Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D37D9C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbjJ0OzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbjJ0Oy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:54:59 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A753C4;
        Fri, 27 Oct 2023 07:54:57 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so1461733fac.0;
        Fri, 27 Oct 2023 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698418497; x=1699023297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FRGus6ktymyimDivswpJ27Ui0IhpUZQSXAOmlCFn8oc=;
        b=J7NdXdqQVTor8CL+TVudIV2/GvGoZVmjR27T3zO606ncNlNqFSiOWdKWUKgSrZwIDy
         3mc7B1mkqOjLJyMxccg2pZdAkZ9/xxzGgpbh6XYIpZUFPRQQFFZJy6GNU7ZtAx5hzXEf
         o4UUwtK1tDlkETq9G040GTmvhwZXYqyk2jPrElo/mhyPFgDCbZhLwM9LzZRdsEYgam/B
         6znzyT5s/8ky8H58vqh96zuKBzYq0CH6PS/FyWUz98WYfszz2t1FxMUpkKHxkhK2dTh/
         M3ZRcKatiUTP/pTLAWTsap7bVx150ccgRtaHyAtfL3e4w9yYkKkgt6+o/kT3OEsn9hPD
         yB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418497; x=1699023297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRGus6ktymyimDivswpJ27Ui0IhpUZQSXAOmlCFn8oc=;
        b=RO8AMx2w/MFgBXOhewVl6s2ERZP0AfWLQljQrlK5rjNUzOB4r45M2SEOybn/x1RPLX
         6hqwKKrTj7J4UWJHKmY78IRoZfIzHhKFVNd3g9yDbcHWRAk9KDawho87sykz+Q33Uwvk
         MFMOhZFvjicFOKG63G8Ky0F1j27PZ8yj4FlKKff+qDiaH0zbcqCz4rNRjVKIvkj/dl/0
         8aTG7fcnNbg+sxlGpxbgFjQXhvRBRfoVZGn43MjdXoLhW6HMbxx8JhwtAJpFEdjdARn1
         fehBG3kn0lp+SGbKn1eoZT9rHqFOUtFLancqEp+BUTy8tVtcoccXJ4WMmaZvc+IR8s6N
         SRPg==
X-Gm-Message-State: AOJu0YxVmvNkOR8DgBOtotF9IBHbo40mNkQGTWjlOA4VE1H/U/xngTHl
        NjpBe493jFvOSnWbeum1tzY=
X-Google-Smtp-Source: AGHT+IHSGc3YoPxDtEzMBIIDVpjwJ36pSYYOeGGCT294/VUaa1hkpwh4XVkxyOqA2FN25iDzWFlFUg==
X-Received: by 2002:a05:6871:7582:b0:1ea:15e6:9420 with SMTP id nz2-20020a056871758200b001ea15e69420mr3162839oac.52.1698418496787;
        Fri, 27 Oct 2023 07:54:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i184-20020a25d1c1000000b00d677aec54ffsm706978ybg.60.2023.10.27.07.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 07:54:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <43b45922-118c-3f77-80f2-960fa398cf1f@roeck-us.net>
Date:   Fri, 27 Oct 2023 07:54:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231024083326.219645073@linuxfoundation.org>
 <6413ac66-2608-cd76-1b3c-5a185fe6d88d@roeck-us.net>
 <2023102728-gigantic-favorable-71a6@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2023102728-gigantic-favorable-71a6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 05:25, Greg Kroah-Hartman wrote:
> On Wed, Oct 25, 2023 at 08:07:26AM -0700, Guenter Roeck wrote:
>> On 10/24/23 01:36, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.10.199 release.
>>> There are 199 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 26 Oct 2023 08:32:45 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> Build reference: v5.10.198-200-ge31b6513c43d
>> Compiler version: x86_64-linux-gcc (GCC) 11.4.0
>> Assembler version: GNU assembler (GNU Binutils) 2.40
>>
>> Building x86_64:defconfig ... passed
>> Building x86_64:allyesconfig ... failed
>> --------------
>> Error log:
>> Unsupported relocation type: unknown type rel type name (-1940038754)
>> make[3]: *** [arch/x86/boot/compressed/Makefile:122: arch/x86/boot/compressed/vmlinux.relocs] Error 1
>> make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
>> make[3]: *** Waiting for unfinished jobs....
>> x86_64-linux-objcopy: vmlinux: unsupported relocation type 0x9e
>> x86_64-linux-objcopy: vmlinux[.text]: relocation count is negative: bad value
>> make[3]: *** [arch/x86/boot/compressed/Makefile:114: arch/x86/boot/compressed/vmlinux.bin] Error 1
>> make[2]: *** [arch/x86/boot/Makefile:115: arch/x86/boot/compressed/vmlinux] Error 2
>> make[1]: *** [arch/x86/Makefile:274: bzImage] Error 2
>> make: *** [Makefile:192: __sub-make] Error 2
>>
>> No idea what is causing it, but it is persistent. Something odd between
>> compiler/binutils/objcopy.
>>
>> Guess it doesn't matter since the release is out already.
> 
> If the commit that causes this can be figured out, we can revert it.
> 

The final release built fine. I see this happen once in a while but
was never able to figure out what causes it to happen. So far it was
always persistent on a given source but disappeared as soon as something
changed in the code (making it all but impossible to bisect).
Looks like that happened again.

Guenter

