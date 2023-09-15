Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F74A7A22FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjIOPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjIOPyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:54:12 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCCE7F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:54:05 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-797ea09af91so12373939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694793245; x=1695398045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0WfQAgxiKpijcp4ZKiRZk25sDoqYFcg0Pdd7jDLWIk=;
        b=KvYnWfBd7if49ytX7wfp/ytJN2hLRe5t952ZuECKCrFBinK5w83KBwnuIo9i3lFULT
         O52OFS7IkmQzR5XSEnVmPqR1v5yG4yjQ7UqnyqLHGS80ty+62mEzAFqP+6f/iYNPVthI
         AB6DCYhKaCkRShEiWYMvQzMd4/OKzDgsAgn0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694793245; x=1695398045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0WfQAgxiKpijcp4ZKiRZk25sDoqYFcg0Pdd7jDLWIk=;
        b=w2fBtGVJ9XizkcPsbab9KvvVgNfLMlw7iYOERYlJBlvOWlk1mf0whrjWFggx9bhv2j
         2eyLawhMYhXF255niUg7c3umo2SASHFAVE6z9Kl/1aTWUhwH/+iSfSoqTq/F5PCuufDB
         hLEjW6BommjZLL2Ubs0L0fvFNdsZ7gbLXFY/zUDLGGMGWJIS8ZNw55B4gpI52WNgnzxa
         Lkl9f+IGtFDUbl5Ajr8KjhQ5TnnYU5gTiQHFCxwKZ5EySlUsh1YUADp3zmZtwVj4RULQ
         HSR5MjxCBbPoF2h7bq7/hXyPbDjBYC4FR/5bDT+bjEvO1abehj0HlzH3JoXQU6cuaqAC
         ZQ/w==
X-Gm-Message-State: AOJu0Yy0PAxha6Uuw3sO0PQQLcvjQn/6JVQ+QnZd1lkWsPi+v8TBxCQk
        4yTiP6AGoqjJqQnQXKti3gvRiCclyW8JP/aYL1o=
X-Google-Smtp-Source: AGHT+IEok3orKD7XybvCpzCs5Ir+7PaGFOZdWFIkIxBiRhcKk8VdYE9jmx/eRCeMf/+iZLLuhcO+Aw==
X-Received: by 2002:a6b:c94d:0:b0:795:172f:977a with SMTP id z74-20020a6bc94d000000b00795172f977amr2193409iof.1.1694793244953;
        Fri, 15 Sep 2023 08:54:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u27-20020a02cbdb000000b004399962e275sm1098080jaq.171.2023.09.15.08.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:54:04 -0700 (PDT)
Message-ID: <b2d8d216-7d02-707e-937a-b42863f9e76d@linuxfoundation.org>
Date:   Fri, 15 Sep 2023 09:54:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] selftests/user_events: Fix failures when user_events
 is not installed
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Mark Brown <broonie@kernel.org>, shuah@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, naresh.kamboju@linaro.org,
        anders.roxell@linaro.org, arnd@arndb.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230908201916.562-1-beaub@linux.microsoft.com>
 <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
 <20230908212712.211a4964@gandalf.local.home>
 <20230912171234.GA3704-beaub@linux.microsoft.com>
 <20230912134644.3b7959b9@gandalf.local.home>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230912134644.3b7959b9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 11:46, Steven Rostedt wrote:
> On Tue, 12 Sep 2023 10:12:34 -0700
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> 
>>> I guess I was wrong and some people do care ;-)
>>>
>>> -- Steve
>>
>> It looks like this change got applied [1] to the fixes branch of
>> linux-kselftest. I can either send a V3 with this addressed or build a
>> patch based upon the fixes branch on top of this one to address it.
>>
>> Which way do you all prefer?

Please send me patch on top of this one on linux-kselftest fixes.

thanks,
-- Shuah
