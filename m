Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DBA7CB378
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjJPTtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJPTtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:49:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0092E83;
        Mon, 16 Oct 2023 12:49:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED27C433C7;
        Mon, 16 Oct 2023 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697485755;
        bh=+3wcWDraNKcP5p0kCJoQlx1vnP3Yz0mPOJeHOrWaark=;
        h=From:To:Cc:Subject:Date:From;
        b=qXNras04vSWoqEThdV68DJhhVgkxnPbSYiQJDnqm8vm1W+Md4E+uwIqzNl6Scl/pl
         +uj7CfOKnVasYBu5m3wMCqgfzLc5Qg308NtER1D8v/UP8BNn6L/JLo9M377u6ycmP6
         eowFYRh3IvClLBY0Xw97wXb9NAmZOu9xa5wHv9V0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.5 000/190] 6.5.8-rc2 review
Date:   Mon, 16 Oct 2023 21:48:57 +0200
Message-ID: <20231016185002.371937173@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.8-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.5.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.5.8-rc2
X-KernelTest-Deadline: 2023-10-18T18:50+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 6.5.8 release.
There are 190 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 18 Oct 2023 18:48:18 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.8-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.5.8-rc2

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed two speaker platform

Amir Goldstein <amir73il@gmail.com>
    ovl: fix regression in showing lowerdir mount option

Amir Goldstein <amir73il@gmail.com>
    ovl: make use of ->layers safe in rcu pathwalk

Amir Goldstein <amir73il@gmail.com>
    ovl: fix regression in parsing of mount options with escaped comma

Amir Goldstein <amir73il@gmail.com>
    fs: factor out vfs_parse_monolithic_sep() helper

Matthew Wilcox (Oracle) <willy@infradead.org>
    fs: Fix kernel-doc warnings

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE

Duoming Zhou <duoming@zju.edu.cn>
    dmaengine: mediatek: Fix deadlock caused by synchronize_irq()

Rex Zhang <rex.zhang@intel.com>
    dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq

Linus Torvalds <torvalds@linux-foundation.org>
    Revert "x86/smp: Put CPUs into INIT on shutdown if possible"

Javier Carrasco <javier.carrasco@wolfvision.net>
    usb: misc: onboard_hub: add support for Microchip USB2412 USB 2.0 hub

Hui Liu <quic_huliu@quicinc.com>
    usb: typec: qcom: Update the logic of regulator enable and disable

Pawel Laszczak <pawell@cadence.com>
    usb: cdnsp: Fixes issue with dequeuing not queued requests

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call

Piyush Mehta <piyush.mehta@amd.com>
    usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Prashanth K <quic_prashk@quicinc.com>
    usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command fails

RD Babiera <rdbabiera@google.com>
    usb: typec: altmodes/displayport: Signal hpd low when exiting mode

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: typec: ucsi: Fix missing link removal

Jiexun Wang <wangjiexun@tinylab.org>
    RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK

Song Shuai <songshuaishuai@tinylab.org>
    riscv: Remove duplicate objcopy flag

Linu Cherian <lcherian@marvell.com>
    coresight: Fix run time warnings while reusing ETR buffer

Dharma Balasubiramani <dharma.b@microchip.com>
    counter: microchip-tcb-capture: Fix the use of internal GCLK logic

Fabrice Gasnier <fabrice.gasnier@foss.st.com>
    counter: chrdev: fix getting array extensions

Björn Töpel <bjorn@rivosinc.com>
    riscv: Only consider swbp/ss handlers for correct privileged mode

Peter Wang <peter.wang@mediatek.com>
    scsi: ufs: core: Correct clear TM error log

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    pinctrl: avoid unsafe code pattern in find_pinctrl()

Christian König <christian.koenig@amd.com>
    dma-buf: add dma_fence_timestamp helper

Michal Koutný <mkoutny@suse.com>
    cgroup: Remove duplicates in cgroup v1 tasks file

Mario Limonciello <mario.limonciello@amd.com>
    usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power supply scope

Johan Hovold <johan+linaro@kernel.org>
    power: supply: qcom_battmgr: fix enable request endianness

Sebastian Reichel <sebastian.reichel@collabora.com>
    power: supply: qcom_battmgr: fix battery_id type

