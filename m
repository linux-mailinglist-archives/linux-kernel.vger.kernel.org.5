Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF978CEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjH2Vuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjH2VuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:50:15 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B112CC0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:50:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4C9D3320085B;
        Tue, 29 Aug 2023 17:50:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 29 Aug 2023 17:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1693345808; x=1693432208; bh=UmsBQCnIHuzr9LYbdxJzJ1dAW6mrMdRefDT
        kAxa0J5E=; b=adwPQT+ulJEKiJChPccDU128xRbknqVxX58jSGP6Z/1EsLSC5XL
        p/KESy/GsrcQJvn0jBtQv432JfKeV0xv8XMww/daFxFI2HxhVmkqAa0S3p1QZ9af
        CfOOFK/mM+eMXhcoASc692tFlom3m0+9fdVxTryx8DQ12lFjRRpZRJ88RPPuWiCR
        vJA48PfyFVNPpi95pKLmwrIY0kC9V56+BY9kxHBp3OC10vUFm6mXHfmrgxLaXMpK
        rECES0t0459dzUpQqrPwxmbsHE5E/HBocR2ocmqwWFWm5ybyvTCZ6okUPPPFDRdW
        ROkqNzyE5YuDsbxawMnU54mBdJwc7xKtU7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693345808; x=1693432208; bh=UmsBQCnIHuzr9LYbdxJzJ1dAW6mrMdRefDT
        kAxa0J5E=; b=Oke8VVHQaSmii4uHtj8HYSz5kSPl2rtSVgaw6IlzYH0ne4kiRXH
        pWCsVpFhCAr15sUA+V0I/gQF3aDqDXnlKe65XNGScJXyRBBrlhfyBro2B1HARLtc
        dzYE2pGWRRoqaiDNiWBYojhLBpHCGDecN14U0TU/ZCFLw4N+tw4gf6YYQXvNotI4
        74L8GfLoKu+V+NI2zytBlWE7QcsCM0HlFvxUEnZC1jP2o3RqSyowFnPeE9Mxjru9
        6Cm92TWK2nQM/QBIFgV/o7SnC5HheTZxE6A16b0YZ/O6/Cs5ZrZ01P4AVfUIRG9G
        1aM5xfBp6/4j4vw4VYU+uWU9dmRziK9QO6g==
X-ME-Sender: <xms:EGjuZKd1UhUDAn7Q1TddTyDzQxKVDO2ufzhvJZYEVK8Z9DnLXSMVNg>
    <xme:EGjuZEM-urlUg1GOAwKnA86MvGbWZ1y3VwDXlr338HucfsrlbwAVLC32V1YbUQjcP
    keeSU7Spr0Xyhd5ZQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefjecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepgfelgeeuvddvkeethfdugfdtheegtefgfeejueeklefhleelteefhfefuefffffh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdhpvghngh
    huthhrohhnihigrdguvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:EGjuZLgMYd83nXlpEAB5QA4sizBEdNZRfatPK82TWQre6lKm0q56FQ>
    <xmx:EGjuZH8mQ9yga6Di68tCjoODzUGB5Ljv1zV5J6qMBVn5_y9kPyWRrg>
    <xmx:EGjuZGtChfgc-r7Cg6U1LBy1AwNPpuGrO5aSWO7ujVH53JH0fJpujA>
    <xmx:EGjuZLXiQqZM1XxVFOGFv5LQRw0hFXTJb16WR8xMge0SwZR0-fB0LQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7F363B60089; Tue, 29 Aug 2023 17:50:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <a5236f8b-4a4f-422b-97c2-7691e2aa1468@app.fastmail.com>
In-Reply-To: <4f60d13e-f060-491a-88c7-6f25323a48f8@app.fastmail.com>
References: <4f60d13e-f060-491a-88c7-6f25323a48f8@app.fastmail.com>
Date:   Tue, 29 Aug 2023 17:49:32 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [GIT PULL 1/4] ARM: SoC drivers for 6.6
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b5=
74c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.6

for you to fetch changes up to 09959520d2b0853a16962d245acfdc995d1b0da9:

  bus: fsl-mc: Use common ranges functions (2023-08-29 16:02:00 -0400)

----------------------------------------------------------------
ARM: SoC drivers for 6.6

The main change this time is the introduction of the drivers/genpd
subsystem that gets split out from drivers/soc to keep common
functionality together. Ulf Hansson is taking over maintainership for
these and is sending a separate pull request with the same commits,
but they are in the soc drivers tree to avoid conflicts against other
soc driver patches.

The SCMI driver subsystem gets an update to version 3.2 of the
specification. There are also updates to memory, reset and other firmware
drivers.

On the soc driver side, the updates are mostly cleanups across a number
of Arm platforms. On driver for loongarch adds power management for DT
based systems, another driver is for HiSilicon's Arm server chips with
their HCCS system health interface.

The remaining updates for the most part add support for additional
hardware in existing drivers or contain minor cleanups. Most of these
are for the Qualcomm Snapdragon platform.

----------------------------------------------------------------
Alexander Stein (1):
      soc: imx: imx93-blk-ctrl: Add dedicated lockdep class for nested g=
enpd locks

