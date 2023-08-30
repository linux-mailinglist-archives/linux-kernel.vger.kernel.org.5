Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DC78DAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbjH3Sgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245286AbjH3PDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB681A2;
        Wed, 30 Aug 2023 08:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81A276254B;
        Wed, 30 Aug 2023 15:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E21DC433C7;
        Wed, 30 Aug 2023 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407824;
        bh=DeWM7a4b/E1c+5EIIo3FC3nMSChNnL+1qogmuBImnWU=;
        h=From:To:Cc:Subject:Date:From;
        b=T0ajV3J1KdvjYFXoPnbov9sEKtJ1/YcUjAjTlcZgPX0lG0cxILMeUb/LjHfgQSfQi
         RwAeaL0SCVbsx+RwPI67eGkrJDaHIP/WrfEkyH5PabxRMZbNm1YAJHU8Z3BkRkbMck
         1/2hpnABGXFQyr0QqB/qP4Wj0zP1j5ur6SxEekkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.193
Date:   Wed, 30 Aug 2023 17:03:29 +0200
Message-ID: <2023083030-cryptic-sultry-b7bf@gregkh>
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

I'm announcing the release of the 5.10.193 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/mips/include/asm/cpu-features.h                      |   21 +
 arch/x86/kernel/fpu/xstate.c                              |    8 
 drivers/block/rbd.c                                       |  139 ++++++++----
 drivers/clk/clk-devres.c                                  |   13 -
 drivers/dma-buf/sw_sync.c                                 |   18 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |    4 
 drivers/gpu/drm/i915/i915_active.c                        |   99 ++++++--
 drivers/gpu/drm/i915/i915_request.c                       |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                       |   13 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                   |   29 --
 drivers/md/dm-integrity.c                                 |    4 
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c        |    2 
 drivers/net/bonding/bond_alb.c                            |    6 
 drivers/net/can/vxcan.c                                   |    7 
 drivers/net/ethernet/broadcom/bgmac.c                     |    2 
 drivers/net/ethernet/broadcom/genet/bcmmii.c              |    2 
 drivers/net/ethernet/ibm/ibmveth.c                        |    2 
 drivers/net/ethernet/intel/ice/ice_base.c                 |    3 
 drivers/net/ethernet/intel/igb/igb_ptp.c                  |   24 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c       |    3 
 drivers/net/ipvlan/ipvlan_main.c                          |    3 
 drivers/net/veth.c                                        |    5 
 drivers/of/dynamic.c                                      |   31 --
 drivers/pci/hotplug/acpiphp_glue.c                        |    9 
 drivers/pinctrl/renesas/pinctrl-rza2.c                    |   17 +
 drivers/scsi/raid_class.c                                 |   48 ----
 drivers/scsi/snic/snic_disc.c                             |    3 
 drivers/video/fbdev/core/sysimgblt.c                      |   64 ++++-
 fs/dlm/lock.c                                             |   53 ++--
 fs/dlm/plock.c                                            |   89 +++++--
 fs/dlm/recover.c                                          |   39 +--
 fs/nfs/direct.c                                           |   26 +-
 fs/nfs/nfs4proc.c                                         |   14 -
 fs/nfsd/nfs4state.c                                       |    2 
 include/drm/drm_dp_helper.h                               |    2 
 include/linux/ceph/msgr.h                                 |    9 
 include/linux/clk.h                                       |   80 +++---
 include/linux/cpuset.h                                    |   12 -
 include/linux/raid_class.h                                |    4 
 include/linux/sched.h                                     |    4 
 include/net/bonding.h                                     |   25 --
 include/net/rtnetlink.h                                   |    4 
 include/net/sock.h                                        |    7 
 kernel/cgroup/cgroup.c                                    |    4 
 kernel/cgroup/cpuset.c                                    |  161 ++++++++++----
 kernel/sched/core.c                                       |   41 +--
 kernel/sched/deadline.c                                   |   66 ++++-
 kernel/sched/sched.h                                      |    2 
 kernel/time/tick-sched.c                                  |   29 ++
 kernel/time/tick-sched.h                                  |    4 
 kernel/torture.c                                          |    2 
 kernel/trace/trace.c                                      |   15 +
 kernel/trace/trace_irqsoff.c                              |    3 
 kernel/trace/trace_sched_wakeup.c                         |    2 
 lib/clz_ctz.c                                             |   32 --
 lib/radix-tree.c                                          |    1 
 mm/memory-failure.c                                       |  136 +++++------
 mm/vmalloc.c                                              |    4 
 net/batman-adv/bat_v_elp.c                                |    3 
 net/batman-adv/bat_v_ogm.c                                |    7 
 net/batman-adv/hard-interface.c                           |   14 +
 net/batman-adv/netlink.c                                  |    3 
 net/batman-adv/soft-interface.c                           |    3 
 net/batman-adv/translation-table.c                        |    1 
 net/batman-adv/types.h                                    |    6 
 net/ceph/mon_client.c                                     |    6 
 net/core/rtnetlink.c                                      |   43 +++
 net/dccp/proto.c                                          |   20 +
 net/netfilter/nft_set_pipapo.c                            |   13 -
 net/sched/sch_api.c                                       |   53 +++-
 net/sctp/socket.c                                         |    2 
 net/sunrpc/xprtrdma/verbs.c                               |    9 
 security/selinux/ss/policydb.c                            |    2 
 sound/core/pcm_memory.c                                   |   44 +++
 sound/soc/codecs/rt711-sdw.h                              |    2 
 sound/soc/codecs/rt711.c                                  |   30 ++
 sound/soc/codecs/rt711.h                                  |   29 ++
 sound/soc/intel/boards/sof_sdw.c                          |   23 +-
 sound/soc/intel/boards/sof_sdw_common.h                   |    5 
 tools/objtool/arch.h                                      |    1 
 tools/objtool/arch/x86/decode.c                           |   11 
 tools/objtool/check.c                                     |   22 +
 tools/objtool/elf.h                                       |    1 
 84 files changed, 1140 insertions(+), 668 deletions(-)

