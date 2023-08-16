Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C4777ED04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346882AbjHPWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346937AbjHPWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:23:36 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531FFE56
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:23:33 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-649a11843b3so2530086d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692224612; x=1692829412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UfmNmBvfztuWDsjujqxbctVfQLnoa4unj/8ThkNkwZU=;
        b=pszzA9eRkOn22KUZMEvzc44XnYZJWafSudCrq1WyuK3lZzAsttWyvQNF4Eo9kDu0yk
         W5AuAvIGp3NBiITtGzM3ziAEcbPa984dAihWRZpKlTZBouyfY3EJ8Ehdf8wCpj+cJ1fE
         YqcceHBSeH6NVWGekzwMprKOmDV2l7TySxYQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692224612; x=1692829412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfmNmBvfztuWDsjujqxbctVfQLnoa4unj/8ThkNkwZU=;
        b=ZE52HkV8XAD2pUe06jkit8b9F8PII+BrD/ZXF4bwgQZsZ7nFFXXpZwgctnXXMFPB4A
         6598gBSAJrpnQAhsOrrTX6D5TcE3y7y2b8fHIS75ckLgxNyrqUOuWnyLUt+VHFhlduqA
         KGhCu6+FHT73PTzeByCKQ9Qq4JYJch11oUtr/uvkSLYu7cipfQQNM4qKj77QR3qDILQx
         JePS0zssbaQabXfXpbGUPJ+pybpVxsVTdn23JqALFtitlkJLivlUwOQy/7p4aLjI77Pu
         eUXlroKh/dwufGhHoqTFfq3W9m9asm8/51rVK9QXohp94Eu+C4sReeCubq1Nrrj+3iRr
         MRTA==
X-Gm-Message-State: AOJu0YyMjIy7DTERC6WSCQMMVvBVbq9LC8FvBmM4mqVb98kniRUF+ch4
        9+SL3ukI47hdysox0B8Pu2BegA==
X-Google-Smtp-Source: AGHT+IG6e+Upo1yW8mSSWK7SMLeTGLb25grTF+p0D2ITEvrG+B/BmckyORBB25kDb5qSntPCy6C26Q==
X-Received: by 2002:a0c:e150:0:b0:640:3ec2:317b with SMTP id c16-20020a0ce150000000b006403ec2317bmr2903666qvl.19.1692224612135;
        Wed, 16 Aug 2023 15:23:32 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id q8-20020a0c8cc8000000b0064743dd0633sm964652qvb.106.2023.08.16.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 15:23:31 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:23:30 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
Message-ID: <20230816222330.GA1455425@joel-ThinkPad-X1-Carbon-4th>
References: <20230813211718.757428827@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:17:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