Andrei Coardos (10):
      reset: ath79: remove unneeded call to platform_set_drvdata()
      reset: bcm6345: remove unneeded call to platform_set_drvdata()
      reset: lantiq: remove unneeded call to platform_set_drvdata()
      reset: lpc18xx: remove unneeded call to platform_set_drvdata()
      reset: meson: remove unneeded call to platform_set_drvdata()
      reset: npcm: remove unneeded call to platform_set_drvdata()
      reset: uniphier-glue: remove unneeded call to platform_set_drvdata=
()
      reset: zynq: remove unneeded call to platfrom_set_drvdata()
      reset: zynqmp: removed unneeded call to platform_set_drvdata()
      reset: ti: syscon: remove unneeded call to platform_set_drvdata()

Arnd Bergmann (23):
      Merge branch 'genpd_create_dir' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/ulfh/linux-pm into soc/drivers
      soc: starfive: remove stale Makefile entry
      genpd: move owl-sps-helper.c from drivers/soc
      Merge branch 'drivers/genpd' into soc/drivers
      Merge tag 'tegra-for-6.6-soc' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tegra/linux into soc/drivers
      Merge tag 'zynqmp-soc-for-6.6' of https://github.com/Xilinx/linux-=
xlnx into soc/drivers
      Merge tag 'vexpress-updates-6.6' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'scmi-updates-6.6' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.6' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'sunxi-drivers-for-6.6-1' of https://git.kernel.org/pub/=
scm/linux/kernel/git/sunxi/linux into soc/drivers
      Merge tag 'reset-for-v6.6' of git://git.pengutronix.de/pza/linux i=
nto soc/drivers
      Merge tag 'samsung-drivers-6.6' of https://git.kernel.org/pub/scm/=
linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'hisi-drivers-for-6.6' of https://github.com/hisilicon/l=
inux-hisi into soc/drivers
      soc: kunpeng_hccs: fix size_t format string
      soc: kunpeng_hccs: add MAILBOX dependency
      Merge tag 'imx-drivers-6.6' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/drivers
      Merge tag 'oxnas-final-for-6.6' of https://git.kernel.org/pub/scm/=
linux/kernel/git/narmstrong/linux-oxnas into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.6' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.6' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'v6.6-rockchip-drivers1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/drivers
      Merge tag 'qcom-drivers-for-6.6' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'omap-for-v6.6/ti-sysc-signed' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/tmlind/linux-omap into soc/drivers
      Merge tag 'arm-soc/for-6.6/drivers' of https://github.com/Broadcom=
/stblinux into soc/drivers

Bjorn Andersson (7):
      soc: qcom: cmd-db: Drop NUL bytes from debugfs output
      soc: qcom: rpmh-rsc: Include state in trace event
      Merge branch '1689744162-9421-2-git-send-email-quic_rohiagar@quici=
nc.com' into drivers-for-6.6
      Merge branch 'genpd_create_dir' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/ulfh/linux-pm into drivers-for-6.6
      soc: qcom: aoss: Move length requirements from caller
      soc: qcom: aoss: Format string in qmp_send()
      soc: qcom: aoss: Tidy up qmp_send() callers

Chen Jiahao (1):
      soc: qcom: smem: Fix incompatible types in comparison

Chris Lew (1):
      soc: qcom: qmi_encdec: Restrict string length in decode

Christophe JAILLET (1):
      soc: qcom: smem: Use struct_size()

Cristian Marussi (2):
      firmware: arm_scmi: Harden perf domain info access
      firmware: arm_scmi: Add v3.2 perf level indexing mode support

David Wronek (2):
      dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
      soc: qcom: socinfo: Add SoC ID for SM7125

Dong Aisheng (2):
      firmware: imx: scu: change init level to subsys_initcall_sync
      firmware: imx: scu: increase RPC timeout

Gokul krishna Krishnakumar (1):
      dt-bindings: firmware: qcom: scm: Updating VMID list

Guru Das Srinagesh (2):
      firmware: qcom_scm: Convert all symbols to EXPORT_SYMBOL_GPL
      firmware: qcom_scm: Add missing extern specifier

Huisong Li (4):
      soc: hisilicon: Support HCCS driver on Kunpeng SoC
      soc: hisilicon: add sysfs entry to query information of HCCS
      doc: soc: hisilicon: Add Kunpeng HCCS driver documentation
      soc: kunpeng_hccs: fix some sparse warnings about incorrect type

Jagan Teki (1):
      genpd: rockchip: Add PD_VO entry for rv1126

Jayesh Choudhary (1):
      soc: ti: k3-ringacc: remove non-fatal probe deferral log

Jiapeng Chong (1):
      soc/tegra: cbb: Remove unnecessary print function dev_err()

Kathiravan T (2):
      soc: qcom: socinfo: drop the IPQ5019 SoC ID
      dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC ID

Konrad Dybcio (7):
      soc: qcom: icc-bwmon: Set default thresholds dynamically
      soc: qcom: rpmpd: Add sync_state
      dt-bindings: firmware: qcom,scm: Allow interconnect on SC8280XP
      dt-bindings: arm: msm: kpss-acc: Make the optional reg truly optio=
nal
      firmware: qcom_scm: Always try to consume all three clocks
      firmware: qcom_scm: Always return devm_clk_get_optional errors
      firmware: qcom_scm: Drop useless compatibles

Krzysztof Kozlowski (6):
      MAINTAINERS: samsung: Un-support cpuidle and clock drivers
      dt-bindings: memory-controllers: ingenic,nemc: reference periphera=
