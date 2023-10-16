Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49D7CA205
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjJPIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjJPIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:44:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD7A2;
        Mon, 16 Oct 2023 01:44:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB40C433C8;
        Mon, 16 Oct 2023 08:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445870;
        bh=4mnZH39JBPaKoiimbxENT7/nt0Awf/brpGFChuXPVv4=;
        h=From:To:Cc:Subject:Date:From;
        b=fcBBt5+eoTmHqccRYd5oD+84WLuz+DMK4W+dKqPxYQRuxs6P1sHrQ02pZOH7g8/je
         906DNsrXTFZ2mt96Ig7pg8/0zG2o1V16Fpn/oZbgrhbQd4L08++B/Y9F/PWPKA5+ws
         ecO5urGTjfyAyi9yD+OJFypc6QWuY2D6ILlc2BQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.15 000/102] 5.15.136-rc1 review
Date:   Mon, 16 Oct 2023 10:39:59 +0200
Message-ID: <20231016083953.689300946@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.136-rc1
X-KernelTest-Deadline: 2023-10-18T08:39+00:00
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

This is the start of the stable review cycle for the 5.15.136 release.
There are 102 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.136-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.136-rc1

Jakub Kicinski <kuba@kernel.org>
    eth: remove remaining copies of the NAPI_POLL_WEIGHT define

Ricardo Cañuelo <ricardo.canuelo@collabora.com>
    usb: hub: Guard against accesses to uninitialized BOS descriptors

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "kernel/sched: Modify initial boot task idle setup"

Ren Zhijie <renzhijie2@huawei.com>
    arm64: armv8_deprecated: fix unused-function error

Mark Rutland <mark.rutland@arm.com>
    arm64: armv8_deprecated: rework deprected instruction handling

Mark Rutland <mark.rutland@arm.com>
    arm64: armv8_deprecated: move aarch32 helper earlier

Mark Rutland <mark.rutland@arm.com>
    arm64: armv8_deprecated move emulation functions

Mark Rutland <mark.rutland@arm.com>
    arm64: armv8_deprecated: fold ops into insn_emulation

Mark Rutland <mark.rutland@arm.com>
    arm64: rework EL0 MRS emulation

Mark Rutland <mark.rutland@arm.com>
    arm64: factor insn read out of call_undef_hook()

Mark Rutland <mark.rutland@arm.com>
    arm64: factor out EL1 SSBS emulation hook

Mark Rutland <mark.rutland@arm.com>
    arm64: split EL0/EL1 UNDEF handlers

Mark Rutland <mark.rutland@arm.com>
    arm64: allow kprobes on EL0 handlers

Mark Rutland <mark.rutland@arm.com>
    arm64: rework BTI exception handling

Mark Rutland <mark.rutland@arm.com>
    arm64: rework FPAC exception handling

Mark Rutland <mark.rutland@arm.com>
    arm64: consistently pass ESR_ELx to die()

Mark Rutland <mark.rutland@arm.com>
    arm64: die(): pass 'err' as long

Mark Rutland <mark.rutland@arm.com>
    arm64: report EL1 UNDEFs better

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

Dharma Balasubiramani <dharma.b@microchip.com>
    counter: microchip-tcb-capture: Fix the use of internal GCLK logic

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    pinctrl: avoid unsafe code pattern in find_pinctrl()

Michal Koutný <mkoutny@suse.com>
    cgroup: Remove duplicates in cgroup v1 tasks file

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

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge

Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
    mcb: remove is_added flag from mcb_device struct

Borislav Petkov (AMD) <bp@alien8.de>
    x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA

Daniel Miess <daniel.miess@amd.com>
    drm/amd/display: Don't set dpms_off for seamless boot

Christian König <christian.koenig@amd.com>
    drm/amdgpu: add missing NULL check

Alexander Zangerl <az@breathe-safe.com>
    iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Lakshmi Yadlapati <lakshmiy@us.ibm.com>
    iio: pressure: dps310: Adjust Timeout Settings

Phil Elwell <phil@raspberrypi.com>
    iio: pressure: bmp280: Fix NULL pointer exception

Xingxing Luo <xingxing.luo@unisoc.com>
    usb: musb: Modify the "HWVers" register address

Xingxing Luo <xingxing.luo@unisoc.com>
    usb: musb: Get the musb_qh poniter after musb_giveback

Xiaolei Wang <xiaolei.wang@windriver.com>
    usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Soft reset phy on probe for host

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer

Hongyu Xie <xy521521@gmail.com>
    xhci: Keep interrupt disabled in initialization until host is running.

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: stm32-mdma: abort resume if no ongoing transfer

