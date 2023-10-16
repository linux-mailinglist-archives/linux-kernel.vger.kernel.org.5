Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95517CA2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjJPIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJPIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:52:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0B9A6;
        Mon, 16 Oct 2023 01:52:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB0EC433C9;
        Mon, 16 Oct 2023 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446334;
        bh=gE+GYmdC2xzmet6QxGHp9jT2yq54NOrGzhlzYQbTO90=;
        h=From:To:Cc:Subject:Date:From;
        b=pTVfmkK3QFb2cfY0Ldv/v1oPpkomvDZ+taDP3knbfjIIGXiNaalVrx3RBgTkB/78m
         6uxGzfGAeVnTLwKuy5TAp/Cy93t69UVSj1Yow8gfr51NsgRdM3K7tdm06UJQh2cWNH
         Luei+KnfI4qSDn5wsb/kFhrOgQxMRN9TjsrzjLYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 000/131] 6.1.59-rc1 review
Date:   Mon, 16 Oct 2023 10:39:43 +0200
Message-ID: <20231016084000.050926073@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.59-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.59-rc1
X-KernelTest-Deadline: 2023-10-18T08:40+00:00
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

This is the start of the stable review cycle for the 6.1.59 release.
There are 131 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.59-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.59-rc1

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fixed two speaker platform

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()

Christophe Leroy <christophe.leroy@csgroup.eu>
    powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE

Duoming Zhou <duoming@zju.edu.cn>
    dmaengine: mediatek: Fix deadlock caused by synchronize_irq()

Rex Zhang <rex.zhang@intel.com>
    dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/alternatives: Disable KASAN in apply_alternatives()

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

Dharma Balasubiramani <dharma.b@microchip.com>
    counter: microchip-tcb-capture: Fix the use of internal GCLK logic

Fabrice Gasnier <fabrice.gasnier@foss.st.com>
    counter: chrdev: fix getting array extensions

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

Yanguo Li <yanguo.li@corigine.com>
    nfp: flower: avoid rmmod nfp crash issues

Jeremy Kerr <jk@codeconstruct.com.au>
    mctp: perform route lookups under a RCU read-side lock

Rijo Thomas <Rijo-john.Thomas@amd.com>
    tee: amdtee: fix use-after-free vulnerability in amdtee_close_session

Hans de Goede <hdegoede@redhat.com>
    Input: goodix - ensure int GPIO is in input for gpio_count == 1 && gpio_int_idx == 0 case

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

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Restart XDomain discovery handshake after failure

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge

Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
    mcb: remove is_added flag from mcb_device struct

Borislav Petkov (AMD) <bp@alien8.de>
    x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

JP Kobryn <inwardvessel@gmail.com>
    perf/x86/lbr: Filter vsyscall addresses

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: not allow to open file if delelete on close bit is set

Hans de Goede <hdegoede@redhat.com>
    ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA

Daniel Miess <daniel.miess@amd.com>
    drm/amd/display: Don't set dpms_off for seamless boot

Christian König <christian.koenig@amd.com>
    drm/amdgpu: add missing NULL check

Simon Ser <contact@emersion.fr>
    drm/atomic-helper: relax unregistered connector check

Macpaul Lin <macpaul.lin@mediatek.com>
    arm64: dts: mediatek: mt8195-demo: update and reorder reserved memory regions

Macpaul Lin <macpaul.lin@mediatek.com>
    arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB

Antoniu Miclaus <antoniu.miclaus@analog.com>
    iio: addac: Kconfig: update ad74413r selections

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

mfreemon@cloudflare.com <mfreemon@cloudflare.com>
    tcp: enforce receive buffer memory limits by allowing the tcp window to shrink

Waiman Long <longman@redhat.com>
    workqueue: Override implicit ordered attribute in workqueue_apply_unbound_cpumask()

Jeremy Cline <jeremy@jcline.org>
    nfc: nci: assert requested protocol is valid

Ralph Siemsen <ralph.siemsen@linaro.org>
    pinctrl: renesas: rzn1: Enable missing PINMUX

