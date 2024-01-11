Return-Path: <linux-kernel+bounces-23849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2352E82B2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6401B1F21A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77447524CB;
	Thu, 11 Jan 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ibums8lO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7BOV4IU+"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFF9524A8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B30913200A17;
	Thu, 11 Jan 2024 11:18:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 11:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1704989913;
	 x=1705076313; bh=wR9kVKHNZJUl/jEBXXwkc1yKshWQ8Ddsb/Xbl9Zge9E=; b=
	ibums8lOcXPMWcJ8h5itn5jzrpotXqq8CVOmk1E1TX7l9BUiH2tH24k3t4tJVp1r
	SUv/DcppH9h8i21tt9Y+yv0Kqbbv7uqvZsYETuzr0vKucLIxbk2AC6mbLM0jmChj
	ngtYHK/27MKOSD7wG3o6DqgwVeFOHYuv9n6EALOvJpqc1Yr73myVrk2M7r9Tra7S
	CDlCT9BdmOdeWmpFQRFe/RXhMq9dP+uobvokZa4WfZrVmAkSBT7+Ukup92gt2xO8
	WwIqXzsipm1zoJ13BSECnTIM+ssxDH0iPcnjr2c8hFJTyshT1yaFsdKcZQ+9J9lU
	l7Rn+KuCgbdeya+a90aX2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704989913; x=
	1705076313; bh=wR9kVKHNZJUl/jEBXXwkc1yKshWQ8Ddsb/Xbl9Zge9E=; b=7
	BOV4IU+Ul4q6krr0QGIs/5HWMZzu5F6ldNj5GYrV/+85Wmoli5kOmjz5Cznw7gSh
	tMffs0H1zp9/j6RrzjjZKDMFPL/VJRwPC5YCd7f1u5QIB8TV6ZI2V9Lre+0hRqYl
	S/+ceuYICicRDARU9usNavexyQ/cuEA4L1dBYfxfJOJWFTvbzhLxO7ppMenXA3TP
	oYV8odp1PUcPRpT45cR6IoWJo8hE87xZ3Hg/cZczm2A8VZ6nOxKFA8UDsKod6Y6l
	yCJUJi/kZEnWNi6mq0xubh+SrSZ4QjarqZCIHuQg/TUz2hUQeOojkpbtf1toZ4JM
	18DP06luFbM40dmGqitzA==
X-ME-Sender: <xms:2RSgZV2YnYABOpRycK62GsqoCT_W8V7zQBe1s0PGuugxdfqhuSkU6Q>
    <xme:2RSgZcGJr72HsOnm8Y2wCop6_Rb01zSLw76aJxvrvRiMhElCP-SI1gHcBY4dbkidb
    YtTvqWlt9O1-TZsYV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeejgeefkeffgeeuvefhfefhhfevudfhjeetueeguddvffffjeevtddtffej
    udekheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnrghrohdrohhrghdpgh
    hithhhuhgsrdgtohhmpdhpvghnghhuthhrohhnihigrdguvgenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2RSgZV5lzcz7dKGr0a_9-NeVyEd3an_LiXYkmSgecwquLzbsO7etwg>
    <xmx:2RSgZS0JEvhLCbhCFt2_iSGLbGo8azMDGZJaTrp90A8Q2DibyrQlNw>
    <xmx:2RSgZYEarIvkqYG39liJVqvAorn_b4wZ9yPXvDQ1RT4RSPOEJsoFpw>
    <xmx:2RSgZSMt3o8LtH63RMzdARVB2daG0ntSf-vjinFx6RY6-iboiqQSqg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F2C1CB6008D; Thu, 11 Jan 2024 11:18:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e56412b6-f79a-4464-b2f8-2ba2c078f0c5@app.fastmail.com>
In-Reply-To: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
References: <1c120ba6-3c94-4d94-8497-afb6c5063d3c@app.fastmail.com>
Date: Thu, 11 Jan 2024 17:18:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] SoC: driver updates for 6.8
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e9147=
1ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.8

for you to fetch changes up to db0a7c09b2a552c5028a29942e80a4848d182934:

  Merge tag 'tee-iov-iter-for-v6.8' of https://git.linaro.org/people/jen=
s.wiklander/linux-tee into soc/drivers (2023-12-22 11:38:03 +0000)

----------------------------------------------------------------
SoC: driver updates for 6.8

A new drivers/cache/ subsystem is added to contain drivers for abstracti=
ng
cache flush methods on riscv and potentially others, as this is needed f=
or
handling non-coherent DMA but several SoCs require nonstandard hardware
methods for it.

op-tee gains support for asynchronous notification with FF-A, as well
as support for a system thread for executing in secure world.

The tee, reset, bus, memory and scmi subsystems have a couple of minor
updates.

