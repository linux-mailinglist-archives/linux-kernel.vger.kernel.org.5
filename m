Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130C7ABF49
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjIWJ1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjIWJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:27:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775301A6;
        Sat, 23 Sep 2023 02:27:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB533C433CA;
        Sat, 23 Sep 2023 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695461261;
        bh=+zLA7V6d9isc5D3VLtBojK7n9K/IM1i70QRs4Ny/R+I=;
        h=From:To:Cc:Subject:Date:From;
        b=mO5qw20WIo1cKnqSQDwCXQnH4wA0UdJsAQgXPtemjFBVZkBazvv1n2GGFLUTXybWI
         I+/eyKVngnaLfyI7UNbB9pHM93OxascFTKkDLZeQoYPKnG8UppjXc3S/xwHWNtlD8M
         +B5qwjcfpv6qHnjfAgD4qgy5rUrjIAMPPveXmZoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.55
Date:   Sat, 23 Sep 2023 11:27:33 +0200
Message-ID: <2023092334-botch-unwritten-4c9e@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

I'm announcing the release of the 6.1.55 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v1/memory.rst                      |    2 
 Documentation/arm64/silicon-errata.rst                              |    3 
 Makefile                                                            |    2 
 arch/arm/kernel/hw_breakpoint.c                                     |    8 
 arch/arm/kernel/machine_kexec.c                                     |   14 
 arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts        |    2 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                                |    2 
 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi             |    2 
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi                |    2 
 arch/arm64/kernel/hw_breakpoint.c                                   |    4 
 arch/mips/Makefile                                                  |    2 
 arch/mips/vdso/Makefile                                             |    2 
 arch/powerpc/platforms/pseries/ibmebus.c                            |    1 
 arch/riscv/kernel/elf_kexec.c                                       |    8 
 arch/x86/boot/compressed/ident_map_64.c                             |    8 
 arch/x86/include/asm/boot.h                                         |   45 
 arch/x86/include/asm/linkage.h                                      |    8 
 arch/x86/purgatory/Makefile                                         |    4 
 block/bio-integrity.c                                               |    7 
 block/bio.c                                                         |   12 
 crypto/lrw.c                                                        |    6 
 crypto/xts.c                                                        |    6 
 drivers/acpi/acpica/psopcode.c                                      |    2 
 drivers/acpi/arm64/iort.c                                           |    5 
 drivers/acpi/video_detect.c                                         |    9 
 drivers/acpi/x86/s2idle.c                                           |    6 
 drivers/ata/ahci.c                                                  |    9 
 drivers/ata/libahci.c                                               |   35 
 drivers/ata/libata-sata.c                                           |   19 
 drivers/bus/ti-sysc.c                                               |    2 
 drivers/char/tpm/tpm_tis_core.c                                     |   13 
 drivers/dma-buf/dma-buf.c                                           |   53 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                 |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                              |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |   26 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |   19 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c                   |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c      |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    |    4 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c |    7 
 drivers/gpu/drm/bridge/tc358762.c                                   |    2 
 drivers/gpu/drm/drm_edid.c                                          |    1 
 drivers/gpu/drm/exynos/exynos_drm_crtc.c                            |    5 
 drivers/gpu/drm/mediatek/mtk_dp.c                                   |    6 
 drivers/gpu/drm/tiny/gm12u320.c                                     |   10 
 drivers/i2c/busses/i2c-aspeed.c                                     |    7 
 drivers/interconnect/core.c                                         |   18 
 drivers/md/dm.c                                                     |   23 
 drivers/md/md.c                                                     |    2 
 drivers/md/raid1.c                                                  |    3 
 drivers/media/pci/cx23885/cx23885-video.c                           |    2 
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c                       |    2 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c                |    2 
 drivers/media/tuners/qt1010.c                                       |   11 
 drivers/media/usb/dvb-usb-v2/af9035.c                               |   14 
 drivers/media/usb/dvb-usb-v2/anysee.c                               |    2 
 drivers/media/usb/dvb-usb-v2/az6007.c                               |    8 
 drivers/media/usb/dvb-usb-v2/gl861.c                                |    2 
 drivers/media/usb/dvb-usb/af9005.c                                  |    5 
 drivers/media/usb/dvb-usb/dw2102.c                                  |   24 
 drivers/misc/Kconfig                                                |    1 
 drivers/misc/fastrpc.c                                              |   12 
 drivers/mmc/host/sdhci-esdhc-imx.c                                  |    7 
 drivers/net/can/Kconfig                                             |    4 
 drivers/net/can/sun4i_can.c                                         |   22 
 drivers/net/ethernet/atheros/alx/ethtool.c                          |    5 
 drivers/net/ethernet/intel/ice/ice_eswitch.c                        |    3 
 drivers/net/wireless/ath/ath9k/ahb.c                                |    4 
 drivers/net/wireless/ath/ath9k/mac.h                                |    6 
 drivers/net/wireless/ath/ath9k/pci.c                                |    4 
 drivers/net/wireless/ath/ath9k/xmit.c                               |    4 
 drivers/net/wireless/ath/wil6210/txrx.c                             |    2 
 drivers/net/wireless/ath/wil6210/txrx.h                             |    6 
 drivers/net/wireless/ath/wil6210/txrx_edma.c                        |    2 
 drivers/net/wireless/ath/wil6210/txrx_edma.h                        |    6 
 drivers/net/wireless/mac80211_hwsim.c                               |    7 
 drivers/net/wireless/marvell/mwifiex/tdls.c                         |    9 
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c                     |    4 
 drivers/nvme/host/core.c                                            |   54 
 drivers/nvme/target/io-cmd-file.c                                   |   10 
 drivers/nvme/target/tcp.c                                           |    5 
 drivers/pci/controller/dwc/pci-imx6.c                               |    1 
 drivers/pci/controller/dwc/pcie-fu740.c                             |    1 
 drivers/pci/controller/vmd.c                                        |   19 
 drivers/perf/arm_smmuv3_pmu.c                                       |   46 
 drivers/perf/fsl_imx8_ddr_perf.c                                    |   21 
 drivers/scsi/lpfc/lpfc.h                                            |    1 
 drivers/scsi/lpfc/lpfc_debugfs.c                                    |   14 
 drivers/scsi/lpfc/lpfc_els.c                                        |   25 
 drivers/scsi/lpfc/lpfc_init.c                                       |   20 
 drivers/scsi/lpfc/lpfc_sli.c                                        |    8 
 drivers/scsi/megaraid/megaraid_sas.h                                |    2 
 drivers/scsi/megaraid/megaraid_sas_base.c                           |   21 
 drivers/scsi/pm8001/pm8001_init.c                                   |   51 
 drivers/scsi/qla2xxx/qla_dfs.c                                      |    6 
 drivers/target/iscsi/iscsi_target_configfs.c                        |   54 
 drivers/target/target_core_transport.c                              |    1 
 drivers/tty/serial/cpm_uart/cpm_uart_core.c                         |   13 
 drivers/usb/cdns3/cdns3-plat.c                                      |    3 
 drivers/usb/cdns3/cdnsp-pci.c                                       |    3 
 drivers/usb/cdns3/core.c                                            |   15 
 drivers/usb/cdns3/core.h                                            |    7 
 drivers/usb/chipidea/ci.h                                           |    1 
 drivers/usb/chipidea/ci_hdrc_imx.c                                  |    4 
 drivers/usb/chipidea/core.c                                         |    2 
 drivers/usb/chipidea/host.c                                         |    1 
 drivers/usb/gadget/udc/fsl_qe_udc.c                                 |    6 
 drivers/usb/host/ehci-hcd.c                                         |    8 
 drivers/usb/host/ehci-hub.c                                         |   10 
 drivers/usb/host/ehci.h                                             |   10 
 fs/attr.c                                                           |   20 
 fs/autofs/waitq.c                                                   |    3 
 fs/btrfs/delayed-inode.c                                            |   19 
 fs/btrfs/disk-io.c                                                  |   22 
 fs/btrfs/extent-tree.c                                              |    5 
 fs/btrfs/ioctl.c                                                    |    8 
 fs/btrfs/ordered-data.c                                             |    2 
 fs/btrfs/volumes.c                                                  |    8 
 fs/btrfs/volumes.h                                                  |    1 
 fs/ext2/xattr.c                                                     |    4 
 fs/ext4/namei.c                                                     |   26 
 fs/jfs/jfs_dmap.c                                                   |    1 
 fs/jfs/jfs_imap.c                                                   |    1 
 fs/locks.c                                                          |    2 
 fs/nfsd/nfs4proc.c                                                  |    4 
 fs/overlayfs/copy_up.c                                              |    3 
 fs/overlayfs/file.c                                                 |    9 
 fs/tracefs/inode.c                                                  |    3 
 include/linux/acpi_iort.h                                           |    1 
 include/linux/bvec.h                                                |   15 
 include/linux/dma-buf.h                                             |    6 
 include/linux/instruction_pointer.h                                 |    5 
 include/linux/libata.h                                              |    4 
 include/linux/perf_event.h                                          |   22 
 include/linux/sched/task.h                                          |   28 
 include/linux/usb/chipidea.h                                        |    1 
 include/uapi/linux/netfilter_bridge/ebtables.h                      |   14 
 io_uring/net.c                                                      |    5 
 kernel/fork.c                                                       |    8 
 kernel/panic.c                                                      |    1 
 kernel/printk/printk.c                                              |   80 -
 kernel/printk/printk_safe.c                                         |    9 
 kernel/rcu/rcuscale.c                                               |    2 
 kernel/scftorture.c                                                 |    6 
 kernel/trace/trace.c                                                |   68 
 kernel/trace/trace.h                                                |    2 
 kernel/trace/trace_events.c                                         |    6 
 kernel/trace/trace_events_inject.c                                  |    3 
 lib/kobject.c                                                       |    5 
 lib/mpi/mpi-cmp.c                                                   |    8 
 mm/memcontrol.c                                                     |   10 
 net/bluetooth/hci_core.c                                            |    4 
 net/bridge/netfilter/ebtables.c                                     |    3 
 net/core/sock.c                                                     |    6 
 net/devlink/leftover.c                                              |    4 
 net/ipv4/ip_output.c                                                |    2 
 net/mac80211/cfg.c                                                  |   15 
 net/mac80211/rx.c                                                   |    4 
 net/netlink/af_netlink.c                                            |   90 -
 net/netlink/af_netlink.h                                            |   22 
 net/netlink/diag.c                                                  |   10 
 net/sched/Kconfig                                                   |   28 
 net/sched/Makefile                                                  |    2 
 net/sched/cls_rsvp.c                                                |   24 
 net/sched/cls_rsvp.h                                                |  764 ----------
 net/sched/cls_rsvp6.c                                               |   24 
 net/sunrpc/clnt.c                                                   |    2 
 net/wireless/mlme.c                                                 |   13 
 net/wireless/ocb.c                                                  |    3 
 samples/hw_breakpoint/data_breakpoint.c                             |    4 
 security/selinux/hooks.c                                            |   10 
 sound/hda/intel-dsp-config.c                                        |    8 
 sound/soc/intel/boards/sof_sdw.c                                    |    4 
 sound/soc/sof/topology.c                                            |    5 
 tools/iio/iio_generic_buffer.c                                      |   17 
 tools/lib/bpf/libbpf.c                                              |    1 
 tools/testing/selftests/ftrace/ftracetest                           |    8 
 tools/testing/selftests/nolibc/nolibc-test.c                        |   33 
 tools/testing/selftests/tc-testing/tc-tests/filters/rsvp.json       |  203 --
 179 files changed, 1238 insertions(+), 1610 deletions(-)