l properties
      dt-bindings: memory-controllers: reference TI GPMC peripheral prop=
erties
      dt-bindings: net: davicom,dm9000: convert to DT schema
      dt-bindings: arm: msm: kpss-acc: Revert "dt-bindings: arm: msm: kp=
ss-acc: Make the optional reg truly optional"
      MAINTAINERS: mfd: Un-support Maxim and Samsung PMIC drivers

Luca Weiss (5):
      soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
      soc: qcom: ocmem: Use dev_err_probe where appropriate
      soc: qcom: ocmem: make iface clock optional
      dt-bindings: sram: qcom,ocmem: Add msm8226 support
      soc: qcom: ocmem: Add support for msm8226

Martin Kaiser (1):
      bus: imx-weim: use devm_platform_ioremap_resource

Neil Armstrong (7):
      Merge tag 'genpd-v6.5-rc1-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/ulfh/linux-pm into v6.6/drivers-genpd
      soc: qcom: pmic_glink_altmode: handle safe mode when disconnect
      soc: qcom: pmic_glink_altmode: add retimer-switch support
      soc: qcom: pmic_glink: enable altmode for SM8550
      irqchip: irq-versatile-fpga: remove obsolete oxnas compatible
      dt-bindings: interrupt-controller: arm,versatile-fpga-irq: mark ox=
nas compatible as deprecated
      MAINTAINERS: remove OXNAS entry

Nishanth Menon (3):
      firmware: ti_sci: Use system_state to determine polling
      firmware: ti_sci: Fixup documentation errors
      soc: ti: k3-ringacc: Fixup documentation errors

Ondrej Jirman (1):
      soc: rockchip: grf: Fix SDMMC not working on RK3588 with bus-width=
 > 1

Peng Fan (5):
      genpd: Makefile: build imx
      firmware: imx: scu: use soc name for soc_id
      firmware: imx: scu: use EOPNOTSUPP
      firmware: imx: scu-irq: add imx_scu_irq_get_status
      firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP

Piyush Mehta (2):
      dt-bindings: reset: Updated binding for Versal-NET reset driver
      reset: reset-zynqmp: add support for Versal NET platform

Ranjani Vaidyanathan (1):
      firmware: imx: scu-irq: support identifying SCU wakeup source from=
 sysfs

Rob Herring (12):
      soc: qcom: Explicitly include correct DT includes
      soc: imx: Explicitly include correct DT includes
      soc: samsung: Explicitly include correct DT includes
      soc/tegra: Explicitly include correct DT includes
      soc: ti: Explicitly include correct DT includes
      memory: Explicitly include correct DT includes
      reset: Explicitly include correct DT includes
      soc: bcm: Explicitly include correct DT includes
      soc: xilinx: Explicitly include correct DT includes
      soc: amlogic: Explicitly include correct DT includes
      soc: sunxi: Explicitly include correct DT includes
      bus: fsl-mc: Use common ranges functions

Robin Gong (1):
      firmware: imx: scu-irq: fix RCU complaint after M4 partition reset

Rohit Agarwal (5):
      dt-bindings: power: qcom,rpmhpd: Add Generic RPMh PD indexes
      soc: qcom: rpmhpd: Use the newly created generic RPMHPD bindings
      dt-bindings: power: qcom,rpmpd: Add compatible for sdx75
      soc: qcom: rpmhpd: Add SDX75 power domains
      dt-bindings: qcom: Update RPMHPD entries for some SoCs

Ruan Jinjie (1):
      soc: xilinx: Do not check for 0 return after calling platform_get_=
irq()

Sicelo A. Mhlongo (1):
      bus: omap_l3_smx: identify timeout cause before rebooting

Stephan Gerhold (9):
      dt-bindings soc: qcom: smd-rpm: Fix sort order
      dt-bindings: soc: qcom: smd-rpm: Add MSM8909 to qcom,smd-channels
      dt-bindings: soc: qcom: smd-rpm: Add some more compatibles
      soc: qcom: smd-rpm: Match rpmsg channel instead of compatible
      dt-bindings: remoteproc: glink-rpm-edge: Use "glink-edge" as node =
name
      dt-bindings: remoteproc: Add Qualcomm RPM processor/subsystem
      soc: qcom: smem: Add qcom_smem_is_available()
      rpmsg: qcom_smd: Use qcom_smem_is_available()
      soc: qcom: Add RPM processor/subsystem driver

Sudeep Holla (1):
      MAINTAINERS: Simplify entries for Arm Vexpress platform and relate=
d drivers

Sumit Gupta (5):
      memory: tegra: make icc_set_bw return zero if BWMGR not supported
      memory: tegra: sort tegra234_mc_clients table as per register offs=
ets
      memory: tegra: Add clients used by DRM in Tegra234
      memory: tegra: add check if MRQ_EMC_DVFS_LATENCY is supported
      memory: tegra: add MC client for Tegra234 GPU

Tengfei Fan (2):
      dt-bindings: arm: qcom,ids: add SoC ID for SM4450
      soc: qcom: socinfo: add SM4450 ID

Thierry Reding (3):
      memory: tegra: Add dummy implementation on Tegra194
      memory: tegra: Prefer octal over symbolic permissions
      soc/tegra: fuse: Sort includes alphabetically

