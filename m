Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E26A7A7EED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjITMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbjITMWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:22:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36729C2;
        Wed, 20 Sep 2023 05:21:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319D3C433C9;
        Wed, 20 Sep 2023 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212511;
        bh=vGyKiBqXXuzaVkfjta0n5cAyqNbH6vG+5Qq8LSxr0ew=;
        h=From:To:Cc:Subject:Date:From;
        b=BAwr892V6x/C9Bo4exkeRPb36UY3e+29yUqumLK7U9VPU77nP5Gj8YREXvVmCSrdQ
         6IsztXPnfTZvLUGcLQNAtpOoFQ7RBr9/tIS4HkqnmmX2bO5Ag3Njpr7QZK6FWfqq13
         1vB/aUPR+K87xA0hepKu4bMludrD24obeBp0exZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.10 00/83] 5.10.196-rc1 review
Date:   Wed, 20 Sep 2023 13:30:50 +0200
Message-ID: <20230920112826.634178162@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.196-rc1
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

This is the start of the stable review cycle for the 5.10.196 release.
There are 83 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.196-rc1

Shida Zhang <zhangshida@kylinos.cn>
    ext4: fix rec_len verify error

Damien Le Moal <dlemoal@kernel.org>
    scsi: pm8001: Setup IRQs on resume

Junxiao Bi <junxiao.bi@oracle.com>
    scsi: megaraid_sas: Fix deadlock on firmware crashdump

Niklas Cassel <niklas.cassel@wdc.com>
    ata: libata: disallow dev-initiated LPM transitions to unsupported states

Tommy Huang <tommy_huang@aspeedtech.com>
    i2c: aspeed: Reset the i2c controller when timeout occurs

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracefs: Add missing lockdown check to tracefs_create_dir()

Jeff Layton <jlayton@kernel.org>
    nfsd: fix change_info in NFSv4 RENAME replies

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have option files inc the trace array ref count

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have current_trace inc the trace array ref count

Melissa Wen <mwen@igalia.com>
    drm/amd/display: enable cursor degamma for DCN3+ DRM legacy gamma

Kent Overstreet <kent.overstreet@gmail.com>
    mm/filemap: fix infinite loop in generic_file_buffered_read()

Zhihao Cheng <chengzhihao1@huawei.com>
    proc: fix a dentry lock race between release_task and lookup

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire rsvp classifier

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix amdgpu_cs_p1_user_fence

Filipe Manana <fdmanana@suse.com>
    btrfs: release path before inode lookup during the ino lookup ioctl

Filipe Manana <fdmanana@suse.com>
    btrfs: fix lockdep splat and potential deadlock after failure running delayed items

Amir Goldstein <amir73il@gmail.com>
    ovl: fix incorrect fdput() on aio completion

Christian Brauner <brauner@kernel.org>
    attr: block mode changes of symlinks

Nigel Croxon <ncroxon@redhat.com>
    md/raid1: fix error: ISO C90 forbids mixed declarations

Arnd Bergmann <arnd@arndb.de>
    samples/hw_breakpoint: fix building without module unloading

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/boot/compressed: Reserve more memory for page tables

Jinjie Ruan <ruanjinjie@huawei.com>
    scsi: lpfc: Fix the NULL vs IS_ERR() bug for debugfs_create_file()

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    selftests: tracing: Fix to unmount tracefs for recovering environment

Jinjie Ruan <ruanjinjie@huawei.com>
    scsi: qla2xxx: Fix NULL vs IS_ERR() bug for debugfs_create_dir()

Jinjie Ruan <ruanjinjie@huawei.com>
    drm: gm12u320: Fix the timeout usage for usb_bulk_msg()

Anand Jain <anand.jain@oracle.com>
    btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super

Anand Jain <anand.jain@oracle.com>
    btrfs: add a helper to read the superblock metadata_uuid

Josef Bacik <josef@toxicpanda.com>
    btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h

Namhyung Kim <namhyung@kernel.org>
    perf build: Update build rule for generated files

Ian Rogers <rogers.email@gmail.com>
    perf jevents: Switch build to use jevents.py

Ian Rogers <irogers@google.com>
    perf tools: Add an option to build without libbfd

John Garry <john.garry@huawei.com>
    perf jevents: Make build dependency on test JSONs

William Zhang <william.zhang@broadcom.com>
    mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller

Florian Fainelli <f.fainelli@gmail.com>
    mtd: rawnand: brcmnand: Allow SoC to provide I/O operations

