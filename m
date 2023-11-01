Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26657DE90E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbjKAXiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbjKAXiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:38:16 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94610C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:38:09 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BDFB5C01A3;
        Wed,  1 Nov 2023 19:38:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 19:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1698881889; x=1698968289; bh=X5Fp6eSysdeHILCdMM2vKLOQRL4Or2GY2a8
        H7ifGgO8=; b=dbn9FOC+7ml25GXqaGoUoc037VlowAKtcM8VK4dce1idavWEqoZ
        GUrZW+1Lqs28IENi/U9f4Tw+zaGlt/selEgJnY/nqDr/75muL9U5IMiqRX37d4Ud
        vHxeuiqVO0w8joZB0I4djR9g8sAC/LEh13umASrLKtPSABWpit9tS6JpH07YES2y
        mCc5XMGw4YLH5U4JVSN8hWcToLtS0ZICnd+hMqf3n+oZUcYT04XW/ZGOKu3gVz4b
        jvnhD3joU9LpkrgSKgCkeQflQpmKXr5K3Z/e8+erG2FHE9/y9rfALPTvSmJZTW7V
        ukOIUJjs7ZEmKWDIwIYzqVPiirOCwwuwzWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698881889; x=1698968289; bh=X5Fp6eSysdeHILCdMM2vKLOQRL4Or2GY2a8
        H7ifGgO8=; b=Tj35AvXaDvkCwNp+aFZDIf1XWcj65gAdfwm4dtijNUaAjTNrNlo
        BA5oQRc95x+KqNWGXfLVydqoO0+qKGdPEuTdoNrrvuDiAabNr8b4J8TSMrnLgpJD
        09pSK3futQjiwtWGxbAkhlDsw4qO6ATPV4UiJ5ZcyGFHewC9w7uDfrIl+djrYiWU
        AqaLgtfaQuqjHm919lpyk4ytRAQygsw+LHtYeCFPMTyVsZIAYhBl+i91UShQ1qPj
        X9cRzm02YmBKkVBHVQ3Pj+T5Rvz14c8ATJIlybjbrSC13VoXFII7kT1fnPwTWhoG
        BOhkSBfjUF/44i9GYpX7njmpnSMOND34qXA==
X-ME-Sender: <xms:YOFCZR2VTIGGnYfpZ9avdRw1aeo7RX8O_l6IjVk-aFjPxYhEZIT6nQ>
    <xme:YOFCZYGnRcBgTQhY9SV68r59j7I8NSa7NgJ3x08ye1Er4rXSIZIjcxF47bjuyeR3M
    vi7EyZFjQRTJ1gfpQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpedvleetveeffeeuleehvdehfeffkeeggeffkeejkeeiieehffevuddvleej
    ueejgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhpvghnghhuthhrohhnihigrd
    guvgdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YOFCZR6QcrKxW9dhUmZrH7trRxZE69YfbF79Oe3HaxBlxnT2PzeU4Q>
    <xmx:YOFCZe28zQyVviy_M0WzaPFH0f-pG3eQ-lrn-8lBUaggxVgYabgrUA>
    <xmx:YOFCZUEjFjhFuFAnyX9kDTL25cGFP08pbyHldc8kGMUI1zT0fwU_9A>
    <xmx:YeFCZeOYdAsoP9SIDZ4_cX2D21A0vEjTSq3NlPxyURRSaJWPhn6hcA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 91E85B60089; Wed,  1 Nov 2023 19:38:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <6a235abf-d3c0-4d05-8cbd-e6be739ec59c@app.fastmail.com>
In-Reply-To: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
References: <263c2cf0-c35a-4d3c-85b3-fcb692cbfd40@app.fastmail.com>
Date:   Thu, 02 Nov 2023 00:37:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] SoC driver updates for 6.7
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c=
0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.7

for you to fetch changes up to dfae947836d867e127e2b64f981ebb299c28f0dc:

  Merge tag 'qcom-drivers-for-6.7-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/drivers (2023-10-25 22:58:30 +0200)

----------------------------------------------------------------
SoC driver updates for 6.7

