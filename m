Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062F7B687C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjJCMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjJCMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:06:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474FA6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:06:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-694f75deb1aso1351260b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696334794; x=1696939594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwYCNU2JZaLLl9Ps7GVMhkLCnR8JZe+7cPMI6Q7rxvc=;
        b=batUF946epPup3tGYITRABkPduQICqLk5R79i/BYiitHHgTtMaYYCiqVXEWe3yOTHU
         vsk9b7LRuyXH4JM6FtPum82Vx0OqKdSBxsNHOLQk+SOIpp5m8qq8moYWvMl7Bxx5sp9N
         jLl/1CdVW6DbCGWM+t09fwJH48RpZwPT5kHI4Pn9bjirFbsuldJ5zRJdpI+NCBUB8roF
         32MdPUuqwlHQzbbsyS7jXL8nFQV5p0nTGJx6my7jI00D5rUubiZcsfLlOB7uDfGeJaiC
         JhKyr+G3gzmtBuxWidBJUvw+FsNIKEHy4pb0gDIrJydV5s6xXryml7wFsUHoGPuUhYNn
         nSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696334794; x=1696939594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwYCNU2JZaLLl9Ps7GVMhkLCnR8JZe+7cPMI6Q7rxvc=;
        b=Pbs5x7ZLg5CqqtnJLWFMusH/6CVdkiHsHq36Xs7W6D15NAhQlaUrxaMb8THMWFBwhQ
         ejhBQHv7+EBK6RxLtpFZ4QAZWUOmmoUJW8H6Iiu9jam/C0N3vWKatq7ErjkFHmc+FpJG
         aFtU6CtIItFQr+mTvMOYuKLyfps6II+e7zClB4SagRILaXj8xbMZyArGm19YUHhV3M6g
         yK2z1Q/xqfVpHvSoTt2wFOU9HS/+6WZ/KAOhAQdhGhStunKNr6KsQK+qcuIQLsbFik6S
         urhQxeO1sXKm6aS4dZV0/PatgxEQGLr0hRnalcFZxt0zPNrIiralGApa8P1BtBO1oUDd
         y6rA==
X-Gm-Message-State: AOJu0Yx3NdomBaKXrtD+UCqkX2716hkgXrA5P9XtT96P5Gi9QrEB2sFf
        JWgYffGP5v5y8S4esvUfcWJi8g==
X-Google-Smtp-Source: AGHT+IHS1xOSvzdyYLOjvKWMH2lCFxTdX89Sw9iGAFSNDCYZeYz4cntR3XmriIxwyMd6Ini5TkSYcg==
X-Received: by 2002:a05:6a00:1141:b0:693:479f:bd1c with SMTP id b1-20020a056a00114100b00693479fbd1cmr3690291pfm.1.1696334794394;
        Tue, 03 Oct 2023 05:06:34 -0700 (PDT)
Received: from [192.168.1.24] ([223.178.210.23])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78492000000b00692b2a63cccsm1189575pfn.210.2023.10.03.05.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 05:06:33 -0700 (PDT)
Message-ID: <5427bc3d-1e14-781a-53a2-f702774715f4@linaro.org>
Date:   Tue, 3 Oct 2023 17:36:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora>
 <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
 <CAHk-=whosoBSLAWzSGUZ8s=UwAVG9rsQ9OVPvw97S2RRFGfk2A@mail.gmail.com>
Content-Language: en-US
From:   Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <CAHk-=whosoBSLAWzSGUZ8s=UwAVG9rsQ9OVPvw97S2RRFGfk2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 10/2/23 02:18, Linus Torvalds wrote:
> On Sun, 1 Oct 2023 at 07:17, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>>>> Peter Zijlstra (1):
>>>>        x86,static_call: Fix static-call vs return-thunk
>>> Hello, the commit above caused a crash on x86 kernel with
>>> CONFIG_DEBUG_VIRTUAL=y.
>> OK, I looked into this a little bit, and it turns out that the problematic
>> address here is from cleanup_trusted() in
>> security/keys/trusted-keys/trusted_core.c.
>> (and it's builtin due to CONFIG_TRUSTED_KEYS=y)
>>
>> The function is marked as __exit, so it does not fall within the
>> 'core kernel text address range,' which is between _stext and _etext
>> (or between _sinittext and _einittext). and thus __text_poke() thinks that
>> it's vmalloc/module area.
>>
>> I think __text_poke() should be taught that functions marked as __exit
>> also belong to kernel code just like __init.
> I think your patch is fine (well, whitespace-damaged, but conceptually good).
>
> But I also wonder about that
>
>          static_call_cond(trusted_key_exit)();
>
> in cleanup_trusted(). It seems all kinds of pointless to use static
> calls for something that is done *once*. That's not an optimization,
> that's honestly just _stupid_. It costs more to do the rewriting that
> it does to just do the one dynamic indirect call.

That's true, there isn't any real performance benefit here. It is 
something which I mentioned when I was asked to incorporate it here [1]. 
However, on the flip side I think there are security benefits here. We 
wouldn't like any indirect branch speculation attack to leak the trusted 
key material contents here.

[1] 
https://patchwork.kernel.org/project/keyrings/patch/1602065268-26017-2-git-send-email-sumit.garg@linaro.org/#23683269

-Sumit

>
> Side note: the same is true of the init-time call, which does
>
>                  static_call_update(trusted_key_init,
>                                     trusted_key_sources[i].ops->init);
>                  ...
>                  ret = static_call(trusted_key_init)();
>
> which again is a *lot* more expensive than just doing the indirect
> function call.
>
> So while I don't think your patch is wrong, I do think that the cause
> here is plain silly code, and that trusted key code simply should not
> do the crazy thing it does (and that causes silly problems).
>
>                 Linus
>
