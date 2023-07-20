Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B19975B1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGTOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjGTOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:51:24 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7826BB;
        Thu, 20 Jul 2023 07:51:21 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b867acbf6dso1211217a34.0;
        Thu, 20 Jul 2023 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689864680; x=1690469480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UhWP+ZeZ3WNU0D0D0pZXS3JRxCCkvCqQIqNPCWlWf2w=;
        b=H1m2U0JQGCymlTl2yk/Iv8QpPFjyeOzAmgIKNKBNGdcqPGqZg1ncSc8yMkB1mTlWOM
         9MW7wXECdI3wFeIlTxsO9S1M4TKGls6iOImTKuq0qG7SG42sHxWjag9BHYg/My2EtlZF
         zguCQPrZQxPzU7DpTv2Zs+okeBB34iwpznElaCophc5BNunmlDXTAti60vMTkBWg47ob
         6DcAbxUrnsUPZ0Lv2QemHtlVsS7Q3EelBzdFUCvfqJHvpvtM8p/rfLo2oi/we5+S78Yj
         XjFR7BcHdrJeZKBlo2ILlFM4m32aBDgtCmITgytJfUtlwN2cb7pwfJzQ3Ctosl+/q8s2
         ycZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864680; x=1690469480;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhWP+ZeZ3WNU0D0D0pZXS3JRxCCkvCqQIqNPCWlWf2w=;
        b=UKGRzbY69FaCvE4zabsgeIIJOg0Gs2gdg/Nv+9sxzqxUlhBgOxa3KH2ncKfSsx4kFM
         zmZI7NJ+V8sr5us2cMrJrampjem2TMMuDVJ6m7nkTxv9XveCCuR+w0WN4GkHj55GtbaH
         uN8uz2FjkvzegUnLETD823RP0gcBESkoFM1wE2u9pBvQRDT0Q8/dOd28NR/AlLZa2glM
         bnVskgDc/UUv7KO5YabSq7zvuQk6wlfTqLg9yuqtAP2+EtWDEbsY+om6GMgh7U7nUObw
         QEFdS73yayjH5xN0QljigiH56+I6IJkjPPtslnIFMgvN3og3tO1+9U0LXUCfjfmZ5Gdm
         Rqig==
X-Gm-Message-State: ABy/qLaBso0DoeEfvqJG3/aqTiWwnDDRhCdGGlu3f6KWgHxZ6Qe5ukPS
        i5tN7dlXjxWb9fkX/TVq1IQ=
X-Google-Smtp-Source: APBJJlG+WfZqYu4hKfk+bE6i1jP3fyq4+mW1KjuU3mF4nEL4pfO3rBqApmJMMMO5xMKb4+5t7mR/9Q==
X-Received: by 2002:a9d:68da:0:b0:6b7:564d:f368 with SMTP id i26-20020a9d68da000000b006b7564df368mr2342631oto.5.1689864680517;
        Thu, 20 Jul 2023 07:51:20 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id s4-20020a056830148400b006b92509e76esm499039otq.32.2023.07.20.07.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 07:51:20 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <ff0cd6d9-b031-d1bd-a9ba-6c70f1f5db47@lwfinger.net>
Date:   Thu, 20 Jul 2023 09:51:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Crash in VirtualBox virtual machines running kernel 6.5
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
 <202307190823.086EFD42D9@keescook> <202307190835.752D710D@keescook>
 <d29c7e51-deff-c82f-81d4-8322b0c28d22@lwfinger.net>
 <DC28E9B9-0F7A-4CA5-9FA9-6A4AB5DCD9D5@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <DC28E9B9-0F7A-4CA5-9FA9-6A4AB5DCD9D5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 17:37, Kees Cook wrote:
> On July 19, 2023 2:24:52 PM PDT, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>> On 7/19/23 10:36, Kees Cook wrote:
>>> Okay, please try:
>>>
>>> diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
>>> index aca829062c12..902fe3224453 100644
>>> --- a/fs/vboxsf/shfl_hostintf.h
>>> +++ b/fs/vboxsf/shfl_hostintf.h
>>> @@ -68,12 +68,11 @@ struct shfl_string {
>>>      	/** UTF-8 or UTF-16 string. Nul terminated. */
>>>    	union {
>>> -		u8 utf8[2];
>>> -		u16 utf16[1];
>>> -		u16 ucs2[1]; /* misnomer, use utf16. */
>>> +		DECLARE_FLEX_ARRAY(u8, utf8);
>>> +		DECLARE_FLEX_ARRAY(u16, utf16);
>>>    	} string;
>>>    };
>>> -VMMDEV_ASSERT_SIZE(shfl_string, 6);
>>> +VMMDEV_ASSERT_SIZE(shfl_string, 4);
>>>      /* The size of shfl_string w/o the string part. */
>>>    #define SHFLSTRING_HEADER_SIZE  4
>>>
>>>
>>> The size assert doesn't seem to be used anywhere else, but I can do a
>>> more careful binary analysis later today...''
>>
>> Kees,
>>
>> The testing was harder than I expected. My standard kernel would not load the system disk on the VM, thus I had to build one using my distros configuration. It is really painful to wait for all those drivers to build, but I figured that might be faster than trying to find the incorrect parameter.
>>
>> I can finally report that vboxsf no longer generated a BUG. It is getting farther, but I am not done yet. It now generates a line that says "Unknown parameter tag" and then hangs. I have not tracked that down yet.
>>
>> I was not aware of the DECLARE_FLEX_ARRAY() macro. I had considered removing the union and creating a simple string[] declaration, but I do not mess with file systems, and decided to let the experts handle it.
>>
>> I will let you know what I find about that unknown parameter. It probably is coming from VirtualBox.
> 
> It's possible the size really needs to stay 6 bytes. In that case, try adding a "u8 legacy_padding[2]" to the union and restore the VMMDEV_ASSERT_SIZE?

Kees,

You win the prize. Adding the 2 bytes of padding restored operations.

Thanks,

Larry

