Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D475835A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjGRRS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjGRRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:18:21 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F4188
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:18:16 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3461053677eso13298035ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689700696; x=1692292696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ctbkx4X1LjMo4HTVQmxd4Bm1HQxqf5O7FTft/2fMrjM=;
        b=ZFttPMGt5/HQc0Pg2uYZ5oguvaRCHaYa4r6731y8+bOx6FRDJB30HYWA+0cQaaA0Uf
         Js8G8YrTB/09WIIgOjevdwDYkMmG1RJcSccs7CzQj7E7BE7X1MloKo5gFEa+StrGrp9N
         WhXXga5A5OmixT77pnUNW+TDLtmKeb5J7CkIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689700696; x=1692292696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ctbkx4X1LjMo4HTVQmxd4Bm1HQxqf5O7FTft/2fMrjM=;
        b=HGpBAwV1326550xX4Kpr/nJXZF1UKDoCJVmKNwVrWVwLLpdtFh91PeozhZ3bIJMElG
         y4EsJh0/17VMAG9zrG/ZBeiRM9F6DD+GI9+c/Y6my+ugUHeELQi1vOVyfieOS0SPhIsd
         8KvpMQzxJKLx18dlZXUvpv8t+RbzRdV6CXGZGXbHfgkZ06stvkzMuOyRvhRkNCbfx1VJ
         V5/ZwPydUJJUV2rN8Vw++7S8opX/QjusQNojmWHBPrKrGOkXvbH+aIaBJqgX3WvNrnhz
         4wNZ9LXv7rs28Xh94Vi69SdZpwaPXttiU6CXaaqhHuPC+ehrEuZKN5W7Xf5MFLhnvRZx
         L82A==
X-Gm-Message-State: ABy/qLZ0hn8k0RP+AvQPj4CtbBtitZfUV/Vysm/g2eW4xlN2eMiOudAK
        DNst6aTKYEvbMSzSedxEHEMx5Q==
X-Google-Smtp-Source: APBJJlFmU02ZmWuzRfHvb7HWpBvMBvJueDMNcuON6He3o+MMbI1V32GDlbj2dMPu8z7EKEeGkPgigA==
X-Received: by 2002:a92:d9d1:0:b0:348:8da5:87a0 with SMTP id n17-20020a92d9d1000000b003488da587a0mr1758376ilq.9.1689700695027;
        Tue, 18 Jul 2023 10:18:15 -0700 (PDT)