Platform specific soc driver changes include:

 - Samsung Exynos gains driver support for Google GS101 (Tensor G1)
   across multiple subsystems

 - Qualcomm Snapdragon gains support for SM8650 and X1E along with
   added features for some other SoCs

 - Mediatek adds support for "Smart Voltage Scaling" on MT8186 and MT819=
5,
   and driver support for MT8188 along with some code refactoring.

 - Microchip Polarfire FPGA support for "Auto Update" of the FPGA bitstr=
eam

 - Apple M1 mailbox driver is rewritten into a SoC driver

 - minor updates on amlogic, mvebu, ti, zynq, imx, renesas and hisilicon

----------------------------------------------------------------
Abel Vesa (3):
      soc: qcom: llcc: Add missing description for members in slice conf=
ig
      dt-bindings: soc: qcom,aoss-qmp: document the X1E80100 Always-On S=
ubsystem side channel
      soc: qcom: llcc: Fix LLCC_TRP_ATTR2_CFGn offset

Andrew Halaney (3):
      soc: qcom: pmic_pdcharger_ulog: Search current directory for heade=
rs
      soc: qcom: pmic_pdcharger_ulog: Move TRACE_SYSTEM out of #if prote=
ction
      soc: qcom: pmic_pdcharger_ulog: Fix hypothetical ulog request mess=
age endianess

AngeloGioacchino Del Regno (17):
      soc: mediatek: mtk-svs: Subtract offset from regs_v2 to avoid conf=
lict
      soc: mediatek: mtk-svs: Convert sw_id and type to enumerations
      soc: mediatek: mtk-svs: Build bank name string dynamically
      soc: mediatek: mtk-svs: Reduce memory footprint of struct svs_bank
      soc: mediatek: mtk-svs: Change the thermal sensor device name
      soc: mediatek: mtk-svs: Add a map to retrieve fused values
      soc: mediatek: mtk-svs: Add SVS-Thermal coefficient to SoC platfor=
m data
      soc: mediatek: mtk-svs: Move t-calibration-data retrieval to svs_p=
robe()
      soc: mediatek: mtk-svs: Commonize efuse parse function for most So=
Cs
      soc: mediatek: mtk-svs: Drop supplementary svs per-bank pointer
      soc: mediatek: mtk-svs: Commonize MT8192 probe function for MT8186
      soc: mediatek: mtk-svs: Remove redundant print in svs_get_efuse_da=
ta
      soc: mediatek: mtk-svs: Compress of_device_id entries
      soc: mediatek: mtk-svs: Cleanup of svs_probe() function
      soc: mediatek: mtk-svs: Check if SVS mode is available in the begi=
nning
      soc: mediatek: mtk-svs: Use ULONG_MAX to compare floor frequency
      soc: mediatek: mtk-svs: Constify runtime-immutable members of svs_=
bank

Arnaud Pouliquen (1):
      tee: Use iov_iter to better support shared buffer registration

Arnd Bergmann (25):
      Merge tag 'asahi-soc-mailbox-6.8' of https://github.com/AsahiLinux=
/linux into soc/drivers
      Merge tag 'bus-platform-remove-void' of https://git.pengutronix.de=
/git/ukl/linux into soc/drivers
      soc: qcom: stats: fix 64-bit division
      Merge tag 'hisi-drivers-for-6.8' of https://github.com/hisilicon/l=
inux-hisi into soc/drivers
      Merge tag 'system-thread-for-v6.8' of https://git.linaro.org/peopl=
e/jens.wiklander/linux-tee into soc/drivers
      Merge tag 'ffa-notif-for-v6.8' of https://git.linaro.org/people/je=
ns.wiklander/linux-tee into soc/drivers
      Merge tag 'kern-priv-shm-for-v6.8' of https://git.linaro.org/peopl=
e/jens.wiklander/linux-tee into soc/drivers
      Merge tag 'fsl_qmc_tsa_v6.8' of https://github.com//hcodina/linux =
into soc/drivers
      Merge tag 'mtk-soc-for-v6.8' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/mediatek/linux into soc/drivers
      Merge tag 'renesas-drivers-for-v6.8-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'imx-drivers-6.8' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/drivers
      Merge tag 'zynqmp-soc-for-6.8' of https://github.com/Xilinx/linux-=
xlnx into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.8' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.8' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'samsung-drivers-6.8' of https://git.kernel.org/pub/scm/=
linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'mvebu-drivers-6.8-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/gclement/mvebu into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.8' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'riscv-soc-drivers-for-v6.8' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/conor/linux into soc/drivers
      Merge tag 'riscv-cache-for-v6.8' of https://git.kernel.org/pub/scm=
