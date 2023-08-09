Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A076776B12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjHIVjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjHIVjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:39:04 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2AF1BD9;
        Wed,  9 Aug 2023 14:39:02 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63f7bb12050so1659446d6.1;
        Wed, 09 Aug 2023 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691617141; x=1692221941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6dH6n9MxOVSjGb5+D/W6GUD0XITQzq0n+mHfFTIhZs=;
        b=aOgoHostP4YubWTq8leSTj6XdYWcI2S6vG1OQZtfiYGjvsFz4RY1Jzn8HqZaw8O+AH
         R5K6mqBP3jxB0bmZzswPdt1Rv68mybqDwz74TuBMDJiVWHvTb1/LHG13WEKvGa2We7lW
         A2Jle6c5NCJS8eI/J+5ywA/LqdaVil1bUH12Qezd6D8le2n5yGG1VDE4kQxhyELh+0nv
         Cm+2DQzMqBiv+JN8MHwIPHWLo7NlJ4DW/SbzATg1a2XpXIaLhelgdoiJU8vlW+lTxx7O
         /0fP/9GCLQALLmexf0iMBezHlZ4wn9vv5NP7iSuqIolAynW0i+luiG5wFqm9ToH75YIw
         9Naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691617141; x=1692221941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6dH6n9MxOVSjGb5+D/W6GUD0XITQzq0n+mHfFTIhZs=;
        b=a56EDx5HYnyVSevfXWw+/dmXcDkG/d2XtWm4vYtsS0H7xgbvDC98e5xTYKcXi+6Rgf
         cxpkCecTse5h+Pm0PkA/+JO0/t9Txj8S2mJYAVrCqN/YCRoTJKROomJfaEWKlvNha92A
         lF3Fl6pfKKw+OTcxHshnCHTabPnHwRX7HjAK0i0EP5plHPrJp4TH1zU+UaXtX4GSPP4O
         tkUDdiqYvTRUWh1t0bN7JTW+GmaJVSuCb6qnfkFRJNInYt+33Q/Xt2tulUv5jMzq2dS5
         4qkUtnBvp/WJIMNH4xilKDsv5FUJHoDP2+S2yrReQaAxEzLb9xnazEda5NXkx2NWfL7w
         1hwg==
X-Gm-Message-State: AOJu0YzIeOcWIphQDdj5on4kok2rhHl8Mfva7ZoGE5zUfFEW16Lm8TsS
        eY4Cs3mftzVGrMNxT+0I/20=
X-Google-Smtp-Source: AGHT+IG9UWzzlhnjxbhtBYjKf4FDFLP7i31yh2cMtrIKdFXGgjFYafuiv70TDnGHP34sOkCYKhctlQ==
X-Received: by 2002:a0c:e004:0:b0:63c:d6f1:7bcb with SMTP id j4-20020a0ce004000000b0063cd6f17bcbmr464720qvk.41.1691617141109;
        Wed, 09 Aug 2023 14:39:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0cf543000000b00636047c276csm4783023qvm.126.2023.08.09.14.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 14:39:00 -0700 (PDT)
