Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C66755FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjGQJrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjGQJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:47:32 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E09E56
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:47:27 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230717094723epoutp01981f8cf70425351d1a5ebc904e50da4d~ynqViofei2437324373epoutp01p
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:47:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230717094723epoutp01981f8cf70425351d1a5ebc904e50da4d~ynqViofei2437324373epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689587243;
        bh=ZfGDEaaLUUB1D/6qCrQO26vbWCkrtRoAi4OwryWDsBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AC3mbEKCOVGJPpZ5BZMRvaEVmusVV2MEV1+ZbSKpGxPf4ZZ1K/UlYCk/KFMj6jB88
         CfGrs0TjMPlTgrByKj8Cl8Pc/bJHzB8VV+tpW6llDhyIslLgNaCbsr2CGQFFCV4434
         Px9WZhkkgj5SuGU3yIl7KSd3Vcy/Nmg+ken5Qb/Y=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230717094722epcas2p3f331a98980ea28258caf12e6d0b69b68~ynqVGELQp1178111781epcas2p37;
        Mon, 17 Jul 2023 09:47:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4R4HLL4Fgmz4x9Q0; Mon, 17 Jul
        2023 09:47:22 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.FA.40133.A2E05B46; Mon, 17 Jul 2023 18:47:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230717094721epcas2p1c5c1254e24d4a1d0fb366e1b4d551536~ynqULc4ag2919929199epcas2p1V;
        Mon, 17 Jul 2023 09:47:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230717094721epsmtrp132d6c76b29beb1eafd85bc7b4bdec367~ynqUKZZZ92680726807epsmtrp1i;
        Mon, 17 Jul 2023 09:47:21 +0000 (GMT)
