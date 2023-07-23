Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480C75E1D3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGWM2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGWM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFEB9;
        Sun, 23 Jul 2023 05:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0ED560CA3;
        Sun, 23 Jul 2023 12:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F64C433C8;
        Sun, 23 Jul 2023 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690115310;
        bh=db9fTToI2ZIb+rns/Ie1AcFvVFav6et9SMsh8lZHeJI=;
        h=From:To:Cc:Subject:Date:From;
        b=q042edPO3QcK3vn9cOq5q0U8pcYS2eun2+vHco69v6nYL7K6QRzAM2Xg/QhvBgRoK
         h9OmHFUYcnwP/0fcWjU4fbu6G9DVfpFiBnpnqbZ+xCT37v3yd2Y9FtqFIiprGafcmj
         oNScaDVIMEk3jfIyRkybLJHgXdjz2+B3ijnujTDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.40
Date:   Sun, 23 Jul 2023 14:28:25 +0200
Message-ID: <2023072326-outfield-throat-a778@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.40 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/device-mapper/dm-init.rst         |    8 
 Makefile                                                    |    2 
 arch/mips/include/asm/kvm_host.h                            |    6 
 arch/mips/kernel/cpu-probe.c                                |    9 
 arch/mips/kvm/emulate.c                                     |   22 -
 arch/mips/kvm/mips.c                                        |   16 
 arch/mips/kvm/stats.c                                       |    4 
 arch/mips/kvm/trace.h                                       |    8 
 arch/mips/kvm/vz.c                                          |   20 
 arch/powerpc/Makefile                                       |    8 
 arch/powerpc/kernel/security.c                              |   37 -
 arch/powerpc/mm/book3s64/hash_native.c                      |   13 
 arch/riscv/mm/init.c                                        |    2 
 arch/riscv/net/bpf_jit.h                                    |    6 
 arch/riscv/net/bpf_jit_core.c                               |   19 
 arch/s390/Makefile                                          |    1 
 arch/x86/events/intel/core.c                                |    7 
 arch/xtensa/platforms/iss/network.c                         |    2 
 block/blk-crypto-profile.c                                  |   12 
 drivers/base/regmap/regmap-irq.c                            |    2 
 drivers/bus/intel-ixp4xx-eb.c                               |    2 
 drivers/char/hw_random/imx-rngc.c                           |    6 
 drivers/char/tpm/tpm-chip.c                                 |    7 
 drivers/char/tpm/tpm_crb.c                                  |   19 
 drivers/char/tpm/tpm_tis_i2c.c                              |   59 +-
 drivers/char/tpm/tpm_vtpm_proxy.c                           |   30 -
 drivers/firmware/stratix10-svc.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                      |   12 
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c                      |   11 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                      |    4 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c   |   26 +
 drivers/gpu/drm/amd/display/dc/core/dc.c                    |    3 
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c     |   10 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c          |   11 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c          |    4 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c           |    2 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.h           |    1 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                 |    2 
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h               |    1 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h                |    4 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c              |   98 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c        |   34 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c        |   34 -
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                       |   35 +
 drivers/gpu/drm/drm_atomic.c                                |   11 
 drivers/gpu/drm/drm_atomic_helper.c                         |   11 
 drivers/gpu/drm/drm_client.c                                |   21 
 drivers/gpu/drm/drm_fb_helper.c                             |    4 
 drivers/gpu/drm/i915/display/intel_display.c                |    1 
 drivers/gpu/drm/i915/gt/intel_gtt.c                         |    2 
 drivers/gpu/drm/panel/panel-simple.c                        |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                 |    8 
 drivers/gpu/drm/ttm/ttm_bo.c                                |    1 
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c               |   30 +
 drivers/iio/adc/meson_saradc.c                              |    2 
 drivers/md/dm-init.c                                        |   22 -
 drivers/md/dm-integrity.c                                   |    4 
 drivers/md/dm-verity-loadpin.c                              |    3 
 drivers/md/raid0.c                                          |   62 ++
 drivers/md/raid0.h                                          |    1 
 drivers/mfd/qcom-pm8008.c                                   |    1 
 drivers/misc/fastrpc.c                                      |    2 
 drivers/misc/pci_endpoint_test.c                            |   10 
 drivers/mtd/nand/raw/meson_nand.c                           |    4 
 drivers/net/dsa/qca/qca8k-8xxx.c                            |    3 
 drivers/net/ethernet/amazon/ena/ena_com.c                   |    3 
 drivers/net/ethernet/broadcom/bgmac.c                       |    4 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                |    2 
 drivers/net/ethernet/google/gve/gve_ethtool.c               |    3 
 drivers/net/ethernet/intel/ice/ice_main.c                   |   16 
 drivers/net/ethernet/intel/igc/igc_ethtool.c                |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                   |    5 
 drivers/net/ethernet/intel/igc/igc_ptp.c                    |   25 +
 drivers/net/ethernet/marvell/mvneta.c                       |    4 
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c             |   19 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c             |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c         |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c    |   23 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c     |    8 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c        |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c            |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c   |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c             |    6 
 drivers/net/ethernet/microchip/lan743x_main.c               |   21 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c             |    5 
 drivers/net/netdevsim/dev.c                                 |    9 
 drivers/net/phy/dp83td510.c                                 |   23 -
 drivers/net/wireless/cisco/airo.c                           |    5 
 drivers/net/wireless/realtek/rtw89/debug.c                  |    5 
 drivers/ntb/hw/amd/ntb_hw_amd.c                             |    7 
 drivers/ntb/hw/idt/ntb_hw_idt.c                             |    7 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                          |    7 
 drivers/ntb/ntb_transport.c                                 |    2 
 drivers/ntb/test/ntb_tool.c                                 |    2 
 drivers/nvme/host/core.c                                    |   36 +
 drivers/nvme/host/pci.c                                     |    2 
 drivers/opp/core.c                                          |    3 
 drivers/pci/controller/dwc/pcie-qcom.c                      |    2 
 drivers/pci/controller/pcie-rockchip-ep.c                   |   65 +--
 drivers/pci/controller/pcie-rockchip.c                      |   17 
 drivers/pci/controller/pcie-rockchip.h                      |   11 
 drivers/pci/endpoint/functions/pci-epf-test.c               |   40 +
 drivers/pci/pci.c                                           |   10 
 drivers/pci/probe.c                                         |    4 
 drivers/pci/quirks.c                                        |    2 
 drivers/perf/riscv_pmu.c                                    |    3 
 drivers/pinctrl/pinctrl-amd.c                               |  190 +++-----
 drivers/pinctrl/pinctrl-amd.h                               |    3 
 drivers/platform/x86/wmi.c                                  |   22 -
 drivers/pwm/pwm-meson.c                                     |   28 -
 drivers/s390/crypto/zcrypt_msgtype6.c                       |    6 
 drivers/scsi/lpfc/lpfc_crtn.h                               |    1 
 drivers/scsi/lpfc/lpfc_els.c                                |   30 -
 drivers/scsi/lpfc/lpfc_hbadisc.c                            |   24 -
 drivers/scsi/mpi3mr/mpi3mr_fw.c                             |    5 
 drivers/scsi/qla2xxx/qla_attr.c                             |   13 
 drivers/scsi/qla2xxx/qla_bsg.c                              |    6 
 drivers/scsi/qla2xxx/qla_def.h                              |   22 -
 drivers/scsi/qla2xxx/qla_edif.c                             |    4 
 drivers/scsi/qla2xxx/qla_gbl.h                              |    2 
 drivers/scsi/qla2xxx/qla_init.c                             |  258 +++++++++++-
 drivers/scsi/qla2xxx/qla_inline.h                           |    5 
 drivers/scsi/qla2xxx/qla_iocb.c                             |   38 +
 drivers/scsi/qla2xxx/qla_isr.c                              |   64 ++
 drivers/scsi/qla2xxx/qla_nvme.c                             |    3 
 drivers/scsi/qla2xxx/qla_os.c                               |  133 +++---
 drivers/soc/qcom/mdt_loader.c                               |   16 
 drivers/soundwire/qcom.c                                    |    3 
 drivers/tty/serial/8250/8250.h                              |    1 
 drivers/tty/serial/8250/8250_pci.c                          |   19 
 drivers/tty/serial/8250/8250_port.c                         |   11 
 drivers/tty/serial/atmel_serial.c                           |    4 
 drivers/tty/serial/imx.c                                    |   18 
 drivers/tty/serial/samsung_tty.c                            |   14 
 drivers/ufs/host/Kconfig                                    |    1 
 drivers/usb/host/xhci-mem.c                                 |   39 +
 drivers/usb/host/xhci-pci.c                                 |   12 
 drivers/usb/host/xhci.h                                     |    2 
 fs/ceph/addr.c                                              |   85 +++
 fs/ceph/caps.c                                              |    9 
 fs/ceph/super.h                                             |   13 
 fs/dlm/lockspace.c                                          |   12 
 fs/dlm/lockspace.h                                          |    1 
 fs/dlm/midcomms.c                                           |    3 
 fs/dlm/plock.c                                              |  115 +++--
 fs/erofs/inode.c                                            |    3 
 fs/erofs/zdata.c                                            |    4 
 fs/ext2/inode.c                                             |    5 
 fs/ext4/indirect.c                                          |    8 
 fs/ext4/inode.c                                             |   10 
 fs/ext4/ioctl.c                                             |    5 
 fs/ext4/mballoc.c                                           |   17 
 fs/ext4/super.c                                             |   19 
 fs/f2fs/compress.c                                          |    2 
 fs/f2fs/dir.c                                               |    9 
 fs/f2fs/xattr.c                                             |    6 
 fs/jfs/jfs_dmap.c                                           |    6 
 fs/jfs/jfs_filsys.h                                         |    2 
 fs/ntfs3/index.c                                            |   84 +++
 fs/ntfs3/inode.c                                            |   18 
 fs/ntfs3/ntfs_fs.h                                          |    4 
 fs/ntfs3/run.c                                              |    7 
 fs/ntfs3/xattr.c                                            |  109 +++--
 fs/overlayfs/inode.c                                        |   12 
 fs/overlayfs/overlayfs.h                                    |    2 
 fs/overlayfs/util.c                                         |    7 
 fs/smb/client/file.c                                        |    4 
 fs/smb/client/smb2transport.c                               |    7 
 fs/smb/server/smb2pdu.c                                     |  109 +++--
 include/linux/blk-crypto-profile.h                          |    1 
 include/linux/nvme.h                                        |    2 
 include/linux/rethook.h                                     |    1 
 include/linux/serial_8250.h                                 |    1 
 include/linux/workqueue.h                                   |   15 
 include/net/pkt_sched.h                                     |    2 
 kernel/bpf/cpumap.c                                         |   40 +
 kernel/bpf/verifier.c                                       |    5 
 kernel/dma/swiotlb.c                                        |  110 +++--
 kernel/power/qos.c                                          |    9 
 kernel/trace/fprobe.c                                       |   11 
 kernel/trace/ftrace.c                                       |   45 +-
 kernel/trace/rethook.c                                      |   13 
 kernel/trace/ring_buffer.c                                  |   24 -
 kernel/trace/trace.c                                        |    3 
 kernel/trace/trace_eprobe.c                                 |   18 
 kernel/trace/trace_events_hist.c                            |    8 
 kernel/trace/trace_events_user.c                            |    6 
 kernel/trace/trace_probe_tmpl.h                             |   14 
 kernel/workqueue.c                                          |   13 
 mm/kasan/kasan.h                                            |    3 
 net/ceph/messenger_v2.c                                     |   41 +
 net/core/skbuff.c                                           |    5 
 net/ipv6/addrconf.c                                         |    3 
 net/ipv6/icmp.c                                             |    5 
 net/ipv6/udp.c                                              |    2 
 net/ncsi/ncsi-rsp.c                                         |   93 +---
 net/sched/cls_flower.c                                      |   10 
 net/sched/cls_fw.c                                          |   10 
 net/sched/sch_qfq.c                                         |   41 +
 samples/ftrace/ftrace-direct-too.c                          |   14 
 tools/testing/selftests/net/mptcp/config                    |    1 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh          |    3 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh          |    9 
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c               |   10 
 tools/testing/selftests/net/mptcp/userspace_pm.sh           |    4 
 208 files changed, 2335 insertions(+), 1240 deletions(-)

