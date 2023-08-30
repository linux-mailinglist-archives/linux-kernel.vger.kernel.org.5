Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502F078DCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbjH3Sqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244522AbjH3NTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:19:47 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5631F137
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:19:43 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-410915344aeso34719321cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693401582; x=1694006382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3VppTGScjcO/zyi0Q3vWC5JDEzdT9McYSrDsY871CHE=;
        b=N65NVxRTV5PLEoeS0mgjPc6LH/hCbVcPuqVN2w1W4/a2TPeTVpE5UdUMGkcSCuSGh4
         FiPBsLcYBSW70HJ/8fCU6Yc7nCfUWaXGLyfCKiG4SqVOqydUKP1ROE7GyuJ9FHRykuI6
         /4MS9YmA7jqM1U56EDpCt04bgwVIT/Yfgee5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401582; x=1694006382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VppTGScjcO/zyi0Q3vWC5JDEzdT9McYSrDsY871CHE=;
        b=N6oAJd3ecC/hemBY7dXLLqzKbVhsS15ja4PWoOsiXT7yAr3Ps+Cj5UqymfKuJcLAYA
         7Z+/v8Xubo3WgBMrHysAmpWsTy15vY+XVGbZQxzqct6sI5JUIXLuGVi3XOwCIZhhdX1L
         P4wJDRdizyISALw2hHWZaiTnaAV/XkXoCtVp0cd31FgDuk6eClsSy4mQWAkI935uilX4
         zCWFsuYj//h5INTZk9kd2aY3QqZcBD3xOD0W0rGt1K10Gb1uLl7Ty4oGyh9QnUnAlTuL
         SVFi3lWmjQ3kffNRAjNnX8ZwIT0KAUwYcu3APGY8+O++DD/Asz7PSdMOLJhqFfCh3s/u
         w95Q==
X-Gm-Message-State: AOJu0YzM4zHTUXFkPUOEvM1xrSp47bI8yy7z8okQeuv+f1Py1VKukmnA
        86mPp2p7h9R21maR4GDMqmlGXAvcpPJZ5cGSwAw=
X-Google-Smtp-Source: AGHT+IHdZ3NMK3MwfFMBnwS/7mU+BeeCDvKcGfPebjkhha/TtPhAoWgeToRmrOFWYGVqgmXQeMVWkg==
X-Received: by 2002:ac8:5a45:0:b0:403:cecf:4ade with SMTP id o5-20020ac85a45000000b00403cecf4ademr2191865qta.32.1693401582376;
        Wed, 30 Aug 2023 06:19:42 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id ha8-20020a05622a2b0800b0041087c90049sm3728468qtb.52.2023.08.30.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:19:41 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:19:41 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
Message-ID: <20230830131941.GA2425542@joel-ThinkPad-X1-Carbon-4th>
References: <20230828101150.163430842@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:13:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.129-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

