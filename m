Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51997644BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjG0EBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjG0EBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:01:10 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1D2E73
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:01:06 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34896a1574dso1851575ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1690430466; x=1691035266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Od+hrNjQ7cGWCDx5iCpKEnmr3Jo0fGpxHqGp3Cj8bU=;
        b=mOdIvIF3aIlz3Lh+ZcIfhxuLSD5i7c9rjn5p06ykUUDISncP7j9jmPz87Z42TQJomH
         Nfnft/HQdNpQAG7g6qMQpT9fAR9fZjS0Aimkd5dGrmhBDDXCvQdKiPYEpV/rx1L6bsSF
         5Gb1V11oXo5rdOC4qKrdYqPVOuwbEBLlm5Qfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690430466; x=1691035266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Od+hrNjQ7cGWCDx5iCpKEnmr3Jo0fGpxHqGp3Cj8bU=;
        b=N8KC4ppaCoO3hlnV0NHaKvDUsmCcm8xtK/nmdwiWSR68U5TFYvC4lyGYl+y7Uy6FTa
         bUmiJKVJRKPIEz4WP3CMyfUlXieEQDU7FCQuM6fECboiigxPkCtEBpWILgkyFnLXXpma
         GfHQw4IS3d4kEJ0kSK9kFySOrx3TAxDg9SxNa6wUN/WO17s5avje0bbzdJX73BklQvks
         4HO/bLVNXzVXpWbSDJn1NUmPRGO2bDpCIn7IIsDK3lDHQARPGF94ioXEfZrLKGVKtKmx
         fm6JU8wP7xu9PAKT05W/JKWYtvANd1xViWzG1xJgnAu3d0jOXOPSsUfAMdLJRia0CvMn
         sgJg==
X-Gm-Message-State: ABy/qLbu086xxTMifaUYBbUj4HNCYVjO/jzATT2wxE/UIB9a2PWQsTzG
        m3TGXmhBscXbhNFQYBCVfN7LZg==
X-Google-Smtp-Source: APBJJlHNM5nM6CLS7+DiRFiZKvW2G23LDF8EAxl7XXkw9k6TnQC3Zf/aA12PRGGykmvXgsAO+Nqusw==
X-Received: by 2002:a05:6e02:1bc4:b0:348:f152:e02b with SMTP id x4-20020a056e021bc400b00348f152e02bmr2708470ilv.5.1690430465868;
        Wed, 26 Jul 2023 21:01:05 -0700 (PDT)
Received: from localhost (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id c2-20020a02a402000000b0042b3bb542aesm153331jal.168.2023.07.26.21.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 21:01:05 -0700 (PDT)
Date:   Thu, 27 Jul 2023 04:01:04 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/183] 6.1.42-rc1 review
Message-ID: <20230727040104.GA3644311@google.com>
References: <20230725104507.756981058@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:43:48PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.42 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.42-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

