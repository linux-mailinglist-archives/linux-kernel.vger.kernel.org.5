Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CAC7761B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjHINxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjHINx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:53:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794FB0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:53:28 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-790bed44880so279943039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691589207; x=1692194007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tlKt8i553XkK+A6Q0tNCVCazz2IrKRXLY80BdZSCzeM=;
        b=AD2A6LYLsAUXNH6GOCJCYuWhY0kQe1UFIf4HKclg/710rDTwbEmL7Rg3PdlR7z4YFS
         LtOyLx/zWUNV+DG3I2YYdY+v1l0b6fToOVSxdrk3bNrp0BL63oPnRRmT9UD3qngJ0NE+
         J+hH4WYBNLXk4xiydaju361U6k9YXtRu6jqUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589207; x=1692194007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlKt8i553XkK+A6Q0tNCVCazz2IrKRXLY80BdZSCzeM=;
        b=i0k1nRJOrXm/CpP1qoYr9AdE0ei1kcHyKB5xzLBbn7f2zml6O7FU7hGEtl9nkmJWyb
         2hV9LSxrs3ogOmMLY/68THIJFqF+4MIB6HZqTOX389npKAHGhXH3NRsPs592aps+/lQV
         E2s2aL3ECqYhl+kJ20RWVbcQl1Sspkqa2BALia0YqO+0YbxkJxE2pglWkMWTd9Csx7KA
         zbBghEzl8Cx743TgEJXJD6c1/I5yNkf5hBy1JWwAkpJm2/N2NhX0v999/7aPBvVLJO+C
         5vEgqiMv190IEzRHKYOo1Z0g1nS0Vg/8QcQDr93GtQk9a2yj0wyIUENPoqkRALSvY6Sq
         OzyA==
X-Gm-Message-State: AOJu0Yy5ls0deRai/U9rE6sIu5Iv6pjyvgF3UwzDkExAE/bd2q+23mSm
        Bet2Y80M2zHolhuYlWnse6/U2A==
X-Google-Smtp-Source: AGHT+IFo+tafcL6oKvNOhzAmCNNiTJ8EKML3AZbAhADFGe58GAI9ixjhvS4phMH+jZOCkojAGKDFAA==
X-Received: by 2002:a05:6602:42d7:b0:786:cc36:360c with SMTP id ce23-20020a05660242d700b00786cc36360cmr3097426iob.8.1691589207311;
        Wed, 09 Aug 2023 06:53:27 -0700 (PDT)