The highlights for the driver support this time are

 - Qualcomm platforms gain support for the Qualcomm Secure Execution
   Environment firmware interface to access EFI variables on certain
   devices, and new features for multiple platform and firmware drivers.

 - Arm FF-A firmware support gains support for v1.1 specification featur=
es,
   in particular notification and memory transaction descriptor changes.

 - SCMI firmware support now support v3.2 features for clock and DVFS
   configuration and a new transport for Qualcomm platforms.

 - Minor cleanups and bugfixes are added to pretty much all the active
   platforms: qualcomm, broadcom, dove, ti-k3, rockchip, sifive, amlogic,
   atmel, tegra, aspeed, vexpress, mediatek, samsung and more.
   In particular, this contains portions of the treewide conversion to
   use __counted_by annotations and the device_get_match_data helper.

----------------------------------------------------------------
Alexey Romanov (1):
      drivers: meson: sm: correct meson_sm_* API retval handling

Arnd Bergmann (19):
      Merge tag 'platform-remove-void-soc-for-6.7-rc' of https://git.pen=
gutronix.de/git/ukl/linux into soc/drivers
      Merge tag 'renesas-drivers-for-v6.7-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'v6.6-next-soc' of https://git.kernel.org/pub/scm/linux/=
kernel/git/matthias.bgg/linux into soc/drivers
      Merge tag 'vexpress-update-6.7' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'scmi-updates-6.7' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'ffa-updates-6.7' of git://git.kernel.org/pub/scm/linux/=
kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'tegra-for-6.7-soc' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.7-firmware' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.7-memory' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'aspeed-6.7-soc' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/joel/bmc into soc/drivers
      Merge tag 'memory-controller-drv-6.7' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.7' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'riscv-soc-for-v6.7' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/conor/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.7' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'v6.7-rockchip-drivers1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.7' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'mvebu-arm-6.7-1' of git://git.kernel.org/pub/scm/linux/=
kernel/git/gclement/mvebu into soc/drivers
      Merge tag 'arm-soc/for-6.7/drivers' of https://github.com/Broadcom=
/stblinux into soc/drivers
      Merge tag 'qcom-drivers-for-6.7-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into soc/drivers

Bartosz Golaszewski (6):
      firmware: qcom-scm: drop unneeded 'extern' specifiers
      firmware: qcom-scm: order includes alphabetically
      firmware: qcom: qseecom: add missing include guards
      firmware: qcom: move Qualcomm code into its own directory
      firmware: qcom: scm: add a missing forward declaration for struct =
device
      firmware: qcom: scm: remove unneeded 'extern' specifiers

Bjorn Andersson (3):
      firmware: qcom: qseecom: Add missing AUXILIARY_BUS dependency
      dt-bindings: reserved-memory: rmtfs: Allow guard pages
      soc: qcom: rmtfs: Support discarding guard pages

Claudiu Beznea (2):
      soc: renesas: Identify RZ/G3S SoC
      soc: renesas: renesas-soc: Remove blank lines

Conor Dooley (1):
      soc: sifive: replace SOC_FOO with ARCH_FOO

Cristian Marussi (6):
      firmware: arm_scmi: Simplify enable/disable clock operations
      firmware: arm_scmi: Add clock v3.2 CONFIG_SET support
      firmware: arm_scmi: Add v3.2 clock CONFIG_GET support
      firmware: arm_scmi: Add clock .state_get support to pre-v3.2
      clk: scmi: Add support for .is_enabled clk_ops
      firmware: arm_scmi: Add clock OEM config clock operations

Danila Tikhonov (3):
      dt-bindings: arm: qcom,ids: Add Soc ID for SM7150P
      soc: qcom: socinfo: Add Soc ID for SM7150P
      dt-bindings: firmware: document Qualcomm SM7150 SCM

Deming Wang (1):
      firmware: tegra: Fix a typo

Dhruva Gole (1):
      firmware: ti_sci: Mark driver as non removable

Dmitry Baryshkov (1):
      soc: qcom: pmic_glink: fix connector type to be DisplayPort

Geert Uytterhoeven (1):
      soc: renesas: Kconfig: Remove blank line before ARCH_R9A07G043 hel=
p text

Gustavo A. R. Silva (1):
      soc: qcom: apr: Add __counted_by for struct apr_rx_buf and use str=
