Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC5477E6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbjHPQnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbjHPQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4B30EF;
        Wed, 16 Aug 2023 09:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383B466D07;
        Wed, 16 Aug 2023 16:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18530C433C8;
        Wed, 16 Aug 2023 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692204143;
        bh=RxUBohyQpLmzwetDz7ehuXmXl42hM6pNFl0YwYTZ46Q=;
        h=From:To:Cc:Subject:Date:From;
        b=c8xmYfAkz6vRiuBvQWd59kQFLq1kfVrezTGYtijm+PVX51EWuhhJJMKTmSJWBAwqZ
         6LRG3cR1HWbcwd0w7oWs5Ut7U3DJSyXphpiPPier5pa7VuWI1iOrTw5iukzEQHP1mC
         E4zBwFWj/9tX+czrLwl6s2XDjzGkPbzp1xKPRbbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.11
Date:   Wed, 16 Aug 2023 18:42:16 +0200
Message-ID: <2023081616-tamper-attitude-8427@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.4.11 kernel.

All users of the 6.4 kernel series must upgrade.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                          |    2 
 arch/alpha/kernel/setup.c                                         |    3 
 arch/arm64/kvm/arm.c                                              |   15 
 arch/parisc/Kconfig.debug                                         |    2 
 arch/parisc/include/asm/spinlock.h                                |    2 
 arch/parisc/include/asm/spinlock_types.h                          |    6 
 arch/parisc/kernel/sys_parisc.c                                   |   15 
 arch/parisc/kernel/syscall.S                                      |   23 
 arch/riscv/include/asm/mmio.h                                     |   16 
 arch/riscv/include/asm/pgtable.h                                  |    2 
 arch/riscv/kernel/elf_kexec.c                                     |    3 
 arch/riscv/mm/init.c                                              |   16 
 arch/riscv/mm/kasan_init.c                                        |    1 
 arch/x86/boot/compressed/idt_64.c                                 |    9 
 arch/x86/boot/compressed/sev.c                                    |   37 +
 arch/x86/entry/vdso/vma.c                                         |    4 
 arch/x86/include/asm/acpi.h                                       |    2 
 arch/x86/include/asm/linkage.h                                    |    2 
 arch/x86/include/asm/processor.h                                  |    2 
 arch/x86/include/asm/segment.h                                    |    2 
 arch/x86/kernel/acpi/boot.c                                       |    4 
 arch/x86/kernel/cpu/amd.c                                         |    1 
 arch/x86/kernel/vmlinux.lds.S                                     |   12 
 arch/x86/kvm/svm/sev.c                                            |   94 +--
 arch/x86/kvm/svm/svm.h                                            |   26 +
 arch/x86/kvm/x86.c                                                |    2 
 drivers/accel/ivpu/ivpu_gem.c                                     |    8 
 drivers/acpi/resource.c                                           |   64 ++
 drivers/acpi/scan.c                                               |    1 
 drivers/android/binder.c                                          |    1 
 drivers/android/binder_alloc.c                                    |    6 
 drivers/android/binder_alloc.h                                    |    1 
 drivers/block/zram/zram_drv.c                                     |   32 -
 drivers/char/tpm/tpm-chip.c                                       |   83 ---
 drivers/char/tpm/tpm_crb.c                                        |   30 +
 drivers/char/tpm/tpm_tis.c                                        |   20 
 drivers/cpufreq/amd-pstate.c                                      |   10 
 drivers/cpuidle/cpuidle-psci-domain.c                             |   39 -
 drivers/cpuidle/dt_idle_genpd.c                                   |   24 
 drivers/cpuidle/dt_idle_genpd.h                                   |    7 
 drivers/dma/idxd/device.c                                         |    4 
 drivers/dma/mcf-edma.c                                            |   13 
 drivers/dma/owl-dma.c                                             |    2 
 drivers/dma/pl330.c                                               |   18 
 drivers/dma/xilinx/xdma.c                                         |    6 
 drivers/gpio/gpio-sim.c                                           |    1 
 drivers/gpio/gpio-ws16c48.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                               |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |   26 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    5 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c       |    2 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c       |    3 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c                  |    7 
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                           |    2 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                  |   48 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c          |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c               |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c               |   27 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c             |   10 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c             |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c             |    4 
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h                      |    2 
 drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h                |    1 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                         |   34 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                     |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c                    |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                    |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c              |    3 
 drivers/gpu/drm/bridge/ite-it6505.c                               |    4 
 drivers/gpu/drm/drm_gem_shmem_helper.c                            |    6 
 drivers/gpu/drm/nouveau/nouveau_connector.c                       |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c                     |   48 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h                 |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c                 |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c                 |   10 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c                |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c                 |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c                 |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c                    |   13 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                       |   17 
 drivers/hwmon/aquacomputer_d5next.c                               |   37 +
 drivers/hwmon/pmbus/bel-pfe.c                                     |   16 
 drivers/iio/adc/ad7192.c                                          |   16 
 drivers/iio/adc/ina2xx-adc.c                                      |    9 
 drivers/iio/adc/meson_saradc.c                                    |   23 
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c         |    2 
 drivers/iio/frequency/admv1013.c                                  |    5 
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c                      |    2 
 drivers/iio/industrialio-core.c                                   |    5 
 drivers/iio/light/rohm-bu27034.c                                  |   22 
 drivers/infiniband/core/umem.c                                    |    3 
 drivers/infiniband/hw/bnxt_re/main.c                              |    4 
 drivers/infiniband/hw/hfi1/chip.c                                 |    1 
 drivers/interconnect/qcom/bcm-voter.c                             |    5 
 drivers/interconnect/qcom/icc-rpmh.h                              |    2 
 drivers/interconnect/qcom/sa8775p.c                               |    1 
 drivers/interconnect/qcom/sm8450.c                                |    9 
 drivers/interconnect/qcom/sm8550.c                                |   17 
 drivers/isdn/mISDN/dsp.h                                          |    2 
 drivers/isdn/mISDN/dsp_cmx.c                                      |    2 
 drivers/isdn/mISDN/dsp_core.c                                     |    2 
 drivers/misc/cardreader/rts5227.c                                 |    2 
 drivers/misc/cardreader/rts5228.c                                 |   18 
 drivers/misc/cardreader/rts5249.c                                 |    3 
 drivers/misc/cardreader/rts5260.c                                 |   18 
 drivers/misc/cardreader/rts5261.c                                 |   18 
 drivers/misc/cardreader/rtsx_pcr.c                                |    5 
 drivers/mmc/host/moxart-mmc.c                                     |    8 
 drivers/mmc/host/sdhci_f_sdh30.c                                  |   60 +-
 drivers/net/bonding/bond_main.c                                   |    4 
 drivers/net/dsa/ocelot/felix.c                                    |    2 
 drivers/net/ethernet/freescale/enetc/enetc_pf.c                   |  103 ++-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c                |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                   |   14 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c        |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |   24 
 drivers/net/ethernet/ibm/ibmvnic.c                                |  112 +++-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                    |    5 
 drivers/net/ethernet/intel/iavf/iavf_fdir.c                       |   11 
 drivers/net/ethernet/intel/igc/igc.h                              |    4 
 drivers/net/ethernet/intel/igc/igc_main.c                         |   34 +
 drivers/net/ethernet/marvell/prestera/prestera_router.c           |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c         |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                 |   11 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                   |   21 
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c               |    5 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c                   |    3 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ptrn.c        |    2 
 drivers/net/ethernet/microsoft/mana/mana_en.c                     |   37 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                   |   23 
 drivers/net/macsec.c                                              |   28 -
 drivers/net/phy/at803x.c                                          |    2 
 drivers/net/tun.c                                                 |    2 
 drivers/net/vxlan/vxlan_vnifilter.c                               |   11 
 drivers/net/wireguard/allowedips.c                                |    8 
 drivers/net/wireguard/selftest/allowedips.c                       |   16 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c       |    5 
 drivers/net/wireless/realtek/rtw89/mac.c                          |    2 
 drivers/nvme/host/core.c                                          |   10 
 drivers/nvme/host/pci.c                                           |    3 
 drivers/nvme/host/rdma.c                                          |    3 
 drivers/nvme/host/tcp.c                                           |    3 
 drivers/pci/bus.c                                                 |    4 
 drivers/pci/controller/Kconfig                                    |    1 
 drivers/pci/of.c                                                  |    5 
 drivers/platform/x86/lenovo-ymc.c                                 |   25 
 drivers/platform/x86/mlx-platform.c                               |   23 
 drivers/platform/x86/msi-ec.c                                     |   18 
 drivers/platform/x86/serial-multi-instantiate.c                   |   35 +
 drivers/scsi/53c700.c                                             |    2 
 drivers/scsi/fnic/fnic.h                                          |    2 
 drivers/scsi/fnic/fnic_scsi.c                                     |    6 
 drivers/scsi/qedf/qedf_main.c                                     |   18 
 drivers/scsi/qedi/qedi_main.c                                     |   18 
 drivers/scsi/raid_class.c                                         |    1 
 drivers/scsi/scsi_proc.c                                          |   30 -
 drivers/scsi/snic/snic_disc.c                                     |    1 
 drivers/scsi/storvsc_drv.c                                        |    4 
 drivers/thunderbolt/tb.c                                          |    2 
 drivers/ufs/host/ufs-renesas.c                                    |    2 
 drivers/usb/common/usb-conn-gpio.c                                |    6 
 drivers/usb/dwc3/gadget.c                                         |    9 
 drivers/usb/gadget/udc/core.c                                     |    9 
 drivers/usb/storage/alauda.c                                      |   12 
 drivers/usb/typec/altmodes/displayport.c                          |   18 
 drivers/usb/typec/tcpm/tcpm.c                                     |    7 
 fs/btrfs/block-group.c                                            |   17 
 fs/btrfs/block-group.h                                            |    2 
 fs/btrfs/disk-io.c                                                |    3 
 fs/btrfs/extent-tree.c                                            |    5 
 fs/btrfs/extent_io.c                                              |   13 
 fs/btrfs/inode.c                                                  |   10 
 fs/btrfs/relocation.c                                             |   45 +
 fs/btrfs/tree-checker.c                                           |   14 
 fs/nilfs2/inode.c                                                 |    8 
 fs/nilfs2/segment.c                                               |    2 
 fs/nilfs2/the_nilfs.h                                             |    2 
 fs/proc/kcore.c                                                   |   30 +
 fs/smb/server/smb2misc.c                                          |   10 
 fs/smb/server/smb2pdu.c                                           |    9 
 include/linux/cpu.h                                               |    2 
 include/linux/skmsg.h                                             |    1 
 include/linux/tpm.h                                               |    1 
 include/net/cfg80211.h                                            |    3 
 include/net/netfilter/nf_tables.h                                 |   64 ++
 include/trace/events/tcp.h                                        |    5 
 io_uring/io_uring.c                                               |    3 
 io_uring/openclose.c                                              |    6 
 mm/damon/core.c                                                   |    1 
 mm/hugetlb.c                                                      |   75 +-
 mm/memory-failure.c                                               |   29 -
 mm/zsmalloc.c                                                     |   14 
 net/core/filter.c                                                 |    6 
 net/core/skmsg.c                                                  |   10 
 net/core/sock_map.c                                               |   10 
 net/dccp/output.c                                                 |    2 
 net/dccp/proto.c                                                  |   10 
 net/ipv4/ip_tunnel_core.c                                         |    2 
 net/ipv4/nexthop.c                                                |   28 -
 net/ipv6/ndisc.c                                                  |    3 
 net/mptcp/protocol.c                                              |    4 
 net/mptcp/protocol.h                                              |    1 
 net/mptcp/subflow.c                                               |   58 +-
 net/netfilter/nf_tables_api.c                                     |  259 +++++++++-
 net/netfilter/nft_set_hash.c                                      |   85 ++-
 net/netfilter/nft_set_pipapo.c                                    |   66 +-
 net/netfilter/nft_set_rbtree.c                                    |  146 +++--
 net/packet/af_packet.c                                            |   16 
 net/smc/af_smc.c                                                  |   77 ++
 net/smc/smc.h                                                     |    2 
 net/smc/smc_clc.c                                                 |    4 
 net/smc/smc_core.c                                                |   25 
 net/smc/smc_sysctl.c                                              |   10 
 net/tls/tls_device.c                                              |   64 +-
 net/wireless/nl80211.c                                            |    5 
 net/xdp/xsk.c                                                     |    1 
 tools/testing/radix-tree/regression1.c                            |    2 
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c           |    2 
 tools/testing/selftests/mm/ksm_tests.c                            |    1 
 tools/testing/selftests/net/fib_nexthops.sh                       |   10 
 tools/testing/selftests/net/forwarding/bridge_mdb.sh              |   59 +-
 tools/testing/selftests/net/forwarding/bridge_mdb_max.sh          |   19 
 tools/testing/selftests/net/forwarding/ethtool.sh                 |    2 
 tools/testing/selftests/net/forwarding/ethtool_extended_state.sh  |    2 
 tools/testing/selftests/net/forwarding/ethtool_mm.sh              |   18 
 tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh         |    2 
 tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh |    2 
 tools/testing/selftests/net/forwarding/lib.sh                     |   17 
 tools/testing/selftests/net/forwarding/settings                   |    1 
 tools/testing/selftests/net/forwarding/tc_actions.sh              |    6 
 tools/testing/selftests/net/forwarding/tc_flower.sh               |    8 
 tools/testing/selftests/net/forwarding/tc_tunnel_key.sh           |    9 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                   |    6 
 tools/testing/selftests/rseq/Makefile                             |    4 
 tools/testing/selftests/rseq/rseq.c                               |    2 
 238 files changed, 2515 insertions(+), 1033 deletions(-)

