Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C678ABEC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjH1Kfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjH1KfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890AAB;
        Mon, 28 Aug 2023 03:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FC963E49;
        Mon, 28 Aug 2023 10:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96480C433C8;
        Mon, 28 Aug 2023 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218920;
        bh=Ru0PX2cLhrnftd7AJuaE7fFhxo6U7vzkibB6wRwGFV0=;
        h=From:To:Cc:Subject:Date:From;
        b=Tj+P4osA+KDpueN3fGsHzxu1UkFEBayzJeyORlQ6QpwjkQONT1cOLrEeLizg99lNq
         5ow/XlHOB+8ysN3UACJXT/g+RMEh/r7FsZzPuefPXZHR/cHd/uEseNY0RM0KUuLSY/
         eRxxCuRJqthaWYoM3xr3qB5sAYl9TdC8TwVIyc5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.4 000/158] 5.4.255-rc1 review
Date:   Mon, 28 Aug 2023 12:11:37 +0200
Message-ID: <20230828101157.322319621@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.255-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.255-rc1
X-KernelTest-Deadline: 2023-08-30T10:12+00:00
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

This is the start of the stable review cycle for the 5.4.255 release.
There are 158 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.255-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.255-rc1

Rob Clark <robdclark@chromium.org>
    dma-buf/sw_sync: Avoid recursive lock during fence signal

Biju Das <biju.das.jz@bp.renesas.com>
    pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}

Biju Das <biju.das.jz@bp.renesas.com>
    clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'

Zhu Wang <wangzhu9@huawei.com>
    scsi: core: raid_class: Remove raid_component_add()

Zhu Wang <wangzhu9@huawei.com>
    scsi: snic: Fix double free in snic_tgt_create()

Jiaxun Yang <jiaxun.yang@flygoat.com>
    irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

Joel Savitz <jsavitz@redhat.com>
    Documentation/sysctl: document page_lock_unfairness

Colin Ian King <colin.i.king@gmail.com>
    ALSA: pcm: Check for null pointer of pointer substream before dereferencing it

Georgi Djakov <georgi.djakov@linaro.org>
    interconnect: Do not skip aggregation for disabled paths

Takashi Iwai <tiwai@suse.de>
    Revert "ALSA: pcm: Use SG-buffer only when direct DMA is available"

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix build error on m68k and others

Ido Schimmel <idosch@nvidia.com>
    rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Linus Torvalds <torvalds@linux-foundation.org>
    mm: allow a controlled amount of unfairness in the page lock

Feng Tang <feng.tang@intel.com>
    x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Ankit Nautiyal <ankit.k.nautiyal@intel.com>
    drm/display/dp: Fix the DP DSC Receiver cap size

Igor Mammedov <imammedo@redhat.com>
    PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus

Wei Chen <harperchen1110@gmail.com>
    media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

Arnd Bergmann <arnd@arndb.de>
    radix tree: remove unused variable

Helge Deller <deller@gmx.de>
    lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Sven Eckelmann <sven@narfation.org>
    batman-adv: Hold rtnl lock during MTU update via netlink

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Fix TT global entry leak when client roamed back

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Do not get eth header before batadv_check_management_packet

Sven Eckelmann <sven@narfation.org>
    batman-adv: Don't increase MTU when set by user

Sven Eckelmann <sven@narfation.org>
    batman-adv: Trigger events for auto adjusted MTU

Benjamin Coddington <bcodding@redhat.com>
    nfsd: Fix race to FREE_STATEID and cl_revoked

Andrey Skvortsov <andrej.skvortzov@gmail.com>
    clk: Fix slab-out-of-bounds error in devm_clk_release()

Benjamin Coddington <bcodding@redhat.com>
    NFSv4: Fix dropped lock for racing OPEN and delegation return

Michael Ellerman <mpe@ellerman.id.au>
    ibmveth: Use dcbf rather than dcbfl

Hangbin Liu <liuhangbin@gmail.com>
    bonding: fix macvlan over alb bond support

Jakub Kicinski <kuba@kernel.org>
    net: remove bond_slave_has_mac_rcu()

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: fix a qdisc modification with ambiguous command request

