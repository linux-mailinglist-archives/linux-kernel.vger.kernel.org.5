Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD547558AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjGPXlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 19:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGPXlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 19:41:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68E8E54
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 16:41:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-262e3c597b9so2765662a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689550863; x=1692142863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRcwjEwgHDPb4cgsAQzZeE3JDmOHZE1UltIWmg0jPlw=;
        b=mQ2Vc3ykI085LU1OUA9dAjG1/D62LhZPN9yrwIOch5kPg5ugpmGmw5mlYeFS95sKoX
         dnYy5v/X0i9cFnUG3QZNHR8YU2HBGWJLScD7QJ1AvHr8GUh9uojLqBdzf7WnnC4wkKnI
         BxMgW8sBeMSAGc8DArzHFVVhtaMRrcaVfgEMhevvCbBT8v6ibpkDyRTEF6ky+FbtKAJJ
         6u0n47bWlgGoI1/PWg9HL9PnbxIrdCVaVCW/Vh3Tb8qxcaui54SAO7/xeZPV8bI2et8w
         MTRUlt6b66F11cLYlsIKNGHI29DFghSA7lXQ88lPTUKSRwAvJHw7FedeNErtWHYuwUGy
         PuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689550863; x=1692142863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRcwjEwgHDPb4cgsAQzZeE3JDmOHZE1UltIWmg0jPlw=;
        b=ByUsLLHelGYP92GhI7Jdj9Df+TSnnreWFkQcIM5UDfsHHvhSZTX5SUhGfEivWlegrj
         ZyCHAQq7/OAL3Wd3/AKNoKSMit29PLea8MRGvrfeuBB3Mgq1f8kiaMSRhpsQ3EDS5AUE
         xGYpaDJe/T2/ytEKlsHvmytloZQlCU2mHJdadlVfWyv2LI9+WBmimYBAJeShs9Lzo0Sv
         HO+Cj3FdqXHe3Eb5rDqCJgdfuw7CznooqIwCrlS35nHPI1Oy2fqjyzEkTGParEDhHNdS
         Fai9Hmxu0rLUwTmyB0OU/U5+MPXUBjYfGwQrVahTbl8RuBuxKjQ8VtP1ho2qGe743UvH
         ANGw==
X-Gm-Message-State: ABy/qLYXHW9QZU4KaXnrzCWtPVJIZgtbPja2FTKXkPkgrVvvjLDP8hIT
        /BGXF0NjXexH55+RczPJxG3Bi7a1lL44KgwUnLNb5A==
X-Google-Smtp-Source: APBJJlEgNejjyF0Oo2GwMcnBckRnkZZEo+YmECnlRh1TDN3NIm560EkLACkcaWTwMFAPKm6PXz77YrH5uP5MaI5HmMM=
X-Received: by 2002:a17:90b:4a43:b0:262:e912:5c75 with SMTP id
 lb3-20020a17090b4a4300b00262e9125c75mr9835658pjb.13.1689550861951; Sun, 16
 Jul 2023 16:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230716194923.861634455@linuxfoundation.org>
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Sun, 16 Jul 2023 17:40:50 -0600
Message-ID: <CAEUSe7-XjSvLKxFuHbKUrJBWAmgKRg5oZRppnDYn1CuoWCUURw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/591] 6.1.39-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, 16 Jul 2023 at 14:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 591 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.39-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.1.39-rc1
>
> Sherry Sun <sherry.sun@nxp.com>
>     tty: serial: fsl_lpuart: add earlycon for imx8ulp platform
>
> Jason A. Donenfeld <Jason@zx2c4.com>
>     wireguard: netlink: send staged packets when setting initial private =
key
>
> Jason A. Donenfeld <Jason@zx2c4.com>
>     wireguard: queueing: use saner cpu selection wrapping
>
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>     netfilter: nf_tables: prevent OOB access in nft_byteorder_eval
>
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>     netfilter: nf_tables: do not ignore genmask when looking up chain by =
id
>
> Florent Revest <revest@chromium.org>
>     netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
>
> Ming Lei <ming.lei@redhat.com>
>     block: make sure local irq is disabled when calling __blkcg_rstat_flu=
sh
>
> Paul Cercueil <paul@crapouillou.net>
>     MIPS: DTS: CI20: Raise VDDCORE voltage to 1.125 volts
>
> Ming Lei <ming.lei@redhat.com>
>     blk-cgroup: Flush stats before releasing blkcg_gq
>
> Waiman Long <longman@redhat.com>
>     blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stat=
s()
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: unbind non-anonymous set if rule construction f=
ails
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
>     xfs: explicitly specify cpu when forcing inodegc delayed work to run =
immediately
>
> Jan Kara <jack@suse.cz>
>     fs: no need to check source
>
> Yu Kuai <yukuai3@huawei.com>
>     blktrace: use inline function for blk_trace_remove() while blktrace i=
s disabled
>
> Christian Marangi <ansuelsmth@gmail.com>
>     leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename
>
> Arnd Bergmann <arnd@arndb.de>
>     ARM: orion5x: fix d2net gpio initialization
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     ARM: dts: qcom: ipq4019: fix broken NAND controller properties overri=
de
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
>     btrfs: fix extent buffer leak after tree mod log failure at split_nod=
e()
>
> Filipe Manana <fdmanana@suse.com>
>     btrfs: fix race when deleting quota root from the dirty cow roots lis=
t
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
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
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
>     bcache: Fix __bch_btree_node_alloc to make the failure behavior consi=
stent
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
>     mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode=
 is used.
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
> Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>     extcon: usbc-tusb320: Unregister typec port on driver removal
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
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
>     bpf, btf: Warn but return no error for NULL btf from __register_btf_k=
func_id_set()
>
> Eric Dumazet <edumazet@google.com>
>     tcp: annotate data races in __tcp_oow_rate_limited()
>
> Eric Dumazet <edumazet@google.com>
>     net: fix net_dev_start_xmit trace event vs skb_transport_offset()
>
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=3D0=
 bridge mode