Alan Stern (2):
      usb-storage: alauda: Fix uninit-value in alauda_check_media()
      USB: Gadget: core: Help prevent panic during UVC unconfigure

Alejandro Tafalla (1):
      iio: imu: lsm6dsx: Fix mount matrix retrieval

Aleksa Sarai (1):
      io_uring: correct check for O_TMPFILE

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report

Alex Deucher (1):
      drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()

Alexandra Diupina (1):
      scsi: 53c700: Check that command slot is not NULL

Alexandre Ghiti (1):
      riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping

Alisa Roman (1):
      iio: adc: ad7192: Fix ac excitation feature

Alvin Šipraga (1):
      iio: adc: ina2xx: avoid NULL pointer dereference on OF device match

Andrea Claudi (2):
      selftests: mptcp: join: fix 'delete and re-add' test
      selftests: mptcp: join: fix 'implicit EP' test

Andrea Parri (1):
      riscv,mmio: Fix readX()-to-delay() ordering

Andrew Kanner (2):
      net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
      drivers: net: prevent tun_build_skb() to exceed the packet size limit

Andrew Yang (1):
      zsmalloc: fix races between modifications of fullness and isolated

Arnd Bergmann (3):
      x86/speculation: Add cpu_show_gds() prototype
      x86: Move gds_ucode_mitigated() declaration to header
      drm/nouveau: remove unused tu102_gr_load() function

