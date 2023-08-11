Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916537792C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbjHKPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbjHKPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578D35AA;
        Fri, 11 Aug 2023 08:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFDD4674AE;
        Fri, 11 Aug 2023 15:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE899C433C8;
        Fri, 11 Aug 2023 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691767095;
        bh=FcCbvE0/hRQHS1guQWi9RQnF5+emJ1Lq2+jHwwNveKo=;
        h=From:To:Cc:Subject:Date:From;
        b=luSYJe1Eb5dza2w8NZtPmYoNBznSoTg3Kc08UwypR/q9lfGiXoslIEbwc76qBJ4ip
         K68wWyNDyphWv9RUXkEgfWvLSjvjPiV2hEAyvO2gvZi9ETlbq2YllDNAsXD/RR7rgK
         EmTshwiwOC1W2IOKhf4rXK9/vV0eT5rn2k7tIbUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.126
Date:   Fri, 11 Aug 2023 17:18:10 +0200
Message-ID: <2023081111-unlocking-synopsis-d7d5@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.126 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Alan Stern (1):
      net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Aleksa Sarai (1):
      open: make RESOLVE_CACHED correctly test for O_TMPFILE

Alexander Stein (1):
      drm/imx/ipuv3: Fix front porch adjustment upon hactive aligning

Alexandra Winter (1):
      s390/qeth: Don't call dev_close/dev_open (DOWN/UP)

Aneesh Kumar K.V (1):
      powerpc/mm/altmap: Fix altmap boundary check

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix OOB available bytes for ECC

Benjamin Poirier (1):
      vxlan: Fix nexthop hash size

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Do not leak quotient data after a division by 0

Chengfeng Ye (1):
      mISDN: hfcpci: Fix potential deadlock on &hc->lock

Christophe JAILLET (1):
      mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()

Chunfeng Yun (1):
      PM / wakeirq: support enabling wake-up irq after runtime_suspend called

Dan Carpenter (1):
      net: ll_temac: fix error checking of irq_of_parse_and_map()

Dinh Nguyen (1):
      arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Eric Dumazet (12):
      net: annotate data-races around sk->sk_max_pacing_rate
      net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
      net: add missing READ_ONCE(sk->sk_sndbuf) annotation
      net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
      net: add missing data-race annotations around sk->sk_peek_off
      net: add missing data-race annotation for sk_ll_usec
      tcp_metrics: fix addr_same() helper
      tcp_metrics: annotate data-races around tm->tcpm_stamp
      tcp_metrics: annotate data-races around tm->tcpm_lock
      tcp_metrics: annotate data-races around tm->tcpm_vals[]
      tcp_metrics: annotate data-races around tm->tcpm_net
      tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Georg Müller (1):
      perf test uprobe_from_different_cu: Skip if there is no gcc

Greg Kroah-Hartman (1):
      Linux 5.15.126

Guchun Chen (1):
      drm/ttm: check null pointer before accessing when swapping

Heiko Carstens (1):
      KVM: s390: fix sthyi error handling

Hou Tao (2):
      bpf, cpumap: Handle skb as well when clean up ptr_ring
      bpf, cpumap: Make sure kthread is running before map update returns

Hugo Villeneuve (1):
      arm64: dts: imx8mn-var-som: add missing pull-up for onboard PHY reset pinmux

Ilan Peer (1):
      wifi: cfg80211: Fix return value in scan logic

Ilya Dryomov (2):
      libceph: fix potential hang in ceph_osdc_notify()
      rbd: prevent busy loop when requesting exclusive lock

Jamal Hadi Salim (1):
      net: sched: cls_u32: Fix match key mis-addressing

Jan Kara (2):
      fs: Protect reconfiguration of sb read-write from racing writes
      ext2: Drop fragment support

Jens Axboe (1):
      io_uring: gate iowait schedule on having pending requests

Jianbo Liu (2):
      net/mlx5: fs_core: Make find_closest_ft more generic
      net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio

Jiri Olsa (1):
      bpf: Disable preemption in bpf_event_output

Johan Hovold (2):
      soundwire: fix enumeration completion
      PM: sleep: wakeirq: fix wake irq arming

Johan Jonker (2):
      mtd: rawnand: rockchip: fix oobfree offset and description
      mtd: rawnand: rockchip: Align hwecc vs. raw page helper layouts

Jonas Gorski (1):
      prestera: fix fallback to previous version on same major version

Konstantin Khorenko (1):
      qed: Fix scheduling in a tasklet while getting stats

Krzysztof Kozlowski (1):
      firmware: arm_scmi: Drop OF node reference in the transport channel setup

Kuniyuki Iwashima (1):
      net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.

Laszlo Ersek (2):
      net: tun_chr_open(): set sk_uid from current_fsuid()
      net: tap_open(): set sk_uid from current_fsuid()

Lin Ma (3):
      bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
      rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
      net: dcb: choose correct policy to parse DCB_ATTR_BCN

Linus Torvalds (1):
      file: reinstate f_pos locking optimization for regular files

Mark Brown (1):
      net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode

Michael Jeanson (1):
      selftests/rseq: check if libc rseq support is registered

Michael Kelley (1):
      scsi: storvsc: Limit max_sectors for virtual Fibre Channel devices

Olivier Maignial (1):
      mtd: spinand: toshiba: Fix ecc_get_status

Paul Fertser (1):
      wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

Peter Zijlstra (1):
      perf: Fix function pointer case

Pierre-Louis Bossart (1):
      soundwire: bus: pm_runtime_request_resume on peripheral attachment

Prabhakar Kushwaha (1):
      qed: Fix kernel-doc warnings

Prince Kumar Maurya (1):
      fs/sysv: Null check to prevent null-ptr-deref bug

Robin Murphy (4):
      iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
      iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
      iommu/arm-smmu-v3: Add explicit feature for nesting
      iommu/arm-smmu-v3: Document nesting-related errata

Roger Quadros (1):
      mtd: rawnand: omap_elm: Fix incorrect type in assignment

Ross Maynard (1):
      USB: zaurus: Add ID for A-300/B-500/C-700

Sean Christopherson (1):
      selftests/rseq: Play nice with binaries statically linked against glibc 2.35+

Shay Drory (1):
      net/mlx5: Free irqs only on shutdown callback

Steffen Maier (1):
      scsi: zfcp: Defer fc_rport blocking until after ADISC response

Sungjong Seo (1):
      exfat: release s_lock before calling dir_emit()

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Suzuki K Poulose (2):
      arm64: errata: Add workaround for TSB flush failures
      arm64: errata: Add detection for TRBE write to out-of-range

Tetsuo Handa (1):
      fs/ntfs3: Use __GFP_NOWARN allocation at ntfs_load_attr_list()

Tomas Glozar (1):
      bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire

Xiubo Li (1):
      ceph: defer stopping mdsc delayed_work

Yang Yingliang (1):
      net: ll_temac: Switch to use dev_err_probe() helper

Yuanjun Gong (3):
      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
      net: dsa: fix value check in bcm_sf2_sw_probe()
      net: korina: handle clk prepare error in korina_probe()

Yue Haibing (1):
      ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Zhengchao Shao (1):
      net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx

gaoming (1):
      exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree

ndesaulniers@google.com (1):
      word-at-a-time: use the same return type for has_zero regardless of endianness

valis (3):
      net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