Received: from localhost (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d8190000000b00783737db8ebsm4396045ion.38.2023.08.09.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:53:26 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:53:26 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Message-ID: <20230809135326.GE3031656@google.com>
References: <20230809103633.485906560@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.126 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.

Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scenarios
hang with this -rc: TREE04, TREE07, TASKS03.

5.15 has a known stop machine issue where it hangs after 1.5 hours with cpu
hotplug rcutorture testing. Me and tglx are continuing to debug this. The
issue does not show up on anything but 5.15 stable kernels and neither on
mainline.

I will do some more runs to see if TASKS03 hang is a new thing but it could
be related to the existing issues.

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
>     Linux 5.15.126-rc1
> 
> Johan Hovold <johan+linaro@kernel.org>
>     PM: sleep: wakeirq: fix wake irq arming
> 
> Chunfeng Yun <chunfeng.yun@mediatek.com>
>     PM / wakeirq: support enabling wake-up irq after runtime_suspend called
> 
> Johan Hovold <johan+linaro@kernel.org>
>     soundwire: fix enumeration completion
> 
> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>     soundwire: bus: pm_runtime_request_resume on peripheral attachment
> 
> Sean Christopherson <seanjc@google.com>
>     selftests/rseq: Play nice with binaries statically linked against glibc 2.35+
> 
> Michael Jeanson <mjeanson@efficios.com>
>     selftests/rseq: check if libc rseq support is registered
> 
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning
> 
> Thomas Zimmermann <tzimmermann@suse.de>
>     drm/fsl-dcu: Use drm_plane_helper_destroy()
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>     powerpc/mm/altmap: Fix altmap boundary check
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()
> 
> Johan Jonker <jbx6244@gmail.com>
>     mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts
> 
> Johan Jonker <jbx6244@gmail.com>
>     mtd: rawnand: rockchip: fix oobfree offset and description
> 
> Roger Quadros <rogerq@kernel.org>
>     mtd: rawnand: omap_elm: Fix incorrect type in assignment
> 
> Jan Kara <jack@suse.cz>
>     ext2: Drop fragment support
> 
> Jan Kara <jack@suse.cz>
>     fs: Protect reconfiguration of sb read-write from racing writes
> 
> Alan Stern <stern@rowland.harvard.edu>
>     net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb
> 
> Sungwoo Kim <iam@sung-woo.kim>
>     Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
> 
> Prince Kumar Maurya <princekumarmaurya06@gmail.com>
>     fs/sysv: Null check to prevent null-ptr-deref bug
> 
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>     fs/ntfs3: Use __GFP_NOWARN allocation at ntfs_load_attr_list()
> 
> Linus Torvalds <torvalds@linux-foundation.org>
>     file: reinstate f_pos locking optimization for regular files
> 
> Hou Tao <houtao1@huawei.com>
>     bpf, cpumap: Make sure kthread is running before map update returns
> 
> Guchun Chen <guchun.chen@amd.com>
>     drm/ttm: check null pointer before accessing when swapping
> 
> Aleksa Sarai <cyphar@cyphar.com>
>     open: make RESOLVE_CACHED correctly test for O_TMPFILE
> 
> Jiri Olsa <jolsa@kernel.org>
>     bpf: Disable preemption in bpf_event_output
> 
> Ilya Dryomov <idryomov@gmail.com>
>     rbd: prevent busy loop when requesting exclusive lock
> 
> Paul Fertser <fercerpav@gmail.com>
>     wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)
> 
> Laszlo Ersek <lersek@redhat.com>
>     net: tap_open(): set sk_uid from current_fsuid()
> 
> Laszlo Ersek <lersek@redhat.com>
>     net: tun_chr_open(): set sk_uid from current_fsuid()
> 
> Dinh Nguyen <dinguyen@kernel.org>
>     arm64: dts: stratix10: fix incorrect I2C property for SCL signal
> 
> Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>     mtd: rawnand: meson: fix OOB available bytes for ECC
> 
> Olivier Maignial <olivier.maignial@hotmail.fr>
>     mtd: spinand: toshiba: Fix ecc_get_status
> 
> Sungjong Seo <sj1557.seo@samsung.com>
>     exfat: release s_lock before calling dir_emit()
> 
> gaoming <gaoming20@hihonor.com>
>     exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     firmware: arm_scmi: Drop OF node reference in the transport channel setup
> 
> Xiubo Li <xiubli@redhat.com>
>     ceph: defer stopping mdsc delayed_work
> 
> Ross Maynard <bids.7405@bigpond.com>
>     USB: zaurus: Add ID for A-300/B-500/C-700
> 
> Ilya Dryomov <idryomov@gmail.com>
>     libceph: fix potential hang in ceph_osdc_notify()
> 
> Michael Kelley <mikelley@microsoft.com>
>     scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices
> 
> Steffen Maier <maier@linux.ibm.com>
>     scsi: zfcp: Defer fc_rport blocking until after ADISC response
> 
> Eric Dumazet <edumazet@google.com>
>     tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen
> 
> Eric Dumazet <edumazet@google.com>
>     tcp_metrics: annotate data-races around tm->tcpm_net
> 
> Eric Dumazet <edumazet@google.com>
>     tcp_metrics: annotate data-races around tm->tcpm_vals[]
> 
> Eric Dumazet <edumazet@google.com>
>     tcp_metrics: annotate data-races around tm->tcpm_lock
> 
> Eric Dumazet <edumazet@google.com>
>     tcp_metrics: annotate data-races around tm->tcpm_stamp
> 
> Eric Dumazet <edumazet@google.com>
>     tcp_metrics: fix addr_same() helper
> 
> Jonas Gorski <jonas.gorski@bisdn.de>
>     prestera: fix fallback to previous version on same major version
> 
> Jianbo Liu <jianbol@nvidia.com>
>     net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio
> 
> Jianbo Liu <jianbol@nvidia.com>
>     net/mlx5: fs_core: Make find_closest_ft more generic
> 
> Benjamin Poirier <bpoirier@nvidia.com>
>     vxlan: Fix nexthop hash size
> 
> Yue Haibing <yuehaibing@huawei.com>
>     ip6mr: Fix skb_under_panic in ip6mr_cache_report()
> 
> Alexandra Winter <wintera@linux.ibm.com>
>     s390/qeth: Don't call dev_close/dev_open (DOWN/UP)
> 
> Lin Ma <linma@zju.edu.cn>
>     net: dcb: choose correct policy to parse DCB_ATTR_BCN
> 
> Mark Brown <broonie@kernel.org>
>     net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>     net: korina: handle clk prepare error in korina_probe()
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>     net: ll_temac: fix error checking of irq_of_parse_and_map()
> 
> Yang Yingliang <yangyingliang@huawei.com>
>     net: ll_temac: Switch to use dev_err_probe() helper
> 
> Tomas Glozar <tglozar@redhat.com>
>     bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
> 
> valis <sec@valis.email>
>     net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free
> 
> valis <sec@valis.email>
>     net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
> 
> valis <sec@valis.email>
>     net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
> 
> Hou Tao <houtao1@huawei.com>
>     bpf, cpumap: Handle skb as well when clean up ptr_ring
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>     net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
> 
> Eric Dumazet <edumazet@google.com>
>     net: add missing data-race annotation for sk_ll_usec
> 
> Eric Dumazet <edumazet@google.com>
>     net: add missing data-race annotations around sk->sk_peek_off
> 
> Eric Dumazet <edumazet@google.com>
>     net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
> 
> Eric Dumazet <edumazet@google.com>
>     net: add missing READ_ONCE(sk->sk_sndbuf) annotation
> 
> Eric Dumazet <edumazet@google.com>
>     net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
> 
> Eric Dumazet <edumazet@google.com>
>     net: annotate data-races around sk->sk_max_pacing_rate
> 
> Konstantin Khorenko <khorenko@virtuozzo.com>
>     qed: Fix scheduling in a tasklet while getting stats
> 
> Prabhakar Kushwaha <pkushwaha@marvell.com>
>     qed: Fix kernel-doc warnings
> 
> Chengfeng Ye <dg573847474@gmail.com>
>     mISDN: hfcpci: Fix potential deadlock on &hc->lock
> 
> Jamal Hadi Salim <jhs@mojatatu.com>
>     net: sched: cls_u32: Fix match key mis-addressing
> 
> Georg Müller <georgmueller@gmx.net>
>     perf test uprobe_from_different_cu: Skip if there is no gcc
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>     net: dsa: fix value check in bcm_sf2_sw_probe()
> 
> Lin Ma <linma@zju.edu.cn>
>     rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
> 
> Lin Ma <linma@zju.edu.cn>
>     bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>     net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>     net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
> 
> Ilan Peer <ilan.peer@intel.com>
>     wifi: cfg80211: Fix return value in scan logic
> 
> Heiko Carstens <hca@linux.ibm.com>
>     KVM: s390: fix sthyi error handling
> 
> ndesaulniers@google.com <ndesaulniers@google.com>
>     word-at-a-time: use the same return type for has_zero regardless of endianness
> 
> Cristian Marussi <cristian.marussi@arm.com>
>     firmware: arm_scmi: Fix chan_free cleanup on SMC
> 
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>     arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY reset pinmux
> 
> Robin Murphy <robin.murphy@arm.com>
>     iommu/arm-smmu-v3: Document nesting-related errata
> 
> Robin Murphy <robin.murphy@arm.com>
>     iommu/arm-smmu-v3: Add explicit feature for nesting
> 
> Robin Murphy <robin.murphy@arm.com>
>     iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
> 
> Robin Murphy <robin.murphy@arm.com>
>     iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
> 
> Suzuki K Poulose <suzuki.poulose@arm.com>
>     arm64: errata: Add detection for TRBE write to out-of-range
> 
> Suzuki K Poulose <suzuki.poulose@arm.com>
>     arm64: errata: Add workaround for TSB flush failures
> 
> Shay Drory <shayd@nvidia.com>
>     net/mlx5: Free irqs only on shutdown callback
> 
> Peter Zijlstra <peterz@infradead.org>
>     perf: Fix function pointer case
> 
> Jens Axboe <axboe@kernel.dk>
>     io_uring: gate iowait schedule on having pending requests
> 
> 
> -------------
> 
> Diffstat:
> 
>  Documentation/arm64/silicon-errata.rst             |  12 +
>  Makefile                                           |   4 +-
>  arch/arm64/Kconfig                                 |  74 ++
>  .../boot/dts/altera/socfpga_stratix10_socdk.dts    |   2 +-
>  .../dts/altera/socfpga_stratix10_socdk_nand.dts    |   2 +-
>  arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   2 +-
>  arch/arm64/include/asm/barrier.h                   |  16 +-
>  arch/arm64/kernel/cpu_errata.c                     |  39 +
>  arch/arm64/tools/cpucaps                           |   2 +
>  arch/powerpc/include/asm/word-at-a-time.h          |   2 +-
>  arch/powerpc/mm/init_64.c                          |   3 +-
>  arch/s390/kernel/sthyi.c                           |   6 +-
>  arch/s390/kvm/intercept.c                          |   9 +-
>  drivers/base/power/power.h                         |   8 +-
>  drivers/base/power/runtime.c                       |   6 +-
>  drivers/base/power/wakeirq.c                       | 111 ++-
>  drivers/block/rbd.c                                |  28 +-
>  drivers/firmware/arm_scmi/mailbox.c                |   4 +-
>  drivers/firmware/arm_scmi/smc.c                    |  21 +-
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |   8 +-
>  drivers/gpu/drm/imx/ipuv3-crtc.c                   |   2 +-
>  drivers/gpu/drm/ttm/ttm_bo.c                       |   3 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  50 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   8 +
>  drivers/isdn/hardware/mISDN/hfcpci.c               |  10 +-
>  drivers/mtd/nand/raw/fsl_upm.c                     |   2 +-
>  drivers/mtd/nand/raw/meson_nand.c                  |   3 +-
>  drivers/mtd/nand/raw/omap_elm.c                    |  24 +-
>  drivers/mtd/nand/raw/rockchip-nand-controller.c    |  45 +-
>  drivers/mtd/nand/spi/toshiba.c                     |   4 +-
>  drivers/net/dsa/bcm_sf2.c                          |   8 +-
>  drivers/net/ethernet/korina.c                      |   3 +-
>  .../net/ethernet/marvell/prestera/prestera_pci.c   |   3 +-
>  .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   4 +-
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 105 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h |   1 +
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  29 +
>  .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   5 +-
>  drivers/net/ethernet/qlogic/qed/qed.h              |   9 +-
>  drivers/net/ethernet/qlogic/qed/qed_cxt.h          | 138 +--
>  drivers/net/ethernet/qlogic/qed/qed_dev_api.h      | 361 ++++----
>  drivers/net/ethernet/qlogic/qed/qed_fcoe.c         |  19 +-
>  drivers/net/ethernet/qlogic/qed/qed_fcoe.h         |  17 +-
>  drivers/net/ethernet/qlogic/qed/qed_hsi.h          | 922 +++++++++++----------
>  drivers/net/ethernet/qlogic/qed/qed_hw.c           |  26 +-
>  drivers/net/ethernet/qlogic/qed/qed_hw.h           | 214 ++---
>  drivers/net/ethernet/qlogic/qed/qed_init_ops.h     |  58 +-
>  drivers/net/ethernet/qlogic/qed/qed_int.h          | 274 +++---
>  drivers/net/ethernet/qlogic/qed/qed_iscsi.c        |  19 +-
>  drivers/net/ethernet/qlogic/qed/qed_iscsi.h        |  17 +-
>  drivers/net/ethernet/qlogic/qed/qed_l2.c           |  19 +-
>  drivers/net/ethernet/qlogic/qed/qed_l2.h           | 158 ++--
>  drivers/net/ethernet/qlogic/qed/qed_ll2.h          | 130 +--
>  drivers/net/ethernet/qlogic/qed/qed_main.c         |   6 +-
>  drivers/net/ethernet/qlogic/qed/qed_mcp.h          | 757 +++++++++--------
>  drivers/net/ethernet/qlogic/qed/qed_selftest.h     |  30 +-
>  drivers/net/ethernet/qlogic/qed/qed_sp.h           | 215 +++--
>  drivers/net/ethernet/qlogic/qed/qed_sriov.h        |  99 ++-
>  drivers/net/ethernet/qlogic/qed/qed_vf.h           | 301 ++++---
>  drivers/net/ethernet/qlogic/qede/qede_main.c       |   5 +-
>  drivers/net/ethernet/socionext/netsec.c            |  11 +
>  drivers/net/ethernet/xilinx/ll_temac_main.c        |  16 +-
>  drivers/net/tap.c                                  |   2 +-
>  drivers/net/tun.c                                  |   2 +-
>  drivers/net/usb/cdc_ether.c                        |  21 +
>  drivers/net/usb/usbnet.c                           |   6 +
>  drivers/net/usb/zaurus.c                           |  21 +
>  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |   6 +-
>  drivers/s390/net/qeth_core.h                       |   1 -
>  drivers/s390/net/qeth_core_main.c                  |   2 -
>  drivers/s390/net/qeth_l2_main.c                    |   9 +-
>  drivers/s390/net/qeth_l3_main.c                    |   8 +-
>  drivers/s390/scsi/zfcp_fc.c                        |   6 +-
>  drivers/scsi/storvsc_drv.c                         |   4 +
>  drivers/soundwire/bus.c                            |  20 +-
>  fs/ceph/mds_client.c                               |   4 +-
>  fs/ceph/mds_client.h                               |   5 +
>  fs/ceph/super.c                                    |  10 +
>  fs/exfat/balloc.c                                  |   6 +-
>  fs/exfat/dir.c                                     |  27 +-
>  fs/ext2/ext2.h                                     |  12 -
>  fs/ext2/super.c                                    |  23 +-
>  fs/file.c                                          |  18 +-
>  fs/ntfs3/attrlist.c                                |   4 +-
>  fs/open.c                                          |   2 +-
>  fs/super.c                                         |  11 +-
>  fs/sysv/itree.c                                    |   4 +
>  include/asm-generic/word-at-a-time.h               |   2 +-
>  include/linux/pm_wakeirq.h                         |   9 +-
>  include/linux/qed/qed_chain.h                      |  97 ++-
>  include/linux/qed/qed_if.h                         | 255 +++---
>  include/linux/qed/qed_iscsi_if.h                   |   2 +-
>  include/linux/qed/qed_ll2_if.h                     |  42 +-
>  include/linux/qed/qed_nvmetcp_if.h                 |  17 +
>  include/net/vxlan.h                                |   4 +-
>  io_uring/io_uring.c                                |  23 +-
>  kernel/bpf/cpumap.c                                |  35 +-
>  kernel/events/core.c                               |   8 +-
>  kernel/trace/bpf_trace.c                           |   6 +-
>  net/bluetooth/l2cap_sock.c                         |   2 +
>  net/ceph/osd_client.c                              |  20 +-
>  net/core/bpf_sk_storage.c                          |   5 +-
>  net/core/rtnetlink.c                               |   8 +-
>  net/core/sock.c                                    |  21 +-
>  net/core/sock_map.c                                |   2 -
>  net/dcb/dcbnl.c                                    |   2 +-
>  net/ipv4/tcp_metrics.c                             |  70 +-
>  net/ipv6/ip6mr.c                                   |   2 +-
>  net/sched/cls_fw.c                                 |   1 -
>  net/sched/cls_route.c                              |   1 -
>  net/sched/cls_u32.c                                |  57 +-
>  net/sched/sch_taprio.c                             |  15 +-
>  net/unix/af_unix.c                                 |   2 +-
>  net/wireless/scan.c                                |   2 +-
>  .../tests/shell/test_uprobe_from_different_cu.sh   |   8 +-
>  tools/testing/selftests/rseq/rseq.c                |  31 +-
>  117 files changed, 3227 insertions(+), 2247 deletions(-)
> 
> 
