Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EDF7537B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjGNKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbjGNKPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:15:09 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C8135A0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:14:37 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230714101435epoutp02f04b98715daad90f74c35197202f2075~xtGOemm5L2315523155epoutp02n
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:14:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230714101435epoutp02f04b98715daad90f74c35197202f2075~xtGOemm5L2315523155epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689329675;
        bh=yK1xGhHzK+NDKt3tZuBvwImsLO9+yzMP1mU5qjcOkpE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HKF2ZRo5FjjzP0Pp8FklxK1uk1yONTHdSuvS1cr0+wGQC8GZ6lPQcrhuVkoQAjSN9
         gcdcRRXBhUankF6UChhe13lI4p9J4v1abjNU4QY4e0AbFpRMAl22CPu4xf2LH+okum
         0OS32IhUlzu0aTZbQJJCAapdBgaLO5NCq9tR/5FU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230714101434epcas2p10a284d47be5c8d70c8d31a8c8bad19a6~xtGN9N3lZ3223032230epcas2p1V;
        Fri, 14 Jul 2023 10:14:34 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4R2S562Bkgz4x9Pp; Fri, 14 Jul
        2023 10:14:34 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.4D.29526.A0021B46; Fri, 14 Jul 2023 19:14:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230714101433epcas2p29094f5fa3c41e39a51a0010124ebea73~xtGNSKs8J2671026710epcas2p2Q;
        Fri, 14 Jul 2023 10:14:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230714101433epsmtrp2a7427bcdc12b00317fb2f5fff3585963~xtGNRUa410345803458epsmtrp24;
        Fri, 14 Jul 2023 10:14:33 +0000 (GMT)