>
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
>
> Pali Roh=C3=A1r <pali@kernel.org>
>     powerpc: dts: turris1x.dts: Fix PCIe MEM size for pci2 node
>
> Randy Dunlap <rdunlap@infradead.org>
>     powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=3Dy
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
> Christian K=C3=B6nig <christian.koenig@amd.com>
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
>     net: dsa: tag_sja1105: always prefer source port information from INC=
L_SRCPT
>
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: sja1105: always enable the INCL_SRCPT option
>
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: felix: don't drop PTP frames with tag_8021q when RX timesta=
mping is disabled
>
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: mscc: ocelot: don't keep PTP configuration of all ports in singl=
e structure
>
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: mscc: ocelot: don't report that RX timestamping is enabled by de=
fault
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
>     net/sched: act_ipt: add sanity checks on table name and hook location=
s
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
> Jouni H=C3=B6gander <jouni.hogander@intel.com>
>     drm/i915/psr: Use hw.adjusted mode when calculating io/fast wake time=
s
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     rtc: st-lpc: Release some resources in st_rtc_probe() in case of erro=
r
>
> Jinke Han <hanjinke.666@bytedance.com>
>     blk-throttle: Fix io statistics for cgroup v1
>
> Ming Lei <ming.lei@redhat.com>
>     blk-cgroup: don't update io stat for root cgroup
>
> Waiman Long <longman@redhat.com>
>     blk-cgroup: Optimize blkcg_rstat_flush()
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
>     KVM: s390/diag: fix racy access of physical cpu number in diag 9c han=
dler
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
>     device property: Clarify description of returned value in some functi=
ons
>
> Miaoqian Lin <linmq006@gmail.com>
>     device property: Fix documentation for fwnode_get_next_parent()
>
> Tony Lindgren <tony@atomide.com>
>     serial: 8250_omap: Use force_suspend and resume for system suspend
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "usb: common: usb-conn-gpio: Set last role to unknown before i=
nitial detection"
>
> Jiasheng Jiang <jiasheng@iscas.ac.cn>
>     mfd: intel-lpss: Add missing check for platform_get_resource
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     mfd: wcd934x: Fix an error handling path in wcd934x_slim_probe()
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_p=
robe()
>
> Prashanth K <quic_prashk@quicinc.com>
>     usb: common: usb-conn-gpio: Set last role to unknown before initial d=
etection
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
>     media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var=
()
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
>     extcon: Fix kernel doc of property capability fields to avoid warning=
s
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
>     clk: qcom: mmcc-msm8974: use clk_rcg2_shared_ops for mdp_clk_src cloc=
k
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
>     media: mediatek: vcodec: using decoder status instead of core work co=
unt
>
> Martin Kepplinger <martink@posteo.de>
>     media: hi846: fix usage of pm_runtime_get_if_in_use()
>
> Daniel Scally <dan.scally@ideasonboard.com>
>     media: i2c: Correct format propagation for st-mipid02
>
> Duoming Zhou <duoming@zju.edu.cn>
>     media: usb: siano: Fix warning due to null work_func_t function point=
er
>
> Marek Vasut <marex@denx.de>
>     media: videodev2.h: Fix struct v4l2_input tuner index comment
>
> Ming Qian <ming.qian@nxp.com>
>     media: amphion: initiate a drain of the capture queue in dynamic reso=
lution change
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
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     usb: dwc2: platform: Improve error reporting for problems during .rem=
ove()
>
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>     sh: j2: Use ioremap() to translate device tree address into kernel me=
mory
>
> Yangtao Li <frank.li@vivo.com>
>     f2fs: do not allow to defragment files have FI_COMPRESS_RELEASED
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     dt-bindings: power: reset: qcom-pon: Only allow reboot-mode pre-pmk83=
50
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
>     btrfs: fix race when deleting free space root from the dirty cow root=
s list
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
>     ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on El=
iteBook
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
>     md/raid1-10: fix casting from randomized structure in raid1_submit_wr=
ite()
>
> Thomas Gleixner <tglx@linutronix.de>
>     x86/efi: Make efi_set_virtual_address_map IBT safe
>
> Will Deacon <will@kernel.org>
>     arm64: sme: Use STR P to clear FFR context field in streaming SVE mod=
e
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
>     SMB3: Do not send lease break acknowledgment if all file handles have=
 been closed
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
>     ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guar=
d
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     modpost: fix off by one in is_executable_section()
>
> Stephan M=C3=BCller <smueller@chronox.de>
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
>     powerpc/mm/dax: Fix the condition when checking if altmap vmemap can =
cross-boundary
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
>     powerpc/powernv/sriov: perform null check on iov before dereferencing=
 iov
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
>     platform/x86: thinkpad_acpi: Fix lkp-tests warnings for platform prof=
iles
>
> Arnaldo Carvalho de Melo <acme@redhat.com>
>     perf script: Fix allocation of evsel->priv related to per-event dump =
files
>
> Christophe Leroy <christophe.leroy@csgroup.eu>
>     powerpc/signal32: Force inlining of __unsafe_save_user_regs() and sav=
e_tm_user_regs_unsafe()
>
> Christophe Leroy <christophe.leroy@csgroup.eu>
>     powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare(=
)
>
> Christophe Leroy <christophe.leroy@csgroup.eu>
>     kcsan: Don't expect 64 bits atomic builtins from 32 bits architecture=
s
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
>     perf bench: Add missing setlocale() call to allow usage of %'d style =
formatting
>
> Justin Tee <justin.tee@broadcom.com>
>     scsi: lpfc: Revise NPIV ELS unsol rcv cmpl logic to drop ndlp based o=
n nlp_state
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
>     scsi: 3w-xxxx: Add error handling for initialization failure in tw_pr=
obe()
>
> Ding Hui <dinghui@sangfor.com.cn>
>     PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-fre=
e
>
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: lenovo-yogabook: Set default keyboard backligh brightne=
ss on probe()
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
>     drm/amdgpu: Fix memcpy() in sienna_cichlid_append_powerplay_table fun=
ction.
>
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
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
>     drm/msm/dsi: Flip greater-than check for slice_count and slice_per_in=
tf
>
> Marijn Suijten <marijn.suijten@somainline.org>
>     drm/msm/dsi: Use DSC slice(s) packet size to compute word count
>
> Jessica Zhang <quic_jesszhan@quicinc.com>
>     drm/msm/dpu: Fix slice_last_group_size calculation
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/msm/dpu: do not enable color-management if DSPPs are not availabl=
e
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
>     clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_p=
robe
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
>     HID: uclogic: Modular KUnit tests should not depend on KUNIT=3Dy
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     drm/radeon: fix possible division-by-zero errors
>
> Aurabindo Pillai <aurabindo.pillai@amd.com>
>     drm/amd/display: Fix artifacting on eDP panels when engaging freesync=
 video mode
