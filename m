Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C609A7A7BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjITLzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjITLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:55:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD8E9;
        Wed, 20 Sep 2023 04:55:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08E5C433C9;
        Wed, 20 Sep 2023 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210931;
        bh=joGaHA/K28WaAlO+7LAOs5+UqdHdGMhTh0SlH7dCGho=;
        h=From:To:Cc:Subject:Date:From;
        b=mEKkFmqzMXHs6tNds7U+TpLjk12mTnhY0f+wJPsFaZHsAHHP7bwHKLLSihIoSyprQ
         Ru6fKBd9wmrYNVtdAL9yZGk5LMWUkEWkLWuFRgkk3JkN4ObkT6N0SKIWu2pPFnjRmJ
         e1g7uK8v7cngiK2tCo7bFEG51+1jXfkAWszBg8Kg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 6.1 000/139] 6.1.55-rc1 review
Date:   Wed, 20 Sep 2023 13:28:54 +0200
Message-ID: <20230920112835.549467415@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.55-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.55-rc1
X-KernelTest-Deadline: 2023-09-22T11:28+00:00
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

This is the start of the stable review cycle for the 6.1.55 release.
There are 139 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.55-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.55-rc1

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire rsvp classifier

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix amdgpu_cs_p1_user_fence

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "memcg: drop kmem.limit_in_bytes"

Yifan Zhang <yifan1.zhang@amd.com>
    drm/amd/display: fix the white screen issue when >= 64GB DRAM

Shida Zhang <zhangshida@kylinos.cn>
    ext4: fix rec_len verify error

Damien Le Moal <dlemoal@kernel.org>
    scsi: pm8001: Setup IRQs on resume

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: megaraid_sas: Fix deadlock on firmware crashdump

Szuying Chen <chensiying21@gmail.com>
    ata: libahci: clear pending interrupt status

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata: disallow dev-initiated LPM transitions to unsupported states

Tommy Huang <tommy_huang@aspeedtech.com>
    i2c: aspeed: Reset the i2c controller when timeout occurs

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracefs: Add missing lockdown check to tracefs_create_dir()

Jeff Layton <jlayton@kernel.org>
    nfsd: fix change_info in NFSv4 RENAME replies

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: fix handling of empty opts in selinux_fs_context_submount()

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have option files inc the trace array ref count

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have current_trace inc the trace array ref count

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Increase trace array ref count on enable and filter files

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have event inject files inc the trace array ref count

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have tracing_max_latency inc the trace array ref count

Josef Bacik <josef@toxicpanda.com>
    btrfs: check for BTRFS_FS_ERROR in pending ordered assert

Filipe Manana <fdmanana@suse.com>
    btrfs: release path before inode lookup during the ino lookup ioctl

Qu Wenruo <wqu@suse.com>
    btrfs: fix a compilation error if DEBUG is defined in btree_dirty_folio

Filipe Manana <fdmanana@suse.com>
    btrfs: fix lockdep splat and potential deadlock after failure running delayed items

Jens Axboe <axboe@kernel.dk>
    dm: don't attempt to queue IO under RCU protection

Hamza Mahfooz <hamza.mahfooz@amd.com>
    Revert "drm/amd: Disable S/G for APUs when 64GB or more host memory"

Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
    md: Put the right device in md_seq_next

Keith Busch <kbusch@kernel.org>
    nvme: avoid bogus CRTO values

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/net: fix iter retargeting for selected buf

Amir Goldstein <amir73il@gmail.com>
    ovl: fix incorrect fdput() on aio completion

Amir Goldstein <amir73il@gmail.com>
    ovl: fix failed copyup of fileattr on a symlink

Christian Brauner <brauner@kernel.org>
    attr: block mode changes of symlinks

Trond Myklebust <trond.myklebust@hammerspace.com>
    Revert "SUNRPC: Fail faster on bad verifier"

Nigel Croxon <ncroxon@redhat.com>
    md/raid1: fix error: ISO C90 forbids mixed declarations