uct_size()

Jia Jie Ho (1):
      riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE

Jinjie Ruan (1):
      firmware: ti_sci: Use list_for_each_entry() helper

Jon Hunter (1):
      memory: tegra: Add Tegra234 clients for RCE and VI

Julia Lawall (1):
      soc: dove: add missing of_node_put

Justin Stitt (1):
      firmware: ti_sci: refactor deprecated strncpy

Kathiravan Thirumoorthy (1):
      firmware: qcom_scm: use 64-bit calling convention only when client=
 is 64-bit

Kees Cook (3):
      memory: atmel-ebi: Annotate struct atmel_ebi_dev with __counted_by
      bus: vexpress-config: Annotate struct vexpress_syscfg_func with __=
counted_by
      soc: qcom: smem: Annotate struct qcom_smem with __counted_by

Kieran Bingham (1):
      firmware: raspberrypi: Fix devm_rpi_firmware_get documentation

Komal Bajaj (6):
      dt-bindings: cache: qcom,llcc: Add LLCC compatible for QDU1000/QRU=
1000
      soc: qcom: llcc: Refactor llcc driver to support multiple configur=
ation
      nvmem: core: Add stub for nvmem_cell_read_u8
      soc: qcom: Add LLCC support for multi channel DDR
      soc: qcom: llcc: Updating the macro name
      soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support

Konrad Dybcio (2):
      soc: qcom: socinfo: Add SM8550-adjacent PMICs
      dt-bindings: qcom: geni-se: Allow dma-coherent

Li Zetao (1):
      soc: qcom: wcnss_ctrl: Remove redundant initialization owner in wc=
nss_ctrl_driver

Lu Hongfei (1):
      soc: qcom: pmic: Fix resource leaks in a device_for_each_child_nod=
e() loop

Luca Weiss (3):
      dt-bindings: arm: qcom,ids: Add SoC ID for QCM6490
      soc: qcom: socinfo: Add SoC ID for QCM6490
      soc: qcom: pmic_glink_altmode: Print return value on error

Mark Tseng (3):
      dt-bindings: soc: mediatek: add mt8188 svs dt-bindings
      soc: mediatek: svs: Add support for MT8188 SoC
      soc: mediatek: svs: Add support for voltage bins

Maximilian Luz (3):
      lib/ucs2_string: Add UCS-2 strscpy function
      firmware: qcom_scm: Add support for Qualcomm Secure Execution Envi=
ronment SCM interface
      firmware: Add support for Qualcomm UEFI Secure Application

Neha Malcom Francis (2):
      soc: ti: k3-socinfo: Fix typo in bitfield documentation
      soc: ti: k3-socinfo: Avoid overriding return value

Nikunj Kela (2):
      dt-bindings: arm: Add new compatible for smc/hvc transport for SCMI
      firmware: arm_scmi: Add qcom smc/hvc transport support

Peng Fan (2):
      firmware: arm_scmi: Add support for clock parents
      clk: scmi: Add support for clock {set,get}_parent

Peter Robinson (2):
      soc: bcm: brcmstb: depend on ARCH_BRCMSTB over arm arches
      bus: brcmstb_gisb: Depend on SoC specifics over generic arm

Rob Herring (6):
      dt-bindings: memory-controllers: Make "additionalProperties: true"=
 explicit
      firmware: arm_scpi: Use device_get_match_data()
      firmware: meson: Use device_get_match_data()
      memory: Use device_get_match_data()
      firmware: ti_sci: Use device_get_match_data()
      soc: ti: knav_qmss_queue: Use device_get_match_data()

Robert Marko (5):
      dt-bindings: arm: qcom,ids: Add IDs for IPQ8174 family
      soc: qcom: socinfo: Add IDs for IPQ8174 family
      dt-bindings: firmware: qcom,scm: support indicating SDI default st=
ate
      firmware: qcom_scm: disable SDI if required
      dt-bindings: firmware: qcom,scm: document IPQ5018 compatible

Sudeep Holla (26):
      firmware: arm_scmi: Move power-domain driver to the pmdomain dir
      firmware: arm_scmi: Do not use !! on boolean when setting msg->fla=