>
> Chen-Yu Tsai <wenst@chromium.org>
>     soc: mediatek: SVS: Fix MT8192 GPU node name
>
> Daniil Dulov <d.dulov@aladdin.ru>
>     drm/amdkfd: Fix potential deallocation of previously deallocated memo=
ry.
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     drm/amd/display: Fix a test dml32_rq_dlg_get_rq_reg()
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     drm/amd/display: Fix a test CalculatePrefetchSchedule()
>
> Paul Cercueil <paul@crapouillou.net>
>     MIPS: DTS: CI20: Fix ACT8600 regulator node names
>
> Maxime Ripard <maxime@cerno.tech>
>     clk: Export clk_hw_forward_rate_request()
>
> Christian Lamparter <chunkeey@gmail.com>
>     ARM: dts: BCM5301X: fix duplex-full =3D> full-duplex
>
> Guenter Roeck <linux@roeck-us.net>
>     hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on AD=
M1272
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
>     fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_pro=
be()
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
>     IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidat=
e
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
>     ASoC: es8316: Increment max value for ALC Capture Target Volume contr=
ol
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
>     arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to =
kukui
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
>     drm/bridge: Introduce pre_enable_prev_first to alter bridge init orde=
r
>
> Stephan Gerhold <stephan@gerhold.net>
>     arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion
>
> Stephan Gerhold <stephan@gerhold.net>
>     arm64: dts: qcom: apq8016-sbc: Fix regulator constraints
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sdm845-polaris: add missing touchscreen child node =
reg
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
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>     drm/bridge: anx7625: Prevent endless probe loop
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
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
> Ma=C3=ADra Canal <mcanal@igalia.com>
>     drm/vkms: Fix RGB565 pixel conversion
>
> Ma=C3=ADra Canal <mcanal@igalia.com>
>     drm: Add fixed-point helper to get rounded integer values
>
> Ma=C3=ADra Canal <mcanal@igalia.com>
>     drm/vkms: isolate pixel conversion functionality
>
> Bard Liao <yung-chuan.liao@linux.intel.com>
>     ASoC: Intel: sof_sdw: remove SOF_SDW_TGL_HDMI for MeteorLake devices
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     driver: soc: xilinx: use _safe loop iterator to avoid a use after fre=
e
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
> Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
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
>     drm/bridge: it6505: Move a variable assignment behind a null pointer =
check in receive_timing_debugfs_show()
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
>     netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() r=
eturn value.
>
> Florian Westphal <fw@strlen.de>
>     netfilter: conntrack: dccp: copy entire header to stack buffer, not j=
ust basic one
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
>     selftests: rtnetlink: remove netdevsim device after ipsec offload tes=
t
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
>     bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpo=
int
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
>     mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 1=
1/2019
>
> Ilan Peer <ilan.peer@intel.com>
>     wifi: ieee80211: Fix the common size calculation for reconfiguration =
ML
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
>     wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_=
msix_handler()
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
>     mmc: mediatek: Avoid ugly error message when SDIO wakeup IRQ isn't us=
ed
>
> Zhen Lei <thunder.leizhen@huawei.com>
>     kexec: fix a memory leak in crash_shrink_memory()
>
> Douglas Anderson <dianders@chromium.org>
>     watchdog/perf: more properly prevent false positives with turbo modes
>
> Douglas Anderson <dianders@chromium.org>
>     watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on co=
rrect config
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
>     wifi: ath10k: Trigger STA disconnect after reconfig complete on hardw=
are restart
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
>     nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_sen=
d_connect()
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
>     wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802=
_11_scan()
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
>     libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBE=
R_BITFIELD_SIZE
>
> Fedor Pchelkin <pchelkin@ispras.ru>
>     wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
>
> Peter Seiderer <ps.report@gmx.net>
>     wifi: ath9k: fix AR9003 mac hardware hang check register offset calcu=
lation
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
>     kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REA=
LTIME is undefined
>
> Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>     rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcusc=
ale
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
>     thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_pro=
be()
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
>     PM: domains: Move the verification of in-params from genpd_add_device=
()
>
> Zhang Rui <rui.zhang@intel.com>
>     powercap: RAPL: Fix CONFIG_IOSF_MBI dependency
>
> Junhao He <hejunhao3@huawei.com>
>     drivers/perf: hisi: Don't migrate perf to the CPU going to teardown
>
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>     x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_z=
eropad()
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
>     nvme-auth: don't ignore key generation failures when initializing ctr=
l keys
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
>     nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_d=
hchap
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
>     erofs: kill hooked chains to avoid loops on deduplicated compressed i=
mages
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

We're seeing build failures on i386 and x86 with Clang:
-----8<-----
/builds/linux/block/blk-cgroup.c:1238:6: error: variable 'ret' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
        if (init_blkcg_llists(blkcg))
            ^~~~~~~~~~~~~~~~~~~~~~~~
/builds/linux/block/blk-cgroup.c:1288:9: note: uninitialized use occurs her=
e
        return ret;
               ^~~
/builds/linux/block/blk-cgroup.c:1238:2: note: remove the 'if' if its
condition is always false
        if (init_blkcg_llists(blkcg))
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/builds/linux/block/blk-cgroup.c:1223:33: note: initialize the
variable 'ret' to silence this warning
        struct cgroup_subsys_state *ret;
                                       ^
                                        =3D NULL
1 error generated.
----->8-----

More info to follow soon.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