Tony Lindgren (5):
      bus: ti-sysc: Fix build warning for 64-bit build
      bus: ti-sysc: Build driver for TI K3 SoCs
      bus: ti-sysc: Configure uart quirks for k3 SoC
      bus: ti-sysc: Fix a build warning with W=3D1 for sysconfig
      bus: ti-sysc: Fix cast to enum warning

Ulf Hansson (18):
      genpd: Create a new subsystem directory to host genpd providers
      soc: actions: Move power-domain driver to the genpd dir
      soc: amlogic: Move power-domain drivers to the genpd dir
      soc: apple: Move power-domain driver to the genpd dir
      soc: bcm: Move power-domain drivers to the genpd dir
      soc: imx: Move power-domain drivers to the genpd dir
      soc: mediatek: Move power-domain drivers to the genpd dir
      soc: qcom: Move power-domain drivers to the genpd dir
      soc: renesas: Move power-domain drivers to the genpd dir
      soc: rockchip: Mover power-domain driver to the genpd dir
      soc: samsung: Move power-domain driver to the genpd dir
      soc: starfive: Move the power-domain driver to the genpd dir
      soc: sunxi: Move power-domain driver to the genpd dir
      soc: tegra: Move powergate-bpmp driver to the genpd dir
      soc: ti: Mover power-domain drivers to the genpd dir
      soc: xilinx: Move power-domain driver to the genpd dir
      ARM: ux500: Convert power-domain code into a regular platform driv=
er
      ARM: ux500: Move power-domain driver to the genpd dir

Uwe Kleine-K=C3=B6nig (1):
      driver: soc: xilinx: Convert to platform remove callback returning=
 void

Vignesh Raghavendra (1):
      soc: ti: k3-socinfo.c: Add JTAG ID for AM62PX

Wang Ming (1):
      reset: hisilicon: Use dev_err_probe instead of dev_err

Xianwei Zhao (3):
      soc: amlogic: use name instead of index as criterion
      dt-bindings: power: add Amlogic C3 power domains
      soc: c3: Add support for power domains controller

Yang Yingliang (1):
      soc: qcom: ocmem: add missing clk_disable_unprepare() in ocmem_dev=
_probe()

Yangtao Li (6):
      soc: qcom: spm: Convert to devm_platform_ioremap_resource()
      bus: vexpress-config: Convert to devm_platform_ioremap_resource()
      soc/tegra: fuse: Use devm_platform_get_and_ioremap_resource()
      bus: tegra-gmi: Convert to devm_platform_ioremap_resource()
      soc: ti: omap-prm: Use devm_platform_get_and_ioremap_resource()
      bus: sunxi-rsb: Convert to devm_platform_ioremap_resource()

Yinbo Zhu (2):
      soc: dt-bindings: add loongson-2 pm
      soc: loongson2_pm: add power management support

Yuanjun Gong (1):
      soc: qcom: use devm_clk_get_enabled() in gsbi_probe()

Zhang Shurong (1):
      firmware: meson_sm: fix to avoid potential NULL pointer dereference

