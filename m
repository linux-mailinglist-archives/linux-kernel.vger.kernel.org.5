Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525A78DB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbjH3SkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245311AbjH3PI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:08:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373C1A2;
        Wed, 30 Aug 2023 08:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C1C5B81F73;
        Wed, 30 Aug 2023 15:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE9C433C8;
        Wed, 30 Aug 2023 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407797;
        bh=aR1gZXpBHvaBixJdtQjTrpSqogBmLdYimoYp+CDXO+A=;
        h=From:To:Cc:Subject:Date:From;
        b=OS2rFQDLyOMk+zyHWdQSxedeH9iXbIeso/LhkuVkm9irSO0yiza0Dfz7lgVt7x01Q
         lEm60ZYAeIO8/kqgiGWPq3Th6e+ZQPecP08BUZtnjkhrNG6EFpoWw5TLaTM/bcWtlh
         U6dN3cG3BPXy17YQrH1rx8I8/4UIK/uVKqo94grE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.50
Date:   Wed, 30 Aug 2023 17:03:13 +0200
Message-ID: <2023083013-dry-transform-5697@gregkh>
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

I'm announcing the release of the 6.1.50 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 MAINTAINERS                                                         |    2 
 Makefile                                                            |    2 
 arch/mips/include/asm/cpu-features.h                                |   21 
 arch/riscv/Kconfig                                                  |   28 
 arch/riscv/kernel/compat_vdso/Makefile                              |    8 
 arch/x86/kernel/fpu/context.h                                       |    3 
 arch/x86/kernel/fpu/core.c                                          |    2 
 arch/x86/kernel/fpu/xstate.c                                        |    7 
 arch/x86/kvm/mmu/mmu.c                                              |    3 
 arch/x86/kvm/mmu/tdp_mmu.c                                          |  121 
 drivers/block/ublk_drv.c                                            |    3 
 drivers/clk/clk-devres.c                                            |   13 
 drivers/dma-buf/sw_sync.c                                           |   18 
 drivers/gpio/gpio-sim.c                                             |   15 
 drivers/gpu/drm/arm/hdlcd_drv.c                                     |    2 
 drivers/gpu/drm/armada/armada_drv.c                                 |    2 
 drivers/gpu/drm/ast/ast_drv.c                                       |   16 
 drivers/gpu/drm/drm_aperture.c                                      |   11 
 drivers/gpu/drm/gma500/psb_drv.c                                    |    9 
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c                             |    1 
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c                            |   95 
 drivers/gpu/drm/i915/gt/gen8_engine_cs.h                            |    3 
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h                        |    1 
 drivers/gpu/drm/i915/gt/intel_lrc.c                                 |   17 
 drivers/gpu/drm/i915/i915_driver.c                                  |   33 
 drivers/gpu/drm/meson/meson_drv.c                                   |    2 
 drivers/gpu/drm/msm/msm_fbdev.c                                     |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c                         |    2 
 drivers/gpu/drm/stm/drv.c                                           |    2 
 drivers/gpu/drm/sun4i/sun4i_drv.c                                   |    2 
 drivers/gpu/drm/tegra/drm.c                                         |    2 
 drivers/gpu/drm/vc4/vc4_drv.c                                       |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                                 |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                             |   29 
 drivers/hwmon/aquacomputer_d5next.c                                 |   36 
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c             |    2 
 drivers/net/bonding/bond_alb.c                                      |    6 
 drivers/net/can/vxcan.c                                             |    7 
 drivers/net/dsa/mt7530.c                                            |    4 
 drivers/net/dsa/mt7530.h                                            |    2 
 drivers/net/dsa/ocelot/felix_vsc9959.c                              |    3 
 drivers/net/ethernet/broadcom/bgmac.c                               |    2 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                        |    2 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c         |    2 
 drivers/net/ethernet/ibm/ibmveth.c                                  |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                         |    5 
 drivers/net/ethernet/intel/ice/ice_base.c                           |    3 
 drivers/net/ethernet/intel/ice/ice_sriov.c                          |    8 
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                         |   34 
 drivers/net/ethernet/intel/ice/ice_vf_lib.h                         |    1 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                       |    1 
 drivers/net/ethernet/intel/igb/igb_ptp.c                            |   24 
 drivers/net/ethernet/intel/igc/igc_defines.h                        |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                 |    3 
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c            |    4 
 drivers/net/ethernet/mellanox/mlxsw/pci.c                           |    8 
 drivers/net/ethernet/mellanox/mlxsw/reg.h                           |    9 
 drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c             |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c        |    4 
 drivers/net/ipvlan/ipvlan_main.c                                    |    3 
 drivers/net/veth.c                                                  |    5 
 drivers/of/dynamic.c                                                |   31 
 drivers/of/kexec.c                                                  |    3 
 drivers/of/unittest.c                                               |    4 
 drivers/pci/hotplug/acpiphp_glue.c                                  |    9 
 drivers/pinctrl/pinctrl-amd.c                                       |   30 
 drivers/pinctrl/renesas/pinctrl-rza2.c                              |   17 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                             |   15 
 drivers/pinctrl/renesas/pinctrl-rzv2m.c                             |   13 
 drivers/platform/x86/ideapad-laptop.c                               |    5 
 drivers/s390/crypto/zcrypt_msgtype6.c                               |   47 
 drivers/scsi/raid_class.c                                           |   48 
 drivers/scsi/snic/snic_disc.c                                       |    3 
 drivers/thunderbolt/tmu.c                                           |    3 
 drivers/video/aperture.c                                            |   31 
 drivers/video/fbdev/aty/radeon_base.c                               |   10 
 fs/attr.c                                                           |    1 
 fs/internal.h                                                       |    2 
 fs/jbd2/checkpoint.c                                                |  153 
 fs/jbd2/commit.c                                                    |    3 
 fs/jbd2/transaction.c                                               |   17 
 fs/nfs/direct.c                                                     |   26 
 fs/nfs/inode.c                                                      |    4 
 fs/nfs/nfs42proc.c                                                  |    5 
 fs/nfs/nfs4proc.c                                                   |   14 
 fs/nfsd/nfs4state.c                                                 |    2 
 fs/nfsd/vfs.c                                                       |    4 
 include/drm/display/drm_dp.h                                        |    2 
 include/drm/drm_aperture.h                                          |    7 
 include/linux/clk.h                                                 |   80 
 include/linux/cpuset.h                                              |   12 
 include/linux/fs.h                                                  |    2 
 include/linux/jbd2.h                                                |    7 
 include/linux/mm.h                                                  |   29 
 include/linux/raid_class.h                                          |    4 
 include/linux/sched.h                                               |    4 
 include/net/bonding.h                                               |   11 
 include/net/inet_sock.h                                             |    2 
 include/net/ip.h                                                    |   15 
 include/net/mac80211.h                                              |    1 
 include/net/rtnetlink.h                                             |    4 
 include/net/sock.h                                                  |    7 
 include/trace/events/jbd2.h                                         |   12 
 io_uring/msg_ring.c                                                 |  140 
 io_uring/msg_ring.h                                                 |    1 
 io_uring/opdef.c                                                    |    1 
 kernel/cgroup/cgroup.c                                              |    4 
 kernel/cgroup/cpuset.c                                              |  246 
 kernel/sched/core.c                                                 |   41 
 kernel/sched/deadline.c                                             |   67 
 kernel/sched/sched.h                                                |    2 
 kernel/trace/trace.c                                                |   15 
 kernel/trace/trace_irqsoff.c                                        |    3 
 kernel/trace/trace_sched_wakeup.c                                   |    2 
 lib/clz_ctz.c                                                       |   32 
 lib/maple_tree.c                                                    |    3 
 lib/radix-tree.c                                                    |    1 
 mm/madvise.c                                                        |    4 
 mm/memory-failure.c                                                 |   11 
 mm/shmem.c                                                          |    6 
 mm/vmalloc.c                                                        |    4 
 net/Makefile                                                        |    1 
 net/batman-adv/bat_v_elp.c                                          |    3 
 net/batman-adv/bat_v_ogm.c                                          |    7 
 net/batman-adv/hard-interface.c                                     |   14 
 net/batman-adv/netlink.c                                            |    3 
 net/batman-adv/soft-interface.c                                     |    3 
 net/batman-adv/translation-table.c                                  |    1 
 net/batman-adv/types.h                                              |    6 
 net/can/isotp.c                                                     |   22 
 net/can/raw.c                                                       |   77 
 net/core/Makefile                                                   |    1 
 net/core/devlink.c                                                  |12547 ---------
 net/core/rtnetlink.c                                                |   25 
 net/dccp/ipv4.c                                                     |    4 
 net/dccp/proto.c                                                    |   20 
 net/devlink/Makefile                                                |    3 
 net/devlink/leftover.c                                              |12550 ++++++++++
 net/ipv4/af_inet.c                                                  |    2 
 net/ipv4/datagram.c                                                 |    2 
 net/ipv4/tcp_ipv4.c                                                 |    4 
 net/mac80211/rx.c                                                   |   12 
 net/netfilter/nf_tables_api.c                                       |    2 
 net/netfilter/nft_set_pipapo.c                                      |   13 
 net/sched/sch_api.c                                                 |   53 
 net/sctp/socket.c                                                   |    4 
 net/sunrpc/xprtrdma/verbs.c                                         |    9 
 security/selinux/ss/policydb.c                                      |    2 
 sound/pci/ymfpci/ymfpci.c                                           |   10 
 sound/soc/amd/Kconfig                                               |    1 
 sound/soc/amd/yc/acp6x-mach.c                                       |    9 
 sound/soc/codecs/cs35l41.c                                          |    2 
 tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh |    4 
 tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh           |   16 
 tools/testing/selftests/net/Makefile                                |   50 
 tools/testing/selftests/net/bpf/Makefile                            |   14 
 tools/testing/selftests/net/bpf/nat6to4.c                           |  285 
 tools/testing/selftests/net/nat6to4.c                               |  285 
 tools/testing/selftests/net/udpgro_frglist.sh                       |    8 
 159 files changed, 14188 insertions(+), 13843 deletions(-)

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report