Alex Deucher (1):
      drm/amdgpu/sdma4: set align mask to 255

Alexander Aring (6):
      fs: dlm: revert check required context while close
      fs: dlm: return positive pid value for F_GETLK
      fs: dlm: fix cleanup pending ops when interrupted
      fs: dlm: interrupt posix locks only when process is killed
      fs: dlm: make F_SETLK use unkillable wait_event
      fs: dlm: fix mismatch of plock results from userspace

Alexander Sverdlin (2):
      tpm: tis_i2c: Limit read bursts to I2C_SMBUS_BLOCK_MAX (32) bytes
      tpm: tis_i2c: Limit write bursts to I2C_SMBUS_BLOCK_MAX (32) bytes

Alexey Kardashevskiy (1):
      swiotlb: reduce the swiotlb buffer size on allocation failure

Andy Shevchenko (1):
      platform/x86: wmi: Break possible infinite loop when parsing GUID

Ankit Kumar (1):
      nvme: fix the NVME_ID_NS_NVM_STS_MASK definition

Aravindhan Gunasekaran (1):
      igc: Handle PPS start time programming for past time values

Arnd Bergmann (1):
      kasan: add kasan_tag_mismatch prototype

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix unaligned DMA buffers handling

Aurabindo Pillai (1):
      drm/amd/display: Add monitor specific edid quirk