/linux/kernel/git/conor/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.8' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'memory-controller-drv-6.8-2' of https://git.kernel.org/=
pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'scmi-updates-6.8' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'reset-for-v6.8' of git://git.pengutronix.de/pza/linux i=
nto soc/drivers
      Merge tag 'optee-cleanup-for-v6.8' of https://git.linaro.org/peopl=
e/jens.wiklander/linux-tee into soc/drivers
      Merge tag 'tee-iov-iter-for-v6.8' of https://git.linaro.org/people=
/jens.wiklander/linux-tee into soc/drivers

Ashish Mhetre (3):
      memory: tegra: Add SID override programming for MC clients
      memory: tegra: Skip SID programming if SID registers aren't set
      memory: tegra: Protect SID override call under CONFIG_IOMMU_API

Atul Dhudase (1):
      soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration

Bartosz Golaszewski (1):
      firmware: qcom: qseecom: fix memory leaks in error paths

Bjorn Andersson (1):
      soc: qcom: stats: Express AOSS QMP module dependency

Christophe JAILLET (1):
      firmware: ti_sci: Fix an off-by-one in ti_sci_debugfs_create()

Conor Dooley (8):
      soc: sifive: shunt ccache driver to drivers/cache
      dt-bindings: soc: microchip: add a property for system controller =
flash
      soc: microchip: mpfs: enable access to the system controller's fla=
sh
      soc: microchip: mpfs: print service status in warning message
      soc: microchip: mpfs: add auto-update subdev to system controller
      firmware: microchip: add PolarFire SoC Auto Update support
      MAINTAINERS: add auto-update driver to mpfs entry
      soc: renesas: Make RZ/Five depend on !DMA_DIRECT_REMAP

Cristian Marussi (2):
      firmware: arm_scmi: Add optional flags to extended names helper
      firmware: arm_scmi: Add protocol versioning checks

Dang Huynh (1):
      soc: qcom: socinfo: Add PM8937 Power IC

Dmitry Baryshkov (2):
      usb: typec: ucsi: fix UCSI on buggy Qualcomm devices
      soc: qcom: pmic_glink: enable UCSI by default

Emil Renner Berthing (4):
      dt-bindings: cache: sifive,ccache0: Add StarFive JH7100 compatible
      soc: sifive: ccache: Add StarFive JH7100 support
      riscv: errata: Add StarFive JH7100 errata
      riscv: errata: Make ERRATA_STARFIVE_JH7100 depend on !DMA_DIRECT_R=
EMAP

Etienne Carriere (5):
      tee: optee: system thread call property
      tee: system session
      tee: optee: support tracking system threads
      firmware: arm_scmi: optee: use optee system invocation
      optee: add missing description of RPC argument reference

Evgeny Bachinin (2):
      firmware: meson_sm: refactor serial sysfs entry via dev_groups att=
rs
      firmware: meson-sm: unmap out_base shmem in error path

Geert Uytterhoeven (1):
      soc: renesas: Remove duplicate setup of soc_device_attribute.family

Ghanshyam Agrawal (1):
      soc: qcom: llcc: Fix typo in kernel-doc

HariBabu Gattem (1):
      soc: xilinx: Fix for call trace due to the usage of smp_processor_=
id()

Hector Martin (5):
      soc: apple: rtkit: Get rid of apple_rtkit_send_message_wait
      soc: apple: mailbox: Add ASC/M3 mailbox driver
      soc: apple: rtkit: Port to the internal mailbox driver
      mailbox: apple: Delete driver
      soc: apple: mailbox: Rename config symbol to APPLE_MAILBOX

Herve Codina (17):
      soc: fsl: cpm1: tsa: Fix __iomem addresses declaration
      soc: fsl: cpm1: qmc: Fix __iomem addresses declaration
      soc: fsl: cpm1: qmc: Fix rx channel reset
      soc: fsl: cpm1: qmc: Extend the API to provide Rx status
      soc: fsl: cpm1: qmc: Remove inline function specifiers
      soc: fsl: cpm1: qmc: Add support for child devices
      soc: fsl: cpm1: qmc: Introduce available timeslots masks
      soc: fsl: cpm1: qmc: Rename qmc_setup_tsa* to qmc_init_tsa*
      soc: fsl: cpm1: qmc: Introduce qmc_chan_setup_tsa*
      soc: fsl: cpm1: qmc: Remove no more needed checks from qmc_check_c=
hans()
      soc: fsl: cpm1: qmc: Check available timeslots in qmc_check_chans()
      soc: fsl: cpm1: qmc: Add support for disabling channel TSA entries
      soc: fsl: cpm1: qmc: Split Tx and Rx TSA entries setup
      soc: fsl: cpm1: qmc: Introduce is_tsa_64rxtx flag
      soc: fsl: cpm1: qmc: Handle timeslot entries at channel start() an=
