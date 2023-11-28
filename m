Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E967FC8C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbjK1V2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346715AbjK1V1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:27:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7327A84;
        Tue, 28 Nov 2023 13:11:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-333130bcae1so118129f8f.1;
        Tue, 28 Nov 2023 13:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701205894; x=1701810694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wYF83HPUNyR5nAyVVBDGsxZcqWFjbNBkZTS8J1OIoA=;
        b=Ik+ELkSmqY1QNOlyzBOyuXGdrthwWOxAoUqrNZDwFb5c2gdjvtvEUQqOlgea33cr0/
         cFqv4CRYDITps6kUtbHu7Xfwtdo72D+2FGGvxZqRR04UL6vPAnhjkyBBOi6N66OxRytm
         20qxbZNUUbp+5WCrtdY5XaaawoZpDKvdttVZsMBuvyKJd5UXACrvsTh7vsmexfl80nYp
         LXYfDoh4GX0nZ2tSrJhoLw9SYcOrLOOZ1liTIVhDB21jAW7ei8/qnelJnGmGxgr9JG/j
         +zt13wxg8Na0WbsuhcF8Sq0ONXjvbKrgra4VIMPNJD9tM/gZyMq7ByrLjV2IfvldkW8A
         Uing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205894; x=1701810694;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wYF83HPUNyR5nAyVVBDGsxZcqWFjbNBkZTS8J1OIoA=;
        b=mog0mUAM9B4+tKKSuf0JVKRhniGHDMaZTbzwq2aXiGaQmTu+PwSuNYW/4WDi5z6+zP
         X2NYdG4NceGg9UiJwg4NJNeweVEHSyh/uxrAo6+MZI0bIlLH9Q2LSdQnz+d5qRNXh8KR
         TlJSsD2U44jdOhI4Gi3CrMBpKEpCY3Uf1vL5FYHhBTQFCbLQv0pUIcYxVH7CuoHGLWQZ
         2Vd0EtXxtPvygzCEuZANBI459QYRmn1+QN9kNerutI2vn3sfwhMLlVi3pRBvOFf+qHC8
         R59rbrcCaRBfoE95NZjbqJaurMPdlaQainev0gVGTm71T/pWwNqI5KPY070iqJvNVWkw
         /Tfg==
X-Gm-Message-State: AOJu0YxRxqp52UqbkPtFWdUSIm/0BvdtQk9fIYWPbv4ROovhfT1lf96k
        MYpIq4sY0PgGdqioCDlAXpg=
X-Google-Smtp-Source: AGHT+IF2IDD5UdB84u5IhsSvfErEf7DdYKLkumkJB5LrhCaWccvKA5jFjn/vu4/BHERnBMhxHENNFw==
X-Received: by 2002:a5d:698d:0:b0:333:7ad:58fc with SMTP id g13-20020a5d698d000000b0033307ad58fcmr3625090wru.3.1701205894105;
        Tue, 28 Nov 2023 13:11:34 -0800 (PST)
Received: from ?IPV6:2a02:2788:416:318:a650:c5d8:5f59:d6? ([2a02:2788:416:318:a650:c5d8:5f59:d6])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b0040b3867a297sm17043001wmn.36.2023.11.28.13.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 13:11:33 -0800 (PST)
Message-ID: <0d1087e9-a8f2-48ee-bc8d-bc2a5518571a@gmail.com>
Date:   Tue, 28 Nov 2023 22:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.1.64
Content-Language: fr-FR
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
References: <2023112826-glitter-onion-8533@gregkh>
 <7f07bb2d-bb00-4774-8cc0-d66b7210380c@gmail.com>
 <2023112843-strep-goliath-875c@gregkh>
