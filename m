Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7478DE59
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbjH3TBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245288AbjH3PDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:03:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA4AC;
        Wed, 30 Aug 2023 08:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E6E76252E;
        Wed, 30 Aug 2023 15:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B74CC433C7;
        Wed, 30 Aug 2023 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407828;
        bh=mFtXE+uO2pbzgAlnIcP7ILqfk5llsdORSRwZ24L/yM0=;
        h=From:To:Cc:Subject:Date:From;
        b=gezLn4H/zLS3d1Epc4zDcl1X5gJjZCEMjP4Zk8x/h/HQMg+DpE9qG8BWXVXMVylFd
         xV6xumIEYCq+mywFMUMHTvGxYMhEIm9HN0erKLynmJpMEiTXO24pHO8UHY60Je7yxJ
         a3drN0PRc4h/NEP/QEHwY7Dt2fgmt8zLkXWhr12s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.129
Date:   Wed, 30 Aug 2023 17:03:37 +0200
Message-ID: <2023083037-fringe-slacks-65d1@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.129 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/mips/include/asm/cpu-features.h                      |   21 +
 arch/x86/include/asm/fpu/internal.h                       |    3 
 arch/x86/kernel/fpu/core.c                                |    2 
 arch/x86/kernel/fpu/xstate.c                              |    7 
 arch/x86/kvm/mmu/tdp_mmu.c                                |    2 
 drivers/clk/clk-devres.c                                  |   13 
 drivers/dma-buf/sw_sync.c                                 |   18 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |    4 
 drivers/gpu/drm/i915/i915_active.c                        |   99 ++++-
 drivers/gpu/drm/i915/i915_request.c                       |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                       |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                   |   29 -
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c        |    2 
 drivers/net/bonding/bond_alb.c                            |    6 
 drivers/net/can/vxcan.c                                   |    7 
 drivers/net/ethernet/broadcom/bgmac.c                     |    2 
 drivers/net/ethernet/broadcom/genet/bcmmii.c              |    2 
 drivers/net/ethernet/ibm/ibmveth.c                        |    2 
 drivers/net/ethernet/intel/ice/ice_base.c                 |    3 
 drivers/net/ethernet/intel/igb/igb_ptp.c                  |   24 -
 drivers/net/ethernet/intel/igc/igc_defines.h              |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c       |    3 
 drivers/net/ipvlan/ipvlan_main.c                          |    3 
 drivers/net/veth.c                                        |    5 
 drivers/of/dynamic.c                                      |   31 -
 drivers/of/kexec.c                                        |    4 
 drivers/of/unittest.c                                     |    4 
 drivers/pci/hotplug/acpiphp_glue.c                        |    9 
 drivers/pinctrl/renesas/pinctrl-rza2.c                    |   17 -
 drivers/scsi/raid_class.c                                 |   48 --
 drivers/scsi/snic/snic_disc.c                             |    3 
 drivers/video/fbdev/core/sysimgblt.c                      |   64 +++
 fs/attr.c                                                 |    1 
 fs/dlm/lock.c                                             |   53 +--
 fs/dlm/plock.c                                            |   89 +++--
 fs/dlm/recover.c                                          |   39 +-
 fs/internal.h                                             |    2 
 fs/jbd2/checkpoint.c                                      |  153 +++------
 fs/jbd2/commit.c                                          |    3 
 fs/jbd2/transaction.c                                     |   17 -
 fs/nfs/direct.c                                           |   26 -
 fs/nfs/inode.c                                            |    4 
 fs/nfs/nfs42proc.c                                        |    5 
 fs/nfs/nfs4proc.c                                         |   14 
 fs/nfsd/nfs4state.c                                       |    2 
 fs/nfsd/vfs.c                                             |    4 
 include/drm/drm_dp_helper.h                               |    2 
 include/linux/clk.h                                       |   80 ++--
 include/linux/cpuset.h                                    |   12 
 include/linux/fs.h                                        |    2 
 include/linux/jbd2.h                                      |    7 
 include/linux/raid_class.h                                |    4 
 include/linux/sched.h                                     |    4 
 include/net/bonding.h                                     |   25 -
 include/net/rtnetlink.h                                   |    4 
 include/net/sock.h                                        |    7 
 include/trace/events/jbd2.h                               |   12 
 kernel/cgroup/cgroup.c                                    |    4 
 kernel/cgroup/cpuset.c                                    |  232 +++++++++-----
 kernel/sched/core.c                                       |   41 +-
 kernel/sched/deadline.c                                   |   66 +++
 kernel/sched/sched.h                                      |    2 
 kernel/torture.c                                          |    2 
 kernel/trace/trace.c                                      |   15 
 kernel/trace/trace_irqsoff.c                              |    3 
 kernel/trace/trace_sched_wakeup.c                         |    2 
 lib/clz_ctz.c                                             |   32 -
 lib/radix-tree.c                                          |    1 
 mm/memory-failure.c                                       |   21 -
 mm/vmalloc.c                                              |    4 
 net/batman-adv/bat_v_elp.c                                |    3 
 net/batman-adv/bat_v_ogm.c                                |    7 
 net/batman-adv/hard-interface.c                           |   14 
 net/batman-adv/netlink.c                                  |    3 
 net/batman-adv/soft-interface.c                           |    3 
 net/batman-adv/translation-table.c                        |    1 
 net/batman-adv/types.h                                    |    6 
 net/can/raw.c                                             |   76 ++--
 net/core/rtnetlink.c                                      |   43 ++
 net/dccp/proto.c                                          |   20 -
 net/ncsi/ncsi-rsp.c                                       |   93 +----
 net/netfilter/nf_tables_api.c                             |    2 
 net/netfilter/nft_set_pipapo.c                            |   13 
 net/sched/sch_api.c                                       |   53 ++-
 net/sctp/socket.c                                         |    2 
 net/sunrpc/xprtrdma/verbs.c                               |    9 
 security/selinux/ss/policydb.c                            |    2 
 sound/core/pcm_memory.c                                   |   44 ++
 sound/pci/ymfpci/ymfpci.c                                 |   10 
 tools/objtool/arch/x86/decode.c                           |   11 
 tools/objtool/check.c                                     |   22 +
 tools/objtool/include/objtool/arch.h                      |    1 
 tools/objtool/include/objtool/elf.h                       |    1 
 94 files changed, 1063 insertions(+), 827 deletions(-)

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