Austin Zheng (1):
      drm/amd/display: Remove Phantom Pipe Check When Calculating K1 and K2

Baokun Li (2):
      ext4: turn quotas off if mount failed after enabling quotas
      ext4: only update i_reserved_data_blocks on successful block allocation

Basavaraj Natikar (3):
      HID: amd_sfh: Rename the float32 variable
      HID: amd_sfh: Fix for shift-out-of-bounds
      pinctrl: amd: Add Z-state wake control bits

Beau Belgrave (1):
      tracing/user_events: Fix struct arg size match check

Bharath SM (1):
      cifs: if deferred close is disabled then close files immediately

Bikash Hazarika (2):
      scsi: qla2xxx: Fix potential NULL pointer dereference
      scsi: qla2xxx: Correct the index of array

Björn Töpel (1):
      riscv, bpf: Fix inconsistent JIT image generation

Brian Norris (2):
      drm/atomic: Allow vblank-enabled + self-refresh "disable"
      drm/rockchip: vop: Leave vblank enabled in self-refresh

Chao Yu (1):
      ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Christian Marangi (1):
      soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup

Christoph Hellwig (1):
      nvme: don't reject probe due to duplicate IDs for single-ported PCIe devices

Christophe JAILLET (3):
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
      firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()

Chungkai Yang (1):
      PM: QoS: Restore support for default value on frequency QoS