Arnd Bergmann <arnd@arndb.de>
    samples/hw_breakpoint: fix building without module unloading

Song Liu <song@kernel.org>
    x86/purgatory: Remove LTO flags

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/boot/compressed: Reserve more memory for page tables

Lukas Wunner <lukas@wunner.de>
    panic: Reenable preemption in WARN slowpath

Jinjie Ruan <ruanjinjie@huawei.com>
    scsi: lpfc: Fix the NULL vs IS_ERR() bug for debugfs_create_file()

David Disseldorp <ddiss@suse.de>
    scsi: target: core: Fix target_cmd_counter leak

Song Shuai <songshuaishuai@tinylab.org>
    riscv: kexec: Align the kexeced kernel entry

Peter Zijlstra <peterz@infradead.org>
    x86/ibt: Suppress spurious ENDBR

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    selftests: tracing: Fix to unmount tracefs for recovering environment

Jinjie Ruan <ruanjinjie@huawei.com>
    scsi: qla2xxx: Fix NULL vs IS_ERR() bug for debugfs_create_dir()

Jinjie Ruan <ruanjinjie@huawei.com>
    drm: gm12u320: Fix the timeout usage for usb_bulk_msg()

Varun Prakash <varun@chelsio.com>
    nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()

Christoph Hellwig <hch@lst.de>
    nvmet: use bvec_set_page to initialize bvecs

Christoph Hellwig <hch@lst.de>
    block: factor out a bvec_set_page helper

Anand Jain <anand.jain@oracle.com>
    btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super

Anand Jain <anand.jain@oracle.com>
    btrfs: add a helper to read the superblock metadata_uuid

Tiezhu Yang <yangtiezhu@loongson.cn>
    MIPS: Use "grep -E" instead of "egrep"

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Fix incorrect DMA mapping unmap request

Dmitry Osipenko <dmitry.osipenko@collabora.com>
    misc: fastrpc: Prepare to dynamic dma-buf locking specification

Dmitry Osipenko <dmitry.osipenko@collabora.com>
    dma-buf: Add unlocked variant of attachment-mapping functions

John Ogness <john.ogness@linutronix.de>
    printk: Consolidate console deferred printing

John Ogness <john.ogness@linutronix.de>
    printk: Keep non-panic-CPUs out of console lock

Rob Clark <robdclark@chromium.org>
    interconnect: Fix locking for runpm vs reclaim

Zhen Lei <thunder.leizhen@huawei.com>
    kobject: Add sanity check for kset->kobj.ktype in kset_register()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning

Xu Yang <xu.yang_2@nxp.com>
    usb: chipidea: add workaround for chipidea PEC bug

Xu Yang <xu.yang_2@nxp.com>
    usb: ehci: add workaround for chipidea PORTSC.PEC bug

Baoquan He <bhe@redhat.com>
    misc: open-dice: make OPEN_DICE depend on HAS_IOMEM

Christophe Leroy <christophe.leroy@csgroup.eu>
    serial: cpm_uart: Avoid suspicious locking

Konstantin Shelekhin <k.shelekhin@yadro.com>
    scsi: target: iscsi: Fix buffer overflow in lio_target_nacl_info_show()

Chenyuan Mi <michenyuan@huawei.com>
    tools: iio: iio_generic_buffer: Fix some integer type and calculation

Ma Ke <make_ruc2021@163.com>
    usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc

Xiaolei Wang <xiaolei.wang@windriver.com>
    usb: cdns3: Put the cdns set active part outside the spin lock

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: pci: cx23885: replace BUG with error return

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: tuners: qt1010: replace BUG_ON with a regular error

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Abort outstanding ELS cmds when mailbox timeout error is detected

Zhang Shurong <zhang_shurong@foxmail.com>
    media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer

Zhang Shurong <zhang_shurong@foxmail.com>
    media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()

Zhang Shurong <zhang_shurong@foxmail.com>
    media: anysee: fix null-ptr-deref in anysee_master_xfer

