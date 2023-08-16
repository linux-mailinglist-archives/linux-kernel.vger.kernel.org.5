Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B752277ED1D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346930AbjHPWaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346921AbjHPW34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:29:56 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111F125
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:29:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76d77cf99afso44316585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692224992; x=1692829792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cf+hpB9t3vkIFaF6qJxIdZC5AoSFvVWh4ZGe9nBCgF8=;
        b=KF0xMzuk/YCtgOgqVYNYA5YeZhIyWSUUTodQNDFAwC90bHkAC/ErZ45Gl1xmM7uUz7
         NSlfRT0ndI1ifKqKl4LNAbUD8inyF7LA3tfugawL3MV9rz7A8mwsiK/xt/Q/KabZsNqS
         gCdlHjZYQm1ZIeNSL17A05zIpd/C8f9zDqKNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692224992; x=1692829792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cf+hpB9t3vkIFaF6qJxIdZC5AoSFvVWh4ZGe9nBCgF8=;
        b=a052mRoopsLI8OSaTNAiGK6H05R30PogMIXnE3WonwSX9fvBCUfaNqwaJ9rw2vlZ3O
         S44u4cJ2HQUQB1VOZhWjrsEyHUzERFjc9MpVKZOyKwi5Xn4L+sxSSswRuQ3IE+suQ2fn
         bl3cMeVzu6dlntyRiuLXVfzhDz8frnCTy3CNQWi4z4CkU+b+stssHcW7DLsRnU66Mojf
         gXmq83qJy4sOHl6WPZh8FQZxWvgB8t6qCdy1gOAREOOm97HuF2cVcymDuWPdXvA0WXDR
         w6gs7+yhDk77BgdAJPvFDU7RmiD37kOZhuLKf9Asko3j94+Xvpf4OA2qaPOY1KEGLtWe
         v3LA==
X-Gm-Message-State: AOJu0Yxu5+ayenduKsGUnSAF39rSn3fl+txnFOj8Kj/ZjUSwWbUGqwzZ
        tpRhUtRVTtUeIzj58p9KK1nNxw==
X-Google-Smtp-Source: AGHT+IHN0KO42kodgpquLCl0BwGdzmA8v9U0zK5qoLxzgs0ygEtTk7LLhEkZ/jwgZU2Feu4Kj+E0qQ==
X-Received: by 2002:a05:620a:cd1:b0:76d:2755:1eb8 with SMTP id b17-20020a05620a0cd100b0076d27551eb8mr2754565qkj.72.1692224991687;
        Wed, 16 Aug 2023 15:29:51 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id c1-20020ae9e201000000b0076ca9269de7sm4711420qkc.124.2023.08.16.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 15:29:50 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:29:50 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/206] 6.4.11-rc1 review