Alessio Igor Bogani <alessio.bogani@elettra.eu>
    igb: Avoid starting unnecessary workqueues

Jakub Kicinski <kuba@kernel.org>
    net: validate veth and vxcan peer ifindexes

Ruan Jinjie <ruanjinjie@huawei.com>
    net: bcmgenet: Fix return value check for fixed_phy_register()

Ruan Jinjie <ruanjinjie@huawei.com>
    net: bgmac: Fix return value check for fixed_phy_register()

Lu Wei <luwei32@huawei.com>
    ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()

Eric Dumazet <edumazet@google.com>
    dccp: annotate data-races in dccp_poll()

Eric Dumazet <edumazet@google.com>
    sock: annotate data-races around prot->memory_pressure

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: SDP: fix receive link config

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix memleak due to race between current_tracer and trace

Taimur Hassan <syed.hassan@amd.com>
    drm/amd/display: check TG is non-null before checking if enabled

Josip Pavic <Josip.Pavic@amd.com>
    drm/amd/display: do not wait for mpc idle if tg is disabled

Matus Gajdos <matuszpd@gmail.com>
    ASoC: fsl_sai: Disable bit clock with transmitter

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_sai: Add new added registers and new bit definition

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_sai: Refine enable/disable TE/RE sequence in trigger()

Mark Brown <broonie@kernel.org>
    regmap: Account for register length in SMBus I/O limits

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix potential data race at PCM memory allocation helpers

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Use SG-buffer only when direct DMA is available

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Set per-card upper limit of PCM buffer allocations

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: reduce vmalloc space footprint on 32-bit architectures

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: increase RECALC_SECTORS to improve recalculate speed

Zhang Shurong <zhang_shurong@foxmail.com>
    fbdev: fix potential OOB read in fast_imageblit()

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev: Fix sys_imageblit() for arbitrary image widths

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev: Improve performance of sys_imageblit()

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: cpu-features: Use boot_cpu_type for CPU type based features

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: cpu-features: Enable octeon_cache by cpu_type

Alexander Aring <aahringo@redhat.com>
    fs: dlm: fix mismatch of plock results from userspace

Alexander Aring <aahringo@redhat.com>
    fs: dlm: use dlm_plock_info for do_unlock_close

Alexander Aring <aahringo@redhat.com>
    fs: dlm: change plock interrupted message to debug again

Alexander Aring <aahringo@redhat.com>
    fs: dlm: add pid to debug log

Jakob Koschel <jakobkoschel@gmail.com>
    dlm: replace usage of found with dedicated list iterator variable

Alexander Aring <aahringo@redhat.com>
    dlm: improve plock logging if interrupted

Igor Mammedov <imammedo@redhat.com>
    PCI: acpiphp: Reassign resources on bridge if necessary

Justin Chen <justin.chen@broadcom.com>
    net: phy: broadcom: stub c45 read/write for 54810

Yangtao Li <frank.li@vivo.com>
    mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove

Lin Ma <linma@zju.edu.cn>
    net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure

Jason Xing <kernelxing@tencent.com>
    net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled

Jason Wang <jasowang@redhat.com>
    virtio-net: set queues after driver_ok

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Xin Long <lucien.xin@gmail.com>
    netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Yibin Ding <yibin.ding@unisoc.com>
    mmc: block: Fix in_flight[issue_type] value error

Yang Yingliang <yangyingliang@huawei.com>
    mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Russell Harmon via samba-technical <samba-technical@lists.samba.org>
    cifs: Release folio lock on fscache read hit.

dengxiang <dengxiang@nfschina.com>
    ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.

Tony Lindgren <tony@atomide.com>
    serial: 8250: Fix oops for port->pm on uart_change_pm()

Jerome Brunet <jbrunet@baylibre.com>
    ASoC: meson: axg-tdm-formatter: fix channel slot allocation

Zhang Shurong <zhang_shurong@foxmail.com>
    ASoC: rt5665: add missed regulator_bulk_disable

Xiaolei Wang <xiaolei.wang@windriver.com>
    ARM: dts: imx: Set default tuning step for imx6sx usdhc

