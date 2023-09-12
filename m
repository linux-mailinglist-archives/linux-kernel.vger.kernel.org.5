Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AC879CFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjILLVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjILLVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:21:07 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5187171B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:20:56 -0700 (PDT)
Received: from [192.168.2.137] (bband-dyn191.178-41-225.t-com.sk [178.41.225.191])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 86826200E3;
        Tue, 12 Sep 2023 13:20:52 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Subject: [PATCH v6 0/4] Add BigTreeTech CB1 SoM & Boards
Date:   Tue, 12 Sep 2023 13:20:46 +0200
Message-Id: <20230912-b4-cb1-v6-0-bb11238f3a9c@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5JAGUC/2XMQQ7CIBCF4as0sxYDFAi68h6mi0Kn7SQKDRiia
 bi72K3L/+Xl2yFjIsxw7XZIWChTDC3MqQO/jmFBRlNrkFz23ArFnGLeCaacsJYL9LNBaOct4Uz
 vA7oPrVfKr5g+h1v0b/0jimacXaToNbdmQlS3HJ8jhQcFPMe0wFBr/QIokb3qoQAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694517652; l=2428;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=leaBh3diZ3MZ30XqxJNPfTE1vSCVgVS4aD8h/WWeOlw=;
 b=sup0iEiznSkWwFYCxzgrHf/xKvcZUfMeJ10xErtkR00fZVsv+BMWVENrKWTycoUracW+PA+FC
 XS+7tZSl/Y8BP0SdPGZHIsUHtak2qfNAu+UPEgztLAjsT7davAiL+28
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
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

This series depends on commit https://lkml.org/lkml/2023/8/28/1073
and https://lkml.org/lkml/2023/8/2/801

Cheers,
Martin

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
Changes in v6:
- Remove SPI node from BTT Pi (To be used via overlays)
- Rebase on top of 6.6-rc1

Changes in v5:
- Removal of wifi node comments that were obvious from properties

Changes in v4:
- Extend the range of vcc-dram to 1.5V (Max of 1.35V caused issues with booting up)

Changes in v3:
- Add missed semicolons
- Move model string from dtsi to board dts
- Add cb1 compatible to manta
- Remove extra empty lines
- Add pinctrl for SPI0

Changes in v2:
- Fix alphabetical order in vendor prefixes
- Remove CB1 SoM from bindings (Its not standalone)
- Fixed whitespace errors
- Move UART into carrier boards and BTT Pi
- Remove usb1-vbus regulator
- Fix ranges and naming of AXP313A rails
- Add comment why broken-cb in mmc0 is needed
- Rename sdio_wifi to wifi
- Add model string to BTT Pi
- Enable IR receiver for BTT Pi
- Enable SPI0

---
Martin Botka (4):
      dt-bindings: vendor-prefixes: Add BigTreeTech
      dt-bindings: arm: sunxi: Add BigTreeTech boards
      arm64: dts: allwinner: h616: Add BigTreeTech CB1 SoM & boards support
      arm64: dts: allwinner: h616: Add BigTreeTech Pi support

 Documentation/devicetree/bindings/arm/sunxi.yaml   |  11 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/allwinner/Makefile             |   2 +
 .../sun50i-h616-bigtreetech-cb1-manta.dts          |  35 ++++++
 .../dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi | 138 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h616-bigtreetech-pi.dts   |  63 ++++++++++
 6 files changed, 251 insertions(+)
---
base-commit: cc19c78b3b3f1af285182dd800a3def22227f9a2
change-id: 20230814-b4-cb1-4b18801ecf6e

Best regards,
-- 
Martin Botka <martin.botka@somainline.org>