Abhishek Mainkar (1):
      ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

Alexander Steffen (1):
      tpm_tis: Resend command to recover from data transfer errors

Amir Goldstein (2):
      ovl: fix failed copyup of fileattr on a symlink
      ovl: fix incorrect fdput() on aio completion

Anand Jain (2):
      btrfs: add a helper to read the superblock metadata_uuid
      btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super

Andrew Kanner (1):
      fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()

AngeloGioacchino Del Regno (1):
      drm/mediatek: dp: Change logging to dev for mtk_dp_aux_transfer()

Arnd Bergmann (1):
      samples/hw_breakpoint: fix building without module unloading

Austin Zheng (1):
      drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK

Azeem Shaikh (1):
      crypto: lrw,xts - Replace strlcpy with strscpy

Baoquan He (1):
      misc: open-dice: make OPEN_DICE depend on HAS_IOMEM

Chenyuan Mi (1):
      tools: iio: iio_generic_buffer: Fix some integer type and calculation

Christian Brauner (1):
      attr: block mode changes of symlinks

Christian König (1):
      drm/amdgpu: fix amdgpu_cs_p1_user_fence

Christoph Hellwig (2):
      block: factor out a bvec_set_page helper
      nvmet: use bvec_set_page to initialize bvecs

Christophe Leroy (1):
      serial: cpm_uart: Avoid suspicious locking