Xiaolei Wang <xiaolei.wang@windriver.com>
    ARM: dts: imx: Set default tuning step for imx7d usdhc

Stefan Wahren <stefan.wahren@i2se.com>
    ARM: dts: imx: Adjust dma-apbh node name

Marek Vasut <marex@denx.de>
    ARM: dts: imx7s: Drop dma-apb interrupt-names

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Flush posted write on enable before reset

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Improve reset to work with modules with no sysconfig

Eric Dumazet <edumazet@google.com>
    net: do not allow gso_size to be set to GSO_BY_FRAGS

Abel Wu <wuyun.abel@bytedance.com>
    sock: Fix misuse of sk_under_memory_pressure()

Alfred Lee <l00g33k@gmail.com>
    net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

Andrii Staikov <andrii.staikov@intel.com>
    i40e: fix misleading debug logs

Ziyang Xuan <william.xuanziyang@huawei.com>
    team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_dynset: disallow object maps

Sishuai Gong <sishuai.system@gmail.com>
    ipvs: fix racy memcpy in proc_do_sync_threshold

Petr Machata <petrm@nvidia.com>
    selftests: mirror_gre_changes: Tighten up the TTL test match

Lin Ma <linma@zju.edu.cn>
    xfrm: add NULL check in xfrm_update_ae_params

Zhengchao Shao <shaozhengchao@huawei.com>
    ip_vti: fix potential slab-use-after-free in decode_session6

Zhengchao Shao <shaozhengchao@huawei.com>
    ip6_vti: fix slab-use-after-free in decode_session6

Zhengchao Shao <shaozhengchao@huawei.com>
    xfrm: fix slab-use-after-free in decode_session6

Eyal Birger <eyal.birger@gmail.com>
    xfrm: interface: rename xfrm_interface.c to xfrm_interface_core.c

Lin Ma <linma@zju.edu.cn>
    net: af_key: fix sadb_x_filter validation

Lin Ma <linma@zju.edu.cn>
    net: xfrm: Fix xfrm_address_filter OOB read

xiaoshoukui <xiaoshoukui@gmail.com>
    btrfs: fix BUG_ON condition in btrfs_cancel_balance

Sherry Sun <sherry.sun@nxp.com>
    tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/rtas_flash: allow user copy to flash block cache objects

Yuanjun Gong <ruc_gongyuanjun@163.com>
    fbdev: mmp: fix value check in mmphw_probe()

Chengfeng Ye <dg573847474@gmail.com>
    i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue

Wolfram Sang <wsa+renesas@sang-engineering.com>
    virtio-mmio: don't break lifecycle of vm_dev

Tang Bin <tangbin@cmss.chinamobile.com>
    virtio-mmio: Use to_virtio_mmio_device() to simply code

Yangtao Li <tiny.windzz@gmail.com>
    virtio-mmio: convert to devm_platform_ioremap_resource

Trond Myklebust <trond.myklebust@hammerspace.com>
    nfsd: Remove incorrect check in nfsd4_validate_stateid

J. Bruce Fields <bfields@redhat.com>
    nfsd4: kill warnings on testing stateids with mismatched clientids

Vijay Khemka <vijaykhemka@fb.com>
    net/ncsi: Fix gma flag setting after response

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/probes: Fix to update dynamic data counter if fetcharg uses it

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing/probes: Have process_fetch_insn() take a void * instead of pt_regs

Christian Marangi <ansuelsmth@gmail.com>
    leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: sunxi: fix deferred probing

Sergey Shtylyov <s.shtylyov@omp.ru>
    mmc: bcm2835: fix deferred probing

Johan Hovold <johan+linaro@kernel.org>
    USB: dwc3: qcom: fix NULL-deref on suspend

Sandeep Maheswaram <quic_c_sanm@quicinc.com>
    usb: dwc3: qcom: Add helper functions to enable,disable wake irqs

Georgi Djakov <georgi.djakov@linaro.org>
    interconnect: Add helpers for enabling/disabling a path

Georgi Djakov <georgi.djakov@linaro.org>
    interconnect: Move internal structs into a separate file

Jiaxun Yang <jiaxun.yang@flygoat.com>
    irqchip/mips-gic: Use raw spinlock for gic_lock

