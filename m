Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27976FCD5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjHDJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHDJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:06:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AEE6A65
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691139763;
        bh=076LEVD4BSyLWa2SK5VEdvnkqk724L3qR38RrXLbRys=;
        h=From:To:Subject:Date:Message-ID:MIME-Version;
        b=U1QcAi10vNcKy0uCpS48sWcAEop1nsZtvGzTWhsUjoY95mniWSc6l/V/BKQvBBtNr
         gw865bhoUQ4NGekVyFS2mU0OWrKaSW7LkQZIgulYGKZhTk4wOnkLO1GjPv1i5/HoH9
         1yqkTuDLDfnCoViOfBeP8BcwLY+SsMx03IZ5ipMg=
X-QQ-mid: bizesmtp65t1691139692t3on4gcc
Received: from localhost.localdomain ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Aug 2023 17:01:13 +0800 (CST)
X-QQ-SSF: 01400000000000404000000A0000000
X-QQ-FEAT: CbHyMb8VrI0apQFECDBnaa0WH30dRGFXyvH1NAubuW747/SP5wwgte8RozsWT
        lmsxn3196kNP4oFbTgDFKlTaao13LeM/mQ8BgcmMmiZc/Pk9Ca73xI4sRt2nsb1+6yYso/1
        W7175A8iZQyXzbS7AJCiM3cAf3u+5RIU3rFSeJVHEdHhyrK2b3DcA+LcFEy0PwLAhN43NCE
        ISoMEPZnrDb9MumTUaX1nZkNvGSAYugG6Tqom2XMwFp4lIo11hbQLM58Kmr2HI0+WmqsmH8
        CQpLtcuyIxYiS8Hh7p4onAco7qQ/kymhfIFERX5CVmO6TrIVpbDag5d7OP3+uPq5W7l4WfQ
        dwfRWLRbzoAMbQ8gSqWYYxtfeg0YfFBo4rF4hIfxksaLmcokkv6oQpLIIk3ZA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3923523324437657278
From:   Martin Botka <martin@biqu3d.com>
To:     martin.botka1@gmail.com
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
Subject: [PATCH v2 0/4] Add BigTreeTech CB1 SoM & Boards
Date:   Fri,  4 Aug 2023 11:00:28 +0200
Message-ID: <DC7CD91802A925BE+20230804090102.273029-1-martin@biqu3d.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 .../sun50i-h616-bigtreetech-cb1.dtsi          | 142 ++++++++++++++++++
 .../allwinner/sun50i-h616-bigtreetech-pi.dts  |  68 +++++++++
 6 files changed, 260 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts

-- 
2.41.0