Alessio Igor Bogani (1):
      igb: Avoid starting unnecessary workqueues

Alexandre Ghiti (1):
      mm: add a call to flush_cache_vmap() in vmap_pfn()

Amit Cohen (1):
      mlxsw: Fix the size of 'VIRT_ROUTER_MSB'

Andi Shyti (2):
      drm/i915: Add the gen12_needs_ccs_aux_inv helper
      drm/i915/gt: Support aux invalidation on all engines

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

Charles Keepax (1):
      ASoC: cs35l41: Correct amp_gain_tlv values

Christian Brauner (2):
      nfs: use vfs setgid helper
      nfsd: use vfs setgid helper

Christian Göttsche (1):
      selinux: set next pointer before attaching to list

Chuck Lever (1):
      xprtrdma: Remap Receive buffers after a reconnect

Daniel Vetter (6):
      drm/ast: Use drm_aperture_remove_conflicting_pci_framebuffers
      fbdev/radeon: use pci aperture helpers
      drm/gma500: Use drm_aperture_remove_conflicting_pci_framebuffers
      drm/aperture: Remove primary argument
      video/aperture: Only kick vgacon when the pdev is decoding vga
      video/aperture: Move vga handling to pci function

Danielle Ratson (1):
      mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC

David Hildenbrand (1):
      mm/gup: handle cont-PTE hugetlb pages correctly in gup_must_unshare() via GUP-fast

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