Miquel Raynal <miquel.raynal@bootlin.com>
    can: sja1000: Always restart the Tx queue after an overrun

Yanguo Li <yanguo.li@corigine.com>
    nfp: flower: avoid rmmod nfp crash issues

Sarthak Kukreti <sarthakkukreti@chromium.org>
    block: Don't invalidate pagecache for invalid falloc modes

Jeremy Kerr <jk@codeconstruct.com.au>
    mctp: perform route lookups under a RCU read-side lock

Rijo Thomas <Rijo-john.Thomas@amd.com>
    tee: amdtee: fix use-after-free vulnerability in amdtee_close_session

Hans de Goede <hdegoede@redhat.com>
    Input: goodix - ensure int GPIO is in input for gpio_count == 1 && gpio_int_idx == 0 case

Max Nguyen <maxwell.nguyen@hp.com>
    Input: xpad - add HyperX Clutch Gladiate Support

Szilard Fabian <szfabian@bluemarch.art>
    Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table

Matthias Berndt <matthias_berndt@gmx.de>
    Input: xpad - add PXN V900 support

Jeffery Miller <jefferymiller@google.com>
    Input: psmouse - fix fast_reconnect function for PS/2 mode

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    Input: powermate - fix use-after-free in powermate_config_complete

Dan Carpenter <dan.carpenter@linaro.org>
    ceph: fix type promotion bug on 32bit systems

Xiubo Li <xiubli@redhat.com>
    ceph: fix incorrect revoked caps assert in ceph_fill_file_size()

Jordan Rife <jrife@google.com>
    libceph: use kernel_connect()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/47x: Fix 47x syscall return crash

Athira Rajeev <atrajeev@linux.vnet.ibm.com>
    powerpc/pseries: Fix STK_PARAM access in the hcall tracing code

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Restart XDomain discovery handshake after failure

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Correct TMU mode initialization from hardware

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge

Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
    mcb: remove is_added flag from mcb_device struct

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/alternatives: Disable KASAN in apply_alternatives()

Borislav Petkov (AMD) <bp@alien8.de>
    x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

JP Kobryn <inwardvessel@gmail.com>
    perf/x86/lbr: Filter vsyscall addresses

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: not allow to open file if delelete on close bit is set

Carlos Llamas <cmllamas@google.com>
    binder: fix memory leaks of spam and pending work

Tony Lindgren <tony@atomide.com>
    serial: core: Fix checks for tx runtime PM state

Tony Lindgren <tony@atomide.com>
    serial: 8250_omap: Fix errors with no_console_suspend

Lukas Wunner <lukas@wunner.de>
    serial: Reduce spinlocked portion of uart_rs485_config()

Hans de Goede <hdegoede@redhat.com>
    ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q to irq1_edge_low_force_override[]

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA

Zack Rusin <zackr@vmware.com>
    drm/vmwgfx: Keep a gem reference to user bos in surfaces

Daniel Miess <daniel.miess@amd.com>
    drm/amd/display: Don't set dpms_off for seamless boot

Christian König <christian.koenig@amd.com>
    drm/amdgpu: add missing NULL check

Simon Ser <contact@emersion.fr>
    drm/atomic-helper: relax unregistered connector check

Joey Gouly <joey.gouly@arm.com>
    drm/tiny: correctly print `struct resource *` on error

Matthew Wilcox (Oracle) <willy@infradead.org>
    drm: Do not overrun array in drm_gem_get_pages()

Macpaul Lin <macpaul.lin@mediatek.com>
    arm64: dts: mediatek: mt8195-demo: update and reorder reserved memory regions

Macpaul Lin <macpaul.lin@mediatek.com>
    arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB

Hans de Goede <hdegoede@redhat.com>
    media: subdev: Don't report V4L2_SUBDEV_CAP_STREAMS when the streams API is disabled

Antoniu Miclaus <antoniu.miclaus@analog.com>
    iio: addac: Kconfig: update ad74413r selections

Alisa-Dariana Roman <alisa.roman@analog.com>
    iio: adc: ad7192: Correct reference voltage

Alexander Zangerl <az@breathe-safe.com>
    iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Lakshmi Yadlapati <lakshmiy@us.ibm.com>
    iio: pressure: dps310: Adjust Timeout Settings

