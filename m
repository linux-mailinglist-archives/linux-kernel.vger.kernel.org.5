Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17D677D819
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbjHPCFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjHPCF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:05:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790DD2121;
        Tue, 15 Aug 2023 19:05:26 -0700 (PDT)
Received: from dggpeml500006.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQWc30TPVzFqYL;
        Wed, 16 Aug 2023 10:02:27 +0800 (CST)
Received: from [10.174.176.127] (10.174.176.127) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 10:05:22 +0800
Subject: Re: [PATCH 4.19 00/33] 4.19.292-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
References: <20230813211703.915807095@linuxfoundation.org>
From:   luomeng <luomeng12@huawei.com>
Message-ID: <67f18995-78c6-d53c-1bc5-e30da7018bc6@huawei.com>
Date:   Wed, 16 Aug 2023 10:05:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on arm64 and x86 for 4.19.292-rc1,

Kernel 
repo:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
Branch: linux-4.19.y
Version: 4.19.292-rc1
Commit: 84b9d8b93009a14264e351f2ae6dd63d95dd6ceb
Compiler: gcc version 7.3.0 (GCC))

arm64:
--------------------------------------------------------------------
Testcase Result Summary:
total: 8901
passed: 8901
failed: 0
timeout: 0
--------------------------------------------------------------------

x86:
--------------------------------------------------------------------
Testcase Result Summary:
total: 8901
passed: 8901
failed: 0
timeout: 0
--------------------------------------------------------------------
Tested-by: Hulk Robot <hulkrobot@huawei.com>

在 2023/8/14 5:18, Greg Kroah-Hartman 写道:
> This is the start of the stable review cycle for the 4.19.292 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.292-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
>      Linux 4.19.292-rc1
> 
> Eric Dumazet <edumazet@google.com>
>      sch_netem: fix issues in netem_change() vs get_dist_table()
> 
> Masahiro Yamada <masahiroy@kernel.org>
>      alpha: remove __init annotation from exported page_is_ram()
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
> Pablo Neira Ayuso <pablo@netfilter.org>
>      netfilter: nf_tables: bogus EBUSY when deleting flowtable after flush
> 
> Christoph Hellwig <hch@lst.de>
>      btrfs: don't stop integrity writeback too early
> 
> Nick Child <nnac123@linux.ibm.com>
>      ibmvnic: Handle DMA unmapping of login buffs in release functions
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
> Eric Dumazet <edumazet@google.com>
>      net/packet: annotate data-races around tp->status
> 
> Nathan Chancellor <nathan@kernel.org>
>      mISDN: Update parameter type of dsp_cmx_send()
> 
> Karol Herbst <kherbst@redhat.com>
>      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes
> 
> Arnd Bergmann <arnd@arndb.de>
>      x86: Move gds_ucode_mitigated() declaration to header
> 
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines
> 
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>      x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405
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
> Ryusuke Konishi <konishi.ryusuke@gmail.com>
>      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput
> 
> Colin Ian King <colin.i.king@gmail.com>
>      radix tree test suite: fix incorrect allocation size for pthreads
> 
> Karol Herbst <kherbst@redhat.com>
>      drm/nouveau/gr: enable memory loads on helper invocation on all channels
> 
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>      dmaengine: pl330: Return DMA_PAUSED when transaction is paused
> 
> Maciej Żenczykowski <maze@google.com>
>      ipv6: adjust ndisc_is_useropt() to also return true for PIO
> 
> Sergei Antonov <saproj@gmail.com>
>      mmc: moxart: read scr register without changing byte order
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      sparc: fix up arch_cpu_finalize_init() build breakage.
> 
> 
> -------------
> 
> Diffstat:
> 
>   Makefile                                           |   4 +-
>   arch/alpha/kernel/setup.c                          |   3 +-
>   arch/sparc/Kconfig                                 |   2 +-
>   arch/x86/entry/vdso/vma.c                          |   4 +-
>   arch/x86/include/asm/processor.h                   |   2 +
>   arch/x86/kernel/cpu/amd.c                          |   1 +
>   arch/x86/kvm/x86.c                                 |   2 -
>   drivers/android/binder.c                           |   1 +
>   drivers/android/binder_alloc.c                     |   6 +
>   drivers/android/binder_alloc.h                     |   1 +
>   drivers/dma/pl330.c                                |  18 ++-
>   drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +-
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |   1 +
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |   4 +-
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  |  10 ++
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |   1 +
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |   1 +
>   drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |   1 +
>   .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   2 +-
>   drivers/infiniband/hw/hfi1/chip.c                  |   1 +
>   drivers/isdn/mISDN/dsp.h                           |   2 +-
>   drivers/isdn/mISDN/dsp_cmx.c                       |   2 +-
>   drivers/isdn/mISDN/dsp_core.c                      |   2 +-
>   drivers/mmc/host/moxart-mmc.c                      |   8 +-
>   drivers/net/bonding/bond_main.c                    |   4 +-
>   drivers/net/ethernet/ibm/ibmvnic.c                 |  15 +-
>   drivers/net/tun.c                                  |   2 +-
>   drivers/scsi/53c700.c                              |   2 +-
>   drivers/scsi/raid_class.c                          |   1 +
>   drivers/scsi/scsi_proc.c                           |  30 ++--
>   drivers/scsi/snic/snic_disc.c                      |   1 +
>   drivers/scsi/storvsc_drv.c                         |   4 -
>   drivers/usb/dwc3/gadget.c                          |   9 +-
>   drivers/usb/storage/alauda.c                       |   9 +-
>   fs/btrfs/extent_io.c                               |   7 +-
>   fs/nilfs2/inode.c                                  |   8 +
>   fs/nilfs2/segment.c                                |   2 +
>   fs/nilfs2/the_nilfs.h                              |   2 +
>   include/net/cfg80211.h                             |   3 +
>   include/net/netfilter/nf_tables.h                  |  35 +++-
>   net/dccp/output.c                                  |   2 +-
>   net/dccp/proto.c                                   |  10 +-
>   net/ipv6/ndisc.c                                   |   3 +-
>   net/netfilter/nf_tables_api.c                      | 180 ++++++++++++++-------
>   net/netfilter/nft_flow_offload.c                   |  23 ++-
>   net/netfilter/nft_objref.c                         |   8 +-
>   net/packet/af_packet.c                             |  16 +-
>   net/sched/sch_netem.c                              |  59 +++----
>   tools/testing/radix-tree/regression1.c             |   2 +-
>   49 files changed, 349 insertions(+), 169 deletions(-)
> 
> 
> .
> 