Nils Hoppmann <niho@linux.ibm.com>
    net/smc: Fix pos miscalculation in statistics

Kory Maincent <kory.maincent@bootlin.com>
    ethtool: Fix mod state of verbose no_mask bitset

Eric Dumazet <edumazet@google.com>
    net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()

Will Mortensen <will@extrahop.com>
    net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp

Dan Carpenter <dan.carpenter@linaro.org>
    ixgbe: fix crash with empty VF macvlan list

Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
    net/mlx5e: macsec: use update_pn flag instead of PN comparation

Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
    net: phy: mscc: macsec: reject PN update requests

Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
    net: macsec: indicate next pn update when offloading

Eric Dumazet <edumazet@google.com>
    net: refine debug info in skb_checksum_help()

David Vernet <void@manifault.com>
    bpf: Fix verifier log for async callback return values

Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
    drm/vmwgfx: fix typo of sizeof argument

Björn Töpel <bjorn@rivosinc.com>
    riscv, bpf: Sign-extend return values

Pu Lehui <pulehui@huawei.com>
    riscv, bpf: Factor out emit_call for kernel and bpf context

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

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8195: Set DSU PMU status to fail

John Watts <contact@jookia.org>
    can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set

Lukas Magel <lukas.magel@posteo.net>
    can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Marek Behún <kabel@kernel.org>
    net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames

Vladimir Oltean <vladimir.oltean@nxp.com>
    phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared registers

Vladimir Oltean <vladimir.oltean@nxp.com>
    phy: lynx-28g: lock PHY while performing CDR lock workaround

Ioana Ciornei <ioana.ciornei@nxp.com>
    phy: lynx-28g: cancel the CDR check work item on the remove path

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

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_sai: Don't disable bitclock for i.MX8MP

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_sai: MCLK bind with TX/RX enable bit

Rob Herring <robh@kernel.org>
    ASoC: Use of_property_read_bool() for boolean properties

Balamurugan C <balamurugan.c@intel.com>
    ASoC: Intel: soc-acpi: Add entry for sof_es8336 in MTL match table.

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: sof_sdw: add support for SKU 0B14

Balamurugan C <balamurugan.c@intel.com>
    ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in MTL match table

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: simple-card-utils: fixup simple_util_startup() error handling

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    ASoC: SOF: amd: fix for firmware reload failure after playback

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek: Change model for Intel RVP board

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

Sven Frotscher <sven.frotscher@gmail.com>
    ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM

Jan Kara <jack@suse.cz>
    quota: Fix slow quotaoff

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect

Damien Le Moal <dlemoal@kernel.org>
    scsi: Do not rescan devices with a suspended queue

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning

Armin Wolf <W_Armin@gmx.de>
    platform/x86: think-lmi: Fix reference leak

Jing Zhang <renyu.zj@linux.alibaba.com>
    perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    RDMA/cxgb4: Check skb value for failure to allocate

Nirmoy Das <nirmoy.das@intel.com>
    drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix delegated action races

Haiyang Zhang <haiyangz@microsoft.com>
    net: mana: Fix TX CQE error handling


-------------