gs
      firmware: arm_scmi: Rename scmi_{msg_,}clock_config_{get,set}_{2,2=
1}
      Merge branch 'opp/pm-domain-scmi' of git://git.kernel.org/pub/scm/=
linux/kernel/git/vireshk/pm into for-next/scmi/updates
      firmware: arm_ffa: Assign the missing IDR allocation ID to the FFA=
 device
      firmware: arm_ffa: Allow the FF-A drivers to use 32bit mode of mes=
saging
      firmware: arm_ffa: Emit modalias for FF-A devices
      firmware: arm_ffa: Update the FF-A command list with v1.1 additions
      firmware: arm_ffa: Implement notification bitmap create and destro=
y interfaces
      firmware: arm_ffa: Implement the notification bind and unbind inte=
rface
      firmware: arm_ffa: Implement the FFA_RUN interface
      firmware: arm_ffa: Implement the FFA_NOTIFICATION_SET interface
      firmware: arm_ffa: Implement the FFA_NOTIFICATION_GET interface
      firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface
      firmware: arm_ffa: Initial support for scheduler receiver interrupt
      firmware: arm_ffa: Add schedule receiver callback mechanism
      firmware: arm_ffa: Add interfaces to request notification callbacks
      firmware: arm_ffa: Add interface to send a notification to a given=
 partition
      firmware: arm_ffa: Add notification handling mechanism
      firmware: arm_ffa: Simplify the computation of transmit and fragme=
nt length
      clk: scmi: Free scmi_clk allocated when the clocks with invalid in=
fo are skipped
      KVM: arm64: FFA: Remove access of endpoint memory access descripto=
r array
      firmware: arm_ffa: Switch to using ffa_mem_desc_offset() accessor
      firmware: arm_ffa: Update memory descriptor to support v1.1 format
      firmware: arm_ffa: Upgrade the driver version to v1.1
      firmware: arm_scmi: Convert u32 to unsigned long to align with arm=
_smccc_1_1_invoke()

Sumit Gupta (1):
      firmware: tegra: Add suspend hook and reset BPMP IPC early on resu=
me

Thierry Reding (2):
      Merge branch 'for-6.7/firmware' into for-6.7/memory
      memory: tegra: Set BPMP msg flags to reset IPC channels

Ulf Hansson (22):
      firmware: arm_scmi: Extend perf protocol ops to get number of doma=
ins
      firmware: arm_scmi: Extend perf protocol ops to get information of=
 a domain
      cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
      firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
      firmware: arm_scmi: Drop redundant ->device_domain_id() from perf =
ops
      cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
      dt-bindings: arm: cpus: Add a power-domain-name for a performance-=
domain
      dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
      dt-bindings: power: Clarify performance capabilities of power-doma=
ins
      cpufreq: scmi: Add support to parse domain-id using #power-domain-=
cells
      PM: domains: Allow genpd providers to manage OPP tables directly b=
y its FW
      pmdomain: arm: Add the SCMI performance domain
      PM: domains: Introduce dev_pm_domain_set_performance_state()
      PM: domains: Implement the ->set_performance_state() callback for =
genpd
      OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
      OPP: Extend dev_pm_opp_data with a level
      OPP: Switch to use dev_pm_domain_set_performance_state()
      OPP: Extend support for the opp-level beyond required-opps
      firmware: arm_scmi: Simplify error path in scmi_dvfs_device_opps_a=
dd()
      firmware: arm_scmi: Specify the performance level when adding an O=
PP
      firmware: arm_scmi: Add generic OPP support to the SCMI performanc=
e domain
      soc/tegra: pmc: Drop the ->opp_to_performance_state() callback

Unnathi Chalicheemala (1):
      soc: qcom: Switch to EXPORT_SYMBOL_GPL()

Uwe Kleine-K=C3=B6nig (37):
      soc/microchip: mpfs-sys-controller: Convert to platform remove cal=
lback returning void
      soc: qcom: llcc: Handle a second device without data corruption
      soc/rockchip: io-domain: Convert to platform remove callback retur=
ning void
      soc/ti: k3-ringacc: Convert to platform remove callback returning =
void
      soc/ti: knav_dma: Convert to platform remove callback returning vo=