Damien Le Moal (1):
      scsi: pm8001: Setup IRQs on resume

David Disseldorp (1):
      scsi: target: core: Fix target_cmd_counter leak

Dmitry Antipov (3):
      wifi: ath9k: fix fortify warnings
      wifi: mwifiex: fix fortify warning
      wifi: wil6210: fix fortify warnings

Dmitry Osipenko (2):
      dma-buf: Add unlocked variant of attachment-mapping functions
      misc: fastrpc: Prepare to dynamic dma-buf locking specification

Dongliang Mu (1):
      wifi: ath9k: fix printk specifier

Ekansh Gupta (1):
      misc: fastrpc: Fix incorrect DMA mapping unmap request

Eric Dumazet (1):
      netlink: convert nlk->flags to atomic flags

Fedor Pchelkin (1):
      autofs: fix memory leak of waitqueues in autofs_catatonic_mode

Filipe Manana (2):
      btrfs: fix lockdep splat and potential deadlock after failure running delayed items
      btrfs: release path before inode lookup during the ino lookup ioctl

GONG, Ruiqi (2):
      alx: fix OOB-read compiler warning
      netfilter: ebtables: fix fortify warnings in size_entry_mwt()

Georg Ottinger (1):
      ext2: fix datatype of block number in ext2_xattr_set2()

