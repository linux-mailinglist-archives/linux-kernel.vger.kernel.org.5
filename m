Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6749F78217E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjHUCfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjHUCfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:35:03 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC48AA0;
        Sun, 20 Aug 2023 19:34:58 -0700 (PDT)
Received: from dggpeml500006.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RTc1k2YPMzLp6N;
        Mon, 21 Aug 2023 10:31:54 +0800 (CST)
Received: from [10.174.176.127] (10.174.176.127) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 10:34:56 +0800
Subject: Re: [PATCH 5.10 00/68] 5.10.191-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
References: <20230813211708.149630011@linuxfoundation.org>
From:   luomeng <luomeng12@huawei.com>
Message-ID: <0b2341d8-98e4-1dc4-cd7b-93332f551c5b@huawei.com>
Date:   Mon, 21 Aug 2023 10:34:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on arm64 and x86 for 5.10.191-rc1,

Kernel 
repo:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
Branch: linux-5.10.y
Version:  5.10.191-rc1
Commit: da742ebfa00c3add4a358dd79ec92161c07e1435
Compiler: gcc version 7.3.0 (GCC)

arm64:
--------------------------------------------------------------------
Testcase Result Summary:
total: 8978
passed: 8978
failed: 0
timeout: 0
--------------------------------------------------------------------

x86:
--------------------------------------------------------------------
Testcase Result Summary:
total: 8978
passed: 8978
failed: 0
timeout: 0
--------------------------------------------------------------------
Tested-by: Hulk Robot <hulkrobot@huawei.com>