Chunhai Guo (2):
      erofs: avoid useless loops in z_erofs_pcluster_readmore() when reading beyond EOF
      erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Damien Le Moal (5):
      PCI: epf-test: Fix DMA transfer completion initialization
      PCI: epf-test: Fix DMA transfer completion detection
      PCI: rockchip: Set address alignment for endpoint mode
      misc: pci_endpoint_test: Free IRQs before removing the device
      misc: pci_endpoint_test: Re-init completion for every test

Dan Carpenter (4):
      scsi: qla2xxx: Fix error code in qla2x00_start_sp()
      netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()
      serial: atmel: don't enable IRQs prematurely
      scsi: qla2xxx: Fix end of loop test

Daniel Vetter (1):
      drm/atomic: Fix potential use-after-free in nonblocking commits

Dmytro Laktyushkin (1):
      drm/amd/display: fix seamless odm transitions

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime

Ekansh Gupta (1):
      misc: fastrpc: Create fastrpc scalar with correct buffer count

Eric Biggers (1):
      blk-crypto: use dynamic lock class for blk_crypto_profile::lock

Eric Dumazet (1):
      udp6: fix udp6_ehashfn() typo

Eric Lin (1):
      perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_start()

Evan Quan (2):
      drm/amd/pm: revise the ASPM settings for thunderbolt attached scenario
      drm/amd/pm: share the code around SMU13 pcie parameters update

Fabio Estevam (1):
      drm/panel: simple: Add connector_type for innolux_at043tn24

Florent Revest (1):
      samples: ftrace: Save required argument registers in sample trampolines

Florian Fainelli (1):
      net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Florian Kauer (2):
      igc: Fix launchtime before start of cycle
      igc: Fix inserting of empty frame for launchtime

George Stark (1):
      meson saradc: fix clock divider mask length

