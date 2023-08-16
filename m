Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBFD77ED0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346910AbjHPW0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346902AbjHPW0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:26:22 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D2E56
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:26:20 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bcf2fd5d69so6190154a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692224779; x=1692829579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mj8sP83fwQJwoEIWe+N0bDewpCENMlpgnFvs5MDXGYc=;
        b=PrEWrARPly2E7lq6aw7kGSryWqF3Sxqfn03diJhqdaQLioRlND++z/rGnxi1u0MWaT
         hOhbXGuW0Qp85tguIYTL+P5Lf+548YFyiXSyCnbBMVKOXCf3HaGbxp9Hl635BZlC9yu9
         8HjOH9dEm0qWc0+KjpIfGYLlr3dK/W8qfoVfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692224779; x=1692829579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mj8sP83fwQJwoEIWe+N0bDewpCENMlpgnFvs5MDXGYc=;
        b=enwCXYGoZrT6aRD7/N17FwIb3jbzhTq5lVJOBJthoj1iQAzlkHGyMIGFdUbScjfU1n
         BBISctbiUn5sdTd2AAN72TmVgolDFv36dCjpYv+0WMBiQTINKStFVjxG3IL5teHVCkic
         wIw3hCNevtEeG3R4PUBiBczvNLWPFOxOsdqo5vc302EZxV38Yzma3AkDOMwSObNIxPSL
         gRSYBVd2Dt3BgVNgT6UCT9txaJbWUZ6+NMtadpDeLTA4xbMDubiGk0dIzoL74c5cOgfY
         Droldf+R3NG0cMMYIq7xRVQ1zs5IlyIex0KL8ifLIQbazUcRT9zfbGr2pfUnLPJJOX9E
         CA1g==
X-Gm-Message-State: AOJu0YwZiDgTRnHVmH5OsCHPSj6nv8gJvTFSHXBKvBfhNM6exG6DoUjL
        X4hBV2Mn9bjcc1xQSkTAcmLWiQ==
X-Google-Smtp-Source: AGHT+IHeRZXn4M/vsFcPK7DZe1Bixm4L6gO+i4z/bf3qoRZATD0pXNz/BR0LDNd/U0yjCv/gi/sShw==
X-Received: by 2002:a05:6830:4c4:b0:6bc:f636:153a with SMTP id s4-20020a05683004c400b006bcf636153amr2986679otd.6.1692224779582;
        Wed, 16 Aug 2023 15:26:19 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a130c00b00767d2870e39sm4732290qkj.41.2023.08.16.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 15:26:19 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:26:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
Message-ID: <20230816222618.GB1455425@joel-ThinkPad-X1-Carbon-4th>
References: <20230813211710.787645394@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 11:18:51PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.

Too late here.

