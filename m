Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176EC80D724
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbjLKShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbjLKShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:37:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEEB10A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:37:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD915C433C7;
        Mon, 11 Dec 2023 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702319842;
        bh=d+9JCro9vkQOLbVFOQJx4tzpj7ohE6MfisG+GXBl83E=;
        h=From:To:Cc:Subject:Date:From;
        b=obJR10l7ytDRZkXZ4sdTCI0aTQw9djsalzOnOCiCZ7moXbCKvqJ266dghXYe/n4Gu
         wfeI7csvkK89Zwy/i2mVmL4QG9tpQW6Rshg14z83MqU7oxN9Rjyxrd8etqzyaklHo6
         akVy02UVw2EgcN8v5IP3K9SUsSx9Pa8AXy/7L50k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: [PATCH 5.10 00/97] 5.10.204-rc1 review
Date:   Mon, 11 Dec 2023 19:21:03 +0100
Message-ID: <20231211182019.802717483@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.204-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.204-rc1
X-KernelTest-Deadline: 2023-12-13T18:20+00:00
Content-Type: text/plain; charset=UTF-8
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

This is the start of the stable review cycle for the 5.10.204 release.
There are 97 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.204-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.204-rc1

ChunHao Lin <hau@realtek.com>
    r8169: fix rtl8125b PAUSE frames blasting when suspended

Mukesh Ojha <quic_mojha@quicinc.com>
    devcoredump: Send uevent once devcd is ready

Mukesh Ojha <quic_mojha@quicinc.com>
    devcoredump : Serialize devcd_del work

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential NULL deref in parse_dfs_referrals()

David Howells <dhowells@redhat.com>
    cifs: Fix non-availability of dedup breaking generic/304

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "btrfs: add dmesg output for first mount and last unmount of a filesystem"

Adrian Hunter <adrian.hunter@intel.com>
    mmc: block: Be sure to wait while busy in CQE error recovery

Luke D. Jones <luke@ljones.dev>
    platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute

Namhyung Kim <namhyung@kernel.org>
    tools headers UAPI: Sync linux/perf_event.h with the kernel sources

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Fix kbd_dock_devid tablet-switch reporting

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: skip inactive elements during set walk

Ido Schimmel <idosch@nvidia.com>
    drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ido Schimmel <idosch@nvidia.com>
    psample: Require 'CAP_NET_ADMIN' when joining "packets" group

Ido Schimmel <idosch@nvidia.com>
    genetlink: add CAP_NET_ADMIN test for multicast bind

Ido Schimmel <idosch@nvidia.com>
    netlink: don't call ->netlink_bind with table lock held

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/af_unix: disable sending io_uring over sockets

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Enable DMA noncoherent support

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: Loongson64: Reserve vgabios memory on boot

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390/mm: Properly reset no-dat

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Check vendor in the AMD microcode callback

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250_omap: Add earlycon support for the AM654 UART controller

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit

Daniel Mack <daniel@zonque.org>
    serial: sc16is7xx: address RX timeout interrupt errata

Arnd Bergmann <arnd@arndb.de>
    ARM: PL011: Fix DMA support

RD Babiera <rdbabiera@google.com>
    usb: typec: class: fix typec_altmode_put_partner to put plugs

Mathias Nyman <mathias.nyman@linux.intel.com>
    Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

Cameron Williams <cang1@live.co.uk>
    parport: Add support for Brainboxes IX/UC/PX parallel cards

Konstantin Aladyshev <aladyshev22@gmail.com>
    usb: gadget: f_hid: fix report descriptor allocation

Prike Liang <Prike.Liang@amd.com>
    drm/amdgpu: correct the amdgpu runtime dereference usage count

Boerge Struempfel <boerge.struempfel@gmail.com>
    gpiolib: sysfs: Fix error handling on failed export

Peter Zijlstra <peterz@infradead.org>
    perf: Fix perf_event_validate_size()

Namhyung Kim <namhyung@kernel.org>
    perf/core: Add a new read format to get a number of lost samples

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Stop current tracer when resizing buffer

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Set actual size after ring buffer resize

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Force absolute timestamp on discard of event

Su Hui <suhui@nfschina.com>
    misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_write

Su Hui <suhui@nfschina.com>
    misc: mei: client.c: return negative error code in mei_cl_write

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memory

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names

Eugen Hristev <eugen.hristev@collabora.com>
    arm64: dts: mediatek: mt7622: fix memory node warning check

Daniel Borkmann <daniel@iogearbox.net>
    packet: Move reference count in packet_sock to atomic_long_t

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a possible race when disabling buffered events

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix incomplete locking when disabling buffered events

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Disable snapshot buffer when stopping instance tracers

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Always update snapshot buffer size