Florian Westphal (1):
      netfilter: nf_tables: fix out of memory error handling

Greg Kroah-Hartman (1):
      Linux 6.1.50

Hangbin Liu (3):
      selftests: bonding: do not set port down before adding to bond
      bonding: fix macvlan over alb bond support
      selftests/net: mv bpf/nat6to4.c to net folder

Harald Freudenberger (1):
      s390/zcrypt: fix reply buffer calculations for CCA replies

Hariprasad Kelam (1):
      octeontx2-af: SDP: fix receive link config

Helge Deller (1):
      lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Hugh Dickins (1):
      shmem: fix smaps BUG sleeping while atomic

Ido Schimmel (3):
      mlxsw: reg: Fix SSPR register layout
      selftests: mlxsw: Fix test failure on Spectrum-4
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Igor Mammedov (2):
      PCI: acpiphp: Reassign resources on bridge if necessary
      PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus

Jakub Kicinski (2):
      devlink: move code to a dedicated directory
      net: validate veth and vxcan peer ifindexes

Jamal Hadi Salim (1):
      net/sched: fix a qdisc modification with ambiguous command request

Jens Axboe (2):
      io_uring/msg_ring: move double lock/unlock helpers higher up
      io_uring/msg_ring: fix missing lock on overflow for IOPOLL