Antoniu Miclaus <antoniu.miclaus@analog.com>
    iio: admv1013: add mixer_vgate corner cases

Marcelo Schmitt <marcelo.schmitt1@gmail.com>
    iio: dac: ad3552r: Correct device IDs

Philipp Rossak <embed3d@gmail.com>
    iio: adc: imx8qxp: Fix address for command buffer registers

Tzung-Bi Shih <tzungbi@kernel.org>
    iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    iio: imu: bno055: Fix missing Kconfig dependencies

Phil Elwell <phil@raspberrypi.com>
    iio: pressure: bmp280: Fix NULL pointer exception

Xingxing Luo <xingxing.luo@unisoc.com>
    usb: musb: Modify the "HWVers" register address

Xingxing Luo <xingxing.luo@unisoc.com>
    usb: musb: Get the musb_qh poniter after musb_giveback

Ricardo Cañuelo <ricardo.canuelo@collabora.com>
    usb: hub: Guard against accesses to uninitialized BOS descriptors

Xiaolei Wang <xiaolei.wang@windriver.com>
    usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Soft reset phy on probe for host

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read

Lukas Wunner <lukas@wunner.de>
    xhci: Preserve RsvdP bits in ERSTBA register correctly

Lukas Wunner <lukas@wunner.de>
    xhci: Clear EHB bit only at end of interrupt handler

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: track port suspend state correctly in unsuccessful resume cases

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-mdma: set in_flight_bytes in case CRQA flag is set

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-mdma: use Link Address Register to compute residue

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-dma: fix residue in case of MDMA chaining

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg in case of MDMA chaining

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-mdma: abort resume if no ongoing transfer

Amir Goldstein <amir73il@gmail.com>
    ovl: temporarily disable appending lowedirs

Andy Chiu <andy.chiu@sifive.com>
    riscv: signal: fix sigaltstack frame size checking

Waiman Long <longman@redhat.com>
    workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    rswitch: Fix imbalance phy_power_off() calling

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    rswitch: Fix renesas_eth_sw_remove() implementation

Ratheesh Kannoth <rkannoth@marvell.com>
    octeontx2-pf: Fix page pool frag allocation warning

Jeremy Cline <jeremy@jcline.org>
    nfc: nci: assert requested protocol is valid

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_packet: Fix fortified memcpy() without flex array.

Ralph Siemsen <ralph.siemsen@linaro.org>
    pinctrl: renesas: rzn1: Enable missing PINMUX

Jakub Kicinski <kuba@kernel.org>
    net: tcp: fix crashes trying to free half-baked MTU probes

Nils Hoppmann <niho@linux.ibm.com>
    net/smc: Fix pos miscalculation in statistics

Kory Maincent <kory.maincent@bootlin.com>
    ethtool: Fix mod state of verbose no_mask bitset

Eric Dumazet <edumazet@google.com>
    net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()

Ilya Leoshkevich <iii@linux.ibm.com>
    s390/bpf: Fix unwinding past the trampoline

Ilya Leoshkevich <iii@linux.ibm.com>
    s390/bpf: Fix clobbering the caller's backchain in the trampoline

Will Mortensen <will@extrahop.com>
    net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp

Gerd Bayer <gbayer@linux.ibm.com>
    net/smc: Fix dependency of SMC on ISM

Dan Carpenter <dan.carpenter@linaro.org>
    ixgbe: fix crash with empty VF macvlan list

Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
    drm/panel: boe-tv101wum-nl6: Completely pull GPW to VGL before TP term

Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
    net/mlx5e: macsec: use update_pn flag instead of PN comparation

Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
    net: phy: mscc: macsec: reject PN update requests

Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
    net: macsec: indicate next pn update when offloading

Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
    octeontx2-pf: mcs: update PN only when update_pn is true

Eric Dumazet <edumazet@google.com>
    net: refine debug info in skb_checksum_help()

David Vernet <void@manifault.com>
    bpf: Fix verifier log for async callback return values

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    drm/vmwgfx: fix typo of sizeof argument

Andrew Kanner <andrew.kanner@gmail.com>
    xdp: Fix zero-size allocation warning in xskq_create()

