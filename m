Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4528078BB94
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjH1Xgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjH1XgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:36:15 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB227CCC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:35:46 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79289fefdbeso100203239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693265746; x=1693870546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/81K7W94/p3QmXbppYEJUQLTvO5y6/r+U+h/m/Bdmu4=;
        b=FyBaOP4ZRdyB/KDVbEZktxVUkeX66TkFe9DhpTyyrZJFSdZlN2JJ5VBH3d8Zw+Jf50
         xIJ89nkc9T83SqiSMDBhFL6rQ64J8hb4M7MM41O3K4GeWsiMQi4P/P3UI3k5r8OZHm7U
         cTR4RWotPXFo0ij8w8xPQ4pH1f0z6Xn2pZe0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265746; x=1693870546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/81K7W94/p3QmXbppYEJUQLTvO5y6/r+U+h/m/Bdmu4=;
        b=iIljYf74olRD+tpWZcfibGrkAVHFX8GlJUyq93v4hKQgsHGW2ygfTodUeeG+cL0RVD
         eV4vMZEzbkYgUsedV6zkiu166ZAcWhZ4cJvcuxgRSMljdZHqI49GKtQxGakOidtVY/aW
         tZp4RpBwRYZkgXzu+3xbCj1MRStNT2i8SWwTKYx49EClljrmQW1xIek83UEqVwSJe0Eo
         COLVQEG6FilELdsKUOsc5lbNn0FF7yhbq2Pv226CY5jpbd0FiUSZj2Cv/5jUSZdXjwhQ
         7jAIpItdC932JuP2iygLWqavNJGOqQ1SL4UWTfVpfIXRiHYABZ/yValIWKppDH2RdrRp
         vsAw==
X-Gm-Message-State: AOJu0YwaZjpgVdqRGE2BJFju3zRRHAF0Zs6vau/AaZ0YQ/FTrdbn6mhH
        I0OkuAZ0tOA8VZ+yvlsLvQIBqQ==
X-Google-Smtp-Source: AGHT+IGKsoNARn+NgnNv2mwwIhAGgE/GGiufFGSOuwiusijB40N5GHWm+0e/l64km9DPaCy3+yLZZQ==
X-Received: by 2002:a05:6e02:1189:b0:349:865d:9fb with SMTP id y9-20020a056e02118900b00349865d09fbmr16676285ili.5.1693265746157;
        Mon, 28 Aug 2023 16:35:46 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id a1-20020a92d341000000b0034ac22c5599sm2721519ilh.73.2023.08.28.16.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:35:45 -0700 (PDT)