For RCU,
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 5.15.129-rc1
> 
> Rik van Riel <riel@surriel.com>
>     mm,ima,kexec,of: use memblock_free_late from ima_free_kexec_buffer
> 
> Miaohe Lin <linmiaohe@huawei.com>
>     mm: memory-failure: fix unexpected return value in soft_offline_page()
> 
> Kefeng Wang <wangkefeng.wang@huawei.com>
>     mm: memory-failure: kill soft_offline_free_page()
> 
> Rob Clark <robdclark@chromium.org>
>     dma-buf/sw_sync: Avoid recursive lock during fence signal
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>     pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>     clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'
> 
> Zhu Wang <wangzhu9@huawei.com>
>     scsi: core: raid_class: Remove raid_component_add()
> 
> Zhu Wang <wangzhu9@huawei.com>
>     scsi: snic: Fix double free in snic_tgt_create()
> 
> Oliver Hartkopp <socketcan@hartkopp.net>
>     can: raw: add missing refcount for memory leak fix
> 
> Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
>     drm/i915: Fix premature release of request's reusable memory
> 
> Dietmar Eggemann <dietmar.eggemann@arm.com>
>     cgroup/cpuset: Free DL BW in case can_attach() fails
> 
> Dietmar Eggemann <dietmar.eggemann@arm.com>
>     sched/deadline: Create DL BW alloc, free & check overflow interface
> 
> Juri Lelli <juri.lelli@redhat.com>
>     cgroup/cpuset: Iterate only if DEADLINE tasks are present
> 
> Juri Lelli <juri.lelli@redhat.com>
>     sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
> 
> Juri Lelli <juri.lelli@redhat.com>
>     sched/cpuset: Bring back cpuset_mutex
> 
> Juri Lelli <juri.lelli@redhat.com>
>     cgroup/cpuset: Rename functions dealing with DEADLINE accounting
> 
> Joel Fernandes (Google) <joel@joelfernandes.org>
>     torture: Fix hang during kthread shutdown phase
> 
> Christian Brauner <brauner@kernel.org>
>     nfsd: use vfs setgid helper
> 
> Christian Brauner <brauner@kernel.org>
>     nfs: use vfs setgid helper
> 
> Feng Tang <feng.tang@intel.com>
>     x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4
> 
> Rick Edgecombe <rick.p.edgecombe@intel.com>
>     x86/fpu: Invalidate FPU state correctly on exec()
> 
> Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>     drm/display/dp: Fix the DP DSC Receiver cap size
> 
> Zack Rusin <zackr@vmware.com>
>     drm/vmwgfx: Fix shader stage validation
> 
> Igor Mammedov <imammedo@redhat.com>
>     PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus
> 
> Wei Chen <harperchen1110@gmail.com>
>     media: vcodec: Fix potential array out-of-bounds in encoder queue_setup
> 
> Rob Herring <robh@kernel.org>
>     of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
> 
> Rob Herring <robh@kernel.org>
>     of: unittest: Fix EXPECT for parse_phandle_with_args_map() test
> 
> Arnd Bergmann <arnd@arndb.de>
>     radix tree: remove unused variable
> 
> Helge Deller <deller@gmx.de>
>     lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
> 
> Sven Eckelmann <sven@narfation.org>
>     batman-adv: Hold rtnl lock during MTU update via netlink
> 
> Remi Pommarel <repk@triplefau.lt>
>     batman-adv: Fix batadv_v_ogm_aggr_send memory leak
> 
> Remi Pommarel <repk@triplefau.lt>
>     batman-adv: Fix TT global entry leak when client roamed back
> 
> Remi Pommarel <repk@triplefau.lt>
>     batman-adv: Do not get eth header before batadv_check_management_packet
> 
> Sven Eckelmann <sven@narfation.org>
>     batman-adv: Don't increase MTU when set by user
> 
> Sven Eckelmann <sven@narfation.org>
>     batman-adv: Trigger events for auto adjusted MTU
> 
> Christian Göttsche <cgzones@googlemail.com>
>     selinux: set next pointer before attaching to list
> 
> Benjamin Coddington <bcodding@redhat.com>
>     nfsd: Fix race to FREE_STATEID and cl_revoked
> 
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     NFS: Fix a use after free in nfs_direct_join_group()
> 
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     mm: add a call to flush_cache_vmap() in vmap_pfn()
> 
> Takashi Iwai <tiwai@suse.de>
>     ALSA: ymfpci: Fix the missing snd_card_free() call at probe error
> 
> Andrey Skvortsov <andrej.skvortzov@gmail.com>
>     clk: Fix slab-out-of-bounds error in devm_clk_release()
> 
> Benjamin Coddington <bcodding@redhat.com>
>     NFSv4: Fix dropped lock for racing OPEN and delegation return
> 
> Michael Ellerman <mpe@ellerman.id.au>
>     ibmveth: Use dcbf rather than dcbfl
> 
> Sean Christopherson <seanjc@google.com>
>     Revert "KVM: x86: enable TDP MMU by default"
> 
> Ivan Mikhaylov <fr0st61te@gmail.com>
>     net/ncsi: change from ndo_set_mac_address to dev_set_mac_address
> 
> Ivan Mikhaylov <fr0st61te@gmail.com>
>     net/ncsi: make one oem_gma function for all mfr id
> 
> Hangbin Liu <liuhangbin@gmail.com>
>     bonding: fix macvlan over alb bond support
> 
> Jakub Kicinski <kuba@kernel.org>
>     net: remove bond_slave_has_mac_rcu()
> 
> Ido Schimmel <idosch@nvidia.com>
>     rtnetlink: Reject negative ifindexes in RTM_NEWLINK
> 
> Florent Fourcot <florent.fourcot@wifirst.fr>
>     rtnetlink: return ENODEV when ifname does not exist and group is given
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: fix out of memory error handling
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: flush pending destroy work before netlink notifier
> 
> Jamal Hadi Salim <jhs@mojatatu.com>
>     net/sched: fix a qdisc modification with ambiguous command request
> 
> Sasha Neftin <sasha.neftin@intel.com>
>     igc: Fix the typo in the PTM Control macro
> 
> Alessio Igor Bogani <alessio.bogani@elettra.eu>
>     igb: Avoid starting unnecessary workqueues
> 
> Jesse Brandeburg <jesse.brandeburg@intel.com>
>     ice: fix receive buffer size miscalculation
> 
> Jakub Kicinski <kuba@kernel.org>
>     net: validate veth and vxcan peer ifindexes
> 
> Ruan Jinjie <ruanjinjie@huawei.com>
>     net: bcmgenet: Fix return value check for fixed_phy_register()
> 
> Ruan Jinjie <ruanjinjie@huawei.com>
>     net: bgmac: Fix return value check for fixed_phy_register()
> 
> Lu Wei <luwei32@huawei.com>
>     ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()
> 
> Eric Dumazet <edumazet@google.com>
>     dccp: annotate data-races in dccp_poll()
> 
> Eric Dumazet <edumazet@google.com>
>     sock: annotate data-races around prot->memory_pressure
> 
> Hariprasad Kelam <hkelam@marvell.com>
>     octeontx2-af: SDP: fix receive link config
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>     tracing: Fix memleak due to race between current_tracer and trace
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>     tracing: Fix cpu buffers unavailable due to 'record_disabled' missed
> 
> Eric Dumazet <edumazet@google.com>
>     can: raw: fix lockdep issue in raw_release()
> 
> Taimur Hassan <syed.hassan@amd.com>
>     drm/amd/display: check TG is non-null before checking if enabled
> 
> Josip Pavic <Josip.Pavic@amd.com>
>     drm/amd/display: do not wait for mpc idle if tg is disabled
> 
> Ziyang Xuan <william.xuanziyang@huawei.com>
>     can: raw: fix receiver memory leak
> 
> Zhang Yi <yi.zhang@huawei.com>
>     jbd2: fix a race when checking checkpoint buffer busy
> 
> Zhang Yi <yi.zhang@huawei.com>
>     jbd2: remove journal_clean_one_cp_list()
> 
> Zhang Yi <yi.zhang@huawei.com>
>     jbd2: remove t_checkpoint_io_list
> 
> Takashi Iwai <tiwai@suse.de>
>     ALSA: pcm: Fix potential data race at PCM memory allocation helpers
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     fbdev: fix potential OOB read in fast_imageblit()
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>     fbdev: Fix sys_imageblit() for arbitrary image widths
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>     fbdev: Improve performance of sys_imageblit()
> 
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>     MIPS: cpu-features: Use boot_cpu_type for CPU type based features
> 
> Jiaxun Yang <jiaxun.yang@flygoat.com>
>     MIPS: cpu-features: Enable octeon_cache by cpu_type
> 
> Alexander Aring <aahringo@redhat.com>
>     fs: dlm: fix mismatch of plock results from userspace
> 
> Alexander Aring <aahringo@redhat.com>
>     fs: dlm: use dlm_plock_info for do_unlock_close
> 
> Alexander Aring <aahringo@redhat.com>
>     fs: dlm: change plock interrupted message to debug again
> 
> Alexander Aring <aahringo@redhat.com>
>     fs: dlm: add pid to debug log
> 
> Jakob Koschel <jakobkoschel@gmail.com>
>     dlm: replace usage of found with dedicated list iterator variable
> 
> Alexander Aring <aahringo@redhat.com>
>     dlm: improve plock logging if interrupted
> 
> Igor Mammedov <imammedo@redhat.com>
>     PCI: acpiphp: Reassign resources on bridge if necessary
> 
> Chuck Lever <chuck.lever@oracle.com>
>     xprtrdma: Remap Receive buffers after a reconnect
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>     NFSv4: fix out path in __nfs4_get_acl_uncached
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>     NFSv4.2: fix error handling in nfs42_proc_getxattr
> 
> Peter Zijlstra <peterz@infradead.org>
>     objtool/x86: Fix SRSO mess
> 
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                                           |   4 +-
>  arch/mips/include/asm/cpu-features.h               |  21 +-
>  arch/x86/include/asm/fpu/internal.h                |   3 +-
>  arch/x86/kernel/fpu/core.c                         |   2 +-
>  arch/x86/kernel/fpu/xstate.c                       |   7 +
>  arch/x86/kvm/mmu/tdp_mmu.c                         |   2 +-
>  drivers/clk/clk-devres.c                           |  13 +-
>  drivers/dma-buf/sw_sync.c                          |  18 +-
>  .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   4 +-
>  drivers/gpu/drm/i915/i915_active.c                 |  99 ++++++---
>  drivers/gpu/drm/i915/i915_request.c                |   2 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  12 ++
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  29 +--
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |   2 +
>  drivers/net/bonding/bond_alb.c                     |   6 +-
>  drivers/net/can/vxcan.c                            |   7 +-
>  drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
>  drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +-
>  drivers/net/ethernet/ibm/ibmveth.c                 |   2 +-
>  drivers/net/ethernet/intel/ice/ice_base.c          |   3 +-
>  drivers/net/ethernet/intel/igb/igb_ptp.c           |  24 +--
>  drivers/net/ethernet/intel/igc/igc_defines.h       |   2 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   3 +-
>  drivers/net/ipvlan/ipvlan_main.c                   |   3 +-
>  drivers/net/veth.c                                 |   5 +-
>  drivers/of/dynamic.c                               |  31 +--
>  drivers/of/kexec.c                                 |   4 +-
>  drivers/of/unittest.c                              |   4 +-
>  drivers/pci/hotplug/acpiphp_glue.c                 |   9 +-
>  drivers/pinctrl/renesas/pinctrl-rza2.c             |  17 +-
>  drivers/scsi/raid_class.c                          |  48 -----
>  drivers/scsi/snic/snic_disc.c                      |   3 +-
>  drivers/video/fbdev/core/sysimgblt.c               |  64 +++++-
>  fs/attr.c                                          |   1 +
>  fs/dlm/lock.c                                      |  53 +++--
>  fs/dlm/plock.c                                     |  89 +++++---
>  fs/dlm/recover.c                                   |  39 ++--
>  fs/internal.h                                      |   2 -
>  fs/jbd2/checkpoint.c                               | 165 ++++++---------
>  fs/jbd2/commit.c                                   |   3 +-
>  fs/jbd2/transaction.c                              |  17 +-
>  fs/nfs/direct.c                                    |  26 ++-
>  fs/nfs/inode.c                                     |   4 +-
>  fs/nfs/nfs42proc.c                                 |   5 +-
>  fs/nfs/nfs4proc.c                                  |  14 +-
>  fs/nfsd/nfs4state.c                                |   2 +-
>  fs/nfsd/vfs.c                                      |   4 +-
>  include/drm/drm_dp_helper.h                        |   2 +-
>  include/linux/clk.h                                |  80 +++----
>  include/linux/cpuset.h                             |  12 +-
>  include/linux/fs.h                                 |   2 +
>  include/linux/jbd2.h                               |   7 +-
>  include/linux/raid_class.h                         |   4 -
>  include/linux/sched.h                              |   4 +-
>  include/net/bonding.h                              |  25 +--
>  include/net/rtnetlink.h                            |   4 +-
>  include/net/sock.h                                 |   7 +-
>  include/trace/events/jbd2.h                        |  12 +-
>  kernel/cgroup/cgroup.c                             |   4 +
>  kernel/cgroup/cpuset.c                             | 232 ++++++++++++++-------
>  kernel/sched/core.c                                |  41 ++--
>  kernel/sched/deadline.c                            |  66 ++++--
>  kernel/sched/sched.h                               |   2 +-
>  kernel/torture.c                                   |   2 +-
>  kernel/trace/trace.c                               |  15 +-
>  kernel/trace/trace_irqsoff.c                       |   3 +-
>  kernel/trace/trace_sched_wakeup.c                  |   2 +
>  lib/clz_ctz.c                                      |  32 +--
>  lib/radix-tree.c                                   |   1 -
>  mm/memory-failure.c                                |  21 +-
>  mm/vmalloc.c                                       |   4 +
>  net/batman-adv/bat_v_elp.c                         |   3 +-
>  net/batman-adv/bat_v_ogm.c                         |   7 +-
>  net/batman-adv/hard-interface.c                    |  14 +-
>  net/batman-adv/netlink.c                           |   3 +
>  net/batman-adv/soft-interface.c                    |   3 +
>  net/batman-adv/translation-table.c                 |   1 -
>  net/batman-adv/types.h                             |   6 +
>  net/can/raw.c                                      |  76 ++++---
>  net/core/rtnetlink.c                               |  43 +++-
>  net/dccp/proto.c                                   |  20 +-
>  net/ncsi/ncsi-rsp.c                                |  93 ++-------
>  net/netfilter/nf_tables_api.c                      |   2 +-
>  net/netfilter/nft_set_pipapo.c                     |  13 +-
>  net/sched/sch_api.c                                |  53 +++--
>  net/sctp/socket.c                                  |   2 +-
>  net/sunrpc/xprtrdma/verbs.c                        |   9 +-
>  security/selinux/ss/policydb.c                     |   2 +-
>  sound/core/pcm_memory.c                            |  44 +++-
>  sound/pci/ymfpci/ymfpci.c                          |  10 +-
>  tools/objtool/arch/x86/decode.c                    |  11 +-
>  tools/objtool/check.c                              |  22 +-
>  tools/objtool/include/objtool/arch.h               |   1 +
>  tools/objtool/include/objtool/elf.h                |   1 +
>  94 files changed, 1070 insertions(+), 834 deletions(-)
> 
> 