All RCU testing passes,
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
>     Linux 6.1.42-rc1
> 
> Wayne Lin <wayne.lin@amd.com>
>     drm/amd/display: Add polling method to handle MST reply packet
> 
> Hersen Wu <hersenxs.wu@amd.com>
>     drm/amd/display: fix linux dp link lost handled only one time
> 
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amd/display: Clean up errors & warnings in amdgpu_dm.c
> 
> Qingqing Zhuo <qingqing.zhuo@amd.com>
>     drm/amd/display: force connector state when bpc changes during compliance
> 
> Wayne Lin <Wayne.Lin@amd.com>
>     drm/dp_mst: Clear MSG_RDY flag before sending new message
> 
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amd/display: fix some coding style issues
> 
> Hamza Mahfooz <hamza.mahfooz@amd.com>
>     drm/amd/display: use max_dsc_bpp in amdgpu_dm
> 
> Ilya Leoshkevich <iii@linux.ibm.com>
>     selftests/bpf: Fix sk_assign on s390x
> 
> Yonghong Song <yhs@fb.com>
>     selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code
> 
> Andrii Nakryiko <andrii@kernel.org>
>     selftests/bpf: make test_align selftest more robust
> 
> Andrii Nakryiko <andrii@kernel.org>
>     bpf: aggressively forget precise markings during state checkpointing
> 
> Andrii Nakryiko <andrii@kernel.org>
>     bpf: stop setting precise in current state
> 
> Andrii Nakryiko <andrii@kernel.org>
>     bpf: allow precision tracking for programs with subprogs
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     scripts/kallsyms: update the usage in the comment block
> 
> Yuma Ueda <cyan@0x00a1e9.dev>
>     scripts/kallsyms.c Make the comment up-to-date with current implementation
> 
> Arnd Bergmann <arnd@arndb.de>
>     kallsyms: add kallsyms_seqs_of_names to list of special symbols
> 
> Abe Kohandel <abe.kohandel@intel.com>
>     spi: dw: Remove misleading comment for Mount Evans SoC
> 
> Yunxiang Li <Yunxiang.Li@amd.com>
>     drm/ttm: fix bulk_move corruption when adding a entry
> 
> Mohamed Khalfella <mkhalfella@purestorage.com>
>     tracing/histograms: Return an error if we fail to add histogram to hist_vars list
> 
> Zhang Yi <yi.zhang@huawei.com>
>     jbd2: recheck chechpointing non-dirty buffer
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: phy: prevent stale pointer dereference in phy_init()
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around fastopenq.max_qlen
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around icsk->icsk_user_timeout
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tp->notsent_lowat
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around rskq_defer_accept
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tp->linger2
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around icsk->icsk_syn_retries
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tp->keepalive_probes
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tp->keepalive_intvl
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tp->keepalive_time
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tp->tsoffset
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tp->tcp_tx_delay
> 
> Douglas Anderson <dianders@chromium.org>
>     Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
> 
> Pauli Virtanen <pav@iki.fi>
>     Bluetooth: ISO: fix iso_conn related locking and validity issues
> 
> Pauli Virtanen <pav@iki.fi>
>     Bluetooth: hci_event: call disconnect callback before deleting conn
> 
> Pauli Virtanen <pav@iki.fi>
>     Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: skip bound chain on rule flush
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: skip bound chain in netns release path
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nft_set_pipapo: fix improper element removal
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: can't schedule in nft_chain_validate
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: fix spurious set element insertion failure
> 
> Vitaly Rodionov <vitalyr@opensource.cirrus.com>
>     ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     llc: Don't drop packet from non-root netns.
> 
> Zhang Shurong <zhang_shurong@foxmail.com>
>     fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     Revert "tcp: avoid the lookup process failing to get sk in ehash table"
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>     net:ipv6: check return value of pskb_trim()
> 
> Wang Ming <machel@vivo.com>
>     net: ipv4: Use kfree_sensitive instead of kfree
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tcp_rsk(req)->ts_recent
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data-races around tcp_rsk(req)->txhash
> 
> Antoine Tenart <atenart@kernel.org>
>     net: ipv4: use consistent txhash in TIME_WAIT and SYN_RECV
> 
> Florian Kauer <florian.kauer@linutronix.de>
>     igc: Prevent garbled TX queue with XDP ZEROCOPY
> 
> Kurt Kanzenbach <kurt@linutronix.de>
>     igc: Avoid transmit queue timeout for XDP
> 
> Alexander Duyck <alexanderduyck@fb.com>
>     bpf, arm64: Fix BTI type used for freplace attached functions
> 
> Kumar Kartikeya Dwivedi <memxor@gmail.com>
>     bpf: Repeat check_max_stack_depth for async callbacks
> 
> Kumar Kartikeya Dwivedi <memxor@gmail.com>
>     bpf: Fix subprog idx logic in check_max_stack_depth
> 
> Geetha sowjanya <gakula@marvell.com>
>     octeontx2-pf: Dont allocate BPIDs for LBK interfaces
> 
> Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>     security: keys: Modify mismatched function name
> 
> Ahmed Zaki <ahmed.zaki@intel.com>
>     iavf: fix reset task race with iavf_remove()
> 
> Ahmed Zaki <ahmed.zaki@intel.com>
>     iavf: fix a deadlock caused by rtnl and driver's lock circular dependencies
> 
> Marcin Szycik <marcin.szycik@linux.intel.com>
>     iavf: Wait for reset in callbacks which trigger it
> 
> Przemek Kitszel <przemyslaw.kitszel@intel.com>
>     iavf: make functions static where possible
> 
> Ahmed Zaki <ahmed.zaki@intel.com>
>     iavf: send VLAN offloading caps once after VFR
> 
> Marcin Szycik <marcin.szycik@linux.intel.com>
>     iavf: Move netdev_update_features() into watchdog task
> 
> Ahmed Zaki <ahmed.zaki@intel.com>
>     iavf: use internal state to free traffic IRQs
> 
> Ding Hui <dinghui@sangfor.com.cn>
>     iavf: Fix out-of-bounds when setting channels on remove
> 
> Ding Hui <dinghui@sangfor.com.cn>
>     iavf: Fix use-after-free in free_netdev
> 
> Tristram Ha <Tristram.Ha@microchip.com>
>     net: dsa: microchip: correct KSZ8795 static MAC table access
> 
> Oleksij Rempel <linux@rempel-privat.de>
>     net: dsa: microchip: ksz8_r_sta_mac_table(): Avoid using error code for empty entries
> 
> Oleksij Rempel <linux@rempel-privat.de>
>     net: dsa: microchip: ksz8: Make ksz8_r_sta_mac_table() static
> 
> Oleksij Rempel <linux@rempel-privat.de>
>     net: dsa: microchip: ksz8: Separate static MAC table operations for code reuse
> 
> Victor Nogueira <victor@mojatatu.com>
>     net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
> 
> Victor Nogueira <victor@mojatatu.com>
>     net: sched: cls_u32: Undo refcount decrement in case update failed
> 
> Victor Nogueira <victor@mojatatu.com>
>     net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
> 
> Victor Nogueira <victor@mojatatu.com>
>     net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     ASoC: SOF: ipc3-dtrace: uninitialized data in dfsentry_trace_filter_write()
> 
> Shyam Prasad N <nspmangalore@gmail.com>
>     cifs: fix mid leak during reconnection after timeout threshold
> 
> Daniel Golle <daniel@makrotopia.org>
>     net: ethernet: mtk_eth_soc: handle probe deferral
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     bridge: Add extack warning when enabling STP in netns.
> 
> Tanmay Patil <t-patil@ti.com>
>     net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()
> 
> Linus Walleij <linus.walleij@linaro.org>
>     dsa: mv88e6xxx: Do a final check before timing out
> 
> Yonghong Song <yhs@fb.com>
>     kallsyms: strip LTO-only suffixes from promoted global functions
> 
> Zhen Lei <thunder.leizhen@huawei.com>
>     kallsyms: Correctly sequence symbols when CONFIG_LTO_CLANG=y
> 
> Zhen Lei <thunder.leizhen@huawei.com>
>     kallsyms: Improve the performance of kallsyms_lookup_name()
> 
> Jaewon Kim <jaewon02.kim@samsung.com>
>     spi: s3c64xx: clear loopback bit after loopback test
> 
> Christoph Hellwig <hch@lst.de>
>     btrfs: be a bit more careful when setting mirror_num_ret in btrfs_map_block
> 
> James Clark <james.clark@arm.com>
>     perf build: Fix library not found error when using CSLIBS
> 
> Yangtao Li <frank.li@vivo.com>
>     fbdev: imxfb: Removed unneeded release_mem_region
> 
> Martin Kaiser <martin@kaiser.cx>
>     fbdev: imxfb: warn about invalid left/right margin
> 
> Jonas Gorski <jonas.gorski@gmail.com>
>     spi: bcm63xx: fix max prepend length
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>     pinctrl: renesas: rzg2l: Handle non-unique subnode names
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     pinctrl: renesas: rzv2m: Handle non-unique subnode names
> 
> Suren Baghdasaryan <surenb@google.com>
>     sched/psi: use kernfs polling functions for PSI trigger polling
> 
> Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>     sched/psi: Allow unprivileged polling of N*2s period
> 
> Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>     sched/psi: Extract update_triggers side effect
> 
> Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>     sched/psi: Rename existing poll members in preparation
> 
> Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>     sched/psi: Rearrange polling code in preparation
> 
> Chengming Zhou <zhouchengming@bytedance.com>
>     sched/psi: Fix avgs_work re-arm in psi_avgs_work()
> 
> Miaohe Lin <linmiaohe@huawei.com>
>     sched/fair: Use recent_used_cpu to test p->cpus_ptr
> 
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>     ASoC: qcom: q6apm: do not close GPR port before closing graph
> 
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>     ASoC: codecs: wcd938x: fix dB range for HPHL and HPHR
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: codecs: wcd938x: fix mbhc impedance loglevel
> 
> Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>     ASoC: amd: acp: fix for invalid dai id handling in acp_get_byte_count()
> 
> Hao Chen <chenhao418@huawei.com>
>     net: hns3: fix strncpy() not using dest-buf length as length issue
> 
> Ying Hsu <yinghsu@chromium.org>
>     igb: Fix igb_down hung on surprise removal
> 
> Yi Kuo <yi@yikuo.dev>
>     wifi: iwlwifi: pcie: add device id 51F1 for killer 1675
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: iwlwifi: mvm: avoid baid size integer overflow
> 
> Mukesh Sisodiya <mukesh.sisodiya@intel.com>
>     wifi: iwlwifi: Add support for new PCI Id
> 
> Gustavo A. R. Silva <gustavoars@kernel.org>
>     wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()
> 
> Petr Oros <poros@redhat.com>
>     devlink: report devlink_port_type_warn source device
> 
> Jisheng Zhang <jszhang@kernel.org>
>     net: ethernet: litex: add support for 64 bit stats
> 
> P Praneesh <quic_ppranees@quicinc.com>
>     wifi: ath11k: fix memory leak in WMI firmware stats
> 
> Abe Kohandel <abe.kohandel@intel.com>
>     spi: dw: Add compatible for Intel Mount Evans SoC
> 
> Ilan Peer <ilan.peer@intel.com>
>     wifi: mac80211_hwsim: Fix possible NULL dereference
> 
> Wen Gong <quic_wgong@quicinc.com>
>     wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855
> 
> Aditi Ghag <aditi.ghag@isovalent.com>
>     bpf: tcp: Avoid taking fast sock lock in iterator
> 
> Martin KaFai Lau <martin.lau@kernel.org>
>     bpf: Address KCSAN report on bpf_lru_list
> 
> Kui-Feng Lee <thinker.li@gmail.com>
>     bpf: Print a warning only if writing to unprivileged_bpf_disabled.
> 
> Maxime Bizon <mbizon@freebox.fr>
>     wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range
> 
> Yicong Yang <yangyicong@hisilicon.com>
>     sched/fair: Don't balance task to its current running CPU
> 
> Paul E. McKenney <paulmck@kernel.org>
>     rcu: Mark additional concurrent load from ->cpu_no_qs.b.exp
> 
> Shigeru Yoshida <syoshida@redhat.com>
>     rcu-tasks: Avoid pr_info() with spin lock in cblist_init_generic()
> 
> Hans de Goede <hdegoede@redhat.com>
>     ACPI: video: Add backlight=native DMI quirk for Dell Studio 1569
> 
> Immad Mir <mirimmad17@gmail.com>
>     FS: JFS: Check for read-only mounted filesystem in txBegin
> 
> Immad Mir <mirimmad17@gmail.com>
>     FS: JFS: Fix null-ptr-deref Read in txBegin
> 
> Gustavo A. R. Silva <gustavoars@kernel.org>
>     MIPS: dec: prom: Address -Warray-bounds warning
> 
> Yogesh <yogi.kernel@gmail.com>
>     fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev
> 
> Jan Kara <jack@suse.cz>
>     udf: Fix uninitialized array access for some pathnames
> 
> Christian Brauner <brauner@kernel.org>
>     ovl: check type and offset of struct vfsmount in ovl_entry
> 
> Marco Morandini <marco.morandini@polimi.it>
>     HID: add quirk for 03f0:464a HP Elite Presenter Mouse
> 
> Ye Bin <yebin10@huawei.com>
>     quota: fix warning in dqgrab()
> 
> Jan Kara <jack@suse.cz>
>     quota: Properly disable quotas when add_dquot_ref() fails
> 
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>     ALSA: emu10k1: roll up loops in DSP setup code for Audigy
> 
> hackyzh002 <hackyzh002@gmail.com>
>     drm/radeon: Fix integer overflow in radeon_cs_parser_init
> 
> Eric Whitney <enwlinux@gmail.com>
>     ext4: correct inline offset when handling xattrs in inode body
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: codecs: wcd938x: fix soundwire initialisation race
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: codecs: wcd938x: fix codec initialisation race
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: codecs: wcd934x: fix resource leaks on component remove
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: codecs: wcd938x: fix missing mbhc init error handling
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: codecs: wcd938x: fix resource leaks on component remove
> 
> Sheetal <sheetal@nvidia.com>
>     ASoC: tegra: Fix AMX byte map
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: qdsp6: audioreach: fix topology probe deferral
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: codecs: wcd-mbhc-v2: fix resource leaks on component remove
> 
> Johan Hovold <johan+linaro@kernel.org>
>     ASoC: codecs: wcd938x: fix missing clsh ctrl error handling
> 
> Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>     ASoC: cs42l51: fix driver to properly autoload with automatic module loading
> 
> Sameer Pujar <spujar@nvidia.com>
>     ASoC: rt5640: Fix sleep in atomic context
> 
> Sheetal <sheetal@nvidia.com>
>     ASoC: tegra: Fix ADX byte map
> 
> Fabio Estevam <festevam@denx.de>
>     ASoC: fsl_sai: Revert "ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode"
> 
> Matus Gajdos <matuszpd@gmail.com>
>     ASoC: fsl_sai: Disable bit clock with transmitter
> 
> Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>     drm/amd/display: Keep PHY active for DP displays on DCN31
> 
> Taimur Hassan <syed.hassan@amd.com>
>     drm/amd/display: check TG is non-null before checking if enabled
> 
> Zhikai Zhai <zhikai.zhai@amd.com>
>     drm/amd/display: Disable MPC split by default on special asic
> 
> Simon Ser <contact@emersion.fr>
>     drm/amd/display: only accept async flips for fast updates
> 
> Jocelyn Falempe <jfalempe@redhat.com>
>     drm/client: Fix memory leak in drm_client_modeset_probe
> 
> Jocelyn Falempe <jfalempe@redhat.com>
>     drm/client: Fix memory leak in drm_client_target_cloned
> 
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu/pm: make mclk consistent for smu 13.0.7
> 
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu/pm: make gfxclock consistent for sienna cichlid
> 
> Guchun Chen <guchun.chen@amd.com>
>     drm/amdgpu/vkms: relax timer deactivation by hrtimer_try_to_cancel
> 
> Ville Syrjälä <ville.syrjala@linux.intel.com>
>     dma-buf/dma-resv: Stop leaking on krealloc() failure
> 
> Matthieu Baerts <matthieu.baerts@tessares.net>
>     selftests: tc: add ConnTrack procfs kconfig
> 
> Marc Kleine-Budde <mkl@pengutronix.de>
>     can: gs_usb: gs_can_open(): improve error handling
> 
> YueHaibing <yuehaibing@huawei.com>
>     can: bcm: Fix UAF in bcm_proc_show()
> 
> Fedor Ross <fedor.ross@ifm.com>
>     can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout
> 
> Mark Brown <broonie@kernel.org>
>     arm64/fpsimd: Ensure SME storage is allocated after SVE VL changes
> 
> Mark Brown <broonie@kernel.org>
>     regmap: Account for register length in SMBus I/O limits
> 
> Rob Herring <robh@kernel.org>
>     of: Preserve "of-display" device name for compatibility
> 
> Mark Brown <broonie@kernel.org>
>     regmap: Drop initial version of maximum transfer length fixes
> 
> Matthieu Baerts <matthieu.baerts@tessares.net>
>     selftests: tc: add 'ct' action kconfig dep
> 
> Matthieu Baerts <matthieu.baerts@tessares.net>
>     selftests: tc: set timeout to 15 minutes
> 
> Josef Bacik <josef@toxicpanda.com>
>     btrfs: fix race between balance and cancel/pause
> 
> Miklos Szeredi <mszeredi@redhat.com>
>     fuse: ioctl: translate ENOSYS in outarg
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: zoned: fix memory leak after finding block group with super blocks
> 
> Josef Bacik <josef@toxicpanda.com>
>     btrfs: set_page_extent_mapped after read_folio in btrfs_cont_expand
> 
> Bernd Schubert <bschubert@ddn.com>
>     fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT
> 
> Miklos Szeredi <mszeredi@redhat.com>
>     fuse: revalidate: don't invalidate if interrupted
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix warning when putting transaction with qgroups enabled after abort
> 
> Georg Müller <georgmueller@gmx.net>
>     perf probe: Add test for regression introduced by switch to die_get_decl_file()
> 
> Petr Pavlu <petr.pavlu@suse.com>
>     keys: Fix linking a duplicate key to a keyring's assoc_array
> 
> Liam R. Howlett <Liam.Howlett@oracle.com>
>     maple_tree: fix node allocation testing on 32 bit
> 
> Peng Zhang <zhangpeng.00@bytedance.com>
>     maple_tree: set the node limit when creating a new root node
> 
> Luka Guzenko <l.guzenko@web.de>
>     ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx
> 
> Christoffer Sandberg <cs@tuxedo.de>
>     ALSA: hda/realtek: Add quirk for Clevo NS70AU
> 
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek - remove 3k pull low procedure
> 
> Jens Axboe <axboe@kernel.dk>
>     io_uring: treat -EAGAIN for REQ_F_NOWAIT as final for io-wq
> 
> 
> -------------
> 
> Diffstat:
> 
>  Documentation/accounting/psi.rst                   |   4 +
>  Makefile                                           |   4 +-
>  arch/arm64/kernel/fpsimd.c                         |  33 +-
>  arch/arm64/net/bpf_jit_comp.c                      |   8 +-
>  arch/mips/include/asm/dec/prom.h                   |   2 +-
>  drivers/acpi/video_detect.c                        |   8 +
>  drivers/base/regmap/regmap-i2c.c                   |   8 +-
>  drivers/base/regmap/regmap-spi-avmm.c              |   2 +-
>  drivers/base/regmap/regmap.c                       |   6 +-
>  drivers/dma-buf/dma-resv.c                         |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   5 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 415 ++++++++--------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  12 +
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  12 +
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 125 +++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 121 ++++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.h    |  11 +
>  .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |   5 +
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 141 +-----
>  .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   3 +-
>  .../drm/amd/display/dc/dcn303/dcn303_resource.c    |   2 +-
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h        |   6 +
>  drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |   4 +
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   8 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   2 +-
>  drivers/gpu/drm/display/drm_dp_mst_topology.c      |  54 ++-
>  drivers/gpu/drm/drm_client_modeset.c               |   6 +
>  drivers/gpu/drm/i915/display/intel_dp.c            |   7 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c            |  12 +-
>  drivers/gpu/drm/radeon/radeon_cs.c                 |   3 +-
>  drivers/gpu/drm/ttm/ttm_resource.c                 |   5 +-
>  drivers/hid/hid-ids.h                              |   1 +
>  drivers/hid/hid-quirks.c                           |   1 +
>  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  10 +-
>  drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   1 +
>  drivers/net/can/usb/gs_usb.c                       |  31 +-
>  drivers/net/dsa/microchip/ksz8.h                   |   2 -
>  drivers/net/dsa/microchip/ksz8795.c                | 121 +++--
>  drivers/net/dsa/microchip/ksz_common.c             |   8 +-
>  drivers/net/dsa/microchip/ksz_common.h             |   7 +
>  drivers/net/dsa/mv88e6xxx/chip.c                   |   7 +
>  drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  33 +-
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  29 +-
>  drivers/net/ethernet/intel/iavf/iavf.h             |  16 +-
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  39 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c        | 232 ++++++---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c        |  43 +-
>  drivers/net/ethernet/intel/iavf/iavf_txrx.h        |   4 -
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   8 +-
>  drivers/net/ethernet/intel/igb/igb_main.c          |   5 +
>  drivers/net/ethernet/intel/igc/igc_main.c          |  12 +-
>  drivers/net/ethernet/litex/litex_liteeth.c         |  19 +-
>  .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   5 +-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  29 +-
>  drivers/net/ethernet/ti/cpsw_ale.c                 |  24 +-
>  drivers/net/phy/phy_device.c                       |  21 +-
>  drivers/net/wireless/ath/ath11k/core.c             |  53 +-
>  drivers/net/wireless/ath/ath11k/mac.c              |   3 +-
>  drivers/net/wireless/ath/ath11k/wmi.c              |   5 +
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   2 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   4 +
>  drivers/net/wireless/mac80211_hwsim.c              |   4 +-
>  drivers/of/platform.c                              |   2 +-
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  28 +-
>  drivers/pinctrl/renesas/pinctrl-rzv2m.c            |  28 +-
>  drivers/spi/spi-bcm63xx.c                          |   2 +-
>  drivers/spi/spi-dw-mmio.c                          |  22 +
>  drivers/spi/spi-s3c64xx.c                          |   2 +
>  drivers/video/fbdev/au1200fb.c                     |   3 +
>  drivers/video/fbdev/imxfb.c                        |   5 +-
>  fs/btrfs/block-group.c                             |   1 +
>  fs/btrfs/inode.c                                   |  14 +-
>  fs/btrfs/qgroup.c                                  |   1 +
>  fs/btrfs/volumes.c                                 |  20 +-
>  fs/ext4/xattr.c                                    |  14 +
>  fs/fuse/dir.c                                      |   2 +-
>  fs/fuse/inode.c                                    |   5 +-
>  fs/fuse/ioctl.c                                    |  21 +-
>  fs/jbd2/checkpoint.c                               | 102 ++--
>  fs/jfs/jfs_dmap.c                                  |   3 +
>  fs/jfs/jfs_txnmgr.c                                |   5 +
>  fs/jfs/namei.c                                     |   5 +
>  fs/overlayfs/ovl_entry.h                           |   9 +
>  fs/quota/dquot.c                                   |   5 +-
>  fs/smb/client/connect.c                            |  19 +-
>  fs/udf/unicode.c                                   |   2 +-
>  include/drm/display/drm_dp_mst_helper.h            |   7 +-
>  include/linux/psi.h                                |   5 +-
>  include/linux/psi_types.h                          |  45 +-
>  include/linux/tcp.h                                |   2 +-
>  include/net/bluetooth/hci_core.h                   |   5 +
>  include/net/ip.h                                   |   2 +-
>  include/net/tcp.h                                  |  31 +-
>  io_uring/io_uring.c                                |   8 +
>  kernel/bpf/bpf_lru_list.c                          |  21 +-
>  kernel/bpf/bpf_lru_list.h                          |   7 +-
>  kernel/bpf/syscall.c                               |   3 +-
>  kernel/bpf/verifier.c                              | 234 ++++++++-
>  kernel/cgroup/cgroup.c                             |   2 +-
>  kernel/kallsyms.c                                  |  91 +++-
>  kernel/kallsyms_internal.h                         |   1 +
>  kernel/rcu/tasks.h                                 |   5 +-
>  kernel/rcu/tree_exp.h                              |   2 +-
>  kernel/rcu/tree_plugin.h                           |   4 +-
>  kernel/sched/fair.c                                |   4 +-
>  kernel/sched/psi.c                                 | 540 ++++++++++++---------
>  kernel/trace/trace_events_hist.c                   |   3 +-
>  lib/maple_tree.c                                   |   3 +-
>  net/bluetooth/hci_conn.c                           |  10 +-
>  net/bluetooth/hci_core.c                           |  42 +-
>  net/bluetooth/hci_event.c                          |  15 +-
>  net/bluetooth/hci_sync.c                           | 121 ++++-
>  net/bluetooth/iso.c                                |  55 ++-
>  net/bluetooth/mgmt.c                               |  26 +-
>  net/bridge/br_stp_if.c                             |   3 +
>  net/can/bcm.c                                      |  12 +-
>  net/core/devlink.c                                 |   5 +-
>  net/ipv4/esp4.c                                    |   2 +-
>  net/ipv4/inet_connection_sock.c                    |   2 +-
>  net/ipv4/inet_hashtables.c                         |  17 +-
>  net/ipv4/inet_timewait_sock.c                      |   8 +-
>  net/ipv4/ip_output.c                               |   4 +-
>  net/ipv4/tcp.c                                     |  57 +--
>  net/ipv4/tcp_fastopen.c                            |   6 +-
>  net/ipv4/tcp_ipv4.c                                |  27 +-
>  net/ipv4/tcp_minisocks.c                           |  11 +-
>  net/ipv4/tcp_output.c                              |   6 +-
>  net/ipv6/ip6_gre.c                                 |   3 +-
>  net/ipv6/tcp_ipv6.c                                |   4 +-
>  net/llc/llc_input.c                                |   3 -
>  net/netfilter/nf_tables_api.c                      |  12 +-
>  net/netfilter/nft_set_pipapo.c                     |   6 +-
>  net/sched/cls_bpf.c                                |  99 ++--
>  net/sched/cls_matchall.c                           |  35 +-
>  net/sched/cls_u32.c                                |  48 +-
>  net/wireless/wext-core.c                           |   6 +
>  scripts/kallsyms.c                                 |  75 ++-
>  scripts/link-vmlinux.sh                            |   4 +
>  security/keys/request_key.c                        |  35 +-
>  security/keys/trusted-keys/trusted_tpm2.c          |   2 +-
>  sound/pci/emu10k1/emufx.c                          | 112 +----
>  sound/pci/hda/patch_realtek.c                      |  54 ++-
>  sound/soc/amd/acp/amd.h                            |   7 +-
>  sound/soc/codecs/cs42l51-i2c.c                     |   6 +
>  sound/soc/codecs/cs42l51.c                         |   7 -
>  sound/soc/codecs/cs42l51.h                         |   1 -
>  sound/soc/codecs/rt5640.c                          |  12 +-
>  sound/soc/codecs/wcd-mbhc-v2.c                     |  57 ++-
>  sound/soc/codecs/wcd934x.c                         |  12 +
>  sound/soc/codecs/wcd938x.c                         |  86 +++-
>  sound/soc/fsl/fsl_sai.c                            |   8 +-
>  sound/soc/fsl/fsl_sai.h                            |   1 +
>  sound/soc/qcom/qdsp6/q6apm.c                       |   7 +-
>  sound/soc/qcom/qdsp6/topology.c                    |   4 +-
>  sound/soc/sof/ipc3-dtrace.c                        |   9 +-
>  sound/soc/tegra/tegra210_adx.c                     |  34 +-
>  sound/soc/tegra/tegra210_amx.c                     |  40 +-
>  tools/perf/Makefile.config                         |   4 +-
>  .../tests/shell/test_uprobe_from_different_cu.sh   |  77 +++
>  tools/testing/radix-tree/maple.c                   |   6 +-
>  tools/testing/selftests/bpf/prog_tests/align.c     |  38 +-
>  tools/testing/selftests/bpf/prog_tests/sk_assign.c |  25 +-
>  tools/testing/selftests/bpf/progs/connect4_prog.c  |   2 +-
>  tools/testing/selftests/bpf/progs/test_sk_assign.c |  11 +
>  .../selftests/bpf/progs/test_sk_assign_libbpf.c    |   3 +
>  tools/testing/selftests/tc-testing/config          |   2 +
>  tools/testing/selftests/tc-testing/settings        |   1 +
>  167 files changed, 2997 insertions(+), 1561 deletions(-)
> 
> 
