Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E08790000
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbjIAPfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241960AbjIAPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:35:11 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22ED10EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:35:07 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230901153503epoutp01f947bdb773e040e094dc1d3a3a06374e~A0FB7Avdk1477714777epoutp01w
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:35:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230901153503epoutp01f947bdb773e040e094dc1d3a3a06374e~A0FB7Avdk1477714777epoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693582504;
        bh=aOlYQ5cBte/JzMksONmfKqcJOHs9+CZOZVn/iaN6WH4=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=nWbLvm2Z44V6o7tMidoCp2zpPx4RUMcSVCRPvEiELd+1QpjxrEHEiTrCBfnAQQ1z3
         ZBmfA6FjZf/d4XxaphVHS5uiMWJUnHr60e8yrKKzFtSDNjvPcE0Gj01gtL6LOjXdWi
         JZbIneLUQAvBx1kVLkK70cphI/Xdg1WYYE8h5SZA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230901153503epcas5p17aada13e7e175c5d6358b274d0e96509~A0FBdLNAd2796027960epcas5p12;
        Fri,  1 Sep 2023 15:35:03 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RchtG2gYYz4x9Pr; Fri,  1 Sep
        2023 15:35:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.E6.09949.6A402F46; Sat,  2 Sep 2023 00:35:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230901153501epcas5p471785b05f3bdb4acdb27ff402cf3f331~A0E-ap-3V2822928229epcas5p45;
        Fri,  1 Sep 2023 15:35:01 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230901153501epsmtrp24014501e2a47447fb5e3085742fe4549~A0E-X_SLI2406224062epsmtrp2S;
        Fri,  1 Sep 2023 15:35:01 +0000 (GMT)
X-AuditID: b6c32a49-bd9f8700000026dd-4d-64f204a676dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.A2.08788.5A402F46; Sat,  2 Sep 2023 00:35:01 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230901153459epsmtip214e46d6101a491878b35aeda8143695d~A0E_Ds1bQ1862818628epsmtip2U;
        Fri,  1 Sep 2023 15:34:59 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arm@kernel.org>, <soc@kernel.org>,
        "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Olof Johansson'" <olof@lixom.net>
