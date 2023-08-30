Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8185678DF7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbjH3TZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245322AbjH3PK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:10:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF64E8;
        Wed, 30 Aug 2023 08:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1381B81F57;
        Wed, 30 Aug 2023 15:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491BEC433C7;
        Wed, 30 Aug 2023 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407808;
        bh=NSgM1dfLPRz9F6b9veDKhe4mSpYkmJon2DztuQ0pWtE=;
        h=From:To:Cc:Subject:Date:From;
        b=giAgePG3Mes+Uyn0tP6Aw+lAbyPuYmwTS4YfOIcDaaQdWxb7FuysCGB4clLe4Zwhn
         gE1t5BntYK/WxZHBrefKyOJwrCZfmMLUSxWZ8RNXmw+BbmIhSpFgj1EBPXFyxlDodQ
         kCRXVComypfLdnwQWGkmS6YKiNDsVR45HJ4FA32o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.13
Date:   Wed, 30 Aug 2023 17:03:20 +0200
Message-ID: <2023083020-these-dander-e24d@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

I'm announcing the release of the 6.4.13 kernel.

All users of the 6.4 kernel series must upgrade.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                            |    2 
 arch/loongarch/kernel/hw_breakpoint.c                               |    3 
 arch/powerpc/mm/book3s64/subpage_prot.c                             |    1 
 arch/riscv/Kconfig                                                  |   32 -
 arch/riscv/kernel/compat_vdso/Makefile                              |    8 
 arch/riscv/mm/pageattr.c                                            |    1 
 arch/s390/mm/gmap.c                                                 |    5 
 arch/x86/kernel/fpu/context.h                                       |    3 
 arch/x86/kernel/fpu/core.c                                          |    2 
 arch/x86/kernel/fpu/xstate.c                                        |    7 
 drivers/acpi/resource.c                                             |    6 
 drivers/clk/clk-devres.c                                            |   13 
 drivers/dma-buf/sw_sync.c                                           |   18 
 drivers/gpio/gpio-sim.c                                             |   15 
 drivers/gpu/drm/drm_probe_helper.c                                  |   68 +-
 drivers/gpu/drm/i915/display/intel_display_device.c                 |   89 +++
 drivers/gpu/drm/i915/display/intel_display_device.h                 |    5 
 drivers/gpu/drm/i915/display/intel_hotplug.c                        |    4 
 drivers/gpu/drm/i915/i915_driver.c                                  |   48 +
 drivers/gpu/drm/i915/intel_device_info.c                            |   13 
 drivers/gpu/drm/panfrost/panfrost_devfreq.c                         |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                  |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                                  |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                                 |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                             |   35 -
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                                 |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c                             |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                              |    3 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c             |    2 
 drivers/net/bonding/bond_alb.c                                      |    6 
 drivers/net/can/vxcan.c                                             |    7 
 drivers/net/dsa/mt7530.c                                            |    4 
 drivers/net/dsa/mt7530.h                                            |    2 
 drivers/net/dsa/ocelot/felix_vsc9959.c                              |    3 
 drivers/net/ethernet/broadcom/bgmac.c                               |    2 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                        |    2 
 drivers/net/ethernet/broadcom/tg3.c                                 |    5 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c         |    2 
 drivers/net/ethernet/ibm/ibmveth.c                                  |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                         |    5 
 drivers/net/ethernet/intel/ice/ice_base.c                           |    3 
 drivers/net/ethernet/intel/ice/ice_sriov.c                          |    8 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                         |   34 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.h                         |    1 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                       |    1 
 drivers/net/ethernet/intel/igb/igb_ptp.c                            |   24 
 drivers/net/ethernet/intel/igc/igc_defines.h                        |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                 |    3 
 drivers/net/ethernet/mediatek/mtk_wed.c                             |   12 
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c            |    4 
 drivers/net/ethernet/mellanox/mlxsw/pci.c                           |    8 
 drivers/net/ethernet/mellanox/mlxsw/reg.h                           |    9 
 drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c             |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c        |    4 
 drivers/net/ipvlan/ipvlan_main.c                                    |    3 
 drivers/net/mdio/mdio-bitbang.c                                     |    4 
 drivers/net/veth.c                                                  |    5 
 drivers/net/wireless/intel/iwlwifi/Kconfig                          |    1 
 drivers/of/dynamic.c                                                |   31 -
 drivers/of/kexec.c                                                  |    3 
 drivers/of/unittest.c                                               |    4 
 drivers/pci/hotplug/acpiphp_glue.c                                  |    9 
 drivers/pinctrl/pinctrl-amd.c                                       |   30 +
 drivers/pinctrl/renesas/pinctrl-rza2.c                              |   17 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                             |   15 
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                             |   13 
 drivers/platform/x86/ideapad-laptop.c                               |    5 
 drivers/platform/x86/lenovo-ymc.c                                   |    7 
 drivers/scsi/raid_class.c                                           |   48 -
 drivers/scsi/snic/snic_disc.c                                       |    3 
 drivers/spi/spi-cadence.c                                           |   19 
 drivers/thunderbolt/tmu.c                                           |    3 
 drivers/tty/Kconfig                                                 |    3 
 drivers/ufs/host/ufs-qcom.c                                         |    2 
 fs/jbd2/checkpoint.c                                                |  153 ++----
 fs/jbd2/commit.c                                                    |    3 
 fs/jbd2/transaction.c                                               |   17 
 fs/nfs/direct.c                                                     |   26 -
 fs/nfs/nfs42proc.c                                                  |    5 
 fs/nfs/nfs4proc.c                                                   |   14 
 fs/nfsd/nfs4state.c                                                 |    2 
 fs/nilfs2/segment.c                                                 |    5 
 fs/proc/task_mmu.c                                                  |    5 
 include/drm/display/drm_dp.h                                        |    2 
 include/drm/drm_probe_helper.h                                      |    1 
 include/linux/clk.h                                                 |   80 +--
 include/linux/cpuset.h                                              |   12 
 include/linux/jbd2.h                                                |    7 
 include/linux/mm.h                                                  |   21 
 include/linux/mm_types.h                                            |    9 
 include/linux/pagewalk.h                                            |   11 
 include/linux/raid_class.h                                          |    4 
 include/linux/sched.h                                               |    4 
 include/linux/trace_events.h                                        |   11 
 include/net/bonding.h                                               |   11 
 include/net/inet_sock.h                                             |    2 
 include/net/ip.h                                                    |   15 
 include/net/mac80211.h                                              |    1 
 include/net/netfilter/nf_tables.h                                   |    7 
 include/net/rtnetlink.h                                             |    4 
 include/net/sock.h                                                  |    7 
 include/trace/events/jbd2.h                                         |   12 
 kernel/cgroup/cgroup.c                                              |    4 
 kernel/cgroup/cpuset.c                                              |  244 ++++++----
 kernel/sched/core.c                                                 |   41 -
 kernel/sched/deadline.c                                             |   67 ++
 kernel/sched/sched.h                                                |    2 
 kernel/trace/trace.c                                                |   15 
 kernel/trace/trace.h                                                |    8 
 kernel/trace/trace_events_synth.c                                   |  103 +---
 kernel/trace/trace_irqsoff.c                                        |    3 
 kernel/trace/trace_sched_wakeup.c                                   |    2 
 lib/clz_ctz.c                                                       |   32 -
 lib/maple_tree.c                                                    |    3 
 lib/radix-tree.c                                                    |    1 
 mm/damon/vaddr.c                                                    |    2 
 mm/gup.c                                                            |   30 -
 mm/hmm.c                                                            |    1 
 mm/huge_memory.c                                                    |    3 
 mm/internal.h                                                       |   10 
 mm/ksm.c                                                            |   25 -
 mm/madvise.c                                                        |   11 
 mm/memcontrol.c                                                     |    2 
 mm/memory-failure.c                                                 |   12 
 mm/mempolicy.c                                                      |   22 
 mm/migrate_device.c                                                 |    1 
 mm/mincore.c                                                        |    1 
 mm/mlock.c                                                          |    1 
 mm/mprotect.c                                                       |    1 
 mm/pagewalk.c                                                       |   36 +
 mm/shmem.c                                                          |    6 
 mm/vmalloc.c                                                        |    4 
 mm/vmscan.c                                                         |   14 
 net/batman-adv/bat_v_elp.c                                          |    3 
 net/batman-adv/bat_v_ogm.c                                          |    7 
 net/batman-adv/hard-interface.c                                     |   14 
 net/batman-adv/netlink.c                                            |    3 
 net/batman-adv/soft-interface.c                                     |    3 
 net/batman-adv/translation-table.c                                  |    1 
 net/batman-adv/types.h                                              |    6 
 net/can/isotp.c                                                     |   22 
 net/can/raw.c                                                       |   77 +--
 net/core/rtnetlink.c                                                |   25 -
 net/dccp/ipv4.c                                                     |    4 
 net/dccp/proto.c                                                    |   20 
 net/devlink/leftover.c                                              |    3 
 net/ipv4/af_inet.c                                                  |    2 
 net/ipv4/datagram.c                                                 |    2 
 net/ipv4/tcp_ipv4.c                                                 |    4 
 net/mac80211/rx.c                                                   |   12 
 net/netfilter/nf_tables_api.c                                       |   23 
 net/netfilter/nft_set_hash.c                                        |    3 
 net/netfilter/nft_set_pipapo.c                                      |   15 
 net/netfilter/nft_set_rbtree.c                                      |    3 
 net/sched/sch_api.c                                                 |   53 +-
 net/sctp/socket.c                                                   |    4 
 net/sunrpc/xprtrdma/verbs.c                                         |    9 
 security/selinux/ss/policydb.c                                      |    2 
 sound/pci/ymfpci/ymfpci.c                                           |   10 
 sound/soc/amd/Kconfig                                               |    1 
 sound/soc/amd/yc/acp6x-mach.c                                       |    9 
 sound/soc/codecs/cs35l41.c                                          |    2 
 sound/soc/codecs/cs35l56.c                                          |   31 -
 sound/soc/sof/ipc4-pcm.c                                            |    3 
 tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh |    4 
 tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh           |   16 
 tools/testing/selftests/mm/hmm-tests.c                              |    7 
 167 files changed, 1430 insertions(+), 931 deletions(-)