Alessio Igor Bogani (1):
      igb: Avoid starting unnecessary workqueues

Alexander Aring (5):
      dlm: improve plock logging if interrupted
      fs: dlm: add pid to debug log
      fs: dlm: change plock interrupted message to debug again
      fs: dlm: use dlm_plock_info for do_unlock_close
      fs: dlm: fix mismatch of plock results from userspace

Alexandre Ghiti (1):
      mm: add a call to flush_cache_vmap() in vmap_pfn()

Andrey Skvortsov (1):
      clk: Fix slab-out-of-bounds error in devm_clk_release()

Ankit Nautiyal (1):
      drm/display/dp: Fix the DP DSC Receiver cap size

Arnd Bergmann (1):
      radix tree: remove unused variable

Bard Liao (1):
      ASoC: Intel: sof_sdw: include rt711.h for RT711 JD mode

Benjamin Coddington (2):
      NFSv4: Fix dropped lock for racing OPEN and delegation return
      nfsd: Fix race to FREE_STATEID and cl_revoked

Biju Das (2):
      clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'
      pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}

Christian Göttsche (1):
      selinux: set next pointer before attaching to list

Chuck Lever (1):
      xprtrdma: Remap Receive buffers after a reconnect

Dan Williams (1):
      mm: fix page reference leak in soft_offline_page()

Dietmar Eggemann (2):
      sched/deadline: Create DL BW alloc, free & check overflow interface
      cgroup/cpuset: Free DL BW in case can_attach() fails

Eric Dumazet (2):
      sock: annotate data-races around prot->memory_pressure
      dccp: annotate data-races in dccp_poll()

Fedor Pchelkin (1):
      NFSv4: fix out path in __nfs4_get_acl_uncached

Feng Tang (1):
      x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Florent Fourcot (1):
      rtnetlink: return ENODEV when ifname does not exist and group is given

Florian Westphal (1):
      netfilter: nf_tables: fix out of memory error handling