Zhang Shurong <zhang_shurong@foxmail.com>
    media: af9005: Fix null-ptr-deref in af9005_i2c_xfer

Zhang Shurong <zhang_shurong@foxmail.com>
    media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()

Zhang Shurong <zhang_shurong@foxmail.com>
    media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer

Lu Hongfei <luhongfei@vivo.com>
    media: mdp3: Fix resource leaks in of_find_device_by_node

Yong-Xuan Wang <yongxuan.wang@sifive.com>
    PCI: fu740: Set the number of MSI vectors

Nirmal Patel <nirmal.patel@linux.intel.com>
    PCI: vmd: Disable bridge window for domain reset

ruanjinjie <ruanjinjie@huawei.com>
    powerpc/pseries: fix possible memory leak in ibmebus_bus_init()

Mårten Lindahl <marten.lindahl@axis.com>
    ARM: 9317/1: kexec: Make smp stop calls asynchronous

Mark Brown <broonie@kernel.org>
    PCI: dwc: Provide deinit callback for i.MX

Liu Shixin via Jfs-discussion <jfs-discussion@lists.sourceforge.net>
    jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount

Andrew Kanner <andrew.kanner@gmail.com>
    fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()

Georg Ottinger <g.ottinger@gmx.at>
    ext2: fix datatype of block number in ext2_xattr_set2()

Zhang Shurong <zhang_shurong@foxmail.com>
    md: raid1: fix potential OOB in raid1_remove_disk()

Tony Lindgren <tony@atomide.com>
    bus: ti-sysc: Configure uart quirks for k3 SoC

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    drm/mediatek: dp: Change logging to dev for mtk_dp_aux_transfer()

Tuo Li <islituo@gmail.com>
    drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()

Leo Chen <sancchen@amd.com>
    drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN314

Leo Chen <sancchen@amd.com>
    drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31

Austin Zheng <austin.zheng@amd.com>
    drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: intel-dsp-cfg: add LunarLake support

Uday M Bhat <uday.m.bhat@intel.com>
    ASoC: Intel: sof_sdw: Update BT offload config for soundwire config

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: SOF: topology: simplify code to prevent static analysis warnings

Leo Ma <hanghong.ma@amd.com>
    drm/amd/display: Fix underflow issue on 175hz timing

Rong Tao <rongtao@cestc.cn>
    samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8250-edo: correct ramoops pmsg-size

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm8150-kumano: correct ramoops pmsg-size

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm6350: correct ramoops pmsg-size

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    arm64: dts: qcom: sm6125-pdx201: correct ramoops pmsg-size

Ralph Campbell <rcampbell@nvidia.com>
    drm/edid: Add quirk for OSVR HDK 2.0

Marek Vasut <marex@denx.de>
    drm/bridge: tc358762: Instruct DSI host to generate HSE packets

Hao Luo <haoluo@google.com>
    libbpf: Free btf_vmlinux when closing bpf_object

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211_hwsim: drop short frames

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: check for station first in client probe

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: ocb: don't leave if not joined

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: reject auth/assoc to AP with our address

GONG, Ruiqi <gongruiqi1@huawei.com>
    netfilter: ebtables: fix fortify warnings in size_entry_mwt()

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: check S1G action frame size

GONG, Ruiqi <gongruiqi1@huawei.com>
    alx: fix OOB-read compiler warning

Giulio Benetti <giulio.benetti@benettiengineering.com>
    mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis: Resend command to recover from data transfer errors

Eric Dumazet <edumazet@google.com>
    netlink: convert nlk->flags to atomic flags

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Fix hci_suspend_sync crash

Mark O'Donovan <shiftee@posteo.net>
    crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

xu xin <xu.xin16@zte.com.cn>
    net/ipv4: return the real errno instead of -EINVAL

Kuniyuki Iwashima <kuniyu@amazon.com>
    net: Use sockaddr_storage for getsockopt(SO_PEERNAME).

