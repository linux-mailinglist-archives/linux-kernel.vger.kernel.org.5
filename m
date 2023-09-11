Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02779BCCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356047AbjIKWCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbjIKUlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:41:15 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A721AB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:41:07 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso5792265ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694464866; x=1695069666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSCla0jUviwrmf8Pqw4zb+jNEO40UJiO21YuO1vgt5s=;
        b=LNnxLDnx2nmqeyPKmV/6YmN+oZt2owxw6WhZg93C2hLjhqtBKu+3oSLE6+RZ78yg1n
         reVgEDJLrOKWI3485Yueh31P/+bdTkDhpFN4rZOuEx93Pa12W/OGpfmexIONxkVEMsSM
         Jc5I3dDUDCpBmthrM+AfHESEwmXUOvy2NT9qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694464866; x=1695069666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSCla0jUviwrmf8Pqw4zb+jNEO40UJiO21YuO1vgt5s=;
        b=C0N7CvTCjeA8ZDePmYxMi/Vc0xFI1nEErlPc5p+MVnCoDFwRbMTJ88WykOtVbvbJ/l
         ma6u8VB77qWn/eDG0m+Cj/SgAyrk7J77xUSgjTuZ4qkW+CfgbqR4X1nXXnf9TZvHbfzu
         s9VIoqKCmtDctYTBWkI1/1pcCjIlAgigw41KR3ZanG0kSNhTQfNSv3S2CnRiO+xnbgrT
         FaF4EXfETKg9mW1LAKzmbWn1WYjee4keF4cIKc+EaltbFEu7QmZL2luteo0lwWO/RzIM
         Bjpa6ZL7GIICEqOE1F/7LVjLI4w7xtNGu93jV/a4RKaZQc0/3RgIZP3f04cd2peTXZO1
         SSaQ==
X-Gm-Message-State: AOJu0Yz3eeu7ejB137wTrdrJwMLy5mdHOmxlDv7hTy8eIoszm00C9W6V
        C2z4LH7VrYZTp0DvYPrqFKRzdw==
X-Google-Smtp-Source: AGHT+IGkOF1394Q++7okrf13fN9QEB8sT/MdQm1u/nr9FzBhTdisV5rU4TW35G6X9U8IarECI4Z56A==
X-Received: by 2002:a05:6602:3603:b0:792:8a08:1bf9 with SMTP id bc3-20020a056602360300b007928a081bf9mr13579784iob.0.1694464866671;
        Mon, 11 Sep 2023 13:41:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e14-20020a02a50e000000b0042bae96eba7sm2342369jam.7.2023.09.11.13.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 13:41:06 -0700 (PDT)
Message-ID: <83cdf82f-8f61-2254-917b-2a4d5fa82f5b@linuxfoundation.org>
Date:   Mon, 11 Sep 2023 14:41:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ftrace/selftests: Add softlink to latest log directory
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230908181721.00f7eb71@gandalf.local.home>
 <20230911092105.95425e2d773f79c9b3b4b94f@kernel.org>
 <20230911140759.725af6b4@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230911140759.725af6b4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 12:07, Steven Rostedt wrote:
> On Mon, 11 Sep 2023 09:21:05 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>> On Fri, 8 Sep 2023 18:17:21 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> From: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>
>>> When I'm debugging something with the ftrace selftests and need to look at
>>> the logs, it becomes tedious that I need to do the following:
>>>
>>>   ls -ltr logs
>>>   [ copy the last directory ]
>>>   ls logs/<paste-last-dir>
>>>
>>> to see where the logs are.
>>>
>>> Instead, do the common practice of having a "latest" softlink to the last
>>> run selftest. This way after running the selftest I only need to do:
>>>
>>>   ls logs/latest/
>>>
>>> and it will always give me the directory of the last run selftest logs!
>>>    
>>
>> Nice! I like this and this looks good to me.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Thank you!
>>
> 
> Should this go via Shuah's tree?
> 

Looks like it is a self contained patch.  I will take it.

thanks,
-- Shuah

