Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86B78AD53
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjH1KrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjH1KrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF3B115;
        Mon, 28 Aug 2023 03:47:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8257B63FEC;
        Mon, 28 Aug 2023 10:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69071C433C7;
        Mon, 28 Aug 2023 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219620;
        bh=UkBN4XAp+tkjTjvTa1Mms2xZf+RBeabiJbjWytGJWbo=;
        h=From:To:Cc:Subject:Date:From;
        b=XiMLYeihEnWhkjZOJh1IqZ6RSEXh4+rXdH3RCkmYGvzXtS7P+ujPRi1w/dsx8sZ74
         m9ag7e3WqHFiC4yqvJ+kERtslM9jXdud8wI+/4+uyavS9lgno6ds1ARskkuz7kgVp+
         vmOP85iw/bDsWToHNNa6sFaWV0KVo5GiDaV/d3eQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 5.10 00/84] 5.10.193-rc1 review
Date:   Mon, 28 Aug 2023 12:13:17 +0200
Message-ID: <20230828101149.146126827@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.193-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.193-rc1
X-KernelTest-Deadline: 2023-08-30T10:11+00:00
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

This is the start of the stable review cycle for the 5.10.193 release.
There are 84 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.193-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.193-rc1

Oscar Salvador <osalvador@suse.de>
    mm,hwpoison: fix printing of page flags

Bard Liao <yung-chuan.liao@linux.intel.com>
    ASoC: Intel: sof_sdw: include rt711.h for RT711 JD mode

Miaohe Lin <linmiaohe@huawei.com>
    mm: memory-failure: fix unexpected return value in soft_offline_page()

Kefeng Wang <wangkefeng.wang@huawei.com>
    mm: memory-failure: kill soft_offline_free_page()

Dan Williams <dan.j.williams@intel.com>
    mm: fix page reference leak in soft_offline_page()

Oscar Salvador <osalvador@suse.de>
    mm,hwpoison: refactor get_any_page

Rob Clark <robdclark@chromium.org>
    dma-buf/sw_sync: Avoid recursive lock during fence signal

Biju Das <biju.das.jz@bp.renesas.com>
    pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}

Biju Das <biju.das.jz@bp.renesas.com>
    clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'

Zhu Wang <wangzhu9@huawei.com>
    scsi: core: raid_class: Remove raid_component_add()

Zhu Wang <wangzhu9@huawei.com>
    scsi: snic: Fix double free in snic_tgt_create()

Shuming Fan <shumingf@realtek.com>
    ASoC: rt711: add two jack detection modes

Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
    drm/i915: Fix premature release of request's reusable memory

Dietmar Eggemann <dietmar.eggemann@arm.com>
    cgroup/cpuset: Free DL BW in case can_attach() fails

Dietmar Eggemann <dietmar.eggemann@arm.com>
    sched/deadline: Create DL BW alloc, free & check overflow interface

Juri Lelli <juri.lelli@redhat.com>
    cgroup/cpuset: Iterate only if DEADLINE tasks are present

Juri Lelli <juri.lelli@redhat.com>
    sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets

Juri Lelli <juri.lelli@redhat.com>
    sched/cpuset: Bring back cpuset_mutex

Juri Lelli <juri.lelli@redhat.com>
    cgroup/cpuset: Rename functions dealing with DEADLINE accounting

Nicholas Piggin <npiggin@gmail.com>
    timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped

Frederic Weisbecker <frederic@kernel.org>
    tick: Detect and fix jiffies update stall

Joel Fernandes (Google) <joel@joelfernandes.org>
    torture: Fix hang during kthread shutdown phase

Feng Tang <feng.tang@intel.com>
    x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Ankit Nautiyal <ankit.k.nautiyal@intel.com>
    drm/display/dp: Fix the DP DSC Receiver cap size

Zack Rusin <zackr@vmware.com>
    drm/vmwgfx: Fix shader stage validation

Igor Mammedov <imammedo@redhat.com>
    PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus

Wei Chen <harperchen1110@gmail.com>
    media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

Rob Herring <robh@kernel.org>
    of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock

Arnd Bergmann <arnd@arndb.de>
    radix tree: remove unused variable

Helge Deller <deller@gmx.de>
    lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Sven Eckelmann <sven@narfation.org>
    batman-adv: Hold rtnl lock during MTU update via netlink

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Fix TT global entry leak when client roamed back

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Do not get eth header before batadv_check_management_packet

Sven Eckelmann <sven@narfation.org>
    batman-adv: Don't increase MTU when set by user

Sven Eckelmann <sven@narfation.org>
    batman-adv: Trigger events for auto adjusted MTU

