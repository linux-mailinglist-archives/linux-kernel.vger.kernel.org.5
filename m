Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933A0807183
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378784AbjLFOBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378760AbjLFOBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:01:11 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629ED181;
        Wed,  6 Dec 2023 06:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1701871276; x=1733407276;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=5Ojpykwp5n32ovbWNydkDxf3PhvVwsu4WWztxh/jFRw=;
  b=Ijs/uQ4zG1bQszD3MlfEKmrGZdRuhqoPC+Qfcwcp0+E4KAvckEWvefuU
   z5b135Rl8Dfp2RHTXT4mPECGSG0Y+Ss59euTYYybUugGWdGuoV6Tz9fxx
   htbZE0N6KMI/0OcYzJnHPq/YbrbCpsFmzmLAmebA6MgDAG9XMD993oflV
   SU2mOqg+BDw6pFqmeOvuUk0LNFQ7zAVb2JiWGRcmaollvhn7tlPAZt3a4
   sR/iJKeSDhaO3g/on/JaPy8Am9ru2PULYNjBM0AnVZJ7DyNKtasDUIztl
   dUnYtK661WGSvjTxtn3vu9qeuoBlQnZWVqmJQ4R9fAefnyggDwguynH1H
   A==;
X-IronPort-AV: E=Sophos;i="6.04,255,1695679200"; 
   d="scan'208";a="34361963"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Dec 2023 15:01:11 +0100
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id ADD45280075;
        Wed,  6 Dec 2023 15:01:11 +0100 (CET)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH 0/2] TQMLX2160A support
Date:   Wed, 06 Dec 2023 15:01:00 +0100
Message-Id: <20231206-for-ml-tqmlx2160a-v1-0-622e41ae4d8e@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJx+cGUC/x3MTQqAIBBA4avErBvQiSy6SrSQGmugX40QwrsnL
 b/Fey8E9sIBuuIFz48EOfYMXRYwLnafGWXKBlJUaVIG3eFxW/G+tjWSNsqiaZmpql2jxwlyd3p
 2Ev9nP6T0AQqiErZjAAAA
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701871271; l=1357;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=30w689X+AivyuyJWGuS58hCBzyRFRC9wW8+XkL3J6yM=;
 b=/lxbtoCvkTi+jEwVHgxKrx9jtr2/yzaPS7UdPM7Gu3+ZHdcTafW0adFgEoNBUP3h8kJpPS5mG
 3gmMI4aus6NBtJFJ5JAY06tDZEy6f87fU74oaI08pKYyrkH+xHEj46W
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds initial support for the TQMLX2160A SoM on MBLX2160a
baseboard. The various supported Serdes Configurations are added with
overlay files.

Patch 1 adds the compatible to dt bindings
Patch 2 adds the dts files

---
Gregor Herburger (2):
      dt-bindings: arm: fsl: Add TQ-Systems LX2160A based boards
      arm64: dts: freescale: add fsl-lx2160a-mblx2160a board

 Documentation/devicetree/bindings/arm/fsl.yaml     |  10 +
 arch/arm64/boot/dts/freescale/Makefile             |  26 ++
 .../freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts | 338 +++++++++++++++++++++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_12_x_x.dtso   |  29 ++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_14_x_x.dtso   |  17 ++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_x_11_x.dtso   |  49 +++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_x_7_x.dtso    |  55 ++++
 .../fsl-lx2160a-tqmlx2160a-mblx2160a_x_8_x.dtso    |  47 +++
 .../boot/dts/freescale/fsl-lx2160a-tqmlx2160a.dtsi |  97 ++++++
 9 files changed, 668 insertions(+)
---
base-commit: 8728c14129df7a6e29188a2e737b4774fb200953
change-id: 20231206-for-ml-tqmlx2160a-68ee235f71cd

Best regards,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