Heiko Carstens <hca@linux.ibm.com>
    checkstack: fix printed address

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing error check for sb_set_blocksize call

Bin Li <bin.li@canonical.com>
    ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5

Jason Zhang <jason.zhang@rock-chips.com>
    ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Clément Léger <cleger@rivosinc.com>
    riscv: fix misaligned access handling of C.SWSP and C.SDSP

Philipp Zabel <p.zabel@pengutronix.de>
    ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

Kunwu Chan <chentao@kylinos.cn>
    ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a warning when allocating buffered events fails

Dinghao Liu <dinghao.liu@zju.edu.cn>
    ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate

Armin Wolf <W_Armin@gmx.de>
    hwmon: (acpi_power_meter) Fix 4.29 MW bug

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Correct module description string

Jack Wang <jinpu.wang@ionos.com>
    RDMA/rtrs-clt: Remove the warnings for req in_use check

Alex Bee <knaerzche@gmail.com>
    arm64: dts: rockchip: Expand reg size of vdec node for RK3399

Sumit Garg <sumit.garg@linaro.org>
    tee: optee: Fix supplicant based device enumeration

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap, updating the sg structure should also update curr

Eric Dumazet <edumazet@google.com>
    tcp: do not accept ACK of bytes we never sent

Phil Sutter <phil@nwl.cc>
    netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: fix fake link up on xge port

Shigeru Yoshida <syoshida@redhat.com>
    ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Brett Creeley <brett.creeley@amd.com>
    ionic: Fix dim work handling in split interrupt mode

Shannon Nelson <shannon.nelson@amd.com>
    ionic: fix snprintf format length warning

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net: bnxt: fix a potential use-after-free in bnxt_init_tc

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix unexpected MFS warning message

Thomas Reichinger <thomas.reichinger@sohard.de>
    arcnet: restoring support for multiple Sohard Arcnet cards

Tong Zhang <ztong0001@gmail.com>
    net: arcnet: com20020 fix error handling

David Thompson <davthompson@nvidia.com>
    mlxbf-bootctl: correctly identify secure boot with development keys

Randy Dunlap <rdunlap@infradead.org>
    hv_netvsc: rndis_filter needs to select NLS

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam

Eric Dumazet <edumazet@google.com>
    ipv6: fix potential NULL deref in fib6_add()

Luca Ceresoli <luca.ceresoli@bootlin.com>
    of: dynamic: Fix of_reconfig_get_state_change() return value documentation

Rob Herring <robh@kernel.org>
    of: Add missing 'Return' section in kerneldoc comments

Rob Herring <robh@kernel.org>
    of: Fix kerneldoc output formatting

Lee Jones <lee.jones@linaro.org>
    of: base: Fix some formatting issues and provide missing descriptions

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi code

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Simplify tablet-mode-switch handling

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-wmi: Simplify tablet-mode-switch probing

Luke D. Jones <luke@ljones.dev>
    platform/x86: asus-wmi: Add support for ROG X13 tablet mode

Luke D. Jones <luke@ljones.dev>
    platform/x86: asus-wmi: Adjust tablet/lidflip handling to use enum

Luke D. Jones <luke@ljones.dev>
    asus-wmi: Add dgpu disable method

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-nb-wmi: Add tablet_mode_sw=lid-flip quirk for the TP200s

Hans de Goede <hdegoede@redhat.com>
    platform/x86: asus-nb-wmi: Allow configuring SW_TABLET_MODE method with a module option

Samuel Čavoj <samuel@cavoj.net>
    platform/x86: asus-wmi: Add support for SW_TABLET_MODE on UX360

YuanShang <YuanShang.Mao@amd.com>
    drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Masahiro Yamada <masahiroy@kernel.org>
    kconfig: fix memory leak from range properties

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Increment tx_dropped in tg3_tso_bug()

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Move the [rt]x_dropped counters to tg3_napi

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Jan Bottorff <janb@os.amperecomputing.com>
    i2c: designware: Fix corrupted memory seen in the ISR