Date:   Mon, 28 Aug 2023 23:35:44 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
Message-ID: <20230828233544.GB1699414@google.com>
References: <20230828101157.383363777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:11:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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
>     Linux 6.4.13-rc1
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: fix kdoc warnings after gc rework
> 
> Günther Noack <gnoack3000@gmail.com>
>     TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig
> 
> Arnd Bergmann <arnd@arndb.de>
>     ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
> 
> Liam R. Howlett <Liam.Howlett@oracle.com>
>     maple_tree: disable mas_wr_append() when other readers are possible
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ
> 
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     gpio: sim: pass the GPIO device's software node to irq domain
> 
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     gpio: sim: dispose of irq mappings before destroying the irq_sim domain
> 
> Rob Clark <robdclark@chromium.org>
>     dma-buf/sw_sync: Avoid recursive lock during fence signal
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>     pinctrl: renesas: rza2: Add lock around pinctrl_generic{{add,remove}_group,{add,remove}_function}
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>     pinctrl: renesas: rzv2m: Fix NULL pointer dereference in rzv2m_dt_subnode_to_map()
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>     pinctrl: renesas: rzg2l: Fix NULL pointer dereference in rzg2l_dt_subnode_to_map()
> 
> Maciej Strozek <mstrozek@opensource.cirrus.com>
>     ASoC: cs35l56: Read firmware uuid from a device property instead of _SUB
> 
> Chao Song <chao.song@linux.intel.com>
>     ASoC: SOF: ipc4-pcm: fix possible null pointer deference
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>     clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'
> 
> Zhu Wang <wangzhu9@huawei.com>
>     scsi: core: raid_class: Remove raid_component_add()
> 
> Neil Armstrong <neil.armstrong@linaro.org>
>     scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW major version > 5
> 
> Zhu Wang <wangzhu9@huawei.com>
>     scsi: snic: Fix double free in snic_tgt_create()
> 
> Yin Fengwei <fengwei.yin@intel.com>
>     madvise:madvise_free_pte_range(): don't use mapcount() against large folio for sharing check
> 
> Yin Fengwei <fengwei.yin@intel.com>
>     madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check
> 
> Matt Roper <matthew.d.roper@intel.com>
>     drm/i915: Fix error handling if driver creation fails during probe
> 
> Oliver Hartkopp <socketcan@hartkopp.net>
>     can: raw: add missing refcount for memory leak fix
> 
> Sanjay R Mehta <sanju.mehta@amd.com>
>     thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd hot plug onwards
> 
> Igor Mammedov <imammedo@redhat.com>
>     PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus
> 
> Wei Chen <harperchen1110@gmail.com>
>     media: vcodec: Fix potential array out-of-bounds in encoder queue_setup
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     pinctrl: amd: Mask wake bits on probe again
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
> Mingzheng Xing <xingmingzheng@iscas.ac.cn>
>     riscv: Fix build errors using binutils2.37 toolchains
> 
> Mingzheng Xing <xingmingzheng@iscas.ac.cn>
>     riscv: Handle zicsr/zifencei issue between gcc and binutils
> 
> Helge Deller <deller@gmx.de>
>     lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
> 
> Hans de Goede <hdegoede@redhat.com>
>     ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M
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
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>     nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
> 
> T.J. Mercier <tjmercier@google.com>
>     mm: multi-gen LRU: don't spin during memcg release
> 
> Miaohe Lin <linmiaohe@huawei.com>
>     mm: memory-failure: fix unexpected return value in soft_offline_page()
> 
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     mm: add a call to flush_cache_vmap() in vmap_pfn()
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
> Jani Nikula <jani.nikula@intel.com>
>     drm/i915: fix display probe for IVB Q and IVB D GT2 server
> 
> Matt Roper <matthew.d.roper@intel.com>
>     drm/i915/display: Handle GMD_ID identification in display code
> 
> Feng Tang <feng.tang@intel.com>
>     x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4
> 
> Rick Edgecombe <rick.p.edgecombe@intel.com>
>     x86/fpu: Invalidate FPU state correctly on exec()
> 
> Huacai Chen <chenhuacai@kernel.org>
>     LoongArch: Fix hw_breakpoint_control() for watchpoints
> 
> Imre Deak <imre.deak@intel.com>
>     drm/i915: Fix HPD polling, reenabling the output poll work as needed
> 
> Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>     drm/display/dp: Fix the DP DSC Receiver cap size
> 
> Anshuman Gupta <anshuman.gupta@intel.com>
>     drm/i915/dgfx: Enable d3cold at s2idle
> 
> David Michael <fedora.dm0@gmail.com>
>     drm/panfrost: Skip speed binning on EOPNOTSUPP
> 
> Imre Deak <imre.deak@intel.com>
>     drm: Add an HPD poll helper to reschedule the poll work
> 
> Zack Rusin <zackr@vmware.com>
>     drm/vmwgfx: Fix possible invalid drm gem put calls
> 
> Zack Rusin <zackr@vmware.com>
>     drm/vmwgfx: Fix shader stage validation
> 
> David Hildenbrand <david@redhat.com>
>     mm/gup: handle cont-PTE hugetlb pages correctly in gup_must_unshare() via GUP-fast
> 
> David Hildenbrand <david@redhat.com>
>     mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
> 
> Suren Baghdasaryan <surenb@google.com>
>     mm: enable page walking API to lock vmas during the walk
> 
> Ayush Jain <ayush.jain3@amd.com>
>     selftests/mm: FOLL_LONGTERM need to be updated to 0x100
> 
> Takashi Iwai <tiwai@suse.de>
>     ALSA: ymfpci: Fix the missing snd_card_free() call at probe error
> 
> Hugh Dickins <hughd@google.com>
>     shmem: fix smaps BUG sleeping while atomic
> 
> Rik van Riel <riel@surriel.com>
>     mm,ima,kexec,of: use memblock_free_late from ima_free_kexec_buffer
> 
> Andrey Skvortsov <andrej.skvortzov@gmail.com>
>     clk: Fix slab-out-of-bounds error in devm_clk_release()
> 
> Benjamin Coddington <bcodding@redhat.com>
>     NFSv4: Fix dropped lock for racing OPEN and delegation return
> 
> André Apitzsch <git@apitzsch.eu>
>     platform/x86: ideapad-laptop: Add support for new hotkeys found on ThinkBook 14s Yoga ITL
> 
> Swapnil Devesh <me@sidevesh.com>
>     platform/x86: lenovo-ymc: Add Lenovo Yoga 7 14ACN6 to ec_trigger_quirk_dmi_table
> 
> Ping-Ke Shih <pkshih@realtek.com>
>     wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning
> 
> Michael Ellerman <mpe@ellerman.id.au>
>     ibmveth: Use dcbf rather than dcbfl
> 
> Srinivas Goud <srinivas.goud@amd.com>
>     spi: spi-cadence: Fix data corruption issues in slave mode
> 
> Charles Keepax <ckeepax@opensource.cirrus.com>
>     ASoC: cs35l41: Correct amp_gain_tlv values
> 
> BrenoRCBrito <brenorcbrito@gmail.com>
>     ASoC: amd: yc: Add VivoBook Pro 15 to quirks list for acp6x
> 
> Hangbin Liu <liuhangbin@gmail.com>
>     bonding: fix macvlan over alb bond support
> 
> Ido Schimmel <idosch@nvidia.com>
>     rtnetlink: Reject negative ifindexes in RTM_NEWLINK
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: defer gc run if previous batch is still pending
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: fix out of memory error handling
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: use correct lock to protect gc_list
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: GC transaction race with abort path
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: flush pending destroy work before netlink notifier
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: validate all pending tables
> 
> Andrii Staikov <andrii.staikov@intel.com>
>     i40e: fix potential NULL pointer dereferencing of pf->vf i40e_sync_vsi_filters()
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
> Oliver Hartkopp <socketcan@hartkopp.net>
>     can: isotp: fix support for transmission of SF without flow control
> 
> Daniel Golle <daniel@makrotopia.org>
>     net: ethernet: mtk_eth_soc: fix NULL pointer on hw reset
> 
> Kees Cook <keescook@chromium.org>
>     tg3: Use slab_build_skb() when needed
> 
> Hangbin Liu <liuhangbin@gmail.com>
>     selftests: bonding: do not set port down before adding to bond
> 
> Petr Oros <poros@redhat.com>
>     ice: Fix NULL pointer deref during VF reset
> 
> Petr Oros <poros@redhat.com>
>     Revert "ice: Fix ice VF reset during iavf initialization"
> 
> Jesse Brandeburg <jesse.brandeburg@intel.com>
>     ice: fix receive buffer size miscalculation
> 
> Eric Dumazet <edumazet@google.com>
>     ipv4: fix data-races around inet->inet_id
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
> Serge Semin <fancer.lancer@gmail.com>
>     net: mdio: mdio-bitbang: Fix C45 read/write protocol
> 
> Arınç ÜNAL <arinc.unal@arinc9.com>
>     net: dsa: mt7530: fix handling of 802.1X PAE frames
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: mlxsw: Fix test failure on Spectrum-4
> 
> Amit Cohen <amcohen@nvidia.com>
>     mlxsw: Fix the size of 'VIRT_ROUTER_MSB'
> 
> Ido Schimmel <idosch@nvidia.com>
>     mlxsw: reg: Fix SSPR register layout
> 
> Danielle Ratson <danieller@nvidia.com>
>     mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC
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
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: felix: fix oversize frame dropping for always closed tc-taprio gates
> 
> Jiri Pirko <jiri@resnulli.us>
>     devlink: add missing unregister linecard notification
> 
> Hariprasad Kelam <hkelam@marvell.com>
>     octeontx2-af: SDP: fix receive link config
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>     tracing: Fix memleak due to race between current_tracer and trace
> 
> Sven Schnelle <svens@linux.ibm.com>
>     tracing/synthetic: Allocate one additional element for size
> 
> Sven Schnelle <svens@linux.ibm.com>
>     tracing/synthetic: Skip first entry for stack traces
> 
> Sven Schnelle <svens@linux.ibm.com>
>     tracing/synthetic: Use union instead of casts
> 
> Zheng Yejian <zhengyejian1@huawei.com>
>     tracing: Fix cpu buffers unavailable due to 'record_disabled' missed
> 
> Randy Dunlap <rdunlap@infradead.org>
>     wifi: iwlwifi: mvm: add dependency for PTP clock
> 
> Eric Dumazet <edumazet@google.com>
>     can: raw: fix lockdep issue in raw_release()
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
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                                           |   4 +-
>  arch/loongarch/kernel/hw_breakpoint.c              |   3 +-
>  arch/powerpc/mm/book3s64/subpage_prot.c            |   1 +
>  arch/riscv/Kconfig                                 |  28 ++-
>  arch/riscv/kernel/compat_vdso/Makefile             |   8 +-
>  arch/riscv/mm/pageattr.c                           |   1 +
>  arch/s390/mm/gmap.c                                |   5 +
>  arch/x86/kernel/fpu/context.h                      |   3 +-
>  arch/x86/kernel/fpu/core.c                         |   2 +-
>  arch/x86/kernel/fpu/xstate.c                       |   7 +
>  drivers/acpi/resource.c                            |   6 +-
>  drivers/clk/clk-devres.c                           |  13 +-
>  drivers/dma-buf/sw_sync.c                          |  18 +-
>  drivers/gpio/gpio-sim.c                            |  15 +-
>  drivers/gpu/drm/drm_probe_helper.c                 |  68 ++++--
>  .../gpu/drm/i915/display/intel_display_device.c    |  91 +++++++-
>  .../gpu/drm/i915/display/intel_display_device.h    |   5 +-
>  drivers/gpu/drm/i915/display/intel_hotplug.c       |   4 +-
>  drivers/gpu/drm/i915/i915_driver.c                 |  50 +++--
>  drivers/gpu/drm/i915/intel_device_info.c           |  13 +-
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c        |   2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   6 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                 |   8 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  12 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |  35 ++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   6 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |   3 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |   3 +-
>  .../platform/mediatek/vcodec/mtk_vcodec_enc.c      |   2 +
>  drivers/net/bonding/bond_alb.c                     |   6 +-
>  drivers/net/can/vxcan.c                            |   7 +-
>  drivers/net/dsa/mt7530.c                           |   4 +
>  drivers/net/dsa/mt7530.h                           |   2 +
>  drivers/net/dsa/ocelot/felix_vsc9959.c             |   3 +
>  drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
>  drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +-
>  drivers/net/ethernet/broadcom/tg3.c                |   5 +-
>  .../chelsio/inline_crypto/chtls/chtls_cm.c         |   2 +-
>  drivers/net/ethernet/ibm/ibmveth.c                 |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |   5 +-
>  drivers/net/ethernet/intel/ice/ice_base.c          |   3 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c         |   8 +-
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  34 +--
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h        |   1 -
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   1 -
>  drivers/net/ethernet/intel/igb/igb_ptp.c           |  24 +-
>  drivers/net/ethernet/intel/igc/igc_defines.h       |   2 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   3 +-
>  drivers/net/ethernet/mediatek/mtk_wed.c            |  12 +-
>  .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |   4 +-
>  drivers/net/ethernet/mellanox/mlxsw/pci.c          |   8 +-
>  drivers/net/ethernet/mellanox/mlxsw/reg.h          |   9 -
>  .../ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c    |   2 +-
>  .../mellanox/mlxsw/spectrum_acl_flex_keys.c        |   4 +-
>  drivers/net/ipvlan/ipvlan_main.c                   |   3 +-
>  drivers/net/mdio/mdio-bitbang.c                    |   4 +-
>  drivers/net/veth.c                                 |   5 +-
>  drivers/net/wireless/intel/iwlwifi/Kconfig         |   1 +
>  drivers/of/dynamic.c                               |  31 +--
>  drivers/of/kexec.c                                 |   3 +-
>  drivers/of/unittest.c                              |   4 +-
>  drivers/pci/hotplug/acpiphp_glue.c                 |   9 +-
>  drivers/pinctrl/pinctrl-amd.c                      |  30 +++
>  drivers/pinctrl/renesas/pinctrl-rza2.c             |  17 +-
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  15 +-
>  drivers/pinctrl/renesas/pinctrl-rzv2m.c            |  13 +-
>  drivers/platform/x86/ideapad-laptop.c              |   5 +
>  drivers/platform/x86/lenovo-ymc.c                  |   7 +
>  drivers/scsi/raid_class.c                          |  48 ----
>  drivers/scsi/snic/snic_disc.c                      |   3 +-
>  drivers/spi/spi-cadence.c                          |  19 +-
>  drivers/thunderbolt/tmu.c                          |   3 +-
>  drivers/tty/Kconfig                                |   3 +
>  drivers/ufs/host/ufs-qcom.c                        |   2 +-
>  fs/jbd2/checkpoint.c                               | 165 +++++---------
>  fs/jbd2/commit.c                                   |   3 +-
>  fs/jbd2/transaction.c                              |  17 +-
>  fs/nfs/direct.c                                    |  26 ++-
>  fs/nfs/nfs42proc.c                                 |   5 +-
>  fs/nfs/nfs4proc.c                                  |  14 +-
>  fs/nfsd/nfs4state.c                                |   2 +-
>  fs/nilfs2/segment.c                                |   5 +
>  fs/proc/task_mmu.c                                 |   5 +
>  include/drm/display/drm_dp.h                       |   2 +-
>  include/drm/drm_probe_helper.h                     |   1 +
>  include/linux/clk.h                                |  80 +++----
>  include/linux/cpuset.h                             |  12 +-
>  include/linux/jbd2.h                               |   7 +-
>  include/linux/mm.h                                 |  21 +-
>  include/linux/mm_types.h                           |   9 +
>  include/linux/pagewalk.h                           |  11 +
>  include/linux/raid_class.h                         |   4 -
>  include/linux/sched.h                              |   4 +-
>  include/linux/trace_events.h                       |  11 +
>  include/net/bonding.h                              |  11 +-
>  include/net/inet_sock.h                            |   2 +-
>  include/net/ip.h                                   |  15 +-
>  include/net/mac80211.h                             |   1 +
>  include/net/netfilter/nf_tables.h                  |   7 +
>  include/net/rtnetlink.h                            |   4 +-
>  include/net/sock.h                                 |   7 +-
>  include/trace/events/jbd2.h                        |  12 +-
>  kernel/cgroup/cgroup.c                             |   4 +
>  kernel/cgroup/cpuset.c                             | 244 +++++++++++++--------
>  kernel/sched/core.c                                |  41 ++--
>  kernel/sched/deadline.c                            |  67 ++++--
>  kernel/sched/sched.h                               |   2 +-
>  kernel/trace/trace.c                               |  15 +-
>  kernel/trace/trace.h                               |   8 +
>  kernel/trace/trace_events_synth.c                  | 103 ++++-----
>  kernel/trace/trace_irqsoff.c                       |   3 +-
>  kernel/trace/trace_sched_wakeup.c                  |   2 +
>  lib/clz_ctz.c                                      |  32 +--
>  lib/maple_tree.c                                   |   3 +
>  lib/radix-tree.c                                   |   1 -
>  mm/damon/vaddr.c                                   |   2 +
>  mm/gup.c                                           |  30 ++-
>  mm/hmm.c                                           |   1 +
>  mm/huge_memory.c                                   |   3 +-
>  mm/internal.h                                      |  10 +
>  mm/ksm.c                                           |  25 ++-
>  mm/madvise.c                                       |  11 +-
>  mm/memcontrol.c                                    |   2 +
>  mm/memory-failure.c                                |  12 +-
>  mm/mempolicy.c                                     |  22 +-
>  mm/migrate_device.c                                |   1 +
>  mm/mincore.c                                       |   1 +
>  mm/mlock.c                                         |   1 +
>  mm/mprotect.c                                      |   1 +
>  mm/pagewalk.c                                      |  36 ++-
>  mm/shmem.c                                         |   6 +-
>  mm/vmalloc.c                                       |   4 +
>  mm/vmscan.c                                        |  14 +-
>  net/batman-adv/bat_v_elp.c                         |   3 +-
>  net/batman-adv/bat_v_ogm.c                         |   7 +-
>  net/batman-adv/hard-interface.c                    |  14 +-
>  net/batman-adv/netlink.c                           |   3 +
>  net/batman-adv/soft-interface.c                    |   3 +
>  net/batman-adv/translation-table.c                 |   1 -
>  net/batman-adv/types.h                             |   6 +
>  net/can/isotp.c                                    |  22 +-
>  net/can/raw.c                                      |  77 ++++---
>  net/core/rtnetlink.c                               |  25 ++-
>  net/dccp/ipv4.c                                    |   4 +-
>  net/dccp/proto.c                                   |  20 +-
>  net/devlink/leftover.c                             |   3 +
>  net/ipv4/af_inet.c                                 |   2 +-
>  net/ipv4/datagram.c                                |   2 +-
>  net/ipv4/tcp_ipv4.c                                |   4 +-
>  net/mac80211/rx.c                                  |  12 +-
>  net/netfilter/nf_tables_api.c                      |  23 +-
>  net/netfilter/nft_set_hash.c                       |   3 +
>  net/netfilter/nft_set_pipapo.c                     |  15 +-
>  net/netfilter/nft_set_rbtree.c                     |   3 +
>  net/sched/sch_api.c                                |  53 +++--
>  net/sctp/socket.c                                  |   4 +-
>  net/sunrpc/xprtrdma/verbs.c                        |   9 +-
>  security/selinux/ss/policydb.c                     |   2 +-
>  sound/pci/ymfpci/ymfpci.c                          |  10 +-
>  sound/soc/amd/Kconfig                              |   1 +
>  sound/soc/amd/yc/acp6x-mach.c                      |   9 +-
>  sound/soc/codecs/cs35l41.c                         |   2 +-
>  sound/soc/codecs/cs35l56.c                         |  31 +--
>  sound/soc/sof/ipc4-pcm.c                           |   3 +
>  .../drivers/net/bonding/bond-break-lacpdu-tx.sh    |   4 +-
>  .../selftests/drivers/net/mlxsw/sharedbuffer.sh    |  16 +-
>  tools/testing/selftests/mm/hmm-tests.c             |   9 +-
>  167 files changed, 1438 insertions(+), 939 deletions(-)
> 
> 
