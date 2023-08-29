Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4976E78C171
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjH2J2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjH2J2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:28:44 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D75CD6;
        Tue, 29 Aug 2023 02:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1693301303; x=1724837303;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=oR18gqbTGntlwPw9/wAxCHkLHeBRWa5x5JbbRS67xn4=;
  b=Bn4UP9zJzBMasCkXJoaH7nDQEa8xQu+zM3HDvoglZUG29KuuYeA3Hafb
   cMHlT5YIW89CrxG+TmwifzJdizJQNe3M7gBiVyii48N1e4ohyafZnubWH
   pK1cEGmPsMEB8BgILkGbHKSaJr04HHTvjO9dRP+wvEgpfqzBsWRHA8uqc
   g0gv8el4oWXd3xQvmrJrTuFVpJ4qjC6VhqQExTI7NTXpgN41GKWnsHkvM
   vQ3r+XQ8o3u4bkNFfxgILaZRamX+meSL0/NSIhORROA8EaU+gWsLUK4vQ
   aCUctPMXPIPHTwaGZBZhBnQJKlumI+92nSYmIT5MVBGZD7BGwBGvvkAWB
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688421600"; 
   d="scan'208";a="32672402"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Aug 2023 11:27:24 +0200
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id BCC5E280045;
        Tue, 29 Aug 2023 11:27:24 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH v2 0/6] TQMLS10xxA support
Date:   Tue, 29 Aug 2023 11:26:56 +0200
Message-Id: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOG57WQC/03MSw6CMBSF4a2Yjr1NHwjiyH0YB1hvSxNK4bYgC
 WHvNo4cfic5/84SksfEbqedEa4++TgWqPOJmb4bHYJ/FzMllBZX1YKNBGGAPIchSbFtHawKMqY
 MFeq6MtpqVRtW/hOh9duv/XgWW4oBck/Y/Re1VKK9KK5l01QCJDhCF4n3SK+FHNIdPzzPZY7Lx
 E0M7Di+VLo1tbYAAAA=
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693301244; l=4299;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=/3+07m1E9mC0z011exs+lEyD7vLyMc7cRpsybcg8uaI=;
 b=i1oGr3SiF3m1LHRxMq+7VDYQfzoMhUiZhLhOEwgsJmdv24UZcWvycXev6ELWXeBs0XDiQMzw5
 MhletYqTfKSAPnFcmmZ7L5u7hhqzgyUc9h6BaMdSJRf3HK9mFoTogW2
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Patch 2 and 4 add the the compatible to dt bindings
Patch 3 and 5 add the .dts[i] files for SoMs and baseboard
Patch 6 updates MAINTAINERS

Changes in v2:
* Added Acked-Bys from Conor Dooley
* Renamed gpio nodes
* Removed trailing empty line

Best regards
Gregor

Gregor Herburger (6):
  arm64: dts: ls1043a: remove second dspi node
  dt-bindings: arm: fsl: Add TQ-Systems LS1043A/LS1046A based boards
  arm64: dts: freescale: add initial device tree for
    TQMLS1043A/TQMLS1046A
  dt-bindings: arm: fsl: Add TQ-Systems LS1088 based boards
  arm64: dts: freescale: add initial device tree for TQMLS1088A
  MAINTAINERS: add tqml device trees to TQ-Systems entry

 .../devicetree/bindings/arm/fsl.yaml          |  21 +++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   3 +
 .../fsl-ls1043a-tqmls1043a-mbls10xxa.dts      |  49 ++++++
 .../dts/freescale/fsl-ls1043a-tqmls1043a.dtsi |  32 ++++
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  14 --
 .../fsl-ls1046a-tqmls1046a-mbls10xxa.dts      |  56 +++++++
 .../dts/freescale/fsl-ls1046a-tqmls1046a.dtsi |  42 +++++
 .../fsl-ls1088a-tqmls1088a-mbls10xxa.dts      |  64 ++++++++
 .../dts/freescale/fsl-ls1088a-tqmls1088a.dtsi |  43 ++++++
 .../freescale/tqmls104xa-mbls10xxa-fman.dtsi  | 104 +++++++++++++
 .../freescale/tqmls1088a-mbls10xxa-mc.dtsi    | 146 ++++++++++++++++++
 .../dts/freescale/tqmls10xxa-mbls10xxa.dtsi   | 136 ++++++++++++++++
 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi |  59 +++++++
 14 files changed, 757 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls104xa-mbls10xxa-fman.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls1088a-mbls10xxa-mc.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi

--
2.34.1

---
Gregor Herburger (6):
      arm64: dts: ls1043a: remove second dspi node
      dt-bindings: arm: fsl: Add TQ-Systems LS1043A/LS1046A based boards
      arm64: dts: freescale: add initial device tree for TQMLS1043A/TQMLS1046A
      dt-bindings: arm: fsl: Add TQ-Systems LS1088 based boards
      arm64: dts: freescale: add initial device tree for TQMLS1088A
      MAINTAINERS: add tqml device trees to TQ-Systems entry

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
base-commit: 47d9bb711707d15b19fad18c8e2b4b027a264a3a
change-id: 20230829-for-ml-tqmls10xxa-v2-test-4e364c3f326c

Best regards,
-- 
Gregor Herburger <gregor.herburger@ew.tq-group.com>