在 2023/8/14 5:19, Greg Kroah-Hartman 写道:
> This is the start of the stable review cycle for the 5.10.191 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.191-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
>      Linux 5.10.191-rc1
> 
> Eric Dumazet <edumazet@google.com>
>      sch_netem: fix issues in netem_change() vs get_dist_table()
> 
> Masahiro Yamada <masahiroy@kernel.org>
>      alpha: remove __init annotation from exported page_is_ram()
> 
> Nilesh Javali <njavali@marvell.com>
>      scsi: qedf: Fix firmware halt over suspend and resume
> 
> Nilesh Javali <njavali@marvell.com>
>      scsi: qedi: Fix firmware halt over suspend and resume
> 
> Zhu Wang <wangzhu9@huawei.com>
>      scsi: core: Fix possible memory leak if device_add() fails
> 
> Zhu Wang <wangzhu9@huawei.com>
>      scsi: snic: Fix possible memory leak if device_add() fails
> 
> Alexandra Diupina <adiupina@astralinux.ru>
>      scsi: 53c700: Check that command slot is not NULL
> 
> Michael Kelley <mikelley@microsoft.com>
>      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts
> 
> Tony Battersby <tonyb@cybernetics.com>
>      scsi: core: Fix legacy /proc parsing buffer overflow
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: report use refcount overflow
> 
> Ming Lei <ming.lei@redhat.com>
>      nvme-rdma: fix potential unbalanced freeze & unfreeze
> 
> Ming Lei <ming.lei@redhat.com>
>      nvme-tcp: fix potential unbalanced freeze & unfreeze
> 
> Josef Bacik <josef@toxicpanda.com>
>      btrfs: set cache_block_group_error if we find an error
> 
> Christoph Hellwig <hch@lst.de>
>      btrfs: don't stop integrity writeback too early
> 
> Nick Child <nnac123@linux.ibm.com>
>      ibmvnic: Handle DMA unmapping of login buffs in release functions
> 
> Nick Child <nnac123@linux.ibm.com>
>      ibmvnic: Unmap DMA login rsp buffer on send login fail
> 
> Nick Child <nnac123@linux.ibm.com>
>      ibmvnic: Enforce stronger sanity checks on login response
> 
> Daniel Jurgens <danielj@nvidia.com>
>      net/mlx5: Allow 0 for total host VFs
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      dmaengine: mcf-edma: Fix a potential un-allocated memory access
> 
> Jie Wang <wangjie125@huawei.com>
>      net: hns3: add wait until mac link down
> 
> Jie Wang <wangjie125@huawei.com>
>      net: hns3: refactor hclge_mac_link_status_wait for interface reuse
> 
> Li Yang <leoyang.li@nxp.com>
>      net: phy: at803x: remove set/get wol callbacks for AR8032
> 
> Felix Fietkau <nbd@nbd.name>
>      wifi: cfg80211: fix sband iftype data lookup for AP_VLAN
> 
> Douglas Miller <doug.miller@cornelisnetworks.com>
>      IB/hfi1: Fix possible panic during hotplug remove
> 
> Andrew Kanner <andrew.kanner@gmail.com>
>      drivers: net: prevent tun_build_skb() to exceed the packet size limit
> 
> Eric Dumazet <edumazet@google.com>
>      dccp: fix data-race around dp->dccps_mss_cache
> 
> Ziyang Xuan <william.xuanziyang@huawei.com>
>      bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves
> 
> Florian Westphal <fw@strlen.de>
>      tunnels: fix kasan splat when generating ipv4 pmtu error
> 
> Eric Dumazet <edumazet@google.com>
>      net/packet: annotate data-races around tp->status
> 
> Nathan Chancellor <nathan@kernel.org>
>      mISDN: Update parameter type of dsp_cmx_send()
> 
> Ido Schimmel <idosch@nvidia.com>
>      selftests: forwarding: tc_flower: Relax success criterion
> 
> Ido Schimmel <idosch@nvidia.com>
>      selftests: forwarding: Switch off timeout
> 
> Ido Schimmel <idosch@nvidia.com>
>      selftests: forwarding: Skip test when no interfaces are specified
> 
> Ido Schimmel <idosch@nvidia.com>
>      selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
> 
> Ido Schimmel <idosch@nvidia.com>
>      selftests: forwarding: ethtool: Skip when using veth pairs
> 
> Ido Schimmel <idosch@nvidia.com>
>      selftests: forwarding: Add a helper to skip test when using veth pairs
> 
> Mark Brown <broonie@kernel.org>
>      selftests/rseq: Fix build with undefined __weak
> 
> Florian Westphal <fw@strlen.de>
>      netfilter: nf_tables: don't skip expired elements during walk
> 
> Karol Herbst <kherbst@redhat.com>
>      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes
> 
> Arnd Bergmann <arnd@arndb.de>
>      x86: Move gds_ucode_mitigated() declaration to header
> 
> Arnd Bergmann <arnd@arndb.de>
>      x86/speculation: Add cpu_show_gds() prototype
> 
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines
> 
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>      x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405
> 
> Nick Desaulniers <ndesaulniers@google.com>
>      x86/srso: Fix build breakage with the LLVM linker
> 
> Prashanth K <quic_prashk@quicinc.com>
>      usb: common: usb-conn-gpio: Prevent bailing out if initial role is none
> 
> Elson Roy Serrao <quic_eserrao@quicinc.com>
>      usb: dwc3: Properly handle processing of pending events
> 
> Alan Stern <stern@rowland.harvard.edu>
>      usb-storage: alauda: Fix uninit-value in alauda_check_media()
> 
> Qi Zheng <zhengqi.arch@bytedance.com>
>      binder: fix memory leak in binder_init()
> 
> Yiyuan Guo <yguoaz@gmail.com>
>      iio: cros_ec: Fix the allocation size for cros_ec_command
> 
> Aleksa Sarai <cyphar@cyphar.com>
>      io_uring: correct check for O_TMPFILE
> 
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput
> 
> Thomas Gleixner <tglx@linutronix.de>
>      x86/pkeys: Revert a5eff7259790 ("x86/pkeys: Add PKRU value to init_fpstate")
> 
> Colin Ian King <colin.i.king@gmail.com>
>      radix tree test suite: fix incorrect allocation size for pthreads
> 
> Tao Ren <rentao.bupt@gmail.com>
>      hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100
> 
> Melissa Wen <mwen@igalia.com>
>      drm/amd/display: check attr flag before set cursor degamma on DCN3+
> 
> Boris Brezillon <boris.brezillon@collabora.com>
>      drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()
> 
> Karol Herbst <kherbst@redhat.com>
>      drm/nouveau/gr: enable memory loads on helper invocation on all channels
> 
> Andrea Parri <parri.andrea@gmail.com>
>      riscv,mmio: Fix readX()-to-delay() ordering
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      dmaengine: pl330: Return DMA_PAUSED when transaction is paused
> 
> Ilya Leoshkevich <iii@linux.ibm.com>
>      selftests/bpf: Fix sk_assign on s390x
> 
> Yonghong Song <yhs@fb.com>
>      selftests/bpf: Workaround verification failure for fexit_bpf2bpf/func_replace_return_code
> 
> Andrii Nakryiko <andrii@kernel.org>
>      selftests/bpf: make test_align selftest more robust
> 
> Andrii Nakryiko <andrii@kernel.org>
>      bpf: aggressively forget precise markings during state checkpointing
> 
> Andrii Nakryiko <andrii@kernel.org>
>      bpf: stop setting precise in current state
> 
> Andrii Nakryiko <andrii@kernel.org>
>      bpf: allow precision tracking for programs with subprogs
> 
> Maciej Żenczykowski <maze@google.com>
>      ipv6: adjust ndisc_is_useropt() to also return true for PIO
> 
> Sergei Antonov <saproj@gmail.com>
>      mmc: moxart: read scr register without changing byte order
> 
> Jason A. Donenfeld <Jason@zx2c4.com>
>      wireguard: allowedips: expand maximum node depth
> 
> 
> -------------
> 
> Diffstat:
> 
>   Makefile                                           |   4 +-
>   arch/alpha/kernel/setup.c                          |   3 +-
>   arch/riscv/include/asm/mmio.h                      |  16 +-
>   arch/x86/entry/vdso/vma.c                          |   4 +-
>   arch/x86/include/asm/processor.h                   |   2 +
>   arch/x86/kernel/cpu/amd.c                          |   1 +
>   arch/x86/kernel/cpu/common.c                       |   5 -
>   arch/x86/kernel/vmlinux.lds.S                      |  12 +-
>   arch/x86/kvm/x86.c                                 |   2 -
>   arch/x86/mm/pkeys.c                                |   6 -
>   drivers/android/binder.c                           |   1 +
>   drivers/android/binder_alloc.c                     |   6 +
>   drivers/android/binder_alloc.h                     |   1 +
>   drivers/dma/mcf-edma.c                             |  13 +-
>   drivers/dma/pl330.c                                |  18 ++-
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   |   7 +-
>   drivers/gpu/drm/drm_gem_shmem_helper.c             |   6 +
>   drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +-
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |   1 +
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |   4 +-
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  |  10 ++
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |   1 +
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |   1 +
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |   1 +
>   drivers/hwmon/pmbus/bel-pfe.c                      |  16 +-
>   .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   2 +-
>   drivers/infiniband/hw/hfi1/chip.c                  |   1 +
>   drivers/isdn/mISDN/dsp.h                           |   2 +-
>   drivers/isdn/mISDN/dsp_cmx.c                       |   2 +-
>   drivers/isdn/mISDN/dsp_core.c                      |   2 +-
>   drivers/mmc/host/moxart-mmc.c                      |   8 +-
>   drivers/net/bonding/bond_main.c                    |   4 +-
>   .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  24 ++-
>   drivers/net/ethernet/ibm/ibmvnic.c                 |  38 ++++-
>   drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |   3 +-
>   drivers/net/phy/at803x.c                           |   2 -
>   drivers/net/tun.c                                  |   2 +-
>   drivers/net/wireguard/allowedips.c                 |   8 +-
>   drivers/net/wireguard/selftest/allowedips.c        |  16 +-
>   drivers/nvme/host/rdma.c                           |   3 +-
>   drivers/nvme/host/tcp.c                            |   3 +-
>   drivers/scsi/53c700.c                              |   2 +-
>   drivers/scsi/qedf/qedf_main.c                      |  18 +++
>   drivers/scsi/qedi/qedi_main.c                      |  18 +++
>   drivers/scsi/raid_class.c                          |   1 +
>   drivers/scsi/scsi_proc.c                           |  30 ++--
>   drivers/scsi/snic/snic_disc.c                      |   1 +
>   drivers/scsi/storvsc_drv.c                         |   4 -
>   drivers/usb/common/usb-conn-gpio.c                 |   6 +-
>   drivers/usb/dwc3/gadget.c                          |   9 +-
>   drivers/usb/storage/alauda.c                       |  12 +-
>   fs/btrfs/extent-tree.c                             |   5 +-
>   fs/btrfs/extent_io.c                               |   7 +-
>   fs/nilfs2/inode.c                                  |   8 +
>   fs/nilfs2/segment.c                                |   2 +
>   fs/nilfs2/the_nilfs.h                              |   2 +
>   include/linux/cpu.h                                |   2 +
>   include/net/cfg80211.h                             |   3 +
>   include/net/netfilter/nf_tables.h                  |  31 +++-
>   io_uring/io_uring.c                                |   6 +-
>   kernel/bpf/verifier.c                              | 175 +++++++++++++++++++--
>   net/dccp/output.c                                  |   2 +-
>   net/dccp/proto.c                                   |  10 +-
>   net/ipv4/ip_tunnel_core.c                          |   2 +-
>   net/ipv6/ndisc.c                                   |   3 +-
>   net/netfilter/nf_tables_api.c                      | 175 +++++++++++++--------
>   net/netfilter/nft_flow_offload.c                   |   6 +-
>   net/netfilter/nft_immediate.c                      |   8 +-
>   net/netfilter/nft_objref.c                         |   8 +-
>   net/netfilter/nft_set_hash.c                       |   2 -
>   net/netfilter/nft_set_pipapo.c                     |  18 ++-
>   net/netfilter/nft_set_rbtree.c                     |   2 -
>   net/packet/af_packet.c                             |  16 +-
>   net/sched/sch_netem.c                              |  59 +++----
>   tools/testing/radix-tree/regression1.c             |   2 +-
>   tools/testing/selftests/bpf/prog_tests/align.c     |  36 +++--
>   tools/testing/selftests/bpf/prog_tests/sk_assign.c |  25 ++-
>   tools/testing/selftests/bpf/progs/connect4_prog.c  |   2 +-
>   tools/testing/selftests/bpf/progs/test_sk_assign.c |  11 ++
>   .../selftests/bpf/progs/test_sk_assign_libbpf.c    |   3 +
>   tools/testing/selftests/net/forwarding/ethtool.sh  |   2 +
>   .../net/forwarding/ethtool_extended_state.sh       |   2 +
>   tools/testing/selftests/net/forwarding/lib.sh      |  16 ++
>   tools/testing/selftests/net/forwarding/settings    |   1 +
>   .../testing/selftests/net/forwarding/tc_flower.sh  |   8 +-
>   tools/testing/selftests/rseq/Makefile              |   4 +-
>   tools/testing/selftests/rseq/rseq.c                |   2 +
>   87 files changed, 737 insertions(+), 293 deletions(-)
> 
> 
> .
> 