Message-ID: <20230816222950.GD1455425@joel-ThinkPad-X1-Carbon-4th>
References: <20230813211724.969019629@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:16:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.11 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.11-rc1.gz
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
>     Linux 6.4.11-rc1
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     alpha: remove __init annotation from exported page_is_ram()
> 
> Simon Trimmer <simont@opensource.cirrus.com>
>     ACPI: scan: Create platform device for CS35L56
> 
> David Xu <xuwd1@hotmail.com>
>     platform/x86: serial-multi-instantiate: Auto detect IRQ resource for CSC3551
> 
> Vadim Pasternak <vadimp@nvidia.com>
>     platform: mellanox: Fix order in exit flow
> 
> Vadim Pasternak <vadimp@nvidia.com>
>     platform: mellanox: mlx-platform: Modify graceful shutdown callback and power down mask
> 
> Vadim Pasternak <vadimp@nvidia.com>
>     platform: mellanox: mlx-platform: Fix signals polarity and latch mask
> 
> Vadim Pasternak <vadimp@nvidia.com>
>     platform: mellanox: Change register offset addresses
> 
> Hans de Goede <hdegoede@redhat.com>
>     platform/x86: lenovo-ymc: Only bind on machines with a convertible DMI chassis-type
> 
> Jean Delvare <jdelvare@suse.de>
>     platform/x86: msi-ec: Fix the build
> 
> Nilesh Javali <njavali@marvell.com>
>     scsi: qedf: Fix firmware halt over suspend and resume
> 
> Nilesh Javali <njavali@marvell.com>
>     scsi: qedi: Fix firmware halt over suspend and resume
> 
> Karan Tilak Kumar <kartilak@cisco.com>
>     scsi: fnic: Replace return codes in fnic_clean_pending_aborts()
> 
> Zhu Wang <wangzhu9@huawei.com>
>     scsi: core: Fix possible memory leak if device_add() fails
> 
> Zhu Wang <wangzhu9@huawei.com>
>     scsi: snic: Fix possible memory leak if device_add() fails
> 
> Alexandra Diupina <adiupina@astralinux.ru>
>     scsi: 53c700: Check that command slot is not NULL
> 
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>     scsi: ufs: renesas: Fix private allocation
> 
> Michael Kelley <mikelley@microsoft.com>
>     scsi: storvsc: Fix handling of virtual Fibre Channel timeouts
> 
> Tony Battersby <tonyb@cybernetics.com>
>     scsi: core: Fix legacy /proc parsing buffer overflow
> 
> Josef Bacik <josef@toxicpanda.com>
>     btrfs: set cache_block_group_error if we find an error
> 
> Qu Wenruo <wqu@suse.com>
>     btrfs: reject invalid reloc tree root keys with stack dump
> 
> Qu Wenruo <wqu@suse.com>
>     btrfs: exit gracefully if reloc roots don't match
> 
> Christoph Hellwig <hch@lst.de>
>     btrfs: properly clear end of the unreserved range in cow_file_range
> 
> Christoph Hellwig <hch@lst.de>
>     btrfs: don't wait for writeback on clean pages in extent_write_cache_pages
> 
> Christoph Hellwig <hch@lst.de>
>     btrfs: don't stop integrity writeback too early
> 
> Josef Bacik <josef@toxicpanda.com>
>     btrfs: wait for actual caching progress during allocation
> 
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     gpio: sim: mark the GPIO chip as a one that can sleep
> 
> William Breathitt Gray <william.gray@linaro.org>
>     gpio: ws16c48: Fix off-by-one error in WS16C48 resource region extent
> 
> Nick Child <nnac123@linux.ibm.com>
>     ibmvnic: Ensure login failure recovery is safe from other resets
> 
> Nick Child <nnac123@linux.ibm.com>
>     ibmvnic: Do partial reset on login failure
> 
> Nick Child <nnac123@linux.ibm.com>
>     ibmvnic: Handle DMA unmapping of login buffs in release functions
> 
> Nick Child <nnac123@linux.ibm.com>
>     ibmvnic: Unmap DMA login rsp buffer on send login fail
> 
> Nick Child <nnac123@linux.ibm.com>
>     ibmvnic: Enforce stronger sanity checks on login response
> 
> Moshe Shemesh <moshe@nvidia.com>
>     net/mlx5: Reload auxiliary devices in pci error handlers
> 
> Moshe Shemesh <moshe@nvidia.com>
>     net/mlx5: Skip clock update work when device is in error state
> 
> Shay Drory <shayd@nvidia.com>
>     net/mlx5: LAG, Check correct bucket when modifying LAG
> 
> Chris Mi <cmi@nvidia.com>
>     net/mlx5e: Unoffload post act rule when handling FIB events
> 
> Daniel Jurgens <danielj@nvidia.com>
>     net/mlx5: Allow 0 for total host VFs
> 
> Yevgeny Kliteynik <kliteyn@nvidia.com>
>     net/mlx5: DR, Fix wrong allocation of modify hdr pattern
> 
> Jianbo Liu <jianbol@nvidia.com>
>     net/mlx5e: TC, Fix internal port memory leak
> 
> Gal Pressman <gal@nvidia.com>
>     net/mlx5e: Take RTNL lock when needed before calling xdp_set_features()
> 
> Zhang Jianhua <chris.zjh@huawei.com>
>     dmaengine: owl-dma: Modify mismatched function name
> 
> Fenghua Yu <fenghua.yu@intel.com>
>     dmaengine: idxd: Clear PRS disable flag when disabling IDXD device
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     dmaengine: mcf-edma: Fix a potential un-allocated memory access
> 
> Hao Chen <chenhao418@huawei.com>
>     net: hns3: fix strscpy causing content truncation issue
> 
> Ido Schimmel <idosch@nvidia.com>
>     nexthop: Fix infinite nexthop bucket dump when using maximum nexthop ID
> 
> Ido Schimmel <idosch@nvidia.com>
>     nexthop: Make nexthop bucket dump more efficient
> 
> Ido Schimmel <idosch@nvidia.com>
>     nexthop: Fix infinite nexthop dump when using maximum nexthop ID
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
> 
> Yonglong Liu <liuyonglong@huawei.com>
>     net: hns3: fix deadlock issue when externel_lb and reset are executed together
> 
> Jie Wang <wangjie125@huawei.com>
>     net: hns3: add wait until mac link down
> 
> Jie Wang <wangjie125@huawei.com>
>     net: hns3: refactor hclge_mac_link_status_wait for interface reuse
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     net: dsa: ocelot: call dsa_tag_8021q_unregister() under rtnl_lock() on driver remove
> 
> Li Yang <leoyang.li@nxp.com>
>     net: phy: at803x: remove set/get wol callbacks for AR8032
> 
> Jonas Gorski <jonas.gorski@bisdn.de>
>     net: marvell: prestera: fix handling IPv4 routes with nhid
> 
> Jakub Kicinski <kuba@kernel.org>
>     net: tls: avoid discarding data on record close
> 
> Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
>     RDMA/bnxt_re: Fix error handling in probe failure path
> 
> Selvin Xavier <selvin.xavier@broadcom.com>
>     RDMA/bnxt_re: Properly order ib_device_unalloc() to avoid UAF
> 
> Michael Guralnik <michaelgur@nvidia.com>
>     RDMA/umem: Set iova in ODP flow
> 
> Felix Fietkau <nbd@nbd.name>
>     wifi: cfg80211: fix sband iftype data lookup for AP_VLAN
> 
> Petr Tesarik <petr.tesarik.ext@huawei.com>
>     wifi: brcm80211: handle params_v1 allocation failure
> 
> Daniel Stone <daniels@collabora.com>
>     drm/rockchip: Don't spam logs in atomic check
> 
> Arnd Bergmann <arnd@arndb.de>
>     drm/nouveau: remove unused tu102_gr_load() function
> 
> Pin-yen Lin <treapking@chromium.org>
>     drm/bridge: it6505: Check power state with it6505->powered in IRQ handler
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd/display: Don't show stack trace for missing eDP
> 
> Douglas Miller <doug.miller@cornelisnetworks.com>
>     IB/hfi1: Fix possible panic during hotplug remove
> 
> Piotr Gardocki <piotrx.gardocki@intel.com>
>     iavf: fix potential races for FDIR filters
> 
> Fedor Pchelkin <pchelkin@ispras.ru>
>     drivers: vxlan: vnifilter: free percpu vni stats on error path
> 
> Andrew Kanner <andrew.kanner@gmail.com>
>     drivers: net: prevent tun_build_skb() to exceed the packet size limit
> 
> Eric Dumazet <edumazet@google.com>
>     dccp: fix data-race around dp->dccps_mss_cache
> 
> Ziyang Xuan <william.xuanziyang@huawei.com>
>     bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves
> 
> Magnus Karlsson <magnus.karlsson@intel.com>
>     xsk: fix refcount underflow in error path
> 
> Florian Westphal <fw@strlen.de>
>     tunnels: fix kasan splat when generating ipv4 pmtu error
> 
> Eric Dumazet <edumazet@google.com>
>     tcp: add missing family to tcp_set_ca_state() tracepoint
> 
> Vladimir Oltean <vladimir.oltean@nxp.com>
>     PCI: move OF status = "disabled" detection to dev->match_driver
> 
> Gerd Bayer <gbayer@linux.ibm.com>
>     net/smc: Use correct buffer sizes when switching between TCP and SMC
> 
> Gerd Bayer <gbayer@linux.ibm.com>
>     net/smc: Fix setsockopt and sysctl to specify same buffer size again
> 
> Eric Dumazet <edumazet@google.com>
>     net/packet: annotate data-races around tp->status
> 
> Nitya Sunkad <nitya.sunkad@amd.com>
>     ionic: Add missing err handling for queue reconfig
> 
> Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>     igc: Add lock to safeguard global Qbv variables
> 
> Xiang Yang <xiangyang3@huawei.com>
>     mptcp: fix the incorrect judgment for msk->cb_flags
> 
> Eric Dumazet <edumazet@google.com>
>     macsec: use DEV_STATS_INC()
> 
> Nathan Chancellor <nathan@kernel.org>
>     mISDN: Update parameter type of dsp_cmx_send()
> 
> Aleksa Savic <savicaleksa83@gmail.com>
>     hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report
> 
> Xu Kuohai <xukuohai@huawei.com>
>     bpf, sockmap: Fix bug that strp_done cannot be called
> 
> Xu Kuohai <xukuohai@huawei.com>
>     bpf, sockmap: Fix map type error in sock_map_del_link
> 
> Andrew Kanner <andrew.kanner@gmail.com>
>     net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: bridge_mdb: Make test more robust
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: bridge_mdb: Fix failing test with old libnet
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: bridge_mdb_max: Fix failing test with old libnet
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: tc_flower: Relax success criterion
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: tc_actions: Use ncat instead of nc
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: Switch off timeout
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: Skip test when no interfaces are specified
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: ethtool: Skip when using veth pairs
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: Add a helper to skip test when using veth pairs
> 
> Mark Brown <broonie@kernel.org>
>     selftests/rseq: Fix build with undefined __weak
> 
> Xu Kuohai <xukuohai@huawei.com>
>     selftests/bpf: fix a CI failure caused by vsock sockmap test
> 
> Minjie Du <duminjie@vivo.com>
>     dmaengine: xilinx: xdma: Fix Judgment of the return value
> 
> Miquel Raynal <miquel.raynal@bootlin.com>
>     dmaengine: xilinx: xdma: Fix typo
> 
> Raghavendra Rao Ananta <rananta@google.com>
>     KVM: arm64: Fix hardware enable/disable flows for pKVM
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: bridge_mdb: Check iproute2 version
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: bridge_mdb_max: Check iproute2 version
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: ethtool_mm: Skip when MAC Merge is not supported
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: tc_tunnel_key: Make filters more specific
> 
> Neil Armstrong <neil.armstrong@linaro.org>
>     interconnect: qcom: sm8550: add enable_mask for bcm nodes
> 
> Neil Armstrong <neil.armstrong@linaro.org>
>     interconnect: qcom: sm8450: add enable_mask for bcm nodes
> 
> Neil Armstrong <neil.armstrong@linaro.org>
>     interconnect: qcom: sa8775p: add enable_mask for bcm nodes
> 
> Mike Tipton <mdtipton@codeaurora.org>
>     interconnect: qcom: Add support for mask-based BCMs
> 
> Matti Vaittinen <mazziesaccount@gmail.com>
>     iio: light: bu27034: Fix scale format
> 
> Milan Zamazal <mzamazal@redhat.com>
>     iio: core: Prevent invalid memory access when there is no parent
> 
> Alejandro Tafalla <atafalla@dnyon.com>
>     iio: imu: lsm6dsx: Fix mount matrix retrieval
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_set_hash: mark set element as dead when deleting from packet path
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: adapt set backend to use GC transaction API
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: GC transaction API to avoid race with control plane
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: don't skip expired elements during walk
> 
> Karol Herbst <kherbst@redhat.com>
>     drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes
> 
> Bjorn Helgaas <bhelgaas@google.com>
>     Revert "PCI: mvebu: Mark driver as BROKEN"
> 
> Arnd Bergmann <arnd@arndb.de>
>     x86: Move gds_ucode_mitigated() declaration to header
> 
> Arnd Bergmann <arnd@arndb.de>
>     x86/speculation: Add cpu_show_gds() prototype
> 
> Jinghao Jia <jinghao@linux.ibm.com>
>     x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h
> 
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/sev: Do not try to parse for the CC blob on non-AMD hardware
> 
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>     x86/mm: Fix VDSO and VVAR placement on 5-level paging machines
> 
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>     x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405
> 
> Xin Li <xin3.li@intel.com>
>     x86/vdso: Choose the right GDT_ENTRY_CPUNODE for 32-bit getcpu() on 64-bit kernel
> 
> Nick Desaulniers <ndesaulniers@google.com>
>     x86/srso: Fix build breakage with the LLVM linker
> 
> RD Babiera <rdbabiera@google.com>
>     usb: typec: altmodes/displayport: Signal hpd when configuring pin assignment
> 
> Badhri Jagan Sridharan <badhri@google.com>
>     usb: typec: tcpm: Fix response to vsafe0V event
> 
> Prashanth K <quic_prashk@quicinc.com>
>     usb: common: usb-conn-gpio: Prevent bailing out if initial role is none
> 
> Alan Stern <stern@rowland.harvard.edu>
>     USB: Gadget: core: Help prevent panic during UVC unconfigure
> 
> Elson Roy Serrao <quic_eserrao@quicinc.com>
>     usb: dwc3: Properly handle processing of pending events
> 
> Alan Stern <stern@rowland.harvard.edu>
>     usb-storage: alauda: Fix uninit-value in alauda_check_media()
> 
> Mika Westerberg <mika.westerberg@linux.intel.com>
>     thunderbolt: Fix memory leak in tb_handle_dp_bandwidth_request()
> 
> Ricky WU <ricky_wu@realtek.com>
>     misc: rtsx: judge ASPM Mode to set PETXCFG Reg
> 
> Qi Zheng <zhengqi.arch@bytedance.com>
>     binder: fix memory leak in binder_init()
> 
> Alvin Šipraga <alsi@bang-olufsen.dk>
>     iio: adc: ina2xx: avoid NULL pointer dereference on OF device match
> 
> George Stark <gnstark@sberdevices.ru>
>     iio: adc: meson: fix core clock enable/disable moment
> 
> Alisa Roman <alisa.roman@analog.com>
>     iio: adc: ad7192: Fix ac excitation feature
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     iio: frequency: admv1013: propagate errors from regulator_get_voltage()
> 
> Yiyuan Guo <yguoaz@gmail.com>
>     iio: cros_ec: Fix the allocation size for cros_ec_command
> 
> Evan Quan <evan.quan@amd.com>
>     drm/amd/pm: avoid unintentional shutdown due to temperature momentary fluctuation
> 
> Evan Quan <evan.quan@amd.com>
>     drm/amd/pm: expose swctf threshold setting for legacy powerplay
> 
> Miaohe Lin <linmiaohe@huawei.com>
>     mm: memory-failure: avoid false hwpoison page mapped error info
> 
> Miaohe Lin <linmiaohe@huawei.com>
>     mm: memory-failure: fix potential unexpected return value from unpoison_memory()
> 
> Ayush Jain <ayush.jain3@amd.com>
>     selftests: mm: ksm: fix incorrect evaluation of parameter
> 
> SeongJae Park <sj@kernel.org>
>     mm/damon/core: initialize damo_filter->list from damos_new_filter()
> 
> Mike Kravetz <mike.kravetz@oracle.com>
>     hugetlb: do not clear hugetlb dtor until allocating vmemmap
> 
> Karol Wachowski <karol.wachowski@linux.intel.com>
>     accel/ivpu: Add set_pages_array_wc/uc for internal buffers
> 
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>     nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput
> 
> Lorenzo Stoakes <lstoakes@gmail.com>
>     fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT regions
> 
> Thomas Weißschuh <linux@weissschuh.net>
>     cpufreq: amd-pstate: fix global sysfs attribute type
> 
> Colin Ian King <colin.i.king@gmail.com>
>     radix tree test suite: fix incorrect allocation size for pthreads
> 
> Tao Ren <rentao.bupt@gmail.com>
>     hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100
> 
> Andrew Yang <andrew.yang@mediatek.com>
>     zsmalloc: fix races between modifications of fullness and isolated
> 
> Aleksa Sarai <cyphar@cyphar.com>
>     io_uring: correct check for O_TMPFILE
> 
> Maulik Shah <quic_mkshah@quicinc.com>
>     cpuidle: psci: Move enabling OSI mode after power domains creation
> 
> Maulik Shah <quic_mkshah@quicinc.com>
>     cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
> 
> Jarkko Sakkinen <jarkko@kernel.org>
>     tpm_tis: Opt-in interrupts
> 
> Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>     tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Disable S/G for APUs when 64GB or more host memory
> 
> Melissa Wen <mwen@igalia.com>
>     drm/amd/display: check attr flag before set cursor degamma on DCN3+
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd/display: Fix a regression on Polaris cards
> 
> Kenneth Feng <kenneth.feng@amd.com>
>     drm/amd/pm: correct the pcie width for smu 13.0.0
> 
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
> 
> Boris Brezillon <boris.brezillon@collabora.com>
>     drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()
> 
> Lyude Paul <lyude@redhat.com>
>     drm/nouveau/nvkm/dp: Add workaround to fix DP 1.3+ DPCD issues
> 
> Karol Herbst <kherbst@redhat.com>
>     drm/nouveau/gr: enable memory loads on helper invocation on all channels
> 
> August Wikerfors <git@augustwikerfors.se>
>     nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G
> 
> Ming Lei <ming.lei@redhat.com>
>     nvme-rdma: fix potential unbalanced freeze & unfreeze
> 
> Ming Lei <ming.lei@redhat.com>
>     nvme-tcp: fix potential unbalanced freeze & unfreeze
> 
> Ming Lei <ming.lei@redhat.com>
>     nvme: fix possible hang when removing a controller during error recovery
> 
> Nick Desaulniers <ndesaulniers@google.com>
>     riscv: mm: fix 2 instances of -Wmissing-variable-declarations
> 
> Torsten Duwe <duwe@suse.de>
>     riscv/kexec: handle R_RISCV_CALL_PLT relocation type
> 
> Andrea Parri <parri.andrea@gmail.com>
>     riscv,mmio: Fix readX()-to-delay() ordering
> 
> Torsten Duwe <duwe@suse.de>
>     riscv/kexec: load initrd high in available memory
> 
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Start of DRAM should at least be aligned on PMD size for the direct mapping
> 
> Helge Deller <deller@gmx.de>
>     parisc: Fix lightweight spinlock checks to not break futexes
> 
> Helge Deller <deller@gmx.de>
>     io_uring/parisc: Adjust pgoff in io_uring mmap() for parisc
> 
> Christoph Hellwig <hch@lst.de>
>     zram: take device and not only bvec offset into account
> 
> Hans de Goede <hdegoede@redhat.com>
>     ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M
> 
> Hans de Goede <hdegoede@redhat.com>
>     ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
> 
> Hans de Goede <hdegoede@redhat.com>
>     ACPI: resource: Always use MADT override IRQ settings for all legacy non i8042 IRQs
> 
> Hans de Goede <hdegoede@redhat.com>
>     ACPI: resource: revert "Remove "Zen" specific match and quirks"
> 
> Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>     net: mana: Fix MANA VF unload when hardware is unresponsive
> 
> Miquel Raynal <miquel.raynal@bootlin.com>
>     dmaengine: xilinx: xdma: Fix interrupt vector setting
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>     dmaengine: pl330: Return DMA_PAUSED when transaction is paused
> 
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: fix disconnect vs accept race
> 
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: avoid bogus reset on fallback close
> 
> Andrea Claudi <aclaudi@redhat.com>
>     selftests: mptcp: join: fix 'implicit EP' test
> 
> Andrea Claudi <aclaudi@redhat.com>
>     selftests: mptcp: join: fix 'delete and re-add' test
> 
> Maciej Żenczykowski <maze@google.com>
>     ipv6: adjust ndisc_is_useropt() to also return true for PIO
> 
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>     mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
> 
> Sergei Antonov <saproj@gmail.com>
>     mmc: moxart: read scr register without changing byte order
> 
> Jason A. Donenfeld <Jason@zx2c4.com>
>     wireguard: allowedips: expand maximum node depth
> 
> Ido Schimmel <idosch@nvidia.com>
>     selftests: forwarding: Set default IPv6 traceroute utility
> 
> Ping-Ke Shih <pkshih@realtek.com>
>     wifi: rtw89: fix 8852AE disconnection caused by RX full flags
> 
> Keith Yeo <keithyjy@gmail.com>
>     wifi: nl80211: fix integer overflow in nl80211_parse_mbssid_elems()
> 
> Paolo Bonzini <pbonzini@redhat.com>
>     KVM: SEV: only access GHCB fields once
> 
> Paolo Bonzini <pbonzini@redhat.com>
>     KVM: SEV: snapshot the GHCB before accessing it
> 
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()
> 
> Long Li <leo.lilong@huawei.com>
>     ksmbd: validate command request size
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     tpm: Add a helper for checking hwrng enabled
> 
> Jonathan McDowell <noodles@meta.com>
>     tpm/tpm_tis: Disable interrupts for Lenovo P620 devices
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     tpm: Disable RNG for all AMD fTPMs
> 
> Takashi Iwai <tiwai@suse.de>
>     tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook S 15/17 Gen7
> 
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                                           |   4 +-
>  arch/alpha/kernel/setup.c                          |   3 +-
>  arch/arm64/kvm/arm.c                               |  15 +-
>  arch/parisc/Kconfig.debug                          |   2 +-
>  arch/parisc/include/asm/spinlock.h                 |   2 -
>  arch/parisc/include/asm/spinlock_types.h           |   6 +
>  arch/parisc/kernel/sys_parisc.c                    |  15 +-
>  arch/parisc/kernel/syscall.S                       |  23 +-
>  arch/riscv/include/asm/mmio.h                      |  16 +-
>  arch/riscv/include/asm/pgtable.h                   |   2 +
>  arch/riscv/kernel/elf_kexec.c                      |   3 +-
>  arch/riscv/mm/init.c                               |  16 +-
>  arch/riscv/mm/kasan_init.c                         |   1 -
>  arch/x86/boot/compressed/idt_64.c                  |   9 +-
>  arch/x86/boot/compressed/sev.c                     |  37 ++-
>  arch/x86/entry/vdso/vma.c                          |   4 +-
>  arch/x86/include/asm/acpi.h                        |   2 +
>  arch/x86/include/asm/linkage.h                     |   2 +-
>  arch/x86/include/asm/processor.h                   |   2 +
>  arch/x86/include/asm/segment.h                     |   2 +-
>  arch/x86/kernel/acpi/boot.c                        |   4 +
>  arch/x86/kernel/cpu/amd.c                          |   1 +
>  arch/x86/kernel/vmlinux.lds.S                      |  12 +-
>  arch/x86/kvm/svm/sev.c                             |  94 ++++----
>  arch/x86/kvm/svm/svm.h                             |  26 +++
>  arch/x86/kvm/x86.c                                 |   2 -
>  drivers/accel/ivpu/ivpu_gem.c                      |   8 +
>  drivers/acpi/resource.c                            |  64 +++++
>  drivers/acpi/scan.c                                |   1 +
>  drivers/android/binder.c                           |   1 +
>  drivers/android/binder_alloc.c                     |   6 +
>  drivers/android/binder_alloc.h                     |   1 +
>  drivers/block/zram/zram_drv.c                      |  32 ++-
>  drivers/char/tpm/tpm-chip.c                        |  83 ++-----
>  drivers/char/tpm/tpm_crb.c                         |  30 +++
>  drivers/char/tpm/tpm_tis.c                         |  20 +-
>  drivers/cpufreq/amd-pstate.c                       |  10 +-
>  drivers/cpuidle/cpuidle-psci-domain.c              |  39 ++--
>  drivers/cpuidle/dt_idle_genpd.c                    |  24 ++
>  drivers/cpuidle/dt_idle_genpd.h                    |   7 +
>  drivers/dma/idxd/device.c                          |   4 +-
>  drivers/dma/mcf-edma.c                             |  13 +-
>  drivers/dma/owl-dma.c                              |   2 +-
>  drivers/dma/pl330.c                                |  18 +-
>  drivers/dma/xilinx/xdma.c                          |   6 +-
>  drivers/gpio/gpio-sim.c                            |   1 +
>  drivers/gpio/gpio-ws16c48.c                        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  26 +++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   5 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   2 +-
>  .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   3 +-
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   |   7 +-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   2 +
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |  48 ++++
>  .../drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   |   4 +-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   2 +
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c    |  27 +--
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  10 +
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |   4 +
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |   4 +
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |   2 +
>  drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h |   1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  34 +++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   2 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   9 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   9 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   3 +-
>  drivers/gpu/drm/bridge/ite-it6505.c                |   4 +-
>  drivers/gpu/drm/drm_gem_shmem_helper.c             |   6 +
>  drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c      |  48 +++-
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |   4 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  |  10 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c     |  13 --
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  17 +-
>  drivers/hwmon/aquacomputer_d5next.c                |  37 ++-
>  drivers/hwmon/pmbus/bel-pfe.c                      |  16 +-
>  drivers/iio/adc/ad7192.c                           |  16 +-
>  drivers/iio/adc/ina2xx-adc.c                       |   9 +-
>  drivers/iio/adc/meson_saradc.c                     |  23 +-
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   2 +-
>  drivers/iio/frequency/admv1013.c                   |   5 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |   2 +-
>  drivers/iio/industrialio-core.c                    |   5 +-
>  drivers/iio/light/rohm-bu27034.c                   |  22 +-
>  drivers/infiniband/core/umem.c                     |   3 +-
>  drivers/infiniband/hw/bnxt_re/main.c               |   4 +-
>  drivers/infiniband/hw/hfi1/chip.c                  |   1 +
>  drivers/interconnect/qcom/bcm-voter.c              |   5 +
>  drivers/interconnect/qcom/icc-rpmh.h               |   2 +
>  drivers/interconnect/qcom/sa8775p.c                |   1 +
>  drivers/interconnect/qcom/sm8450.c                 |   9 +
>  drivers/interconnect/qcom/sm8550.c                 |  17 ++
>  drivers/isdn/mISDN/dsp.h                           |   2 +-
>  drivers/isdn/mISDN/dsp_cmx.c                       |   2 +-
>  drivers/isdn/mISDN/dsp_core.c                      |   2 +-
>  drivers/misc/cardreader/rts5227.c                  |   2 +-
>  drivers/misc/cardreader/rts5228.c                  |  18 --
>  drivers/misc/cardreader/rts5249.c                  |   3 +-
>  drivers/misc/cardreader/rts5260.c                  |  18 --
>  drivers/misc/cardreader/rts5261.c                  |  18 --
>  drivers/misc/cardreader/rtsx_pcr.c                 |   5 +-
>  drivers/mmc/host/moxart-mmc.c                      |   8 +-
>  drivers/mmc/host/sdhci_f_sdh30.c                   |  60 +++--
>  drivers/net/bonding/bond_main.c                    |   4 +-
>  drivers/net/dsa/ocelot/felix.c                     |   2 +
>  drivers/net/ethernet/freescale/enetc/enetc_pf.c    | 103 +++++---
>  drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   4 +-
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  14 +-
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   4 +-
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  24 +-
>  drivers/net/ethernet/ibm/ibmvnic.c                 | 112 +++++++--
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   5 +-
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c        |  11 +-
>  drivers/net/ethernet/intel/igc/igc.h               |   4 +
>  drivers/net/ethernet/intel/igc/igc_main.c          |  34 ++-
>  .../ethernet/marvell/prestera/prestera_router.c    |  14 +-
>  .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   6 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  11 +
>  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  21 +-
>  .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   2 +-
>  .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   5 +
>  drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |   3 +-
>  .../ethernet/mellanox/mlx5/core/steering/dr_ptrn.c |   2 +-
>  drivers/net/ethernet/microsoft/mana/mana_en.c      |  37 ++-
>  drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  23 +-
>  drivers/net/macsec.c                               |  28 +--
>  drivers/net/phy/at803x.c                           |   2 -
>  drivers/net/tun.c                                  |   2 +-
>  drivers/net/vxlan/vxlan_vnifilter.c                |  11 +-
>  drivers/net/wireguard/allowedips.c                 |   8 +-
>  drivers/net/wireguard/selftest/allowedips.c        |  16 +-
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   5 +
>  drivers/net/wireless/realtek/rtw89/mac.c           |   2 +-
>  drivers/nvme/host/core.c                           |  10 +-
>  drivers/nvme/host/pci.c                            |   3 +-
>  drivers/nvme/host/rdma.c                           |   3 +-
>  drivers/nvme/host/tcp.c                            |   3 +-
>  drivers/pci/bus.c                                  |   4 +-
>  drivers/pci/controller/Kconfig                     |   1 -
>  drivers/pci/of.c                                   |   5 -
>  drivers/platform/x86/lenovo-ymc.c                  |  25 ++
>  drivers/platform/x86/mlx-platform.c                |  23 +-
>  drivers/platform/x86/msi-ec.c                      |  18 +-
>  drivers/platform/x86/serial-multi-instantiate.c    |  35 ++-
>  drivers/scsi/53c700.c                              |   2 +-
>  drivers/scsi/fnic/fnic.h                           |   2 +-
>  drivers/scsi/fnic/fnic_scsi.c                      |   6 +-
>  drivers/scsi/qedf/qedf_main.c                      |  18 ++
>  drivers/scsi/qedi/qedi_main.c                      |  18 ++
>  drivers/scsi/raid_class.c                          |   1 +
>  drivers/scsi/scsi_proc.c                           |  30 +--
>  drivers/scsi/snic/snic_disc.c                      |   1 +
>  drivers/scsi/storvsc_drv.c                         |   4 -
>  drivers/thunderbolt/tb.c                           |   2 +
>  drivers/ufs/host/ufs-renesas.c                     |   2 +-
>  drivers/usb/common/usb-conn-gpio.c                 |   6 +-
>  drivers/usb/dwc3/gadget.c                          |   9 +-
>  drivers/usb/gadget/udc/core.c                      |   9 +
>  drivers/usb/storage/alauda.c                       |  12 +-
>  drivers/usb/typec/altmodes/displayport.c           |  18 +-
>  drivers/usb/typec/tcpm/tcpm.c                      |   7 +
>  fs/btrfs/block-group.c                             |  17 +-
>  fs/btrfs/block-group.h                             |   2 +
>  fs/btrfs/disk-io.c                                 |   3 +-
>  fs/btrfs/extent-tree.c                             |   5 +-
>  fs/btrfs/extent_io.c                               |  13 +-
>  fs/btrfs/inode.c                                   |  10 +-
>  fs/btrfs/relocation.c                              |  45 +++-
>  fs/btrfs/tree-checker.c                            |  14 ++
>  fs/nilfs2/inode.c                                  |   8 +
>  fs/nilfs2/segment.c                                |   2 +
>  fs/nilfs2/the_nilfs.h                              |   2 +
>  fs/proc/kcore.c                                    |  30 ++-
>  fs/smb/server/smb2misc.c                           |  10 +-
>  fs/smb/server/smb2pdu.c                            |   9 +-
>  include/linux/cpu.h                                |   2 +
>  include/linux/skmsg.h                              |   1 +
>  include/linux/tpm.h                                |   1 +
>  include/net/cfg80211.h                             |   3 +
>  include/net/netfilter/nf_tables.h                  |  64 ++++-
>  include/trace/events/tcp.h                         |   5 +-
>  io_uring/io_uring.c                                |   3 +
>  io_uring/openclose.c                               |   6 +-
>  mm/damon/core.c                                    |   1 +
>  mm/hugetlb.c                                       |  75 ++++--
>  mm/memory-failure.c                                |  29 +--
>  mm/zsmalloc.c                                      |  14 +-
>  net/core/filter.c                                  |   6 -
>  net/core/skmsg.c                                   |  10 +-
>  net/core/sock_map.c                                |  10 +-
>  net/dccp/output.c                                  |   2 +-
>  net/dccp/proto.c                                   |  10 +-
>  net/ipv4/ip_tunnel_core.c                          |   2 +-
>  net/ipv4/nexthop.c                                 |  28 +--
>  net/ipv6/ndisc.c                                   |   3 +-
>  net/mptcp/protocol.c                               |   4 +-
>  net/mptcp/protocol.h                               |   1 -
>  net/mptcp/subflow.c                                |  58 ++---
>  net/netfilter/nf_tables_api.c                      | 259 +++++++++++++++++++--
>  net/netfilter/nft_set_hash.c                       |  85 ++++---
>  net/netfilter/nft_set_pipapo.c                     |  66 ++++--
>  net/netfilter/nft_set_rbtree.c                     | 146 +++++++-----
>  net/packet/af_packet.c                             |  16 +-
>  net/smc/af_smc.c                                   |  77 ++++--
>  net/smc/smc.h                                      |   2 +-
>  net/smc/smc_clc.c                                  |   4 +-
>  net/smc/smc_core.c                                 |  25 +-
>  net/smc/smc_sysctl.c                               |  10 +-
>  net/tls/tls_device.c                               |  64 ++---
>  net/wireless/nl80211.c                             |   5 +-
>  net/xdp/xsk.c                                      |   1 +
>  tools/testing/radix-tree/regression1.c             |   2 +-
>  .../selftests/bpf/prog_tests/sockmap_listen.c      |   2 +-
>  tools/testing/selftests/mm/ksm_tests.c             |   1 +
>  tools/testing/selftests/net/fib_nexthops.sh        |  10 +
>  .../testing/selftests/net/forwarding/bridge_mdb.sh |  59 ++---
>  .../selftests/net/forwarding/bridge_mdb_max.sh     |  19 +-
>  tools/testing/selftests/net/forwarding/ethtool.sh  |   2 +
>  .../net/forwarding/ethtool_extended_state.sh       |   2 +
>  .../testing/selftests/net/forwarding/ethtool_mm.sh |  18 +-
>  .../selftests/net/forwarding/hw_stats_l3_gre.sh    |   2 +
>  .../net/forwarding/ip6_forward_instats_vrf.sh      |   2 +
>  tools/testing/selftests/net/forwarding/lib.sh      |  17 ++
>  tools/testing/selftests/net/forwarding/settings    |   1 +
>  .../testing/selftests/net/forwarding/tc_actions.sh |   6 +-
>  .../testing/selftests/net/forwarding/tc_flower.sh  |   8 +-
>  .../selftests/net/forwarding/tc_tunnel_key.sh      |   9 +-
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    |   6 +-
>  tools/testing/selftests/rseq/Makefile              |   4 +-
>  tools/testing/selftests/rseq/rseq.c                |   2 +
>  238 files changed, 2516 insertions(+), 1034 deletions(-)
> 
> 