d stop()
      soc: fsl: cpm1: qmc: Remove timeslots handling from setup_chan()
      soc: fsl: cpm1: qmc: Introduce functions to change timeslots at ru=
ntime

Hsiao Chien Sung (4):
      soc: mediatek: Support MT8188 VDOSYS1 in mtk-mmsys
      soc: mediatek: Support MT8188 VDOSYS1 Padding in mtk-mmsys
      soc: mediatek: Support reset bit mapping in mmsys driver
      soc: mediatek: Add MT8188 VDOSYS reset bit map

Huisong Li (5):
      soc: hisilicon: kunpeng_hccs: Fix some incorrect format strings
      soc: hisilicon: kunpeng_hccs: Add failure log for no _CRS method
      soc: hisilicon: kunpeng_hccs: Remove an unused blank line
      doc: kunpeng_hccs: Fix incorrect email domain name
      soc: hisilicon: kunpeng_hccs: Support the platform with PCC type3 =
and interrupt ack

Jaewon Kim (8):
      soc: samsung: exynos-chipid: add exynosautov920 SoC support
      dt-bindings: samsung: exynos-sysreg: add exynosautov920 sysreg
      dt-bindings: samsung: exynos-pmu: add exynosautov920 compatible
      dt-bindings: samsung: usi: add exynosautov920-usi compatible
      dt-bindings: serial: samsung: add exynosautov920-uart compatible
      dt-bindings: pwm: samsung: add exynosautov920 compatible
      dt-bindings: arm: samsung: Document exynosautov920 SADK board bind=
ing
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynosautov920 com=
patible

Jens Wiklander (4):
      optee: provide optee_do_bottom_half() as a common function
      optee: ffa_abi: add asynchronous notifications
      optee: add page list to kernel private shared memory
      optee: allocate shared memory with alloc_pages_exact()

Johan Hovold (3):
      soc: qcom: pmic_glink_altmode: fix port sanity check
      soc: qcom: pmic_glink: disable UCSI on sc8280xp
      soc: qcom: pmic_glink: drop stray semicolons

Konrad Dybcio (4):
      dt-bindings: soc: qcom: stats: Add QMP handle
      soc: qcom: stats: Add DDR sleep stats
      dt-bindings: firmware: qcom,scm: Allow interconnect for everyone
      Revert "soc: qcom: stats: Add DDR sleep stats"

Kory Maincent (1):
      firmware_loader: Expand Firmware upload error codes with firmware =
invalid error

Krzysztof Kozlowski (19):
      dt-bindings: hwinfo: samsung,exynos-chipid: add specific compatibl=
es for existing SoC
      dt-bindings: i2c: exynos5: add specific compatibles for existing S=
oC
      dt-bindings: i2c: samsung,s3c2410-i2c: add specific compatibles fo=
r existing SoC
      dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatibles=
 for existing SoC
      dt-bindings: rtc: s3c-rtc: add specific compatibles for existing S=
oC
      dt-bindings: serial: samsung: add specific compatibles for existin=
g SoC
      dt-bindings: samsung: exynos-pmu: add specific compatibles for exi=
sting SoC
      dt-bindings: gpu: arm,mali-midgard: add specific compatibles for e=
xisting Exynos SoC
      dt-bindings: iio: samsung,exynos-adc: add specific compatibles for=
 existing SoC
      ASoC: dt-bindings: samsung-i2s: add specific compatibles for exist=
ing SoC
      dt-bindings: pwm: samsung: add specific compatibles for existing S=
oC
      dt-bindings: i2c: exynos5: add specific compatible for Tesla FSD
      dt-bindings: pwm: samsung: add specific compatible for Tesla FSD
      dt-bindings: serial: samsung: add specific compatible for Tesla FSD
      dt-bindings: samsung: exynos-pmu: add specific compatible for Tesl=
a FSD
      dt-bindings: watchdog: samsung: add specific compatible for Tesla =
FSD
      dt-bindings: samsung: exynos-sysreg: combine exynosautov920 with o=
ther enum
      Merge tag 'samsung-dt-bindings-refactoring-and-google-gs101-6.8' i=
nto next/drivers
      MAINTAINERS: qcom: move Andy Gross to credits

Lad Prabhakar (1):
      dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/Five SoC

Mark Tseng (2):
      soc: mediatek: svs: Add support for MT8195 SoC
      soc: mediatek: svs: Add support for MT8186 SoC

Michal Simek (1):
      soc: xilinx: fix quoted string split across lines

Naman Jain (1):
      soc: qcom: socinfo: Add few DSPs to get their image details

Naman Trivedi Manojbhai (1):
      soc: xilinx: Add error message for invalid payload received from I=
PI callback.