Zheng Wang <zyytlz.wz@163.com>
    media: mtk-jpeg: Fix use after free bug due to uncanceled work

Patrick Rohr <prohr@google.com>
    net: release reference to inet6_dev pointer

Patrick Rohr <prohr@google.com>
    net: change accept_ra_min_rtr_lft to affect all RA lifetimes

Patrick Rohr <prohr@google.com>
    net: add sysctl accept_ra_min_rtr_lft

Adrian Hunter <adrian.hunter@intel.com>
    perf inject: Fix GEN_ELF_TEXT_OFFSET for jit

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
    net: phy: mscc: macsec: reject PN update requests

Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
    net: macsec: indicate next pn update when offloading

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

Jakub Kicinski <kuba@kernel.org>
    eth: remove copies of the NAPI_POLL_WEIGHT define

Dan Carpenter <dan.carpenter@linaro.org>
    mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix use-after-free issue in ravb_tx_timeout_work()

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    ravb: Fix up dma_free_coherent() call in ravb_remove()

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow

Dan Carpenter <dan.carpenter@linaro.org>
    drm/msm/dsi: fix irq_of_parse_and_map() error checking

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dsi: skip the wait for video mode done if not applicable

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dp: do not reinitialize phy unless retry during link training

Sumit Garg <sumit.garg@linaro.org>
    KEYS: trusted: Remove redundant static calls usage

Ahmad Fatoum <a.fatoum@pengutronix.de>
    KEYS: trusted: allow use of kernel RNG for key material

WhaleChang <whalechang@google.com>
    ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset

Jordan Rife <jrife@google.com>
    net: prevent address rewrite in kernel_bind()

Jan Kara <jack@suse.cz>
    quota: Fix slow quotaoff

Hans de Goede <hdegoede@redhat.com>
    HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    lib/test_meminit: fix off-by-one error in test_pages()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    platform/x86: hp-wmi:: Mark driver struct with __refdata to prevent section mismatch warning

Armin Wolf <W_Armin@gmx.de>
    platform/x86: think-lmi: Fix reference leak

Geert Uytterhoeven <geert+renesas@glider.be>
    of: overlay: Reorder struct fragment fields kerneldoc

Jing Zhang <renyu.zj@linux.alibaba.com>
    perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7

Artem Chernyshev <artem.chernyshev@red-soft.ru>
    RDMA/cxgb4: Check skb value for failure to allocate

Bart Van Assche <bvanassche@acm.org>
    RDMA/srp: Do not call scsi_done() from srp_abort()

Bart Van Assche <bvanassche@acm.org>
    scsi: ib_srp: Call scsi_done() directly

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Rename scsi_mq_done() into scsi_done() and export it

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Use a structure member to track the SCSI command submitter