Thomas Gleixner <tglx@linutronix.de>
    hrtimers: Push pending hrtimers away from outgoing CPU earlier


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-bus-optee-devices  |   9 +
 Documentation/ABI/testing/sysfs-platform-asus-wmi  |   9 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx7s.dtsi                       |   8 +-
 arch/arm/mach-imx/mmdc.c                           |   7 +-
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   2 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   4 +-
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |   2 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   6 +-
 arch/mips/Kconfig                                  |   2 +
 arch/mips/include/asm/mach-loongson64/boot_param.h |   3 +-
 arch/mips/loongson64/env.c                         |  10 +-
 arch/mips/loongson64/init.c                        |   5 +
 arch/riscv/kernel/traps_misaligned.c               |   6 +-
 arch/s390/mm/pgtable.c                             |   2 +-
 arch/x86/kernel/cpu/amd.c                          |   3 +
 drivers/base/devcoredump.c                         |  86 +++++-
 drivers/gpio/gpiolib-sysfs.c                       |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  10 +-
 drivers/hwmon/acpi_power_meter.c                   |   4 +
 drivers/i2c/busses/i2c-designware-common.c         |  16 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   2 +-
 drivers/misc/mei/client.c                          |   4 +-
 drivers/mmc/core/core.c                            |   2 +
 drivers/mmc/core/mmc_ops.c                         |   3 +-
 drivers/mmc/core/mmc_ops.h                         |   1 +
 drivers/net/arcnet/arcdevice.h                     |   2 +
 drivers/net/arcnet/com20020-pci.c                  | 117 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |   1 +
 drivers/net/ethernet/broadcom/tg3.c                |  42 ++-
 drivers/net/ethernet/broadcom/tg3.h                |   4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  29 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   6 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  16 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   7 +-
 drivers/net/hyperv/Kconfig                         |   1 +
 drivers/of/base.c                                  | 318 +++++++++++----------
 drivers/of/dynamic.c                               |  22 +-
 drivers/of/fdt.c                                   |  17 +-
 drivers/of/irq.c                                   |  14 +-
 drivers/of/overlay.c                               |  16 +-
 drivers/of/platform.c                              |  10 +-
 drivers/of/property.c                              |  66 +++--
 drivers/parport/parport_pc.c                       |  21 ++
 drivers/platform/mellanox/mlxbf-bootctl.c          |  39 ++-
 drivers/platform/x86/Kconfig                       |   2 +-
 drivers/platform/x86/asus-nb-wmi.c                 |  57 +++-
 drivers/platform/x86/asus-wmi.c                    | 194 +++++++++++--
 drivers/platform/x86/asus-wmi.h                    |   9 +-
 drivers/scsi/be2iscsi/be_main.c                    |   1 +
 drivers/tee/optee/device.c                         |  17 +-
 drivers/tty/serial/8250/8250_early.c               |   1 +
 drivers/tty/serial/8250/8250_omap.c                |  14 +-
 drivers/tty/serial/amba-pl011.c                    | 112 ++++----
 drivers/tty/serial/sc16is7xx.c                     |  12 +
 drivers/usb/gadget/function/f_hid.c                |   7 +-
 drivers/usb/host/xhci-pci.c                        |   2 -
 drivers/usb/typec/class.c                          |   5 +-
 fs/btrfs/disk-io.c                                 |   1 -
 fs/btrfs/super.c                                   |   5 +-
 fs/cifs/cifsfs.c                                   |   4 +-
 fs/cifs/smb2ops.c                                  |   2 +
 fs/nilfs2/sufile.c                                 |  44 ++-
 fs/nilfs2/the_nilfs.c                              |   6 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/hrtimer.h                            |   4 +-
 include/linux/of.h                                 |  63 ++--
 include/linux/perf_event.h                         |   2 +
 include/linux/platform_data/x86/asus-wmi.h         |   5 +
 include/net/genetlink.h                            |   3 +
 include/uapi/linux/perf_event.h                    |   5 +-
 io_uring/io_uring.c                                |  55 ----
 kernel/cpu.c                                       |   8 +-
 kernel/events/core.c                               |  80 ++++--
 kernel/events/ring_buffer.c                        |   5 +-
 kernel/time/hrtimer.c                              |  33 +--
 kernel/trace/ring_buffer.c                         |  19 +-
 kernel/trace/trace.c                               | 219 ++++++--------
 net/core/drop_monitor.c                            |   4 +-
 net/core/filter.c                                  |  19 ++
 net/core/scm.c                                     |   6 +
 net/ipv4/ip_gre.c                                  |  11 +-
 net/ipv4/tcp_input.c                               |   6 +-
 net/ipv6/ip6_fib.c                                 |   6 +-
 net/netfilter/ipset/ip_set_core.c                  |  14 +-
 net/netfilter/nft_set_pipapo.c                     |   3 +
 net/netfilter/xt_owner.c                           |  16 +-
 net/netlink/af_netlink.c                           |   4 +-
 net/netlink/genetlink.c                            |  35 +++
 net/packet/af_packet.c                             |  16 +-
 net/packet/internal.h                              |   2 +-
 net/psample/psample.c                              |   3 +-
 scripts/checkstack.pl                              |   8 +-
 scripts/kconfig/symbol.c                           |  14 +-
 sound/core/pcm.c                                   |   1 +
 sound/pci/hda/patch_realtek.c                      |   1 +
 sound/soc/codecs/wm_adsp.c                         |   8 +-
 tools/include/uapi/linux/perf_event.h              |   5 +-
 104 files changed, 1370 insertions(+), 794 deletions(-)


