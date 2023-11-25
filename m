Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A077F8889
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 06:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjKYFpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 00:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYFpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 00:45:07 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93A4170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 21:45:13 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2f4a5ccebso1637466b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 21:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700891113; x=1701495913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YtcVT0tO/faU6pBapwW4pF/eOnwAU4GwA3kQ7ou57Q=;
        b=b9TCGaXjju1T5l/bw/G0ao5bmLuAGtTCuufBms1tk829AJAsNHhVptN7JqtzMIcVRt
         Tfiy54ej7G739QaaZVNN0omAPCOxpzrITgtDOefZTq4qyiKyxj2z1tESKclSfLr9xL6I
         X0QydVCe1OExnE7FZpW3nrUtr7NBLtZSRp/og59g8BdoSm/qViqL7koxg44N50opXEVM
         kATPsj9bFvkJQBntEeBooe0EFqDI7qs+NZHplhDRKbHl71vvP59he0NJiEs/sTcqJGzI
         qeNdVtwyh1zfQEciyfOR3V6B3nVl9WMdcW1H3bVXW+Yxx2FbHLUmPJYkbyKnMNA0DQ5Q
         DymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700891113; x=1701495913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YtcVT0tO/faU6pBapwW4pF/eOnwAU4GwA3kQ7ou57Q=;
        b=i3DiPVnJM+/FXi+SmiqF1eQQh/ksaWWZI8AiNjJyNfeyGBytndE7QGzbWJGesmjtVP
         oZ1mTWjI3ctcec3+HKifx1k7b+IAJ9KYvdd249Oa4kw8x2Ha4ThLtHRSA7WlcH0wnkoX
         jdfwAKT/Qji0ShdsFyC1rrKhYPojNuhSYDpZbCZZ1ol0xv9dOeqKYEAKRY+FHjZ1h4OB
         Y/tVn942ssvaiY3ws2j3hwFMF0zSiFby2Dy6vSSP6QJW5vzsAxCQSNQ4KTe2639Z6pPO
         T/wICHZeLF6w6Vvw7UNXoE1Y0sfL6zdY+sd3b71/E36FgQyf0VEZotGx2783WbYmmQCd
         fjMw==
X-Gm-Message-State: AOJu0Yz9f2c5wCk2WVDsEu5c2lkQOKO4o9C89+G9Zby263yi/+ep4YER
        kRjiv2+8UfILxnQrMdOvqU0Ivw==
X-Google-Smtp-Source: AGHT+IF8hKgzamcS6ks5XPNrfLtxKvTT7kP1+08AKQ7V7ZC2VsynTR7rqVJLUmxGjFzLY3gdcJkZOw==
X-Received: by 2002:a05:6808:2111:b0:3b8:3826:6dcd with SMTP id r17-20020a056808211100b003b838266dcdmr727299oiw.25.1700891113007;
        Fri, 24 Nov 2023 21:45:13 -0800 (PST)
Received: from [192.168.17.16] ([138.84.62.70])
        by smtp.gmail.com with ESMTPSA id bc10-20020a056808170a00b003b85ad8e75asm163754oib.6.2023.11.24.21.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 21:45:12 -0800 (PST)
Message-ID: <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
Date:   Fri, 24 Nov 2023 23:45:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/297] 5.15.140-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        jack@suse.cz, chrubis@suse.cz
References: <20231124172000.087816911@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.140 release.
> There are 297 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We are noticing a regression with ltp-syscalls' preadv03:

-----8<-----
   preadv03 preadv03
   preadv03_64 preadv03_64
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
   preadv03.c:102: TINFO: Using block size 512
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
----->8-----

This is seen in the following environments:
* dragonboard-845c
* juno-64k_page_size
* qemu-arm64
* qemu-armv7
* qemu-i386
* qemu-x86_64
* x86_64-clang

and on the following RC's:
* v5.10.202-rc1
* v5.15.140-rc1
* v6.1.64-rc1

(Note that the list might not be complete, because some branches failed to execute completely due to build issues reported elsewhere.)

Bisection in linux-5.15.y pointed to:

   commit db85c7fff122c14bc5755e47b51fbfafae660235
   Author: Jan Kara <jack@suse.cz>
   Date:   Fri Oct 13 14:13:50 2023 +0200

       ext4: properly sync file size update after O_SYNC direct IO
       
       commit 91562895f8030cb9a0470b1db49de79346a69f91 upstream.


Reverting that commit made the test pass.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

