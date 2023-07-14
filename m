Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8E753811
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjGNK1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjGNK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:27:26 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8C23589
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:27:05 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230714102703epoutp040279ce7eb53a2d380abb4cbe2d52f8a9~xtRHV_4Xr0097300973epoutp04U
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:27:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230714102703epoutp040279ce7eb53a2d380abb4cbe2d52f8a9~xtRHV_4Xr0097300973epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689330423;
        bh=PfTKpzeAicjsBpBI4oNeV4WVzYiV1GmFuBK5HnVNuh4=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=dZJgOLT4zS/ygHd27PbnaHFfAVK/gru3T+by4cQ/GqKdICW0aRXpRPEk2FA5hq0Zy
         FfDLCoSo+jo6vlW0mVhTtNz/RsaRTwpUxAX/gcyvXAM6KOb9pTSFXWxJHXHSRYs+AN
         9FwFcwpTtvQFXyNaIbw35qiLO0dU9h3ISveMnVHQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230714102702epcas5p41c5fd6263b005da4d9df1f15f20f1396~xtRG4AmOd2106621066epcas5p4d;
        Fri, 14 Jul 2023 10:27:02 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4R2SMS1g6nz4x9Q1; Fri, 14 Jul
        2023 10:27:00 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.83.55522.4F221B46; Fri, 14 Jul 2023 19:27:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230714102659epcas5p3fa1be02a8a0eed9a4b61a01ee1066b21~xtREBRHPo1687116871epcas5p3j;
        Fri, 14 Jul 2023 10:26:59 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230714102659epsmtrp2f3fdaafddb754b40eb649b321bb542e3~xtREAiIZr1016210162epsmtrp25;
        Fri, 14 Jul 2023 10:26:59 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-c2-64b122f401b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.A5.14748.3F221B46; Fri, 14 Jul 2023 19:26:59 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230714102658epsmtip1cf36312f4a4b5e2cde0c6ab43702e155~xtRCjBrBx0311603116epsmtip1B;
        Fri, 14 Jul 2023 10:26:58 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20230713152926.82884-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/2] ARM: dts: samsung: s3c6410-mini6410: correct
 ethernet reg addresses (split)