Neha Malcom Francis (1):
      soc: ti: k3-socinfo: Revamp driver to accommodate different rev st=
ructs

Neil Armstrong (8):
      soc: qcom: add ADSP PDCharger ULOG driver
      dt-bindings: soc: qcom,aoss-qmp: document the SM8560 Always-On Sub=
system side channel
      dt-bindings: soc: qcom: pmic-glink: document SM8650 compatible
      dt-bindings: firmware: qcom,scm: document SM8650 SCM Firmware Inte=
rface
      dt-bindings: arm: qcom,ids: Add SoC ID for SM8650
      soc: qcom: socinfo: Add SM8650 SoC ID table entry
      dt-bindings: cache: qcom,llcc: Document the SM8650 Last Level Cach=
e Controller
      soc: qcom: llcc: Add configuration data for SM8650

Peter Griffin (13):
      dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
      dt-bindings: clock: Add Google gs101 clock management unit bindings
      dt-bindings: soc: google: exynos-sysreg: add dedicated SYSREG comp=
atibles to GS101
      dt-bindings: watchdog: Document Google gs101 watchdog bindings
      dt-bindings: serial: samsung: Add google-gs101-uart compatible
      dt-bindings: serial: samsung: Make samsung,uart-fifosize a require=
d property
      dt-bindings: clock: google,gs101: fix incorrect numbering and DGB =
suffix
      clk: samsung: clk-pll: Add support for pll_{0516,0517,518}
      clk: samsung: clk-gs101: Add cmu_top, cmu_misc and cmu_apm support
      tty: serial: samsung: Add gs101 compatible and common fifoszdt_ser=
ial_drv_data
      watchdog: s3c2410_wdt: Add support for WTCON register DBGACK_MASK =
bit
      watchdog: s3c2410_wdt: Update QUIRK macros to use BIT macro
      watchdog: s3c2410_wdt: Add support for Google gs101 SoC

Rajendra Nayak (2):
      dt-bindings: cache: qcom,llcc: Add X1E80100 compatible
      soc: qcom: llcc: Add configuration data for X1E80100

Rob Herring (7):
      soc: apple: mailbox: Add explicit include of platform_device.h
      bus: imx-weim: Use device_get_match_data()
      reset: Use device_get_match_data()
      dt-bindings: reset: qcom: drop unneeded quotes
      dt-bindings: reset: imx-src: Simplify compatible schema and drop u=
nneeded quotes
      dt-bindings: reset: hisilicon,hi3660-reset: Drop providers and con=
sumers from example
      firmware: microchip: Replace of_device.h with explicit include

Sibi Sankar (3):
      firmware: arm_scmi: Fix NULL pointer dereference during fastchanne=
l init
      firmware: arm_scmi: Increase the maximum opp count in the perf pro=
tocol
      dt-bindings: firmware: qcom,scm: document SCM on X1E80100 SoCs

Sjoerd Simons (2):
      bus: moxtet: Mark the irq as shared
      bus: moxtet: Add spi device table

Sudeep Holla (1):
      firmware: arm_scmi: Populate fastchannel info only if set operatio=
ns are allowed

Sumit Garg (1):
      tee: optee: Remove redundant custom workqueue

Tanmay Shah (1):
      soc: xilinx: fix unhandled SGI warning message

Tudor Ambarus (2):
      dt-bindings: soc: samsung: usi: add google,gs101-usi compatible
      dt-bindings: clock: google,gs101: rename CMU_TOP gate defines

Uwe Kleine-K=C3=B6nig (30):
      soc/xilinx: zynqmp_power: Convert to platform remove callback retu=
rning void
      bus: fsl-mc: Drop if block with always false condition
      bus: fsl-mc: Convert to platform remove callback returning void
      bus: hisi_lpc: Convert to platform remove callback returning void
      bus: omap-ocp2scp: Convert to platform remove callback returning v=
oid
      bus: omap_l3_smx: Convert to platform remove callback returning vo=
id
      bus: qcom-ssc-block-bus: Convert to platform remove callback retur=
ning void
      bus: simple-pm-bus: Convert to platform remove callback returning =
void
      bus: sun50i-de2: Convert to platform remove callback returning void
      bus: sunxi-rsb: Convert to platform remove callback returning void
      bus: tegra-aconnect: Convert to platform remove callback returning=
 void
      bus: tegra-gmi: Convert to platform remove callback returning void
      bus: ti-pwmss: Convert to platform remove callback returning void
      bus: ti-sysc: Convert to platform remove callback returning void
      bus: ts-nbus: Convert to platform remove callback returning void
      memory: brcmstb_dpfe: Convert to platform remove callback returnin=
g void
      memory: brcmstb_memc: Convert to platform remove callback returnin=