John Watts <contact@jookia.org>
    can: sun4i_can: Add support for the Allwinner D1

John Watts <contact@jookia.org>
    can: sun4i_can: Add acceptance register quirk

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: wil6210: fix fortify warnings

Matt Whitlock <kernel@mattwhitlock.name>
    mt76: mt7921: don't assume adequate headroom for SDIO headers

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix fortify warning

Dongliang Mu <dzm91@hust.edu.cn>
    wifi: ath9k: fix printk specifier

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: fix fortify warnings

Wojciech Drewek <wojciech.drewek@intel.com>
    ice: Don't tx before switchdev is fully configured

Azeem Shaikh <azeemshaikh38@gmail.com>
    crypto: lrw,xts - Replace strlcpy with strscpy

Jiri Pirko <jiri@nvidia.com>
    devlink: remove reload failed checks in params get/set callbacks

Zhangjin Wu <falcon@tinylab.org>
    selftests/nolibc: fix up kernel parameters support

Mario Limonciello <mario.limonciello@amd.com>
    ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects

Tomislav Novak <tnovak@meta.com>
    hw_breakpoint: fix single-stepping when using bpf_overflow_handler

Xu Yang <xu.yang_2@nxp.com>
    perf/imx_ddr: speed up overflow frequency of cycle

Yicong Yang <yangyicong@hisilicon.com>
    perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470

Paul E. McKenney <paulmck@kernel.org>
    scftorture: Forgive memory-allocation failure if KASAN

Zqiang <qiang.zhang1211@gmail.com>
    rcuscale: Move rcu_scale_writer() schedule_timeout_uninterruptible() to _idle()

Wander Lairson Costa <wander@redhat.com>
    kernel/fork: beware of __put_task_struct() calling context

Abhishek Mainkar <abmainkar@nvidia.com>
    ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

Will Shiu <Will.Shiu@mediatek.com>
    locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock

Qu Wenruo <wqu@suse.com>
    btrfs: output extra debug info if we failed to find an inline backref

Fedor Pchelkin <pchelkin@ispras.ru>
    autofs: fix memory leak of waitqueues in autofs_catatonic_mode


-------------

