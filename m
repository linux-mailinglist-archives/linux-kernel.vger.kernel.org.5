Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8957FF814
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbjK3RVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3RVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:21:40 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F51E6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:21:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cb749044a2so1203776b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701364905; x=1701969705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+1NKp8OKw0P/eE393b072NrkaHsOaU7RRQgiOkDqJU=;
        b=g8Kr0wlcWDXpJUFR4W3YqDeJk3rFqsFJ60ibl8f5wt476iGLJjUv0EqfbMQk6/NWEw
         rlCPz0i17ND0GSLtSk1z3U/jJFZGjsVwWI78z4MwsyFJ7GyWz7lYvNrEt6eJcracshK5
         OTyQTdOhNsyMmdyBDJOVoyTOyagVEtjyD/yzTbEAyPXB59CskwvWTR/LHmkLSSUfWklq
         tV8yoG9Y7w3Mhmeyvsk/oxLX6JWTC63TTbl4ZHwPWiHsG/3InvYb0hz3OGuZZji4hrNt
         IE67p1pSGqjoROIYNZ8m8sEDeODf14Kgd9lk0VNWygGxprVOp7lcJHjwyyHFQkx1zETd
         5CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364905; x=1701969705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+1NKp8OKw0P/eE393b072NrkaHsOaU7RRQgiOkDqJU=;
        b=eG6nFKSvVfLp99FmHidVGKU3cSOqc5Cg9K/8EeYiVxj2rX+zGaWW86fh6jNyYR+A3T
         rHSSo4R5TxetCqVtzEpNxx4ElxjIbKNycFxD6QnSZno5SYe7sn0e/u4NoH8xS95UOOHi
         vxd8Wn7Urmr7Gr0eyIUPf5RtMj7iMvPCXcDwK+Znl8DKM5QncBafuvj+mxeXI32V3qCa
         1WQ+JC00of9fjzl16z2M9It2yo0orFeLzcFlCTHu7j9uqFkoMJCzMBQlRvOqK9NWbv04
         Tko1OqugXS0iWqTygBC7TWFSXDZHLvG8km1EX7X5a6h3NPBH6ZQy7PmGgBopJkvTpMyU
         UEGw==
X-Gm-Message-State: AOJu0YwYd8bgMoYK7pO71agWpWdAUaOdGXNm2zWg/2bA5U2AzEDCs/8R
        5aqYvBaHPBtWbCfjar6JVLTZikAnFAhemq8vzj2Wiw==
X-Google-Smtp-Source: AGHT+IFG73GreE7X7IFciPqn7XMItr6fyqJiIVhevq5xHQacVAUnnKVb0qJxgsjCwPHIQwtqXIodji1vcuJ5iPNamPE=
X-Received: by 2002:a05:6a00:244a:b0:6cb:a2f7:83d with SMTP id
 d10-20020a056a00244a00b006cba2f7083dmr25774630pfj.19.1701364905208; Thu, 30
 Nov 2023 09:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20231130162133.035359406@linuxfoundation.org>
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 30 Nov 2023 11:21:34 -0600
Message-ID: <CAEUSe7-yhmQkr1iK-82+Sc_YpVtWUQhuKoazoXHF_3oP9XTt4Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
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