Benjamin Coddington (2):
      NFSv4: Fix dropped lock for racing OPEN and delegation return
      nfsd: Fix race to FREE_STATEID and cl_revoked

Biju Das (2):
      clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'
      pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}

Christian Brauner (2):
      nfs: use vfs setgid helper
      nfsd: use vfs setgid helper

Christian Göttsche (1):
      selinux: set next pointer before attaching to list

Chuck Lever (1):
      xprtrdma: Remap Receive buffers after a reconnect

Dietmar Eggemann (2):
      sched/deadline: Create DL BW alloc, free & check overflow interface
      cgroup/cpuset: Free DL BW in case can_attach() fails

Eric Dumazet (3):
      can: raw: fix lockdep issue in raw_release()
      sock: annotate data-races around prot->memory_pressure
      dccp: annotate data-races in dccp_poll()

Fedor Pchelkin (2):
      NFSv4.2: fix error handling in nfs42_proc_getxattr
      NFSv4: fix out path in __nfs4_get_acl_uncached

Feng Tang (1):
      x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Florent Fourcot (1):
      rtnetlink: return ENODEV when ifname does not exist and group is given

Florian Westphal (1):
      netfilter: nf_tables: fix out of memory error handling

Greg Kroah-Hartman (1):
      Linux 5.15.129

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

Ivan Mikhaylov (2):
      net/ncsi: make one oem_gma function for all mfr id
      net/ncsi: change from ndo_set_mac_address to dev_set_mac_address

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

Oliver Hartkopp (1):
      can: raw: add missing refcount for memory leak fix

Pablo Neira Ayuso (1):
      netfilter: nf_tables: flush pending destroy work before netlink notifier

Peter Zijlstra (1):
      objtool/x86: Fix SRSO mess

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

Sasha Neftin (1):
      igc: Fix the typo in the PTM Control macro

Sean Christopherson (1):
      Revert "KVM: x86: enable TDP MMU by default"

Sven Eckelmann (3):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user
      batman-adv: Hold rtnl lock during MTU update via netlink

Taimur Hassan (1):
      drm/amd/display: check TG is non-null before checking if enabled

Takashi Iwai (2):
      ALSA: pcm: Fix potential data race at PCM memory allocation helpers
      ALSA: ymfpci: Fix the missing snd_card_free() call at probe error

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