Marc Zyngier <maz@kernel.org>
    irqchip/mips-gic: Get rid of the reliance on irq_cpu_online()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Fix unhandled register update during auto-suspend period

Sakari Ailus <sakari.ailus@linux.intel.com>
    PM: runtime: Add pm_runtime_get_if_active()

Michał Mirosław <mirq-linux@rere.qmqm.pl>
    PM-runtime: add tracepoints for usage_count changes

Kishon Vijay Abraham I <kvijayab@amd.com>
    iommu/amd: Fix "Guest Virtual APIC Table Root Pointer" configuration in IRTE

William Breathitt Gray <william.gray@linaro.org>
    iio: addac: stx104: Fix race condition when converting analog-to-digital

William Breathitt Gray <william.gray@linaro.org>
    iio: addac: stx104: Fix race condition for stx104_write_raw()

William Breathitt Gray <william.gray@linaro.org>
    iio: stx104: Move to addac subdirectory

William Breathitt Gray <william.gray@linaro.org>
    iio: adc: stx104: Implement and utilize register structures

William Breathitt Gray <william.gray@linaro.org>
    iio: adc: stx104: Utilize iomap interface

Cosmin Tanislav <demonsingur@gmail.com>
    iio: add addac subdirectory

Randy Dunlap <rdunlap@infradead.org>
    IMA: allow/fix UML builds

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/kasan: Disable KCOV in KASAN code

Tuo Li <islituo@gmail.com>
    ALSA: hda: fix a possible null-pointer dereference due to data race in snd_hdac_regmap_sync()

dengxiang <dengxiang@nfschina.com>
    ALSA: hda/realtek: Add quirks for Unis H3C Desktop B760 & Q760

shanzhulig <shanzhulig@gmail.com>
    drm/amdgpu: Fix potential fence use-after-free v2

Zhengping Jiang <jiangzp@google.com>
    Bluetooth: L2CAP: Fix use-after-free

Armin Wolf <W_Armin@gmx.de>
    pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Tuo Li <islituo@gmail.com>
    gfs2: Fix possible data races in gfs2_show_options()

Xu Yang <xu.yang_2@nxp.com>
    usb: chipidea: imx: don't request QoS for imx8ulp

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: platform: mediatek: vpu: fix NULL ptr dereference

Yunfei Dong <yunfei.dong@mediatek.com>
    media: v4l2-mem2mem: add lock to protect parameter num_rdy

Immad Mir <mirimmad17@gmail.com>
    FS: JFS: Check for read-only mounted filesystem in txBegin

Immad Mir <mirimmad17@gmail.com>
    FS: JFS: Fix null-ptr-deref Read in txBegin

Gustavo A. R. Silva <gustavoars@kernel.org>
    MIPS: dec: prom: Address -Warray-bounds warning

Yogesh <yogi.kernel@gmail.com>
    fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Jan Kara <jack@suse.cz>
    udf: Fix uninitialized array access for some pathnames

Christian Brauner <brauner@kernel.org>
    ovl: check type and offset of struct vfsmount in ovl_entry

Marco Morandini <marco.morandini@polimi.it>
    HID: add quirk for 03f0:464a HP Elite Presenter Mouse

Ye Bin <yebin10@huawei.com>
    quota: fix warning in dqgrab()

Jan Kara <jack@suse.cz>
    quota: Properly disable quotas when add_dquot_ref() fails

Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
    ALSA: emu10k1: roll up loops in DSP setup code for Audigy

hackyzh002 <hackyzh002@gmail.com>
    drm/radeon: Fix integer overflow in radeon_cs_parser_init

Eric Dumazet <edumazet@google.com>
    macsec: use DEV_STATS_INC()

Clayton Yager <Clayton_Yager@selinc.com>
    macsec: Fix traffic counters/statistics

Ido Schimmel <idosch@nvidia.com>
    selftests: forwarding: tc_flower: Relax success criterion

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Yangtao Li <tiny.windzz@gmail.com>
    mmc: sdhci_f_sdh30: convert to devm_platform_ioremap_resource


-------------

