Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1083675652E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjGQNhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjGQNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:37:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC818C;
        Mon, 17 Jul 2023 06:37:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668730696a4so2907094b3a.1;
        Mon, 17 Jul 2023 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689601059; x=1692193059;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OI/Xw9Oicm1E8Ha3XK2fs7XQtbSia/OTSUWNe+imDac=;
        b=LbMijjLqkqmTy7jFt/n0fblCOEIiLfEIVCD572knoSJ0e373Ejrqs8JnFW/cFqHT54
         ienXb/kLLFGNIlG7xMXxVXpSHBL8i+443V1lgAW/8I0CSAgn3J72zgO5xpWMpjW6kQbK
         sPBxsboQ1NCi1ZAp+ZHbY16Ae1k2DX7lVW3RmwCFwdzsBVMZHyaTYcV2mFN0SgKbEXrZ
         W5LNN3Ny0G/qng58yZhKGpylh3bxjkhHzNpJ8dj/xEuUeC7hJrIZzMuCicTTDRDaqHJ1
         YRC2mjSkYvoIce2PFkrqXiautPcEhLr2NxQr69XeK22HALpiVmuI0HLEM8gZu8Z/QbEP
         qe6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689601059; x=1692193059;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OI/Xw9Oicm1E8Ha3XK2fs7XQtbSia/OTSUWNe+imDac=;
        b=VuzoMh/JAA2fpt7r0j6da+NBqxBN2IhTbQZth03/7SNcTM4sgU4fZwcgcUKJHRWYBx
         Q+HNxOKQ8LLo7XSL633goR7vZlGz05zcPn3VojUYIhcCDVz1F6qvO+dolmqGj0Xa+7Tj
         Wg78XyX99IhxRcq80jl5EYyer7JB3WsnCRPWXFjOMO+Y0SM4otuN9LV3iho1WhfYWKB2
         vnTWddLciVfEwu2XOQZu5rgKMTq/MPjY+mHf2HTo+gQbTjiRl9JQmBPpe3/h9yY+M2x6
         Q6jg4wigKVtx9GrGLSHiB+zZXS0GyaXpcy2Cyx0szIELuNruj8vab50ztExOid08Sde7
         /bNA==
X-Gm-Message-State: ABy/qLb47nO3+4IhnqUHiHkXtERQgusGZy2wS0LqVV6fh57mMCo0/BHI
        rzNTFU3EUNNbBRqUzAf0v9M=
X-Google-Smtp-Source: APBJJlF2SrL7/3Qh/n/vEQoz7ob2kbKIvFUB8Uep1MfYD53kuHoWJwVwcgrr+ndE16iyNyZhrDJltg==
X-Received: by 2002:a05:6a00:10c6:b0:63b:5c82:e209 with SMTP id d6-20020a056a0010c600b0063b5c82e209mr12258518pfu.10.1689601059435;
        Mon, 17 Jul 2023 06:37:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78396000000b0068285a7f107sm12305636pfm.177.2023.07.17.06.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:37:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6e31d62f-21b0-874b-a2e2-3c74a0b587c0@roeck-us.net>
Date:   Mon, 17 Jul 2023 06:37:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230716194949.099592437@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.4 000/800] 6.4.4-rc1 review
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 12:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 800 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> Anything received after that time might be too late.
> 

As I had already reported:

Building mips:allmodconfig ... failed
--------------
Error log:
arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
ERROR: Input tree has errors, aborting (use -f to force output)
make[3]: [scripts/Makefile.lib:419: arch/mips/boot/dts/ingenic/ci20.dtb] Error 2 (ignored)
arch/mips/boot/dts/ingenic/ci20.dts:242.19-247.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC1: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:248.18-253.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC2: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:254.18-259.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/DCDC3: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:265.17-270.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO5: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:271.18-276.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO6: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:277.20-282.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO7: Reference to non-existent node or label "vcc_33v"
arch/mips/boot/dts/ingenic/ci20.dts:283.20-288.6: ERROR (phandle_references): /i2c@10050000/act8600@5a/regulators/LDO8: Reference to non-existent node or label "vcc_33v"
ERROR: Input tree has errors, aborting (use -f to force output)
make[4]: [scripts/Makefile.lib:419: arch/mips/boot/dts/ingenic/ci20.dtb] Error 2 (ignored)

This is the same error as reported for 6.3.13-rc3, introduced with "MIPS: DTS:
CI20: Add parent supplies to ACT8600 regulators" which uses vcc_33v without
introducing it (it was introduced with commit c9f4b25272843).

Guenter