g void
      memory: emif: Convert to platform remove callback returning void
      memory: fsl-corenet-cf: Convert to platform remove callback return=
ing void
      memory: fsl_ifc: Convert to platform remove callback returning void
      memory: jz4780-nemc: Convert to platform remove callback returning=
 void
      memory: mtk-smi: Convert to platform remove callback returning void
      memory: omap-gpmc: Convert to platform remove callback returning v=
oid
      memory: renesas-rpc-if: Convert to platform remove callback return=
ing void
      memory: exynos5422-dmc: Convert to platform remove callback return=
ing void
      memory: stm32-fmc2-ebi: Convert to platform remove callback return=
ing void
      memory: tegra186-emc: Convert to platform remove callback returnin=
g void
      memory: tegra210-emc: Convert to platform remove callback returnin=
g void
      memory: ti-aemif: Convert to platform remove callback returning vo=
id
      memory: ti-emif-pm: Convert to platform remove callback returning =
void

Vaishnav Achath (1):
      soc: ti: k3-socinfo: Add JTAG ID for J722S

Yangtao Li (7):
      reset: brcmstb: Use devm_platform_get_and_ioremap_resource()
      reset: meson-audio-arb: Convert to devm_platform_ioremap_resource()
      reset: qcom-aoss: Convert to devm_platform_ioremap_resource()
      reset: qcom: Convert to devm_platform_ioremap_resource()
      reset: simple: Convert to devm_platform_get_and_ioremap_resource()
      reset: sunplus: Use devm_platform_get_and_ioremap_resource()
      reset: uniphier-glue: Use devm_platform_get_and_ioremap_resource()

Zelong Dong (2):
      dt-bindings: reset: Add compatible and DT bindings for Amlogic C3 =
Reset Controller
      reset: reset-meson: add support for Amlogic C3 SoC Reset Controller

xinglong.yang (1):
      firmware: arm_scmi: Check beforehand if the perf domain set operat=
ions are allowed

