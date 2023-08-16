Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE2E77E6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbjHPQnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbjHPQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681962D4B;
        Wed, 16 Aug 2023 09:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB4DA66D16;
        Wed, 16 Aug 2023 16:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B2CC433CC;
        Wed, 16 Aug 2023 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692204134;
        bh=D+5O61VFGai9h2gyYBHpMb/kES3BMG6CuxBnj2TsZxg=;
        h=From:To:Cc:Subject:Date:From;
        b=1XpzD9GqLFU3sj/NZYkG0o1w/S2pPpFG1wgP873l9tECQgPD1gMAkS3qAmtCmOmff
         bpE+5MiGqp/a9NUimo0zFrd21FVZ+DCuemQsk9vNdF3LSwyl+4ZP0CeecHIejwL8al
         7tmwjBHbzGEuz7KFOb5ZtYXy6hFlZLCr+qVb87Zw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.46
Date:   Wed, 16 Aug 2023 18:42:10 +0200
Message-ID: <2023081610-repurpose-upstate-0b62@gregkh>
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

I'm announcing the release of the 6.1.46 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                          |    2 
 arch/alpha/kernel/setup.c                                         |    3 
 arch/loongarch/Kconfig                                            |    1 
 arch/loongarch/kernel/setup.c                                     |    6 
 arch/riscv/include/asm/mmio.h                                     |   16 
 arch/riscv/kernel/elf_kexec.c                                     |    3 
 arch/x86/boot/compressed/idt_64.c                                 |    9 
 arch/x86/boot/compressed/sev.c                                    |   37 +
 arch/x86/entry/vdso/vma.c                                         |    4 
 arch/x86/include/asm/processor.h                                  |    2 
 arch/x86/kernel/cpu/amd.c                                         |    1 
 arch/x86/kernel/vmlinux.lds.S                                     |   12 
 arch/x86/kvm/svm/sev.c                                            |   94 ++--
 arch/x86/kvm/svm/svm.h                                            |   26 +
 arch/x86/kvm/x86.c                                                |    2 
 drivers/acpi/scan.c                                               |    1 
 drivers/android/binder.c                                          |    1 
 drivers/android/binder_alloc.c                                    |    6 
 drivers/android/binder_alloc.h                                    |    1 
 drivers/char/tpm/tpm-chip.c                                       |   83 ---
 drivers/char/tpm/tpm_crb.c                                        |   30 +
 drivers/cpuidle/dt_idle_genpd.c                                   |   24 +
 drivers/cpuidle/dt_idle_genpd.h                                   |    7 
 drivers/dma/mcf-edma.c                                            |   13 
 drivers/dma/owl-dma.c                                             |    2 
 drivers/dma/pl330.c                                               |   18 
 drivers/gpio/gpio-sim.c                                           |    1 
 drivers/gpio/gpio-ws16c48.c                                       |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                               |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                        |   26 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                           |   11 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                 |    2 
 drivers/gpu/drm/amd/display/dc/core/dc.c                          |   74 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c                     |    5 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                 |  234 +++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h                               |    6 
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c         |    6 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c                  |    7 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c                 |    8 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c             |   22 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h             |    3 
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c           |    1 
 drivers/gpu/drm/amd/display/dc/inc/core_types.h                   |    1 
 drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h          |    1 
 drivers/gpu/drm/amd/include/kgd_pp_interface.h                    |    2 
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h                           |    2 
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c                  |   58 ++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c          |    4 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c              |   16 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c               |   80 ++-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c               |   16 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c               |   27 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c             |   41 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c             |   26 +
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c             |   24 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h                      |    4 
 drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h                |    1 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                         |   42 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h                     |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c                    |    9 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                    |    9 
 drivers/gpu/drm/drm_gem_shmem_helper.c                            |    6 
 drivers/gpu/drm/nouveau/nouveau_connector.c                       |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c                     |   48 ++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h                 |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c                 |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c                 |   10 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c                |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c                 |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c                 |    1 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                       |   17 
 drivers/hwmon/pmbus/bel-pfe.c                                     |   16 
 drivers/iio/adc/ad7192.c                                          |   16 
 drivers/iio/adc/ina2xx-adc.c                                      |    9 
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c         |    2 
 drivers/iio/frequency/admv1013.c                                  |    5 
 drivers/iio/industrialio-core.c                                   |    5 
 drivers/infiniband/core/umem.c                                    |    3 
 drivers/infiniband/hw/hfi1/chip.c                                 |    1 
 drivers/interconnect/qcom/bcm-voter.c                             |    5 
 drivers/interconnect/qcom/icc-rpmh.h                              |    2 
 drivers/interconnect/qcom/sm8450.c                                |    9 
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
 drivers/net/bonding/bond_main.c                                   |    4 
 drivers/net/dsa/ocelot/felix.c                                    |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c                |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                   |   14 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c        |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |   24 -
 drivers/net/ethernet/ibm/ibmvnic.c                                |  112 ++++
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                    |    5 
 drivers/net/ethernet/intel/iavf/iavf_fdir.c                       |   11 
 drivers/net/ethernet/marvell/prestera/prestera_router.c           |   14 
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c            |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c               |    5 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c                   |    3 
 drivers/net/ethernet/microsoft/mana/mana_en.c                     |   37 +
 drivers/net/macsec.c                                              |   28 -
 drivers/net/phy/at803x.c                                          |    2 
 drivers/net/tun.c                                                 |    2 
 drivers/net/vxlan/vxlan_vnifilter.c                               |   11 
 drivers/net/wireguard/allowedips.c                                |    8 
 drivers/net/wireguard/selftest/allowedips.c                       |   16 
 drivers/net/wireless/realtek/rtw89/mac.c                          |    2 
 drivers/nvme/host/pci.c                                           |    3 
 drivers/nvme/host/rdma.c                                          |    3 
 drivers/nvme/host/tcp.c                                           |    3 
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
 fs/btrfs/extent_io.c                                              |    7 
 fs/btrfs/inode.c                                                  |   10 
 fs/btrfs/relocation.c                                             |   45 +
 fs/btrfs/tree-checker.c                                           |   14 
 fs/nilfs2/inode.c                                                 |    8 
 fs/nilfs2/segment.c                                               |    2 
 fs/nilfs2/the_nilfs.h                                             |    2 
 fs/smb/server/smb2misc.c                                          |   10 
 fs/smb/server/smb2pdu.c                                           |    9 
 include/linux/cpu.h                                               |    2 
 include/linux/skmsg.h                                             |    1 
 include/linux/tpm.h                                               |    1 
 include/net/cfg80211.h                                            |    3 
 include/net/netfilter/nf_tables.h                                 |   31 +
 include/trace/events/tcp.h                                        |    5 
 io_uring/openclose.c                                              |    6 
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
 net/netfilter/nf_tables_api.c                                     |  163 ++++--
 net/netfilter/nft_flow_offload.c                                  |    6 
 net/netfilter/nft_immediate.c                                     |    8 
 net/netfilter/nft_objref.c                                        |    8 
 net/packet/af_packet.c                                            |   16 
 net/sched/sch_netem.c                                             |   59 +-
 net/smc/af_smc.c                                                  |   73 ++-
 net/tls/tls_device.c                                              |   64 +-
 net/wireless/nl80211.c                                            |    5 
 net/xdp/xsk.c                                                     |    1 
 scripts/gcc-plugins/gcc-common.h                                  |    4 
 tools/testing/radix-tree/regression1.c                            |    2 
 tools/testing/selftests/net/fib_nexthops.sh                       |   10 
 tools/testing/selftests/net/forwarding/ethtool.sh                 |    2 
 tools/testing/selftests/net/forwarding/ethtool_extended_state.sh  |    2 
 tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh         |    2 
 tools/testing/selftests/net/forwarding/ip6_forward_instats_vrf.sh |    2 
 tools/testing/selftests/net/forwarding/lib.sh                     |   17 
 tools/testing/selftests/net/forwarding/settings                   |    1 
 tools/testing/selftests/net/forwarding/tc_flower.sh               |    8 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                   |    6 
 tools/testing/selftests/rseq/Makefile                             |    4 
 tools/testing/selftests/rseq/rseq.c                               |    2 
 189 files changed, 1975 insertions(+), 734 deletions(-)

