Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733A8772863
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjHGO6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjHGO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:58:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7B41980
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691420237;
        bh=uwvKyFr1unElz/DkJyUlWAXXoNXN6XIeTc3bxNcJNkc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=iYI4CAzkD9k+dG4wZYhc+Jr8BmqZ4r5PQgQRCCt+HDLuln/Ge91yCEtPhE9GkneV8
         WAEQ1mG6VCvdct+VwYH2gNqj6OwhmulpbBIE66UBjZLfzSGijliArGUvL9z4j3SO97
         ZMZDGXrVp5UkVrChbDZJHgX4LrkiIP39Wh6Xdv7s=
X-QQ-mid: bizesmtp83t1691420103tsslwy1x
Received: from localhost.localdomain ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 22:54:45 +0800 (CST)
X-QQ-SSF: 01400000000000803000000A0000000
X-QQ-FEAT: 3M0okmaRx3gpHCBKqEAQZbExmqoL0neyUJY7/yhBBTF9MQ15WEDdQW1oWfvSy
        p5xcLykMdDtm8FNqBoaKJNDBSOOXgUEM7wxi0y+fJSRmmC/2lV6GPuYYwKmAViTKG4HeSAX
        usypxHCXfbTcna4uG54Z4w9yNkCehSl19ggSPzVxD0hW6bSV9ZT2Utai388SRi4zx0xTwxv
        DR8Vi81DM0rGrAnHtvy8tX8gH2bsr3Km2JmeAm45kKc0t/z45Zxw6m8o37mddL8sUN5uHPO
        JKfVJLl+qRTEPX2Wds2cWCZOGsNhEtCZEKhNoXKzw4lYytYqpfEKR/aj53xFpFlCZFiP6JS
        w6PK9rHrJBfnkUo9A9V1Rde2sQNJBA0tZO9oahD7xRDAbDQqfY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16953552314333439969
From:   Martin Botka <martin@biqu3d.com>
To:     Martin Botka <martin.botka1@gmail.com>
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
        Andrew Lunn <andrew@lunn.ch>,
        Ludwig Kormann <ludwig.kormann@ict42.de>,
        Icenowy Zheng <uwu@icenowy.me>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add BigTreeTech CB1 SoM & Boards
Date:   Mon,  7 Aug 2023 16:53:20 +0200
Message-ID: <8C44A4D4409EB674+20230807145349.2220490-1-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Im aware of the threading issues with sending patches from this email.
It appears to be an issue with SNMP provider. Not much I can do.
I apologize for this.

Cheers,
Martin

Martin Botka (4):
  dt-bindings: vendor-prefixes: Add BigTreeTech
  dt-bindings: arm: sunxi: Add BigTreeTech boards
  arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
  arm64: dts: allwinner: h616: Add BigTreeTech Pi support

 .../devicetree/bindings/arm/sunxi.yaml        |  11 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/allwinner/Makefile        |   2 +
 .../sun50i-h616-bigtreetech-cb1-manta.dts     |  35 +++++
 .../sun50i-h616-bigtreetech-cb1.dtsi          | 140 ++++++++++++++++++
 .../allwinner/sun50i-h616-bigtreetech-pi.dts  |  70 +++++++++
 6 files changed, 260 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts

-- 
2.41.0