Alessio Igor Bogani (1):
      igb: Avoid starting unnecessary workqueues

Alexandre Ghiti (1):
      mm: add a call to flush_cache_vmap() in vmap_pfn()

Amit Cohen (1):
      mlxsw: Fix the size of 'VIRT_ROUTER_MSB'

Andrey Skvortsov (1):
      clk: Fix slab-out-of-bounds error in devm_clk_release()

Andrii Staikov (1):
      i40e: fix potential NULL pointer dereferencing of pf->vf i40e_sync_vsi_filters()

André Apitzsch (1):
      platform/x86: ideapad-laptop: Add support for new hotkeys found on ThinkBook 14s Yoga ITL

Ankit Nautiyal (1):
      drm/display/dp: Fix the DP DSC Receiver cap size

Anshuman Gupta (1):
      drm/i915/dgfx: Enable d3cold at s2idle

Arnd Bergmann (2):
      radix tree: remove unused variable
      ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG

Arınç ÜNAL (1):
      net: dsa: mt7530: fix handling of 802.1X PAE frames

Ayush Jain (1):
      selftests/mm: FOLL_LONGTERM need to be updated to 0x100

Bartosz Golaszewski (2):
      gpio: sim: dispose of irq mappings before destroying the irq_sim domain
      gpio: sim: pass the GPIO device's software node to irq domain

