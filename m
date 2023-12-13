Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947858118C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjLMQJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjLMQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:09:46 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFD9AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:09:49 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231213160948epoutp02323a4c0ba00bdb6d7080c7b397fa45ee~gb-w4KU611712417124epoutp02l
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:09:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231213160948epoutp02323a4c0ba00bdb6d7080c7b397fa45ee~gb-w4KU611712417124epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702483788;
        bh=afVvJieNT+llfsmtaR1nNoSD0bljlOmyLWrGv/f0GlA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=pWE8HBU2PORXnNdPyW24obJSdQYv7CfFCpLZAupVLrCi1oCQgj/XnJazdTpZQKBan
         fi8Y34QQl9ly8VnUgBA+TLY1Utg/Y0Bi1YJ3O9jEONzdq+eH5NIIpfkvIrhWPuGmVT
         z1vh/5XiP9DUYh96myTTFJQEWl2Q3uoPNG+HxHxc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231213160947epcas5p3325683ce64e485d30828497c7725e703~gb-v9fiYY2618626186epcas5p3p;
        Wed, 13 Dec 2023 16:09:47 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Sr0mn4Mgfz4x9Pt; Wed, 13 Dec
        2023 16:09:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.92.08567.947D9756; Thu, 14 Dec 2023 01:09:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231213160945epcas5p4968cf82b20ac40bb7a89937f5f83e3b1~gb-t5sIpr1187811878epcas5p4Y;
        Wed, 13 Dec 2023 16:09:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231213160945epsmtrp1aea7a274763388f1e005033043e810e8~gb-t41qNv0255102551epsmtrp1d;
        Wed, 13 Dec 2023 16:09:45 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-4c-6579d74935e4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.B3.08817.847D9756; Thu, 14 Dec 2023 01:09:44 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231213160943epsmtip15a2583debde02121028b0b3c6ef0368b~gb-sHTVNv0109401094epsmtip1A;
        Wed, 13 Dec 2023 16:09:42 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231210133915.42112-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] dt-bindings: pinctrl: samsung: correct ExynosAutov920
 wake-up compatibles