id
      soc/ti: knav_qmss_queue: Convert to platform remove callback retur=
ning void
      soc/ti: pm33xx: Convert to platform remove callback returning void
      soc/ti: pruss: Convert to platform remove callback returning void
      soc/ti: smartreflex: Convert to platform remove callback returning=
 void
      soc/ti: wkup_m3_ipc: Convert to platform remove callback returning=
 void
      soc: qcom: icc-bwmon: Convert to platform remove callback returnin=
g void
      soc: qcom: llcc-qcom: Convert to platform remove callback returnin=
g void
      soc: qcom: ocmem: Convert to platform remove callback returning vo=
id
      soc: qcom: pmic_glink: Convert to platform remove callback returni=
ng void
      soc: qcom: qcom_aoss: Convert to platform remove callback returnin=
g void
      soc: qcom: qcom_gsbi: Convert to platform remove callback returnin=
g void
      soc: qcom: qcom_stats: Convert to platform remove callback returni=
ng void
      soc: qcom: rmtfs_mem: Convert to platform remove callback returnin=
g void
      soc: qcom: smem: Convert to platform remove callback returning void
      soc: qcom: smp2p: Convert to platform remove callback returning vo=
id
      soc: qcom: smsm: Convert to platform remove callback returning void
      soc: qcom: socinfo: Convert to platform remove callback returning =
void
      soc/tegra: cbb: tegra194-cbb: Convert to platform remove callback =
returning void
      soc/aspeed: Convert to platform remove callback returning void
      soc/fsl: dpaa2-console: Convert to platform remove callback return=
ing void
      soc/fsl: cpm: qmc: Convert to platform remove callback returning v=
oid
      soc/fsl: cpm: tsa: Convert to platform remove callback returning v=
oid
      soc/fujitsu: a64fx-diag: Convert to platform remove callback retur=
ning void
      soc/hisilicon: kunpeng_hccs: Convert to platform remove callback r=
eturning void
      soc/ixp4xx: ixp4xx-npe: Convert to platform remove callback return=
ing void
      soc/ixp4xx: ixp4xx-qmgr: Convert to platform remove callback retur=
ning void
      soc/litex: litex_soc_ctrl: Convert to platform remove callback ret=
urning void
      soc/loongson: loongson2_guts: Convert to platform remove callback =
returning void
      soc/mediatek: mtk-devapc: Convert to platform remove callback retu=
rning void
      soc/mediatek: mtk-mmsys: Convert to platform remove callback retur=
ning void
      soc/pxa: ssp: Convert to platform remove callback returning void
      soc: samsung: exynos-chipid: Convert to platform remove callback r=
eturning void

 Documentation/devicetree/bindings/arm/cpus.yaml    |   4 +-
 .../devicetree/bindings/cache/qcom,llcc.yaml       |  10 +
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  15 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |  10 +
 .../bindings/memory-controllers/ingenic,nemc.yaml  |   1 +
 .../memory-controllers/renesas,rpc-if.yaml         |   2 +
 .../bindings/memory-controllers/ti,gpmc.yaml       |   2 +-
 .../devicetree/bindings/power/power-domain.yaml    |  17 +-
 .../bindings/reserved-memory/qcom,rmtfs-mem.yaml   |  11 +
 .../devicetree/bindings/soc/mediatek/mtk-svs.yaml  |   1 +
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   2 +
 MAINTAINERS                                        |  13 +
 arch/arm64/kvm/hyp/nvhe/ffa.c                      |  10 +-
 arch/riscv/Kconfig.socs                            |   1 +
 drivers/base/power/common.c                        |  21 +
 drivers/base/power/domain.c                        |  44 +-
 drivers/bus/Kconfig                                |   2 +-
 drivers/bus/vexpress-config.c                      |   2 +-
 drivers/clk/clk-scmi.c                             |  96 ++-
 drivers/cpufreq/scmi-cpufreq.c                     |  52 +-
 drivers/firmware/Kconfig                           |  15 +-
 drivers/firmware/Makefile                          |   3 +-
 drivers/firmware/arm_ffa/bus.c                     |  16 +-
 drivers/firmware/arm_ffa/driver.c                  | 770 ++++++++++++++=