From:   =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <2023112843-strep-goliath-875c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 28/11/23 à 20:35, Greg Kroah-Hartman a écrit :
> On Tue, Nov 28, 2023 at 08:22:22PM +0100, François Valenduc wrote:
>> Build fails on my baremetal server on scaleway:
>>
>> In file included from arch/x86/kvm/vmx/vmx.c:54:
>> arch/x86/kvm/vmx/evmcs.h:215:20: note: previous definition of
>> ‘evmptr_is_valid’ with type ‘bool(u64)’ {aka ‘_Bool(long long unsigned
>> int)’}
>>    215 | static inline bool evmptr_is_valid(u64 evmptr)
>>        |                    ^~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:55:
>> arch/x86/kvm/vmx/hyperv.h:184:6: error: redeclaration of ‘enum
>> nested_evmptrld_status’
>>    184 | enum nested_evmptrld_status {
>>        |      ^~~~~~~~~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:54:
>> arch/x86/kvm/vmx/evmcs.h:220:6: note: originally defined here
>>    220 | enum nested_evmptrld_status {
>>        |      ^~~~~~~~~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:55:
>> arch/x86/kvm/vmx/hyperv.h:185:9: error: redeclaration of enumerator
>> ‘EVMPTRLD_DISABLED’
>>    185 |         EVMPTRLD_DISABLED,
>>        |         ^~~~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:54:
>> arch/x86/kvm/vmx/evmcs.h:221:9: note: previous definition of
>> ‘EVMPTRLD_DISABLED’ with type ‘enum nested_evmptrld_status’
>>    221 |         EVMPTRLD_DISABLED,
>>        |         ^~~~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:55:
>> arch/x86/kvm/vmx/hyperv.h:186:9: error: redeclaration of enumerator
>> ‘EVMPTRLD_SUCCEEDED’
>>    186 |         EVMPTRLD_SUCCEEDED,
>>        |         ^~~~~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:54:
>> arch/x86/kvm/vmx/evmcs.h:222:9: note: previous definition of
>> ‘EVMPTRLD_SUCCEEDED’ with type ‘enum nested_evmptrld_status’
>>    222 |         EVMPTRLD_SUCCEEDED,
>>        |         ^~~~~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:55:
>> arch/x86/kvm/vmx/hyperv.h:187:9: error: redeclaration of enumerator
>> ‘EVMPTRLD_VMFAIL’
>>    187 |         EVMPTRLD_VMFAIL,
>>        |         ^~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:54:
>> arch/x86/kvm/vmx/evmcs.h:223:9: note: previous definition of
>> ‘EVMPTRLD_VMFAIL’ with type ‘enum nested_evmptrld_status’
>>    223 |         EVMPTRLD_VMFAIL,
>>        |         ^~~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:55:
>> arch/x86/kvm/vmx/hyperv.h:188:9: error: redeclaration of enumerator
>> ‘EVMPTRLD_ERROR’
>>    188 |         EVMPTRLD_ERROR,
>>        |         ^~~~~~~~~~~~~~
>> In file included from arch/x86/kvm/vmx/vmx.c:54:
>> arch/x86/kvm/vmx/evmcs.h:224:9: note: previous definition of
>> ‘EVMPTRLD_ERROR’ with type ‘enum nested_evmptrld_status’
>>    224 |         EVMPTRLD_ERROR,
>>        |         ^~~~~~~~~~~~~~
>> make[3]: *** [scripts/Makefile.build:250: arch/x86/kvm/vmx/vmx.o] Error 1
>> make[2]: *** [scripts/Makefile.build:500: arch/x86/kvm] Error 2
>> make[1]: *** [scripts/Makefile.build:500: arch/x86] Error 2
>>
>> The configuration file is attached. Kernel 6.1.62 compiled fine.
>> Does somebody have an idea about this ?
> I just tried your .config file here and it builds just fine for 6.1.64,
> what version of gcc are you using that causes failures?  I tried gcc-12
> successfully.
>
> thanks,
>
> greg k-h

Bisection gave very strange results until I found the tree was 
corrupted. I recreated it correctly and it works fine.
Sorry for the noise.

Best regards.

François Valenduc