Rob Clark <robdclark@chromium.org>
    interconnect: Fix locking for runpm vs reclaim

Zhen Lei <thunder.leizhen@huawei.com>
    kobject: Add sanity check for kset->kobj.ktype in kset_register()

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning

Christophe Leroy <christophe.leroy@csgroup.eu>
    serial: cpm_uart: Avoid suspicious locking

Konstantin Shelekhin <k.shelekhin@yadro.com>
    scsi: target: iscsi: Fix buffer overflow in lio_target_nacl_info_show()

Ma Ke <make_ruc2021@163.com>
    usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: pci: cx23885: replace BUG with error return

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: tuners: qt1010: replace BUG_ON with a regular error

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

ruanjinjie <ruanjinjie@huawei.com>
    powerpc/pseries: fix possible memory leak in ibmebus_bus_init()

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

Tuo Li <islituo@gmail.com>
    drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: intel-dsp-cfg: add LunarLake support

Uday M Bhat <uday.m.bhat@intel.com>
    ASoC: Intel: sof_sdw: Update BT offload config for soundwire config

Rong Tao <rongtao@cestc.cn>
    samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'

Marek Vasut <marex@denx.de>
    drm/bridge: tc358762: Instruct DSI host to generate HSE packets

Hao Luo <haoluo@google.com>
    libbpf: Free btf_vmlinux when closing bpf_object

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211_hwsim: drop short frames

GONG, Ruiqi <gongruiqi1@huawei.com>
    netfilter: ebtables: fix fortify warnings in size_entry_mwt()

GONG, Ruiqi <gongruiqi1@huawei.com>
    alx: fix OOB-read compiler warning

Giulio Benetti <giulio.benetti@benettiengineering.com>
    mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450

Alexander Steffen <Alexander.Steffen@infineon.com>
    tpm_tis: Resend command to recover from data transfer errors

Mark O'Donovan <shiftee@posteo.net>
    crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: wil6210: fix fortify warnings

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: mwifiex: fix fortify warning

Dongliang Mu <dzm91@hust.edu.cn>
    wifi: ath9k: fix printk specifier

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: fix fortify warnings

Azeem Shaikh <azeemshaikh38@gmail.com>
    crypto: lrw,xts - Replace strlcpy with strscpy

Jiri Pirko <jiri@nvidia.com>
    devlink: remove reload failed checks in params get/set callbacks

Tomislav Novak <tnovak@meta.com>
    hw_breakpoint: fix single-stepping when using bpf_overflow_handler