+++-
 drivers/firmware/arm_scmi/Kconfig                  |  12 +
 drivers/firmware/arm_scmi/Makefile                 |   1 -
 drivers/firmware/arm_scmi/clock.c                  | 402 +++++++++-
 drivers/firmware/arm_scmi/driver.c                 |   1 +
 drivers/firmware/arm_scmi/perf.c                   | 112 ++-
 drivers/firmware/arm_scmi/powercap.c               |   4 +-
 drivers/firmware/arm_scmi/smc.c                    |  35 +-
 drivers/firmware/arm_scpi.c                        |  13 +-
 drivers/firmware/meson/meson_sm.c                  |  25 +-
 drivers/firmware/qcom/Kconfig                      |  56 ++
 drivers/firmware/qcom/Makefile                     |   9 +
 drivers/firmware/qcom/qcom_qseecom.c               | 120 +++
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c    | 871 ++++++++++++++=
+++++++
 drivers/firmware/{ =3D> qcom}/qcom_scm-legacy.c      |   0
 drivers/firmware/{ =3D> qcom}/qcom_scm-smc.c         |   0
 drivers/firmware/{ =3D> qcom}/qcom_scm.c             | 448 ++++++++++-
 drivers/firmware/{ =3D> qcom}/qcom_scm.h             |  16 +-
 drivers/firmware/raspberrypi.c                     |   1 +
 drivers/firmware/tegra/bpmp.c                      |  30 +
 drivers/firmware/ti_sci.c                          |  69 +-
 drivers/memory/atmel-ebi.c                         |  16 +-
 drivers/memory/brcmstb_memc.c                      |   9 +-
 drivers/memory/fsl-corenet-cf.c                    |  11 +-
 drivers/memory/tegra/tegra234.c                    |  64 ++
 drivers/opp/core.c                                 |  60 +-
 drivers/opp/of.c                                   |  10 +-
 drivers/opp/opp.h                                  |   2 +-
 drivers/pmdomain/Makefile                          |   1 +
 drivers/pmdomain/arm/Makefile                      |   4 +
 drivers/pmdomain/arm/scmi_perf_domain.c            | 184 +++++
 .../arm_scmi =3D> pmdomain/arm}/scmi_pm_domain.c     |   0
 drivers/soc/aspeed/aspeed-lpc-ctrl.c               |   6 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c              |   6 +-
 drivers/soc/aspeed/aspeed-p2a-ctrl.c               |   6 +-
 drivers/soc/aspeed/aspeed-uart-routing.c           |   6 +-
 drivers/soc/bcm/Kconfig                            |   2 +-
 drivers/soc/dove/pmu.c                             |   5 +-
 drivers/soc/fsl/dpaa2-console.c                    |   6 +-
 drivers/soc/fsl/qe/qmc.c                           |   6 +-
 drivers/soc/fsl/qe/tsa.c                           |   5 +-
 drivers/soc/fujitsu/a64fx-diag.c                   |   6 +-
 drivers/soc/hisilicon/kunpeng_hccs.c               |   6 +-
 drivers/soc/ixp4xx/ixp4xx-npe.c                    |   6 +-
 drivers/soc/ixp4xx/ixp4xx-qmgr.c                   |   5 +-
 drivers/soc/litex/litex_soc_ctrl.c                 |   5 +-
 drivers/soc/loongson/loongson2_guts.c              |   6 +-
 drivers/soc/mediatek/mtk-devapc.c                  |   6 +-
 drivers/soc/mediatek/mtk-mmsys.c                   |   6 +-
 drivers/soc/mediatek/mtk-svs.c                     | 184 ++++-
 drivers/soc/microchip/mpfs-sys-controller.c        |   6 +-
 drivers/soc/pxa/ssp.c                              |   6 +-
 drivers/soc/qcom/apr.c                             |   4 +-
 drivers/soc/qcom/cmd-db.c                          |   8 +-
 drivers/soc/qcom/icc-bwmon.c                       |   6 +-
 drivers/soc/qcom/kryo-l2-accessors.c               |   4 +-
 drivers/soc/qcom/llcc-qcom.c                       | 367 ++++++---
 drivers/soc/qcom/ocmem.c                           |  12 +-
 drivers/soc/qcom/pdr_interface.c                   |   8 +-
 drivers/soc/qcom/pmic_glink.c                      |   6 +-
 drivers/soc/qcom/pmic_glink_altmode.c              |  46 +-
 drivers/soc/qcom/qcom-geni-se.c                    |  38 +-
 drivers/soc/qcom/qcom_aoss.c                       |  12 +-
 drivers/soc/qcom/qcom_gsbi.c                       |   6 +-
 drivers/soc/qcom/qcom_stats.c                      |   6 +-
 drivers/soc/qcom/qmi_encdec.c                      |   6 +-
 drivers/soc/qcom/qmi_interface.c                   |  20 +-
 drivers/soc/qcom/rmtfs_mem.c                       |  15 +-
 drivers/soc/qcom/rpmh.c                            |   8 +-
 drivers/soc/qcom/smd-rpm.c                         |   2 +-
 drivers/soc/qcom/smem.c                            |  10 +-
 drivers/soc/qcom/smp2p.c                           |   6 +-
 drivers/soc/qcom/smsm.c                            |   6 +-
 drivers/soc/qcom/socinfo.c                         |  17 +-
 drivers/soc/qcom/wcnss_ctrl.c                      |   3 +-
 drivers/soc/renesas/Kconfig                        |   7 +-
 drivers/soc/renesas/renesas-soc.c                  |  15 +-
 drivers/soc/rockchip/io-domain.c                   |   6 +-
 drivers/soc/samsung/exynos-chipid.c                |   6 +-
 drivers/soc/sifive/Kconfig                         |   2 +-
 drivers/soc/tegra/cbb/tegra194-cbb.c               |   6 +-
 drivers/soc/tegra/pmc.c                            |   8 -
 drivers/soc/ti/k3-ringacc.c                        |   5 +-
 drivers/soc/ti/k3-socinfo.c                        |   7 +-
 drivers/soc/ti/knav_dma.c                          |   6 +-
 drivers/soc/ti/knav_qmss_queue.c                   |  13 +-
 drivers/soc/ti/pm33xx.c                            |   5 +-
 drivers/soc/ti/pruss.c                             |   6 +-
 drivers/soc/ti/smartreflex.c                       |   5 +-
 drivers/soc/ti/wkup_m3_ipc.c                       |   6 +-
 include/dt-bindings/arm/qcom,ids.h                 |   5 +
 include/linux/arm_ffa.h                            |  79 +-
 include/linux/firmware/meson/meson_sm.h            |   2 +-
 include/linux/firmware/qcom/qcom_qseecom.h         |  52 ++
 include/linux/firmware/qcom/qcom_scm.h             | 123 +--
 include/linux/nvmem-consumer.h                     |   6 +
 include/linux/pm.h                                 |   2 +
 include/linux/pm_domain.h                          |  11 +
 include/linux/pm_opp.h                             |  31 +-
 include/linux/scmi_protocol.h                      |  43 +-
 include/linux/soc/qcom/llcc-qcom.h                 |   2 +-
 include/linux/ucs2_string.h                        |   1 +
 include/soc/tegra/bpmp-abi.h                       |   2 +-
 include/soc/tegra/bpmp.h                           |   6 +
 lib/ucs2_string.c                                  |  52 ++
 128 files changed, 4395 insertions(+), 737 deletions(-)
 create mode 100644 drivers/firmware/qcom/Kconfig
 create mode 100644 drivers/firmware/qcom/Makefile
 create mode 100644 drivers/firmware/qcom/qcom_qseecom.c
 create mode 100644 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
 rename drivers/firmware/{ =3D> qcom}/qcom_scm-legacy.c (100%)
 rename drivers/firmware/{ =3D> qcom}/qcom_scm-smc.c (100%)
 rename drivers/firmware/{ =3D> qcom}/qcom_scm.c (76%)
 rename drivers/firmware/{ =3D> qcom}/qcom_scm.h (91%)
 create mode 100644 drivers/pmdomain/arm/Makefile
 create mode 100644 drivers/pmdomain/arm/scmi_perf_domain.c
 rename drivers/{firmware/arm_scmi =3D> pmdomain/arm}/scmi_pm_domain.c (=
100%)
 create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h