In-Reply-To: <20230901115732.45854-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] arm64: defconfig: enable syscon-poweroff driver
Date:   Fri, 1 Sep 2023 21:04:58 +0530
Message-ID: <000401d9dce9$ded545f0$9c7fd1d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJpw2blY2KnWiSxJ1DezFvi/M20/AGXv2sKrtmOvbA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmhu4ylk8pBtemCFsc+7KFzeLvpGPs
        FvOPnGO12Pt6K7vFpsfXWC0u75rDZjHj/D4mi1PXP7NZPL7+h82B0+P3r0mMHptWdbJ53Lm2
        h81j85J6jysnmlg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LI
        S8xNtVVy8QnQdcvMATpKSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhb
        XJqXrpeXWmJlaGBgZApUmJCdMedXF1vBE66KR4v2MzUwruXsYuTkkBAwkWhvvMDWxcjFISSw
        m1Gid/YVFgjnE6PEk7f7mSGcb4wSM669YoVpefBpBxOILSSwl1Hi/fREiKKXjBKfbrYygyTY
        BHQldixuA5srIrCbSeLzxw3sIAlOAReJXduXgBUJA9lfJ3wFm8oioCKxuOkYC4jNK2ApcXHR
        SSYIW1Di5MwnYHFmAXmJ7W/nMENcoSDx8+kysF4RASuJ3bduMkLUiEu8PHqEHaJmIYfEw99c
        ELaLxO6Du6B6hSVeHd8CVSMl8fndXqBDOYBsD4lFf6QgwhkSb5evZ4Sw7SUOXJnDAlLCLKAp
        sX6XPsQmPone30+YIDp5JTrahCCqVSWa311lgbClJSZ2d0ODzUNiU/M0aEhPZ5RY1H+CZQKj
        wiwkT85C8uQsJM/MQti8gJFlFaNkakFxbnpqsWmBYV5qOTy+k/NzNzGCk6yW5w7Guw8+6B1i
        ZOJgPMQowcGsJMIba/YuRYg3JbGyKrUoP76oNCe1+BCjKTDkJzJLiSbnA9N8Xkm8oYmlgYmZ
        mZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTJV3lq6emy1z2l5jwZFOHddtIpPZ
        zc4uX3hi5srpoTd/spyNScrneR4WI/NY+srmLZPCDqpHr98uNzE69uDJL+afYhf++ZA0M9lr
        afcqv8Yinu/t7zZ93lgWYdFdoOSiMKNerOWo/0P1OinhdXVrb7AvFBBs3e8S7XXZ99+Hy/kr
        li+5Ytbgvz5/zjq+rixdr+7T6QrxzNmBO25+tecWbJX+5lny9Mnvwl/fd9sLRMWobd/scGft
        JP4b35WcY7ynyfPURrmv4mowY879tv60/3LV69dY14rvvnrfTGqFmY7zmgezeNb2yy2bbjBP
        aOe2s5836jiWqtelps0zeXiV0zVo9rMHW6xSn1s0VhZZ2SuxFGckGmoxFxUnAgBGyLLsOwQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXncpy6cUg+vP2C2OfdnCZvF30jF2
        i/lHzrFa7H29ld1i0+NrrBaXd81hs5hxfh+Txanrn9ksHl//w+bA6fH71yRGj02rOtk87lzb
        w+axeUm9x5UTTawenzfJBbBFcdmkpOZklqUW6dslcGXM+dXFVvCEq+LRov1MDYxrObsYOTkk
        BEwkHnzawQRiCwnsZpRY89gNIi4tcX3jBHYIW1hi5b/nQDYXUM1zRolZf26ygCTYBHQldixu
        YwNJiAgcZpLobbjOClE1lVFi/dftrCBVnAIuEru2L2EGsYWB7K8TvoLFWQRUJBY3HQObxCtg
        KXFx0UkmCFtQ4uTMJ0BxDg5mAT2Jto2MIGFmAXmJ7W/nMENcpCDx8+kysDEiAlYSu2/dhKoR
        l3h59Aj7BEahWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/d
        xAiOKC2tHYx7Vn3QO8TIxMF4iFGCg1lJhDfW7F2KEG9KYmVValF+fFFpTmrxIUZpDhYlcd5v
        r3tThATSE0tSs1NTC1KLYLJMHJxSDUzq3wPXLzzzc6LDi6ka34uZmK59WezeHtTy++60U6ev
        F3/SXn9ad/WUbdkbXyztEXu0db8Rv/0EFSEpzT9f+UMXFc/mb33U1bfmX9mJ+ZJNaXESn2Sd
        shJN4y5ocDEruK9RlrGUfms0/4bXl2lf22t+beh92vw80CpsxZw/MqmN5t8iah+Zb78aOTeU
        5YCO55577bfUD2QHVS3Mmxr57ET0XY+NC7pWnGq4JFmm8CvIg9t5tulN1uOl1uc2vGScxv3T
        io0lcsHe7l85152nNCXmcxzmDHt0kV8knOWqS+POe3Ii2lnZW3Z+smR7Zy/c+zSoKibkRa1C
        jszl7TKvE5a/z7qQqbC2gl/6yRVd3pdKLMUZiYZazEXFiQBKg3yKFwMAAA==
X-CMS-MailID: 20230901153501epcas5p471785b05f3bdb4acdb27ff402cf3f331
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230901115741epcas5p185b55c93ec71163e618a5a70b141800c
References: <CGME20230901115741epcas5p185b55c93ec71163e618a5a70b141800c@epcas5p1.samsung.com>
        <20230901115732.45854-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, September 1, 2023 5:28 PM
> To: Alim Akhtar <alim.akhtar@samsung.com>; devicetree@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org;
> linux-kernel@vger.kernel.org; arm@kernel.org; soc@kernel.org; Arnd
> Bergmann <arnd@arndb.de>; Olof Johansson <olof@lixom.net>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH] arm64: defconfig: enable syscon-poweroff driver
> 
> Enable the generic syscon-poweroff driver used on all Exynos ARM64 SoCs
> (e.g. Exynos5433) and few APM SoCs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5315789f4868..ec59174b14db 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -636,6 +636,7 @@ CONFIG_POWER_RESET_MSM=y
> CONFIG_POWER_RESET_QCOM_PON=m  CONFIG_POWER_RESET_XGENE=y
> CONFIG_POWER_RESET_SYSCON=y
> +CONFIG_POWER_RESET_SYSCON_POWEROFF=y
>  CONFIG_SYSCON_REBOOT_MODE=y
>  CONFIG_NVMEM_REBOOT_MODE=m
>  CONFIG_BATTERY_SBS=m
> --
> 2.34.1