X-AuditID: b6c32a4d-637c170000047356-2a-64b1200adffd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.F3.34491.90021B46; Fri, 14 Jul 2023 19:14:33 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230714101433epsmtip117736aca0bec3ae2751573634ff0094f~xtGNCgxSu3014330143epsmtip1v;
        Fri, 14 Jul 2023 10:14:33 +0000 (GMT)
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
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v2 0/3] support PWM for exynosautov9
Date:   Fri, 14 Jul 2023 19:09:26 +0900
Message-Id: <20230714100929.94563-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmuS6XwsYUgxVT+CwezNvGZnF5v7bF
        mr3nmCzmHznHarGj4QirRd+Lh8wWmx5fY7W4vGsOm8Xdu6sYLWac38dk0br3CLvFz13zWCxu
        T5zM6MDrsXPWXXaPTas62TzuXNvD5rF5Sb1H/18Dj74tqxg9Pm+SC2CPyrbJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdcfXpR5aC3ywVi4+o
        NDA+Y+5i5OSQEDCReNy0nhHEFhLYwyjxc6slhP2JUaJznU0XIxeQ/Y1R4u2MK3ANS95tY4RI
        7GWUmP7vNhOE85FR4v3MY0wgVWwC2hLf1y9mBbFFBBYySTy7XwZiM4OMmvyHB8QWBpr0Y/Fa
        NhCbRUBV4uWzXexdjBwcvAK2EpsapSGWyUus3nAAavFLdone21BxF4n9p5ZBxYUlXh3fwg5h
        S0l8freXDcLOlmif/ocVwq6QuLhhNlTcWGLWs3ZGkFXMApoS63fpg5gSAsoSR26xQBzJJ9Fx
        +C87RJhXoqNNCKJRTeL+1HNQQ2QkJh1ZyQRhe0i03DvMBAm2WImOm8eYJzDKzkKYv4CRcRWj
        VGpBcW56arJRgaFuXmo5PI6S83M3MYJTn5bvDsbX6//qHWJk4mA8xCjBwawkwquybV2KEG9K
        YmVValF+fFFpTmrxIUZTYIBNZJYSTc4HJt+8knhDE0sDEzMzQ3MjUwNzJXHee61zU4QE0hNL
        UrNTUwtSi2D6mDg4pRqY7ALeF5wQ8uEwmXLq66OkWVGu2XcNb1TUXjdi7Uk+M4NX1+tx3ycX
        vgnzTvhdsrA5d2HqjMqnR3LXTw5Q//3s84uIl42SvS/jj/+ZcnYD29YpRy4rfOFnTcz7Eef7
        paJ8/X+LQtaD7e+LZc5POJ09cdkVjRU20Zlpu77PD4u1aiiWLQ/8tjysLOfScyVu4Z4oA63b
        U8KK/iw7zLL1fc9Stri8PeXMQSlz5n654V00bZv7yau3lzuvWytQdGCe3eS5v1tOqnNrGJ5K
        L1p27frthf+NfBZL7jVs/PGySbBtxzzLHYlLIxpYmGRuHNv/KCha+ynHacfCGN7OxKNCoZq3
        l6Vc4y51s7vwjD8qgN36hxJLcUaioRZzUXEiAIYCeakGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnC6nwsYUg3s3DC0ezNvGZnF5v7bF
        mr3nmCzmHznHarGj4QirRd+Lh8wWmx5fY7W4vGsOm8Xdu6sYLWac38dk0br3CLvFz13zWCxu
        T5zM6MDrsXPWXXaPTas62TzuXNvD5rF5Sb1H/18Dj74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL
        4Mq4+vQjS8FvlorFR1QaGJ8xdzFyckgImEgsebeNsYuRi0NIYDejROOU+2wQCRmJ5c/6oGxh
        ifstR1ghit4zSrz4vYYVJMEmoC3xff1isISIwGImiTfdD8EcZoE/jBL9TSvAqoSBdvxYvBZs
        FIuAqsTLZ7vYuxg5OHgFbCU2NUpDbJCXWL3hAPMERp4FjAyrGCVTC4pz03OLDQsM81LL9YoT
        c4tL89L1kvNzNzGCA1JLcwfj9lUf9A4xMnEwHmKU4GBWEuFV2bYuRYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwenVAOT6uHqtXfPsfy4Keh0dPoH1UvZe+Ya
        /Twav1Rmw4lmztibmayVHcW7gj6237rjqHSD7/88y1la/f7H3IXzF/3oZ2w6v+2N/5nuNE6H
        sEjr/ImLVSY0L9m8WuftcYmmr7feOW3d/T9hU/LeK5HcC5blHUq/FZo87ecBHlFv0xnLn364
        lvA9Q/nz4sC8xm0/FUQCVbKtbk+d8SP0zqHWlwd3zLoj4z2JZ+GU1Vt1pqXLMuax3D+8a+4x
        VsWLfUu/tU8Ivhr8/6qOacVHrnsbZK52bbBKt1AQcHymtK0ya9IG++WCz2e3rdD78UTj5MGM
        bIYNpw/+19iWJhS0t3L9+2u1i74etqial35DhuPz0gvhMS+VWIozEg21mIuKEwFVui3BtwIA
        AA==
X-CMS-MailID: 20230714101433epcas2p29094f5fa3c41e39a51a0010124ebea73
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714101433epcas2p29094f5fa3c41e39a51a0010124ebea73
References: <CGME20230714101433epcas2p29094f5fa3c41e39a51a0010124ebea73@epcas2p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pwm nodes to support PWM fan on exynosautov9-sadk board.

Changes in v2.
 - add new compatible string for exynosautov9

Jaewon Kim (3):
  dt-bindings: pwm: samsung: add exynosautov9 compatible
  pwm: samsung: Add compatible for ExynosAutov9 SoC
  arm64: dts: exynos: add pwm node for exynosautov9-sadk

 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts       | 6 ++++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi           | 9 +++++++++
 drivers/pwm/pwm-samsung.c                              | 1 +
 4 files changed, 17 insertions(+)

-- 
2.17.1