Diffstat:

 .../interrupt-controller/renesas,rzg2l-irqc.yaml   |  5 +-
 Documentation/networking/ip-sysctl.rst             | 15 ++++
 Makefile                                           |  4 +-
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts       | 39 ++++++++--
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  7 ++
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  2 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |  2 +
 arch/powerpc/kernel/entry_32.S                     |  8 +-
 arch/riscv/net/bpf_jit_comp64.c                    | 33 ++++----
 arch/x86/events/utils.c                            |  5 +-
 arch/x86/include/asm/msr-index.h                   |  9 ++-
 arch/x86/kernel/alternative.c                      | 13 ++++
 arch/x86/kernel/cpu/amd.c                          |  8 ++
 drivers/acpi/ec.c                                  | 11 +++
 drivers/acpi/resource.c                            |  7 ++
 drivers/ata/libata-core.c                          | 90 ++++++++++++++++++++++
 drivers/ata/libata-eh.c                            | 54 ++++++++++++-
 drivers/ata/libata-scsi.c                          | 16 ++--
 drivers/ata/libata.h                               |  2 +
 drivers/counter/counter-chrdev.c                   |  4 +-
 drivers/counter/microchip-tcb-capture.c            |  2 +-
 drivers/dma-buf/dma-fence-unwrap.c                 | 13 +---
 drivers/dma-buf/sync_file.c                        |  9 +--
 drivers/dma/idxd/device.c                          |  5 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |  3 +-
 drivers/dma/stm32-dma.c                            | 11 ++-
 drivers/dma/stm32-mdma.c                           | 33 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  3 +
 drivers/gpu/drm/drm_atomic_helper.c                | 17 +++-
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c           | 11 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          | 12 +--
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 13 ++--
 drivers/gpu/drm/msm/dp/dp_link.c                   |  2 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 | 19 ++++-
 drivers/gpu/drm/scheduler/sched_main.c             |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  2 +-
 drivers/hid/hid-logitech-hidpp.c                   |  3 +-
 drivers/iio/adc/imx8qxp-adc.c                      |  4 +-
 drivers/iio/addac/Kconfig                          |  2 +
 drivers/iio/dac/ad3552r.c                          |  4 +-
 drivers/iio/frequency/admv1013.c                   |  4 +-
 drivers/iio/imu/bno055/Kconfig                     |  2 +
 drivers/iio/pressure/bmp280-core.c                 |  2 +-
 drivers/iio/pressure/dps310.c                      |  8 +-
 drivers/iio/pressure/ms5611_core.c                 |  2 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |  3 +
 drivers/input/joystick/xpad.c                      |  2 +
 drivers/input/misc/powermate.c                     |  1 +
 drivers/input/mouse/elantech.c                     |  1 +
 drivers/input/mouse/synaptics.c                    |  1 +
 drivers/input/serio/i8042-acpipnpio.h              |  8 ++
 drivers/input/touchscreen/goodix.c                 | 19 +++++
 drivers/irqchip/irq-renesas-rzg2l.c                |  2 +-
 drivers/mcb/mcb-core.c                             | 10 +--
 drivers/mcb/mcb-parse.c                            |  2 -
 drivers/net/can/Kconfig                            |  2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   | 11 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  5 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  3 +-
 .../ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   |  4 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 16 ++--
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c   | 10 ++-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  | 19 +++--
 drivers/net/ethernet/netronome/nfp/flower/main.h   |  2 +
 .../net/ethernet/netronome/nfp/flower/metadata.c   |  2 +
 .../net/ethernet/netronome/nfp/flower/offload.c    | 24 ++++--
 .../net/ethernet/netronome/nfp/flower/qos_conf.c   | 20 +++--
 drivers/net/ethernet/renesas/ravb_main.c           |  6 +-
 drivers/net/ieee802154/ca8210.c                    | 17 +---
 drivers/net/macsec.c                               |  2 +
 drivers/net/phy/mscc/mscc_macsec.c                 |  6 ++
 drivers/net/usb/dm9601.c                           |  7 +-
 drivers/net/xen-netback/interface.c                |  4 -
 drivers/perf/arm-cmn.c                             |  2 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c           | 27 ++++++-
 drivers/pinctrl/core.c                             | 16 ++--
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |  6 +-
 drivers/pinctrl/renesas/Kconfig                    |  1 +
 drivers/platform/x86/hp/hp-wmi.c                   |  8 +-
 drivers/platform/x86/think-lmi.c                   | 24 +++++-
 drivers/scsi/scsi_scan.c                           | 11 +--
 drivers/tee/amdtee/core.c                          | 10 ++-
 drivers/thunderbolt/icm.c                          | 40 +++++-----
 drivers/thunderbolt/switch.c                       |  7 ++
 drivers/thunderbolt/xdomain.c                      | 58 ++++++++++----
 drivers/ufs/core/ufshcd.c                          |  2 +-
 drivers/usb/cdns3/cdnsp-gadget.c                   |  3 +
 drivers/usb/cdns3/core.h                           |  3 +-
 drivers/usb/core/hub.c                             | 25 +++++-
 drivers/usb/core/hub.h                             |  2 +-
 drivers/usb/dwc3/core.c                            | 39 +++++++++-
 drivers/usb/gadget/function/f_ncm.c                | 26 +++++--
 drivers/usb/gadget/udc/udc-xilinx.c                | 20 +++--
 drivers/usb/host/xhci-ring.c                       |  4 +-
 drivers/usb/musb/musb_debugfs.c                    |  2 +-
 drivers/usb/musb/musb_host.c                       |  9 ++-
 drivers/usb/typec/altmodes/displayport.c           |  5 ++
 drivers/usb/typec/ucsi/psy.c                       |  9 +++
 drivers/usb/typec/ucsi/ucsi.c                      |  1 +
 fs/ceph/file.c                                     |  2 +-
 fs/ceph/inode.c                                    |  4 +-
 fs/quota/dquot.c                                   | 66 +++++++++-------
 fs/smb/server/vfs_cache.c                          |  4 +-
 include/linux/dma-fence.h                          | 19 +++++
 include/linux/libata.h                             |  7 +-
 include/linux/mcb.h                                |  1 -
 include/linux/quota.h                              |  4 +-
 include/linux/quotaops.h                           |  2 +-
 include/net/macsec.h                               |  1 +
 include/net/netns/ipv4.h                           |  1 +
 kernel/bpf/verifier.c                              |  6 +-
 kernel/cgroup/cgroup-v1.c                          |  5 +-
 kernel/workqueue.c                                 |  8 +-
 net/can/isotp.c                                    | 19 ++---
 net/ceph/messenger.c                               |  4 +-
 net/core/dev.c                                     |  8 +-
 net/ethtool/bitset.c                               | 32 ++++++--
 net/ipv4/sysctl_net_ipv4.c                         |  9 +++
 net/ipv4/tcp_ipv4.c                                |  2 +
 net/ipv4/tcp_output.c                              | 60 ++++++++++++---
 net/mctp/route.c                                   | 22 ++++--
 net/mptcp/protocol.c                               | 28 +++----
 net/mptcp/protocol.h                               | 35 +++------
 net/mptcp/subflow.c                                | 10 ++-
 net/netfilter/ipvs/ip_vs_sync.c                    |  4 +-
 net/nfc/llcp_core.c                                | 30 +++-----
 net/nfc/nci/core.c                                 |  5 ++
 net/rds/tcp_connect.c                              |  2 +-
 net/rds/tcp_listen.c                               |  2 +-
 net/smc/smc_stats.h                                | 14 ++--
 net/socket.c                                       |  6 +-
 security/keys/trusted-keys/trusted_core.c          | 13 ++--
 sound/pci/hda/patch_realtek.c                      | 89 ++++++++++++++++++---
 sound/soc/amd/yc/acp6x-mach.c                      |  7 ++
 sound/soc/codecs/sta32x.c                          | 39 +++++-----
 sound/soc/codecs/sta350.c                          | 63 +++++++--------
 sound/soc/codecs/tas5086.c                         |  2 +-
 sound/soc/fsl/fsl_sai.c                            | 41 +++++++---
 sound/soc/fsl/fsl_sai.h                            |  2 +
 sound/soc/fsl/fsl_ssi.c                            |  2 +-
 sound/soc/fsl/imx-card.c                           |  2 +-
 sound/soc/generic/simple-card-utils.c              |  3 +-
 sound/soc/intel/boards/sof_es8336.c                | 10 +++
 sound/soc/intel/boards/sof_sdw.c                   | 10 +++
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c  | 25 ++++++
 sound/soc/sh/rcar/ssi.c                            |  4 +-
 sound/soc/sof/amd/pci-rmb.c                        |  1 -
 sound/usb/mixer.c                                  |  7 ++
 sound/usb/quirks.c                                 |  8 +-
 153 files changed, 1327 insertions(+), 523 deletions(-)