X-AuditID: b6c32a46-4edb870000009cc5-75-64b50e2a1e4c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.0D.30535.92E05B46; Mon, 17 Jul 2023 18:47:21 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230717094721epsmtip2eb3b9c03e3bf6e8a8ac0cceebcb4fd98~ynqT-Cw0H0570605706epsmtip2n;
        Mon, 17 Jul 2023 09:47:21 +0000 (GMT)
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
Subject: [PATCH v4 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Date:   Mon, 17 Jul 2023 18:42:01 +0900
Message-Id: <20230717094202.18296-2-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717094202.18296-1-jaewon02.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmha4W39YUg0P7FSwezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KOybTJSE1NSixRS85LzUzLz
        0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
        pCpk5BeX2CqlFqTkFJgX6BUn5haX5qXr5aWWWBkaGBiZAhUmZGf0bLjEVHCDu+LqCt8Gxhsc
        XYycHBICJhJT+/azdjFycQgJ7GCUOH5mCSOE84lRYk1TJzOE841RYurS/ywwLes/TmYFsYUE
        9gIldvJCFH1klOhb9ooRJMEmoC3xff1isCIRgYVMEs/ul4EUMQucZpRYe+sJ2CRhgQCJY1PW
        gxWxCKhK9M9fBhbnFbCV2LHxAdQ2eYnVGw4wg9icAnYSW28uBjtWQuAnu0TvpGNA2ziAHBeJ
        /TedIOqFJV4d38IOYUtJvOxvg7KzJdqn/2GFsCskLm6YzQZhG0vMetYONoZZQFNi/S59iInK
        EkdugV3ALMAn0XH4LztEmFeio00IolFN4v7Uc1BDZCQmHVnJBGF7SBxa28sCCZKJjBK/fxxk
        msAoNwthwQJGxlWMYqkFxbnpqcVGBUbw+ErOz93ECE6FWm47GKe8/aB3iJGJg/EQowQHs5II
        7/dVm1KEeFMSK6tSi/Lji0pzUosPMZoCg24is5Rocj4wGeeVxBuaWBqYmJkZmhuZGpgrifPe
        a52bIiSQnliSmp2aWpBaBNPHxMEp1cA0o8umJtD64fMbDn0BDupnln4V2e5Q/a57o6lLYOTE
        O4yvNpZPFfYQ3KjxfmvrZ2Gh7i9eO2dn5O7jXed5I/x85b00qx/lIs9lpSQYCkK2b+97rvZ4
        J6dvk9/WyH/ThZteHVv1YO+9SbwLPX7V9fzomfeR9zaf71zBI1LanE8XdFgd9az4vkgnmrtn
        js5F/wnfdq67P6d79x6v6nN7X0+7n9J18YmeB0fDg4iw76uffZqctFxS6eC20t7OEz8PBj44
        qutRlSY3X/TKp4RlNWGMc+qK/9R+WtkmvkLyznIZQ9Nq/7DXJgqfN0zeKva969fdDZynRTSl
        Zfm+MD6d95cxnaPyfLhp5J58O3O9F6e4lViKMxINtZiLihMBRDETRg4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSvK4m39YUg61bjCwezNvGZrFm7zkm
        i/lHzrFa7Gg4wmrR9+Ihs8Wmx9dYLS7vmsNmcffuKkaLGef3MVm07j3CbvFz1zwWi9sTJzM6
        8HjsnHWX3WPTqk42jzvX9rB5bF5S79H/18Cjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mno2
        XGIquMFdcXWFbwPjDY4uRk4OCQETifUfJ7OC2EICuxklen4bQMRlJJY/62ODsIUl7rccAarh
        Aqp5zyjxY1IHI0iCTUBb4vv6xWAJEYHFTBJvuh+COcwCFxklTvy5wg5SJSzgJzF7+zqwDhYB
        VYn++ctYQGxeAVuJHRsfsECskJdYveEAM4jNKWAnsfXmYqiTbCUWvW5ln8DIt4CRYRWjZGpB
        cW56brFhgVFearlecWJucWleul5yfu4mRnDgamntYNyz6oPeIUYmDsZDjBIczEoivN9XbUoR
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvtdW+KkEB6YklqdmpqQWoRTJaJg1Oqgemi8u0Niy5x
        L8ycOjVyv7jcR2c2633HT75O2RkapuTk3Nb1ZjFL4+n1707tZns//3OOCYf2ZTn55rMrjhxp
        PxaxuM5PLNiUrSvuQcqKuwW2ymFLwoSVLwv+WFSWO+mgyqZPq3jmTNJiiTZq+zJF1WdR6Jsd
        0cselYouahPt3WPJd1csSyPsV8M3wc11VSan61UYz/w//XHP4ss8K9oOyN6rms9073N7uUp5
        S9S/0mdZ17hW+bXMa8k+1rnK839ypWaghvuv3I+6ihlHQxf+lq2z2+V+fLnX7Sn/zxov9XrJ
        LerRPE+dc9FJcfHLEv9Lle1d11lIOpu83qavz2QW/1vtTc6zFQu22jsyvnokZ6vEUpyRaKjF
        XFScCAACiV7KywIAAA==
X-CMS-MailID: 20230717094721epcas2p1c5c1254e24d4a1d0fb366e1b4d551536
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230717094721epcas2p1c5c1254e24d4a1d0fb366e1b4d551536
References: <20230717094202.18296-1-jaewon02.kim@samsung.com>
        <CGME20230717094721epcas2p1c5c1254e24d4a1d0fb366e1b4d551536@epcas2p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add samsung,exynosautov9-pwm compatible string to binding document.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 .../devicetree/bindings/pwm/pwm-samsung.yaml     | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index fe603fb1b2cc..6f65e2b52f52 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -20,12 +20,16 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - samsung,s3c2410-pwm             # 16-bit, S3C24xx
-      - samsung,s3c6400-pwm             # 32-bit, S3C64xx
-      - samsung,s5p6440-pwm             # 32-bit, S5P64x0
-      - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
-      - samsung,exynos4210-pwm          # 32-bit, Exynos
+    oneOf:
+      - const: samsung,s3c2410-pwm        # 16-bit
+      - const: samsung,s3c6400-pwm        # 32-bit, S3C64xx
+      - const: samsung,s5p6440-pwm        # 32-bit, S5P64x0
+      - const: samsung,s5pc100-pwm        # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
+      - const: samsung,exynos4210-pwm     # 32-bit, Exynos
+      - items:
+          - enum:
+              - samsung,exynosautov9-pwm  # 32-bit, ExynosAutov9
+          - const: samsung,exynos4210-pwm
 
   reg:
     maxItems: 1
-- 
2.17.1