Greg Kroah-Hartman (1):
      Linux 6.1.40

Harald Freudenberger (1):
      s390/zcrypt: do not retry administrative requests

Heiko Carstens (1):
      s390/decompressor: fix misaligned symbol build error

Heiner Kallweit (2):
      pwm: meson: modify and simplify calculation in meson_pwm_get_state
      pwm: meson: fix handling of period/duty if greater than UINT_MAX

Hersen Wu (1):
      drm/amd/display: edp do not add non-edid timings

Huacai Chen (2):
      MIPS: Loongson: Fix cpu_probe_loongson() again
      MIPS: KVM: Fix NULL pointer dereference

Ido Schimmel (1):
      net/sched: flower: Ensure both minimum and maximum ports are specified

Ilya Dryomov (1):
      libceph: harden msgr2.1 frame segment length checks

Isaac J. Manjarres (1):
      regmap-irq: Fix out-of-bounds access when allocating config buffers

Ivan Mikhaylov (2):
      net/ncsi: make one oem_gma function for all mfr id
      net/ncsi: change from ndo_set_mac_address to dev_set_mac_address

Jaegeuk Kim (2):
      f2fs: fix the wrong condition to determine atomic context
      f2fs: fix deadlock in i_xattr_sem and inode page lock

Jarkko Sakkinen (1):
      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Jason Baron (1):
      md/raid0: add discard support for the 'original' layout

Jerry Snitselaar (1):
      tpm: return false from tpm_amd_is_rng_defective on non-x86 platforms

Jiaqing Zhao (1):
      Revert "8250: add support for ASIX devices with a FIFO bug"

Jiasheng Jiang (2):
      NTB: ntb_tool: Add check for devm_kcalloc
      net: dsa: qca8k: Add check for skb_copy

Jiri Olsa (1):
      fprobe: Release rethook after the ftrace_ops is unregistered

Jisheng Zhang (1):
      riscv: mm: fix truncation warning on RV32

Johan Hovold (1):
      mfd: pm8008: Fix module autoloading

Jonas Gorski (1):
      bus: ixp4xx: fix IXP4XX_EXP_T1_MASK

Junfeng Guo (1):
      gve: Set default duplex configuration to full

Justin Tee (1):
      scsi: lpfc: Fix double free in lpfc_cmpl_els_logo_acc() caused by lpfc_nlp_not_used()

Kemeng Shi (3):
      ext4: fix wrong unit use in ext4_mb_clear_bb
      ext4: get block from bh in ext4_free_blocks for fast commit replay
      ext4: fix wrong unit use in ext4_mb_new_blocks

Kenneth Feng (1):
      drm/amd/pm: add abnormal fan detection for smu 13.0.0

Klaus Kudielka (1):
      net: mvneta: fix txq_map in case of txq_number==1

Konstantin Komarov (1):
      fs/ntfs3: Check fields while reading

Kornel Dulęba (1):
      pinctrl: amd: Detect and mask spurious interrupts

Krister Johansen (1):
      net: ena: fix shift-out-of-bounds in exponential backoff

Krzysztof Kozlowski (1):
      soundwire: qcom: fix storing port config out-of-bounds

Kumar Kartikeya Dwivedi (1):
      bpf: Fix max stack depth check for async callbacks

Kuniyuki Iwashima (1):
      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().

Leo Chen (1):
      drm/amd/display: disable seamless boot if force_odm_combine is enabled

Linus Torvalds (1):
      workqueue: clean up WORK_* constant types, clarify masking

Luben Tuikov (1):
      drm/amdgpu: Fix minmax warning

M A Ramdhan (1):
      net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Manish Rangankar (1):
      scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Manivannan Sadhasivam (1):
      PCI: qcom: Disable write access to read only registers for IP v2.3.3

Marek Vasut (1):
      drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags

Mario Limonciello (13):
      pinctrl: amd: Adjust debugfs output
      pinctrl: amd: Add fields for interrupt status and wake status
      pinctrl: amd: Detect internal GPIO0 debounce handling
      pinctrl: amd: Fix mistake in handling clearing pins at startup
      pinctrl: amd: Revert "pinctrl: amd: disable and mask interrupts on probe"
      pinctrl: amd: Only use special debounce behavior for GPIO 0
      pinctrl: amd: Use amd_pinconf_set() for all config options
      pinctrl: amd: Drop pull up select configuration
      pinctrl: amd: Unify debounce handling into amd_pinconf_set()
      drm/amd: Disable PSR-SU on Parade 0803 TCON
      drm/amd/display: Correct `DMUB_FW_VERSION` macro
      drm/amd/pm: conditionally disable pcie lane/speed switching for SMU13
      Revert "drm/amd: Disable PSR-SU on Parade 0803 TCON"

Martin Fuzzey (1):
      tty: serial: imx: fix rs485 rx after tx

Martin Kaiser (1):
      hwrng: imx-rngc - fix the timeout for init and self check

Masami Hiramatsu (Google) (3):
      fprobe: Ensure running fprobe_exit_handler() finished before calling rethook_free()
      tracing/probes: Fix not to count error code to total length
      tracing/probes: Fix to update dynamic data counter if fetcharg uses it

Mateusz Stachyra (1):
      tracing: Fix null pointer dereference in tracing_err_log_open()

Matthias Kaehlcke (1):
      dm: verity-loadpin: Add NULL pointer check for 'bdev' parameter

Matthieu Baerts (6):
      selftests: mptcp: connect: fail if nft supposed to work
      selftests: mptcp: sockopt: return error if wrong mark
      selftests: mptcp: userspace_pm: use correct server port
      selftests: mptcp: userspace_pm: report errors with 'remove' tests
      selftests: mptcp: depend on SYN_COOKIES
      selftests: mptcp: pm_nl_ctl: fix 32-bit support

Max Filippov (1):
      xtensa: ISS: fix call to split_if_spec

Michael Ellerman (2):
      powerpc/security: Fix Speculation_Store_Bypass reporting on Power10
      powerpc/64s: Fix native_hpte_remove() to be irq-safe

Mikulas Patocka (1):
      dm integrity: reduce vmalloc space footprint on 32-bit architectures

Ming Lei (1):
      nvme-pci: fix DMA direction of unmapping integrity data

Mohamed Khalfella (1):
      tracing/histograms: Add histograms to hist_vars if they have referenced variables

Moritz Fischer (1):
      net: lan743x: Don't sleep in atomic context

Muhammad Husaini Zulkifli (1):
      igc: Remove delay during TX ring configuration

Namhyung Kim (1):
      perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR

Namjae Jeon (2):
      ksmbd: add missing compound request handing in some commands
      ksmbd: fix out of bounds read in smb2_sess_setup

Naveen N Rao (1):
      powerpc: Fail build if using recordmcount with binutils v2.37

Nilesh Javali (3):
      scsi: qla2xxx: Array index may go out of bound
      scsi: qla2xxx: Avoid fcport pointer dereference
      scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Nitya Sunkad (1):
      ionic: remove WARN_ON to prevent panic_on_warn

Oleksij Rempel (1):
      net: phy: dp83td510: fix kernel stall during netboot in DP83TD510E PHY driver

Ondrej Zary (1):
      PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Paolo Abeni (1):
      net: prevent skb corruption on frag list segmentation

Pedro Tammela (4):
      net/sched: make psched_mtu() RTNL-less safe
      net/sched: sch_qfq: refactor parsing of netlink parameters
      net/sched: sch_qfq: account for stab overhead in qfq_enqueue
      net/sched: sch_qfq: reintroduce lmax bound check for MTU

Peter Korsgaard (1):
      dm init: add dm-mod.waitfor to wait for asynchronously probed block devices

Petr Tesarik (2):
      swiotlb: always set the number of areas before allocating the pool
      swiotlb: reduce the number of areas to match actual memory pool size

Prasad Koya (1):
      igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Pu Lehui (1):
      bpf: cpumap: Fix memory leak in cpu_map_update_elem

Quinn Tran (7):
      scsi: qla2xxx: Multi-que support for TMF
      scsi: qla2xxx: Fix task management cmd failure
      scsi: qla2xxx: Fix task management cmd fail due to unavailable resource
      scsi: qla2xxx: Fix hang in task management
      scsi: qla2xxx: Wait for io return on terminate rport
      scsi: qla2xxx: Fix mem access after free
      scsi: qla2xxx: Fix buffer overrun