Date:   Fri, 14 Jul 2023 15:56:56 +0530
Message-ID: <020501d9b63d$b8e29e60$2aa7db20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIFx3ikTXDZlVI7qFxSw2mQgomQfwEZgCtor1geOnA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmuu4XpY0pBr9Os1us2XuOyWL+kXOs
        Fntfb2W32PT4GqvF5V1z2CxmnN/HZNG69wi7A7vHplWdbB53ru1h89i8pN7j8ya5AJaobJuM
        1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoAOUFMoSc0qB
        QgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZZ45u
        ZSxYylPxd89L9gbG9VxdjJwcEgImEje6v7B1MXJxCAnsZpSY/34XlPOJUeL0+uNMEM43Ront
        e74ywbR8nv6DESKxl1Hi/sJNrBDOS0aJWes72EGq2AR0JXYsbmMDsUUEZjNJXLqWB2JzCrhI
        LL40DSwuLJAm0bD3EZjNIqAqMXH9MVYQm1fAUmL+ztmMELagxMmZT1hAbGYBeYntb+cwQ1yh
        IPHz6TJWiPlWEru6DjBB1IhLvDx6hB3kIAmBVg6JCSc3sEA0uEi8nPEeyhaWeHV8CzuELSXx
        +d1eoCM4gGwPiUV/pCDCGRJvl69nhLDtJQ5cmcMCUsIsoCmxfpc+xCo+id7fT5ggOnklOtqE
        IKpVJZrfXYVaJC0xsbubFcL2kOjd2QkNt+mMEsf69jBNYFSYheTLWUi+nIXkm1kImxcwsqxi
        lEwtKM5NTy02LTDMSy2HR3hyfu4mRnD61PLcwXj3wQe9Q4xMHIyHGCU4mJVEeFW2rUsR4k1J
        rKxKLcqPLyrNSS0+xGgKDPqJzFKiyfnABJ5XEm9oYmlgYmZmZmJpbGaoJM77unVuipBAemJJ
        anZqakFqEUwfEwenVAPTgpzle4uXVtV9638kNUE2aanvYeZbh0XXz/a+VXVzlVthx3Xrlu+h
        8tsOT3+rMXn69VqDEK7d9ydk+vAvtZ7DEnTQ4LFo78wVmp86jjv3Hnya8lr0pmL1WbMZGwoF
        FyUlLeXN/NJx69ffRM+98xr3vnF0kXU91PPf4Z/hcRaPNdP6mRKuxFnPPlOfY6vYFf96rXZ0
        T0Ufh3tMrlOEBv9dW4N4yVLb6pP2+xc9N8p1qToxL/tEQk3Sa97wrhAzI9kLZ7nPeDzNWPGO
        a5qL79rwexddttW2X9y8unuhn/KnVz4njY8ZVHjt/nz+LpsR1zteiavmVz58TE9btF3rXvGe
        Mga191U56uE7XBS2LTdUYinOSDTUYi4qTgQAGApr3SgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO5npY0pBks/G1is2XuOyWL+kXOs
        Fntfb2W32PT4GqvF5V1z2CxmnN/HZNG69wi7A7vHplWdbB53ru1h89i8pN7j8ya5AJYoLpuU
        1JzMstQifbsErowzR7cyFizlqfi75yV7A+N6ri5GTg4JAROJz9N/MHYxcnEICexmlHj77D4b
        REJa4vrGCewQtrDEyn/P2SGKnjNKLF59lBUkwSagK7FjcRsbSEJEYCGTxKurB8G6hQSmMkps
        PJYKYnMKuEgsvjQNLC4skCKxq3kTC4jNIqAqMXH9MbBBvAKWEvN3zmaEsAUlTs58AlTDwcEs
        oCfRthEszCwgL7H97RxmiIMUJH4+XQbWKiJgJbGr6wATRI24xMujR9gnMArNQjJpFsKkWUgm
        zULSsYCRZRWjZGpBcW56brJhgWFearlecWJucWleul5yfu4mRnCkaGnsYLw3/5/eIUYmDsZD
        jBIczEoivCrb1qUI8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9sSQ1OzW1ILUIJsvE
        wSnVwBQ288uJAu7412FT777fFz75/4JalaOTp1XNmbK3ftYVt72RSw89+PLl4MnsMLaGD//e
        p/VGdbo0+vXdvCpysUVa+uFv+WDT1S6nH513FNm6dKXGlBBRK+GpoQWBGzdqXTmY5Of2L8Fv
        Z75B3KqG9p/nzZzzfyswB/Xz2flFW3WvCJjRFdirWrXBhrnppsmOn2mHxbaUi3uLi5zju1Je
        4fVC85Bw8ZWLOsJtOwwuplq6aPbvdX7nX/akqPeyTbv1of9Bt9pnZJ3xcDqqciGQ85yK1JX4
        Pm5RAxFd8YqN++dvm7R6hdol5oZlhXc7XHl6ymYoHT7T1Wqh+vHN2vs3uA7LxCvJqt3f8Om8
        zB69q0osxRmJhlrMRcWJAPQAfN8DAwAA
X-CMS-MailID: 20230714102659epcas5p3fa1be02a8a0eed9a4b61a01ee1066b21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230713152937epcas5p483e95ece242b0dc2c9a1ada1ba328117
References: <CGME20230713152937epcas5p483e95ece242b0dc2c9a1ada1ba328117@epcas5p4.samsung.com>
        <20230713152926.82884-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Thursday, July 13, 2023 8:59 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>; Rob Herring <robh+dt@kernel.org>; Conor
> Dooley <conor+dt@kernel.org>; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 1/2] ARM: dts: samsung: s3c6410-mini6410: correct ethernet
> reg addresses (split)
> 
> The davicom,dm9000 Ethernet Controller accepts two reg addresses.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Do you need to add fixes: to send to previous stable releases?
In any case:

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm/boot/dts/samsung/s3c6410-mini6410.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
> b/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
> index 17097da36f5e..0b07b3c31960 100644
> --- a/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
> +++ b/arch/arm/boot/dts/samsung/s3c6410-mini6410.dts
> @@ -51,7 +51,7 @@ srom-cs1-bus@18000000 {
> 
>  		ethernet@18000000 {
>  			compatible = "davicom,dm9000";
> -			reg = <0x18000000 0x2 0x18000004 0x2>;
> +			reg = <0x18000000 0x2>, <0x18000004 0x2>;
>  			interrupt-parent = <&gpn>;
>  			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
>  			davicom,no-eeprom;
> --
> 2.34.1