yu-chang.lee (1):
      soc: mediatek: mmsys: Add support for MT8188 VPPSYS

 CREDITS                                            |    4 +
 Documentation/ABI/testing/sysfs-bus-optee-devices  |    9 +
 .../testing/sysfs-devices-platform-kunpeng_hccs    |    6 +-
 .../bindings/arm/samsung/samsung-boards.yaml       |    6 +
 .../devicetree/bindings/cache/qcom,llcc.yaml       |    3 +
 .../devicetree/bindings/cache/sifive,ccache0.yaml  |    6 +-
 .../bindings/clock/google,gs101-clock.yaml         |  106 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |   18 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |    5 +
 .../bindings/hwinfo/samsung,exynos-chipid.yaml     |   18 +-
 .../devicetree/bindings/i2c/i2c-exynos5.yaml       |   11 +-
 .../bindings/i2c/samsung,s3c2410-i2c.yaml          |   22 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |   29 +-
 .../bindings/mfd/samsung,exynos5433-lpass.yaml     |    2 +-
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |   25 +-
 .../devicetree/bindings/pwm/pwm-samsung.yaml       |    4 +
 .../bindings/reset/amlogic,meson-reset.yaml        |    1 +
 .../devicetree/bindings/reset/fsl,imx-src.yaml     |   31 +-
 .../bindings/reset/hisilicon,hi3660-reset.yaml     |   25 +-
 .../devicetree/bindings/reset/qcom,aoss-reset.yaml |   10 +-
 .../devicetree/bindings/reset/qcom,pdc-global.yaml |    8 +-
 .../bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml  |    2 +-
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml |    5 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |   28 +-
 .../microchip/microchip,mpfs-sys-controller.yaml   |   10 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    2 +
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   22 +-
 .../devicetree/bindings/soc/qcom/qcom-stats.yaml   |   14 +
 .../bindings/soc/samsung/exynos-pmu.yaml           |   10 +
 .../bindings/soc/samsung/exynos-usi.yaml           |    7 +-
 .../soc/samsung/samsung,exynos-sysreg.yaml         |    5 +
 .../devicetree/bindings/sound/samsung-i2s.yaml     |   19 +-
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |   29 +-
 MAINTAINERS                                        |   18 +-
 arch/riscv/Kconfig.errata                          |   19 +
 drivers/base/firmware_loader/sysfs_upload.c        |    1 +
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   16 +-
 drivers/bus/hisi_lpc.c                             |    6 +-
 drivers/bus/imx-weim.c                             |    9 +-
 drivers/bus/moxtet.c                               |    9 +-
 drivers/bus/omap-ocp2scp.c                         |    6 +-
 drivers/bus/omap_l3_smx.c                          |    6 +-
 drivers/bus/qcom-ssc-block-bus.c                   |    6 +-
 drivers/bus/simple-pm-bus.c                        |    7 +-
 drivers/bus/sun50i-de2.c                           |    5 +-
 drivers/bus/sunxi-rsb.c                            |    6 +-
 drivers/bus/tegra-aconnect.c                       |    6 +-
 drivers/bus/tegra-gmi.c                            |    6 +-
 drivers/bus/ti-pwmss.c                             |    5 +-
 drivers/bus/ti-sysc.c                              |    6 +-
 drivers/bus/ts-nbus.c                              |    6 +-
 drivers/cache/Kconfig                              |    6 +
 drivers/cache/Makefile                             |    3 +-
 drivers/{soc/sifive =3D> cache}/sifive_ccache.c      |   62 +-
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-gs101.c                    | 2518 +++++++++++++=
+++++++
 drivers/clk/samsung/clk-pll.c                      |    6 +
 drivers/clk/samsung/clk-pll.h                      |    3 +
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/arm_scmi/base.c                   |    6 +-
 drivers/firmware/arm_scmi/clock.c                  |    8 +-
 drivers/firmware/arm_scmi/driver.c                 |   24 +-
 drivers/firmware/arm_scmi/optee.c                  |    4 +
 drivers/firmware/arm_scmi/perf.c                   |   48 +-
 drivers/firmware/arm_scmi/power.c                  |    8 +-
 drivers/firmware/arm_scmi/powercap.c               |    8 +-
 drivers/firmware/arm_scmi/protocols.h              |   11 +-
 drivers/firmware/arm_scmi/reset.c                  |    9 +-
 drivers/firmware/arm_scmi/sensors.c                |    8 +-
 drivers/firmware/arm_scmi/system.c                 |    6 +-
 drivers/firmware/arm_scmi/voltage.c                |    8 +-
 drivers/firmware/meson/meson_sm.c                  |   19 +-
 drivers/firmware/microchip/Kconfig                 |   12 +
 drivers/firmware/microchip/Makefile                |    3 +
 drivers/firmware/microchip/mpfs-auto-update.c      |  494 ++++
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c    |   20 +-
 drivers/firmware/ti_sci.c                          |   10 +-
 drivers/mailbox/Kconfig                            |   12 -
 drivers/mailbox/Makefile                           |    2 -
 drivers/mailbox/apple-mailbox.c                    |  441 ----
 drivers/memory/brcmstb_dpfe.c                      |    6 +-
 drivers/memory/brcmstb_memc.c                      |    6 +-
 drivers/memory/emif.c                              |    6 +-
 drivers/memory/fsl-corenet-cf.c                    |    6 +-
 drivers/memory/fsl_ifc.c                           |    6 +-
 drivers/memory/jz4780-nemc.c                       |    5 +-
 drivers/memory/mtk-smi.c                           |   10 +-
 drivers/memory/omap-gpmc.c                         |    6 +-
 drivers/memory/renesas-rpc-if.c                    |    6 +-
 drivers/memory/samsung/exynos5422-dmc.c            |    6 +-
 drivers/memory/stm32-fmc2-ebi.c                    |    6 +-
 drivers/memory/tegra/tegra186-emc.c                |    6 +-
 drivers/memory/tegra/tegra186.c                    |   19 +
 drivers/memory/tegra/tegra210-emc-core.c           |    6 +-
 drivers/memory/ti-aemif.c                          |    5 +-
 drivers/memory/ti-emif-pm.c                        |    6 +-
 drivers/reset/reset-brcmstb.c                      |    3 +-
 drivers/reset/reset-meson-audio-arb.c              |    4 +-
 drivers/reset/reset-meson.c                        |    1 +
 drivers/reset/reset-npcm.c                         |    5 +-
 drivers/reset/reset-qcom-aoss.c                    |    4 +-
 drivers/reset/reset-qcom-pdc.c                     |    4 +-
 drivers/reset/reset-simple.c                       |    3 +-
 drivers/reset/reset-sunplus.c                      |    3 +-
 drivers/reset/reset-uniphier-glue.c                |    3 +-
 drivers/reset/sti/reset-syscfg.c                   |   11 +-
 drivers/soc/Kconfig                                |    1 -
 drivers/soc/Makefile                               |    1 -
 drivers/soc/apple/Kconfig                          |   15 +-
 drivers/soc/apple/Makefile                         |    4 +
 drivers/soc/apple/mailbox.c                        |  437 ++++
 drivers/soc/apple/mailbox.h                        |   48 +
 drivers/soc/apple/rtkit-internal.h                 |    8 +-
 drivers/soc/apple/rtkit.c                          |  133 +-
 drivers/soc/fsl/qe/qmc.c                           |  658 +++--
 drivers/soc/fsl/qe/tsa.c                           |   22 +-
 drivers/soc/hisilicon/kunpeng_hccs.c               |  152 +-
 drivers/soc/hisilicon/kunpeng_hccs.h               |   15 +
 drivers/soc/mediatek/mt8188-mmsys.h                |  210 ++
 drivers/soc/mediatek/mtk-mmsys.c                   |   39 +
 drivers/soc/mediatek/mtk-mmsys.h                   |   32 +
 drivers/soc/mediatek/mtk-mutex.c                   |   51 +
 drivers/soc/mediatek/mtk-svs.c                     | 1678 +++++++------
 drivers/soc/microchip/Kconfig                      |    1 +
 drivers/soc/microchip/mpfs-sys-controller.c        |   33 +-
 drivers/soc/qcom/Kconfig                           |   13 +
 drivers/soc/qcom/Makefile                          |    2 +
 drivers/soc/qcom/llcc-qcom.c                       |  107 +-
 drivers/soc/qcom/pmic_glink.c                      |   24 +-
 drivers/soc/qcom/pmic_glink_altmode.c              |    6 +-
 drivers/soc/qcom/pmic_pdcharger_ulog.c             |  166 ++
 drivers/soc/qcom/pmic_pdcharger_ulog.h             |   36 +
 drivers/soc/qcom/socinfo.c                         |   13 +-
 drivers/soc/renesas/Kconfig                        |    1 +
 drivers/soc/renesas/renesas-soc.c                  |    4 -
 drivers/soc/samsung/exynos-chipid.c                |    1 +
 drivers/soc/sifive/Kconfig                         |   10 -
 drivers/soc/sifive/Makefile                        |    3 -
 drivers/soc/ti/k3-socinfo.c                        |   73 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |    7 +-
 drivers/soc/xilinx/zynqmp_power.c                  |   16 +-
 drivers/tee/optee/call.c                           |  161 +-
 drivers/tee/optee/core.c                           |   62 +-
 drivers/tee/optee/device.c                         |   17 +-
 drivers/tee/optee/ffa_abi.c                        |  107 +-
 drivers/tee/optee/optee_ffa.h                      |   28 +-
 drivers/tee/optee/optee_private.h                  |   40 +-
 drivers/tee/optee/smc_abi.c                        |  112 +-
 drivers/tee/tee_core.c                             |    8 +
 drivers/tee/tee_shm.c                              |   78 +-
 drivers/tty/serial/samsung_tty.c                   |   16 +
 drivers/usb/typec/ucsi/ucsi.c                      |    3 +
 drivers/usb/typec/ucsi/ucsi.h                      |    3 +
 drivers/usb/typec/ucsi/ucsi_glink.c                |   13 +
 drivers/watchdog/s3c2410_wdt.c                     |   85 +-
 include/dt-bindings/arm/qcom,ids.h                 |    1 +
 include/dt-bindings/clock/google,gs101.h           |  392 +++
 include/dt-bindings/reset/amlogic,c3-reset.h       |  119 +
 include/linux/apple-mailbox.h                      |   19 -
 include/linux/firmware.h                           |    2 +
 include/linux/soc/apple/rtkit.h                    |   18 -
 include/linux/soc/mediatek/mtk-mmsys.h             |    8 +
 include/linux/tee_drv.h                            |   16 +
 include/soc/fsl/qe/qmc.h                           |   27 +-
 include/soc/microchip/mpfs.h                       |    2 +
 include/soc/tegra/mc.h                             |    1 +
 lib/test_firmware.c                                |    1 +
 sound/soc/fsl/fsl_qmc_audio.c                      |    2 +-
 169 files changed, 7828 insertions(+), 2092 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/google,gs101=
-clock.yaml
 rename drivers/{soc/sifive =3D> cache}/sifive_ccache.c (81%)
 create mode 100644 drivers/clk/samsung/clk-gs101.c
 create mode 100644 drivers/firmware/microchip/Kconfig
 create mode 100644 drivers/firmware/microchip/Makefile
 create mode 100644 drivers/firmware/microchip/mpfs-auto-update.c
 delete mode 100644 drivers/mailbox/apple-mailbox.c
 create mode 100644 drivers/soc/apple/mailbox.c
 create mode 100644 drivers/soc/apple/mailbox.h
 create mode 100644 drivers/soc/qcom/pmic_pdcharger_ulog.c
 create mode 100644 drivers/soc/qcom/pmic_pdcharger_ulog.h
 delete mode 100644 drivers/soc/sifive/Kconfig
 delete mode 100644 drivers/soc/sifive/Makefile
 create mode 100644 include/dt-bindings/clock/google,gs101.h
 create mode 100644 include/dt-bindings/reset/amlogic,c3-reset.h
 delete mode 100644 include/linux/apple-mailbox.h