August Wikerfors (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G

Ayush Jain (1):
      selftests: mm: ksm: fix incorrect evaluation of parameter

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix response to vsafe0V event

Bartosz Golaszewski (1):
      gpio: sim: mark the GPIO chip as a one that can sleep

Bjorn Helgaas (1):
      Revert "PCI: mvebu: Mark driver as BROKEN"

Boris Brezillon (1):
      drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()

Borislav Petkov (AMD) (1):
      x86/sev: Do not try to parse for the CC blob on non-AMD hardware

Chris Mi (1):
      net/mlx5e: Unoffload post act rule when handling FIB events

Christoph Hellwig (4):
      zram: take device and not only bvec offset into account
      btrfs: don't stop integrity writeback too early
      btrfs: don't wait for writeback on clean pages in extent_write_cache_pages
      btrfs: properly clear end of the unreserved range in cow_file_range

Christophe JAILLET (1):
      dmaengine: mcf-edma: Fix a potential un-allocated memory access

Colin Ian King (1):
      radix tree test suite: fix incorrect allocation size for pthreads

Cristian Ciocaltea (1):
      x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405

Dan Carpenter (1):
      iio: frequency: admv1013: propagate errors from regulator_get_voltage()

Daniel Jurgens (1):
      net/mlx5: Allow 0 for total host VFs

Daniel Stone (1):
      drm/rockchip: Don't spam logs in atomic check

David Xu (1):
      platform/x86: serial-multi-instantiate: Auto detect IRQ resource for CSC3551

Douglas Miller (1):
      IB/hfi1: Fix possible panic during hotplug remove

Elson Roy Serrao (1):
      usb: dwc3: Properly handle processing of pending events

Eric Dumazet (4):
      macsec: use DEV_STATS_INC()
      net/packet: annotate data-races around tp->status
      tcp: add missing family to tcp_set_ca_state() tracepoint
      dccp: fix data-race around dp->dccps_mss_cache

Evan Quan (2):
      drm/amd/pm: expose swctf threshold setting for legacy powerplay
      drm/amd/pm: avoid unintentional shutdown due to temperature momentary fluctuation

Fedor Pchelkin (1):
      drivers: vxlan: vnifilter: free percpu vni stats on error path

Felix Fietkau (1):
      wifi: cfg80211: fix sband iftype data lookup for AP_VLAN

Fenghua Yu (1):
      dmaengine: idxd: Clear PRS disable flag when disabling IDXD device

Florian Westphal (2):
      netfilter: nf_tables: don't skip expired elements during walk
      tunnels: fix kasan splat when generating ipv4 pmtu error

Gal Pressman (1):
      net/mlx5e: Take RTNL lock when needed before calling xdp_set_features()

George Stark (1):
      iio: adc: meson: fix core clock enable/disable moment

Gerd Bayer (2):
      net/smc: Fix setsockopt and sysctl to specify same buffer size again
      net/smc: Use correct buffer sizes when switching between TCP and SMC

Greg Kroah-Hartman (1):
      Linux 6.4.11

Hans de Goede (5):
      ACPI: resource: revert "Remove "Zen" specific match and quirks"
      ACPI: resource: Always use MADT override IRQ settings for all legacy non i8042 IRQs
      ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
      ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M
      platform/x86: lenovo-ymc: Only bind on machines with a convertible DMI chassis-type

Hao Chen (1):
      net: hns3: fix strscpy causing content truncation issue

Helge Deller (2):
      io_uring/parisc: Adjust pgoff in io_uring mmap() for parisc
      parisc: Fix lightweight spinlock checks to not break futexes

Ido Schimmel (19):
      selftests: forwarding: Set default IPv6 traceroute utility
      selftests: forwarding: tc_tunnel_key: Make filters more specific
      selftests: forwarding: ethtool_mm: Skip when MAC Merge is not supported
      selftests: forwarding: bridge_mdb_max: Check iproute2 version
      selftests: forwarding: bridge_mdb: Check iproute2 version
      selftests: forwarding: Add a helper to skip test when using veth pairs
      selftests: forwarding: ethtool: Skip when using veth pairs
      selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
      selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
      selftests: forwarding: Skip test when no interfaces are specified
      selftests: forwarding: Switch off timeout
      selftests: forwarding: tc_actions: Use ncat instead of nc
      selftests: forwarding: tc_flower: Relax success criterion
      selftests: forwarding: bridge_mdb_max: Fix failing test with old libnet
      selftests: forwarding: bridge_mdb: Fix failing test with old libnet
      selftests: forwarding: bridge_mdb: Make test more robust
      nexthop: Fix infinite nexthop dump when using maximum nexthop ID
      nexthop: Make nexthop bucket dump more efficient
      nexthop: Fix infinite nexthop bucket dump when using maximum nexthop ID

Ilpo Järvinen (1):
      dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Jakub Kicinski (1):
      net: tls: avoid discarding data on record close

Jarkko Sakkinen (1):
      tpm_tis: Opt-in interrupts

Jason A. Donenfeld (1):
      wireguard: allowedips: expand maximum node depth

Jean Delvare (1):
      platform/x86: msi-ec: Fix the build

Jianbo Liu (1):
      net/mlx5e: TC, Fix internal port memory leak

Jie Wang (2):
      net: hns3: refactor hclge_mac_link_status_wait for interface reuse
      net: hns3: add wait until mac link down

Jinghao Jia (1):
      x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h

Jonas Gorski (1):
      net: marvell: prestera: fix handling IPv4 routes with nhid

Jonathan McDowell (1):
      tpm/tpm_tis: Disable interrupts for Lenovo P620 devices

Josef Bacik (2):
      btrfs: wait for actual caching progress during allocation
      btrfs: set cache_block_group_error if we find an error

Kalesh AP (1):
      RDMA/bnxt_re: Fix error handling in probe failure path

Karan Tilak Kumar (1):
      scsi: fnic: Replace return codes in fnic_clean_pending_aborts()

Karol Herbst (2):
      drm/nouveau/gr: enable memory loads on helper invocation on all channels
      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes

Karol Wachowski (1):
      accel/ivpu: Add set_pages_array_wc/uc for internal buffers

Keith Yeo (1):
      wifi: nl80211: fix integer overflow in nl80211_parse_mbssid_elems()

Kenneth Feng (1):
      drm/amd/pm: correct the pcie width for smu 13.0.0

Kirill A. Shutemov (1):
      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Kunihiko Hayashi (1):
      mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Li Yang (1):
      net: phy: at803x: remove set/get wol callbacks for AR8032

Long Li (1):
      ksmbd: validate command request size

Lorenzo Stoakes (1):
      fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT regions

Lyude Paul (1):
      drm/nouveau/nvkm/dp: Add workaround to fix DP 1.3+ DPCD issues

Maciej Żenczykowski (1):
      ipv6: adjust ndisc_is_useropt() to also return true for PIO

Magnus Karlsson (1):
      xsk: fix refcount underflow in error path

Mario Limonciello (5):
      tpm: Disable RNG for all AMD fTPMs
      tpm: Add a helper for checking hwrng enabled
      drm/amd/display: Fix a regression on Polaris cards
      drm/amd: Disable S/G for APUs when 64GB or more host memory
      drm/amd/display: Don't show stack trace for missing eDP

Mark Brown (1):
      selftests/rseq: Fix build with undefined __weak

Masahiro Yamada (1):
      alpha: remove __init annotation from exported page_is_ram()

Matti Vaittinen (1):
      iio: light: bu27034: Fix scale format

Maulik Shah (2):
      cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
      cpuidle: psci: Move enabling OSI mode after power domains creation

Melissa Wen (1):
      drm/amd/display: check attr flag before set cursor degamma on DCN3+

Miaohe Lin (2):
      mm: memory-failure: fix potential unexpected return value from unpoison_memory()
      mm: memory-failure: avoid false hwpoison page mapped error info

Michael Guralnik (1):
      RDMA/umem: Set iova in ODP flow

Michael Kelley (1):
      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Mika Westerberg (1):
      thunderbolt: Fix memory leak in tb_handle_dp_bandwidth_request()

Mike Kravetz (1):
      hugetlb: do not clear hugetlb dtor until allocating vmemmap

Mike Tipton (1):
      interconnect: qcom: Add support for mask-based BCMs

Milan Zamazal (1):
      iio: core: Prevent invalid memory access when there is no parent

Ming Lei (3):
      nvme: fix possible hang when removing a controller during error recovery
      nvme-tcp: fix potential unbalanced freeze & unfreeze
      nvme-rdma: fix potential unbalanced freeze & unfreeze

Minjie Du (1):
      dmaengine: xilinx: xdma: Fix Judgment of the return value

Miquel Raynal (2):
      dmaengine: xilinx: xdma: Fix interrupt vector setting
      dmaengine: xilinx: xdma: Fix typo

Moshe Shemesh (2):
      net/mlx5: Skip clock update work when device is in error state
      net/mlx5: Reload auxiliary devices in pci error handlers

Muhammad Husaini Zulkifli (1):
      igc: Add lock to safeguard global Qbv variables

Namjae Jeon (1):
      ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()

Nathan Chancellor (1):
      mISDN: Update parameter type of dsp_cmx_send()

Neil Armstrong (3):
      interconnect: qcom: sa8775p: add enable_mask for bcm nodes
      interconnect: qcom: sm8450: add enable_mask for bcm nodes
      interconnect: qcom: sm8550: add enable_mask for bcm nodes

Nick Child (5):
      ibmvnic: Enforce stronger sanity checks on login response
      ibmvnic: Unmap DMA login rsp buffer on send login fail
      ibmvnic: Handle DMA unmapping of login buffs in release functions
      ibmvnic: Do partial reset on login failure
      ibmvnic: Ensure login failure recovery is safe from other resets

Nick Desaulniers (2):
      riscv: mm: fix 2 instances of -Wmissing-variable-declarations
      x86/srso: Fix build breakage with the LLVM linker

Nilesh Javali (2):
      scsi: qedi: Fix firmware halt over suspend and resume
      scsi: qedf: Fix firmware halt over suspend and resume

Nitya Sunkad (1):
      ionic: Add missing err handling for queue reconfig

Pablo Neira Ayuso (3):
      netfilter: nf_tables: GC transaction API to avoid race with control plane
      netfilter: nf_tables: adapt set backend to use GC transaction API
      netfilter: nft_set_hash: mark set element as dead when deleting from packet path

Paolo Abeni (2):
      mptcp: avoid bogus reset on fallback close
      mptcp: fix disconnect vs accept race

Paolo Bonzini (2):
      KVM: SEV: snapshot the GHCB before accessing it
      KVM: SEV: only access GHCB fields once

Peter Ujfalusi (1):
      tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition

Petr Tesarik (1):
      wifi: brcm80211: handle params_v1 allocation failure

Pin-yen Lin (1):
      drm/bridge: it6505: Check power state with it6505->powered in IRQ handler

Ping-Ke Shih (1):
      wifi: rtw89: fix 8852AE disconnection caused by RX full flags

Piotr Gardocki (1):
      iavf: fix potential races for FDIR filters

Prashanth K (1):
      usb: common: usb-conn-gpio: Prevent bailing out if initial role is none

Qi Zheng (1):
      binder: fix memory leak in binder_init()

Qu Wenruo (2):
      btrfs: exit gracefully if reloc roots don't match
      btrfs: reject invalid reloc tree root keys with stack dump

RD Babiera (1):
      usb: typec: altmodes/displayport: Signal hpd when configuring pin assignment

Raghavendra Rao Ananta (1):
      KVM: arm64: Fix hardware enable/disable flows for pKVM

Ricky WU (1):
      misc: rtsx: judge ASPM Mode to set PETXCFG Reg

Ryusuke Konishi (1):
      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput

Selvin Xavier (1):
      RDMA/bnxt_re: Properly order ib_device_unalloc() to avoid UAF

SeongJae Park (1):
      mm/damon/core: initialize damo_filter->list from damos_new_filter()

Sergei Antonov (1):
      mmc: moxart: read scr register without changing byte order

Shay Drory (1):
      net/mlx5: LAG, Check correct bucket when modifying LAG

Simon Trimmer (1):
      ACPI: scan: Create platform device for CS35L56

Souradeep Chakrabarti (1):
      net: mana: Fix MANA VF unload when hardware is unresponsive

Takashi Iwai (1):
      tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook S 15/17 Gen7

Tao Ren (1):
      hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100

Thomas Weißschuh (1):
      cpufreq: amd-pstate: fix global sysfs attribute type

Tony Battersby (1):
      scsi: core: Fix legacy /proc parsing buffer overflow

Torsten Duwe (2):
      riscv/kexec: load initrd high in available memory
      riscv/kexec: handle R_RISCV_CALL_PLT relocation type

Vadim Pasternak (4):
      platform: mellanox: Change register offset addresses
      platform: mellanox: mlx-platform: Fix signals polarity and latch mask
      platform: mellanox: mlx-platform: Modify graceful shutdown callback and power down mask
      platform: mellanox: Fix order in exit flow

Vladimir Oltean (3):
      PCI: move OF status = "disabled" detection to dev->match_driver
      net: dsa: ocelot: call dsa_tag_8021q_unregister() under rtnl_lock() on driver remove
      net: enetc: reimplement RFS/RSS memory clearing as PCI quirk

William Breathitt Gray (1):
      gpio: ws16c48: Fix off-by-one error in WS16C48 resource region extent

Xiang Yang (1):
      mptcp: fix the incorrect judgment for msk->cb_flags

Xin Li (1):
      x86/vdso: Choose the right GDT_ENTRY_CPUNODE for 32-bit getcpu() on 64-bit kernel

Xu Kuohai (3):
      selftests/bpf: fix a CI failure caused by vsock sockmap test
      bpf, sockmap: Fix map type error in sock_map_del_link
      bpf, sockmap: Fix bug that strp_done cannot be called

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix wrong allocation of modify hdr pattern

Yiyuan Guo (1):
      iio: cros_ec: Fix the allocation size for cros_ec_command

Yonglong Liu (1):
      net: hns3: fix deadlock issue when externel_lb and reset are executed together

Yoshihiro Shimoda (1):
      scsi: ufs: renesas: Fix private allocation

Zhang Jianhua (1):
      dmaengine: owl-dma: Modify mismatched function name

Zhu Wang (2):
      scsi: snic: Fix possible memory leak if device_add() fails
      scsi: core: Fix possible memory leak if device_add() fails

Ziyang Xuan (1):
      bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