Date:   Wed, 13 Dec 2023 21:39:41 +0530
Message-ID: <016e01da2dde$c9777610$5c666230$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQDwuG9IClMSYxFsO+y1snlGxJj/YwKcDPHesmVr46A=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmhq7n9cpUg9blihZr9p5jsph/5Byr
        xY6GI6wWe19vZbeY8mc5k8Wmx9dYLTbP/8NocXnXHDaLGef3MVm07j3CbnH4TTurxapdfxgd
        eDx2zrrL7rFpVSebx51re9g8Ni+p9+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv
        4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAblRTKEnNKgUIBicXFSvp2NkX5pSWpChn5
        xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGZfOJRZM56pY/uYbSwPjLY4uRk4O
        CQETiYPnpzN3MXJxCAnsZpS4PuclO0hCSOATo8S3HbwQiW+MEjffbmOD6Wg99psJIrGXUWLr
        9ivMEB0vGCWmLPUAsdkEdCV2LG5jAykSEfjCLDHr0CcWkASngIvE7qufGUFsYYEEiSnn77KC
        2CwCqhIrT00A28ArYCnxat9lFghbUOLkzCdgNrOAvMT2t3OYIa5QkPj5dBkrRFxc4uXRI2Bn
        iwhYSVxe/5QRZLGEwA4OiZ3Ne4ESHECOi8SjBYIQvcISr45vYYewpSRe9rdBlXhILPojBRHO
        kHi7fD0jhG0vceDKHBaQEmYBTYn1u/QhtvJJ9P5+wgTRySvR0SYEUa0q0fzuKguELS0xsbub
        FcL2kHj4exYLJNimM0qcnvmAZQKjwiwkT85C8uQsJI/NQti8gJFlFaNkakFxbnpqsmmBYV5q
        OTy2k/NzNzGC06+Wyw7GG/P/6R1iZOJgPMQowcGsJMJ7ckd5qhBvSmJlVWpRfnxRaU5q8SFG
        U2DIT2SWEk3OB2aAvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUa
        mAqUfm671np7vmH4JosJz69/rmzONedb5GO9i+NF/pSnldFhaxjuaty/EsTe/upqHufBfacm
        9/jZJUvLTvgky+K4bgX3owSVp4XbhbeY/pP71BAwNXKR24GKomi5uS/vytaq5fPeYxF7+pHr
        UILjpZkiKpHfPk6SYu4+z8ie/d2srf3K9Qmfp1zO2Pfi+bMf/Klr4vIW3n50k29thTWTfW3k
        /vyjPa8n9VXOre/qFbF+919cpPoQh0HT3Ne3v//sLDKa/XpRqVgQy/d4m81sab/dVNX6C3/s
        /vlo3tTCtzXXy19fMxfe7HDO+oHJlFfZa/qu/jkfolc693HXhPs8y02k3d4X9nlHaBU/kxeQ
        DFdiKc5INNRiLipOBADeDrEBSAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnK7H9cpUg32LTCzW7D3HZDH/yDlW
        ix0NR1gt9r7eym4x5c9yJotNj6+xWmye/4fR4vKuOWwWM87vY7Jo3XuE3eLwm3ZWi1W7/jA6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79G3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZl84lFkzn
        qlj+5htLA+Mtji5GTg4JAROJ1mO/mboYuTiEBHYzSuw/8Y8VIiEtcX3jBHYIW1hi5b/n7BBF
        zxglds3ZzAaSYBPQldixuA3MFhH4wyyxZXk6RNFURomXC5pZQBKcAi4Su69+ZgSxhQXiJF5M
        vMIMYrMIqEqsPDUBrJlXwFLi1b7LLBC2oMTJmU+AbA4OZgE9ibaNYK3MAvIS29/OYYY4SEHi
        59NlrBBxcYmXR4+wQ9xgJXF5/VPGCYxCs5BMmoUwaRaSSbOQdC9gZFnFKJlaUJybnltsWGCU
        l1quV5yYW1yal66XnJ+7iREcbVpaOxj3rPqgd4iRiYPxEKMEB7OSCO/JHeWpQrwpiZVVqUX5
        8UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTB1bLFYcvhNUVP8pyV5hgJC
        uyOkFpzPOXa8NfGqbHL4P9NmbS6P0k/Zs/L01kZ3HNDcfOh0yqpzy2ODbjV4dG8MfONnG18f
        9d5Jd+Xif+HeXwPPtgr6G/31t/v/duHf3wtPpCzN3b1u+3fTWeVd1hH93I2ur2f0iJsqztfi
        KVlgeJzJ3qjw3ONLapf4u37eetrNUMW2d077GpOTtWyaf5Yo7P52ZWur4frnSzbrLD8b/FpQ
        6fOj5fNPvH72ZvKuNzlV5acS1rfYRkssyMv4q+Lk6/tml+bbHXlvjrvta3l0wqqxbNvKnA/S
        H9U/aq5zSjL/9cdo21lt5suGy1+8cj365KAJQ7fPteRjBw4mr3XsVWIpzkg01GIuKk4EAJMG
        Vy4lAwAA
X-CMS-MailID: 20231213160945epcas5p4968cf82b20ac40bb7a89937f5f83e3b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231210133923epcas5p2b8c2e0d2bd5f54a338deb13ccde8f9ba
References: <CGME20231210133923epcas5p2b8c2e0d2bd5f54a338deb13ccde8f9ba@epcas5p2.samsung.com>
        <20231210133915.42112-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Sunday, December 10, 2023 7:09 PM
> To: Tomasz Figa <tomasz.figa@gmail.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>; Sylwester Nawrocki
> <s.nawrocki@samsung.com>; Alim Akhtar <alim.akhtar@samsung.com>;
> Linus Walleij <linus.walleij@linaro.org>; Rob Herring
<robh+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; Jaewon Kim
> <jaewon02.kim@samsung.com>; linux-arm-kernel@lists.infradead.org;
> linux-samsung-soc@vger.kernel.org; linux-gpio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] dt-bindings: pinctrl: samsung: correct ExynosAutov920
> wake-up compatibles
> 
> ExynosAutov920 SoC wake-up pin controller has different register layout
> than Exynos7, thus it should not be marked as compatible.  Neither DTS nor
> Linux driver was merged yet, so the change does not impact ABI.
> 
> Cc: Jaewon Kim <jaewon02.kim@samsung.com>
> Fixes: 904140fa4553 ("dt-bindings: pinctrl: samsung: use Exynos7 fallbacks
for
> newer wake-up controllers")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> ---
> 
.
.
.
--
> 2.34.1
> 


