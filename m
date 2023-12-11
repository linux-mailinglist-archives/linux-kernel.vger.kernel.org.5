Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69FA80D81E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbjLKSmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbjLKSmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:42:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66FBD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:42:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD22DC433C8;
        Mon, 11 Dec 2023 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702320174;
        bh=PpksGrSnsbl7NvnLFOoRUn/7YNNa2ndyMrsLfjhggXk=;
        h=From:To:Cc:Subject:Date:From;
        b=n/t+lJBl80dIEzfnpv1D7l6q2Jz2jaRYVHh/ch+Kn3T7FhfjPvqiVbW4/ntmZ5Z8+
         agzlYVx8v7JBcKdmClXbNiUNJ3YN5jeUasf468FskqoGoGJiQ/Sm4dFIHWVrOjKOaz
         wxh6q9FuZlToOb543v/n5bd3mepNiPv4lK3t8E0w=
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
Subject: [PATCH 5.4 00/67] 5.4.264-rc1 review
Date:   Mon, 11 Dec 2023 19:21:44 +0100
Message-ID: <20231211182015.049134368@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.264-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.264-rc1
X-KernelTest-Deadline: 2023-12-13T18:20+00:00
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

This is the start of the stable review cycle for the 5.4.264 release.
There are 67 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.264-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.264-rc1

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

Namhyung Kim <namhyung@kernel.org>
    tools headers UAPI: Sync linux/perf_event.h with the kernel sources

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

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing error check for sb_set_blocksize call

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390/mm: Properly reset no-dat

Borislav Petkov (AMD) <bp@alien8.de>
    x86/CPU/AMD: Check vendor in the AMD microcode callback

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250_omap: Add earlycon support for the AM654 UART controller

Daniel Mack <daniel@zonque.org>
    serial: sc16is7xx: address RX timeout interrupt errata

Arnd Bergmann <arnd@arndb.de>
    ARM: PL011: Fix DMA support

RD Babiera <rdbabiera@google.com>
    usb: typec: class: fix typec_altmode_put_partner to put plugs

Cameron Williams <cang1@live.co.uk>
    parport: Add support for Brainboxes IX/UC/PX parallel cards

Konstantin Aladyshev <aladyshev22@gmail.com>
    usb: gadget: f_hid: fix report descriptor allocation

Wenchao Chen <wenchao.chen@unisoc.com>
    mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulled

Heiner Kallweit <hkallweit1@gmail.com>
    mmc: core: add helpers mmc_regulator_enable/disable_vqmmc

Boerge Struempfel <boerge.struempfel@gmail.com>
    gpiolib: sysfs: Fix error handling on failed export

Peter Zijlstra <peterz@infradead.org>
    perf: Fix perf_event_validate_size()

Namhyung Kim <namhyung@kernel.org>
    perf/core: Add a new read format to get a number of lost samples

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
    tracing: Always update snapshot buffer size

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Jason Zhang <jason.zhang@rock-chips.com>
    ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Philipp Zabel <p.zabel@pengutronix.de>
    ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

Anson Huang <Anson.Huang@nxp.com>
    ARM: dts: imx: make gpt node name generic

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

Thomas Reichinger <thomas.reichinger@sohard.de>
    arcnet: restoring support for multiple Sohard Arcnet cards

Tong Zhang <ztong0001@gmail.com>
    net: arcnet: com20020 fix error handling

Ahmed S. Darwish <a.darwish@linutronix.de>
    net: arcnet: Fix RESET flag handling

Randy Dunlap <rdunlap@infradead.org>
    hv_netvsc: rndis_filter needs to select NLS

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

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    of/irq: Make of_msi_map_rid() PCI bus agnostic

Diana Craciun <diana.craciun@oss.nxp.com>
    of/irq: make of_msi_map_get_device_domain() bus agnostic

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    of/iommu: Make of_map_rid() PCI agnostic

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    ACPI/IORT: Make iort_msi_map_rid() PCI agnostic

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    ACPI/IORT: Make iort_get_device_domain IRQ domain agnostic

Ulf Hansson <ulf.hansson@linaro.org>
    of: base: Add of_get_cpu_state_node() to get idle states for a CPU node

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