Received: from localhost (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id j7-20020a926e07000000b00345cce526cdsm814864ilc.54.2023.07.18.10.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 10:18:13 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:18:12 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
Message-ID: <20230718171812.GA3072320@google.com>
References: <20230717201547.359923764@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717201547.359923764@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:34:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

LGTM from an RCU viewpoint. Test results below.

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

 --- Tue Jul 18 07:30:56 AM UTC 2023 Test summary:
Results directory:
/usr/local/google/home/joelaf/.jenkins/workspace/rcutorture_stable_linux-6.1.y/tools/testing/selftests/rcutorture/res/2023.07.18-04.00.14
tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 48 --duration 60
RUDE01 ------- 21491 GPs (5.96972/s) [tasks-rude: g0 f0x0 total-gps=0] n_max_cbs: 50000
SRCU-N ------- 159237 GPs (44.2325/s) [srcu: g1855348 f0x0 total-gps=1855348] n_max_cbs: 150000
SRCU-P ------- 125492 GPs (34.8589/s) [srcud: g1149832 f0x0 total-gps=1149832] n_max_cbs: 150000
SRCU-T ------- 391366 GPs (108.713/s) [srcu: g3548634 f0x0 total-gps=3548634] n_max_cbs: 24350
SRCU-U ------- 377745 GPs (104.929/s) [srcud: g3422740 f0x0 total-gps=3422740] n_max_cbs: 15812
TASKS01 ------- 10676 GPs (2.96556/s) [tasks: g0 f0x0 total-gps=0]
TASKS02 ------- 11192 GPs (3.10889/s) [tasks: g0 f0x0 total-gps=0]
TASKS03 ------- 10627 GPs (2.95194/s) [tasks: g0 f0x0 total-gps=0]
TINY01 ------- 320214 GPs (88.9483/s) [rcu: g0 f0x0 total-gps=0] n_max_cbs: 18189
TINY02 ------- 333976 GPs (92.7711/s) [rcu: g0 f0x0 total-gps=0] n_max_cbs: 1059
TRACE01 ------- 11246 GPs (3.12389/s) [tasks-tracing: g0 f0x0 total-gps=0] n_max_cbs: 50000
TRACE02 ------- 112258 GPs (31.1828/s) [tasks-tracing: g0 f0x0 total-gps=0] n_max_cbs: 100000
TREE01 ------- 42502 GPs (11.8061/s) [rcu: g348173 f0x0 total-gps=87324]
TREE02 ------- 162543 GPs (45.1508/s) [rcu: g1620369 f0x0 total-gps=405373] n_max_cbs: 873555
TREE03 ------- 101468 GPs (28.1856/s) [rcu: g2344965 f0x0 total-gps=586514] n_max_cbs: 369608
TREE04 ------- 128256 GPs (35.6267/s) [rcu: g1022457 f0x0 total-gps=255899] n_max_cbs: 3078000
TREE05 ------- 180639 GPs (50.1775/s) [rcu: g1480033 f0x0 total-gps=370284] n_max_cbs: 53753
TREE07 ------- 78943 GPs (21.9286/s) [rcu: g475173 f0x0 total-gps=119068] n_max_cbs: 1133697
TREE09 ------- 267743 GPs (74.3731/s) [rcu: g5061077 f0x0 total-gps=1265563] n_max_cbs: 1064384
 --- Done at Tue Jul 18 07:30:59 AM UTC 2023 (3:30:45) exitcode 0


> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.1.39-rc3
> 
> Andres Freund <andres@anarazel.de>
>     io_uring: Use io_schedule* in cqring wait
> 
> Artur Rojek <contact@artur-rojek.eu>
>     sh: hd64461: Handle virq offset for offchip IRQ base and HD64461 IRQ
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     sh: mach-dreamcast: Handle virq offset in cascaded IRQ demux
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     sh: mach-highlander: Handle virq offset in cascaded IRL demux
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     sh: mach-r2d: Handle virq offset in cascaded IRL demux
> 
> Michael Schmitz <schmitzmic@gmail.com>
>     block/partition: fix signedness issue for Amiga partitions
> 
> Sherry Sun <sherry.sun@nxp.com>
>     tty: serial: fsl_lpuart: add earlycon for imx8ulp platform
> 
> Jason A. Donenfeld <Jason@zx2c4.com>
>     wireguard: netlink: send staged packets when setting initial private key
> 
> Jason A. Donenfeld <Jason@zx2c4.com>
>     wireguard: queueing: use saner cpu selection wrapping
> 
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>     netfilter: nf_tables: prevent OOB access in nft_byteorder_eval
> 
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>     netfilter: nf_tables: do not ignore genmask when looking up chain by id
> 
> Florent Revest <revest@chromium.org>
>     netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: unbind non-anonymous set if rule construction fails
> 
> Lukas Bulwahn <lukas.bulwahn@gmail.com>
>     mtd: parsers: refer to ARCH_BCMBCA instead of ARCH_BCM4908
> 
> Imre Deak <imre.deak@intel.com>
>     drm/i915/tc: Fix system resume MST mode restore for DP-alt sinks
> 
> Imre Deak <imre.deak@intel.com>
>     drm/i915/tc: Fix TC port link ref init for DP MST during HW readout
> 
> Imre Deak <imre.deak@intel.com>
>     drm/i915: Fix TypeC mode initialization during system resume
> 
> Liam R. Howlett <Liam.Howlett@oracle.com>
>     mm/mmap: Fix extra maple tree write
> 
> Darrick J. Wong <djwong@kernel.org>
>     xfs: fix xfs_inodegc_stop racing with mod_delayed_work
> 
> Darrick J. Wong <djwong@kernel.org>
>     xfs: disable reaping in fscounters scrub
> 
> Darrick J. Wong <djwong@kernel.org>
>     xfs: check that per-cpu inodegc workers actually run on that cpu
> 
> Darrick J. Wong <djwong@kernel.org>
>     xfs: explicitly specify cpu when forcing inodegc delayed work to run immediately
> 
> Jan Kara <jack@suse.cz>
>     fs: no need to check source
> 
> Yu Kuai <yukuai3@huawei.com>
>     blktrace: use inline function for blk_trace_remove() while blktrace is disabled
> 
> Christian Marangi <ansuelsmth@gmail.com>
>     leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename
> 
> Arnd Bergmann <arnd@arndb.de>
>     ARM: orion5x: fix d2net gpio initialization
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     ARM: dts: qcom: ipq4019: fix broken NAND controller properties override
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     regulator: tps65219: Fix matching interrupts for their regulators
> 
> Ricardo Ribalda Delgado <ribalda@chromium.org>
>     ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path
> 
> Ricardo Ribalda Delgado <ribalda@chromium.org>
>     ASoC: mediatek: mt8173: Fix irq error path
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix extent buffer leak after tree mod log failure at split_node()
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix race when deleting quota root from the dirty cow roots list
> 
> Naohiro Aota <naota@elisp.net>
>     btrfs: move out now unused BG from the reclaim list
> 
> Naohiro Aota <naota@elisp.net>
>     btrfs: reinsert BGs failed to reclaim
> 
> David Sterba <dsterba@suse.com>
>     btrfs: add block-group tree to lockdep classes
> 
> Naohiro Aota <naota@elisp.net>
>     btrfs: bail out reclaim process if filesystem is read-only
> 
> Naohiro Aota <naota@elisp.net>
>     btrfs: delete unused BGs while reclaiming BGs
> 
> Matt Corallo <blnxfsl@bluematt.me>
>     btrfs: add handling for RAID1C23/DUP to btrfs_reduce_alloc_profile
> 
> Abhijeet Rastogi <abhijeet.1989@gmail.com>
>     ipvs: increase ip_vs_conn_tab_bits range for 64BIT
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     usb: typec: ucsi: Mark dGPUs as DEVICE scope
> 
> Wayne Chang <waynec@nvidia.com>
>     i2c: nvidia-gpu: Remove ccgx,firmware-build property
> 
> Wayne Chang <waynec@nvidia.com>
>     i2c: nvidia-gpu: Add ACPI property to align with device-tree
> 
> Jan Kara <jack@suse.cz>
>     fs: Lock moved directories
> 
> Jan Kara <jack@suse.cz>
>     fs: Establish locking order for unrelated directories
> 
> Jan Kara <jack@suse.cz>
>     Revert "f2fs: fix potential corruption when moving a directory"
> 
> Jan Kara <jack@suse.cz>
>     ext4: Remove ext4 locking of moved directory
> 
> Thomas Weißschuh <linux@weissschuh.net>
>     fs: avoid empty option when generating legacy mount string
> 
> Fabian Frederick <fabf@skynet.be>
>     jffs2: reduce stack usage in jffs2_build_xattr_subsystem()
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>     shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs
> 
> Ryan Roberts <ryan.roberts@arm.com>
>     mm/damon/ops-common: atomically test and clear young on ptes and pmds
> 
> Arnd Bergmann <arnd@arndb.de>
>     autofs: use flexible array in ioctl structure
> 
> Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>     integrity: Fix possible multiple allocation in integrity_inode_get()
> 
> Kees Cook <keescook@chromium.org>
>     um: Use HOST_DIR for mrproper
> 
> Siddh Raman Pant <code@siddh.me>
>     watch_queue: prevent dangling pipe pointer
> 
> Zheng Wang <zyytlz.wz@163.com>
>     bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent
> 
> Zheng Wang <zyytlz.wz@163.com>
>     bcache: Remove unnecessary NULL point check in node allocations
> 
> Mingzhe Zou <mingzhe.zou@easystack.cn>
>     bcache: fixup btree_cache_wait list damage
> 
> Quan Zhou <quan.zhou@mediatek.com>
>     wifi: mt76: mt7921e: fix init command fail with enabled device
> 
> Alexander Wetzel <alexander@wetzel-home.de>
>     wifi: ath10k: Serialize wake_tx_queue ops
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: cfg80211: fix regulatory disconnect for non-MLO
> 
> Chevron Li <chevron.li@bayhubtech.com>
>     mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.
> 
> Ulf Hansson <ulf.hansson@linaro.org>
>     mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS
> 
> Robert Marko <robimarko@gmail.com>
>     mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
> 
> Robert Marko <robimarko@gmail.com>
>     mmc: core: disable TRIM on Kingston EMMC04G-M627
> 
> Jens Axboe <axboe@kernel.dk>
>     io_uring: wait interruptibly for request completions on exit
> 
> Jianmin Lv <lvjianmin@loongson.cn>
>     irqchip/loongson-pch-pic: Fix initialization of HT vector register
> 
> Dai Ngo <dai.ngo@oracle.com>
>     NFSD: add encoding of op_recall flag for write delegation
> 
> Liu Peibao <liupeibao@loongson.cn>
>     irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment
> 
> Shuai Jiang <d202180596@hust.edu.cn>
>     i2c: qup: Add missing unwind goto in qup_i2c_probe()
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: do not BUG_ON() on tree mod log failure at balance_level()
> 
> Alvin Šipraga <alsi@bang-olufsen.dk>
>     extcon: usbc-tusb320: Unregister typec port on driver removal
> 
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>     extcon: usbc-tusb320: Convert to i2c's .probe_new()
> 
> Demi Marie Obenour <demi@invisiblethingslab.com>
>     dm ioctl: Avoid double-fetch of version
> 
> Heinz Mauelshagen <heinzm@redhat.com>
>     dm ioctl: have constant on the right side of the test
> 
> Heinz Mauelshagen <heinzm@redhat.com>
>     dm: avoid split of quoted strings where possible
> 
> Heinz Mauelshagen <heinzm@redhat.com>
>     dm: fix undue/missing spaces
> 
> Robert Hancock <robert.hancock@calian.com>
>     i2c: xiic: Don't try to handle more interrupt events after error
> 
> Danila Chernetsov <listdansp@mail.ru>
>     apparmor: fix missing error check for rhashtable_insert_fast
> 
> Artur Rojek <contact@artur-rojek.eu>
>     sh: dma: Fix DMA channel offset calculation
> 
> Thorsten Winkler <twinkler@linux.ibm.com>
>     s390/qeth: Fix vipa deletion
> 
> David Howells <dhowells@redhat.com>
>     afs: Fix accidental truncation when storing data
> 
> Hariprasad Kelam <hkelam@marvell.com>
>     octeontx-af: fix hardware timestamp configuration
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: sja1105: always enable the send_meta options
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: tag_sja1105: fix MAC DA patching from meta frames
> 
> Guillaume Nault <gnault@redhat.com>
>     pptp: Fix fib lookup calls.
> 
> Woody Zhang <woodylab@foxmail.com>
>     riscv: move memblock_allow_resize() after linear mapping is ready
> 
> Amir Goldstein <amir73il@gmail.com>
>     fanotify: disallow mount/sb marks on kernel internal pseudo fs
> 
> Lin Ma <linma@zju.edu.cn>
>     net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX
> 
> Ilya Maximets <i.maximets@ovn.org>
>     xsk: Honor SO_BINDTODEVICE on bind
> 
> SeongJae Park <sj@kernel.org>
>     bpf, btf: Warn but return no error for NULL btf from __register_btf_kfunc_id_set()
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data races in __tcp_oow_rate_limited()
> 
> Eric Dumazet <edumazet@google.com>
>     net: fix net_dev_start_xmit trace event vs skb_transport_offset()
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=0 bridge mode
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
> 
> Pali Rohár <pali@kernel.org>
>     powerpc: dts: turris1x.dts: Fix PCIe MEM size for pci2 node
> 
> Randy Dunlap <rdunlap@infradead.org>
>     powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y
> 
> Zeng Heng <zengheng4@huawei.com>
>     ntfs: Fix panic about slab-out-of-bounds caused by ntfs_listxattr()
> 
> Hariprasad Kelam <hkelam@marvell.com>
>     octeontx2-af: Add validation before accessing cgx and lmac
> 
> Hariprasad Kelam <hkelam@marvell.com>
>     octeontx2-af: Fix mapping for NIX block from CGX connection
> 
> Chao Yu <chao@kernel.org>
>     f2fs: fix error path handling in truncate_dnode()
> 
> Nishanth Menon <nm@ti.com>
>     mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Don't try to enable secure display TA multiple times
> 
> Christian König <christian.koenig@amd.com>
>     drm/amdgpu: fix number of fence calculations
> 
> Jonas Gorski <jonas.gorski@gmail.com>
>     spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>     mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init
> 
> Pawel Dembicki <paweldembicki@gmail.com>
>     net: dsa: vsc73xx: fix MTU configuration
> 
> Nick Child <nnac123@linux.ibm.com>
>     ibmvnic: Do not reset dql stats on NON_FATAL err
> 
> Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>     Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable
> 
> Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>     Bluetooth: MGMT: Use BIT macro when defining bitfields
> 
> Pauli Virtanen <pav@iki.fi>
>     Bluetooth: MGMT: add CIS feature bits to controller information
> 
> Pauli Virtanen <pav@iki.fi>
>     Bluetooth: ISO: use hci_sync for setting CIG parameters
> 
> Johan Hovold <johan+linaro@kernel.org>
>     Bluetooth: fix invalid-bdaddr quirk for non-persistent setup
> 
> Tobias Heider <me@tobhe.de>
>     Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: sja1105: always enable the INCL_SRCPT option
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: felix: don't drop PTP frames with tag_8021q when RX timestamping is disabled
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: mscc: ocelot: don't keep PTP configuration of all ports in single structure
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: mscc: ocelot: don't report that RX timestamping is enabled by default
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode
> 
> Florian Westphal <fw@strlen.de>
>     net/sched: act_ipt: add sanity checks on skb before calling target
> 
> Xin Long <lucien.xin@gmail.com>
>     net: add a couple of helpers for iph tot_len
> 
> Florian Westphal <fw@strlen.de>
>     net/sched: act_ipt: add sanity checks on table name and hook locations
> 
> Chengfeng Ye <dg573847474@gmail.com>
>     sctp: fix potential deadlock on &net->sctp.addr_wq_lock
> 
> Randy Dunlap <rdunlap@infradead.org>
>     media: cec: i2c: ch7322: also select REGMAP
> 
> Chao Yu <chao@kernel.org>
>     f2fs: check return value of freeze_super()
> 
> Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>     drm/i915/guc/slpc: Apply min softlimit correctly
> 
> Jouni Högander <jouni.hogander@intel.com>
>     drm/i915/psr: Use hw.adjusted mode when calculating io/fast wake times
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
> 
> Li Nan <linan122@huawei.com>
>     md/raid10: fix the condition to call bio_end_io_acct()
> 
> Shuijing Li <shuijing.li@mediatek.com>
>     pwm: mtk_disp: Fix the disable flow of disp_pwm
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     pwm: ab8500: Fix error code in probe()
> 
> Marek Vasut <marex@denx.de>
>     pwm: sysfs: Do not apply state to already disabled PWMs
> 
> Fancy Fang <chen.fang@nxp.com>
>     pwm: imx-tpm: force 'real_period' to be zero in suspend
> 
> Yury Norov <yury.norov@gmail.com>
>     lib/bitmap: drop optimization of bitmap_{from,to}_arr64
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     phy: tegra: xusb: check return value of devm_kzalloc()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     mfd: stmpe: Only disable the regulators if they are enabled
> 
> Yicong Yang <yangyicong@hisilicon.com>
>     hwtracing: hisi_ptt: Fix potential sleep in atomic context
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     clk: qcom: mmcc-msm8974: fix MDSS_GDSC power flags
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     misc: fastrpc: check return value of devm_kasprintf()
> 
> Daniel Golle <daniel@makrotopia.org>
>     cpufreq: mediatek: correct voltages for MT7622 and MT7623
> 
> Christian Borntraeger <borntraeger@linux.ibm.com>
>     KVM: s390/diag: fix racy access of physical cpu number in diag 9c handler
> 
> Pierre Morel <pmorel@linux.ibm.com>
>     KVM: s390: vsie: fix the length of APCB bitmap
> 
> Amelie Delaunay <amelie.delaunay@foss.st.com>
>     mfd: stmfx: Nullify stmfx->vdd in case of error
> 
> Amelie Delaunay <amelie.delaunay@foss.st.com>
>     mfd: stmfx: Fix error path in stmfx_chip_init
> 
> Laurentiu Tudor <laurentiu.tudor@nxp.com>
>     bus: fsl-mc: don't assume child devices are all fsl-mc devices
> 
> Phil Elwell <phil@raspberrypi.com>
>     nvmem: rmem: Use NVMEM_DEVID_AUTO
> 
> Yi Yingao <m202271736@hust.edu.cn>
>     nvmem: sunplus-ocotp: release otp->clk before return
> 
> Matti Vaittinen <mazziesaccount@gmail.com>
>     drivers: fwnode: fix fwnode_irq_get[_byname]()
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     device property: Clarify description of returned value in some functions
> 
> Miaoqian Lin <linmq006@gmail.com>
>     device property: Fix documentation for fwnode_get_next_parent()
> 
> Tony Lindgren <tony@atomide.com>
>     serial: 8250_omap: Use force_suspend and resume for system suspend
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>     mfd: intel-lpss: Add missing check for platform_get_resource
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     mfd: wcd934x: Fix an error handling path in wcd934x_slim_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
> 
> Prashanth K <quic_prashk@quicinc.com>
>     usb: common: usb-conn-gpio: Set last role to unknown before initial detection
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
> 
> Nico Boehr <nrb@linux.ibm.com>
>     KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
> 
> Chao Yu <chao@kernel.org>
>     f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
> 
> Chao Yu <chao@kernel.org>
>     f2fs: fix potential deadlock due to unpaired node_write lock use
> 
> Bob Peterson <rpeterso@redhat.com>
>     gfs2: Fix duplicate should_fault_in_pages() call
> 
> Sergey Shtylyov <s.shtylyov@omp.ru>
>     sh: Avoid using IRQ0 on SH3 and SH4
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var()
> 
> Rikard Falkeborn <rikard.falkeborn@gmail.com>
>     media: venus: helpers: Fix ALIGN() of non power of two
> 
> Stephan Gerhold <stephan@gerhold.net>
>     mfd: rt5033: Drop rt5033-battery sub-device
> 
> James Clark <james.clark@arm.com>
>     coresight: Fix loss of connection info when a module is unloaded
> 
> Clark Wang <xiaoning.wang@nxp.com>
>     i3c: master: svc: fix cpu schedule in spin lock
> 
> Yue Zhao <findns94@gmail.com>
>     lkdtm: replace ll_rw_block with submit_bh
> 
> Muchun Song <muchun.song@linux.dev>
>     kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR
> 
> John Ogness <john.ogness@linutronix.de>
>     serial: 8250: lock port for UART_IER access in omap8250_irq()
> 
> John Ogness <john.ogness@linutronix.de>
>     serial: core: lock port for start_rx() in uart_resume_port()
> 
> John Ogness <john.ogness@linutronix.de>
>     serial: 8250: lock port for stop_rx() in omap8250_irq()
> 
> John Ogness <john.ogness@linutronix.de>
>     serial: core: lock port for stop_rx() in uart_suspend_port()
> 
> Bhupesh Sharma <bhupesh.sharma@linaro.org>
>     usb: misc: eud: Fix eud sysfs path (use 'qcom_eud')
> 
> Arnd Bergmann <arnd@arndb.de>
>     usb: hide unused usbfs_notify_suspend/resume functions
> 
> Li Yang <lidaxian@hust.edu.cn>
>     usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     extcon: Fix kernel doc of property capability fields to avoid warnings
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     extcon: Fix kernel doc of property fields to avoid warnings
> 
> Prashanth K <quic_prashk@quicinc.com>
>     usb: gadget: u_serial: Add null pointer check in gserial_suspend
> 
> Vladislav Efanov <VEfanov@ispras.ru>
>     usb: dwc3: qcom: Fix potential memory leak
> 
> Arnd Bergmann <arnd@arndb.de>
>     staging: vchiq_arm: mark vchiq_platform_init() static
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     clk: qcom: mmcc-msm8974: use clk_rcg2_shared_ops for mdp_clk_src clock
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     clk: qcom: dispcc-qcm2290: Fix BI_TCXO_AO handling
> 
> Robert Marko <robimarko@gmail.com>
>     clk: qcom: ipq6018: fix networking resets
> 
> Robert Marko <robimarko@gmail.com>
>     clk: qcom: reset: support resetting multiple bits
> 
> Yunfei Dong <yunfei.dong@mediatek.com>
>     media: mediatek: vcodec: using decoder status instead of core work count
> 
> Martin Kepplinger <martink@posteo.de>
>     media: hi846: fix usage of pm_runtime_get_if_in_use()
> 
> Daniel Scally <dan.scally@ideasonboard.com>
>     media: i2c: Correct format propagation for st-mipid02
> 
> Duoming Zhou <duoming@zju.edu.cn>
>     media: usb: siano: Fix warning due to null work_func_t function pointer
> 
> Marek Vasut <marex@denx.de>
>     media: videodev2.h: Fix struct v4l2_input tuner index comment
> 
> Ming Qian <ming.qian@nxp.com>
>     media: amphion: initiate a drain of the capture queue in dynamic resolution change
> 
> Ming Qian <ming.qian@nxp.com>
>     media: amphion: drop repeated codec data for vc1g format
> 
> Ming Qian <ming.qian@nxp.com>
>     media: amphion: drop repeated codec data for vc1l format
> 
> Daniil Dulov <d.dulov@aladdin.ru>
>     media: usb: Check az6007_read() return value
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     clk: qcom: gcc-qcm2290: Mark RCGs shared where applicable
> 
> Mantas Pucka <mantas@8devices.com>
>     clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks
> 
> Taniya Das <quic_tdas@quicinc.com>
>     clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     clk: qcom: mmcc-msm8974: remove oxili_ocmemgx_clk
> 
> Tony Lindgren <tony@atomide.com>
>     serial: 8250: omap: Fix freeing of resources on failed register
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     usb: dwc2: Fix some error handling paths
> 
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>     usb: dwc2: platform: Improve error reporting for problems during .remove()
> 
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>     sh: j2: Use ioremap() to translate device tree address into kernel memory
> 
> Yangtao Li <frank.li@vivo.com>
>     f2fs: do not allow to defragment files have FI_COMPRESS_RELEASED
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     dt-bindings: power: reset: qcom-pon: Only allow reboot-mode pre-pmk8350
> 
> Dan Carpenter <error27@gmail.com>
>     w1: fix loop in w1_fini()
> 
> Stefan Wahren <stefan.wahren@i2se.com>
>     w1: w1_therm: fix locking behavior in convert_t
> 
> Ding Hui <dinghui@sangfor.com.cn>
>     SUNRPC: Fix UAF in svc_tcp_listen_data_ready()
> 
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix race when deleting free space root from the dirty cow roots list
> 
> Demi Marie Obenour <demi@invisiblethingslab.com>
>     block: increment diskseq on all media change events
> 
> Michael Schmitz <schmitzmic@gmail.com>
>     block: change all __u32 annotations to __be32 in affs_hardblocks.h
> 
> Michael Schmitz <schmitzmic@gmail.com>
>     block: add overflow checks for Amiga partition support
> 
> Michael Schmitz <schmitzmic@gmail.com>
>     block: fix signed int overflow in Amiga partition support
> 
> Takashi Iwai <tiwai@suse.de>
>     ALSA: pcm: Fix potential data race at PCM memory allocation helpers
> 
> Takashi Iwai <tiwai@suse.de>
>     ALSA: jack: Fix mutex call in snd_jack_report()
> 
> Werner Sembach <wse@tuxedocomputers.com>
>     ALSA: hda/realtek: Add quirk for Clevo NPx0SNx
> 
> Andy Chi <andy.chi@canonical.com>
>     ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on EliteBook
> 
> Suren Baghdasaryan <surenb@google.com>
>     mm/mmap: Fix VM_LOCKED check in do_vmi_align_munmap()
> 
> Hersen Wu <hersenxs.wu@amd.com>
>     Revert "drm/amd/display: edp do not add non-edid timings"
> 
> Sean Nyekjaer <sean@geanix.com>
>     iio: accel: fxls8962af: fixup buffer scan element type
> 
> Sean Nyekjaer <sean@geanix.com>
>     iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF
> 
> Fabrizio Lamarque <fl.scratchpad@gmail.com>
>     iio: adc: ad7192: Fix internal/external clock selection
> 
> Fabrizio Lamarque <fl.scratchpad@gmail.com>
>     iio: adc: ad7192: Fix null ad7192_state pointer access
> 
> EJ Hsu <ejh@nvidia.com>
>     phy: tegra: xusb: Clear the driver reference in usb-phy dev
> 
> Krishna Kurapati <quic_kriskura@quicinc.com>
>     usb: dwc3: gadget: Propagate core init errors to UDC during pullup
> 
> Davide Tronchin <davide.tronchin.94@gmail.com>
>     USB: serial: option: add LARA-R6 01B PIDs
> 
> Yu Kuai <yukuai3@huawei.com>
>     md/raid1-10: fix casting from randomized structure in raid1_submit_write()
> 
> Thomas Gleixner <tglx@linutronix.de>
>     x86/efi: Make efi_set_virtual_address_map IBT safe
> 
> Will Deacon <will@kernel.org>
>     arm64: sme: Use STR P to clear FFR context field in streaming SVE mode
> 
> Arnd Bergmann <arnd@arndb.de>
>     ksmbd: avoid field overflow warning
> 
> Paulo Alcantara <pc@manguebit.com>
>     smb: client: fix broken file attrs with nodfs mounts
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: do all necessary checks for credits within or before locking
> 
> Shyam Prasad N <sprasad@microsoft.com>
>     cifs: prevent use-after-free by freeing the cfile later
> 
> Ard Biesheuvel <ardb@kernel.org>
>     efi/libstub: Disable PCI DMA before grabbing the EFI memory map
> 
> Sami Tolvanen <samitolvanen@google.com>
>     kbuild: Disable GCOV for *.mod.o
> 
> Martin Kaiser <martin@kaiser.cx>
>     hwrng: st - keep clock enabled while hwrng is registered
> 
> Tarun Sahu <tsahu@linux.ibm.com>
>     dax/kmem: Pass valid argument to memory_group_register_static
> 
> Dan Williams <dan.j.williams@intel.com>
>     dax: Introduce alloc_dev_dax_id()
> 
> Dan Williams <dan.j.williams@intel.com>
>     dax: Fix dax_mapping_release() use after free
> 
> Bharath SM <bharathsm@microsoft.com>
>     SMB3: Do not send lease break acknowledgment if all file handles have been closed
> 
> Olga Kornievskaia <kolga@netapp.com>
>     NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION
> 
> Qi Zheng <zhengqi.arch@bytedance.com>
>     NFSv4.2: fix wrong shrinker_id
> 
> Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
>     crypto: qat - unmap buffers before free for RSA
> 
> Hareshx Sankar Raj <hareshx.sankar.raj@intel.com>
>     crypto: qat - unmap buffer before free for DH
> 
> Herbert Xu <herbert@gondor.apana.org.au>
>     crypto: qat - Use helper to set reqsize
> 
> Herbert Xu <herbert@gondor.apana.org.au>
>     crypto: kpp - Add helper to set reqsize
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     modpost: fix off by one in is_executable_section()
> 
> Stephan Müller <smueller@chronox.de>
>     crypto: jitter - correct health test during initialization
> 
> Arnd Bergmann <arnd@arndb.de>
>     crypto: marvell/cesa - Fix type mismatch warning
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     modpost: fix section mismatch message for R_ARM_ABS32
> 
> Randy Dunlap <rdunlap@infradead.org>
>     crypto: nx - fix build warnings when DEBUG_FS is not enabled
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     modpost: remove broken calculation of exception_table_entry size
> 
> Herbert Xu <herbert@gondor.apana.org.au>
>     hwrng: virtio - Fix race on data_avail and actual data
> 
> Eric Farman <farman@linux.ibm.com>
>     vfio/mdev: Move the compat_class initialization to module init
> 
> Xinghui Li <korantli@tencent.com>
>     PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()
> 
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>     PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction
> 
> Shunsuke Mie <mie@igel.co.jp>
>     PCI: endpoint: Fix a Kconfig prompt of vNTB driver
> 
> Shunsuke Mie <mie@igel.co.jp>
>     PCI: endpoint: Fix Kconfig indent style
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>     powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>     powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo
> 
> Tiezhu Yang <yangtiezhu@loongson.cn>
>     riscv: uprobes: Restore thread.bad_cause
> 
> Manivannan Sadhasivam <mani@kernel.org>
>     PCI: qcom: Disable write access to read only registers for IP v2.9.0
> 
> Manivannan Sadhasivam <mani@kernel.org>
>     PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
> 
> Manivannan Sadhasivam <mani@kernel.org>
>     PCI: qcom: Use lower case for hex
> 
> Manivannan Sadhasivam <mani@kernel.org>
>     PCI: qcom: Sort and group registers and bitfield definitions
> 
> Manivannan Sadhasivam <mani@kernel.org>
>     PCI: qcom: Remove PCIE20_ prefix from register definitions
> 
> Aditya Gupta <adityag@linux.ibm.com>
>     powerpc: update ppc_save_regs to save current r1 in pt_regs
> 
> Nicholas Piggin <npiggin@gmail.com>
>     powerpc: simplify ppc_save_regs
> 
> Colin Ian King <colin.i.king@gmail.com>
>     powerpc/powernv/sriov: perform null check on iov before dereferencing iov
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     pinctrl: at91-pio4: check return value of devm_kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     pinctrl: microchip-sgpio: check return value of devm_kasprintf()
> 
> Nicholas Piggin <npiggin@gmail.com>
>     powerpc/64s: Fix VAS mm use after free
> 
> Ian Rogers <irogers@google.com>
>     perf tool x86: Fix perf_env memory leak
> 
> Ravi Bangoria <ravi.bangoria@amd.com>
>     perf tool x86: Consolidate is_amd check into single function
> 
> Michal Wilczynski <michal.wilczynski@intel.com>
>     platform/x86/dell/dell-rbtn: Fix resources leaking on error path
> 
> Namhyung Kim <namhyung@kernel.org>
>     perf dwarf-aux: Fix off-by-one in die_get_varname()
> 
> Mark Pearson <mpearson-lenovo@squebb.ca>
>     platform/x86: thinkpad_acpi: Fix lkp-tests warnings for platform profiles
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>     perf script: Fix allocation of evsel->priv related to per-event dump files
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
>     powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
>     powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare()
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>
>     kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>     pinctrl: npcm7xx: Add missing check for ioremap
> 
> Wells Lu <wellslutw@gmail.com>
>     pinctrl:sunplus: Add check for kmalloc
> 
> Mark Pearson <mpearson-lenovo@squebb.ca>
>     platform/x86: think-lmi: Correct NVME password handling
> 
> Mark Pearson <mpearson-lenovo@squebb.ca>
>     platform/x86: think-lmi: Correct System password interface
> 
> Mark Pearson <mpearson-lenovo@squebb.ca>
>     platform/x86: think-lmi: mutex protection around multiple WMI calls
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     pinctrl: cherryview: Return correct value if pin in push-pull mode
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>     perf bench: Add missing setlocale() call to allow usage of %'d style formatting
> 
> Justin Tee <justin.tee@broadcom.com>
>     scsi: lpfc: Revise NPIV ELS unsol rcv cmpl logic to drop ndlp based on nlp_state
> 
> Sui Jingfeng <suijingfeng@loongson.cn>
>     PCI: Add pci_clear_master() stub for non-CONFIG_PCI
> 
> Wells Lu <wellslutw@gmail.com>
>     pinctrl: sunplus: Add check for kmalloc
> 
> Junyan Ye <yejunyan@hust.edu.cn>
>     PCI: ftpci100: Release the clock resources
> 
> Rongguang Wei <weirongguang@kylinos.cn>
>     PCI: pciehp: Cancel bringup sequence if card is not present
> 
> Yuchen Yang <u202114568@hust.edu.cn>
>     scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()
> 
> Ding Hui <dinghui@sangfor.com.cn>
>     PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free
> 
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: lenovo-yogabook: Set default keyboard backligh brightness on probe()
> 
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: lenovo-yogabook: Reprobe devices on remove()
> 
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: lenovo-yogabook: Fix work race on remove()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors
> 
> Jinhong Zhu <jinhongzhu@hust.edu.cn>
>     scsi: qedf: Fix NULL dereference in error handling
> 
> Nirmal Patel <nirmal.patel@linux.intel.com>
>     PCI: vmd: Reset VMD config register between soft reboots
> 
> Siddharth Vadapalli <s-vadapalli@ti.com>
>     PCI: cadence: Fix Gen2 Link Retraining process
> 
> Syed Saba Kareem <Syed.SabaKareem@amd.com>
>     ASoC: amd: acp: clear pdm dma interrupt mask
> 
> Michael Walle <mwalle@kernel.org>
>     ARM: dts: lan966x: kontron-d10: fix SPI CS
> 
> Michael Walle <mwalle@kernel.org>
>     ARM: dts: lan966x: kontron-d10: fix board reset
> 
> Fei Shao <fshao@chromium.org>
>     clk: Fix memory leak in devm_clk_notifier_register()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     ASoC: imx-audmix: check return value of devm_kasprintf()
> 
> Amir Goldstein <amir73il@gmail.com>
>     ovl: update of dentry revalidate flags after copy up
> 
> Alexey Romanov <avromanov@sberdevices.ru>
>     drivers: meson: secure-pwrc: always enable DMA domain
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     clk: ti: clkctrl: check return value of kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     clk: keystone: sci-clk: check return value of kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     clk: si5341: free unused memory on probe failure
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     clk: si5341: check return value of {devm_}kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     clk: si5341: return error if one synth clock registration fails
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     clk: cdce925: check return value of kasprintf()
> 
> Claudiu Beznea <claudiu.beznea@microchip.com>
>     clk: vc5: check memory returned by kasprintf()
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/msm/dpu: correct MERGE_3D length
> 
> Luben Tuikov <luben.tuikov@amd.com>
>     drm/amdgpu: Fix usage of UMC fill record in RAS
> 
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amdgpu: Fix memcpy() in sienna_cichlid_append_powerplay_table function.
> 
> Nícolas F. R. A. Prado <nfraprado@collabora.com>
>     arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz
> 
> Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>     arm64: dts: mediatek: Add cpufreq nodes for MT8192
> 
> Bjorn Andersson <quic_bjorande@quicinc.com>
>     drm/msm/dp: Free resources after unregistering them
> 
> Jessica Zhang <quic_jesszhan@quicinc.com>
>     drm/msm/dsi: Remove incorrect references to slice_count
> 
> Marijn Suijten <marijn.suijten@somainline.org>
>     drm/msm/dsi: Flip greater-than check for slice_count and slice_per_intf
> 
> Marijn Suijten <marijn.suijten@somainline.org>
>     drm/msm/dsi: Use DSC slice(s) packet size to compute word count
> 
> Jessica Zhang <quic_jesszhan@quicinc.com>
>     drm/msm/dpu: Fix slice_last_group_size calculation
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/msm/dpu: do not enable color-management if DSPPs are not available
> 
> Su Hui <suhui@nfschina.com>
>     ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer
> 
> Yuan Can <yuancan@huawei.com>
>     clk: tegra: tegra124-emc: Fix potential memory leak
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     clk: bcm: rpi: Fix off by one in raspberrypi_discover_clocks()
> 
> Marijn Suijten <marijn.suijten@somainline.org>
>     arm64: dts: qcom: sm8250-edo: Panel framebuffer is 2.5k instead of 4k
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
> 
> Yuxing Liu <lyx2022@hust.edu.cn>
>     clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()
> 
> Zhanhao Hu <zero12113@hust.edu.cn>
>     clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe
> 
> Hao Luo <m202171776@hust.edu.cn>
>     clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe
> 
> Kai Ma <kaima@hust.edu.cn>
>     clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe
> 
> Kashyap Desai <kashyap.desai@broadcom.com>
>     RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context
> 
> Kashyap Desai <kashyap.desai@broadcom.com>
>     RDMA/bnxt_re: wraparound mbox producer index
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/msm/a5xx: really check for A510 in a5xx_gpu_init
> 
> Chia-I Wu <olvaffe@gmail.com>
>     amdgpu: validate offset_in_bo of drm_amdgpu_gem_va
> 
> Bob Pearson <rpearsonhpe@gmail.com>
>     RDMA/rxe: Fix access checks in rxe_check_bind_mw
> 
> Bob Pearson <rpearsonhpe@gmail.com>
>     RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mw.c
> 
> Bob Pearson <rpearsonhpe@gmail.com>
>     RDMA/rxe: Add ibdev_dbg macros for rxe
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     HID: uclogic: Modular KUnit tests should not depend on KUNIT=y
> 
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     drm/radeon: fix possible division-by-zero errors
> 
> Aurabindo Pillai <aurabindo.pillai@amd.com>
>     drm/amd/display: Fix artifacting on eDP panels when engaging freesync video mode
> 
> Chen-Yu Tsai <wenst@chromium.org>
>     soc: mediatek: SVS: Fix MT8192 GPU node name
> 
> Daniil Dulov <d.dulov@aladdin.ru>
>     drm/amdkfd: Fix potential deallocation of previously deallocated memory.
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     drm/amd/display: Fix a test dml32_rq_dlg_get_rq_reg()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     drm/amd/display: Fix a test CalculatePrefetchSchedule()
> 
> Maxime Ripard <maxime@cerno.tech>
>     clk: Export clk_hw_forward_rate_request()
> 
> Christian Lamparter <chunkeey@gmail.com>
>     ARM: dts: BCM5301X: fix duplex-full => full-duplex
> 
> Guenter Roeck <linux@roeck-us.net>
>     hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272
> 
> Tim Harvey <tharvey@gateworks.com>
>     hwmon: (gsc-hwmon) fix fan pwm temperature scaling
> 
> Olivier Moysan <olivier.moysan@foss.st.com>
>     ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx
> 
> Marek Vasut <marex@denx.de>
>     ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2
> 
> Caleb Connolly <caleb.connolly@linaro.org>
>     Input: pm8941-powerkey - fix debounce on gen2+ PMICs
> 
> Keerthy <j-keerthy@ti.com>
>     arm64: dts: ti: k3-j7200: Fix physical address of pin
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
> 
> Kuogee Hsieh <quic_khsieh@quicinc.com>
>     drm/msm/dpu: set DSC flush bit correctly at MDP CTL flush register
> 
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>     arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier
> 
> Chengchang Tang <tangchengchang@huawei.com>
>     RDMA/hns: Fix hns_roce_table_get return value
> 
> Brendan Cunningham <bcunningham@cornelisnetworks.com>
>     IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate
> 
> Arnd Bergmann <arnd@arndb.de>
>     RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes
> 
> Randy Dunlap <rdunlap@infradead.org>
>     soc/fsl/qe: fix usb.c build errors
> 
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>     ARM: dts: meson8: correct uart_B and uart_C clock references
> 
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>     ASoC: es8316: Do not set rate constraints for unsupported MCLKs
> 
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>     ASoC: es8316: Increment max value for ALC Capture Target Volume control
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     ARM: dts: qcom: apq8074-dragonboard: Set DMA as remotely controlled
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     memory: brcmstb_dpfe: fix testing array offset after use
> 
> Marek Vasut <marex@denx.de>
>     ARM: dts: stm32: Shorten the AV96 HDMI sound card name
> 
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: apq8096: fix fixed regulator name property
> 
> Luca Weiss <luca.weiss@fairphone.com>
>     arm64: dts: qcom: pm7250b: add missing spmi-vadc include
> 
> Arnd Bergmann <arnd@arndb.de>
>     ARM: omap2: fix missing tick_broadcast() prototype
> 
> Arnd Bergmann <arnd@arndb.de>
>     ARM: ep93xx: fix missing-prototype warnings
> 
> Dario Binacchi <dario.binacchi@amarulasolutions.com>
>     drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H
> 
> Frieder Schrempf <frieder.schrempf@kontron.de>
>     drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec
> 
> Dave Stevenson <dave.stevenson@raspberrypi.com>
>     drm/bridge: Introduce pre_enable_prev_first to alter bridge init order
> 
> Stephan Gerhold <stephan@gerhold.net>
>     arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion
> 
> Stephan Gerhold <stephan@gerhold.net>
>     arm64: dts: qcom: apq8016-sbc: Fix regulator constraints
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sdm845-polaris: add missing touchscreen child node reg
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sm8350: correct DMA controller unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sm8350: Add GPI DMA compatible fallback
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sdm845: correct camss unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sdm630: correct camss unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: msm8996: correct camss unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: msm8994: correct SPMI unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: msm8916: correct MMC unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: msm8916: correct camss unit address
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     ARM: dts: qcom: msm8974: do not use underscore in node name (again)
> 
> Nícolas F. R. A. Prado <nfraprado@collabora.com>
>     drm/bridge: anx7625: Prevent endless probe loop
> 
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>     drm/bridge: anx7625: Convert to i2c's .probe_new()
> 
> Tony Lindgren <tony@atomide.com>
>     ARM: dts: gta04: Move model property out of pinctrl node
> 
> Biju Das <biju.das.jz@bp.renesas.com>
>     clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write
> 
> Jean-Philippe Brucker <jean-philippe@linaro.org>
>     iommu/virtio: Return size mapped for a detached domain
> 
> Jean-Philippe Brucker <jean-philippe@linaro.org>
>     iommu/virtio: Detach domain on endpoint release
> 
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK
> 
> Vinod Polimera <quic_vpolimer@quicinc.com>
>     drm/msm/disp/dpu: get timing engine status from intf status register
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/msm/dsi: don't allow enabling 14nm VCO with unprogrammed rate
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>     RDMA/bnxt_re: Fix to remove an unnecessary log
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>     RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>     RDMA/bnxt_re: Use unique names while registering interrupts
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>     RDMA/bnxt_re: Fix to remove unnecessary return labels
> 
> Selvin Xavier <selvin.xavier@broadcom.com>
>     RDMA/bnxt_re: Disable/kill tasklet only if it is enabled
> 
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     hwmon: (f71882fg) prevent possible division by zero
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     clk: imx: scu: use _safe list iterator to avoid a use after free
> 
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     drm/bridge: tc358767: Switch to devm MIPI-DSI helpers
> 
> Robert Marko <robert.marko@sartura.hr>
>     arm64: dts: microchip: sparx5: do not use PSCI on reference boards
> 
> Tony Lindgren <tony@atomide.com>
>     bus: ti-sysc: Fix dispc quirk masking bool variables
> 
> Marek Vasut <marex@denx.de>
>     ARM: dts: stm32: Move ethernet MAC EEPROM from SoM to carrier boards
> 
> Maíra Canal <mcanal@igalia.com>
>     drm/vkms: Fix RGB565 pixel conversion
> 
> Maíra Canal <mcanal@igalia.com>
>     drm: Add fixed-point helper to get rounded integer values
> 
> Maíra Canal <mcanal@igalia.com>
>     drm/vkms: isolate pixel conversion functionality
> 
> Bard Liao <yung-chuan.liao@linux.intel.com>
>     ASoC: Intel: sof_sdw: remove SOF_SDW_TGL_HDMI for MeteorLake devices
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     driver: soc: xilinx: use _safe loop iterator to avoid a use after free
> 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/panel: sharp-ls043t1le01: adjust mode settings
> 
> XuDong Liu <m202071377@hust.edu.cn>
>     drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`
> 
> Marek Vasut <marex@denx.de>
>     Input: adxl34x - do not hardcode interrupt trigger type
> 
> Marek Vasut <marek.vasut+renesas@mailbox.org>
>     clk: rs9: Fix .driver_data content in i2c_device_id
> 
> Marek Vasut <marek.vasut+renesas@mailbox.org>
>     clk: vc7: Fix .driver_data content in i2c_device_id
> 
> Marek Vasut <marek.vasut+renesas@mailbox.org>
>     clk: vc5: Fix .driver_data content in i2c_device_id
> 
> Liu Shixin <liushixin2@huawei.com>
>     bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page
> 
> Lars-Peter Clausen <lars@metafoo.de>
>     clk: vc5: Use `clamp()` to restrict PLL range
> 
> Peter Collingbourne <pcc@google.com>
>     mm: call arch_swap_restore() from do_swap_page()
> 
> hfdevel@gmx.net <hfdevel@gmx.net>
>     ARM: dts: meson8b: correct uart_B and uart_C clock references
> 
> Rafał Miłecki <rafal@milecki.pl>
>     ARM: dts: BCM5301X: Drop "clock-names" from the SPI node
> 
> Luc Ma <luc@sietium.com>
>     drm/vram-helper: fix function names in vram helper doc
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: fix THS_TRAILCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: fix TXTAGOCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: fix THS_ZEROCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: fix TCLK_TRAILCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: Add atomic_get_input_bus_fmts() implementation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: fix TCLK_ZEROCNT computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: fix PLL target frequency
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: fix PLL parameters computation
> 
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     drm/bridge: tc358768: always enable HS video mode
> 
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     drm/bridge: ti-sn65dsi83: Fix enable error path
> 
> Luca Weiss <luca@z3ntu.xyz>
>     Input: drv260x - sleep between polling GO bit
> 
> Markus Elfring <elfring@users.sourceforge.net>
>     drm/bridge: it6505: Move a variable assignment behind a null pointer check in receive_timing_debugfs_show()
> 
> Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>     drm/amd/display: Explicitly specify update type per plane info change
> 
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     radeon: avoid double free in ci_dpm_init()
> 
> Wesley Chalmers <Wesley.Chalmers@amd.com>
>     drm/amd/display: Add logging for display MALL refresh setting
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     netlink: Add __sock_i_ino() for __netlink_diag_dump().
> 
> Cambda Zhu <cambda@linux.alibaba.com>
>     ipvlan: Fix return value of ipvlan_queue_xmit()
> 
> Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
>     netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one
> 
> Jeremy Sowden <jeremy@azazel.net>
>     lib/ts_bm: reset initial match offset for every block of text
> 
> Lin Ma <linma@zju.edu.cn>
>     net: nfc: Fix use-after-free caused by nfc_llcp_find_local
> 
> Edward Cree <ecree.xilinx@gmail.com>
>     sfc: fix crash when reading stats while NIC is resetting
> 
> David Howells <dhowells@redhat.com>
>     ocfs2: Fix use of slab data with sendpage
> 
> Maxim Kochetkov <fido_max@inbox.ru>
>     net: axienet: Move reset before 64-bit DMA detection
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     gtp: Fix use-after-free in __gtp_encap_destroy().
> 
> Sabrina Dubroca <sd@queasysnail.net>
>     selftests: rtnetlink: remove netdevsim device after ipsec offload test
> 
> Eric Dumazet <edumazet@google.com>
>     bonding: do not assume skb mac_header is set
> 
> Eric Dumazet <edumazet@google.com>
>     netlink: do not hard code device address lenth in fdb dumps
> 
> Eric Dumazet <edumazet@google.com>
>     netlink: fix potential deadlock in netlink_set_err()
> 
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     net: stmmac: fix double serdes powerdown
> 
> Jimmy Assarsson <extja@kvaser.com>
>     can: kvaser_pciefd: Set hardware timestamp on transmitted packets
> 
> Jimmy Assarsson <extja@kvaser.com>
>     can: kvaser_pciefd: Add function to set skb hwtstamps
> 
> Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>     can: length: fix bitstuffing count
> 
> Gilad Sever <gilad9366@gmail.com>
>     bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings
> 
> Gilad Sever <gilad9366@gmail.com>
>     bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint
> 
> Gilad Sever <gilad9366@gmail.com>
>     bpf: Factor out socket lookup functions for the TC hookpoint.
> 
> Dmitry Antipov <dmantipov@yandex.ru>
>     wifi: ath9k: convert msecs to jiffies where needed
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection
> 
> Marek Vasut <marex@denx.de>
>     mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019
> 
> Ilan Peer <ilan.peer@intel.com>
>     wifi: ieee80211: Fix the common size calculation for reconfiguration ML
> 
> Ilan Peer <ilan.peer@intel.com>
>     wifi: cfg80211/mac80211: Fix ML element common size calculation
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: cfg80211: fix regulatory disconnect with OCB/NAN
> 
> Benjamin Berg <benjamin.berg@intel.com>
>     wifi: cfg80211: drop incorrect nontransmitted BSS update code
> 
> Benjamin Berg <benjamin.berg@intel.com>
>     wifi: cfg80211: rewrite merging of inherited elements
> 
> Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
>     wifi: mac80211: Remove "Missing iftype sband data/EHT cap" spam
> 
> Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>     wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: iwlwifi: pull from TXQs with softirqs disabled
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>     wifi: ath11k: Add missing check for ioremap
> 
> Edwin Peer <edwin.peer@broadcom.com>
>     rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO
> 
> Ilan Peer <ilan.peer@intel.com>
>     wifi: mac80211: Fix permissions for valid_links debugfs entry
> 
> Remi Pommarel <repk@triplefau.lt>
>     wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()
> 
> Arnd Bergmann <arnd@arndb.de>
>     memstick r592: make memstick_debug_get_tpc_name() static
> 
> Douglas Anderson <dianders@chromium.org>
>     mmc: mediatek: Avoid ugly error message when SDIO wakeup IRQ isn't used
> 
> Zhen Lei <thunder.leizhen@huawei.com>
>     kexec: fix a memory leak in crash_shrink_memory()
> 
> Douglas Anderson <dianders@chromium.org>
>     watchdog/perf: more properly prevent false positives with turbo modes
> 
> Douglas Anderson <dianders@chromium.org>
>     watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config
> 
> Haifeng Xu <haifeng.xu@shopee.com>
>     selftests: cgroup: fix unexpected failure on test_memcg_low
> 
> Karol Kolacinski <karol.kolacinski@intel.com>
>     ice: handle extts in the miscellaneous interrupt thread
> 
> Marek Vasut <marex@denx.de>
>     wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
> 
> Marek Vasut <marex@denx.de>
>     wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled
> 
> Jesper Dangaard Brouer <brouer@redhat.com>
>     selftests/bpf: Fix check_mtu using wrong variable type
> 
> Johannes Berg <johannes.berg@intel.com>
>     wifi: mac80211: recalc min chandef for new STA links
> 
> Youghandhar Chintala <quic_youghand@quicinc.com>
>     wifi: ath10k: Trigger STA disconnect after reconfig complete on hardware restart
> 
> Jesper Dangaard Brouer <brouer@redhat.com>
>     samples/bpf: xdp1 and xdp2 reduce XDPBUFSIZE to 60
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>     wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     wifi: ray_cs: Fix an error handling path in ray_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     wifi: wl3501_cs: Fix an error handling path in wl3501_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     wifi: atmel: Fix an error handling path in atmel_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     wifi: orinoco: Fix an error handling path in spectrum_cs_probe()
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     regulator: core: Streamline debugfs operations
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>     regulator: core: Fix more error checking for debugfs_create_dir()
> 
> Alexey Gladkov <legion@kernel.org>
>     selftests/bpf: Do not use sign-file as testcase
> 
> Yafang Shao <laoar.shao@gmail.com>
>     bpf: Fix memleak due to fentry attach failure
> 
> Yafang Shao <laoar.shao@gmail.com>
>     bpf: Remove bpf trampoline selector
> 
> Alan Maguire <alan.maguire@oracle.com>
>     bpftool: JIT limited misreported as negative value on aarch64
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
> 
> Joy Chakraborty <joychakr@google.com>
>     spi: dw: Round of n_bytes to power of 2
> 
> Stanislav Fomichev <sdf@google.com>
>     bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
> 
> Andrii Nakryiko <andrii@kernel.org>
>     libbpf: fix offsetof() and container_of() to work with CO-RE
> 
> Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>     sctp: add bpf_bypass_getsockopt proto callback
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
> 
> Amisha Patel <amisha.patel@microchip.com>
>     wifi: wilc1000: fix for absent RSN capabilities WFA testcase
> 
> Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>     spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG
> 
> Pengcheng Yang <yangpc@wangsu.com>
>     samples/bpf: Fix buffer overflow in tcp_basertt
> 
> Martin KaFai Lau <martin.lau@kernel.org>
>     libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>     wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
> 
> Peter Seiderer <ps.report@gmx.net>
>     wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation
> 
> Jesper Dangaard Brouer <brouer@redhat.com>
>     igc: Enable and fix RX hash usage by netstack
> 
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>     pstore/ram: Add check for kstrdup
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>     ima: Fix build warnings
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>     evm: Fix build warnings
> 
> Roberto Sassu <roberto.sassu@huawei.com>
>     evm: Complete description of evm_inode_setattr()
> 
> Mark Rutland <mark.rutland@arm.com>
>     locking/atomic: arm: fix sync ops
> 
> Juergen Gross <jgross@suse.com>
>     x86/mm: Fix __swp_entry_to_pte() for Xen PV guests
> 
> Ravi Bangoria <ravi.bangoria@amd.com>
>     perf/ibs: Fix interface via core pmu events
> 
> Colin Ian King <colin.i.king@gmail.com>
>     kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined
> 
> Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>     rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale
> 
> Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>     rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
> 
> Paul E. McKenney <paulmck@kernel.org>
>     rcuscale: Move shutdown from wait_event() to wait_event_idle()
> 
> Paul E. McKenney <paulmck@kernel.org>
>     rcutorture: Correct name of use_softirq module parameter
> 
> Paul E. McKenney <paulmck@kernel.org>
>     rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs
> 
> Paul E. McKenney <paulmck@kernel.org>
>     rcu: Make rcu_cpu_starting() rely on interrupts being disabled
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()
> 
> Balsam CHIHI <bchihi@baylibre.com>
>     thermal/drivers/mediatek: Relocate driver to mediatek folder
> 
> Tero Kristo <tero.kristo@linux.intel.com>
>     cpufreq: intel_pstate: Fix energy_performance_preference for passive
> 
> Arnd Bergmann <arnd@arndb.de>
>     ARM: 9303/1: kprobes: avoid missing-declaration warnings
> 
> Ulf Hansson <ulf.hansson@linaro.org>
>     PM: domains: Move the verification of in-params from genpd_add_device()
> 
> Zhang Rui <rui.zhang@intel.com>
>     powercap: RAPL: Fix CONFIG_IOSF_MBI dependency
> 
> Junhao He <hejunhao3@huawei.com>
>     drivers/perf: hisi: Don't migrate perf to the CPU going to teardown
> 
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>     x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()
> 
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>     x86/mm: Allow guest.enc_status_change_prepare() to fail
> 
> Robin Murphy <robin.murphy@arm.com>
>     perf/arm-cmn: Fix DTC reset
> 
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     PM: domains: fix integer overflow issues in genpd_parse_state()
> 
> Feng Mingxi <m202271825@hust.edu.cn>
>     clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe
> 
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().
> 
> Wen Yang <wenyang.linux@foxmail.com>
>     tick/rcu: Fix bogus ratelimit condition
> 
> Thomas Gleixner <tglx@linutronix.de>
>     posix-timers: Prevent RT livelock in itimer_delete()
> 
> Gao Xiang <xiang@kernel.org>
>     erofs: fix compact 4B support for 16k block size
> 
> Gao Xiang <xiang@kernel.org>
>     erofs: simplify iloc()
> 
> Chuck Lever <chuck.lever@oracle.com>
>     svcrdma: Prevent page release when nothing was received
> 
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>     irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
> 
> Antonio Borneo <antonio.borneo@foss.st.com>
>     irqchip/stm32-exti: Fix warning on initialized field overwritten
> 
> Yu Kuai <yukuai3@huawei.com>
>     block: fix blktrace debugfs entries leakage
> 
> Yu Kuai <yukuai3@huawei.com>
>     md/raid1-10: submit write io directly if bitmap is not enabled
> 
> Yu Kuai <yukuai3@huawei.com>
>     md/raid1-10: factor out a helper to submit normal write
> 
> Yu Kuai <yukuai3@huawei.com>
>     md/raid1-10: factor out a helper to add bio to plug
> 
> Li Nan <linan122@huawei.com>
>     md/raid10: fix io loss while replacement replace rdev
> 
> Li Nan <linan122@huawei.com>
>     md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
> 
> Li Nan <linan122@huawei.com>
>     md/raid10: fix wrong setting of max_corr_read_errors
> 
> Li Nan <linan122@huawei.com>
>     md/raid10: fix overflow of md/safe_mode_delay
> 
> Li Nan <linan122@huawei.com>
>     md/raid10: check slab-out-of-bounds in md_bitmap_get_counter
> 
> Chaitanya Kulkarni <kch@nvidia.com>
>     nvme-core: fix dev_pm_qos memleak
> 
> Chaitanya Kulkarni <kch@nvidia.com>
>     nvme-core: add missing fault-injection cleanup
> 
> Sagi Grimberg <sagi@grimberg.me>
>     nvme-auth: don't ignore key generation failures when initializing ctrl keys
> 
> Chaitanya Kulkarni <kch@nvidia.com>
>     nvme-core: fix memory leak in dhchap_ctrl_secret
> 
> Chaitanya Kulkarni <kch@nvidia.com>
>     nvme-core: fix memory leak in dhchap_secret_store
> 
> Sagi Grimberg <sagi@grimberg.me>
>     nvme-auth: no need to reset chap contexts on re-authentication
> 
> Sagi Grimberg <sagi@grimberg.me>
>     nvme-auth: remove symbol export from nvme_auth_reset
> 
> Sagi Grimberg <sagi@grimberg.me>
>     nvme-auth: rename authentication work elements
> 
> Sagi Grimberg <sagi@grimberg.me>
>     nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_dhchap
> 
> NeilBrown <neilb@suse.de>
>     lockd: drop inappropriate svc_get() from locked_get()
> 
> Yu Kuai <yukuai3@huawei.com>
>     blk-mq: fix potential io hang by wrong 'wake_batch'
> 
> Arnd Bergmann <arnd@arndb.de>
>     virt: sevguest: Add CONFIG_CRYPTO dependency
> 
> Tom Lendacky <thomas.lendacky@amd.com>
>     x86/sev: Fix calculation of end address based on number of pages
> 
> Li Nan <linan122@huawei.com>
>     blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost
> 
> Shawn Wang <shawnwang@linux.alibaba.com>
>     x86/resctrl: Only show tasks' pid in current pid namespace
> 
> Gao Xiang <xiang@kernel.org>
>     erofs: kill hooked chains to avoid loops on deduplicated compressed images
> 
> Gao Xiang <xiang@kernel.org>
>     erofs: move zdata.h into zdata.c
> 
> Gao Xiang <xiang@kernel.org>
>     erofs: remove tagged pointer helpers
> 
> Gao Xiang <xiang@kernel.org>
>     erofs: avoid tagged pointers to mark sync decompression
> 
> Gao Xiang <xiang@kernel.org>
>     erofs: clean up cached I/O strategies
> 
> Bart Van Assche <bvanassche@acm.org>
>     block: Fix the type of the second bdev_op_is_zoned_write() argument
> 
> Arnd Bergmann <arnd@arndb.de>
>     fs: pipe: reveal missing function protoypes
> 
> Jeff Layton <jlayton@kernel.org>
>     drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2
> 
> 
> -------------
> 
> Diffstat:
> 
>  Documentation/ABI/testing/sysfs-driver-eud         |   2 +-
>  .../devicetree/bindings/power/reset/qcom,pon.yaml  |   4 +-
>  Documentation/fault-injection/provoke-crashes.rst  |   2 +-
>  Documentation/filesystems/autofs-mount-control.rst |   2 +-
>  Documentation/filesystems/autofs.rst               |   2 +-
>  Documentation/filesystems/directory-locking.rst    |  26 +-
>  Documentation/networking/af_xdp.rst                |   9 +
>  Makefile                                           |   4 +-
>  arch/arc/include/asm/linkage.h                     |   8 +-
>  arch/arm/boot/dts/bcm53015-meraki-mr26.dts         |   2 +-
>  arch/arm/boot/dts/bcm53016-meraki-mr32.dts         |   2 +-
>  arch/arm/boot/dts/bcm5301x.dtsi                    |   1 -
>  arch/arm/boot/dts/iwg20d-q7-common.dtsi            |   2 +-
>  .../boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi  |  16 +-
>  arch/arm/boot/dts/meson8.dtsi                      |   4 +-
>  arch/arm/boot/dts/meson8b.dtsi                     |   4 +-
>  arch/arm/boot/dts/omap3-gta04a5one.dts             |   4 +-
>  arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |   4 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |   8 +-
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi      |  10 +-
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi      |  12 +-
>  arch/arm/boot/dts/qcom-msm8974.dtsi                |   2 +-
>  arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi      |  11 +-
>  arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |   8 +-
>  .../boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi    |   6 +
>  arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi       |   6 -
>  arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   2 +-
>  arch/arm/include/asm/assembler.h                   |  17 +
>  arch/arm/include/asm/sync_bitops.h                 |  29 +-
>  arch/arm/lib/bitops.h                              |  14 +-
>  arch/arm/lib/testchangebit.S                       |   4 +
>  arch/arm/lib/testclearbit.S                        |   4 +
>  arch/arm/lib/testsetbit.S                          |   4 +
>  arch/arm/mach-ep93xx/timer-ep93xx.c                |   3 +-
>  arch/arm/mach-omap2/board-generic.c                |   1 +
>  arch/arm/mach-orion5x/board-dt.c                   |   3 +
>  arch/arm/mach-orion5x/common.h                     |   6 +
>  arch/arm/probes/kprobes/checkers-common.c          |   2 +-
>  arch/arm/probes/kprobes/core.c                     |   2 +-
>  arch/arm/probes/kprobes/opt-arm.c                  |   2 -
>  arch/arm/probes/kprobes/test-core.c                |   2 +-
>  arch/arm/probes/kprobes/test-core.h                |   4 +
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   4 +
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi           |  22 +-
>  arch/arm64/boot/dts/microchip/sparx5.dtsi          |   2 +-
>  .../boot/dts/microchip/sparx5_pcb_common.dtsi      |  12 +
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |  78 +++--
>  arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts       |   4 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi              |   6 +-
>  arch/arm64/boot/dts/qcom/msm8994.dtsi              |   2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +-
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi              |   1 +
>  arch/arm64/boot/dts/qcom/sdm630.dtsi               |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts |   1 +
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |   3 +-
>  .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      |   7 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi               |   8 +-
>  arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |   3 +-
>  .../boot/dts/ti/k3-j7200-common-proc-board.dts     |  28 +-
>  arch/arm64/include/asm/fpsimdmacros.h              |   6 +-
>  arch/powerpc/Kconfig.debug                         |   2 +-
>  arch/powerpc/boot/dts/turris1x.dts                 |   6 +-
>  arch/powerpc/kernel/interrupt.c                    |   3 +-
>  arch/powerpc/kernel/ppc_save_regs.S                |  61 +---
>  arch/powerpc/kernel/signal_32.c                    |  15 +-
>  arch/powerpc/mm/book3s64/radix_pgtable.c           |  34 +-
>  arch/powerpc/mm/init_64.c                          |   2 +-
>  arch/powerpc/platforms/powernv/pci-sriov.c         |   6 +-
>  arch/powerpc/platforms/powernv/vas-window.c        |   2 +-
>  arch/powerpc/platforms/pseries/vas.c               |   2 +-
>  arch/riscv/kernel/probes/uprobes.c                 |   2 +
>  arch/riscv/mm/init.c                               |   4 +-
>  arch/s390/kvm/diag.c                               |   8 +-
>  arch/s390/kvm/kvm-s390.c                           |   4 +
>  arch/s390/kvm/vsie.c                               |   6 +-
>  arch/sh/boards/mach-dreamcast/irq.c                |   6 +-
>  arch/sh/boards/mach-highlander/setup.c             |   4 +-
>  arch/sh/boards/mach-r2d/irq.c                      |   4 +-
>  arch/sh/cchips/Kconfig                             |   4 +-
>  arch/sh/drivers/dma/dma-sh.c                       |  37 +-
>  arch/sh/include/asm/hd64461.h                      |   2 +-
>  arch/sh/include/mach-common/mach/highlander.h      |   2 +-
>  arch/sh/include/mach-common/mach/r2d.h             |   2 +-
>  arch/sh/include/mach-dreamcast/mach/sysasic.h      |   2 +-
>  arch/sh/include/mach-se/mach/se7724.h              |   2 +-
>  arch/sh/kernel/cpu/sh2/probe.c                     |   2 +-
>  arch/sh/kernel/cpu/sh3/entry.S                     |   4 +-
>  arch/um/Makefile                                   |   2 +-
>  arch/x86/coco/tdx/tdx.c                            |  51 ++-
>  arch/x86/events/amd/core.c                         |   2 +-
>  arch/x86/events/amd/ibs.c                          |  53 ++-
>  arch/x86/include/asm/perf_event.h                  |   2 +
>  arch/x86/include/asm/pgtable_64.h                  |   4 +-
>  arch/x86/include/asm/sev.h                         |  16 +-
>  arch/x86/include/asm/x86_init.h                    |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c             |   8 +-
>  arch/x86/kernel/sev.c                              |  14 +-
>  arch/x86/kernel/x86_init.c                         |   2 +-
>  arch/x86/mm/mem_encrypt_amd.c                      |   4 +-
>  arch/x86/mm/pat/set_memory.c                       |   3 +-
>  arch/x86/platform/efi/efi_64.c                     |   6 +-
>  block/blk-iocost.c                                 |   7 +-
>  block/blk-mq-debugfs.c                             |   2 +-
>  block/blk-mq-tag.c                                 |  15 +-
>  block/blk-mq.h                                     |   3 +-
>  block/disk-events.c                                |   1 +
>  block/genhd.c                                      |   5 +-
>  block/partitions/amiga.c                           | 104 +++++-
>  crypto/jitterentropy.c                             |   9 +-
>  drivers/base/power/domain.c                        |  15 +-
>  drivers/base/property.c                            | 132 ++++++--
>  drivers/bus/fsl-mc/dprc-driver.c                   |   6 +
>  drivers/bus/ti-sysc.c                              |   4 +-
>  drivers/char/hw_random/st-rng.c                    |  21 +-
>  drivers/char/hw_random/virtio-rng.c                |  10 +-
>  drivers/clk/bcm/clk-raspberrypi.c                  |   4 +-
>  drivers/clk/clk-cdce925.c                          |  12 +
>  drivers/clk/clk-renesas-pcie.c                     |   2 +-
>  drivers/clk/clk-si5341.c                           |  38 ++-
>  drivers/clk/clk-versaclock5.c                      |  48 ++-
>  drivers/clk/clk-versaclock7.c                      |   2 +-
>  drivers/clk/clk.c                                  |   2 +
>  drivers/clk/imx/clk-imx8mn.c                       |   8 +-
>  drivers/clk/imx/clk-imx8mp.c                       |  24 +-
>  drivers/clk/imx/clk-imx93.c                        |  15 +-
>  drivers/clk/imx/clk-imxrt1050.c                    |  22 +-
>  drivers/clk/imx/clk-scu.c                          |   4 +-
>  drivers/clk/keystone/sci-clk.c                     |   2 +
>  drivers/clk/qcom/camcc-sc7180.c                    |  19 +-
>  drivers/clk/qcom/dispcc-qcm2290.c                  |  12 +-
>  drivers/clk/qcom/gcc-ipq6018.c                     |  34 +-
>  drivers/clk/qcom/gcc-qcm2290.c                     |  62 ++--
>  drivers/clk/qcom/mmcc-msm8974.c                    |  23 +-
>  drivers/clk/qcom/reset.c                           |   4 +-
>  drivers/clk/qcom/reset.h                           |   1 +
>  drivers/clk/renesas/rzg2l-cpg.c                    |   6 +-
>  drivers/clk/renesas/rzg2l-cpg.h                    |   3 -
>  drivers/clk/tegra/clk-tegra124-emc.c               |   2 +
>  drivers/clk/ti/clkctrl.c                           |   7 +
>  drivers/clk/xilinx/clk-xlnx-clock-wizard.c         |   2 +-
>  drivers/clocksource/timer-cadence-ttc.c            |  19 +-
>  drivers/cpufreq/intel_pstate.c                     |   2 +
>  drivers/cpufreq/mediatek-cpufreq.c                 |  13 +-
>  drivers/crypto/marvell/cesa/cipher.c               |   2 +-
>  drivers/crypto/nx/Makefile                         |   2 +-
>  drivers/crypto/nx/nx.h                             |   4 +-
>  drivers/crypto/qat/qat_common/qat_asym_algs.c      |  20 +-
>  drivers/dax/bus.c                                  |  61 ++--
>  drivers/dax/dax-private.h                          |   4 +-
>  drivers/dax/kmem.c                                 |   2 +-
>  drivers/extcon/extcon-usbc-tusb320.c               |  47 ++-
>  drivers/extcon/extcon.c                            |   8 +
>  drivers/firmware/efi/libstub/efi-stub-helper.c     |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  11 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  16 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  13 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  10 +-
>  .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c       |   3 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c           |   3 -
>  .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |   2 +-
>  .../display/dc/dml/dcn32/display_rq_dlg_calc_32.c  |   2 +-
>  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  18 +-
>  drivers/gpu/drm/bridge/analogix/anx7625.c          | 133 +++++---
>  drivers/gpu/drm/bridge/ite-it6505.c                |   3 +-
>  drivers/gpu/drm/bridge/tc358767.c                  |   4 +-
>  drivers/gpu/drm/bridge/tc358768.c                  |  93 +++--
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c              |  20 +-
>  drivers/gpu/drm/display/drm_dp_mst_topology.c      |   2 +-
>  drivers/gpu/drm/drm_bridge.c                       | 145 ++++++--
>  drivers/gpu/drm/drm_gem_vram_helper.c              |   6 +-
>  drivers/gpu/drm/i915/display/intel_ddi.c           |   8 +-
>  drivers/gpu/drm/i915/display/intel_display_types.h |   1 +
>  drivers/gpu/drm/i915/display/intel_psr.c           |   4 +-
>  drivers/gpu/drm/i915/display/intel_tc.c            | 127 +++++--
>  drivers/gpu/drm/i915/display/intel_tc.h            |   3 +-
>  drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c        |   2 +-
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   5 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  10 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  12 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |   2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |   5 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   8 +-
>  drivers/gpu/drm/msm/dp/dp_display.c                |   2 +-
>  drivers/gpu/drm/msm/dsi/dsi_host.c                 |  25 +-
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |   3 +
>  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    |  11 +-
>  drivers/gpu/drm/panel/panel-simple.c               |   4 +-
>  drivers/gpu/drm/radeon/ci_dpm.c                    |  28 +-
>  drivers/gpu/drm/radeon/cypress_dpm.c               |   8 +-
>  drivers/gpu/drm/radeon/ni_dpm.c                    |   8 +-
>  drivers/gpu/drm/radeon/rv740_dpm.c                 |   8 +-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  19 +-
>  drivers/gpu/drm/vkms/vkms_composer.c               |   4 +-
>  drivers/gpu/drm/vkms/vkms_drv.h                    |   4 +-
>  drivers/gpu/drm/vkms/vkms_formats.c                | 131 +++-----
>  drivers/gpu/drm/vkms/vkms_formats.h                |   2 +-
>  drivers/gpu/drm/vkms/vkms_plane.c                  |   2 +-
>  drivers/hid/Kconfig                                |   2 +-
>  drivers/hwmon/f71882fg.c                           |   7 +-
>  drivers/hwmon/gsc-hwmon.c                          |   6 +-
>  drivers/hwmon/pmbus/adm1275.c                      |  52 +--
>  drivers/hwtracing/coresight/coresight-core.c       |   9 +-
>  drivers/hwtracing/ptt/hisi_ptt.c                   |  12 +-
>  drivers/hwtracing/ptt/hisi_ptt.h                   |   2 +
>  drivers/i2c/busses/i2c-designware-pcidrv.c         |  13 +-
>  drivers/i2c/busses/i2c-nvidia-gpu.c                |   7 +-
>  drivers/i2c/busses/i2c-qup.c                       |  21 +-
>  drivers/i2c/busses/i2c-xiic.c                      |   2 +
>  drivers/i3c/master/svc-i3c-master.c                |  19 +-
>  drivers/iio/accel/fxls8962af-core.c                |   8 +-
>  drivers/iio/adc/ad7192.c                           |   8 +-
>  drivers/infiniband/hw/bnxt_re/main.c               |  20 +-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  40 ++-
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  46 ++-
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   1 +
>  drivers/infiniband/hw/hfi1/ipoib_tx.c              |   4 +-
>  drivers/infiniband/hw/hfi1/mmu_rb.c                | 101 +++---
>  drivers/infiniband/hw/hfi1/mmu_rb.h                |   3 +
>  drivers/infiniband/hw/hfi1/sdma.c                  |  23 +-
>  drivers/infiniband/hw/hfi1/sdma.h                  |  47 ++-
>  drivers/infiniband/hw/hfi1/sdma_txreq.h            |   2 +
>  drivers/infiniband/hw/hfi1/user_sdma.c             | 137 +++-----
>  drivers/infiniband/hw/hfi1/user_sdma.h             |   1 -
>  drivers/infiniband/hw/hfi1/vnic_sdma.c             |   4 +-
>  drivers/infiniband/hw/hns/hns_roce_hem.c           |   7 +-
>  drivers/infiniband/hw/irdma/uk.c                   |  10 +-
>  drivers/infiniband/sw/rxe/rxe.h                    |  19 ++
>  drivers/infiniband/sw/rxe/rxe_mw.c                 |  37 +-
>  drivers/input/misc/adxl34x.c                       |   3 +-
>  drivers/input/misc/drv260x.c                       |   1 +
>  drivers/input/misc/pm8941-pwrkey.c                 |  19 +-
>  drivers/iommu/virtio-iommu.c                       |  57 +++-
>  drivers/irqchip/irq-jcore-aic.c                    |   7 +
>  drivers/irqchip/irq-loongson-pch-pic.c             |  10 +-
>  drivers/irqchip/irq-stm32-exti.c                   |  12 +
>  drivers/leds/trigger/ledtrig-netdev.c              |   3 +
>  drivers/mailbox/ti-msgmgr.c                        |  12 +-
>  drivers/md/bcache/btree.c                          |  25 +-
>  drivers/md/bcache/btree.h                          |   1 +
>  drivers/md/bcache/super.c                          |   4 +-
>  drivers/md/bcache/writeback.c                      |  10 +
>  drivers/md/dm-crypt.c                              |   3 +-
>  drivers/md/dm-ioctl.c                              |  43 ++-
>  drivers/md/dm-log-userspace-transfer.c             |   5 +-
>  drivers/md/dm-log.c                                |   3 +-
>  drivers/md/dm-mpath.c                              |   2 +-
>  drivers/md/dm-ps-service-time.c                    |   3 +-
>  drivers/md/dm-raid1.c                              |   7 +-
>  drivers/md/dm-snap-persistent.c                    |   6 +-
>  drivers/md/dm-snap-transient.c                     |   3 +-
>  drivers/md/dm-snap.c                               |  27 +-
>  drivers/md/dm-stripe.c                             |  12 +-
>  drivers/md/dm-table.c                              |  20 +-
>  drivers/md/dm-thin-metadata.c                      |   8 +-
>  drivers/md/dm-uevent.h                             |   2 +-
>  drivers/md/dm-writecache.c                         |   4 +-
>  drivers/md/dm-zoned-metadata.c                     |  14 +-
>  drivers/md/md-bitmap.c                             |  21 +-
>  drivers/md/md-bitmap.h                             |   7 +
>  drivers/md/md.c                                    |   9 +-
>  drivers/md/raid1-10.c                              |  42 +++
>  drivers/md/raid1.c                                 |  25 +-
>  drivers/md/raid10.c                                |  75 ++---
>  drivers/media/cec/i2c/Kconfig                      |   1 +
>  drivers/media/i2c/hi846.c                          |   3 +-
>  drivers/media/i2c/st-mipid02.c                     |   9 +-
>  drivers/media/platform/amphion/vdec.c              |   7 +-
>  drivers/media/platform/amphion/venc.c              |   4 +-
>  drivers/media/platform/amphion/vpu_malone.c        |  12 +
>  drivers/media/platform/amphion/vpu_v4l2.c          |   5 +-
>  drivers/media/platform/amphion/vpu_v4l2.h          |   2 +-
>  .../platform/mediatek/vcodec/vdec_msg_queue.c      |  33 +-
>  .../platform/mediatek/vcodec/vdec_msg_queue.h      |  16 +-
>  drivers/media/platform/qcom/venus/helpers.c        |   4 +-
>  drivers/media/usb/dvb-usb-v2/az6007.c              |   3 +-
>  drivers/media/usb/siano/smsusb.c                   |   3 +-
>  drivers/memory/brcmstb_dpfe.c                      |   4 +-
>  drivers/memstick/host/r592.c                       |   4 +-
>  drivers/mfd/intel-lpss-acpi.c                      |   3 +
>  drivers/mfd/rt5033.c                               |   3 -
>  drivers/mfd/stmfx.c                                |   7 +-
>  drivers/mfd/stmpe.c                                |   4 +-
>  drivers/mfd/wcd934x.c                              |   9 +-
>  drivers/misc/fastrpc.c                             |   3 +
>  drivers/misc/lkdtm/core.c                          |   2 +-
>  drivers/mmc/core/card.h                            |  30 +-
>  drivers/mmc/core/quirks.h                          |  27 ++
>  drivers/mmc/core/sd.c                              |   2 +-
>  drivers/mmc/host/mmci.c                            |   1 +
>  drivers/mmc/host/mtk-sd.c                          |   2 +-
>  drivers/mmc/host/sdhci.c                           |   4 +-
>  drivers/mtd/parsers/Kconfig                        |   2 +-
>  drivers/net/bonding/bond_main.c                    |   2 +-
>  drivers/net/can/kvaser_pciefd.c                    |  39 +--
>  drivers/net/dsa/ocelot/felix.c                     |  12 +
>  drivers/net/dsa/sja1105/sja1105.h                  |   2 +-
>  drivers/net/dsa/sja1105/sja1105_main.c             |  14 +-
>  drivers/net/dsa/sja1105/sja1105_ptp.c              |  48 +--
>  drivers/net/dsa/vitesse-vsc73xx-core.c             |   6 +-
>  drivers/net/ethernet/broadcom/tg3.c                |   1 +
>  drivers/net/ethernet/ibm/ibmvnic.c                 |   9 +-
>  drivers/net/ethernet/intel/ice/ice.h               |   7 +
>  drivers/net/ethernet/intel/ice/ice_main.c          |  29 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.c           |  12 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.h           |   4 +-
>  drivers/net/ethernet/intel/igc/igc.h               |  28 ++
>  drivers/net/ethernet/intel/igc/igc_main.c          |  31 +-
>  drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   7 +
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  11 +
>  .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   4 +-
>  drivers/net/ethernet/mellanox/mlxsw/minimal.c      |   1 +
>  drivers/net/ethernet/mscc/ocelot.c                 |   1 -
>  drivers/net/ethernet/mscc/ocelot_ptp.c             |  66 ++--
>  drivers/net/ethernet/sfc/ef10.c                    |  13 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 -
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  10 +-
>  drivers/net/gtp.c                                  |   2 +
>  drivers/net/ipvlan/ipvlan_core.c                   |   9 +-
>  drivers/net/ppp/pptp.c                             |  31 +-
>  drivers/net/wireguard/netlink.c                    |  14 +-
>  drivers/net/wireguard/queueing.c                   |   1 +
>  drivers/net/wireguard/queueing.h                   |  25 +-
>  drivers/net/wireguard/receive.c                    |   2 +-
>  drivers/net/wireguard/send.c                       |   2 +-
>  drivers/net/wireless/ath/ath10k/core.c             |  12 +-
>  drivers/net/wireless/ath/ath10k/core.h             |   3 +
>  drivers/net/wireless/ath/ath10k/mac.c              |  13 +-
>  drivers/net/wireless/ath/ath11k/qmi.c              |   5 +
>  drivers/net/wireless/ath/ath9k/ar9003_hw.c         |  27 +-
>  drivers/net/wireless/ath/ath9k/htc_hst.c           |   8 +-
>  drivers/net/wireless/ath/ath9k/main.c              |  11 +-
>  drivers/net/wireless/ath/ath9k/wmi.c               |   4 +
>  drivers/net/wireless/atmel/atmel_cs.c              |  13 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   5 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   9 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   5 +-
>  drivers/net/wireless/intersil/orinoco/orinoco_cs.c |  13 +-
>  .../net/wireless/intersil/orinoco/spectrum_cs.c    |  13 +-
>  drivers/net/wireless/marvell/mwifiex/scan.c        |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/dma.c    |   4 -
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   8 -
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   8 +
>  drivers/net/wireless/microchip/wilc1000/hif.c      |   8 +-
>  drivers/net/wireless/ray_cs.c                      |  16 +-
>  drivers/net/wireless/rsi/rsi_91x_sdio.c            |   9 +-
>  drivers/net/wireless/wl3501_cs.c                   |  16 +-
>  drivers/nvme/host/auth.c                           |  51 ++-
>  drivers/nvme/host/core.c                           |  26 +-
>  drivers/nvme/host/nvme.h                           |   8 +-
>  drivers/nvmem/rmem.c                               |   1 +
>  drivers/nvmem/sunplus-ocotp.c                      |   9 +-
>  drivers/pci/controller/cadence/pcie-cadence-host.c |  27 ++
>  drivers/pci/controller/dwc/pcie-qcom.c             | 249 +++++++-------
>  drivers/pci/controller/pci-ftpci100.c              |  14 +-
>  drivers/pci/controller/vmd.c                       |  11 +-
>  drivers/pci/endpoint/functions/Kconfig             |  18 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c      |   2 +-
>  drivers/pci/hotplug/pciehp_ctrl.c                  |   8 +
>  drivers/pci/pcie/aspm.c                            |  21 +-
>  drivers/perf/arm-cmn.c                             |   7 +-
>  drivers/perf/hisilicon/hisi_pcie_pmu.c             |   2 +-
>  drivers/phy/tegra/xusb.c                           |   4 +
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   6 +-
>  drivers/pinctrl/intel/pinctrl-cherryview.c         |  15 +-
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   2 +
>  drivers/pinctrl/pinctrl-at91-pio4.c                |   2 +
>  drivers/pinctrl/pinctrl-microchip-sgpio.c          |   3 +
>  drivers/pinctrl/sunplus/sppctl.c                   |  23 +-
>  drivers/platform/x86/dell/dell-rbtn.c              |  13 +-
>  drivers/platform/x86/lenovo-yogabook-wmi.c         |  34 +-
>  drivers/platform/x86/think-lmi.c                   |  20 +-
>  drivers/platform/x86/thinkpad_acpi.c               |   6 +-
>  drivers/powercap/Kconfig                           |   4 +-
>  drivers/powercap/intel_rapl_msr.c                  |   1 -
>  drivers/pwm/pwm-ab8500.c                           |   2 +-
>  drivers/pwm/pwm-imx-tpm.c                          |   7 +
>  drivers/pwm/pwm-mtk-disp.c                         |  13 +-
>  drivers/pwm/sysfs.c                                |  17 +
>  drivers/regulator/core.c                           |  30 +-
>  drivers/regulator/tps65219-regulator.c             |   6 +-
>  drivers/rtc/rtc-st-lpc.c                           |   2 +-
>  drivers/s390/net/qeth_l3_sys.c                     |   2 +-
>  drivers/scsi/3w-xxxx.c                             |   4 +-
>  drivers/scsi/lpfc/lpfc_els.c                       |  14 +-
>  drivers/scsi/qedf/qedf_main.c                      |   3 +-
>  drivers/soc/amlogic/meson-secure-pwrc.c            |   2 +-
>  drivers/soc/fsl/qe/Kconfig                         |   1 +
>  drivers/soc/mediatek/mtk-svs.c                     |   4 +-
>  drivers/soc/xilinx/xlnx_event_manager.c            |   6 +-
>  drivers/spi/spi-bcm-qspi.c                         |  10 +-
>  drivers/spi/spi-dw-core.c                          |   5 +-
>  drivers/spi/spi-geni-qcom.c                        |   8 +-
>  .../media/atomisp/pci/atomisp_gmin_platform.c      |   2 +-
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   4 +-
>  drivers/thermal/Kconfig                            |  14 +-
>  drivers/thermal/Makefile                           |   2 +-
>  drivers/thermal/mediatek/Kconfig                   |  21 ++
>  drivers/thermal/mediatek/Makefile                  |   1 +
>  .../{mtk_thermal.c => mediatek/auxadc_thermal.c}   |   2 +-
>  drivers/thermal/sun8i_thermal.c                    |  55 +--
>  drivers/tty/serial/8250/8250_omap.c                |  25 +-
>  drivers/tty/serial/fsl_lpuart.c                    |   1 +
>  drivers/tty/serial/serial_core.c                   |  10 +-
>  drivers/usb/core/devio.c                           |   2 +
>  drivers/usb/dwc2/platform.c                        |  18 +-
>  drivers/usb/dwc3/dwc3-meson-g12a.c                 |   5 +-
>  drivers/usb/dwc3/dwc3-qcom.c                       |  17 +-
>  drivers/usb/dwc3/gadget.c                          |   4 +-
>  drivers/usb/gadget/function/u_serial.c             |  13 +-
>  drivers/usb/phy/phy-tahvo.c                        |   2 +-
>  drivers/usb/serial/option.c                        |   4 +
>  drivers/usb/typec/ucsi/psy.c                       |  14 +
>  drivers/vfio/mdev/mdev_core.c                      |  23 +-
>  drivers/video/fbdev/omap/lcd_mipid.c               |   6 +-
>  drivers/virt/coco/sev-guest/Kconfig                |   1 +
>  drivers/w1/slaves/w1_therm.c                       |  31 +-
>  drivers/w1/w1.c                                    |   4 +-
>  fs/afs/write.c                                     |   8 +-
>  fs/btrfs/block-group.c                             |  41 ++-
>  fs/btrfs/ctree.c                                   |  28 +-
>  fs/btrfs/free-space-tree.c                         |   3 +
>  fs/btrfs/locking.c                                 |   5 +-
>  fs/btrfs/qgroup.c                                  |   2 +
>  fs/erofs/data.c                                    |   9 +-
>  fs/erofs/inode.c                                   |   2 +-
>  fs/erofs/internal.h                                |  16 +-
>  fs/erofs/tagptr.h                                  | 107 ------
>  fs/erofs/xattr.c                                   |  20 +-
>  fs/erofs/zdata.c                                   | 373 +++++++++++++--------
>  fs/erofs/zdata.h                                   | 178 ----------
>  fs/erofs/zmap.c                                    |  19 +-
>  fs/ext4/namei.c                                    |  17 +-
>  fs/f2fs/compress.c                                 |   7 +-
>  fs/f2fs/data.c                                     |   7 +-
>  fs/f2fs/f2fs.h                                     |   2 +-
>  fs/f2fs/file.c                                     |   8 +-
>  fs/f2fs/gc.c                                       |  25 +-
>  fs/f2fs/namei.c                                    |  16 +-
>  fs/f2fs/node.c                                     |   4 +-
>  fs/fs_context.c                                    |   3 +-
>  fs/gfs2/file.c                                     |   2 +-
>  fs/inode.c                                         |  42 +++
>  fs/internal.h                                      |   2 +
>  fs/jffs2/build.c                                   |   5 +-
>  fs/jffs2/xattr.c                                   |  13 +-
>  fs/jffs2/xattr.h                                   |   4 +-
>  fs/kernfs/dir.c                                    |   2 +
>  fs/lockd/svc.c                                     |   1 -
>  fs/namei.c                                         |  25 +-
>  fs/nfs/nfs42xattr.c                                |  79 +++--
>  fs/nfs/nfs4proc.c                                  |   1 +
>  fs/nfsd/nfs4xdr.c                                  |   2 +-
>  fs/notify/fanotify/fanotify_user.c                 |  14 +
>  fs/ntfs3/xattr.c                                   |   3 +
>  fs/ocfs2/cluster/tcp.c                             |  23 +-
>  fs/overlayfs/copy_up.c                             |   2 +
>  fs/overlayfs/dir.c                                 |   3 +-
>  fs/overlayfs/export.c                              |   3 +-
>  fs/overlayfs/namei.c                               |   3 +-
>  fs/overlayfs/overlayfs.h                           |   6 +-
>  fs/overlayfs/super.c                               |   2 +-
>  fs/overlayfs/util.c                                |  24 +-
>  fs/pstore/ram_core.c                               |   2 +
>  fs/ramfs/inode.c                                   |   2 +-
>  fs/smb/client/file.c                               |  25 +-
>  fs/smb/client/smb2inode.c                          |   9 +-
>  fs/smb/client/smb2ops.c                            |  19 +-
>  fs/smb/client/transport.c                          |  20 +-
>  fs/smb/server/smb_common.c                         |   2 +-
>  fs/xfs/scrub/common.c                              |  26 --
>  fs/xfs/scrub/common.h                              |   2 -
>  fs/xfs/scrub/fscounters.c                          |  13 +-
>  fs/xfs/scrub/scrub.c                               |   2 -
>  fs/xfs/scrub/scrub.h                               |   1 -
>  fs/xfs/xfs_icache.c                                |  40 ++-
>  fs/xfs/xfs_mount.h                                 |   3 +
>  fs/xfs/xfs_super.c                                 |   3 +
>  include/crypto/internal/kpp.h                      |   6 +
>  include/drm/drm_bridge.h                           |   8 +
>  include/drm/drm_fixed.h                            |   6 +
>  include/linux/bitmap.h                             |   8 +-
>  include/linux/blk-mq.h                             |   3 +-
>  include/linux/blkdev.h                             |   2 +-
>  include/linux/blktrace_api.h                       |   6 +-
>  include/linux/bootmem_info.h                       |   2 +
>  include/linux/bpf.h                                |   1 -
>  include/linux/can/length.h                         |  14 +-
>  include/linux/dsa/sja1105.h                        |   4 -
>  include/linux/ieee80211.h                          |  14 +-
>  include/linux/ip.h                                 |  21 ++
>  include/linux/mmc/card.h                           |   1 +
>  include/linux/netdevice.h                          |   9 +
>  include/linux/nmi.h                                |   2 +-
>  include/linux/pci.h                                |   1 +
>  include/linux/pipe_fs_i.h                          |   4 -
>  include/linux/ramfs.h                              |   1 +
>  include/linux/sh_intc.h                            |   6 +-
>  include/linux/watch_queue.h                        |   3 +-
>  include/net/bluetooth/mgmt.h                       |  79 ++---
>  include/net/regulatory.h                           |  13 +-
>  include/net/route.h                                |   3 -
>  include/net/sock.h                                 |   1 +
>  include/soc/mscc/ocelot.h                          |  10 +-
>  include/trace/events/erofs.h                       |   4 +-
>  include/trace/events/net.h                         |   3 +-
>  include/trace/events/timer.h                       |   6 +-
>  include/uapi/linux/affs_hardblocks.h               |  68 ++--
>  include/uapi/linux/auto_dev-ioctl.h                |   2 +-
>  include/uapi/linux/videodev2.h                     |   2 +-
>  io_uring/io_uring.c                                |  35 +-
>  kernel/bpf/btf.c                                   |   6 +-
>  kernel/bpf/cgroup.c                                |  15 +
>  kernel/bpf/trampoline.c                            |  32 +-
>  kernel/kcsan/core.c                                |   2 +
>  kernel/kexec_core.c                                |   5 +-
>  kernel/rcu/rcu.h                                   |   6 +
>  kernel/rcu/rcuscale.c                              | 204 +++++------
>  kernel/rcu/tasks.h                                 |   7 +-
>  kernel/rcu/tree.c                                  |  23 +-
>  kernel/time/posix-timers.c                         |  43 ++-
>  kernel/time/tick-sched.c                           |   2 +-
>  kernel/watch_queue.c                               |  12 +-
>  kernel/watchdog_hld.c                              |   6 +-
>  lib/bitmap.c                                       |   2 +-
>  lib/ts_bm.c                                        |   4 +-
>  mm/damon/ops-common.c                              |  16 +-
>  mm/damon/ops-common.h                              |   4 +-
>  mm/damon/paddr.c                                   |   4 +-
>  mm/damon/vaddr.c                                   |   4 +-
>  mm/memory.c                                        |   7 +
>  mm/mmap.c                                          |   5 +-
>  mm/shmem.c                                         |   2 +-
>  net/bluetooth/hci_conn.c                           |  47 ++-
>  net/bluetooth/hci_event.c                          |  15 +-
>  net/bluetooth/hci_sync.c                           |  28 +-
>  net/bluetooth/mgmt.c                               |  12 +
>  net/bridge/br_if.c                                 |   5 +-
>  net/core/filter.c                                  | 126 +++++--
>  net/core/rtnetlink.c                               | 104 +++---
>  net/core/sock.c                                    |  17 +-
>  net/dsa/tag_sja1105.c                              |  90 ++---
>  net/ipv4/tcp_input.c                               |  12 +-
>  net/mac80211/debugfs_netdev.c                      |   2 +-
>  net/mac80211/sta_info.c                            |   2 +
>  net/mac80211/util.c                                |   4 +-
>  net/netfilter/ipvs/Kconfig                         |  27 +-
>  net/netfilter/ipvs/ip_vs_conn.c                    |   4 +-
>  net/netfilter/nf_conntrack_helper.c                |   4 +
>  net/netfilter/nf_conntrack_proto_dccp.c            |  52 ++-
>  net/netfilter/nf_conntrack_sip.c                   |   2 +-
>  net/netfilter/nf_tables_api.c                      |  13 +-
>  net/netfilter/nft_byteorder.c                      |  14 +-
>  net/netlink/af_netlink.c                           |   5 +-
>  net/netlink/diag.c                                 |   7 +-
>  net/nfc/llcp.h                                     |   1 -
>  net/nfc/llcp_commands.c                            |  15 +-
>  net/nfc/llcp_core.c                                |  49 ++-
>  net/nfc/llcp_sock.c                                |  18 +-
>  net/nfc/netlink.c                                  |  20 +-
>  net/nfc/nfc.h                                      |   1 +
>  net/sched/act_ipt.c                                |  60 +++-
>  net/sched/act_pedit.c                              |   1 +
>  net/sctp/socket.c                                  |  22 +-
>  net/sunrpc/svcsock.c                               |  23 +-
>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |  12 +-
>  net/wireless/core.c                                |  16 -
>  net/wireless/reg.c                                 |  16 +-
>  net/wireless/scan.c                                | 367 ++++++++------------
>  net/xdp/xsk.c                                      |   5 +
>  samples/bpf/tcp_basertt_kern.c                     |   2 +-
>  samples/bpf/xdp1_kern.c                            |   2 +-
>  samples/bpf/xdp2_kern.c                            |   2 +-
>  scripts/Makefile.modfinal                          |   2 +-
>  scripts/mod/modpost.c                              |  86 ++---
>  security/apparmor/policy_unpack.c                  |   9 +-
>  security/integrity/evm/evm_crypto.c                |   2 +-
>  security/integrity/evm/evm_main.c                  |   4 +-
>  security/integrity/iint.c                          |  15 +-
>  security/integrity/ima/ima_modsig.c                |   3 +
>  security/integrity/ima/ima_policy.c                |   3 +-
>  sound/core/jack.c                                  |  15 +-
>  sound/core/pcm_memory.c                            |  44 ++-
>  sound/pci/ac97/ac97_codec.c                        |   4 +-
>  sound/pci/hda/patch_realtek.c                      |   7 +-
>  sound/soc/amd/acp/acp-pdm.c                        |   2 +-
>  sound/soc/codecs/es8316.c                          |  23 +-
>  sound/soc/fsl/imx-audmix.c                         |   9 +
>  sound/soc/intel/boards/sof_sdw.c                   |   2 +-
>  sound/soc/mediatek/mt8173/mt8173-afe-pcm.c         |  13 +-
>  tools/bpf/bpftool/feature.c                        |  24 +-
>  tools/lib/bpf/bpf_helpers.h                        |  15 +-
>  tools/lib/bpf/btf_dump.c                           |  22 +-
>  tools/perf/arch/x86/util/Build                     |   1 +
>  tools/perf/arch/x86/util/env.c                     |  19 ++
>  tools/perf/arch/x86/util/env.h                     |   7 +
>  tools/perf/arch/x86/util/evsel.c                   |  16 +-
>  tools/perf/arch/x86/util/mem-events.c              |  19 +-
>  tools/perf/builtin-bench.c                         |   2 +
>  tools/perf/builtin-script.c                        |  16 +-
>  tools/perf/util/dwarf-aux.c                        |   2 +-
>  tools/testing/selftests/bpf/Makefile               |   3 +-
>  tools/testing/selftests/bpf/prog_tests/check_mtu.c |   2 +-
>  tools/testing/selftests/cgroup/test_memcontrol.c   |   4 +-
>  tools/testing/selftests/net/rtnetlink.sh           |   1 +
>  .../rcutorture/configs/rcu/BUSTED-BOOST.boot       |   2 +-
>  .../selftests/rcutorture/configs/rcu/TREE03.boot   |   2 +-
>  .../selftests/vDSO/vdso_test_clock_getres.c        |   4 +-
>  tools/testing/selftests/wireguard/netns.sh         |  30 +-
>  612 files changed, 5623 insertions(+), 3847 deletions(-)
> 
> 
