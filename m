Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ECD7E343A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjKGDeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGDeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:34:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5EF101;
        Mon,  6 Nov 2023 19:34:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EDFC433CA;
        Tue,  7 Nov 2023 03:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699328060;
        bh=OfweZHB38AdNXn/P8vLctkJkhs9Vuna2g2+KNYU6ofk=;
        h=From:To:Cc:Subject:Date:From;
        b=nvqEa2lI211kU+e02t/9TDVvEpVkU5DPhNOE0cr2Kn26tQcCKQ/OY7ySRLPDahfgy
         4XOKMkAGAaa/gGdIWJgvQmSQlNzQREUSiLFZf8k6UeO20mj0spqObaWkgrCH537hCv
         n9lJ8wS0YkmJWQvhCFZDq+3iFGjiCI8MDDhxkST+x4qbdWAI1bTtbDFhr61tEDjyY+
         Sa9g4KuNMDh5PmkUrnltjF4bHIYT8f04oengNRaDvSFC3wzz/luCr9vXsHT2i04XF4
         hQvxUwYxBBbkSL9T16vLbcK8thkOLvkcgQEBRcNoaGATesXxjDRoR2HEbP6CvzGliN
         dq4v43H7YkbQw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>,
        Tanmay Shah <tanmay.shah@amd.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL] remoteproc updates for v6.7
Date:   Mon,  6 Nov 2023 19:38:20 -0800
Message-ID: <20231107033821.2563960-1-andersson@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.7

for you to fetch changes up to 3d8a18697ad834436d088d65cc66165947cfe600:

  remoteproc: st: Fix sometimes uninitialized ret in st_rproc_probe() (2023-10-16 11:24:34 -0600)

----------------------------------------------------------------
remoteproc updates for v6.7

Support for controlling the second core in Mediatek's SCP dual-core
setup is introduced.

Support for audio, compute and modem DSPs on Qualcomm SM6375, and the
audio DSP in SC7180 are introduced. The peripheral NoC clock is
dropped from MSM8996 modem DSP, as this is handled through the
interconnect provider.

In the zynqmp driver the setup for TCM memory, and device address
translation thereof, when operating in lockstep mode is corrected.

A few bug fixes and cleanups are introduces across the ST and STM32
remoteproc drivers.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      remoteproc: mediatek: Refactor single core check and fix retrocompatibility

Chen Jiahao (1):
      remoteproc: stm32: Clean up redundant dev_err_probe()

Konrad Dybcio (6):
      dt-bindings: remoteproc: qcom,sm6375-pas: Document remoteprocs
      remoteproc: qcom: pas: Add SM6375 ADSP & CDSP
      remoteproc: qcom: pas: Add SM6375 MPSS
      dt-bindings: remoteproc: qcom,adsp: Remove AGGRE2 clock
      dt-bindings: remoteproc: qcom,msm8996-mss-pil: Remove PNoC clock
      remoteproc: qcom: q6v5-mss: Remove PNoC clock from 8996 MSS

MD Danish Anwar (1):
      dt-bindings: remoteproc: pru: Add Interrupt property

Nathan Chancellor (1):
      remoteproc: st: Fix sometimes uninitialized ret in st_rproc_probe()

Nikita Travkin (2):
      dt-bindings: remoteproc: qcom: sc7180-pas: Add ADSP compatible
      remoteproc: qcom: pas: Add sc7180 adsp

Rob Herring (1):
      remoteproc: st: Use device_get_match_data()

Tanmay Shah (2):
      remoteproc: zynqmp: fix TCM carveouts in lockstep mode
      remoteproc: zynqmp: Change tcm address translation method

Tinghan Shen (13):
      dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode definition
      dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
      remoteproc: mediatek: Add MT8195 SCP core 1 operations
      remoteproc: mediatek: Extract SCP common registers
      remoteproc: mediatek: Revise SCP rproc initialization flow for multi-core SCP
      remoteproc: mediatek: Probe SCP cluster on single-core SCP
      remoteproc: mediatek: Probe SCP cluster on multi-core SCP
      remoteproc: mediatek: Remove dependency of MT8195 SCP L2TCM power control on dual-core SCP
      remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
      remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
      remoteproc: mediatek: Report watchdog crash to all cores
      remoteproc: mediatek: Refine ipi handler error message
      arm64: dts: mediatek: Update the node name of SCP rpmsg subnode

 .../devicetree/bindings/remoteproc/mtk,scp.yaml    | 176 ++++++-
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |  20 +-
 .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |   2 -
 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |  81 +++-
 .../bindings/remoteproc/qcom,sm6375-pas.yaml       | 145 ++++++
 .../bindings/remoteproc/ti,pru-rproc.yaml          |  23 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   2 +-
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi   |   2 +-
 drivers/remoteproc/mtk_common.h                    |  39 +-
 drivers/remoteproc/mtk_scp.c                       | 536 ++++++++++++++++-----
 drivers/remoteproc/mtk_scp_ipi.c                   |   4 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |   1 -
 drivers/remoteproc/qcom_q6v5_pas.c                 |  19 +
 drivers/remoteproc/st_remoteproc.c                 |  16 +-
 drivers/remoteproc/stm32_rproc.c                   |   4 +-
 drivers/remoteproc/xlnx_r5_remoteproc.c            | 110 ++---
 16 files changed, 932 insertions(+), 248 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6375-pas.yaml