Christian Göttsche <cgzones@googlemail.com>
    selinux: set next pointer before attaching to list

Benjamin Coddington <bcodding@redhat.com>
    nfsd: Fix race to FREE_STATEID and cl_revoked

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix a use after free in nfs_direct_join_group()

Alexandre Ghiti <alexghiti@rivosinc.com>
    mm: add a call to flush_cache_vmap() in vmap_pfn()

Andrey Skvortsov <andrej.skvortzov@gmail.com>
    clk: Fix slab-out-of-bounds error in devm_clk_release()

Benjamin Coddington <bcodding@redhat.com>
    NFSv4: Fix dropped lock for racing OPEN and delegation return

Michael Ellerman <mpe@ellerman.id.au>
    ibmveth: Use dcbf rather than dcbfl

Hangbin Liu <liuhangbin@gmail.com>
    bonding: fix macvlan over alb bond support

Jakub Kicinski <kuba@kernel.org>
    net: remove bond_slave_has_mac_rcu()

Ido Schimmel <idosch@nvidia.com>
    rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Florent Fourcot <florent.fourcot@wifirst.fr>
    rtnetlink: return ENODEV when ifname does not exist and group is given

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: fix out of memory error handling

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: fix a qdisc modification with ambiguous command request

Alessio Igor Bogani <alessio.bogani@elettra.eu>
    igb: Avoid starting unnecessary workqueues

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: fix receive buffer size miscalculation

Jakub Kicinski <kuba@kernel.org>
    net: validate veth and vxcan peer ifindexes

Ruan Jinjie <ruanjinjie@huawei.com>
    net: bcmgenet: Fix return value check for fixed_phy_register()

Ruan Jinjie <ruanjinjie@huawei.com>
    net: bgmac: Fix return value check for fixed_phy_register()

Lu Wei <luwei32@huawei.com>
    ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()

Eric Dumazet <edumazet@google.com>
    dccp: annotate data-races in dccp_poll()

Eric Dumazet <edumazet@google.com>
    sock: annotate data-races around prot->memory_pressure

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-af: SDP: fix receive link config

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix memleak due to race between current_tracer and trace

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix cpu buffers unavailable due to 'record_disabled' missed

Ilya Dryomov <idryomov@gmail.com>
    rbd: prevent busy loop when requesting exclusive lock

Ilya Dryomov <idryomov@gmail.com>
    rbd: retrieve and check lock owner twice before blocklisting

Ilya Dryomov <idryomov@gmail.com>
    rbd: make get_lock_owner_info() return a single locker or NULL

Ilya Dryomov <idryomov@gmail.com>
    libceph, rbd: ignore addr->type while comparing in some cases

Taimur Hassan <syed.hassan@amd.com>
    drm/amd/display: check TG is non-null before checking if enabled

Josip Pavic <Josip.Pavic@amd.com>
    drm/amd/display: do not wait for mpc idle if tg is disabled

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix potential data race at PCM memory allocation helpers

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: reduce vmalloc space footprint on 32-bit architectures

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: increase RECALC_SECTORS to improve recalculate speed

Zhang Shurong <zhang_shurong@foxmail.com>
    fbdev: fix potential OOB read in fast_imageblit()

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev: Fix sys_imageblit() for arbitrary image widths

Thomas Zimmermann <tzimmermann@suse.de>
    fbdev: Improve performance of sys_imageblit()

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: cpu-features: Use boot_cpu_type for CPU type based features

Jiaxun Yang <jiaxun.yang@flygoat.com>
    MIPS: cpu-features: Enable octeon_cache by cpu_type

Alexander Aring <aahringo@redhat.com>
    fs: dlm: fix mismatch of plock results from userspace

Alexander Aring <aahringo@redhat.com>
    fs: dlm: use dlm_plock_info for do_unlock_close

Alexander Aring <aahringo@redhat.com>
    fs: dlm: change plock interrupted message to debug again

Alexander Aring <aahringo@redhat.com>
    fs: dlm: add pid to debug log

Jakob Koschel <jakobkoschel@gmail.com>
    dlm: replace usage of found with dedicated list iterator variable

Alexander Aring <aahringo@redhat.com>
    dlm: improve plock logging if interrupted

Igor Mammedov <imammedo@redhat.com>
    PCI: acpiphp: Reassign resources on bridge if necessary

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Remap Receive buffers after a reconnect

Fedor Pchelkin <pchelkin@ispras.ru>
    NFSv4: fix out path in __nfs4_get_acl_uncached