Little too late to the party, but

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
>     Linux 6.1.46-rc1
> 
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amd/pm/smu7: move variables to where they are used
> 
> Eric Dumazet <edumazet@google.com>
>     sch_netem: fix issues in netem_change() vs get_dist_table()
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
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: report use refcount overflow
> 
> Ming Lei <ming.lei@redhat.com>
>     nvme-rdma: fix potential unbalanced freeze & unfreeze
> 
> Ming Lei <ming.lei@redhat.com>
>     nvme-tcp: fix potential unbalanced freeze & unfreeze
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
> Daniel Jurgens <danielj@nvidia.com>
>     net/mlx5: Allow 0 for total host VFs
> 
> Zhang Jianhua <chris.zjh@huawei.com>
>     dmaengine: owl-dma: Modify mismatched function name
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
> Michael Guralnik <michaelgur@nvidia.com>
>     RDMA/umem: Set iova in ODP flow
> 
> Felix Fietkau <nbd@nbd.name>
>     wifi: cfg80211: fix sband iftype data lookup for AP_VLAN
> 
> Daniel Stone <daniels@collabora.com>
>     drm/rockchip: Don't spam logs in atomic check
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
> Gerd Bayer <gbayer@linux.ibm.com>
>     net/smc: Use correct buffer sizes when switching between TCP and SMC
> 
> Eric Dumazet <edumazet@google.com>
>     net/packet: annotate data-races around tp->status
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
>     selftests: forwarding: tc_flower: Relax success criterion
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
> Neil Armstrong <neil.armstrong@linaro.org>
>     interconnect: qcom: sm8450: add enable_mask for bcm nodes
> 
> Mike Tipton <mdtipton@codeaurora.org>
>     interconnect: qcom: Add support for mask-based BCMs
> 
> Milan Zamazal <mzamazal@redhat.com>
>     iio: core: Prevent invalid memory access when there is no parent
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: don't skip expired elements during walk
> 
> Karol Herbst <kherbst@redhat.com>
>     drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes
> 
> Arnd Bergmann <arnd@arndb.de>
>     x86: Move gds_ucode_mitigated() declaration to header
> 
> Arnd Bergmann <arnd@arndb.de>
>     x86/speculation: Add cpu_show_gds() prototype
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
> Ricky WU <ricky_wu@realtek.com>
>     misc: rtsx: judge ASPM Mode to set PETXCFG Reg
> 
> Qi Zheng <zhengqi.arch@bytedance.com>
>     binder: fix memory leak in binder_init()
> 
> Alvin Šipraga <alsi@bang-olufsen.dk>
>     iio: adc: ina2xx: avoid NULL pointer dereference on OF device match
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
> Aleksa Sarai <cyphar@cyphar.com>
>     io_uring: correct check for O_TMPFILE
> 
> Aurabindo Pillai <aurabindo.pillai@amd.com>
>     drm/amd/display: trigger timing sync only if TG is running
> 
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amd/display: fix the build when DRM_AMD_DC_DCN is not set
> 
> Alvin Lee <Alvin.Lee2@amd.com>
>     drm/amd/display: Retain phantom plane/stream if validation fails
> 
> Alvin Lee <Alvin.Lee2@amd.com>
>     drm/amd/display: Disable phantom OTG after enable for plane disable
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     drm/amd/display: Use update plane and stream routine for DCN32x
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     drm/amd/display: Avoid ABM when ODM combine is enabled for eDP
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     drm/amd/display: Update OTG instance in the commit stream
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     drm/amd/display: Handle seamless boot stream
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     drm/amd/display: Add function for validate and update new stream
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>     drm/amd/display: Handle virtual hardware detect
> 
> Evan Quan <evan.quan@amd.com>
>     drm/amd/pm: avoid unintentional shutdown due to temperature momentary fluctuation
> 
> Evan Quan <evan.quan@amd.com>
>     drm/amd/pm: fulfill powerplay peak profiling mode shader/memory clock settings
> 
> Evan Quan <evan.quan@amd.com>
>     drm/amd/pm: expose swctf threshold setting for legacy powerplay
> 
> Evan Quan <evan.quan@amd.com>
>     drm/amd/pm: fulfill swsmu peak profiling mode shader/memory clock settings
> 
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>     nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput
> 
> Colin Ian King <colin.i.king@gmail.com>
>     radix tree test suite: fix incorrect allocation size for pthreads
> 
> Tao Ren <rentao.bupt@gmail.com>
>     hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100
> 
> Maulik Shah <quic_mkshah@quicinc.com>
>     cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
> 
> Peichen Huang <peichen.huang@amd.com>
>     drm/amd/display: limit DPIA link rate to HBR3
> 
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Disable S/G for APUs when 64GB or more host memory
> 
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu: add S/G display parameter
> 
> Melissa Wen <mwen@igalia.com>
>     drm/amd/display: check attr flag before set cursor degamma on DCN3+
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
> Torsten Duwe <duwe@suse.de>
>     riscv/kexec: handle R_RISCV_CALL_PLT relocation type
> 
> Andrea Parri <parri.andrea@gmail.com>
>     riscv,mmio: Fix readX()-to-delay() ordering
> 
> Torsten Duwe <duwe@suse.de>
>     riscv/kexec: load initrd high in available memory
> 
> Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>     net: mana: Fix MANA VF unload when hardware is unresponsive
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
> Mario Limonciello <mario.limonciello@amd.com>
>     tpm: Disable RNG for all AMD fTPMs
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "loongarch/cpu: Switch to arch_cpu_finalize_init()"
> 
> Kees Cook <keescook@chromium.org>
>     gcc-plugins: Reorganize gimple includes for GCC 13
> 
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                                           |   4 +-
>  arch/alpha/kernel/setup.c                          |   3 +-
>  arch/loongarch/Kconfig                             |   1 -
>  arch/loongarch/kernel/setup.c                      |   6 -
>  arch/riscv/include/asm/mmio.h                      |  16 +-
>  arch/riscv/kernel/elf_kexec.c                      |   3 +-
>  arch/x86/boot/compressed/idt_64.c                  |   9 +-
>  arch/x86/boot/compressed/sev.c                     |  37 +++-
>  arch/x86/entry/vdso/vma.c                          |   4 +-
>  arch/x86/include/asm/processor.h                   |   2 +
>  arch/x86/kernel/cpu/amd.c                          |   1 +
>  arch/x86/kernel/vmlinux.lds.S                      |  12 +-
>  arch/x86/kvm/svm/sev.c                             |  94 +++++----
>  arch/x86/kvm/svm/svm.h                             |  26 +++
>  arch/x86/kvm/x86.c                                 |   2 -
>  drivers/acpi/scan.c                                |   1 +
>  drivers/android/binder.c                           |   1 +
>  drivers/android/binder_alloc.c                     |   6 +
>  drivers/android/binder_alloc.h                     |   1 +
>  drivers/char/tpm/tpm-chip.c                        |  83 ++------
>  drivers/char/tpm/tpm_crb.c                         |  30 +++
>  drivers/cpuidle/dt_idle_genpd.c                    |  24 +++
>  drivers/cpuidle/dt_idle_genpd.h                    |   7 +
>  drivers/dma/mcf-edma.c                             |  13 +-
>  drivers/dma/owl-dma.c                              |   2 +-
>  drivers/dma/pl330.c                                |  18 +-
>  drivers/gpio/gpio-sim.c                            |   1 +
>  drivers/gpio/gpio-ws16c48.c                        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  26 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  11 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c           |  74 ++++++-
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   5 +
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  | 234 ++++++++++++++++++++-
>  drivers/gpu/drm/amd/display/dc/dc.h                |   6 +
>  .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   6 +
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   |   7 +-
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |   8 +
>  .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |  22 ++
>  .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.h  |   3 +
>  .../drm/amd/display/dc/dcn321/dcn321_resource.c    |   1 +
>  drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   1 +
>  .../drm/amd/display/dc/inc/hw/timing_generator.h   |   1 +
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   2 +
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   2 +
>  drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |  58 ++++-
>  .../drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   |   4 +-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  16 +-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  80 +++++--
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |  16 +-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu_helper.c    |  27 +--
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  41 +++-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  26 +++
>  .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  24 +--
>  drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |   4 +
>  drivers/gpu/drm/amd/pm/powerplay/inc/power_state.h |   1 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  42 ++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   2 +
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   9 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   9 +-
>  drivers/gpu/drm/drm_gem_shmem_helper.c             |   6 +
>  drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c      |  48 ++++-
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |   4 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  |  10 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |   1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  17 +-
>  drivers/hwmon/pmbus/bel-pfe.c                      |  16 +-
>  drivers/iio/adc/ad7192.c                           |  16 +-
>  drivers/iio/adc/ina2xx-adc.c                       |   9 +-
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   2 +-
>  drivers/iio/frequency/admv1013.c                   |   5 +-
>  drivers/iio/industrialio-core.c                    |   5 +-
>  drivers/infiniband/core/umem.c                     |   3 +-
>  drivers/infiniband/hw/hfi1/chip.c                  |   1 +
>  drivers/interconnect/qcom/bcm-voter.c              |   5 +
>  drivers/interconnect/qcom/icc-rpmh.h               |   2 +
>  drivers/interconnect/qcom/sm8450.c                 |   9 +
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
>  drivers/net/bonding/bond_main.c                    |   4 +-
>  drivers/net/dsa/ocelot/felix.c                     |   2 +
>  drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   4 +-
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  14 +-
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   4 +-
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  24 ++-
>  drivers/net/ethernet/ibm/ibmvnic.c                 | 112 ++++++++--
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   5 +-
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c        |  11 +-
>  .../ethernet/marvell/prestera/prestera_router.c    |  14 +-
>  .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   2 +-
>  .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   5 +
>  drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |   3 +-
>  drivers/net/ethernet/microsoft/mana/mana_en.c      |  37 +++-
>  drivers/net/macsec.c                               |  28 +--
>  drivers/net/phy/at803x.c                           |   2 -
>  drivers/net/tun.c                                  |   2 +-
>  drivers/net/vxlan/vxlan_vnifilter.c                |  11 +-
>  drivers/net/wireguard/allowedips.c                 |   8 +-
>  drivers/net/wireguard/selftest/allowedips.c        |  16 +-
>  drivers/net/wireless/realtek/rtw89/mac.c           |   2 +-
>  drivers/nvme/host/pci.c                            |   3 +-
>  drivers/nvme/host/rdma.c                           |   3 +-
>  drivers/nvme/host/tcp.c                            |   3 +-
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
>  fs/btrfs/extent_io.c                               |   7 +-
>  fs/btrfs/inode.c                                   |  10 +-
>  fs/btrfs/relocation.c                              |  45 +++-
>  fs/btrfs/tree-checker.c                            |  14 ++
>  fs/nilfs2/inode.c                                  |   8 +
>  fs/nilfs2/segment.c                                |   2 +
>  fs/nilfs2/the_nilfs.h                              |   2 +
>  fs/smb/server/smb2misc.c                           |  10 +-
>  fs/smb/server/smb2pdu.c                            |   9 +-
>  include/linux/cpu.h                                |   2 +
>  include/linux/skmsg.h                              |   1 +
>  include/linux/tpm.h                                |   1 +
>  include/net/cfg80211.h                             |   3 +
>  include/net/netfilter/nf_tables.h                  |  31 ++-
>  include/trace/events/tcp.h                         |   5 +-
>  io_uring/openclose.c                               |   6 +-
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
>  net/netfilter/nf_tables_api.c                      | 167 +++++++++------
>  net/netfilter/nft_flow_offload.c                   |   6 +-
>  net/netfilter/nft_immediate.c                      |   8 +-
>  net/netfilter/nft_objref.c                         |   8 +-
>  net/netfilter/nft_set_hash.c                       |   2 -
>  net/netfilter/nft_set_pipapo.c                     |  18 +-
>  net/netfilter/nft_set_rbtree.c                     |   2 -
>  net/packet/af_packet.c                             |  16 +-
>  net/sched/sch_netem.c                              |  59 +++---
>  net/smc/af_smc.c                                   |  73 +++++--
>  net/tls/tls_device.c                               |  64 +++---
>  net/wireless/nl80211.c                             |   5 +-
>  net/xdp/xsk.c                                      |   1 +
>  scripts/gcc-plugins/gcc-common.h                   |   4 +-
>  tools/testing/radix-tree/regression1.c             |   2 +-
>  tools/testing/selftests/net/fib_nexthops.sh        |  10 +
>  tools/testing/selftests/net/forwarding/ethtool.sh  |   2 +
>  .../net/forwarding/ethtool_extended_state.sh       |   2 +
>  .../selftests/net/forwarding/hw_stats_l3_gre.sh    |   2 +
>  .../net/forwarding/ip6_forward_instats_vrf.sh      |   2 +
>  tools/testing/selftests/net/forwarding/lib.sh      |  17 ++
>  tools/testing/selftests/net/forwarding/settings    |   1 +
>  .../testing/selftests/net/forwarding/tc_flower.sh  |   8 +-
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    |   6 +-
>  tools/testing/selftests/rseq/Makefile              |   4 +-
>  tools/testing/selftests/rseq/rseq.c                |   2 +
>  192 files changed, 1992 insertions(+), 745 deletions(-)
> 
> 
