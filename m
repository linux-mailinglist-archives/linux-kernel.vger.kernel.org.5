Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6CB76DA68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjHBWFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjHBWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:05:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E1A1990
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691013876;
        bh=KuKfICHe8kJpAKODRVYzdda8Hek5/0cPyGj8I7ZATlM=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=CzoNHzMnvbI8Ec/Wce2+AA7j9dRHjpOZvcN3u4aBZ+LKlibmc8dKkECA5JrsEDOLh
         WXrgX1f8dD4/b2Jr+NLzaCnwAn829NS9YwR+udkNBs2M8RYBfifNOkUX5+cJudimPK
         JvaxJJs9ZiauJrqW7GTChIfQrkwaMzuuPmfysaB0=
X-QQ-mid: bizesmtp89t1691013810t38ek73v
Received: from TimeMachine.lan ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 06:03:11 +0800 (CST)
X-QQ-SSF: 01400000008000201000B00A0000000
X-QQ-FEAT: iDzLjIm7mlb6svzCVDKdtprdYr5Ri/HS/vKXlXvRaJu43GC2mBGpFg65hutKI
        VEq5zJRTqZ9of6v/teJS70B3V4Cuy1Q51oVsX7YKe0I2SduKmIdoHh175Ng3iWEEJ11xHm0
        mV6tqRfz7I3kq67ecFnK3V5QmJlrAwhZL8ZjQFB36pA5zcm81W5RLW4+Yc1rBQxJAbLAwQ5
        a2bqTIJQDcB8JKnpDnGHSwRRemeh0J+9RuaEoB0z6IaFag2ISYCjIeCnP9pXJHRTe5X+QsD
        HnWFSnETtxbJPY8psOBGvV7EnJ/qdHNQ1C/ubOT6TffaqnRs40q7gDZy1ETG4uXYXeBBMge
        B1idzazbfcreHgLsNjXEjVy5bvznjXxM5r02sTh0e4dKyQGr2E=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14097724008001462046
From:   Martin Botka <martin@biqu3d.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Martin Botka <martin@biqu3d.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>, Icenowy Zheng <uwu@icenowy.me>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] Add BigTreeTech CB1 SoM & Boards
Date:   Thu,  3 Aug 2023 00:02:33 +0200
Message-ID: <910F0CD8FD751C0C+20230802220309.163804-1-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This series adds a vendor prefix for BigTreeTech and adds BigTreeTech CB1,
Manta board and BigTreeTech Pi.

CB1 is just an SoM thats based on AllWinner H616.
BigTreeTech Manta boards are expander boards for CB1 and BigTreeTech Pi
is an CB1 in Rpi style with few additional things like IR receiver and fan port
on GPIO.

This work started before I was hired by BigTreeTech and thus majority of the
patches are from SoMainline email and few are from my work email.

This series depends on commit https://lkml.org/lkml/2023/8/2/801
"dt-bindings: mfd: x-powers,axp152: make interrupt optional for more chips".

Cheers,
Martin

Martin Botka (6):
  dt-bindings: vendor-prefixes: Add BigTreeTech
  dt-bindings: arm: sunxi: Add BigTreeTech CB1
  dt-bindings: arm: sunxi: Add BigTreeTech Manta board
  dt-bindings: arm: sunxi: Add BigTreeTech Pi
  arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
  arm64: dts: allwinner: h616: Add BigTreeTech Pi support

 .../devicetree/bindings/arm/sunxi.yaml        |  16 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../sun50i-h616-bigtreetech-cb1-manta.dts     |  20 +++
 .../sun50i-h616-bigtreetech-cb1.dtsi          | 164 ++++++++++++++++++
 .../allwinner/sun50i-h616-bigtreetech-pi.dts  |  44 +++++
 6 files changed, 247 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts

-- 
2.41.0