Giulio Benetti (1):
      mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450

Greg Kroah-Hartman (2):
      Revert "memcg: drop kmem.limit_in_bytes"
      Linux 6.1.55

Hamza Mahfooz (1):
      Revert "drm/amd: Disable S/G for APUs when 64GB or more host memory"

Hans Verkuil (2):
      media: tuners: qt1010: replace BUG_ON with a regular error
      media: pci: cx23885: replace BUG with error return

Hao Luo (1):
      libbpf: Free btf_vmlinux when closing bpf_object

Jamal Hadi Salim (1):
      net/sched: Retire rsvp classifier

Jeff Layton (1):
      nfsd: fix change_info in NFSv4 RENAME replies

Jens Axboe (1):
      dm: don't attempt to queue IO under RCU protection

Jinjie Ruan (3):
      drm: gm12u320: Fix the timeout usage for usb_bulk_msg()
      scsi: qla2xxx: Fix NULL vs IS_ERR() bug for debugfs_create_dir()
      scsi: lpfc: Fix the NULL vs IS_ERR() bug for debugfs_create_file()

Jiri Pirko (1):
      devlink: remove reload failed checks in params get/set callbacks

Jiri Slaby (SUSE) (1):
      ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470

Johannes Berg (5):
      wifi: mac80211: check S1G action frame size
      wifi: cfg80211: reject auth/assoc to AP with our address
      wifi: cfg80211: ocb: don't leave if not joined
      wifi: mac80211: check for station first in client probe
      wifi: mac80211_hwsim: drop short frames

John Ogness (2):
      printk: Keep non-panic-CPUs out of console lock
      printk: Consolidate console deferred printing

John Watts (2):
      can: sun4i_can: Add acceptance register quirk
      can: sun4i_can: Add support for the Allwinner D1

Josef Bacik (1):
      btrfs: check for BTRFS_FS_ERROR in pending ordered assert

Junxiao Bi (1):
      scsi: megaraid_sas: Fix deadlock on firmware crashdump

Justin Tee (1):
      scsi: lpfc: Abort outstanding ELS cmds when mailbox timeout error is detected

Keith Busch (1):
      nvme: avoid bogus CRTO values

Kirill A. Shutemov (1):
      x86/boot/compressed: Reserve more memory for page tables

Konstantin Shelekhin (1):
      scsi: target: iscsi: Fix buffer overflow in lio_target_nacl_info_show()

Krzysztof Kozlowski (4):
      arm64: dts: qcom: sm6125-pdx201: correct ramoops pmsg-size
      arm64: dts: qcom: sm6350: correct ramoops pmsg-size
      arm64: dts: qcom: sm8150-kumano: correct ramoops pmsg-size
      arm64: dts: qcom: sm8250-edo: correct ramoops pmsg-size

Kuniyuki Iwashima (1):
      net: Use sockaddr_storage for getsockopt(SO_PEERNAME).

Leo Chen (2):
      drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31
      drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN314

Leo Ma (1):
      drm/amd/display: Fix underflow issue on 175hz timing

Liu Shixin via Jfs-discussion (1):
      jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount

Lu Hongfei (1):
      media: mdp3: Fix resource leaks in of_find_device_by_node

Lukas Wunner (1):
      panic: Reenable preemption in WARN slowpath

Ma Ke (1):
      usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc

Marek Vasut (1):
      drm/bridge: tc358762: Instruct DSI host to generate HSE packets

Mario Limonciello (1):
      ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects

Mariusz Tkaczyk (1):
      md: Put the right device in md_seq_next

Mark Brown (1):
      PCI: dwc: Provide deinit callback for i.MX

