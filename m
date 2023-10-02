Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF57B4D68
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjJBIoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:44:06 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9BDA4;
        Mon,  2 Oct 2023 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1696236244; x=1727772244;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=b+aTORcVWyPRU0e0zfa5AhazdfQSs5Ixw/y30Fq9c/k=;
  b=azHPzlKKmricxigaSDW+sy64MxwgctDlN3oUUK1TZR1Tl7gd9+6/uA1p
   O56ybSSR5oXr4kKQGeOUVVMyBsd7ratKOp3YbvbGP2Ln53BSytIV08dgF
   /wgfmQ9tDv9jErJp8jCpGfbwJvT4ml7YfqQ5tOIKqJItCrFdIib2tYfSA
   tWzE8uwutH/GogW6mCs3fI6+lGYkyn04OzQeZS3gUNvzynkXfSrStJkle
   +cN4CTKOINRpIM6BGoBT2U4Skb8TJOymvDNQ344MUaujyzAV5IydJVu7O
   vjrtsLMt62pIrAFHeVjG4QPqJQkmgxO8z87VyO5R3JxCEivJj/aRsg9da
   w==;
X-IronPort-AV: E=Sophos;i="6.03,193,1694728800"; 
   d="scan'208";a="33241245"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Oct 2023 10:43:59 +0200
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 47330280075;
        Mon,  2 Oct 2023 10:43:59 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH v3 0/5] TQMLS10xxA support
Date:   Mon, 02 Oct 2023 10:43:49 +0200
Message-Id: <20231002-for-ml-tqmls10xxa-v2-test-v3-0-402819b9a29b@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMWCGmUC/42Oyw6CMBBFf4V07ZB2yktX/odxAThAE7AwLYgx/
 LuVlYkbVzfnJnPmvoQjNuTEKXoJpsU4Y+8B9CESdVfeWwJzCyxQopYFHqGxDEMPfhp6p+S6lrA
 geHIeEtJZUutGY1aLcD8yNWbd3Zdr4IbtAL5jKr+NWqE8phhrleeJBAUtU2s57oirmVviMz1iP
 4XazmNc2+Gj7ozzlp/76gU/D/4ZGFJCpW5lpvMirTD9UV+3bXsDY0rtWxMBAAA=
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696236239; l=2439;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=d86vdRWS6AL82dK3Ppi+XcM9V7N57f3lq2Dzdgdt1HQ=;
 b=a5j5dv7/sOIamoa4qrcVjYmiwfV4QIAawCCxUuZGUklZZlGHnq24vcs7cp7tcxHA2JCgg1TJa
 aIdYE0A+d2iBZ/t+SmkmlBwROSSwAvseYjqninlQFuvprIycrZyBFbe
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds initial support for the TQMLS1043A, TQMLS1046A and
TQMLS1088A SoM on the MBLS10xxA baseboard. These three modules share a
common layout and a common baseboard.

Patch 1 removes an non-existing spi controller
Patch 2 and 4 add the compatible to dt bindings
Patch 3 and 5 add the .dts[i] files for SoMs and baseboard

Changes in v3:
- reordered aliases alphabetically
- squashed MAINTAINERS patch into dts patch
- rebased to next-20230929
- Link to v2: https://lore.kernel.org/r/20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com

Changes in v2:
- Added Acked-Bys from Conor Dooley
- Renamed gpio nodes
- Removed trailing empty line

Best regards
Gregor

---
Gregor Herburger (5):
      arm64: dts: ls1043a: remove second dspi node
      dt-bindings: arm: fsl: Add TQ-Systems LS1043A/LS1046A based boards
      arm64: dts: freescale: add initial device tree for TQMLS1043A/TQMLS1046A
      dt-bindings: arm: fsl: Add TQ-Systems LS1088 based boards
      arm64: dts: freescale: add initial device tree for TQMLS1088A

 Documentation/devicetree/bindings/arm/fsl.yaml     |  21 +++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts |  49 +++++++
 .../boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi |  32 +++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  14 --
 .../freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts |  56 ++++++++
 .../boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi |  42 ++++++
 .../freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dts |  64 +++++++++
 .../boot/dts/freescale/fsl-ls1088a-tqmls1088a.dtsi |  43 ++++++
 .../dts/freescale/tqmls104xa-mbls10xxa-fman.dtsi   | 104 +++++++++++++++
 .../dts/freescale/tqmls1088a-mbls10xxa-mc.dtsi     | 146 +++++++++++++++++++++
 .../boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi   | 136 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi      |  58 ++++++++
 14 files changed, 756 insertions(+), 14 deletions(-)
---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230829-for-ml-tqmls10xxa-v2-test-4e364c3f326c

Best regards,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