Zhang Rui <rui.zhang@intel.com>
    iommu/vt-d: Avoid memory allocation in iommu_suspend()


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |  10 +
 Documentation/networking/ip-sysctl.rst             |   8 +
 Documentation/security/keys/trusted-encrypted.rst  |  20 +-
 Makefile                                           |   4 +-
 arch/arm64/include/asm/cpufeature.h                |   3 +-
 arch/arm64/include/asm/exception.h                 |  13 +-
 arch/arm64/include/asm/spectre.h                   |   2 +
 arch/arm64/include/asm/system_misc.h               |   2 +-
 arch/arm64/include/asm/traps.h                     |  19 +-
 arch/arm64/kernel/armv8_deprecated.c               | 572 ++++++++++-----------
 arch/arm64/kernel/cpufeature.c                     |  23 +-
 arch/arm64/kernel/entry-common.c                   |  36 +-
 arch/arm64/kernel/proton-pack.c                    |  26 +-
 arch/arm64/kernel/traps.c                          | 125 ++---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   7 +
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   2 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |   2 +
 arch/riscv/net/bpf_jit_comp64.c                    |  33 +-
 arch/x86/include/asm/msr-index.h                   |   9 +-
 arch/x86/kernel/alternative.c                      |  13 +
 arch/x86/kernel/cpu/amd.c                          |   8 +
 drivers/acpi/resource.c                            |   7 +
 drivers/counter/microchip-tcb-capture.c            |   2 +-
 drivers/dma/idxd/device.c                          |   5 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |   3 +-
 drivers/dma/stm32-mdma.c                           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  12 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  13 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  19 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |   2 +-
 drivers/hid/hid-logitech-hidpp.c                   |   3 +-
 drivers/iio/pressure/bmp280-core.c                 |   2 +-
 drivers/iio/pressure/dps310.c                      |   8 +-
 drivers/iio/pressure/ms5611_core.c                 |   2 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   3 +
 drivers/infiniband/ulp/srp/ib_srp.c                |  22 +-
 drivers/input/joystick/xpad.c                      |   2 +
 drivers/input/misc/powermate.c                     |   1 +
 drivers/input/mouse/elantech.c                     |   1 +
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/serio/i8042-acpipnpio.h              |   8 +
 drivers/input/touchscreen/goodix.c                 |  19 +
 drivers/iommu/intel/iommu.c                        |  16 -
 drivers/mcb/mcb-core.c                             |  10 +-
 drivers/mcb/mcb-parse.c                            |   2 -
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    |   1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   4 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |   3 +-
 drivers/net/ethernet/cortina/gemini.c              |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   5 +-
 drivers/net/ethernet/marvell/skge.c                |   3 +-
 drivers/net/ethernet/marvell/sky2.c                |   3 +-
 drivers/net/ethernet/mediatek/mtk_star_emac.c      |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   3 +-
 .../ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   |   4 +-
 drivers/net/ethernet/nvidia/forcedeth.c            |   6 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   6 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   3 +-
 drivers/net/ethernet/ti/netcp_core.c               |   5 +-
 drivers/net/ieee802154/ca8210.c                    |  17 +-
 drivers/net/macsec.c                               |   2 +
 drivers/net/phy/mscc/mscc_macsec.c                 |   6 +
 drivers/net/usb/dm9601.c                           |   7 +-
 drivers/net/xen-netback/interface.c                |   7 +-
 drivers/of/overlay.c                               |   2 +-
 drivers/perf/arm-cmn.c                             |   2 +-
 drivers/pinctrl/core.c                             |  16 +-
 drivers/pinctrl/renesas/Kconfig                    |   1 +
 drivers/platform/x86/hp/hp-wmi.c                   |   8 +-
 drivers/platform/x86/think-lmi.c                   |  24 +-
 drivers/scsi/scsi_error.c                          |  17 +-
 drivers/scsi/scsi_lib.c                            |  15 +-
 drivers/scsi/scsi_priv.h                           |   1 +
 drivers/tee/amdtee/core.c                          |  10 +-
 drivers/thunderbolt/icm.c                          |  40 +-
 drivers/thunderbolt/switch.c                       |   7 +
 drivers/usb/cdns3/cdnsp-gadget.c                   |   3 +
 drivers/usb/cdns3/core.h                           |   3 +-
 drivers/usb/core/hub.c                             |  25 +-
 drivers/usb/core/hub.h                             |   2 +-
 drivers/usb/dwc3/core.c                            |  39 +-
 drivers/usb/gadget/function/f_ncm.c                |  26 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |  20 +-
 drivers/usb/host/xhci-ring.c                       |   4 +-
 drivers/usb/host/xhci.c                            |  35 +-
 drivers/usb/musb/musb_debugfs.c                    |   2 +-
 drivers/usb/musb/musb_host.c                       |   9 +-
 fs/ceph/file.c                                     |   2 +-
 fs/ceph/inode.c                                    |   4 +-
 fs/quota/dquot.c                                   |  66 ++-
 include/keys/trusted-type.h                        |   2 +-
 include/linux/intel-iommu.h                        |   2 +-
 include/linux/ipv6.h                               |   1 +
 include/linux/mcb.h                                |   1 -
 include/linux/quota.h                              |   4 +-
 include/linux/quotaops.h                           |   2 +-
 include/net/macsec.h                               |   1 +
 include/scsi/scsi_cmnd.h                           |   9 +
 include/uapi/linux/ipv6.h                          |   3 +
 kernel/bpf/verifier.c                              |   6 +-
 kernel/cgroup/cgroup-v1.c                          |   5 +-
 kernel/sched/core.c                                |   2 +-
 kernel/sched/idle.c                                |   1 -
 kernel/workqueue.c                                 |   8 +-
 lib/test_meminit.c                                 |   2 +-
 net/ceph/messenger.c                               |   4 +-
 net/ethtool/bitset.c                               |  32 +-
 net/ipv6/addrconf.c                                |  13 +
 net/ipv6/ndisc.c                                   |  13 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   4 +-
 net/nfc/llcp_core.c                                |  30 +-
 net/nfc/nci/core.c                                 |   5 +
 net/rds/tcp_connect.c                              |   2 +-
 net/rds/tcp_listen.c                               |   2 +-
 net/smc/smc_stats.h                                |  14 +-
 net/socket.c                                       |   6 +-
 security/keys/trusted-keys/trusted_core.c          |  48 +-
 sound/usb/quirks.c                                 |   6 +-
 tools/perf/util/genelf.h                           |   4 +-
 121 files changed, 1054 insertions(+), 762 deletions(-)