Benjamin Coddington (2):
      NFSv4: Fix dropped lock for racing OPEN and delegation return
      nfsd: Fix race to FREE_STATEID and cl_revoked

Biju Das (4):
      clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'
      pinctrl: renesas: rzg2l: Fix NULL pointer dereference in rzg2l_dt_subnode_to_map()
      pinctrl: renesas: rzv2m: Fix NULL pointer dereference in rzv2m_dt_subnode_to_map()
      pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}

BrenoRCBrito (1):
      ASoC: amd: yc: Add VivoBook Pro 15 to quirks list for acp6x

Chao Song (1):
      ASoC: SOF: ipc4-pcm: fix possible null pointer deference

Charles Keepax (1):
      ASoC: cs35l41: Correct amp_gain_tlv values

Christian Göttsche (1):
      selinux: set next pointer before attaching to list

Chuck Lever (1):
      xprtrdma: Remap Receive buffers after a reconnect

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: fix NULL pointer on hw reset

Danielle Ratson (1):
      mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC

David Hildenbrand (2):
      mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
      mm/gup: handle cont-PTE hugetlb pages correctly in gup_must_unshare() via GUP-fast

David Michael (1):
      drm/panfrost: Skip speed binning on EOPNOTSUPP

Dietmar Eggemann (2):
      sched/deadline: Create DL BW alloc, free & check overflow interface
      cgroup/cpuset: Free DL BW in case can_attach() fails