Anyway for RCU it passed,

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
>     Linux 5.15.127-rc1
> 
> Frederic Weisbecker <frederic@kernel.org>
>     timers/nohz: Last resort update jiffies on nohz_full IRQ entry
> 
> Nicholas Piggin <npiggin@gmail.com>
>     timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped
> 
> Frederic Weisbecker <frederic@kernel.org>
>     tick: Detect and fix jiffies update stall
> 
> Eric Dumazet <edumazet@google.com>
>     sch_netem: fix issues in netem_change() vs get_dist_table()
> 
> Masahiro Yamada <masahiroy@kernel.org>
>     alpha: remove __init annotation from exported page_is_ram()
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
>     btrfs: don't stop integrity writeback too early
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
>     net/mlx5: Skip clock update work when device is in error state
> 
> Daniel Jurgens <danielj@nvidia.com>
>     net/mlx5: Allow 0 for total host VFs
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     dmaengine: mcf-edma: Fix a potential un-allocated memory access
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
> Jie Wang <wangjie125@huawei.com>
>     net: hns3: add wait until mac link down
> 
> Jie Wang <wangjie125@huawei.com>
>     net: hns3: refactor hclge_mac_link_status_wait for interface reuse
> 
> Li Yang <leoyang.li@nxp.com>
>     net: phy: at803x: remove set/get wol callbacks for AR8032
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
>     net/packet: annotate data-races around tp->status
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
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>     x86/mm: Fix VDSO and VVAR placement on 5-level paging machines
> 
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>     x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405
> 
> Nick Desaulniers <ndesaulniers@google.com>
>     x86/srso: Fix build breakage with the LLVM linker
> 
> Badhri Jagan Sridharan <badhri@google.com>
>     usb: typec: tcpm: Fix response to vsafe0V event
> 
> Prashanth K <quic_prashk@quicinc.com>
>     usb: common: usb-conn-gpio: Prevent bailing out if initial role is none
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
> Yiyuan Guo <yguoaz@gmail.com>
>     iio: cros_ec: Fix the allocation size for cros_ec_command
> 
> Aleksa Sarai <cyphar@cyphar.com>
>     io_uring: correct check for O_TMPFILE
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
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>     nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput
> 
> Colin Ian King <colin.i.king@gmail.com>
>     radix tree test suite: fix incorrect allocation size for pthreads
> 
> Tao Ren <rentao.bupt@gmail.com>
>     hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100
> 
> Melissa Wen <mwen@igalia.com>
>     drm/amd/display: check attr flag before set cursor degamma on DCN3+
> 
> Boris Brezillon <boris.brezillon@collabora.com>
>     drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()
> 
> Karol Herbst <kherbst@redhat.com>
>     drm/nouveau/gr: enable memory loads on helper invocation on all channels
> 
> Andrea Parri <parri.andrea@gmail.com>
>     riscv,mmio: Fix readX()-to-delay() ordering
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>     dmaengine: pl330: Return DMA_PAUSED when transaction is paused
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
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()
> 
> Long Li <leo.lilong@huawei.com>
>     ksmbd: validate command request size
> 
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                                           |   4 +-
>  arch/alpha/kernel/setup.c                          |   3 +-
>  arch/riscv/include/asm/mmio.h                      |  16 +-
>  arch/x86/entry/vdso/vma.c                          |   4 +-
>  arch/x86/include/asm/processor.h                   |   2 +
>  arch/x86/kernel/cpu/amd.c                          |   1 +
>  arch/x86/kernel/vmlinux.lds.S                      |  12 +-
>  arch/x86/kvm/x86.c                                 |   2 -
>  drivers/android/binder.c                           |   1 +
>  drivers/android/binder_alloc.c                     |   6 +
>  drivers/android/binder_alloc.h                     |   1 +
>  drivers/dma/mcf-edma.c                             |  13 +-
>  drivers/dma/pl330.c                                |  18 +-
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   |   7 +-
>  drivers/gpu/drm/drm_gem_shmem_helper.c             |   6 +
>  drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |   4 +-
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  |  10 ++
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |   1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |   1 +
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  17 +-
>  drivers/hwmon/pmbus/bel-pfe.c                      |  16 +-
>  drivers/iio/adc/ina2xx-adc.c                       |   9 +-
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   2 +-
>  drivers/infiniband/core/umem.c                     |   3 +-
>  drivers/infiniband/hw/hfi1/chip.c                  |   1 +
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
>  .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  24 ++-
>  drivers/net/ethernet/ibm/ibmvnic.c                 |  38 +++-
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   5 +-
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c        |  11 +-
>  .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   5 +
>  drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |   3 +-
>  drivers/net/phy/at803x.c                           |   2 -
>  drivers/net/tun.c                                  |   2 +-
>  drivers/net/wireguard/allowedips.c                 |   8 +-
>  drivers/net/wireguard/selftest/allowedips.c        |  16 +-
>  drivers/nvme/host/rdma.c                           |   3 +-
>  drivers/nvme/host/tcp.c                            |   3 +-
>  drivers/scsi/53c700.c                              |   2 +-
>  drivers/scsi/fnic/fnic_scsi.c                      |   6 +-
>  drivers/scsi/qedf/qedf_main.c                      |  18 ++
>  drivers/scsi/qedi/qedi_main.c                      |  18 ++
>  drivers/scsi/raid_class.c                          |   1 +
>  drivers/scsi/scsi_proc.c                           |  30 ++--
>  drivers/scsi/snic/snic_disc.c                      |   1 +
>  drivers/scsi/storvsc_drv.c                         |   4 -
>  drivers/usb/common/usb-conn-gpio.c                 |   6 +-
>  drivers/usb/dwc3/gadget.c                          |   9 +-
>  drivers/usb/storage/alauda.c                       |  12 +-
>  drivers/usb/typec/tcpm/tcpm.c                      |   7 +
>  fs/btrfs/disk-io.c                                 |   3 +-
>  fs/btrfs/extent-tree.c                             |   5 +-
>  fs/btrfs/extent_io.c                               |   7 +-
>  fs/btrfs/relocation.c                              |  45 ++++-
>  fs/btrfs/tree-checker.c                            |  14 ++
>  fs/ksmbd/smb2misc.c                                |  10 +-
>  fs/ksmbd/smb2pdu.c                                 |   9 +-
>  fs/nilfs2/inode.c                                  |   8 +
>  fs/nilfs2/segment.c                                |   2 +
>  fs/nilfs2/the_nilfs.h                              |   2 +
>  include/linux/cpu.h                                |   2 +
>  include/linux/skmsg.h                              |   1 +
>  include/net/cfg80211.h                             |   3 +
>  include/net/netfilter/nf_tables.h                  |  31 +++-
>  io_uring/io_uring.c                                |   6 +-
>  kernel/bpf/verifier.c                              | 199 +++++++++++++++++++--
>  kernel/softirq.c                                   |   3 +-
>  kernel/time/tick-sched.c                           |  36 +++-
>  kernel/time/tick-sched.h                           |   4 +
>  net/core/filter.c                                  |   6 -
>  net/core/skmsg.c                                   |  10 +-
>  net/core/sock_map.c                                |  10 +-
>  net/dccp/output.c                                  |   2 +-
>  net/dccp/proto.c                                   |  10 +-
>  net/ipv4/ip_tunnel_core.c                          |   2 +-
>  net/ipv4/nexthop.c                                 |  28 +--
>  net/ipv6/ndisc.c                                   |   3 +-
>  net/netfilter/nf_tables_api.c                      | 168 ++++++++++-------
>  net/netfilter/nft_flow_offload.c                   |   6 +-
>  net/netfilter/nft_immediate.c                      |   8 +-
>  net/netfilter/nft_objref.c                         |   8 +-
>  net/netfilter/nft_set_hash.c                       |   2 -
>  net/netfilter/nft_set_pipapo.c                     |  18 +-
>  net/netfilter/nft_set_rbtree.c                     |   2 -
>  net/packet/af_packet.c                             |  16 +-
>  net/sched/sch_netem.c                              |  59 +++---
>  net/xdp/xsk.c                                      |   1 +
>  tools/testing/radix-tree/regression1.c             |   2 +-
>  tools/testing/selftests/bpf/prog_tests/align.c     |  36 ++--
>  tools/testing/selftests/bpf/prog_tests/sk_assign.c |  25 ++-
>  tools/testing/selftests/bpf/progs/connect4_prog.c  |   2 +-
>  tools/testing/selftests/bpf/progs/test_sk_assign.c |  11 ++
>  .../selftests/bpf/progs/test_sk_assign_libbpf.c    |   3 +
>  tools/testing/selftests/net/fib_nexthops.sh        |  10 ++
>  tools/testing/selftests/net/forwarding/ethtool.sh  |   2 +
>  .../net/forwarding/ethtool_extended_state.sh       |   2 +
>  tools/testing/selftests/net/forwarding/lib.sh      |  16 ++
>  tools/testing/selftests/net/forwarding/settings    |   1 +
>  .../testing/selftests/net/forwarding/tc_flower.sh  |   8 +-
>  tools/testing/selftests/rseq/Makefile              |   4 +-
>  tools/testing/selftests/rseq/rseq.c                |   2 +
>  114 files changed, 946 insertions(+), 407 deletions(-)
> 
> 
