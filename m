Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC9791B30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353301AbjIDQOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjIDQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:14:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157709D;
        Mon,  4 Sep 2023 09:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E422B80DB3;
        Mon,  4 Sep 2023 16:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3009C433CD;
        Mon,  4 Sep 2023 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693844044;
        bh=XZLlMsqp967+lb+1ZSRH4MYxUufjgFUQchIzouq7qEk=;
        h=From:To:Cc:Subject:Date:From;
        b=a+8l/MfCyM2HRm4w/+2Sf0ABYtIrmE4BBImCeD7qOdNkqUiiCGJjIISzjdDRwVpES
         La7DGWaqyrt2cuHLs16qMJV2zCUrZzW2gUwNMtxR1LQo+Fr5dlpPca5wDY7HGqwuyJ
         Z2SjUpbvETvTBlN1ZOSOBs5snb5D1RtQUF8EjJkfVGOXyJ8f2ybq6TIqzw6BOq9PTN
         xJQyyQL8muqfA6xMYX2MwcG8tf7aWmjWPYR7OJhJ8DQIL3jgHfnbW21hUhBia4PiDv
         Q6Cjd0c/BBQPClZ1mrSrCREZs8tHk0gTLkrhjT4TxXsrzbTEABPYe/GhYCr8LU6B1J
         DxNHFkzz/miow==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] remoteproc updates for v6.6
Date:   Mon,  4 Sep 2023 09:16:19 -0700
Message-ID: <20230904161621.2954993-1-andersson@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.6

for you to fetch changes up to 18cf4fcd7bdc1864e75127f4fd15abc0bc76ec7f:

  remoteproc: pru: add support for configuring GPMUX based on client setup (2023-08-21 15:19:28 -0600)

----------------------------------------------------------------
remoteproc updates for v6.6

Support for booting the iMX remoteprocs using MMIO, instead of SMCCC is
added. The iMX driver is also extended to support delivering interrupts
from an arbitrary number of vdev.

Support is added to the TI PRU driver, to allow GPMUX to be controlled
from DeviceTree.

The Qualcomm coredump collector is extended to fall back to generating a
full coredump, in the case that the loaded firmware doesn't support
generating minidump. The overly terse MD abbreviation of "MINIDUMP" is
expanded, to make the code easier on the eye.

The list of Qualcomm Sensor Low Power Island (SLPI) instances supported
is cleaned up, and SDM845 is added. SDM630/636/660 support for the modem
subsystem (mss) is added.

All the Qualcomm drivers are transitioned to of_reserved_mem_lookup()
instead of open coding the resolution of reserved-memory regions, to
gain handling of error cases. A couple of drivers are transitioned to
use devm_platform_ioremap_resource_byname().

The stm32 remoteproc driver's PM operations are updated to modern
macros, to avoid the "unused variable"-warning in some configurations.

Drivers are transitioned away from directly including of_device.h.

----------------------------------------------------------------
Alexey Minnekhanov (2):
      dt-bindings: remoteproc: qcom,msm8996-mss-pil: Add SDM660 compatible
      remoteproc: qcom: q6v5-mss: Add support for SDM630/636/660

Arnd Bergmann (1):
      remoteproc: stm32: fix incorrect optional pointers

Dylan Van Assche (3):
      dt-bindings: remoteproc: qcom: adsp: add qcom,sdm845-slpi-pas compatible
      remoteproc: qcom: pas: refactor SLPI remoteproc init
      remoteproc: qcom: pas: add SDM845 SLPI compatible

Konrad Dybcio (2):
      dt-bindings: remoteproc: qcom: sm6115-pas: Add QCM2290
      dt-bindings: remoteproc: qcom,msm8996-mss-pil: Fix 8996 clocks

Krzysztof Kozlowski (4):
      dt-bindings: remoteproc: qcom,pas: correct memory-region constraints
      dt-bindings: remoteproc: qcom,sm6115-pas: correct memory-region constraints
      dt-bindings: remoteproc: qcom,sm8550-pas: require memory-region
      dt-bindings: remoteproc: qcom,adsp: bring back firmware-name