Zhang Zekun (1):
      soc: ti: Use devm_platform_ioremap_resource_byname simplify logic

 .../testing/sysfs-devices-platform-kunpeng_hccs    |   81 ++
 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |    4 +-
 .../bindings/clock/qcom,sm8350-videocc.yaml        |    4 +-
 .../bindings/clock/qcom,sm8450-camcc.yaml          |    4 +-
 .../bindings/clock/qcom,sm8450-dispcc.yaml         |    4 +-
 .../bindings/clock/qcom,sm8450-videocc.yaml        |    4 +-
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |    4 +-
 .../devicetree/bindings/clock/qcom,videocc.yaml    |    4 +-
 .../bindings/display/msm/qcom,sm8250-dpu.yaml      |    4 +-
 .../bindings/display/msm/qcom,sm8250-mdss.yaml     |    8 +-
 .../bindings/display/msm/qcom,sm8350-dpu.yaml      |    4 +-
 .../bindings/display/msm/qcom,sm8350-mdss.yaml     |    6 +-
 .../bindings/display/msm/qcom,sm8450-dpu.yaml      |    4 +-
 .../bindings/display/msm/qcom,sm8450-mdss.yaml     |    8 +-
 .../bindings/display/msm/qcom,sm8550-dpu.yaml      |    4 +-
 .../bindings/display/msm/qcom,sm8550-mdss.yaml     |    8 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
 .../arm,versatile-fpga-irq.txt                     |    4 +-
 .../bindings/media/qcom,sm8250-venus.yaml          |    4 +-
 .../bindings/memory-controllers/ingenic,nemc.yaml  |    1 +
 .../memory-controllers/mc-peripheral-props.yaml    |    2 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |    4 +-
 .../devicetree/bindings/net/davicom,dm9000.yaml    |   59 +
 .../devicetree/bindings/net/davicom-dm9000.txt     |   27 -
 .../bindings/power/amlogic,meson-sec-pwrc.yaml     |    3 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 .../bindings/remoteproc/qcom,glink-edge.yaml       |    3 -
 .../bindings/remoteproc/qcom,glink-rpm-edge.yaml   |    2 +-
 .../bindings/remoteproc/qcom,rpm-proc.yaml         |  171 +++
 .../bindings/remoteproc/qcom,sm8350-pas.yaml       |    6 +-
 .../bindings/reset/xlnx,zynqmp-reset.yaml          |    1 +
 .../bindings/soc/loongson/loongson,ls2k-pmc.yaml   |   52 +
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   23 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |    7 +
 .../devicetree/bindings/sram/qcom,ocmem.yaml       |   26 +-
 MAINTAINERS                                        |   65 +-
 arch/arm/mach-ux500/Makefile                       |    1 -
 arch/arm/mach-ux500/cpu-db8500.c                   |    5 -
 arch/arm/mach-ux500/pm_domains.h                   |   17 -
 drivers/Makefile                                   |    1 +
 drivers/bus/Kconfig                                |    3 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   90 +-
 drivers/bus/imx-weim.c                             |    2 +-
 drivers/bus/omap_l3_smx.c                          |   21 +-
 drivers/bus/sunxi-rsb.c                            |    4 +-
 drivers/bus/tegra-gmi.c                            |    4 +-
 drivers/bus/ti-sysc.c                              |    5 +-
 drivers/bus/vexpress-config.c                      |    4 +-
 drivers/firmware/arm_scmi/perf.c                   |  430 +++++--
 drivers/firmware/imx/imx-scu-irq.c                 |  118 +-
 drivers/firmware/imx/imx-scu-soc.c                 |   20 +-
 drivers/firmware/imx/imx-scu.c                     |    9 +-
 drivers/firmware/meson/meson_sm.c                  |    2 +
 drivers/firmware/qcom_scm.c                        |  156 +--
 drivers/firmware/ti_sci.c                          |   49 +-
 drivers/genpd/Makefile                             |   17 +
 drivers/genpd/actions/Makefile                     |    3 +
 drivers/{soc =3D> genpd}/actions/owl-sps-helper.c    |    0
 drivers/{soc =3D> genpd}/actions/owl-sps.c           |    0
 drivers/genpd/amlogic/Makefile                     |    4 +
 drivers/{soc =3D> genpd}/amlogic/meson-ee-pwrc.c     |    3 +-
 drivers/{soc =3D> genpd}/amlogic/meson-gx-pwrc-vpu.c |    3 +-
 drivers/{soc =3D> genpd}/amlogic/meson-secure-pwrc.c |   30 +-
 drivers/genpd/apple/Makefile                       |    2 +
 .../apple/pmgr-pwrstate.c}                         |    0
 drivers/genpd/bcm/Makefile                         |    5 +
 drivers/{soc/bcm/bcm63xx =3D> genpd/bcm}/bcm-pmb.c   |    1 -
 drivers/{soc =3D> genpd}/bcm/bcm2835-power.c         |    0
 .../{soc/bcm/bcm63xx =3D> genpd/bcm}/bcm63xx-power.c |    1 -
 drivers/{soc =3D> genpd}/bcm/raspberrypi-power.c     |    2 +-
 drivers/genpd/imx/Makefile                         |    7 +
 drivers/{soc =3D> genpd}/imx/gpc.c                   |    0
 drivers/{soc =3D> genpd}/imx/gpcv2.c                 |    2 +-
 drivers/{soc =3D> genpd}/imx/imx8m-blk-ctrl.c        |    3 +-
 drivers/{soc =3D> genpd}/imx/imx8mp-blk-ctrl.c       |    2 +-
 drivers/{soc =3D> genpd}/imx/imx93-blk-ctrl.c        |   17 +-
 drivers/{soc =3D> genpd}/imx/imx93-pd.c              |    2 +-
 drivers/genpd/mediatek/Makefile                    |    3 +
 .../{soc =3D> genpd}/mediatek/mt6795-pm-domains.h    |    0
 .../{soc =3D> genpd}/mediatek/mt8167-pm-domains.h    |    0
 .../{soc =3D> genpd}/mediatek/mt8173-pm-domains.h    |    0
 .../{soc =3D> genpd}/mediatek/mt8183-pm-domains.h    |    0
 .../{soc =3D> genpd}/mediatek/mt8186-pm-domains.h    |    0
 .../{soc =3D> genpd}/mediatek/mt8188-pm-domains.h    |    0
 .../{soc =3D> genpd}/mediatek/mt8192-pm-domains.h    |    0
 .../{soc =3D> genpd}/mediatek/mt8195-pm-domains.h    |    0
 drivers/{soc =3D> genpd}/mediatek/mtk-pm-domains.c   |    0
 drivers/{soc =3D> genpd}/mediatek/mtk-pm-domains.h   |    0
 drivers/{soc =3D> genpd}/mediatek/mtk-scpsys.c       |    0
 drivers/genpd/qcom/Makefile                        |    4 +
 drivers/{soc =3D> genpd}/qcom/cpr.c                  |    1 -
 drivers/{soc =3D> genpd}/qcom/rpmhpd.c               |  118 +-
 drivers/{soc =3D> genpd}/qcom/rpmpd.c                |   35 +-
 drivers/genpd/renesas/Makefile                     |   30 +
 drivers/{soc =3D> genpd}/renesas/r8a7742-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a7743-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a7745-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a77470-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a774a1-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a774b1-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a774c0-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a774e1-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a7779-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a7790-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a7791-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a7792-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a7794-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a7795-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a7796-sysc.c      |    0
 drivers/{soc =3D> genpd}/renesas/r8a77965-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a77970-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a77980-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a77990-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a77995-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a779a0-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a779f0-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/r8a779g0-sysc.c     |    0
 drivers/{soc =3D> genpd}/renesas/rcar-gen4-sysc.c    |    0
 drivers/{soc =3D> genpd}/renesas/rcar-gen4-sysc.h    |    0
 drivers/{soc =3D> genpd}/renesas/rcar-sysc.c         |    0
 drivers/{soc =3D> genpd}/renesas/rcar-sysc.h         |    0
 drivers/{soc =3D> genpd}/renesas/rmobile-sysc.c      |    0
 drivers/genpd/rockchip/Makefile                    |    2 +
 .../pm_domains.c =3D> genpd/rockchip/pm-domains.c}   |    1 +
 drivers/genpd/samsung/Makefile                     |    2 +
 .../samsung/exynos-pm-domains.c}                   |    3 +-
 drivers/genpd/st/Makefile                          |    2 +
 .../genpd/st/ste-ux500-pm-domain.c                 |   25 +-
 drivers/genpd/starfive/Makefile                    |    2 +
 .../jh71xx_pmu.c =3D> genpd/starfive/jh71xx-pmu.c}   |    0
 drivers/genpd/sunxi/Makefile                       |    2 +
 drivers/{soc =3D> genpd}/sunxi/sun20i-ppu.c          |    0
 drivers/genpd/tegra/Makefile                       |    2 +
 drivers/{soc =3D> genpd}/tegra/powergate-bpmp.c      |    0
 drivers/genpd/ti/Makefile                          |    3 +
 drivers/{soc =3D> genpd}/ti/omap_prm.c               |   13 +-
 drivers/{soc =3D> genpd}/ti/ti_sci_pm_domains.c      |    0
 drivers/genpd/xilinx/Makefile                      |    2 +
 .../xilinx/zynqmp-pm-domains.c}                    |    0
 drivers/irqchip/irq-versatile-fpga.c               |    1 -
 drivers/memory/brcmstb_dpfe.c                      |    3 +-
 drivers/memory/da8xx-ddrctl.c                      |    1 -
 drivers/memory/fsl_ifc.c                           |    2 +-
 drivers/memory/jz4780-nemc.c                       |    1 -
 drivers/memory/pl353-smc.c                         |    1 +
 drivers/memory/renesas-rpc-if.c                    |    1 -
 drivers/memory/samsung/exynos5422-dmc.c            |    2 +-
 drivers/memory/stm32-fmc2-ebi.c                    |    2 +
 drivers/memory/tegra/mc.c                          |   39 +-
 drivers/memory/tegra/tegra124.c                    |    2 +-
 drivers/memory/tegra/tegra186-emc.c                |  136 ++-
 drivers/memory/tegra/tegra186.c                    |    3 +-
 drivers/memory/tegra/tegra194.c                    |    1 +
 drivers/memory/tegra/tegra20.c                     |    3 +-
 drivers/memory/tegra/tegra210-emc-core.c           |    4 +-
 drivers/memory/tegra/tegra234.c                    |  641 ++++++----
 drivers/memory/tegra/tegra30-emc.c                 |    2 +-
 drivers/memory/tegra/tegra30.c                     |    2 +-
 drivers/net/ipa/ipa_power.c                        |    5 +-
 drivers/remoteproc/qcom_q6v5.c                     |    8 +-
 drivers/reset/hisilicon/hi6220_reset.c             |    1 -
 drivers/reset/hisilicon/reset-hi3660.c             |    6 +-
 drivers/reset/reset-ath79.c                        |    2 -
 drivers/reset/reset-bcm6345.c                      |    2 -
 drivers/reset/reset-imx7.c                         |    2 +-
 drivers/reset/reset-intel-gw.c                     |    2 +-
 drivers/reset/reset-k210.c                         |    1 -
 drivers/reset/reset-lantiq.c                       |    1 -
 drivers/reset/reset-lpc18xx.c                      |    2 -
 drivers/reset/reset-meson-audio-arb.c              |    3 +-
 drivers/reset/reset-meson.c                        |    3 -
 drivers/reset/reset-microchip-sparx5.c             |    3 +-
 drivers/reset/reset-mpfs.c                         |    1 +
 drivers/reset/reset-npcm.c                         |    2 -
 drivers/reset/reset-qcom-aoss.c                    |    2 +-
 drivers/reset/reset-qcom-pdc.c                     |    2 +-
 drivers/reset/reset-simple.c                       |    1 -
 drivers/reset/reset-ti-syscon.c                    |    2 -
 drivers/reset/reset-uniphier-glue.c                |    4 +-
 drivers/reset/reset-uniphier.c                     |    1 -
 drivers/reset/reset-zynq.c                         |    1 -
 drivers/reset/reset-zynqmp.c                       |   10 +-
 drivers/rpmsg/qcom_smd.c                           |   10 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    3 +-
 drivers/soc/actions/Makefile                       |    4 -
 drivers/soc/amlogic/Makefile                       |    3 -
 drivers/soc/amlogic/meson-canvas.c                 |    1 +
 drivers/soc/apple/Makefile                         |    2 -
 drivers/soc/bcm/Kconfig                            |   22 +-
 drivers/soc/bcm/Makefile                           |    3 -
 drivers/soc/bcm/bcm63xx/Kconfig                    |   21 -
 drivers/soc/bcm/bcm63xx/Makefile                   |    3 -
 drivers/soc/hisilicon/Kconfig                      |   21 +
 drivers/soc/hisilicon/Makefile                     |    2 +
 drivers/soc/hisilicon/kunpeng_hccs.c               | 1276 +++++++++++++=