Björn Töpel <bjorn@rivosinc.com>
    riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values

Björn Töpel <bjorn@rivosinc.com>
    riscv, bpf: Sign-extend return values

Roger Pau Monne <roger.pau@citrix.com>
    xen-netback: use default TX queue size for vifs

Dan Carpenter <dan.carpenter@linaro.org>
    mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix use-after-free issue in ravb_tx_timeout_work()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix up dma_free_coherent() call in ravb_remove()

Moshe Shemesh <moshe@nvidia.com>
    devlink: Hold devlink lock on health reporter dump get

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8195: Set DSU PMU status to fail

Eugen Hristev <eugen.hristev@collabora.com>
    arm64: dts: mediatek: fix t-phy unit name

John Watts <contact@jookia.org>
    can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set

Lukas Magel <lukas.magel@posteo.net>
    can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Marek Behún <kabel@kernel.org>
    net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames

Marek Behún <kabel@kernel.org>
    net: dsa: qca8k: fix regmap bulk read/write methods on big endian systems

Vladimir Oltean <vladimir.oltean@nxp.com>
    phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared registers

Vladimir Oltean <vladimir.oltean@nxp.com>
    phy: lynx-28g: lock PHY while performing CDR lock workaround

Ioana Ciornei <ioana.ciornei@nxp.com>
    phy: lynx-28g: cancel the CDR check work item on the remove path

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dpu: fail dpu_plane_atomic_check() based on mdp clk limits

Stephen Boyd <swboyd@chromium.org>
    drm/msm/dp: Add newlines to debug printks

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow

Dan Carpenter <dan.carpenter@linaro.org>
    drm/msm/dsi: fix irq_of_parse_and_map() error checking

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dsi: skip the wait for video mode done if not applicable

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dp: do not reinitialize phy unless retry during link training

Hal Feng <hal.feng@starfivetech.com>
    pinctrl: starfive: jh7110: Fix failure to set irq after CONFIG_PM is enabled

Mikhail Kobuk <m.kobuk@ispras.ru>
    pinctrl: nuvoton: wpcm450: fix out of bounds write

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - ALC287 merge RTK codec with CS CS35L41 AMP

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - ALC287 I2S speaker platform support

Fabian Vogt <fabian@ritter-vogt.de>
    ALSA: hda/realtek: Add quirk for mute LEDs on HP ENVY x360 15-eu0xxx

SungHwan Jung <onenowy@gmail.com>
    ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED

Balamurugan C <balamurugan.c@intel.com>
    ASoC: Intel: soc-acpi: Add entry for sof_es8336 in MTL match table.

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: sof_sdw: add support for SKU 0B14

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_sai: Don't disable bitclock for i.MX8MP

Balamurugan C <balamurugan.c@intel.com>
    ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in MTL match table

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: soc-acpi: fix Dell SKU 0B34

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: simple-card-utils: fixup simple_util_startup() error handling

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: SOF: amd: fix for firmware reload failure after playback

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Change model for Intel RVP board

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda: cs35l41: Cleanup and fix double free in firmware request

Christos Skevis <xristos.thes@gmail.com>
    ALSA: usb-audio: Fix microphone sound on Nexigo webcam.

WhaleChang <whalechang@google.com>
    ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset

Sumit Garg <sumit.garg@linaro.org>
    KEYS: trusted: Remove redundant static calls usage

Biju Das <biju.das.jz@bp.renesas.com>
    irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source

Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
    dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells' property

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    arm64: dts: qcom: sm8150: extend the size of the PDC resource

Jordan Rife <jrife@google.com>
    net: prevent address rewrite in kernel_bind()

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Disable scsi device manage_system_start_stop

Matthias Reichl <hias@horus.com>
    ASoC: hdmi-codec: Fix broken channel map reporting

Sven Frotscher <sven.frotscher@gmail.com>
    ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM

Herbert Xu <herbert@gondor.apana.org.au>
    dm crypt: Fix reqsize in crypt_iv_eboiv_gen

Jan Kara <jack@suse.cz>
    quota: Fix slow quotaoff

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect

Ondrej Zary <linux@zary.sk>
    ata: pata_parport: implement set_devctl