Lots of failures everywhere:
* clang-17-lkftconfig                 arm64
* clang-17-lkftconfig                 arm64
* clang-17-lkftconfig                 arm64
* clang-lkftconfig                    arm64
* clang-lkftconfig                    arm
* clang-lkftconfig                    i386
* clang-lkftconfig                    x86_64
* gcc-12-lkftconfig                   arm64
* gcc-12-lkftconfig                   arm
* gcc-12-lkftconfig                   i386
* gcc-12-lkftconfig                   x86_64
* gcc-12-lkftconfig-64k_page_size     arm64
* gcc-12-lkftconfig-64k_page_size     arm64
* gcc-12-lkftconfig-armv8_features    arm64
* gcc-12-lkftconfig-debug             arm64
* gcc-12-lkftconfig-debug             arm64
* gcc-12-lkftconfig-debug             arm
* gcc-12-lkftconfig-debug             i386
* gcc-12-lkftconfig-debug             x86_64
* gcc-12-lkftconfig-debug-kmemleak    arm64
* gcc-12-lkftconfig-debug-kmemleak    arm
* gcc-12-lkftconfig-debug-kmemleak    i386
* gcc-12-lkftconfig-debug-kmemleak    x86_64
* gcc-12-lkftconfig-devicetree        arm64
* gcc-12-lkftconfig-kasan             arm64
* gcc-12-lkftconfig-kasan             arm64
* gcc-12-lkftconfig-kasan             x86_64
* gcc-12-lkftconfig-kselftest         arm64
* gcc-12-lkftconfig-kselftest-kernel  arm64
* gcc-12-lkftconfig-kselftest-kernel  arm
* gcc-12-lkftconfig-kselftest-kernel  i386
* gcc-12-lkftconfig-kunit             arm64
* gcc-12-lkftconfig-kunit             arm64
* gcc-12-lkftconfig-kunit             arm
* gcc-12-lkftconfig-kunit             i386
* gcc-12-lkftconfig-kunit             x86_64
* gcc-12-lkftconfig-libgpiod          arm64
* gcc-12-lkftconfig-libgpiod          arm
* gcc-12-lkftconfig-libgpiod          i386
* gcc-12-lkftconfig-libgpiod          x86_64
* gcc-12-lkftconfig-perf              arm64
* gcc-12-lkftconfig-perf-kernel       arm64
* gcc-12-lkftconfig-perf-kernel       arm
* gcc-12-lkftconfig-perf-kernel       i386
* gcc-12-lkftconfig-perf-kernel       x86_64
* gcc-12-lkftconfig-rcutorture        arm64
* gcc-12-lkftconfig-rcutorture        arm64
* gcc-12-lkftconfig-rcutorture        arm
* gcc-12-lkftconfig-rcutorture        i386
* gcc-12-lkftconfig-rcutorture        x86_64

It's essentially this:

-----8<-----
  make --silent --keep-going --jobs=3D8
O=3D/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=3Dx86_64 SRCARCH=3Dx8=
6
CROSS_COMPILE=3Dx86_64-linux-gnu- 'CC=3Dsccache x86_64-linux-gnu-gcc'
'HOSTCC=3Dsccache gcc'
  arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x51:
unreachable instruction
  x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
`__trace_kprobe_create':
  trace_kprobe.c:(.text+0x2f39): undefined reference to
`kallsyms_on_each_symbol'
  x86_64-linux-gnu-ld: kernel/trace/trace_kprobe.o: in function
`create_local_trace_kprobe':
  trace_kprobe.c:(.text+0x384b): undefined reference to
`kallsyms_on_each_symbol'
  make[1]: *** [/builds/linux/Makefile:1227: vmlinux] Error 1
  make[1]: Target '__all' not remade because of errors.
  make: *** [Makefile:226: __sub-make] Error 2
  make: Target '__all' not remade because of errors.
----->8-----

It only affects 5.15. Bisection in progress.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org



