Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001D7757424
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGRG1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjGRG1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:27:39 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BE170F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:27:27 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230718062725epoutp014f7d39e198e5e8efe479521a3f132f24~y4lBkHC-_2199221992epoutp01Z
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:27:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230718062725epoutp014f7d39e198e5e8efe479521a3f132f24~y4lBkHC-_2199221992epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689661645;
        bh=3bOGiT3ikHTUDaEMZyxt0KawOuLANRDEEEMA3gDYL/A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fbSIGsSuwe4qKtnJ/RK2WmHrriCGpRe9/uYYmnyd6XeOevmeKX+egUj0HAnBZafZd
         qEGtQDAbAfEt+6k1HFf9BVDtHMYUJnuWGmTyiH4+LMv1Uuk1bs/iUEflzDMjhEhELT
         i68j01mV56otTC7A9Zn+tNs4AQNONMbV5vOn7ZmU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230718062724epcas2p2c9c172d740d130b6960882a126f39270~y4lBDlBM61964119641epcas2p23;
        Tue, 18 Jul 2023 06:27:24 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R4ps81kmnz4x9Q3; Tue, 18 Jul
        2023 06:27:24 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.57.32606.CC036B46; Tue, 18 Jul 2023 15:27:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230718062723epcas2p4fa1d2b07220c873a4d7de2d1899f1699~y4lAYyf9a3019630196epcas2p4r;
        Tue, 18 Jul 2023 06:27:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230718062723epsmtrp14428f918ae8dacedce08a6eb9280a6fd~y4lAVTYnA2319023190epsmtrp1h;
        Tue, 18 Jul 2023 06:27:23 +0000 (GMT)
X-AuditID: b6c32a47-9cbff70000007f5e-35-64b630ccc409
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.F5.34491.BC036B46; Tue, 18 Jul 2023 15:27:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230718062723epsmtip260970c94a2b257f909b8515ac14eb87c~y4lADBjtl0240002400epsmtip2W;
        Tue, 18 Jul 2023 06:27:23 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v6 0/2] support PWM for exynosautov9
Date:   Tue, 18 Jul 2023 15:21:58 +0900
Message-Id: <20230718062200.79306-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmhe4Zg20pBrc7uSwezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGc8WPKRsWAeW8XpHf3sDYy/
        WboYOTkkBEwkvrStYuti5OIQEtjBKDFv4gx2kISQwCdGif4HcRCJb4wSz5f+YYTpuDljPiNE
        Yi+jxLLTG5ghnI+MEvPP9TCBVLEJaEt8X7+YFcQWEVjIJPHsfhlIEbPAaUaJtbeegC0XBho1
        9dpnsH0sAqoSDc/Wgtm8ArYS19+vhFonL7F6wwGwDRIC99glvh48zAqRcJE4+vQ6M4QtLPHq
        +BZ2CFtK4mV/G5SdLdE+/Q9UfYXExQ2z2SBsY4lZz9qBFnAAXaQpsX6XPogpIaAsceQW2GnM
        AnwSHYf/skOEeSU62oQgGtUk7k89BzVERmLSkZVMELaHxInWN9CQi5XY//430wRG2VkI8xcw
        Mq5iFEstKM5NTy02KjCGR1Jyfu4mRnDS03LfwTjj7Qe9Q4xMHIyHGCU4mJVEeL+v2pQixJuS
        WFmVWpQfX1Sak1p8iNEUGFwTmaVEk/OBaTevJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS
        1OzU1ILUIpg+Jg5OqQamRbP7Y9/mHbSYHSDid//Yw2unt7ryvp5/Qn7Dk9e3Dzo5Hl3361tT
        6KmKoobvvCtlDzyJM57fLmZ04r3dPgeGsl3NV+qzNcIKQhe9qrFjWFEmmcFwbrVFwvzveiHH
        lbcdFoyO/dJw7XkeB9/OwmN2G1xYexelPZhf+L1t/dVsc16meAfFrjDnHbsLk88eT9BP4Lsn
        OmH/wqI7mec1f9Q8+xG46DBrz6efk1M2OyvfF/o3bVH6Eq1K7k+hoUHmvTevPbiTFePAcELd
        tJv1+BROl04r6ao4A79ZZj/uS5zmF8k+nRMslOU2xUH+t2n91EeH5nx0Dt9y+NElw5Ldfaxr
        0uNP1vK0fIlecUfgrHu+EktxRqKhFnNRcSIARmq55AMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSvO5pg20pBruPaFs8mLeNzWLN3nNM
        FvOPnGO12NFwhNWi78VDZotNj6+xWlzeNYfN4u7dVYwWM87vY7Jo3XuE3eLnrnksFrcnTmZ0
        4PHYOesuu8emVZ1sHneu7WHz2Lyk3qP/r4FH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZTxY
        8pGxYB5bxekd/ewNjL9Zuhg5OSQETCRuzpjP2MXIxSEksJtRYumEiVAJGYnlz/rYIGxhifst
        R1hBbCGB94wSqw7Xg9hsAtoS39cvZgVpFhFYzCTxpvshmMMscJFR4sSfK+wgVcJAK6Ze+wxm
        swioSjQ8Wwtm8wrYSlx/v5IRYoO8xOoNB5gnMPIsYGRYxSiZWlCcm55bbFhgmJdarlecmFtc
        mpeul5yfu4kRHIpamjsYt6/6oHeIkYmD8RCjBAezkgjv91WbUoR4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUw6XB0JphUvyiUC5+r2aWfei4vafHFw8LP
        wn6or/sheLRh+urZH1lvKeTeOO4tqvSsuC1h6dc9QfbC9geWyizOWH9qUbdK0LKfRW9Cdtbr
        trQncMzylVx652GTusNlidY72cvFWyQ4jZw/sE91nmmxKaehpIW3yP9qfeVWMfc6nenPFm51
        E9/Dr+9V7d2azXJBIcLOcraZFOu6d2mbd3dqqDAG8G0wfzLhQEneC82Uu8839yveyXNcFbL/
        +8UOqcbrNZK2bqJq0kf/1pQr8/i/zttyMujfhqXK2y7I3tq7b3rwglMKWbuWfJSc8rRxx6Et
        1yfMsrKYFvRgJrPD+R27D+heObcg4Oqe//+XqUi8VmIpzkg01GIuKk4EAJIk+bq0AgAA
X-CMS-MailID: 20230718062723epcas2p4fa1d2b07220c873a4d7de2d1899f1699
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230718062723epcas2p4fa1d2b07220c873a4d7de2d1899f1699
References: <CGME20230718062723epcas2p4fa1d2b07220c873a4d7de2d1899f1699@epcas2p4.samsung.com>
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

Add pwm nodes to support PWM fan on exynosautov9-sadk board.

---
Changes in v6:
 - add disabled status to exynosautov9.dtsi

Changes in v5:
 - change const to enum in dt-bindings document
 - remove comment for exynosautov9

Changes in v4:
 - add document file.

Changes in v3:
 - removed adding compatible to driver.

Changes in v2:
 - add compatible string to driver.


Jaewon Kim (2):
  dt-bindings: pwm: samsung: add exynosautov9 compatible
  arm64: dts: exynos: add pwm node for exynosautov9-sadk

 .../devicetree/bindings/pwm/pwm-samsung.yaml    | 17 +++++++++++------
 .../arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi    | 11 +++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.17.1