Rafał Miłecki (1):
      net: bgmac: postpone turning IRQs off to avoid SoC hangs

Randy Dunlap (3):
      scsi: ufs: ufs-mediatek: Add dependency for RESET_CONTROLLER
      wifi: airo: avoid uninitialized warning in airo_get_rate()
      swiotlb: mark swiotlb_memblock_alloc() as __init

Ratheesh Kannoth (1):
      octeontx2-af: Promisc enable/disable through mbox

Rick Wertenbroek (5):
      PCI: rockchip: Assert PCI Configuration Enable bit after probe
      PCI: rockchip: Write PCI Device ID to correct register
      PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
      PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
      PCI: rockchip: Use u32 variable to access 32-bit registers

Ritesh Harjani (IBM) (1):
      ext2/dax: Fix ext2_setsize when len is page aligned

Robin Murphy (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Ross Lagerwall (1):
      PCI: Release resource invalidated by coalescing

Sai Krishna (1):
      octeontx2-af: Move validation of ptp pointer before its usage

Samuel Pitoiset (1):
      drm/amdgpu: fix clearing mappings for BOs that are always valid in VM

Sathya Prakash (1):
      scsi: mpi3mr: Propagate sense data for admin queue SCSI I/O

Shreyas Deodhar (1):
      scsi: qla2xxx: Pointer may be dereferenced

Siddh Raman Pant (1):
      jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Sridhar Samudrala (1):
      ice: Fix max_rate check while configuring TX rate limits

Stanislav Lisovskiy (1):
      drm/i915: Don't preserve dpll_hw_state for slave crtc in Bigjoiner

Stephan Gerhold (1):
      opp: Fix use-after-free in lazy_opp_tables after probe deferral

Suman Ghosh (1):
      octeontx2-pf: Add additional check for MCAM rules

Sung-huai Wang (1):
      drm/amd/display: add a NULL pointer check

Thomas Bogendoerfer (1):
      MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled

Thomas Hellström (1):
      drm/ttm: Don't leak a resource on swapout move error

Thomas Zimmermann (1):
      drm/client: Send hotplug event after registering a client

Tvrtko Ursulin (1):
      drm/i915: Fix one wrong caching mode enum usage

Tzvetomir Stoyanov (VMware) (1):
      kernel/trace: Fix cleanup logic of enable_trace_eprobe

Valentin David (1):
      tpm: Do not remap from ACPI resources again for Pluton TPM

Vlad Buslov (1):
      net/mlx5e: Check for NOT_READY flag state after locking

Weitao Wang (3):
      xhci: Fix resume issue of some ZHAOXIN hosts
      xhci: Fix TRB prefetch issue of ZHAOXIN hosts
      xhci: Show ZHAOXIN xHCI root hub speed correctly

Winston Wen (1):
      cifs: fix session state check in smb2_find_smb_ses

Xin Yin (1):
      erofs: fix fsdax unavailability for chunk-based regular files

Xiubo Li (3):
      ceph: add a dedicated private data for netfs rreq
      ceph: fix blindly expanding the readahead windows
      ceph: don't let check_caps skip sending responses for revoke msgs

Yang Yingliang (1):
      NTB: ntb_transport: fix possible memory leak while device_register() fails

Yuan Can (3):
      ntb: idt: Fix error handling in idt_pci_driver_init()
      NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
      ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

Zhang Shurong (1):
      wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()

Zheng Yejian (3):
      tracing: Fix memory leak of iter->temp when reading trace_pipe
      ring-buffer: Fix deadloop issue on reading trace_pipe
      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

Zhengchao Shao (3):
      net/mlx5e: fix double free in mlx5e_destroy_flow_table
      net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
      net/mlx5e: fix memory leak in mlx5e_ptp_open

Zhihao Cheng (3):
      ovl: let helper ovl_i_path_real() return the realinode
      ovl: fix null pointer dereference in ovl_get_acl_rcu()
      ext4: Fix reusing stale buffer heads from last failed mounting

Ziyang Xuan (1):
      ipv6/addrconf: fix a potential refcount underflow for idev

gaba (1):
      drm/amdgpu: avoid restore process run into dead loop.

lyndonli (1):
      drm/amdgpu: add the fan abnormal detection feature

sunliming (1):
      tracing/user_events: Fix incorrect return value for writing operation when events are disabled

