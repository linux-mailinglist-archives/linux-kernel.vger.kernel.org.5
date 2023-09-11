Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA71F79B254
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348678AbjIKV3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbjIKNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:34:23 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CBCD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:34:17 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230911133415euoutp01773752e847dd4193442e3d654e45131d~D24Zi8EC02174021740euoutp01m
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230911133415euoutp01773752e847dd4193442e3d654e45131d~D24Zi8EC02174021740euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694439255;
        bh=2Tnd5geW05sUAKwPwLdNlu3ET1dwYUIDETcddL3bGaM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GGPmtVcb0lnzWV0Y7gExxFVr3iW7ipyKWFfvU2fs854p/pJUl4+jk96k6xqE+lJG5
         QhlUzpRnVYvINhm9Z5Va+v2GwxWNKo2wmQoGfsB/bxuyTmvOuBomkJKUpVviCnUpf2
         dze2n+GS0/Zd9vxTObbY7643pa/lZTLP3rPvk7UE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230911133414eucas1p21199a978db8ab96180bab694b137c150~D24ZOarSc1713017130eucas1p2W;
        Mon, 11 Sep 2023 13:34:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F7.8E.11320.6571FF46; Mon, 11
        Sep 2023 14:34:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230911133414eucas1p116d395f8219ea34c284aa21d46033fa6~D24Y49S6s1288212882eucas1p1o;
        Mon, 11 Sep 2023 13:34:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230911133414eusmtrp1bf509f49c228e86ba4e998dd58583b61~D24Y4UOSX2520025200eusmtrp1J;
        Mon, 11 Sep 2023 13:34:14 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-6b-64ff1756f245
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.5B.10549.6571FF46; Mon, 11
        Sep 2023 14:34:14 +0100 (BST)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
        [106.120.51.28]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230911133413eusmtip1f098d0b8e9796317242ab2b0e35c32d0~D24YSgE5R1486914869eusmtip1X;
        Mon, 11 Sep 2023 13:34:13 +0000 (GMT)
From:   Mateusz Majewski <m.majewski2@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Majewski <m.majewski2@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] arm64: dts: exynos: remove unused TMU alias
Date:   Mon, 11 Sep 2023 15:33:39 +0200
Message-ID: <20230911133342.14028-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7ph4v9TDI51aVg8mLeNzWLN3nNM
        FvOPnGO16HvxkNli0+NrrBaXd81hs5hxfh+TxcRjk5kt1h65y27RuvcIuwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDIOvDvPWvCJtWLrvocsDYwfWboYOTkk
        BEwktn27w9bFyMUhJLCCUeLP7vlMEM4XRonF+48xQjifGSW6Ds1gh2lZt/ohK0RiOaPEjIXP
        2SGcViaJVYefgQ1mEzCQePBmGVhCRKCdUWLB3WfMIA6zQCeTxPuv01lBqoQFbCQWHd7HDGKz
        CKhKLLj0nhHE5gWKH1zSzwixT17i+a077BBxQYmTM5+AbWAGijdvnQ02VEJgC4fEs+5FQA4H
        kOMicXWZK0SvsMSr41ug7paROD25B+rtfIkZm9+zQJRXSNw96AVhWkt8PAM2hFlAU2L9Ln2I
        YkeJU40NULP5JG68FYTYzycxadt0qDCvREebEES1qsTxPZOYIWxpiSctt5kgSjwkOj+6gYSF
        BGIlGq73s0xgVJiF5KlZSJ6ahXDCAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIEp
        6PS/4192MC5/9VHvECMTB+MhRgkOZiUR3pJDf1OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rb
        nkwWEkhPLEnNTk0tSC2CyTJxcEo1MM084Hi4/9e8EG+D2L1efRPyop7VzWSpz3KaKywe/qRz
        X3OD8vvVW9Y9m/n+RX6fePJNxV/KP46ZLz68M81y++ZdM2c/+rnYs2VT4pVb6y5fXcQWXWlY
        yH7k97+SLRbue34tfynkodJ/1HLNmit9Ex/cFbqkcNT1g7XI+o0RB2dHqNVKTJdpNnwTO892
        wiap2hyxb7xVidWXSh2idla56530unRiVmrOJiOW5r9uc511Ql+2sjwJsC+s5vx34I7rs0Z7
        qyM9gcaPPxhVf0nw5X+9df3lraF/C9sO7f90Xc7j56yOPp3qo5018RUJWfWTSuq3/gktNGWQ
        K4627uQtSq+9+/SdqiejGmPSHN6UfCWW4oxEQy3mouJEADmrYSWwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsVy+t/xu7ph4v9TDB5cELR4MG8bm8WaveeY
        LOYfOcdq0ffiIbPFpsfXWC0u75rDZjHj/D4mi4nHJjNbrD1yl92ide8Rdgcuj02rOtk87lzb
        w+axeUm9R9+WVYwenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp
        29mkpOZklqUW6dsl6GUceHeeteATa8XWfQ9ZGhg/snQxcnJICJhIrFv9kLWLkYtDSGApo8SM
        RRcZIRLSEoe/TGGHsIUl/lzrYoMoamaS6JgzFaybTcBA4sGbZewgCRGBbkaJQzNvsYA4zALd
        TBLdix+BjRIWsJFYdHgfM4jNIqAqseDSe7A4L1D84JJ+qHXyEs9v3WGHiAtKnJz5BGwDM1C8
        eets5gmMfLOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGAXbjv3cvINx3quP
        eocYmTgYDzFKcDArifCWHPqbIsSbklhZlVqUH19UmpNafIjRFOi+icxSosn5wDjMK4k3NDMw
        NTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg0nYV/VRj3qrZnfFF5Pxel7nH
        toSWpQtUbWmc/+gB49zlVZtUDtz89LEj2/6r+NEtr04tExS51253fdLaINUG0+9qM7KY+Jzl
        t/WHLbqnrBY/f3q2f2Suh9vL+8cyL3j9iumTPjPhhICX2crbbiG3pvE15ckdcrv6zEvAbs4T
        4/P1G8xWigq4SajO6il8fCZmm+6HTvO7IouPKXQoyn/ZfKRraX9xburM4O3bloSwKmX+1636
        or6FrSm0Piju8sXIrRp2rWnTLXk8dqQ6W3J8bA8T0M3bXDUzlFH6Qt93i1lzpdcttD/2uVh4
        t5R3Veu7A0cPdTh8DFvS+Ofyp2lz/eVMD6cGOi6/ulVaZtI5JZbijERDLeai4kQA17nomQsD
        AAA=
X-CMS-MailID: 20230911133414eucas1p116d395f8219ea34c284aa21d46033fa6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230911133414eucas1p116d395f8219ea34c284aa21d46033fa6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230911133414eucas1p116d395f8219ea34c284aa21d46033fa6
References: <CGME20230911133414eucas1p116d395f8219ea34c284aa21d46033fa6@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ID of this alias is checked by the exynos-tmu driver, but isn't used
anywhere and omitting it does not cause an error. Indeed, this is the
only Exynos device that defines this alias.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 54ed5167d0f6..6ed80ddf3369 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -25,7 +25,6 @@ aliases {
 		pinctrl6 = &pinctrl_fsys0;
 		pinctrl7 = &pinctrl_fsys1;
 		pinctrl8 = &pinctrl_bus1;
-		tmuctrl0 = &tmuctrl_0;
 	};
 
 	arm-pmu {
-- 
2.41.0