Thomas Gleixner <tglx@linutronix.de>
    hrtimers: Push pending hrtimers away from outgoing CPU earlier


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   2 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   2 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   4 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  16 +-
 arch/arm/mach-imx/mmdc.c                           |   7 +-
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   2 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |   4 +-
 arch/s390/mm/pgtable.c                             |   2 +-
 arch/x86/kernel/cpu/amd.c                          |   3 +
 drivers/acpi/arm64/iort.c                          |  26 +-
 drivers/base/devcoredump.c                         |  86 ++++-
 drivers/gpio/gpiolib-sysfs.c                       |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/hwmon/acpi_power_meter.c                   |   4 +
 drivers/infiniband/hw/bnxt_re/main.c               |   2 +-
 drivers/iommu/of_iommu.c                           |   4 +-
 drivers/mmc/core/regulator.c                       |  41 +++
 drivers/mmc/host/sdhci-sprd.c                      |  25 ++
 drivers/net/arcnet/arc-rimi.c                      |   4 +-
 drivers/net/arcnet/arcdevice.h                     |   8 +
 drivers/net/arcnet/arcnet.c                        |  66 +++-
 drivers/net/arcnet/com20020-isa.c                  |   4 +-
 drivers/net/arcnet/com20020-pci.c                  | 119 ++++---
 drivers/net/arcnet/com20020_cs.c                   |   2 +-
 drivers/net/arcnet/com90io.c                       |   4 +-
 drivers/net/arcnet/com90xx.c                       |   4 +-
 drivers/net/ethernet/broadcom/tg3.c                |  42 ++-
 drivers/net/ethernet/broadcom/tg3.h                |   4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  29 ++
 drivers/net/hyperv/Kconfig                         |   1 +
 drivers/of/base.c                                  | 394 ++++++++++++---------
 drivers/of/dynamic.c                               |  22 +-
 drivers/of/fdt.c                                   |  17 +-
 drivers/of/irq.c                                   |  46 +--
 drivers/of/overlay.c                               |  16 +-
 drivers/of/platform.c                              |  10 +-
 drivers/of/property.c                              |  66 ++--
 drivers/parport/parport_pc.c                       |  21 ++
 drivers/pci/msi.c                                  |   9 +-
 drivers/scsi/be2iscsi/be_main.c                    |   1 +
 drivers/tty/serial/8250/8250_early.c               |   1 +
 drivers/tty/serial/amba-pl011.c                    | 112 +++---
 drivers/tty/serial/sc16is7xx.c                     |  12 +
 drivers/usb/gadget/function/f_hid.c                |   7 +-
 drivers/usb/typec/class.c                          |   5 +-
 fs/btrfs/disk-io.c                                 |   1 -
 fs/btrfs/super.c                                   |   5 +-
 fs/cifs/cifsfs.c                                   |   4 +-
 fs/cifs/smb2ops.c                                  |   2 +
 fs/io_uring.c                                      | 101 +-----
 fs/nilfs2/sufile.c                                 |  44 ++-
 fs/nilfs2/the_nilfs.c                              |   6 +-
 include/linux/acpi_iort.h                          |  13 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/hrtimer.h                            |   4 +-
 include/linux/mmc/host.h                           |   3 +
 include/linux/of.h                                 |  75 ++--
 include/linux/of_irq.h                             |  13 +-
 include/linux/perf_event.h                         |   2 +
 include/net/genetlink.h                            |   3 +
 include/uapi/linux/perf_event.h                    |   5 +-
 kernel/cpu.c                                       |   8 +-
 kernel/events/core.c                               |  80 +++--
 kernel/events/ring_buffer.c                        |   5 +-
 kernel/time/hrtimer.c                              |  33 +-
 kernel/trace/trace.c                               |  42 ++-
 net/core/drop_monitor.c                            |   4 +-
 net/core/filter.c                                  |  19 +
 net/core/scm.c                                     |   6 +
 net/ipv4/ip_gre.c                                  |  11 +-
 net/ipv4/tcp_input.c                               |   6 +-
 net/ipv6/ip6_fib.c                                 |   6 +-
 net/netfilter/ipset/ip_set_core.c                  |  14 +-
 net/netfilter/xt_owner.c                           |  16 +-
 net/netlink/af_netlink.c                           |   4 +-
 net/netlink/genetlink.c                            |  35 ++
 net/packet/af_packet.c                             |  16 +-
 net/packet/internal.h                              |   2 +-
 net/psample/psample.c                              |   3 +-
 scripts/kconfig/symbol.c                           |  14 +-
 sound/core/pcm.c                                   |   1 +
 sound/soc/codecs/wm_adsp.c                         |   8 +-
 tools/include/uapi/linux/perf_event.h              |   5 +-
 86 files changed, 1191 insertions(+), 710 deletions(-)