Eric Dumazet (4):
      can: raw: fix lockdep issue in raw_release()
      sock: annotate data-races around prot->memory_pressure
      dccp: annotate data-races in dccp_poll()
      ipv4: fix data-races around inet->inet_id

Fedor Pchelkin (2):
      NFSv4.2: fix error handling in nfs42_proc_getxattr
      NFSv4: fix out path in __nfs4_get_acl_uncached

Feng Tang (1):
      x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Florian Westphal (4):
      netfilter: nf_tables: validate all pending tables
      netfilter: nf_tables: fix out of memory error handling
      netfilter: nf_tables: defer gc run if previous batch is still pending
      netfilter: nf_tables: fix kdoc warnings after gc rework

Greg Kroah-Hartman (1):
      Linux 6.4.13

Günther Noack (1):
      TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig

Hangbin Liu (2):
      selftests: bonding: do not set port down before adding to bond
      bonding: fix macvlan over alb bond support

Hans de Goede (1):
      ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M

Hariprasad Kelam (1):
      octeontx2-af: SDP: fix receive link config

Helge Deller (1):
      lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Huacai Chen (1):
      LoongArch: Fix hw_breakpoint_control() for watchpoints

Hugh Dickins (1):
      shmem: fix smaps BUG sleeping while atomic

Ido Schimmel (3):
      mlxsw: reg: Fix SSPR register layout
      selftests: mlxsw: Fix test failure on Spectrum-4
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Igor Mammedov (2):
      PCI: acpiphp: Reassign resources on bridge if necessary
      PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus

Imre Deak (2):
      drm: Add an HPD poll helper to reschedule the poll work
      drm/i915: Fix HPD polling, reenabling the output poll work as needed

Jakub Kicinski (1):
      net: validate veth and vxcan peer ifindexes

Jamal Hadi Salim (1):
      net/sched: fix a qdisc modification with ambiguous command request

Jani Nikula (1):
      drm/i915: fix display probe for IVB Q and IVB D GT2 server

Jesse Brandeburg (1):
      ice: fix receive buffer size miscalculation

Jiri Pirko (1):
      devlink: add missing unregister linecard notification

Juri Lelli (4):
      cgroup/cpuset: Rename functions dealing with DEADLINE accounting
      sched/cpuset: Bring back cpuset_mutex
      sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
      cgroup/cpuset: Iterate only if DEADLINE tasks are present

Kees Cook (1):
      tg3: Use slab_build_skb() when needed

Liam R. Howlett (1):
      maple_tree: disable mas_wr_append() when other readers are possible

Lu Wei (1):
      ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()

Maciej Strozek (1):
      ASoC: cs35l56: Read firmware uuid from a device property instead of _SUB

Mario Limonciello (2):
      pinctrl: amd: Mask wake bits on probe again
      ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ

Matt Roper (2):
      drm/i915/display: Handle GMD_ID identification in display code
      drm/i915: Fix error handling if driver creation fails during probe

Miaohe Lin (1):
      mm: memory-failure: fix unexpected return value in soft_offline_page()

Michael Ellerman (1):
      ibmveth: Use dcbf rather than dcbfl

Mingzheng Xing (2):
      riscv: Handle zicsr/zifencei issue between gcc and binutils
      riscv: Fix build errors using binutils2.37 toolchains

Neil Armstrong (1):
      scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW major version > 5

Oliver Hartkopp (2):
      can: isotp: fix support for transmission of SF without flow control
      can: raw: add missing refcount for memory leak fix

Pablo Neira Ayuso (3):
      netfilter: nf_tables: flush pending destroy work before netlink notifier
      netfilter: nf_tables: GC transaction race with abort path
      netfilter: nf_tables: use correct lock to protect gc_list

Petr Oros (2):
      Revert "ice: Fix ice VF reset during iavf initialization"
      ice: Fix NULL pointer deref during VF reset

Ping-Ke Shih (1):
      wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning

Randy Dunlap (1):
      wifi: iwlwifi: mvm: add dependency for PTP clock

Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_packet
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Rick Edgecombe (1):
      x86/fpu: Invalidate FPU state correctly on exec()

Rik van Riel (1):
      mm,ima,kexec,of: use memblock_free_late from ima_free_kexec_buffer

Rob Clark (1):
      dma-buf/sw_sync: Avoid recursive lock during fence signal

Rob Herring (2):
      of: unittest: Fix EXPECT for parse_phandle_with_args_map() test
      of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock

Ruan Jinjie (2):
      net: bgmac: Fix return value check for fixed_phy_register()
      net: bcmgenet: Fix return value check for fixed_phy_register()

Ryusuke Konishi (1):
      nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()

Sanjay R Mehta (1):
      thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd hot plug onwards

Sasha Neftin (1):
      igc: Fix the typo in the PTM Control macro

Serge Semin (1):
      net: mdio: mdio-bitbang: Fix C45 read/write protocol

Srinivas Goud (1):
      spi: spi-cadence: Fix data corruption issues in slave mode

Suren Baghdasaryan (1):
      mm: enable page walking API to lock vmas during the walk

Sven Eckelmann (3):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user
      batman-adv: Hold rtnl lock during MTU update via netlink

Sven Schnelle (3):
      tracing/synthetic: Use union instead of casts
      tracing/synthetic: Skip first entry for stack traces
      tracing/synthetic: Allocate one additional element for size

Swapnil Devesh (1):
      platform/x86: lenovo-ymc: Add Lenovo Yoga 7 14ACN6 to ec_trigger_quirk_dmi_table

T.J. Mercier (1):
      mm: multi-gen LRU: don't spin during memcg release

Takashi Iwai (1):
      ALSA: ymfpci: Fix the missing snd_card_free() call at probe error

Trond Myklebust (1):
      NFS: Fix a use after free in nfs_direct_join_group()

Vladimir Oltean (1):
      net: dsa: felix: fix oversize frame dropping for always closed tc-taprio gates

Wei Chen (1):
      media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

Yin Fengwei (2):
      madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check
      madvise:madvise_free_pte_range(): don't use mapcount() against large folio for sharing check

Zack Rusin (2):
      drm/vmwgfx: Fix shader stage validation
      drm/vmwgfx: Fix possible invalid drm gem put calls

Zhang Yi (3):
      jbd2: remove t_checkpoint_io_list
      jbd2: remove journal_clean_one_cp_list()
      jbd2: fix a race when checking checkpoint buffer busy

Zheng Yejian (2):
      tracing: Fix cpu buffers unavailable due to 'record_disabled' missed
      tracing: Fix memleak due to race between current_tracer and trace

Zhu Wang (2):
      scsi: snic: Fix double free in snic_tgt_create()
      scsi: core: raid_class: Remove raid_component_add()

Ziyang Xuan (1):
      can: raw: fix receiver memory leak