Frederic Weisbecker (1):
      tick: Detect and fix jiffies update stall

Greg Kroah-Hartman (1):
      Linux 5.10.193

Hangbin Liu (1):
      bonding: fix macvlan over alb bond support

Hariprasad Kelam (1):
      octeontx2-af: SDP: fix receive link config

Helge Deller (1):
      lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Ido Schimmel (1):
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Igor Mammedov (2):
      PCI: acpiphp: Reassign resources on bridge if necessary
      PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus

Ilya Dryomov (4):
      libceph, rbd: ignore addr->type while comparing in some cases
      rbd: make get_lock_owner_info() return a single locker or NULL
      rbd: retrieve and check lock owner twice before blocklisting
      rbd: prevent busy loop when requesting exclusive lock

Jakob Koschel (1):
      dlm: replace usage of found with dedicated list iterator variable

Jakub Kicinski (2):
      net: validate veth and vxcan peer ifindexes
      net: remove bond_slave_has_mac_rcu()

Jamal Hadi Salim (1):
      net/sched: fix a qdisc modification with ambiguous command request

Janusz Krzysztofik (1):
      drm/i915: Fix premature release of request's reusable memory

Jesse Brandeburg (1):
      ice: fix receive buffer size miscalculation

Jiaxun Yang (2):
      MIPS: cpu-features: Enable octeon_cache by cpu_type
      MIPS: cpu-features: Use boot_cpu_type for CPU type based features

Joel Fernandes (Google) (1):
      torture: Fix hang during kthread shutdown phase

Josip Pavic (1):
      drm/amd/display: do not wait for mpc idle if tg is disabled

Juri Lelli (4):
      cgroup/cpuset: Rename functions dealing with DEADLINE accounting
      sched/cpuset: Bring back cpuset_mutex
      sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
      cgroup/cpuset: Iterate only if DEADLINE tasks are present

Kefeng Wang (1):
      mm: memory-failure: kill soft_offline_free_page()

Lu Wei (1):
      ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()

Miaohe Lin (1):
      mm: memory-failure: fix unexpected return value in soft_offline_page()

Michael Ellerman (1):
      ibmveth: Use dcbf rather than dcbfl

Mikulas Patocka (2):
      dm integrity: increase RECALC_SECTORS to improve recalculate speed
      dm integrity: reduce vmalloc space footprint on 32-bit architectures

Nicholas Piggin (1):
      timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped

Oscar Salvador (2):
      mm,hwpoison: refactor get_any_page
      mm,hwpoison: fix printing of page flags

Peter Zijlstra (1):
      objtool/x86: Fix SRSO mess

Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_packet
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Rob Clark (1):
      dma-buf/sw_sync: Avoid recursive lock during fence signal

Rob Herring (1):
      of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock

Ruan Jinjie (2):
      net: bgmac: Fix return value check for fixed_phy_register()
      net: bcmgenet: Fix return value check for fixed_phy_register()

Shuming Fan (1):
      ASoC: rt711: add two jack detection modes

Sven Eckelmann (3):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user
      batman-adv: Hold rtnl lock during MTU update via netlink

Taimur Hassan (1):
      drm/amd/display: check TG is non-null before checking if enabled

Takashi Iwai (1):
      ALSA: pcm: Fix potential data race at PCM memory allocation helpers

Thomas Zimmermann (2):
      fbdev: Improve performance of sys_imageblit()
      fbdev: Fix sys_imageblit() for arbitrary image widths

Trond Myklebust (1):
      NFS: Fix a use after free in nfs_direct_join_group()

Wei Chen (1):
      media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

Zack Rusin (1):
      drm/vmwgfx: Fix shader stage validation

Zhang Shurong (1):
      fbdev: fix potential OOB read in fast_imageblit()

Zheng Yejian (2):
      tracing: Fix cpu buffers unavailable due to 'record_disabled' missed
      tracing: Fix memleak due to race between current_tracer and trace

Zhu Wang (2):
      scsi: snic: Fix double free in snic_tgt_create()
      scsi: core: raid_class: Remove raid_component_add()