Diffstat:

 Documentation/admin-guide/cgroup-v1/memory.rst     |   2 +
 Documentation/arm64/silicon-errata.rst             |   3 +
 Makefile                                           |   4 +-
 arch/arm/kernel/hw_breakpoint.c                    |   8 +-
 arch/arm/kernel/machine_kexec.c                    |  14 +-
 .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   |   2 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |   2 +-
 .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   |   2 +-
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |   2 +-
 arch/arm64/kernel/hw_breakpoint.c                  |   4 +-
 arch/mips/Makefile                                 |   2 +-
 arch/mips/vdso/Makefile                            |   2 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   1 +
 arch/riscv/kernel/elf_kexec.c                      |   8 +-
 arch/x86/boot/compressed/ident_map_64.c            |   8 +
 arch/x86/include/asm/boot.h                        |  45 +-
 arch/x86/include/asm/linkage.h                     |   8 +
 arch/x86/purgatory/Makefile                        |   4 +
 block/bio-integrity.c                              |   7 +-
 block/bio.c                                        |  12 +-
 crypto/lrw.c                                       |   6 +-
 crypto/xts.c                                       |   6 +-
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/arm64/iort.c                          |   5 +-
 drivers/acpi/video_detect.c                        |   9 +
 drivers/acpi/x86/s2idle.c                          |   6 +
 drivers/ata/ahci.c                                 |   9 +
 drivers/ata/libahci.c                              |  35 +-
 drivers/ata/libata-sata.c                          |  19 +-
 drivers/bus/ti-sysc.c                              |   2 +
 drivers/char/tpm/tpm_tis_core.c                    |  13 +-
 drivers/dma-buf/dma-buf.c                          |  53 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  26 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  19 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c  |   3 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |   4 +-
 .../display/dc/dml/dcn314/display_mode_vba_314.c   |   4 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |   7 +-
 drivers/gpu/drm/bridge/tc358762.c                  |   2 +-
 drivers/gpu/drm/drm_edid.c                         |   1 +
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |   5 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |   6 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |  10 +-
 drivers/i2c/busses/i2c-aspeed.c                    |   7 +-
 drivers/interconnect/core.c                        |   8 +-
 drivers/md/dm.c                                    |  23 +-
 drivers/md/md.c                                    |   2 +-
 drivers/md/raid1.c                                 |   3 +
 drivers/media/pci/cx23885/cx23885-video.c          |   2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |   2 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |   2 +
 drivers/media/tuners/qt1010.c                      |  11 +-
 drivers/media/usb/dvb-usb-v2/af9035.c              |  14 +-
 drivers/media/usb/dvb-usb-v2/anysee.c              |   2 +-
 drivers/media/usb/dvb-usb-v2/az6007.c              |   8 +
 drivers/media/usb/dvb-usb-v2/gl861.c               |   2 +-
 drivers/media/usb/dvb-usb/af9005.c                 |   5 +
 drivers/media/usb/dvb-usb/dw2102.c                 |  24 +
 drivers/misc/Kconfig                               |   1 +
 drivers/misc/fastrpc.c                             |  12 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   7 +-
 drivers/net/can/Kconfig                            |   4 +-
 drivers/net/can/sun4i_can.c                        |  22 +-
 drivers/net/ethernet/atheros/alx/ethtool.c         |   5 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c       |   3 +
 drivers/net/wireless/ath/ath9k/ahb.c               |   4 +-
 drivers/net/wireless/ath/ath9k/mac.h               |   6 +-
 drivers/net/wireless/ath/ath9k/pci.c               |   4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   4 +-
 drivers/net/wireless/ath/wil6210/txrx.c            |   2 +-
 drivers/net/wireless/ath/wil6210/txrx.h            |   6 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.c       |   2 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.h       |   6 +-
 drivers/net/wireless/mac80211_hwsim.c              |   7 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c        |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   4 +
 drivers/nvme/host/core.c                           |  54 +-
 drivers/nvme/target/io-cmd-file.c                  |  10 +-
 drivers/nvme/target/tcp.c                          |   5 +-
 drivers/pci/controller/dwc/pci-imx6.c              |   1 +
 drivers/pci/controller/dwc/pcie-fu740.c            |   1 +
 drivers/pci/controller/vmd.c                       |  19 +-
 drivers/perf/arm_smmuv3_pmu.c                      |  46 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |  21 +
 drivers/scsi/lpfc/lpfc.h                           |   1 +
 drivers/scsi/lpfc/lpfc_debugfs.c                   |  14 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  25 +-
 drivers/scsi/lpfc/lpfc_init.c                      |  20 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   8 +-
 drivers/scsi/megaraid/megaraid_sas.h               |   2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  21 +-
 drivers/scsi/pm8001/pm8001_init.c                  |  51 +-
 drivers/scsi/qla2xxx/qla_dfs.c                     |   6 +-
 drivers/target/iscsi/iscsi_target_configfs.c       |  54 +-
 drivers/target/target_core_transport.c             |   1 +
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  13 +-
 drivers/usb/cdns3/cdns3-plat.c                     |   3 +-
 drivers/usb/cdns3/cdnsp-pci.c                      |   3 +-
 drivers/usb/cdns3/core.c                           |  15 +-
 drivers/usb/cdns3/core.h                           |   7 +-
 drivers/usb/chipidea/ci.h                          |   1 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   4 +-
 drivers/usb/chipidea/core.c                        |   2 +
 drivers/usb/chipidea/host.c                        |   1 +
 drivers/usb/gadget/udc/fsl_qe_udc.c                |   2 +
 drivers/usb/host/ehci-hcd.c                        |   8 +-
 drivers/usb/host/ehci-hub.c                        |  10 +-
 drivers/usb/host/ehci.h                            |  10 +
 fs/attr.c                                          |  20 +-
 fs/autofs/waitq.c                                  |   3 +-
 fs/btrfs/delayed-inode.c                           |  19 +-
 fs/btrfs/disk-io.c                                 |  22 +-
 fs/btrfs/extent-tree.c                             |   5 +
 fs/btrfs/ioctl.c                                   |   8 +-
 fs/btrfs/ordered-data.c                            |   2 +-
 fs/btrfs/volumes.c                                 |   8 +
 fs/btrfs/volumes.h                                 |   1 +
 fs/ext2/xattr.c                                    |   4 +-
 fs/ext4/namei.c                                    |  26 +-
 fs/jfs/jfs_dmap.c                                  |   1 +
 fs/jfs/jfs_imap.c                                  |   1 +
 fs/locks.c                                         |   2 +-
 fs/nfsd/nfs4proc.c                                 |   4 +-
 fs/overlayfs/copy_up.c                             |   3 +-
 fs/overlayfs/file.c                                |   9 +-
 fs/tracefs/inode.c                                 |   3 +
 include/linux/acpi_iort.h                          |   1 +
 include/linux/bvec.h                               |  15 +
 include/linux/dma-buf.h                            |   6 +
 include/linux/instruction_pointer.h                |   5 +
 include/linux/libata.h                             |   4 +
 include/linux/perf_event.h                         |  22 +-
 include/linux/sched/task.h                         |  28 +-
 include/linux/usb/chipidea.h                       |   1 +
 include/uapi/linux/netfilter_bridge/ebtables.h     |  14 +-
 io_uring/net.c                                     |   5 +
 kernel/fork.c                                      |   8 +
 kernel/panic.c                                     |   1 +
 kernel/printk/printk.c                             |  80 ++-
 kernel/printk/printk_safe.c                        |   9 +-
 kernel/rcu/rcuscale.c                              |   2 +-
 kernel/scftorture.c                                |   6 +-
 kernel/trace/trace.c                               |  68 +-
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_events.c                        |   6 +-
 kernel/trace/trace_events_inject.c                 |   3 +-
 lib/kobject.c                                      |   5 +
 lib/mpi/mpi-cmp.c                                  |   8 +-
 mm/memcontrol.c                                    |  10 +
 net/bluetooth/hci_core.c                           |   4 +
 net/bridge/netfilter/ebtables.c                    |   3 +-
 net/core/sock.c                                    |   6 +-
 net/devlink/leftover.c                             |   4 +-
 net/ipv4/ip_output.c                               |   2 +-
 net/mac80211/cfg.c                                 |  15 +-
 net/mac80211/rx.c                                  |   4 +
 net/netlink/af_netlink.c                           |  90 +--
 net/netlink/af_netlink.h                           |  22 +-
 net/netlink/diag.c                                 |  10 +-
 net/sched/Kconfig                                  |  28 -
 net/sched/Makefile                                 |   2 -
 net/sched/cls_rsvp.c                               |  24 -
 net/sched/cls_rsvp.h                               | 764 ---------------------
 net/sched/cls_rsvp6.c                              |  24 -
 net/sunrpc/clnt.c                                  |   2 +-
 net/wireless/mlme.c                                |  13 +
 net/wireless/ocb.c                                 |   3 +
 samples/hw_breakpoint/data_breakpoint.c            |   4 +-
 security/selinux/hooks.c                           |  10 +-
 sound/hda/intel-dsp-config.c                       |   8 +
 sound/soc/intel/boards/sof_sdw.c                   |   4 +-
 sound/soc/sof/topology.c                           |   5 +-
 tools/iio/iio_generic_buffer.c                     |  17 +-
 tools/lib/bpf/libbpf.c                             |   1 +
 tools/testing/selftests/ftrace/ftracetest          |   8 +
 tools/testing/selftests/nolibc/nolibc-test.c       |  33 +-
 .../tc-testing/tc-tests/filters/rsvp.json          | 203 ------
 179 files changed, 1227 insertions(+), 1609 deletions(-)


