Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7DF7BA17A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjJEOpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbjJEOk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:40:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F329B0D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:14:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-694f3444f94so835674b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696515275; x=1697120075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRX3/Gt3srv/e7AHO8IUFPoIUo5JbeHrDyopAPxYQfg=;
        b=K4/NCRdV6J2SWmBRCQPI7DKa/29gEd6eShJPKAsjQ+YsV/8DaENx46yGIOzfGd57Rl
         RNcRNHqKGI4A6JdSJBLkWc5OfLbCxTlvpie7KEM4/ql05gay7MOENtM+Nk9/DAlQLJI8
         Co0uLmXh8cZFIk6XzHu/m6FfYj3xCtnQrMi9tt5eWPmxvXFvGUhS7x1udvWTVa3vDmUo
         cVpfmM2sn1iChXT53JYolIkpkAWsKKULgny/gh/OaPE76o1hTRx8nwwg7gth/3aMjAdz
         +qN836zEzJSotpl/2UiQjYuIUDKJZI6AFYkhyfJ+d6lFHOFeSVQ3yiFzdYxAQTfzvljU
         xVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696515275; x=1697120075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRX3/Gt3srv/e7AHO8IUFPoIUo5JbeHrDyopAPxYQfg=;
        b=kiJFpxINn5t9aZ+5v723IRgOu5/+k3MzQDCf9LtugDytnhGtH/J4ymzfHzuYDE6e2B
         hyqlLHfgWDFB99rJHYpKR+VXnbQOZmHR53lavanp6EAW1aX7l9LryCfLVD6J8hnnQcfP
         N6csQPamGBm0uCNKB9KxCepU7lTFeSzO9lI4jO+h3r1xBJCxDSiqQe5Xx1lbjm1u88+x
         OgeqSU0ZK6c6MskvYtbpm7zRgsq9i0O+6FRF6BRzzMnCsearmrYsFF3JU/S6fgoC+7/v
         1WptwXDovjR2wlFUqhGaMondRBjw1iLSu+CRM5uzvPzrIgBk993y8JCAWkL1jW4kj6bk
         lWQw==
X-Gm-Message-State: AOJu0Ywx1PQvwZwU30uNSbSj3YhbXHb851hiMRHwlNY3Oy/KrK73ItSZ
        rFb7SNlTotDorlUPpmO8rd0=
X-Google-Smtp-Source: AGHT+IEeRx+XgfA3+fP3kfww/bCY0zMNHEVM8tRFijHwPIggIPn9wkl6mwbyfwRVRyHDGBW6QDgYwg==
X-Received: by 2002:a05:6a20:1a9d:b0:158:17e6:7a6 with SMTP id ci29-20020a056a201a9d00b0015817e607a6mr4517939pzb.42.1696515275091;
        Thu, 05 Oct 2023 07:14:35 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b0064f76992905sm1392751pfn.202.2023.10.05.07.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 07:14:34 -0700 (PDT)
Message-ID: <20cb9f71-cb69-4e8a-b2c5-566292c802f2@gmail.com>
Date:   Thu, 5 Oct 2023 21:14:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: kmalloc memory leak over time.
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, freeze0985@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <4f01f302-9d59-4146-b7ff-0478c4bd94b1@gmail.com>
 <8343dcf3-96e9-4601-aaac-e0a80686586b@leemhuis.info>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <8343dcf3-96e9-4601-aaac-e0a80686586b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 19:55, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 28.09.23 10:40, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> @mm developers: feel free to ignore this, the user has Nvidia's driver
> loaded (see bugzilla; I'll ask to reproduce without it).
> 

#regzbot invalid: reinstalling nvidia driver solves the regression

-- 
An old man doll... just what I always wanted! - Clara