Peter Zijlstra <peterz@infradead.org>
    objtool/x86: Fix SRSO mess


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/mips/include/asm/cpu-features.h               |  21 ++-
 arch/x86/kernel/fpu/xstate.c                       |   8 +
 drivers/block/rbd.c                                | 139 ++++++++++++------
 drivers/clk/clk-devres.c                           |  13 +-
 drivers/dma-buf/sw_sync.c                          |  18 +--
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   4 +-
 drivers/gpu/drm/i915/i915_active.c                 |  99 +++++++++----
 drivers/gpu/drm/i915/i915_request.c                |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  13 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  29 ++--
 drivers/md/dm-integrity.c                          |   4 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |   2 +
 drivers/net/bonding/bond_alb.c                     |   6 +-
 drivers/net/can/vxcan.c                            |   7 +-
 drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |   2 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |   3 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |  24 +--
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   3 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   3 +-
 drivers/net/veth.c                                 |   5 +-
 drivers/of/dynamic.c                               |  31 ++--
 drivers/pci/hotplug/acpiphp_glue.c                 |   9 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c             |  17 ++-
 drivers/scsi/raid_class.c                          |  48 ------
 drivers/scsi/snic/snic_disc.c                      |   3 +-
 drivers/video/fbdev/core/sysimgblt.c               |  64 +++++++-
 fs/dlm/lock.c                                      |  53 ++++---
 fs/dlm/plock.c                                     |  89 ++++++++----
 fs/dlm/recover.c                                   |  39 +++--
 fs/nfs/direct.c                                    |  26 ++--
 fs/nfs/nfs4proc.c                                  |  14 +-
 fs/nfsd/nfs4state.c                                |   2 +-
 include/drm/drm_dp_helper.h                        |   2 +-
 include/linux/ceph/msgr.h                          |   9 +-
 include/linux/clk.h                                |  80 +++++-----
 include/linux/cpuset.h                             |  12 +-
 include/linux/raid_class.h                         |   4 -
 include/linux/sched.h                              |   4 +-
 include/net/bonding.h                              |  25 +---
 include/net/rtnetlink.h                            |   4 +-
 include/net/sock.h                                 |   7 +-
 kernel/cgroup/cgroup.c                             |   4 +
 kernel/cgroup/cpuset.c                             | 161 +++++++++++++++------
 kernel/sched/core.c                                |  41 +++---
 kernel/sched/deadline.c                            |  66 +++++++--
 kernel/sched/sched.h                               |   2 +-
 kernel/time/tick-sched.c                           |  29 +++-
 kernel/time/tick-sched.h                           |   4 +
 kernel/torture.c                                   |   2 +-
 kernel/trace/trace.c                               |  15 +-
 kernel/trace/trace_irqsoff.c                       |   3 +-
 kernel/trace/trace_sched_wakeup.c                  |   2 +
 lib/clz_ctz.c                                      |  32 +---
 lib/radix-tree.c                                   |   1 -
 mm/memory-failure.c                                | 134 ++++++++---------
 mm/vmalloc.c                                       |   4 +
 net/batman-adv/bat_v_elp.c                         |   3 +-
 net/batman-adv/bat_v_ogm.c                         |   7 +-
 net/batman-adv/hard-interface.c                    |  14 +-
 net/batman-adv/netlink.c                           |   3 +
 net/batman-adv/soft-interface.c                    |   3 +
 net/batman-adv/translation-table.c                 |   1 -
 net/batman-adv/types.h                             |   6 +
 net/ceph/mon_client.c                              |   6 +-
 net/core/rtnetlink.c                               |  43 +++++-
 net/dccp/proto.c                                   |  20 ++-
 net/netfilter/nft_set_pipapo.c                     |  13 +-
 net/sched/sch_api.c                                |  53 +++++--
 net/sctp/socket.c                                  |   2 +-
 net/sunrpc/xprtrdma/verbs.c                        |   9 +-
 security/selinux/ss/policydb.c                     |   2 +-
 sound/core/pcm_memory.c                            |  44 +++++-
 sound/soc/codecs/rt711-sdw.h                       |   2 +
 sound/soc/codecs/rt711.c                           |  30 ++++
 sound/soc/codecs/rt711.h                           |  29 +++-
 sound/soc/intel/boards/sof_sdw.c                   |  23 +--
 sound/soc/intel/boards/sof_sdw_common.h            |   5 -
 tools/objtool/arch.h                               |   1 +
 tools/objtool/arch/x86/decode.c                    |  11 +-
 tools/objtool/check.c                              |  22 ++-
 tools/objtool/elf.h                                |   1 +
 84 files changed, 1140 insertions(+), 668 deletions(-)