Diffstat:

 Documentation/admin-guide/sysctl/vm.rst            |   9 ++
 Documentation/power/runtime_pm.rst                 |   6 +
 MAINTAINERS                                        |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx23.dtsi                       |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   2 +-
 arch/arm/boot/dts/imx7s.dtsi                       |   9 +-
 arch/mips/include/asm/cpu-features.h               |  21 ++-
 arch/mips/include/asm/dec/prom.h                   |   2 +-
 arch/powerpc/kernel/rtas_flash.c                   |   6 +-
 arch/powerpc/mm/kasan/Makefile                     |   1 +
 arch/x86/kernel/fpu/xstate.c                       |   8 ++
 drivers/base/power/runtime.c                       |  49 +++++--
 drivers/base/regmap/regmap-i2c.c                   |   4 +-
 drivers/bus/ti-sysc.c                              |  12 +-
 drivers/clk/clk-devres.c                           |  13 +-
 drivers/dma-buf/sw_sync.c                          |  18 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   6 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   4 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |   3 +-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c                 |  11 +-
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |  16 ---
 drivers/iio/adc/Makefile                           |   1 -
 drivers/iio/addac/Kconfig                          |  24 ++++
 drivers/iio/addac/Makefile                         |   7 +
 drivers/iio/{adc => addac}/stx104.c                |  98 +++++++++----
 drivers/interconnect/core.c                        |  77 ++++++----
 drivers/interconnect/internal.h                    |  42 ++++++
 drivers/iommu/amd_iommu_types.h                    |   4 +-
 drivers/irqchip/irq-mips-gic.c                     |  65 +++++----
 drivers/leds/trigger/ledtrig-netdev.c              |   3 +
 drivers/md/dm-integrity.c                          |   4 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |   2 +
 drivers/media/platform/mtk-vpu/mtk_vpu.c           |   6 +-
 drivers/mmc/core/block.c                           |   7 +-
 drivers/mmc/host/bcm2835.c                         |   4 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |  68 ++++-----
 drivers/mmc/host/sunxi-mmc.c                       |   4 +-
 drivers/mmc/host/wbsd.c                            |   2 -
 drivers/net/bonding/bond_alb.c                     |   6 +-
 drivers/net/can/vxcan.c                            |   7 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   8 ++
 drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  16 +--
 drivers/net/ethernet/intel/igb/igb_ptp.c           |  24 ++--
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   3 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   3 +-
 drivers/net/macsec.c                               |  70 +++++++--
 drivers/net/phy/broadcom.c                         |  13 ++
 drivers/net/team/team.c                            |   4 +-
 drivers/net/veth.c                                 |   5 +-
 drivers/net/virtio_net.c                           |   4 +-
 drivers/pci/hotplug/acpiphp_glue.c                 |   9 +-
 drivers/pcmcia/rsrc_nonstatic.c                    |   2 +
 drivers/pinctrl/pinctrl-rza2.c                     |  17 ++-
 drivers/scsi/raid_class.c                          |  48 -------
 drivers/scsi/snic/snic_disc.c                      |   3 +-
 drivers/tty/serial/8250/8250_port.c                |   1 +
 drivers/tty/serial/fsl_lpuart.c                    |   4 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   5 +
 drivers/usb/dwc3/dwc3-qcom.c                       |  69 ++++-----
 drivers/video/fbdev/core/sysimgblt.c               |  64 +++++++--
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |   4 +-
 drivers/virtio/virtio_mmio.c                       |  23 +--
 fs/btrfs/volumes.c                                 |   3 +-
 fs/cifs/file.c                                     |   2 +-
 fs/dlm/lock.c                                      |  53 ++++---
 fs/dlm/plock.c                                     |  89 ++++++++----
 fs/dlm/recover.c                                   |  39 +++--
 fs/gfs2/super.c                                    |  26 ++--
 fs/jfs/jfs_dmap.c                                  |   3 +
 fs/jfs/jfs_txnmgr.c                                |   5 +
 fs/jfs/namei.c                                     |   5 +
 fs/nfs/nfs4proc.c                                  |   9 +-
 fs/nfsd/nfs4state.c                                |  11 +-
 fs/overlayfs/ovl_entry.h                           |   9 ++
 fs/quota/dquot.c                                   |   5 +-
 fs/udf/unicode.c                                   |   2 +-
 include/drm/drm_dp_helper.h                        |   2 +-
 include/linux/clk.h                                |  80 +++++------
 include/linux/interconnect.h                       |  12 ++
 include/linux/mm.h                                 |   2 +
 include/linux/pm_runtime.h                         |  12 +-
 include/linux/raid_class.h                         |   4 -
 include/linux/virtio_net.h                         |   4 +
 include/linux/wait.h                               |   2 +
 include/media/v4l2-mem2mem.h                       |  18 ++-
 include/net/bonding.h                              |  25 +---
 include/net/rtnetlink.h                            |   4 +-
 include/net/sock.h                                 |  11 +-
 include/sound/core.h                               |   3 +
 include/trace/events/rpm.h                         |   6 +
 kernel/sysctl.c                                    |   8 ++
 kernel/trace/trace.c                               |   9 +-
 kernel/trace/trace_irqsoff.c                       |   3 +-
 kernel/trace/trace_kprobe.c                        |   3 +-
 kernel/trace/trace_probe_tmpl.h                    |  18 +--
 kernel/trace/trace_sched_wakeup.c                  |   2 +
 kernel/trace/trace_uprobe.c                        |   3 +-
 lib/clz_ctz.c                                      |  32 +----
 lib/radix-tree.c                                   |   1 -
 mm/filemap.c                                       | 160 +++++++++++++++++----
 net/batman-adv/bat_v_elp.c                         |   3 +-
 net/batman-adv/bat_v_ogm.c                         |   7 +-
 net/batman-adv/hard-interface.c                    |  14 +-
 net/batman-adv/netlink.c                           |   3 +
 net/batman-adv/soft-interface.c                    |   3 +
 net/batman-adv/translation-table.c                 |   1 -
 net/batman-adv/types.h                             |   6 +
 net/bluetooth/l2cap_core.c                         |   5 +
 net/core/rtnetlink.c                               |  29 +++-
 net/core/sock.c                                    |   2 +-
 net/dccp/proto.c                                   |  20 +--
 net/ipv4/ip_vti.c                                  |   4 +-
 net/ipv4/tcp_timer.c                               |   4 +-
 net/ipv6/ip6_vti.c                                 |   4 +-
 net/key/af_key.c                                   |   4 +-
 net/ncsi/ncsi-manage.c                             |   3 -
 net/ncsi/ncsi-rsp.c                                |   6 +
 net/netfilter/ipvs/ip_vs_ctl.c                     |   4 +
 net/netfilter/nf_conntrack_proto_sctp.c            |   6 +-
 net/netfilter/nft_dynset.c                         |   3 +
 net/sched/sch_api.c                                |  53 +++++--
 net/sctp/socket.c                                  |   2 +-
 net/unix/af_unix.c                                 |   9 +-
 net/xfrm/Makefile                                  |   2 +
 .../{xfrm_interface.c => xfrm_interface_core.c}    |   4 +-
 net/xfrm/xfrm_user.c                               |  13 +-
 security/integrity/ima/Kconfig                     |   2 +-
 sound/core/init.c                                  |   1 +
 sound/core/pcm_memory.c                            |  99 ++++++++++---
 sound/hda/hdac_device.c                            |   2 +-
 sound/hda/hdac_regmap.c                            |   7 +-
 sound/pci/emu10k1/emufx.c                          | 112 ++-------------
 sound/pci/hda/patch_realtek.c                      |   9 ++
 sound/soc/codecs/rt5665.c                          |   2 +
 sound/soc/fsl/fsl_sai.c                            | 143 +++++++++++++-----
 sound/soc/fsl/fsl_sai.h                            |  60 ++++++++
 sound/soc/meson/axg-tdm-formatter.c                |  42 +++---
 sound/usb/quirks-table.h                           |  29 ++++
 .../selftests/net/forwarding/mirror_gre_changes.sh |   3 +-
 .../testing/selftests/net/forwarding/tc_flower.sh  |   8 +-
 151 files changed, 1603 insertions(+), 875 deletions(-)