On Thu, 30 Nov 2023 at 10:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.141-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
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
>     Linux 5.15.141-rc1
>
> Keith Busch <kbusch@kernel.org>
>     io_uring: fix off-by one bvec index
>
> Johan Hovold <johan+linaro@kernel.org>
>     USB: dwc3: qcom: fix wakeup after probe deferral
>
> Johan Hovold <johan+linaro@kernel.org>
>     USB: dwc3: qcom: fix software node leak on probe errors
>
> Ricardo Ribalda <ribalda@chromium.org>
>     usb: dwc3: set the dma max_seg_size
>
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     usb: dwc3: Fix default mode initialization
>
> Oliver Neukum <oneukum@suse.com>
>     USB: dwc2: write HCINT with INTMASK applied
>
> Badhri Jagan Sridharan <badhri@google.com>
>     usb: typec: tcpm: Skip hard reset when in error recovery
>
> Lech Perczak <lech.perczak@gmail.com>
>     USB: serial: option: don't claim interface 4 for ZTE MF290
>
> Puliang Lu <puliang.lu@fibocom.com>
>     USB: serial: option: fix FM101R-GL defines
>
> Victor Fragoso <victorffs@hotmail.com>
>     USB: serial: option: add Fibocom L7xx modules
>
> Pawel Laszczak <pawell@cadence.com>
>     usb: cdnsp: Fix deadlock issue during using NCM gadget
>
> Mingzhe Zou <mingzhe.zou@easystack.cn>
>     bcache: fixup lock c->root error
>
> Mingzhe Zou <mingzhe.zou@easystack.cn>
>     bcache: fixup init dirty data errors
>
> Rand Deeb <rand.sec96@gmail.com>
>     bcache: prevent potential division by zero error
>
> Coly Li <colyli@suse.de>
>     bcache: check return value from btree_node_alloc_replacement()
>
> Mikulas Patocka <mpatocka@redhat.com>
>     dm-delay: fix a race between delay_presuspend and delay_bio
>
> Long Li <longli@microsoft.com>
>     hv_netvsc: Mark VF as slave before exposing it to user-mode
>
> Haiyang Zhang <haiyangz@microsoft.com>
>     hv_netvsc: Fix race of register_netdevice_notifier and VF register
>
> Asuna Yang <spriteovo@gmail.com>
>     USB: serial: option: add Luat Air72*U series products
>
> Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>     s390/dasd: protect device queue against concurrent access
>
> Charles Mirabile <cmirabil@redhat.com>
>     io_uring/fs: consider link->flags when getting path for LINKAT
>
> Mingzhe Zou <mingzhe.zou@easystack.cn>
>     bcache: fixup multi-threaded bch_sectors_dirty_init() wake-up race
>
> Song Liu <song@kernel.org>
>     md: fix bi_status reporting in md_end_clone_io
>
> Coly Li <colyli@suse.de>
>     bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_c=
oalesce()
>
> Keith Busch <kbusch@kernel.org>
>     swiotlb-xen: provide the "max_mapping_size" method
>
> Hans de Goede <hdegoede@redhat.com>
>     ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA
>
> Krister Johansen <kjlx@templeofstupid.com>
>     proc: sysctl: prevent aliased sysctls from getting passed to init
>
> Francis Laniel <flaniel@linux.microsoft.com>
>     tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbo=
ls
>
> Zhang Yi <yi.zhang@huawei.com>
>     ext4: make sure allocate pending entry not fail
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: fix slab-use-after-free in ext4_es_insert_extent()
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: using nofail preallocation in ext4_es_insert_extent()
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: using nofail preallocation in ext4_es_insert_delayed_block()
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: using nofail preallocation in ext4_es_remove_extent()
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: use pre-allocated es in __es_remove_extent()
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: use pre-allocated es in __es_insert_extent()
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: factor out __es_alloc_extent() and __es_free_extent()
>
> Baokun Li <libaokun1@huawei.com>
>     ext4: add a new helper to check if es must be kept
>
> Andrey Konovalov <andrey.konovalov@linaro.org>
>     media: qcom: camss: Fix csid-gen2 for test pattern generator
>
> Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>     media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater t=
han 3
>
> Milen Mitkov <quic_mmitkov@quicinc.com>
>     media: camss: sm8250: Virtual channels for CSID
>
> Souptick Joarder (HPE) <jrdr.linux@gmail.com>
>     media: camss: Replace hard coded value with parameter
>
> Huacai Chen <chenhuacai@kernel.org>
>     MIPS: KVM: Fix a build warning about variable set but not used
>
> Peter Zijlstra <peterz@infradead.org>
>     lockdep: Fix block chain corruption
>
> Johan Hovold <johan+linaro@kernel.org>
>     USB: dwc3: qcom: fix ACPI platform device leak
>
> Johan Hovold <johan+linaro@kernel.org>
>     USB: dwc3: qcom: fix resource leaks on probe deferral
>
> Christoph Hellwig <hch@lst.de>
>     nvmet: nul-terminate the NQNs passed in the connect command
>
> David Howells <dhowells@redhat.com>
>     afs: Fix file locking on R/O volumes to operate in local mode
>
> David Howells <dhowells@redhat.com>
>     afs: Return ENOENT if no cell DNS record can be found
>
> Samuel Holland <samuel.holland@sifive.com>
>     net: axienet: Fix check for partial TX checksum
>
> Raju Rangoju <Raju.Rangoju@amd.com>
>     amd-xgbe: propagate the correct speed and duplex status
>
> Raju Rangoju <Raju.Rangoju@amd.com>
>     amd-xgbe: handle the corner-case during tx completion
>
> Raju Rangoju <Raju.Rangoju@amd.com>
>     amd-xgbe: handle corner-case during sfp hotplug
>
> Suman Ghosh <sumang@marvell.com>
>     octeontx2-pf: Fix ntuple rule creation to direct packet to VF with hi=
gher Rx queue than its PF
>
> Stefano Stabellini <sstabellini@kernel.org>
>     arm/xen: fix xen_vcpu_info allocation alignment
>
> D. Wythe <alibuda@linux.alibaba.com>
>     net/smc: avoid data corruption caused by decline
>
> Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
>     net: usb: ax88179_178a: fix failed operations during ax88179_reset
>
> Kunwu Chan <chentao@kylinos.cn>
>     ipv4: Correct/silence an endian warning in __ip_do_redirect
>
> Charles Yi <be286@163.com>
>     HID: fix HID device resource race between HID core and debugging supp=
ort
>
> Benjamin Tissoires <benjamin.tissoires@redhat.com>
>     HID: core: store the unique system identifier in hid_device
>
> Jonas Karlman <jonas@kwiboo.se>
>     drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full
>
> Chen Ni <nichen@iscas.ac.cn>
>     ata: pata_isapnp: Add missing error check for devm_ioport_map()
>
> Suman Ghosh <sumang@marvell.com>
>     octeontx2-pf: Fix memory leak during interface down
>
> Eric Dumazet <edumazet@google.com>
>     wireguard: use DEV_STATS_INC()
>
> Marek Vasut <marex@denx.de>
>     drm/panel: simple: Fix Innolux G101ICE-L01 timings
>
> Marek Vasut <marex@denx.de>
>     drm/panel: simple: Fix Innolux G101ICE-L01 bus flags
>
> Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
>     drm/panel: auo,b101uan08.3: Fine tune the panel power sequence
>
> Shuijing Li <shuijing.li@mediatek.com>
>     drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence
>
> David Howells <dhowells@redhat.com>
>     afs: Make error on cell lookup failure consistent with OpenAFS
>
> David Howells <dhowells@redhat.com>
>     afs: Fix afs_server_list to be cleaned up with RCU
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                           |   4 +-
>  arch/arm/xen/enlighten.c                           |   3 +-
>  arch/mips/kvm/mmu.c                                |   3 +-
>  drivers/acpi/resource.c                            |   7 +
>  drivers/ata/pata_isapnp.c                          |   3 +
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c     |   7 +
>  drivers/gpu/drm/panel/panel-simple.c               |  13 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  14 +-
>  drivers/hid/hid-core.c                             |  16 +-
>  drivers/hid/hid-debug.c                            |   3 +
>  drivers/md/bcache/btree.c                          |   4 +-
>  drivers/md/bcache/sysfs.c                          |   2 +-
>  drivers/md/bcache/writeback.c                      |  22 +-
>  drivers/md/dm-delay.c                              |  17 +-
>  drivers/md/md.c                                    |   3 +-
>  drivers/media/platform/qcom/camss/camss-csid-170.c |  65 +++--
>  drivers/media/platform/qcom/camss/camss-csid.c     |  44 ++-
>  drivers/media/platform/qcom/camss/camss-csid.h     |  11 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  14 +
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |  11 +-
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  14 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  20 +-
>  .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   2 +-
>  drivers/net/hyperv/netvsc_drv.c                    |  41 ++-
>  drivers/net/usb/ax88179_178a.c                     |   4 +-
>  drivers/net/wireguard/device.c                     |   4 +-
>  drivers/net/wireguard/receive.c                    |  12 +-
>  drivers/net/wireguard/send.c                       |   3 +-
>  drivers/nvme/target/fabrics-cmd.c                  |   4 +
>  drivers/s390/block/dasd.c                          |  24 +-
>  drivers/usb/cdns3/cdnsp-ring.c                     |   3 +
>  drivers/usb/dwc2/hcd_intr.c                        |  15 +-
>  drivers/usb/dwc3/core.c                            |   2 +
>  drivers/usb/dwc3/drd.c                             |   2 +-
>  drivers/usb/dwc3/dwc3-qcom.c                       |  65 +++--
>  drivers/usb/serial/option.c                        |  11 +-
>  drivers/usb/typec/tcpm/tcpm.c                      |   9 +
>  drivers/xen/swiotlb-xen.c                          |   1 +
>  fs/afs/dynroot.c                                   |   4 +-
>  fs/afs/internal.h                                  |   1 +
>  fs/afs/server_list.c                               |   2 +-
>  fs/afs/super.c                                     |   2 +
>  fs/afs/vl_rotate.c                                 |  10 +
>  fs/ext4/extents_status.c                           | 306 +++++++++++++++=
------
>  fs/proc/proc_sysctl.c                              |   7 +
>  include/linux/hid.h                                |   5 +
>  include/linux/sysctl.h                             |   6 +
>  init/main.c                                        |   4 +
>  io_uring/io_uring.c                                |   4 +-
>  kernel/locking/lockdep.c                           |   3 +-
>  kernel/trace/trace_kprobe.c                        |  74 +++++
>  kernel/trace/trace_probe.h                         |   1 +
>  net/ipv4/route.c                                   |   2 +-
>  net/smc/af_smc.c                                   |   8 +-
>  55 files changed, 704 insertions(+), 239 deletions(-)
>
>
>