Message-ID: <e91dd60f-cd23-e7ba-0877-824a6672ef16@gmail.com>
Date:   Wed, 9 Aug 2023 14:38:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
References: <20230809103636.615294317@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 03:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.45 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.45-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
>      Linux 6.1.45-rc1
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      Revert "drm/i915: Disable DC states for all commits"
> 
> Lijo Lazar <lijo.lazar@amd.com>
>      drm/amdgpu: Use apt name for FW reserved region
> 
> Luben Tuikov <luben.tuikov@amd.com>
>      drm/amdgpu: Remove unnecessary domain argument
> 
> Tong Liu01 <Tong.Liu01@amd.com>
>      drm/amdgpu: add vram reservation based on vram_usagebyfirmware_v2_2
> 
> Mark Brown <broonie@kernel.org>
>      arm64/ptrace: Don't enable SVE when setting streaming SVE
> 
> Namjae Jeon <linkinjeon@kernel.org>
>      exfat: check if filename entries exceeds max filename length
> 
> Chao Yu <chao@kernel.org>
>      f2fs: don't reset unchangable mount option in f2fs_remount()
> 
> Yangtao Li <frank.li@vivo.com>
>      f2fs: fix to set flush_merge opt and show noflush_merge
> 
> Sean Christopherson <seanjc@google.com>
>      selftests/rseq: Play nice with binaries statically linked against glibc 2.35+
> 
> Peichen Huang <PeiChen.Huang@amd.com>
>      drm/amd/display: skip CLEAR_PAYLOAD_ID_TABLE if device mst_en is 0
> 
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>      drm/amd/display: Ensure that planes are in the same order
> 
> Alexander Stein <alexander.stein@ew.tq-group.com>
>      drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning
> 
> Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>      powerpc/mm/altmap: Fix altmap boundary check
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>      mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()
> 
> Johan Jonker <jbx6244@gmail.com>
>      mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts
> 
> Johan Jonker <jbx6244@gmail.com>
>      mtd: rawnand: rockchip: fix oobfree offset and description
> 
> Roger Quadros <rogerq@kernel.org>
>      mtd: rawnand: omap_elm: Fix incorrect type in assignment
> 
> Pavel Begunkov <asml.silence@gmail.com>
>      io_uring: annotate offset timeout races
> 
> Chao Yu <chao@kernel.org>
>      f2fs: fix to do sanity check on direct node in truncate_dnode()
> 
> Filipe Manana <fdmanana@suse.com>
>      btrfs: remove BUG_ON()'s in add_new_free_space()
> 
> Jan Kara <jack@suse.cz>
>      ext2: Drop fragment support
> 
> Jan Kara <jack@suse.cz>
>      fs: Protect reconfiguration of sb read-write from racing writes
> 
> Alan Stern <stern@rowland.harvard.edu>
>      net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb
> 
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>      debugobjects: Recheck debug_objects_enabled before reporting
> 
> Sungwoo Kim <iam@sung-woo.kim>
>      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb
> 
> Prince Kumar Maurya <princekumarmaurya06@gmail.com>
>      fs/sysv: Null check to prevent null-ptr-deref bug
> 
> Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>      fs/ntfs3: Use __GFP_NOWARN allocation at ntfs_load_attr_list()
> 
> Roman Gushchin <roman.gushchin@linux.dev>
>      mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
> 
> Linus Torvalds <torvalds@linux-foundation.org>
>      file: reinstate f_pos locking optimization for regular files
> 
> Hou Tao <houtao1@huawei.com>
>      bpf, cpumap: Make sure kthread is running before map update returns
> 
> Geert Uytterhoeven <geert+renesas@glider.be>
>      clk: imx93: Propagate correct error in imx93_clocks_probe()
> 
> Andi Shyti <andi.shyti@linux.intel.com>
>      drm/i915/gt: Cleanup aux invalidation registers
> 
> Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
>      drm/i915: Fix premature release of request's reusable memory
> 
> Guchun Chen <guchun.chen@amd.com>
>      drm/ttm: check null pointer before accessing when swapping
> 
> Aleksa Sarai <cyphar@cyphar.com>
>      open: make RESOLVE_CACHED correctly test for O_TMPFILE
> 
> Mark Brown <broonie@kernel.org>
>      arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems
> 
> Mark Brown <broonie@kernel.org>
>      arm64/fpsimd: Clear SME state in the target task when setting the VL
> 
> Mark Brown <broonie@kernel.org>
>      arm64/fpsimd: Sync and zero pad FPSIMD state for streaming SVE
> 
> Naveen N Rao <naveen@kernel.org>
>      powerpc/ftrace: Create a dummy stackframe to fix stack unwind
> 
> Jiri Olsa <jolsa@kernel.org>
>      bpf: Disable preemption in bpf_event_output
> 
> Ilya Dryomov <idryomov@gmail.com>
>      rbd: prevent busy loop when requesting exclusive lock
> 
> Michael Kelley <mikelley@microsoft.com>
>      x86/hyperv: Disable IBT when hypercall page lacks ENDBR instruction
> 
> Paul Fertser <fercerpav@gmail.com>
>      wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)
> 
> Laszlo Ersek <lersek@redhat.com>
>      net: tap_open(): set sk_uid from current_fsuid()
> 
> Laszlo Ersek <lersek@redhat.com>
>      net: tun_chr_open(): set sk_uid from current_fsuid()
> 
> Dinh Nguyen <dinguyen@kernel.org>
>      arm64: dts: stratix10: fix incorrect I2C property for SCL signal
> 
> Jiri Olsa <jolsa@kernel.org>
>      bpf: Disable preemption in bpf_perf_event_output
> 
> Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>      mtd: rawnand: meson: fix OOB available bytes for ECC
> 
> Olivier Maignial <olivier.maignial@hotmail.fr>
>      mtd: spinand: toshiba: Fix ecc_get_status
> 
> Sungjong Seo <sj1557.seo@samsung.com>
>      exfat: release s_lock before calling dir_emit()
> 
> gaoming <gaoming20@hihonor.com>
>      exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>      firmware: arm_scmi: Drop OF node reference in the transport channel setup
> 
> Xiubo Li <xiubli@redhat.com>
>      ceph: defer stopping mdsc delayed_work
> 
> Ross Maynard <bids.7405@bigpond.com>
>      USB: zaurus: Add ID for A-300/B-500/C-700
> 
> Ilya Dryomov <idryomov@gmail.com>
>      libceph: fix potential hang in ceph_osdc_notify()
> 
> Michael Kelley <mikelley@microsoft.com>
>      scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices
> 
> Steffen Maier <maier@linux.ibm.com>
>      scsi: zfcp: Defer fc_rport blocking until after ADISC response
> 
> Boqun Feng <boqun.feng@gmail.com>
>      rust: allocator: Prevent mis-aligned allocation
> 
> Eric Dumazet <edumazet@google.com>
>      tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen
> 
> Eric Dumazet <edumazet@google.com>
>      tcp_metrics: annotate data-races around tm->tcpm_net
> 
> Eric Dumazet <edumazet@google.com>
>      tcp_metrics: annotate data-races around tm->tcpm_vals[]
> 
> Eric Dumazet <edumazet@google.com>
>      tcp_metrics: annotate data-races around tm->tcpm_lock
> 
> Eric Dumazet <edumazet@google.com>
>      tcp_metrics: annotate data-races around tm->tcpm_stamp
> 
> Eric Dumazet <edumazet@google.com>
>      tcp_metrics: fix addr_same() helper
> 
> Jonas Gorski <jonas.gorski@bisdn.de>
>      prestera: fix fallback to previous version on same major version
> 
> Jianbo Liu <jianbol@nvidia.com>
>      net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio
> 
> Jianbo Liu <jianbol@nvidia.com>
>      net/mlx5: fs_core: Make find_closest_ft more generic
> 
> Benjamin Poirier <bpoirier@nvidia.com>
>      vxlan: Fix nexthop hash size
> 
> Yue Haibing <yuehaibing@huawei.com>
>      ip6mr: Fix skb_under_panic in ip6mr_cache_report()
> 
> Alexandra Winter <wintera@linux.ibm.com>
>      s390/qeth: Don't call dev_close/dev_open (DOWN/UP)
> 
> Lin Ma <linma@zju.edu.cn>
>      net: dcb: choose correct policy to parse DCB_ATTR_BCN
> 
> Michael Chan <michael.chan@broadcom.com>
>      bnxt_en: Fix max_mtu setting for multi-buf XDP
> 
> Somnath Kotur <somnath.kotur@broadcom.com>
>      bnxt_en: Fix page pool logic for page size >= 64K
> 
> Mark Brown <broonie@kernel.org>
>      net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>      net: korina: handle clk prepare error in korina_probe()
> 
> Dan Carpenter <dan.carpenter@linaro.org>
>      net: ll_temac: fix error checking of irq_of_parse_and_map()
> 
> Tomas Glozar <tglozar@redhat.com>
>      bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
> 
> valis <sec@valis.email>
>      net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free
> 
> valis <sec@valis.email>
>      net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
> 
> valis <sec@valis.email>
>      net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
> 
> Hou Tao <houtao1@huawei.com>
>      bpf, cpumap: Handle skb as well when clean up ptr_ring
> 
> Rafal Rogalski <rafalx.rogalski@intel.com>
>      ice: Fix RDMA VSI removal during queue rebuild
> 
> Kuniyuki Iwashima <kuniyu@amazon.com>
>      net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
> 
> Eric Dumazet <edumazet@google.com>
>      net: annotate data-races around sk->sk_priority
> 
> Eric Dumazet <edumazet@google.com>
>      net: add missing data-race annotation for sk_ll_usec
> 
> Eric Dumazet <edumazet@google.com>
>      net: add missing data-race annotations around sk->sk_peek_off
> 
> Eric Dumazet <edumazet@google.com>
>      net: annotate data-races around sk->sk_mark
> 
> Eric Dumazet <edumazet@google.com>
>      net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
> 
> Eric Dumazet <edumazet@google.com>
>      net: add missing READ_ONCE(sk->sk_sndbuf) annotation
> 
> Eric Dumazet <edumazet@google.com>
>      net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
> 
> Eric Dumazet <edumazet@google.com>
>      net: annotate data-races around sk->sk_max_pacing_rate
> 
> Eric Dumazet <edumazet@google.com>
>      net: annotate data-race around sk->sk_txrehash
> 
> Eric Dumazet <edumazet@google.com>
>      net: annotate data-races around sk->sk_reserved_mem
> 
> Konstantin Khorenko <khorenko@virtuozzo.com>
>      qed: Fix scheduling in a tasklet while getting stats
> 
> Chengfeng Ye <dg573847474@gmail.com>
>      mISDN: hfcpci: Fix potential deadlock on &hc->lock
> 
> Jamal Hadi Salim <jhs@mojatatu.com>
>      net: sched: cls_u32: Fix match key mis-addressing
> 
> Georg Müller <georgmueller@gmx.net>
>      perf test uprobe_from_different_cu: Skip if there is no gcc
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>      net: dsa: fix value check in bcm_sf2_sw_probe()
> 
> Lin Ma <linma@zju.edu.cn>
>      rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
> 
> Lin Ma <linma@zju.edu.cn>
>      bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
> 
> Jianbo Liu <jianbol@nvidia.com>
>      net/mlx5e: Move representor neigh cleanup to profile cleanup_tx
> 
> Amir Tzin <amirtz@nvidia.com>
>      net/mlx5e: Fix crash moving to switchdev mode when ntuple offload is set
> 
> Yuanjun Gong <ruc_gongyuanjun@163.com>
>      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>      net/mlx5: fix potential memory leak in mlx5e_init_rep_rx
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>      net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
> 
> Zhengchao Shao <shaozhengchao@huawei.com>
>      net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups
> 
> Ilan Peer <ilan.peer@intel.com>
>      wifi: cfg80211: Fix return value in scan logic
> 
> Gao Xiang <xiang@kernel.org>
>      erofs: fix wrong primary bvec selection on deduplicated extents
> 
> Heiko Carstens <hca@linux.ibm.com>
>      KVM: s390: fix sthyi error handling
> 
> ndesaulniers@google.com <ndesaulniers@google.com>
>      word-at-a-time: use the same return type for has_zero regardless of endianness
> 
> Cristian Marussi <cristian.marussi@arm.com>
>      firmware: arm_scmi: Fix chan_free cleanup on SMC
> 
> Yury Norov <yury.norov@gmail.com>
>      lib/bitmap: workaround const_eval test build failure
> 
> Punit Agrawal <punit.agrawal@bytedance.com>
>      firmware: smccc: Fix use of uninitialised results structure
> 
> Benjamin Gaignard <benjamin.gaignard@collabora.com>
>      arm64: dts: freescale: Fix VPU G2 clock
> 
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>      arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY reset pinmux
> 
> Yashwanth Varakala <y.varakala@phytec.de>
>      arm64: dts: phycore-imx8mm: Correction in gpio-line-names
> 
> Yashwanth Varakala <y.varakala@phytec.de>
>      arm64: dts: phycore-imx8mm: Label typo-fix of VPU
> 
> Tim Harvey <tharvey@gateworks.com>
>      arm64: dts: imx8mm-venice-gw7904: disable disp_blk_ctrl
> 
> Tim Harvey <tharvey@gateworks.com>
>      arm64: dts: imx8mm-venice-gw7903: disable disp_blk_ctrl
> 
> Robin Murphy <robin.murphy@arm.com>
>      iommu/arm-smmu-v3: Document nesting-related errata
> 
> Robin Murphy <robin.murphy@arm.com>
>      iommu/arm-smmu-v3: Add explicit feature for nesting
> 
> Robin Murphy <robin.murphy@arm.com>
>      iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
> 
> Robin Murphy <robin.murphy@arm.com>
>      iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
> 
> Alex Elder <elder@linaro.org>
>      net: ipa: only reset hashed tables when supported
> 
> Shay Drory <shayd@nvidia.com>
>      net/mlx5: Free irqs only on shutdown callback
> 
> Peter Zijlstra <peterz@infradead.org>
>      perf: Fix function pointer case
> 
> Jens Axboe <axboe@kernel.dk>
>      io_uring: gate iowait schedule on having pending requests
> 
> 
> -------------
> 
> Diffstat:
> 
>   Documentation/arm64/silicon-errata.rst             |   4 +
>   Makefile                                           |   4 +-
>   .../boot/dts/altera/socfpga_stratix10_socdk.dts    |   2 +-
>   .../dts/altera/socfpga_stratix10_socdk_nand.dts    |   2 +-
>   .../dts/freescale/imx8mm-phyboard-polis-rdk.dts    |   2 +-
>   .../boot/dts/freescale/imx8mm-phycore-som.dtsi     |   4 +-
>   .../boot/dts/freescale/imx8mm-venice-gw7903.dts    |   4 +
>   .../boot/dts/freescale/imx8mm-venice-gw7904.dts    |   4 +
>   arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   2 +-
>   arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   2 +-
>   arch/arm64/kernel/fpsimd.c                         |   9 +-
>   arch/arm64/kernel/ptrace.c                         |   8 +-
>   arch/powerpc/include/asm/word-at-a-time.h          |   2 +-
>   arch/powerpc/kernel/trace/ftrace_mprofile.S        |   9 +-
>   arch/powerpc/mm/init_64.c                          |   3 +-
>   arch/s390/kernel/sthyi.c                           |   6 +-
>   arch/s390/kvm/intercept.c                          |   9 +-
>   arch/x86/hyperv/hv_init.c                          |  21 +++++
>   drivers/block/rbd.c                                |  28 +++---
>   drivers/clk/imx/clk-imx93.c                        |   2 +-
>   drivers/firmware/arm_scmi/mailbox.c                |   4 +-
>   drivers/firmware/arm_scmi/smc.c                    |  21 +++--
>   drivers/firmware/smccc/soc_id.c                    |   5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   | 104 +++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  10 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  89 +++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   1 -
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  15 +++
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   5 +-
>   drivers/gpu/drm/amd/include/atomfirmware.h         |  63 +++++++++++--
>   drivers/gpu/drm/i915/display/intel_display.c       |  28 +-----
>   drivers/gpu/drm/i915/gt/gen8_engine_cs.c           |   8 +-
>   drivers/gpu/drm/i915/gt/intel_gt_regs.h            |  16 ++--
>   drivers/gpu/drm/i915/gt/intel_lrc.c                |   6 +-
>   drivers/gpu/drm/i915/i915_active.c                 |  99 +++++++++++++------
>   drivers/gpu/drm/i915/i915_request.c                |  11 +++
>   drivers/gpu/drm/imx/ipuv3-crtc.c                   |   2 +-
>   drivers/gpu/drm/ttm/ttm_bo.c                       |   3 +-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  50 ++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   8 ++
>   drivers/isdn/hardware/mISDN/hfcpci.c               |  10 +-
>   drivers/mtd/nand/raw/fsl_upm.c                     |   2 +-
>   drivers/mtd/nand/raw/meson_nand.c                  |   3 +-
>   drivers/mtd/nand/raw/omap_elm.c                    |  24 ++---
>   drivers/mtd/nand/raw/rockchip-nand-controller.c    |  45 +++++----
>   drivers/mtd/nand/spi/toshiba.c                     |   4 +-
>   drivers/net/dsa/bcm_sf2.c                          |   8 +-
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  59 +++++++-----
>   drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   6 +-
>   drivers/net/ethernet/intel/ice/ice_main.c          |  18 ++++
>   drivers/net/ethernet/korina.c                      |   3 +-
>   .../net/ethernet/marvell/prestera/prestera_pci.c   |   3 +-
>   .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   4 +-
>   .../mellanox/mlx5/core/en_accel/macsec_fs.c        |   1 +
>   drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  10 ++
>   drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  20 ++--
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   2 +-
>   drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 105 ++++++++++++++++-----
>   drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h |   1 +
>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  29 ++++++
>   .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   5 +-
>   drivers/net/ethernet/qlogic/qed/qed_dev_api.h      |  16 ++++
>   drivers/net/ethernet/qlogic/qed/qed_fcoe.c         |  19 +++-
>   drivers/net/ethernet/qlogic/qed/qed_fcoe.h         |  17 +++-
>   drivers/net/ethernet/qlogic/qed/qed_hw.c           |  26 ++++-
>   drivers/net/ethernet/qlogic/qed/qed_iscsi.c        |  19 +++-
>   drivers/net/ethernet/qlogic/qed/qed_iscsi.h        |   8 +-
>   drivers/net/ethernet/qlogic/qed/qed_l2.c           |  19 +++-
>   drivers/net/ethernet/qlogic/qed/qed_l2.h           |  24 +++++
>   drivers/net/ethernet/qlogic/qed/qed_main.c         |   6 +-
>   drivers/net/ethernet/socionext/netsec.c            |  11 +++
>   drivers/net/ethernet/xilinx/ll_temac_main.c        |  12 ++-
>   drivers/net/ipa/ipa_table.c                        |  26 ++---
>   drivers/net/tap.c                                  |   2 +-
>   drivers/net/tun.c                                  |   2 +-
>   drivers/net/usb/cdc_ether.c                        |  21 +++++
>   drivers/net/usb/usbnet.c                           |   6 ++
>   drivers/net/usb/zaurus.c                           |  21 +++++
>   drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |   6 +-
>   drivers/s390/net/qeth_core.h                       |   1 -
>   drivers/s390/net/qeth_core_main.c                  |   2 -
>   drivers/s390/net/qeth_l2_main.c                    |   9 +-
>   drivers/s390/net/qeth_l3_main.c                    |   8 +-
>   drivers/s390/scsi/zfcp_fc.c                        |   6 +-
>   drivers/scsi/storvsc_drv.c                         |   4 +
>   fs/btrfs/block-group.c                             |  51 ++++++----
>   fs/btrfs/block-group.h                             |   4 +-
>   fs/btrfs/free-space-tree.c                         |  24 +++--
>   fs/ceph/mds_client.c                               |   4 +-
>   fs/ceph/mds_client.h                               |   5 +
>   fs/ceph/super.c                                    |  10 ++
>   fs/erofs/zdata.c                                   |   7 +-
>   fs/exfat/balloc.c                                  |   6 +-
>   fs/exfat/dir.c                                     |  36 +++----
>   fs/ext2/ext2.h                                     |  12 ---
>   fs/ext2/super.c                                    |  23 +----
>   fs/f2fs/f2fs.h                                     |   1 -
>   fs/f2fs/file.c                                     |   5 -
>   fs/f2fs/node.c                                     |  14 ++-
>   fs/f2fs/super.c                                    |  43 ++++++---
>   fs/file.c                                          |  18 +++-
>   fs/ntfs3/attrlist.c                                |   4 +-
>   fs/open.c                                          |   2 +-
>   fs/super.c                                         |  11 ++-
>   fs/sysv/itree.c                                    |   4 +
>   include/asm-generic/word-at-a-time.h               |   2 +-
>   include/linux/f2fs_fs.h                            |   1 +
>   include/net/inet_sock.h                            |   7 +-
>   include/net/ip.h                                   |   2 +-
>   include/net/route.h                                |   4 +-
>   include/net/vxlan.h                                |   4 +-
>   io_uring/io_uring.c                                |  23 +++--
>   io_uring/timeout.c                                 |   2 +-
>   kernel/bpf/cpumap.c                                |  35 ++++---
>   kernel/events/core.c                               |   8 +-
>   kernel/trace/bpf_trace.c                           |  17 +++-
>   lib/Makefile                                       |   6 ++
>   lib/debugobjects.c                                 |   9 ++
>   lib/test_bitmap.c                                  |   8 +-
>   mm/memcontrol.c                                    |  19 ++--
>   net/bluetooth/l2cap_sock.c                         |   2 +
>   net/ceph/osd_client.c                              |  20 ++--
>   net/core/bpf_sk_storage.c                          |   5 +-
>   net/core/rtnetlink.c                               |   8 +-
>   net/core/sock.c                                    |  45 +++++----
>   net/core/sock_map.c                                |   2 -
>   net/dcb/dcbnl.c                                    |   2 +-
>   net/dccp/ipv6.c                                    |   4 +-
>   net/ipv4/inet_diag.c                               |   4 +-
>   net/ipv4/ip_output.c                               |   8 +-
>   net/ipv4/ip_sockglue.c                             |   2 +-
>   net/ipv4/raw.c                                     |   2 +-
>   net/ipv4/route.c                                   |   4 +-
>   net/ipv4/tcp_ipv4.c                                |   4 +-
>   net/ipv4/tcp_metrics.c                             |  70 +++++++++-----
>   net/ipv6/ip6mr.c                                   |   2 +-
>   net/ipv6/ping.c                                    |   2 +-
>   net/ipv6/raw.c                                     |   6 +-
>   net/ipv6/route.c                                   |   7 +-
>   net/ipv6/tcp_ipv6.c                                |   9 +-
>   net/ipv6/udp.c                                     |   4 +-
>   net/l2tp/l2tp_ip6.c                                |   2 +-
>   net/mptcp/sockopt.c                                |   2 +-
>   net/netfilter/nft_socket.c                         |   2 +-
>   net/netfilter/xt_socket.c                          |   4 +-
>   net/packet/af_packet.c                             |  12 +--
>   net/sched/cls_fw.c                                 |   1 -
>   net/sched/cls_route.c                              |   1 -
>   net/sched/cls_u32.c                                |  57 +++++++++--
>   net/sched/sch_taprio.c                             |  15 ++-
>   net/smc/af_smc.c                                   |   2 +-
>   net/unix/af_unix.c                                 |   2 +-
>   net/wireless/scan.c                                |   2 +-
>   net/xdp/xsk.c                                      |   2 +-
>   net/xfrm/xfrm_policy.c                             |   2 +-
>   rust/bindings/bindings_helper.h                    |   1 +
>   rust/kernel/allocator.rs                           |  74 ++++++++++++---
>   .../tests/shell/test_uprobe_from_different_cu.sh   |   8 +-
>   tools/testing/selftests/rseq/rseq.c                |  28 ++++--
>   .../tc-testing/tc-tests/qdiscs/taprio.json         |  25 +++++
>   162 files changed, 1576 insertions(+), 647 deletions(-)
> 
> 

-- 
Florian