+++++++
 drivers/soc/hisilicon/kunpeng_hccs.h               |  191 +++
 drivers/soc/imx/Makefile                           |    7 +-
 drivers/soc/loongson/Kconfig                       |   10 +
 drivers/soc/loongson/Makefile                      |    1 +
 drivers/soc/loongson/loongson2_pm.c                |  215 ++++
 drivers/soc/mediatek/Makefile                      |    2 -
 drivers/soc/qcom/Kconfig                           |    1 +
 drivers/soc/qcom/Makefile                          |    5 +-
 drivers/soc/qcom/cmd-db.c                          |    2 +-
 drivers/soc/qcom/icc-bwmon.c                       |   30 +-
 drivers/soc/qcom/ice.c                             |    2 +
 drivers/soc/qcom/llcc-qcom.c                       |    1 -
 drivers/soc/qcom/ocmem.c                           |   68 +-
 drivers/soc/qcom/pmic_glink.c                      |    8 +-
 drivers/soc/qcom/pmic_glink_altmode.c              |   62 +-
 drivers/soc/qcom/qcom_aoss.c                       |   49 +-
 drivers/soc/qcom/qcom_gsbi.c                       |   11 +-
 drivers/soc/qcom/qmi_encdec.c                      |    4 +-
 drivers/soc/qcom/rpm-proc.c                        |   77 ++
 drivers/soc/qcom/rpmh-rsc.c                        |    2 +-
 drivers/soc/qcom/smd-rpm.c                         |   35 +-
 drivers/soc/qcom/smem.c                            |   18 +-
 drivers/soc/qcom/socinfo.c                         |    3 +-
 drivers/soc/qcom/spm.c                             |    6 +-
 drivers/soc/qcom/trace-rpmh.h                      |   16 +-
 drivers/soc/qcom/wcnss_ctrl.c                      |    1 +
 drivers/soc/renesas/Makefile                       |   27 -
 drivers/soc/rockchip/Makefile                      |    1 -
 drivers/soc/rockchip/grf.c                         |   14 +
 drivers/soc/samsung/Makefile                       |    1 -
 drivers/soc/samsung/exynos-chipid.c                |    1 -
 drivers/soc/samsung/exynos-pmu.c                   |    2 +-
 drivers/soc/starfive/Makefile                      |    3 -
 drivers/soc/sunxi/Makefile                         |    1 -
 drivers/soc/sunxi/sunxi_sram.c                     |    2 +-
 drivers/soc/tegra/Makefile                         |    1 -
 drivers/soc/tegra/cbb/tegra-cbb.c                  |   12 +-
 drivers/soc/tegra/cbb/tegra194-cbb.c               |    4 +-
 drivers/soc/tegra/cbb/tegra234-cbb.c               |    3 -
 drivers/soc/tegra/fuse/fuse-tegra.c                |    9 +-
 drivers/soc/tegra/fuse/fuse-tegra20.c              |    2 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c              |    2 -
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |    4 +-
 drivers/soc/ti/Makefile                            |    2 -
 drivers/soc/ti/k3-ringacc.c                        |   31 +-
 drivers/soc/ti/k3-socinfo.c                        |    1 +
 drivers/soc/ti/pruss.c                             |    4 +-
 drivers/soc/ti/ti_sci_inta_msi.c                   |    3 +-
 drivers/soc/xilinx/Makefile                        |    1 -
 drivers/soc/xilinx/xlnx_event_manager.c            |    6 +-
 drivers/soc/xilinx/zynqmp_power.c                  |    5 +-
 include/dt-bindings/arm/qcom,ids.h                 |    3 +-
 include/dt-bindings/firmware/qcom,scm.h            |   21 +
 include/dt-bindings/power/amlogic,c3-pwrc.h        |   25 +
 include/dt-bindings/power/qcom,rpmhpd.h            |   30 +
 include/linux/firmware/imx/sci.h                   |   16 +-
 include/linux/firmware/qcom/qcom_scm.h             |    2 +-
 include/linux/soc/qcom/qcom_aoss.h                 |    4 +-
 include/linux/soc/qcom/smem.h                      |    1 +
 include/soc/tegra/mc.h                             |    3 +
 256 files changed, 4019 insertions(+), 1253 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-kun=