Hans de Goede <hdegoede@redhat.com>
    ACPI: video: Add backlight=native DMI quirk for Apple iMac12,1 and iMac12,2

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

 Documentation/arm64/silicon-errata.rst            |   3 +
 Makefile                                          |   4 +-
 arch/arm/kernel/hw_breakpoint.c                   |   8 +-
 arch/arm64/kernel/hw_breakpoint.c                 |   4 +-
 arch/powerpc/platforms/pseries/ibmebus.c          |   1 +
 arch/x86/boot/compressed/ident_map_64.c           |   8 +
 arch/x86/include/asm/boot.h                       |  45 +-
 crypto/lrw.c                                      |   6 +-
 crypto/xts.c                                      |   6 +-
 drivers/acpi/acpica/psopcode.c                    |   2 +-
 drivers/acpi/arm64/iort.c                         |   5 +-
 drivers/acpi/video_detect.c                       |  27 +
 drivers/ata/ahci.c                                |   9 +
 drivers/ata/libata-sata.c                         |  19 +-
 drivers/bus/ti-sysc.c                             |   2 +
 drivers/char/tpm/tpm_tis_core.c                   |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  18 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 +
 drivers/gpu/drm/bridge/tc358762.c                 |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_crtc.c          |   5 +-
 drivers/gpu/drm/tiny/gm12u320.c                   |  10 +-
 drivers/i2c/busses/i2c-aspeed.c                   |   7 +-
 drivers/interconnect/core.c                       |   8 +-
 drivers/md/raid1.c                                |   3 +
 drivers/media/pci/cx23885/cx23885-video.c         |   2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c          |   2 +-
 drivers/media/tuners/qt1010.c                     |  11 +-
 drivers/media/usb/dvb-usb-v2/af9035.c             |  14 +-
 drivers/media/usb/dvb-usb-v2/anysee.c             |   2 +-
 drivers/media/usb/dvb-usb-v2/az6007.c             |   8 +
 drivers/media/usb/dvb-usb-v2/gl861.c              |   2 +-
 drivers/media/usb/dvb-usb/af9005.c                |   5 +
 drivers/media/usb/dvb-usb/dw2102.c                |  24 +
 drivers/mmc/host/sdhci-esdhc-imx.c                |   7 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c          | 102 ++-
 drivers/mtd/nand/raw/brcmnand/brcmnand.h          |  29 +
 drivers/net/ethernet/atheros/alx/ethtool.c        |   5 +-
 drivers/net/wireless/ath/ath9k/ahb.c              |   4 +-
 drivers/net/wireless/ath/ath9k/mac.h              |   6 +-
 drivers/net/wireless/ath/ath9k/pci.c              |   4 +-
 drivers/net/wireless/ath/ath9k/xmit.c             |   4 +-
 drivers/net/wireless/ath/wil6210/txrx.c           |   2 +-
 drivers/net/wireless/ath/wil6210/txrx.h           |   6 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.c      |   2 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.h      |   6 +-
 drivers/net/wireless/mac80211_hwsim.c             |   7 +-
 drivers/net/wireless/marvell/mwifiex/tdls.c       |   9 +-
 drivers/perf/arm_smmuv3_pmu.c                     |  46 +-
 drivers/scsi/lpfc/lpfc_debugfs.c                  |  10 +-
 drivers/scsi/megaraid/megaraid_sas.h              |   2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c         |  21 +-
 drivers/scsi/pm8001/pm8001_init.c                 |  51 +-
 drivers/scsi/qla2xxx/qla_dfs.c                    |   6 +-
 drivers/target/iscsi/iscsi_target_configfs.c      |  54 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c       |  13 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c               |   2 +
 fs/attr.c                                         |  20 +-
 fs/autofs/waitq.c                                 |   3 +-
 fs/btrfs/ctree.h                                  |   2 -
 fs/btrfs/delayed-inode.c                          |  19 +-
 fs/btrfs/disk-io.c                                |   8 +-
 fs/btrfs/extent-tree.c                            |   5 +
 fs/btrfs/ioctl.c                                  |   8 +-
 fs/btrfs/volumes.c                                |   8 +
 fs/btrfs/volumes.h                                |   3 +
 fs/ext2/xattr.c                                   |   4 +-
 fs/ext4/namei.c                                   |  26 +-
 fs/jfs/jfs_dmap.c                                 |   1 +
 fs/jfs/jfs_imap.c                                 |   1 +
 fs/locks.c                                        |   2 +-
 fs/nfsd/nfs4proc.c                                |   4 +-
 fs/overlayfs/file.c                               |   9 +-
 fs/proc/base.c                                    |  46 +-
 fs/tracefs/inode.c                                |   3 +
 include/linux/acpi_iort.h                         |   1 +
 include/linux/libata.h                            |   4 +
 include/linux/perf_event.h                        |  22 +-
 include/linux/sched/task.h                        |  28 +-
 include/uapi/linux/netfilter_bridge/ebtables.h    |  14 +-
 kernel/fork.c                                     |   8 +
 kernel/rcu/rcuscale.c                             |   2 +-
 kernel/scftorture.c                               |   6 +-
 kernel/trace/trace.c                              |  26 +-
 lib/kobject.c                                     |   5 +
 lib/mpi/mpi-cmp.c                                 |   8 +-
 mm/filemap.c                                      |   3 +
 net/bridge/netfilter/ebtables.c                   |   3 +-
 net/core/devlink.c                                |   4 +-
 net/sched/Kconfig                                 |  28 -
 net/sched/Makefile                                |   2 -
 net/sched/cls_rsvp.c                              |  24 -
 net/sched/cls_rsvp.h                              | 777 ----------------------
 net/sched/cls_rsvp6.c                             |  24 -
 samples/hw_breakpoint/data_breakpoint.c           |   4 +-
 sound/hda/intel-dsp-config.c                      |   8 +
 sound/soc/intel/boards/sof_sdw.c                  |   4 +-
 tools/build/Makefile.build                        |  10 +
 tools/lib/bpf/libbpf.c                            |   1 +
 tools/perf/Makefile.config                        |  66 +-
 tools/perf/Makefile.perf                          |   1 +
 tools/perf/pmu-events/Build                       |  22 +-
 tools/perf/pmu-events/empty-pmu-events.c          | 158 +++++
 tools/testing/selftests/ftrace/ftracetest         |   8 +
 103 files changed, 957 insertions(+), 1178 deletions(-)


