Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C697AE573
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjIZGDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjIZGDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:03:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6638DF3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:03:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991c786369cso951793866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695708192; x=1696312992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfs3uOds06wI8qZNBQ/jScxCDSnU/xxk06vJqhJ+EGI=;
        b=qZSw+imohcQvmJ1PXM7fOlv2itVNdLKnqdN9KXSLGwa1yLvq/05wbtBEFhwP5R6dIl
         hnl03nb6srZgUjoi43xP8EBZHybjEPcERNGuwZ8vg6rsG+QeUpqpOKtm7rJnX06PGLu4
         2OovBFBkPVmR+/c7RrLTRmW16YEhzZ/PA6nV6rBwKMW0cqpjd9WD/zT2mr07BSl0iZOZ
         E7t6BSdNema/4Ld3Vf+Dagf3shM0WCRrdglxWPt5eWhkNtKjausLnmvPWvCF3NGv/mHm
         Gw6jcpN6d2st9LNDbgzgiKOIj/9OkXu1Glbvm2W5C51eH532FYiAZdla/t9TsbfXo+Hr
         NaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695708192; x=1696312992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfs3uOds06wI8qZNBQ/jScxCDSnU/xxk06vJqhJ+EGI=;
        b=Mqa4gAJjgo08CU6CQLeZS6cCxP/RVZ7NtPH5RPPq5iWq04SvKRxt03aBh0YFdtCwuh
         cxQ4PbLEjG02j62J9nxg2XBgjPQVauMnV1J4iE+A9UTRKjcKeX3vPAiIVnLiiPSzXF7e
         mQzHzddHzC0ua6Ua5j8NFk4EDrywSI8OVC7yUSzbGNFAo1VFy1PrCGSqPjr9tbXQdR7j
         0bwKcwfQrHJ84fJj08zZOdDksrjJWHdco2d3QcPNq33IoaPoYvep5pHCTFIoyKqjt/Pp
         n6HuiB2X/gfjJPiveP3FEC8pFbQ7OLN0qbYj8XxoEScqJMrNKfOMoB2QaUPlSvkDOiru
         G8CA==
X-Gm-Message-State: AOJu0Yx7aJdkqTcqAp4rVuk4N6ehVNxYNV4/WMYMr2CA0VHvmSo6Nhik
        7U84l762wV600qBIf4Yv3QFlvhkIBUIj2N3J9cLnqw==
X-Google-Smtp-Source: AGHT+IH1LOZVRXrwtuM9ma/WTZ7miGwf1wGdWJgQJ0j+GgMqXtdbzGXn2MaMy8AUj+20ZkCZ3zwM6w==
X-Received: by 2002:a17:907:6d0a:b0:9a1:cb2c:b55c with SMTP id sa10-20020a1709076d0a00b009a1cb2cb55cmr8844670ejc.35.1695708191854;
        Mon, 25 Sep 2023 23:03:11 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i13-20020a170906090d00b0099cbfee34e3sm7306105ejd.196.2023.09.25.23.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 23:03:10 -0700 (PDT)
Message-ID: <fc358b53-0ca7-3600-0d27-a5849811ed2c@linaro.org>
Date:   Tue, 26 Sep 2023 07:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: linux-next: duplicate patches in the nvmem tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230926083446.1c3d9914@canb.auug.org.au>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230926083446.1c3d9914@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen for reporting this.

Its fixed now.


--srini
On 25/09/2023 23:34, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>    0991afbe4b18 ("nvmem: core: Notify when a new layout is registered")
>    b8257f61b4dd ("nvmem: core: Do not open-code existing functions")
>    6c7f48ea2e66 ("nvmem: core: Return NULL when no nvmem layout is found")
>    104af6a5b199 ("nvmem: core: Create all cells before adding the nvmem device")
>    c32f2186acc9 ("nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper")
>    0a9ec38c47c1 ("nvmem: sec-qfprom: Add Qualcomm secure QFPROM support")
>    050cd7f49580 ("dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom")
>    4b71b2a44d7d ("dt-bindings: nvmem: Add compatible for QCM2290")
>    9d53d595f688 ("nvmem: Kconfig: Fix typo "drive" -> "driver"")
>    3e0558db94db ("nvmem: Explicitly include correct DT includes")
>    c8efcf7a86eb ("nvmem: add new NXP QorIQ eFuse driver")
>    0401edffa338 ("dt-bindings: nvmem: Add t1023-sfp efuse support")
>    8fd85ce6cfdf ("dt-bindings: nvmem: qfprom: Add compatible for MSM8226")
>    97edd4c6ba34 ("nvmem: uniphier: Use devm_platform_get_and_ioremap_resource()")
>    431f08ed0ba5 ("nvmem: qfprom: do some cleanup")
>    77803ef86379 ("nvmem: stm32-romem: Use devm_platform_get_and_ioremap_resource()")
>    e75d23cf347d ("nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_resource()")
>    ad065ae27bd1 ("nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_resource()")
>    67f919120705 ("nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resource()
> ")
>    5f41033e4154 ("nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()")
>    6870b4a37343 ("nvmem: sunxi_sid: Convert to devm_platform_ioremap_resource()")
>    31c8217bc34a ("dt-bindings: nvmem: fixed-cell: add compatible for MAC cells")
> 