peng_hccs
 create mode 100644 Documentation/devicetree/bindings/net/davicom,dm9000=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/davicom-dm9000=
.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,rp=
m-proc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/loongson/loong=
son,ls2k-pmc.yaml
 delete mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 drivers/genpd/Makefile
 create mode 100644 drivers/genpd/actions/Makefile
 rename drivers/{soc =3D> genpd}/actions/owl-sps-helper.c (100%)
 rename drivers/{soc =3D> genpd}/actions/owl-sps.c (100%)
 create mode 100644 drivers/genpd/amlogic/Makefile
 rename drivers/{soc =3D> genpd}/amlogic/meson-ee-pwrc.c (99%)
 rename drivers/{soc =3D> genpd}/amlogic/meson-gx-pwrc-vpu.c (99%)
 rename drivers/{soc =3D> genpd}/amlogic/meson-secure-pwrc.c (86%)
 create mode 100644 drivers/genpd/apple/Makefile
 rename drivers/{soc/apple/apple-pmgr-pwrstate.c =3D> genpd/apple/pmgr-p=
wrstate.c} (100%)
 create mode 100644 drivers/genpd/bcm/Makefile
 rename drivers/{soc/bcm/bcm63xx =3D> genpd/bcm}/bcm-pmb.c (99%)
 rename drivers/{soc =3D> genpd}/bcm/bcm2835-power.c (100%)
 rename drivers/{soc/bcm/bcm63xx =3D> genpd/bcm}/bcm63xx-power.c (99%)
 rename drivers/{soc =3D> genpd}/bcm/raspberrypi-power.c (99%)
 create mode 100644 drivers/genpd/imx/Makefile
 rename drivers/{soc =3D> genpd}/imx/gpc.c (100%)
 rename drivers/{soc =3D> genpd}/imx/gpcv2.c (99%)
 rename drivers/{soc =3D> genpd}/imx/imx8m-blk-ctrl.c (99%)
 rename drivers/{soc =3D> genpd}/imx/imx8mp-blk-ctrl.c (99%)
 rename drivers/{soc =3D> genpd}/imx/imx93-blk-ctrl.c (94%)
 rename drivers/{soc =3D> genpd}/imx/imx93-pd.c (99%)
 create mode 100644 drivers/genpd/mediatek/Makefile
 rename drivers/{soc =3D> genpd}/mediatek/mt6795-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mt8167-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mt8173-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mt8183-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mt8186-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mt8188-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mt8192-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mt8195-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mtk-pm-domains.c (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mtk-pm-domains.h (100%)
 rename drivers/{soc =3D> genpd}/mediatek/mtk-scpsys.c (100%)
 create mode 100644 drivers/genpd/qcom/Makefile
 rename drivers/{soc =3D> genpd}/qcom/cpr.c (99%)
 rename drivers/{soc =3D> genpd}/qcom/rpmhpd.c (92%)
 rename drivers/{soc =3D> genpd}/qcom/rpmpd.c (96%)
 create mode 100644 drivers/genpd/renesas/Makefile
 rename drivers/{soc =3D> genpd}/renesas/r8a7742-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7743-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7745-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a77470-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a774a1-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a774b1-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a774c0-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a774e1-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7779-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7790-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7791-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7792-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7794-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7795-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a7796-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a77965-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a77970-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a77980-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a77990-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a77995-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a779a0-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a779f0-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/r8a779g0-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/rcar-gen4-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/rcar-gen4-sysc.h (100%)
 rename drivers/{soc =3D> genpd}/renesas/rcar-sysc.c (100%)
 rename drivers/{soc =3D> genpd}/renesas/rcar-sysc.h (100%)
 rename drivers/{soc =3D> genpd}/renesas/rmobile-sysc.c (100%)
 create mode 100644 drivers/genpd/rockchip/Makefile
 rename drivers/{soc/rockchip/pm_domains.c =3D> genpd/rockchip/pm-domain=
s.c} (99%)
 create mode 100644 drivers/genpd/samsung/Makefile
 rename drivers/{soc/samsung/pm_domains.c =3D> genpd/samsung/exynos-pm-d=
omains.c} (98%)
 create mode 100644 drivers/genpd/st/Makefile
 rename arch/arm/mach-ux500/pm_domains.c =3D> drivers/genpd/st/ste-ux500=
-pm-domain.c (75%)
 create mode 100644 drivers/genpd/starfive/Makefile
 rename drivers/{soc/starfive/jh71xx_pmu.c =3D> genpd/starfive/jh71xx-pm=
u.c} (100%)
 create mode 100644 drivers/genpd/sunxi/Makefile
 rename drivers/{soc =3D> genpd}/sunxi/sun20i-ppu.c (100%)
 create mode 100644 drivers/genpd/tegra/Makefile
 rename drivers/{soc =3D> genpd}/tegra/powergate-bpmp.c (100%)
 create mode 100644 drivers/genpd/ti/Makefile
 rename drivers/{soc =3D> genpd}/ti/omap_prm.c (99%)
 rename drivers/{soc =3D> genpd}/ti/ti_sci_pm_domains.c (100%)
 create mode 100644 drivers/genpd/xilinx/Makefile
 rename drivers/{soc/xilinx/zynqmp_pm_domains.c =3D> genpd/xilinx/zynqmp=
-pm-domains.c} (100%)
 delete mode 100644 drivers/soc/actions/Makefile
 delete mode 100644 drivers/soc/bcm/bcm63xx/Kconfig
 delete mode 100644 drivers/soc/bcm/bcm63xx/Makefile
 create mode 100644 drivers/soc/hisilicon/Kconfig
 create mode 100644 drivers/soc/hisilicon/Makefile
 create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.c
 create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.h
 create mode 100644 drivers/soc/loongson/loongson2_pm.c
 create mode 100644 drivers/soc/qcom/rpm-proc.c
 delete mode 100644 drivers/soc/starfive/Makefile
 create mode 100644 include/dt-bindings/power/amlogic,c3-pwrc.h
 create mode 100644 include/dt-bindings/power/qcom,rpmhpd.h
