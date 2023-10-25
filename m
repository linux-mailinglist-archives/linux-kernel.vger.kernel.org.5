Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00517D7062
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbjJYPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjJYPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:07:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591ED189;
        Wed, 25 Oct 2023 08:07:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1caad0bcc95so39687495ad.0;
        Wed, 25 Oct 2023 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698246449; x=1698851249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JP1FjdQMG6Z5vfQZsofPNw1OQcVaM3P5E6uI/DRXk8k=;
        b=Qn5vlhFVoXbgoqeylx+lYTaMP1mjGMSthZVRY5G+m9D1uRCKU49PoFwSEllWUTs3Kl
         y+XBqIH3BSLZsbWIwbKmn8By2odg4TzRCdZHClv/DdyRjW02JuDbfj4h4sfim49GAKyb
         09d+wGIZroJ5bFa5W5YjDi2OvM46K34trymswgLus28Yi1nX/BZskxcla/F7xdGVzHC+
         06O50hNXwcWwO1mqyDk7kgAXMeRZSSTKaSS9A5AY9j3CVGjHPeutzgzt9oLQ2CX8MPHF
         cZbwKNbxkxuhVXelgEoD98sOJAHnsVOwEzotXCGMRut6ojftv2BRriifebBpKzp7Pbdl
         iGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698246449; x=1698851249;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JP1FjdQMG6Z5vfQZsofPNw1OQcVaM3P5E6uI/DRXk8k=;
        b=aBDpJY8M51KfRPJiH8+MO7WgFXvx6XguvAF//Gd6EI9qjXvevjgs1abTs3GVmmNkuh
         56+VSxAczOLQzRYTaEcbaTZFHdnxmmJgAY0vNBVO5xucApbDlkPe+bqA7LFoJWkUGOSr
         QADvpswTnWFU4FEYVyrF3U4sdFANuc6jIBO/NhTk7E8T91cpGWqsmSGNjX6+TEMatWsN
         Pv0OWEyoKljBVYY1WDjaZ0wCKCFkR55sPN57DFZvrVlFlBGz6lrHItJ+PoJisy+Jlo9m
         3AeYbLsmwgY9+Qemdl4yhgsuuMDv2m+J1F1t7bpR7sQUyZOx3WEsYaQ9g/s88Wi8xFAg
         evnw==
X-Gm-Message-State: AOJu0Yyci4R4adh9gixBQ0b9v95ogDqSMycy/aMN4vZdljL/Z40vxKBi
        s9Ljr7ns42gFtED6L7MEq0UfYmJIdvE=
X-Google-Smtp-Source: AGHT+IFMOIIhptdepjZLOZzYYCzLergAVAmDgWVhVsoemQVUM+VhK/lctlxxQ/HCg7xsgPO3MFsjUQ==
X-Received: by 2002:a17:902:cece:b0:1c6:16d3:1783 with SMTP id d14-20020a170902cece00b001c616d31783mr13902474plg.58.1698246449576;
        Wed, 25 Oct 2023 08:07:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b001bdc9daadc9sm9334783plb.89.2023.10.25.08.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 08:07:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6413ac66-2608-cd76-1b3c-5a185fe6d88d@roeck-us.net>
Date:   Wed, 25 Oct 2023 08:07:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231024083326.219645073@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
In-Reply-To: <20231024083326.219645073@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 01:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:45 +0000.
> Anything received after that time might be too late.
> 

Build reference: v5.10.198-200-ge31b6513c43d
Compiler version: x86_64-linux-gcc (GCC) 11.4.0
Assembler version: GNU assembler (GNU Binutils) 2.40

Building x86_64:defconfig ... passed
Building x86_64:allyesconfig ... failed
--------------
Error log:
Unsupported relocation type: unknown type rel type name (-1940038754)
make[3]: *** [arch/x86/boot/compressed/Makefile:122: arch/x86/boot/compressed/vmlinux.relocs] Error 1
make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
make[3]: *** Waiting for unfinished jobs....
x86_64-linux-objcopy: vmlinux: unsupported relocation type 0x9e
x86_64-linux-objcopy: vmlinux[.text]: relocation count is negative: bad value
make[3]: *** [arch/x86/boot/compressed/Makefile:114: arch/x86/boot/compressed/vmlinux.bin] Error 1
make[2]: *** [arch/x86/boot/Makefile:115: arch/x86/boot/compressed/vmlinux] Error 2
make[1]: *** [arch/x86/Makefile:274: bzImage] Error 2
make: *** [Makefile:192: __sub-make] Error 2

No idea what is causing it, but it is persistent. Something odd between
compiler/binutils/objcopy.

Guess it doesn't matter since the release is out already.

Guenter