Ondrej Zary <linux@zary.sk>
    ata: pata_parport: fix pata_parport_devchk

Damien Le Moal <dlemoal@kernel.org>
    scsi: Do not rescan devices with a suspended queue

Samson Tam <samson.tam@amd.com>
    drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master OTG pipes only

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: implement pipe type definition and adding accessors

Fabio Estevam <festevam@denx.de>
    media: dt-bindings: imx7-csi: Make power-domains not required for imx8mq

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning

Luben Tuikov <luben.tuikov@amd.com>
    drm/amdgpu: Fix a memory leak

Oza Pawandeep <quic_poza@quicinc.com>
    cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer

Mathias Krause <minipli@grsecurity.net>
    drm/i915: Register engines early to avoid type confusion

Armin Wolf <W_Armin@gmx.de>
    platform/x86: think-lmi: Fix reference leak

Jing Zhang <renyu.zj@linux.alibaba.com>
    perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    RDMA/cxgb4: Check skb value for failure to allocate

Remi Pommarel <repk@triplefau.lt>
    net: stmmac: remove unneeded stmmac_poll_controller


-------------

Diffstat:

 .../interrupt-controller/renesas,rzg2l-irqc.yaml   |   5 +-
 .../devicetree/bindings/media/nxp,imx7-csi.yaml    |   1 -
 Documentation/filesystems/overlayfs.rst            |  12 ++
 Makefile                                           |   4 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |   2 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi          |   2 +-
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts       |  39 +++++--
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   2 +-
 arch/arm64/include/asm/acpi.h                      |  20 ++++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   7 ++
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   2 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |   2 +
 arch/powerpc/kernel/entry_32.S                     |   8 +-
 arch/powerpc/platforms/pseries/hvCall.S            |   4 +-
 arch/riscv/Makefile                                |   1 -
 arch/riscv/include/asm/kprobes.h                   |  11 +-
 arch/riscv/include/asm/uprobes.h                   |  13 ++-
 arch/riscv/kernel/irq.c                            |   4 +-
 arch/riscv/kernel/signal.c                         |   7 --
 arch/riscv/kernel/traps.c                          |  28 +++--
 arch/riscv/net/bpf_jit_comp64.c                    |  18 ++-
 arch/s390/net/bpf_jit_comp.c                       |  25 +++-
 arch/x86/events/utils.c                            |   5 +-
 arch/x86/include/asm/msr-index.h                   |   9 +-
 arch/x86/include/asm/smp.h                         |   2 -
 arch/x86/kernel/alternative.c                      |  13 +++
 arch/x86/kernel/cpu/amd.c                          |   8 ++
 arch/x86/kernel/smp.c                              |  39 ++-----
 arch/x86/kernel/smpboot.c                          |  27 -----
 block/fops.c                                       |  21 +++-
 drivers/acpi/ec.c                                  |  11 ++
 drivers/acpi/processor_idle.c                      |   3 +-
 drivers/acpi/resource.c                            |  26 ++++-
 drivers/android/binder.c                           |   2 +
 drivers/ata/libata-core.c                          |  90 +++++++++++++++
 drivers/ata/libata-eh.c                            |  54 ++++++++-
 drivers/ata/libata-scsi.c                          |  16 ++-
 drivers/ata/libata.h                               |   2 +
 drivers/ata/pata_parport/pata_parport.c            |  10 +-
 drivers/counter/counter-chrdev.c                   |   4 +-
 drivers/counter/microchip-tcb-capture.c            |   2 +-
 drivers/dma-buf/dma-fence-unwrap.c                 |  13 +--
 drivers/dma-buf/sync_file.c                        |   9 +-
 drivers/dma/idxd/device.c                          |   5 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |   3 +-
 drivers/dma/stm32-dma.c                            |  11 +-
 drivers/dma/stm32-mdma.c                           |  33 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   2 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |   4 +-
 .../amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  35 ++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h      | 106 +++++++++++++++++
 drivers/gpu/drm/drm_atomic_helper.c                |  17 ++-
 drivers/gpu/drm/drm_gem.c                          |   6 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   9 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  27 +++--
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  13 +--
 drivers/gpu/drm/msm/dp/dp_link.c                   |   4 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  19 +++-
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |   4 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   2 +-
 drivers/gpu/drm/tiny/simpledrm.c                   |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                 |  17 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                |  18 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |  12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  31 ++---
 drivers/hid/hid-logitech-hidpp.c                   |   3 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  24 ++--
 drivers/iio/adc/ad7192.c                           |  29 ++++-
 drivers/iio/adc/imx8qxp-adc.c                      |   4 +-
 drivers/iio/addac/Kconfig                          |   2 +
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   6 +-
 drivers/iio/dac/ad3552r.c                          |   4 +-
 drivers/iio/frequency/admv1013.c                   |   4 +-
 drivers/iio/imu/bno055/Kconfig                     |   2 +
 drivers/iio/pressure/bmp280-core.c                 |   2 +-
 drivers/iio/pressure/dps310.c                      |   8 +-
 drivers/iio/pressure/ms5611_core.c                 |   2 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   3 +
 drivers/input/joystick/xpad.c                      |   4 +
 drivers/input/misc/powermate.c                     |   1 +
 drivers/input/mouse/elantech.c                     |   1 +
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/serio/i8042-acpipnpio.h              |   8 ++
 drivers/input/touchscreen/goodix.c                 |  19 ++++
 drivers/irqchip/irq-renesas-rzg2l.c                |   2 +-
 drivers/mcb/mcb-core.c                             |  10 +-
 drivers/mcb/mcb-parse.c                            |   2 -
 drivers/md/dm-crypt.c                              |   3 +-
 drivers/media/v4l2-core/v4l2-subdev.c              |   7 ++
 drivers/net/can/Kconfig                            |   2 +-
 drivers/net/can/sja1000/sja1000.c                  |   8 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |  15 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   5 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |  13 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   1 +
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   3 +-
 .../ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   |   4 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c   |  10 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |  19 +++-
 drivers/net/ethernet/netronome/nfp/flower/main.h   |   2 +
 .../net/ethernet/netronome/nfp/flower/metadata.c   |   2 +
 .../net/ethernet/netronome/nfp/flower/offload.c    |  24 +++-
 .../net/ethernet/netronome/nfp/flower/qos_conf.c   |  20 ++--
 drivers/net/ethernet/renesas/ravb_main.c           |   6 +-
 drivers/net/ethernet/renesas/rswitch.c             |  12 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  30 -----
 drivers/net/ieee802154/ca8210.c                    |  17 +--
 drivers/net/macsec.c                               |   2 +
 drivers/net/phy/mscc/mscc_macsec.c                 |   6 +
 drivers/net/usb/dm9601.c                           |   7 +-
 drivers/net/xen-netback/interface.c                |   4 -
 drivers/perf/arm-cmn.c                             |   2 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c           |  27 ++++-
 drivers/pinctrl/core.c                             |  16 +--
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |   6 +-
 drivers/pinctrl/renesas/Kconfig                    |   1 +
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c |   2 -
 drivers/platform/x86/hp/hp-wmi.c                   |   8 +-
 drivers/platform/x86/think-lmi.c                   |  24 +++-
 drivers/power/supply/qcom_battmgr.c                |   8 +-
 drivers/s390/net/Kconfig                           |   2 +-
 drivers/scsi/scsi_scan.c                           |  11 +-
 drivers/tee/amdtee/core.c                          |  10 +-
 drivers/thunderbolt/icm.c                          |  40 +++----
 drivers/thunderbolt/switch.c                       |   7 ++
 drivers/thunderbolt/tmu.c                          |   2 +-
 drivers/thunderbolt/xdomain.c                      |  58 +++++++---
 drivers/tty/serial/8250/8250_omap.c                |  25 ++--
 drivers/tty/serial/serial_core.c                   |  15 ++-
 drivers/ufs/core/ufshcd.c                          |   2 +-
 drivers/usb/cdns3/cdnsp-gadget.c                   |   3 +
 drivers/usb/cdns3/core.h                           |   3 +-
 drivers/usb/core/hub.c                             |  25 +++-
 drivers/usb/core/hub.h                             |   2 +-
 drivers/usb/dwc3/core.c                            |  39 ++++++-
 drivers/usb/gadget/function/f_ncm.c                |  26 +++--
 drivers/usb/gadget/udc/udc-xilinx.c                |  20 ++--
 drivers/usb/host/xhci-hub.c                        |  19 ++--
 drivers/usb/host/xhci-mem.c                        |   4 +-
 drivers/usb/host/xhci-ring.c                       |  16 +--
 drivers/usb/host/xhci.h                            |   2 +-
 drivers/usb/misc/onboard_usb_hub.c                 |   1 +
 drivers/usb/misc/onboard_usb_hub.h                 |   1 +
 drivers/usb/musb/musb_debugfs.c                    |   2 +-
 drivers/usb/musb/musb_host.c                       |   9 +-
 drivers/usb/typec/altmodes/displayport.c           |   5 +
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    |  12 +-
 drivers/usb/typec/ucsi/psy.c                       |   9 ++
 drivers/usb/typec/ucsi/ucsi.c                      |   2 +
 fs/ceph/file.c                                     |   2 +-
 fs/ceph/inode.c                                    |   4 +-
 fs/file.c                                          |   3 +-
 fs/fs_context.c                                    |  46 ++++++--
 fs/ioctl.c                                         |  10 +-
 fs/kernel_read_file.c                              |  12 +-
 fs/namei.c                                         |   3 +
 fs/open.c                                          |   4 +-
 fs/overlayfs/ovl_entry.h                           |  10 +-
 fs/overlayfs/params.c                              | 126 ++++++++++-----------
 fs/overlayfs/super.c                               |  18 +--
 fs/quota/dquot.c                                   |  66 ++++++-----
 fs/smb/server/vfs_cache.c                          |   4 +-
 include/linux/acpi.h                               |   9 ++
 include/linux/dma-fence.h                          |  19 ++++
 include/linux/fs_context.h                         |   2 +
 include/linux/libata.h                             |   6 +-
 include/linux/mcb.h                                |   1 -
 include/linux/quota.h                              |   4 +-
 include/linux/quotaops.h                           |   2 +-
 include/net/macsec.h                               |   1 +
 include/uapi/linux/if_packet.h                     |   6 +-
 kernel/bpf/verifier.c                              |   6 +-
 kernel/cgroup/cgroup-v1.c                          |   5 +-
 kernel/workqueue.c                                 |   8 +-
 net/can/isotp.c                                    |  19 ++--
 net/ceph/messenger.c                               |   4 +-
 net/core/dev.c                                     |   8 +-
 net/devlink/health.c                               |  30 ++---
 net/ethtool/bitset.c                               |  32 +++++-
 net/ipv4/tcp_output.c                              |   1 +
 net/mctp/route.c                                   |  22 +++-
 net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
 net/nfc/llcp_core.c                                |  30 ++---
 net/nfc/nci/core.c                                 |   5 +
 net/packet/af_packet.c                             |   7 +-
 net/rds/tcp_connect.c                              |   2 +-
 net/rds/tcp_listen.c                               |   2 +-
 net/smc/Kconfig                                    |   1 +
 net/smc/smc_stats.h                                |  14 ++-
 net/socket.c                                       |   6 +-
 net/xdp/xsk_queue.c                                |  10 ++
 security/keys/trusted-keys/trusted_core.c          |  13 +--
 sound/pci/hda/cs35l41_hda.c                        | 115 +++++++++++++------
 sound/pci/hda/patch_realtek.c                      |  89 +++++++++++++--
 sound/soc/amd/yc/acp6x-mach.c                      |   7 ++
 sound/soc/codecs/hdmi-codec.c                      |   5 +-
 sound/soc/fsl/fsl_sai.c                            |   9 +-
 sound/soc/generic/simple-card-utils.c              |   3 +-
 sound/soc/intel/boards/sof_es8336.c                |  10 ++
 sound/soc/intel/boards/sof_sdw.c                   |  10 ++
 sound/soc/intel/common/soc-acpi-intel-adl-match.c  |  12 +-
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  |  25 ++++
 sound/soc/sof/amd/pci-rmb.c                        |   1 -
 sound/usb/mixer.c                                  |   7 ++
 sound/usb/quirks.c                                 |   8 +-
 217 files changed, 1897 insertions(+), 837 deletions(-)