Alan Stern (2):
      usb-storage: alauda: Fix uninit-value in alauda_check_media()
      USB: Gadget: core: Help prevent panic during UVC unconfigure

Aleksa Sarai (1):
      io_uring: correct check for O_TMPFILE

Alex Deucher (4):
      drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
      drm/amdgpu: add S/G display parameter
      drm/amd/display: fix the build when DRM_AMD_DC_DCN is not set
      drm/amd/pm/smu7: move variables to where they are used

Alexandra Diupina (1):
      scsi: 53c700: Check that command slot is not NULL

Alisa Roman (1):
      iio: adc: ad7192: Fix ac excitation feature

Alvin Lee (2):
      drm/amd/display: Disable phantom OTG after enable for plane disable
      drm/amd/display: Retain phantom plane/stream if validation fails

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

Arnd Bergmann (2):
      x86/speculation: Add cpu_show_gds() prototype
      x86: Move gds_ucode_mitigated() declaration to header

August Wikerfors (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G

Aurabindo Pillai (1):
      drm/amd/display: trigger timing sync only if TG is running

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix response to vsafe0V event

Bartosz Golaszewski (1):
      gpio: sim: mark the GPIO chip as a one that can sleep

Boris Brezillon (1):
      drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()

Borislav Petkov (AMD) (1):
      x86/sev: Do not try to parse for the CC blob on non-AMD hardware

Christoph Hellwig (2):
      btrfs: don't stop integrity writeback too early
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

Eric Dumazet (5):
      macsec: use DEV_STATS_INC()
      net/packet: annotate data-races around tp->status
      tcp: add missing family to tcp_set_ca_state() tracepoint
      dccp: fix data-race around dp->dccps_mss_cache
      sch_netem: fix issues in netem_change() vs get_dist_table()

Evan Quan (4):
      drm/amd/pm: fulfill swsmu peak profiling mode shader/memory clock settings
      drm/amd/pm: expose swctf threshold setting for legacy powerplay
      drm/amd/pm: fulfill powerplay peak profiling mode shader/memory clock settings
      drm/amd/pm: avoid unintentional shutdown due to temperature momentary fluctuation

Fedor Pchelkin (1):
      drivers: vxlan: vnifilter: free percpu vni stats on error path

Felix Fietkau (1):
      wifi: cfg80211: fix sband iftype data lookup for AP_VLAN

Florian Westphal (1):
      tunnels: fix kasan splat when generating ipv4 pmtu error

Gerd Bayer (1):
      net/smc: Use correct buffer sizes when switching between TCP and SMC

Greg Kroah-Hartman (2):
      Revert "loongarch/cpu: Switch to arch_cpu_finalize_init()"
      Linux 6.1.46

Hao Chen (1):
      net: hns3: fix strscpy causing content truncation issue

Ido Schimmel (11):
      selftests: forwarding: Set default IPv6 traceroute utility
      selftests: forwarding: Add a helper to skip test when using veth pairs
      selftests: forwarding: ethtool: Skip when using veth pairs
      selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
      selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
      selftests: forwarding: Skip test when no interfaces are specified
      selftests: forwarding: Switch off timeout
      selftests: forwarding: tc_flower: Relax success criterion
      nexthop: Fix infinite nexthop dump when using maximum nexthop ID
      nexthop: Make nexthop bucket dump more efficient
      nexthop: Fix infinite nexthop bucket dump when using maximum nexthop ID

Ilpo Järvinen (1):
      dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Jakub Kicinski (1):
      net: tls: avoid discarding data on record close

Jason A. Donenfeld (1):
      wireguard: allowedips: expand maximum node depth

Jie Wang (2):
      net: hns3: refactor hclge_mac_link_status_wait for interface reuse
      net: hns3: add wait until mac link down

Jonas Gorski (1):
      net: marvell: prestera: fix handling IPv4 routes with nhid

Josef Bacik (2):
      btrfs: wait for actual caching progress during allocation
      btrfs: set cache_block_group_error if we find an error

Karan Tilak Kumar (1):
      scsi: fnic: Replace return codes in fnic_clean_pending_aborts()

Karol Herbst (2):
      drm/nouveau/gr: enable memory loads on helper invocation on all channels
      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes

Kees Cook (1):
      gcc-plugins: Reorganize gimple includes for GCC 13

Keith Yeo (1):
      wifi: nl80211: fix integer overflow in nl80211_parse_mbssid_elems()

Kirill A. Shutemov (1):
      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Li Yang (1):
      net: phy: at803x: remove set/get wol callbacks for AR8032

Long Li (1):
      ksmbd: validate command request size

Lyude Paul (1):
      drm/nouveau/nvkm/dp: Add workaround to fix DP 1.3+ DPCD issues

Maciej Żenczykowski (1):
      ipv6: adjust ndisc_is_useropt() to also return true for PIO

Magnus Karlsson (1):
      xsk: fix refcount underflow in error path

Mario Limonciello (3):
      tpm: Disable RNG for all AMD fTPMs
      tpm: Add a helper for checking hwrng enabled
      drm/amd: Disable S/G for APUs when 64GB or more host memory

Mark Brown (1):
      selftests/rseq: Fix build with undefined __weak

Masahiro Yamada (1):
      alpha: remove __init annotation from exported page_is_ram()

Maulik Shah (1):
      cpuidle: dt_idle_genpd: Add helper function to remove genpd topology

Melissa Wen (1):
      drm/amd/display: check attr flag before set cursor degamma on DCN3+

Michael Guralnik (1):
      RDMA/umem: Set iova in ODP flow

Michael Kelley (1):
      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Mike Tipton (1):
      interconnect: qcom: Add support for mask-based BCMs

Milan Zamazal (1):
      iio: core: Prevent invalid memory access when there is no parent

Ming Lei (2):
      nvme-tcp: fix potential unbalanced freeze & unfreeze
      nvme-rdma: fix potential unbalanced freeze & unfreeze

Moshe Shemesh (2):
      net/mlx5: Skip clock update work when device is in error state
      net/mlx5: Reload auxiliary devices in pci error handlers

Namjae Jeon (1):
      ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()

Nathan Chancellor (1):
      mISDN: Update parameter type of dsp_cmx_send()

Neil Armstrong (1):
      interconnect: qcom: sm8450: add enable_mask for bcm nodes

Nick Child (5):
      ibmvnic: Enforce stronger sanity checks on login response
      ibmvnic: Unmap DMA login rsp buffer on send login fail
      ibmvnic: Handle DMA unmapping of login buffs in release functions
      ibmvnic: Do partial reset on login failure
      ibmvnic: Ensure login failure recovery is safe from other resets

Nick Desaulniers (1):
      x86/srso: Fix build breakage with the LLVM linker

Nilesh Javali (2):
      scsi: qedi: Fix firmware halt over suspend and resume
      scsi: qedf: Fix firmware halt over suspend and resume

Pablo Neira Ayuso (1):
      netfilter: nf_tables: report use refcount overflow

Paolo Abeni (2):
      mptcp: avoid bogus reset on fallback close
      mptcp: fix disconnect vs accept race

Paolo Bonzini (2):
      KVM: SEV: snapshot the GHCB before accessing it
      KVM: SEV: only access GHCB fields once

Peichen Huang (1):
      drm/amd/display: limit DPIA link rate to HBR3

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

Ricky WU (1):
      misc: rtsx: judge ASPM Mode to set PETXCFG Reg

Rodrigo Siqueira (6):
      drm/amd/display: Handle virtual hardware detect
      drm/amd/display: Add function for validate and update new stream
      drm/amd/display: Handle seamless boot stream
      drm/amd/display: Update OTG instance in the commit stream
      drm/amd/display: Avoid ABM when ODM combine is enabled for eDP
      drm/amd/display: Use update plane and stream routine for DCN32x

Ryusuke Konishi (1):
      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput

Sergei Antonov (1):
      mmc: moxart: read scr register without changing byte order

Shay Drory (1):
      net/mlx5: LAG, Check correct bucket when modifying LAG

Simon Trimmer (1):
      ACPI: scan: Create platform device for CS35L56

Souradeep Chakrabarti (1):
      net: mana: Fix MANA VF unload when hardware is unresponsive

Tao Ren (1):
      hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100

Tony Battersby (1):
      scsi: core: Fix legacy /proc parsing buffer overflow

Torsten Duwe (2):
      riscv/kexec: load initrd high in available memory
      riscv/kexec: handle R_RISCV_CALL_PLT relocation type

Vladimir Oltean (1):
      net: dsa: ocelot: call dsa_tag_8021q_unregister() under rtnl_lock() on driver remove

William Breathitt Gray (1):
      gpio: ws16c48: Fix off-by-one error in WS16C48 resource region extent

Xiang Yang (1):
      mptcp: fix the incorrect judgment for msk->cb_flags

Xu Kuohai (2):
      bpf, sockmap: Fix map type error in sock_map_del_link
      bpf, sockmap: Fix bug that strp_done cannot be called

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