Mark O'Donovan (1):
      crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

Masami Hiramatsu (Google) (1):
      selftests: tracing: Fix to unmount tracefs for recovering environment

Matt Whitlock (1):
      mt76: mt7921: don't assume adequate headroom for SDIO headers

Mårten Lindahl (1):
      ARM: 9317/1: kexec: Make smp stop calls asynchronous

Nigel Croxon (1):
      md/raid1: fix error: ISO C90 forbids mixed declarations

Niklas Cassel (1):
      ata: libata: disallow dev-initiated LPM transitions to unsupported states

Nirmal Patel (1):
      PCI: vmd: Disable bridge window for domain reset

Ondrej Mosnacek (1):
      selinux: fix handling of empty opts in selinux_fs_context_submount()

Paul E. McKenney (1):
      scftorture: Forgive memory-allocation failure if KASAN

Pavel Begunkov (1):
      io_uring/net: fix iter retargeting for selected buf

Peter Zijlstra (1):
      x86/ibt: Suppress spurious ENDBR

Pierre-Louis Bossart (2):
      ASoC: SOF: topology: simplify code to prevent static analysis warnings
      ALSA: hda: intel-dsp-cfg: add LunarLake support

Qu Wenruo (2):
      btrfs: output extra debug info if we failed to find an inline backref
      btrfs: fix a compilation error if DEBUG is defined in btree_dirty_folio

Ralph Campbell (1):
      drm/edid: Add quirk for OSVR HDK 2.0

Rob Clark (2):
      interconnect: Fix locking for runpm vs reclaim
      interconnect: Teach lockdep about icc_bw_lock order

Rong Tao (1):
      samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'

Sakari Ailus (1):
      media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning

Shida Zhang (1):
      ext4: fix rec_len verify error

Song Liu (1):
      x86/purgatory: Remove LTO flags

Song Shuai (1):
      riscv: kexec: Align the kexeced kernel entry

Steven Rostedt (Google) (6):
      tracing: Have tracing_max_latency inc the trace array ref count
      tracing: Have event inject files inc the trace array ref count
      tracing: Increase trace array ref count on enable and filter files
      tracing: Have current_trace inc the trace array ref count
      tracing: Have option files inc the trace array ref count
      tracefs: Add missing lockdown check to tracefs_create_dir()

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

Tiezhu Yang (1):
      MIPS: Use "grep -E" instead of "egrep"

Tomislav Novak (1):
      hw_breakpoint: fix single-stepping when using bpf_overflow_handler

Tommy Huang (1):
      i2c: aspeed: Reset the i2c controller when timeout occurs

Tony Lindgren (1):
      bus: ti-sysc: Configure uart quirks for k3 SoC

Trond Myklebust (1):
      Revert "SUNRPC: Fail faster on bad verifier"

Tuo Li (1):
      drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()

Uday M Bhat (1):
      ASoC: Intel: sof_sdw: Update BT offload config for soundwire config

Varun Prakash (1):
      nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()

Wander Lairson Costa (1):
      kernel/fork: beware of __put_task_struct() calling context

Will Shiu (1):
      locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock

Wojciech Drewek (1):
      ice: Don't tx before switchdev is fully configured

Xiaolei Wang (1):
      usb: cdns3: Put the cdns set active part outside the spin lock

Xu Yang (3):
      perf/imx_ddr: speed up overflow frequency of cycle
      usb: ehci: add workaround for chipidea PORTSC.PEC bug
      usb: chipidea: add workaround for chipidea PEC bug

Yicong Yang (1):
      perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09

Yifan Zhang (1):
      drm/amd/display: fix the white screen issue when >= 64GB DRAM

Ying Hsu (1):
      Bluetooth: Fix hci_suspend_sync crash

Yong-Xuan Wang (1):
      PCI: fu740: Set the number of MSI vectors

Zhang Shurong (7):
      md: raid1: fix potential OOB in raid1_remove_disk()
      media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer
      media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()
      media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
      media: anysee: fix null-ptr-deref in anysee_master_xfer
      media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()
      media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer

Zhangjin Wu (1):
      selftests/nolibc: fix up kernel parameters support

Zhen Lei (1):
      kobject: Add sanity check for kset->kobj.ktype in kset_register()

Zqiang (1):
      rcuscale: Move rcu_scale_writer() schedule_timeout_uninterruptible() to _idle()

ruanjinjie (1):
      powerpc/pseries: fix possible memory leak in ibmebus_bus_init()

xu xin (1):
      net/ipv4: return the real errno instead of -EINVAL