Marek Vasut (2):
      dt-bindings: remoteproc: imx_rproc: Support i.MX8MN/P MMIO
      remoteproc: imx_rproc: Switch iMX8MN/MP from SMCCC to MMIO

Mukesh Ojha (1):
      remoteproc: qcom: Expand MD_* as MINIDUMP_*

Peng Fan (1):
      remoteproc: imx_rproc: iterate all notifiyids in rx callback

Rob Herring (1):
      remoteproc: Explicitly include correct DT includes

Siddharth Gupta (2):
      remoteproc: core: Export the rproc coredump APIs
      remoteproc: qcom: Add full coredump fallback mechanism

Stephan Gerhold (1):
      remoteproc: qcom: Use of_reserved_mem_lookup()

Tero Kristo (1):
      remoteproc: pru: add support for configuring GPMUX based on client setup

Ye Xingchen (2):
      remoteproc: qcom: q6v5: use devm_platform_ioremap_resource_byname()
      remoteproc: qcom: wcnss: use devm_platform_ioremap_resource_byname()

 .../bindings/remoteproc/fsl,imx-rproc.yaml         |  20 ++++
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |  24 +++++
 .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  12 ++-
 .../bindings/remoteproc/qcom,pas-common.yaml       |   1 -
 .../bindings/remoteproc/qcom,qcs404-pas.yaml       |   3 +-
 .../bindings/remoteproc/qcom,sc7180-pas.yaml       |   3 +-
 .../bindings/remoteproc/qcom,sc8180x-pas.yaml      |   3 +-
 .../bindings/remoteproc/qcom,sc8280xp-pas.yaml     |   3 +-
 .../bindings/remoteproc/qcom,sdx55-pas.yaml        |   3 +-
 .../bindings/remoteproc/qcom,sm6115-pas.yaml       |  39 +++++---
 .../bindings/remoteproc/qcom,sm6350-pas.yaml       |   3 +-
 .../bindings/remoteproc/qcom,sm8150-pas.yaml       |   3 +-
 .../bindings/remoteproc/qcom,sm8350-pas.yaml       |   3 +-
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       |   1 +
 drivers/remoteproc/imx_dsp_rproc.c                 |   3 +-
 drivers/remoteproc/imx_rproc.c                     |  73 ++++++++++++++-
 drivers/remoteproc/imx_rproc.h                     |   2 +
 drivers/remoteproc/omap_remoteproc.c               |   3 +-
 drivers/remoteproc/pru_rproc.c                     |  25 ++++-
 drivers/remoteproc/qcom_common.c                   |  21 +++--
 drivers/remoteproc/qcom_q6v5_adsp.c                |  26 +++---
 drivers/remoteproc/qcom_q6v5_mss.c                 |  87 ++++++++++++++----
 drivers/remoteproc/qcom_q6v5_pas.c                 | 102 ++++++++-------------
 drivers/remoteproc/qcom_q6v5_wcss.c                |   3 +-
 drivers/remoteproc/qcom_sysmon.c                   |   1 -
 drivers/remoteproc/qcom_wcnss.c                    |  30 +++---
 drivers/remoteproc/qcom_wcnss_iris.c               |   1 +
 drivers/remoteproc/rcar_rproc.c                    |   3 +-
 drivers/remoteproc/remoteproc_coredump.c           |   2 +
 drivers/remoteproc/remoteproc_internal.h           |   4 -
 drivers/remoteproc/st_slim_rproc.c                 |   1 -
 drivers/remoteproc/stm32_rproc.c                   |  16 ++--
 drivers/remoteproc/ti_k3_dsp_remoteproc.c          |   2 +-
 drivers/remoteproc/ti_k3_r5_remoteproc.c           |   3 +-
 drivers/remoteproc/wkup_m3_rproc.c                 |   2 +-
 include/linux/remoteproc.h                         |   4 +
 36 files changed, 362 insertions(+), 173 deletions(-)