Jesse Brandeburg (1):
      ice: fix receive buffer size miscalculation

Jiaxun Yang (2):
      MIPS: cpu-features: Enable octeon_cache by cpu_type
      MIPS: cpu-features: Use boot_cpu_type for CPU type based features

Jiri Pirko (1):
      devlink: add missing unregister linecard notification

Jonathan Cavitt (2):
      drm/i915/gt: Ensure memory quiesced before invalidation
      drm/i915/gt: Poll aux invalidation register bit on invalidation

Juri Lelli (4):
      cgroup/cpuset: Rename functions dealing with DEADLINE accounting
      sched/cpuset: Bring back cpuset_mutex
      sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
      cgroup/cpuset: Iterate only if DEADLINE tasks are present

Liam R. Howlett (1):
      maple_tree: disable mas_wr_append() when other readers are possible

Lu Wei (1):
      ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()

Mario Limonciello (2):
      pinctrl: amd: Mask wake bits on probe again
      ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ

Miaohe Lin (1):
      mm: memory-failure: fix unexpected return value in soft_offline_page()

Michael Ellerman (1):
      ibmveth: Use dcbf rather than dcbfl

Ming Lei (1):
      ublk: remove check IO_URING_F_SQE128 in ublk_ch_uring_cmd

Mingzheng Xing (2):
      riscv: Handle zicsr/zifencei issue between gcc and binutils
      riscv: Fix build errors using binutils2.37 toolchains

Oliver Hartkopp (2):
      can: isotp: fix support for transmission of SF without flow control
      can: raw: add missing refcount for memory leak fix

Pablo Neira Ayuso (1):
      netfilter: nf_tables: flush pending destroy work before netlink notifier

Pavel Begunkov (2):
      io_uring: get rid of double locking
      io_uring: extract a io_msg_install_complete helper

Petr Oros (2):
      Revert "ice: Fix ice VF reset during iavf initialization"
      ice: Fix NULL pointer deref during VF reset

Ping-Ke Shih (1):
      wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning

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

Sanjay R Mehta (1):
      thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd hot plug onwards

Sasha Neftin (1):
      igc: Fix the typo in the PTM Control macro

Sean Christopherson (2):
      KVM: x86: Preserve TDP MMU roots until they are explicitly invalidated
      KVM: x86/mmu: Fix an sign-extension bug with mmu_seq that hangs vCPUs

Sven Eckelmann (3):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user
      batman-adv: Hold rtnl lock during MTU update via netlink

Takashi Iwai (1):
      ALSA: ymfpci: Fix the missing snd_card_free() call at probe error

Trond Myklebust (1):
      NFS: Fix a use after free in nfs_direct_join_group()

Vladimir Oltean (1):
      net: dsa: felix: fix oversize frame dropping for always closed tc-taprio gates

Wei Chen (1):
      media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

Yin Fengwei (1):
      madvise:madvise_free_pte_range(): don't use mapcount() against large folio for sharing check

Yu Zhe (1):
      s390/zcrypt: remove unnecessary (void *) conversions

Zack Rusin (1):
      drm/vmwgfx: Fix shader stage validation

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

