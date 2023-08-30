Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9078DF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjH3T0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbjH3PKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:10:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A764F1A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:10:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D43FCE1E04;
        Wed, 30 Aug 2023 15:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F441C433C7;
        Wed, 30 Aug 2023 15:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693407761;
        bh=URmCea/eiO32iNZRTt8um7oD275z8YtZ4m+LD4qPK60=;
        h=From:To:Cc:Subject:Date:From;
        b=tph/mqa/Tb+gu2hVqul9yz9HDgBmC9ml4IPsTsTrFmwFbbrj7wlZXG/zJvlEMIqD5
         n0m2fVPog+rpgijWgaX01OhXxqgJSDwZ/qiDtk4ZgTNlSqAY6kP4iVFW3vt4CMNTqT
         dbQfPMh7ZjGtYq5sqb7d2X4ivt2/H4udLGD5EzKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.324
Date:   Wed, 30 Aug 2023 17:02:37 +0200
Message-ID: <2023083037-conceded-candle-b9e8@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.14.324 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                           |    2 
 arch/mips/include/asm/dec/prom.h                   |    2 
 arch/x86/kernel/fpu/xstate.c                       |    8 +
 drivers/android/binder.c                           |    1 
 drivers/android/binder_alloc.c                     |    6 +
 drivers/android/binder_alloc.h                     |    1 
 drivers/dma-buf/sw_sync.c                          |   18 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    3 
 drivers/gpu/drm/radeon/radeon_cs.c                 |    3 
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |    2 
 drivers/media/platform/mtk-vpu/mtk_vpu.c           |    6 -
 drivers/mmc/host/wbsd.c                            |    2 
 drivers/net/ethernet/ibm/ibmveth.c                 |    2 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |   16 +--
 drivers/net/ethernet/intel/igb/igb_ptp.c           |   24 ++--
 drivers/net/phy/broadcom.c                         |   13 ++
 drivers/net/team/team.c                            |    4 
 drivers/pcmcia/rsrc_nonstatic.c                    |    2 
 drivers/scsi/raid_class.c                          |   48 ---------
 drivers/scsi/snic/snic_disc.c                      |    3 
 drivers/tty/serial/8250/8250_port.c                |    1 
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |    4 
 fs/cifs/file.c                                     |    2 
 fs/gfs2/super.c                                    |   26 ++--
 fs/jfs/jfs_dmap.c                                  |    3 
 fs/jfs/jfs_txnmgr.c                                |    5 
 fs/jfs/namei.c                                     |    5 
 fs/quota/dquot.c                                   |    5 
 fs/udf/unicode.c                                   |    2 
 include/linux/raid_class.h                         |    4 
 include/linux/virtio_net.h                         |    4 
 include/media/v4l2-mem2mem.h                       |   18 +++
 include/net/sock.h                                 |   11 +-
 kernel/trace/trace.c                               |    9 +
 kernel/trace/trace_irqsoff.c                       |    3 
 kernel/trace/trace_sched_wakeup.c                  |    2 
 lib/clz_ctz.c                                      |   32 +-----
 lib/mpi/longlong.h                                 |   36 ------
 lib/test_firmware.c                                |   37 +++++-
 net/batman-adv/bat_v_elp.c                         |    3 
 net/batman-adv/bat_v_ogm.c                         |    7 -
 net/batman-adv/hard-interface.c                    |    2 
 net/batman-adv/translation-table.c                 |    1 
 net/bluetooth/l2cap_core.c                         |    5 
 net/core/rtnetlink.c                               |    5 
 net/core/sock.c                                    |    2 
 net/ipv4/ip_vti.c                                  |    4 
 net/ipv4/tcp_timer.c                               |    4 
 net/ipv6/ip6_vti.c                                 |    4 
 net/key/af_key.c                                   |    4 
 net/netfilter/ipvs/ip_vs_ctl.c                     |   74 +++++++------
 net/netfilter/nf_conntrack_proto_sctp.c            |    6 -
 net/netfilter/nft_dynset.c                         |    3 
 net/sctp/socket.c                                  |    2 
 net/unix/af_unix.c                                 |    9 -
 net/xfrm/xfrm_user.c                               |   13 ++
 sound/pci/emu10k1/emufx.c                          |  112 +--------------------
 sound/soc/codecs/rt5665.c                          |    2 
 sound/usb/quirks-table.h                           |   29 +++++
 59 files changed, 320 insertions(+), 346 deletions(-)

Abel Wu (1):
      sock: Fix misuse of sk_under_memory_pressure()

Alessio Igor Bogani (1):
      igb: Avoid starting unnecessary workqueues

Andrii Staikov (1):
      i40e: fix misleading debug logs

Armin Wolf (1):
      pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Eric Dumazet (2):
      net: do not allow gso_size to be set to GSO_BY_FRAGS
      sock: annotate data-races around prot->memory_pressure

Feng Tang (1):
      x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Greg Kroah-Hartman (1):
      Linux 4.14.324

Gustavo A. R. Silva (1):
      MIPS: dec: prom: Address -Warray-bounds warning

Hans Verkuil (1):
      media: platform: mediatek: vpu: fix NULL ptr dereference

Helge Deller (1):
      lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Ido Schimmel (1):
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Immad Mir (2):
      FS: JFS: Fix null-ptr-deref Read in txBegin
      FS: JFS: Check for read-only mounted filesystem in txBegin

Jan Kara (2):
      quota: Properly disable quotas when add_dquot_ref() fails
      udf: Fix uninitialized array access for some pathnames

Jason Xing (1):
      net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled

Junwei Hu (1):
      ipvs: Improve robustness to the ipvs sysctl

Justin Chen (1):
      net: phy: broadcom: stub c45 read/write for 54810

Kuniyuki Iwashima (1):
      af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Lin Ma (4):
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      xfrm: add NULL check in xfrm_update_ae_params
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure

Michael Ellerman (1):
      ibmveth: Use dcbf rather than dcbfl

Mirsad Goran Todorovac (1):
      test_firmware: prevent race conditions by a correct implementation of locking

Nathan Chancellor (1):
      lib/mpi: Eliminate unused umul_ppmm definitions for MIPS

Oswald Buddenhagen (1):
      ALSA: emu10k1: roll up loops in DSP setup code for Audigy

Pablo Neira Ayuso (1):
      netfilter: nft_dynset: disallow object maps

Qi Zheng (1):
      binder: fix memory leak in binder_init()

Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_packet
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Rob Clark (1):
      dma-buf/sw_sync: Avoid recursive lock during fence signal

Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Sven Eckelmann (1):
      batman-adv: Trigger events for auto adjusted MTU

Tony Lindgren (1):
      serial: 8250: Fix oops for port->pm on uart_change_pm()

Tuo Li (1):
      gfs2: Fix possible data races in gfs2_show_options()

Wei Chen (1):
      media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Ye Bin (1):
      quota: fix warning in dqgrab()

Yogesh (1):
      fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Yuanjun Gong (1):
      fbdev: mmp: fix value check in mmphw_probe()

Yunfei Dong (1):
      media: v4l2-mem2mem: add lock to protect parameter num_rdy

Zhang Shurong (1):
      ASoC: rt5665: add missed regulator_bulk_disable

Zheng Yejian (1):
      tracing: Fix memleak due to race between current_tracer and trace

Zhengchao Shao (2):
      ip6_vti: fix slab-use-after-free in decode_session6
      ip_vti: fix potential slab-use-after-free in decode_session6

Zhengping Jiang (1):
      Bluetooth: L2CAP: Fix use-after-free

Zhu Wang (2):
      scsi: snic: Fix double free in snic_tgt_create()
      scsi: core: raid_class: Remove raid_component_add()

Ziyang Xuan (1):
      team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

dengxiang (1):
      ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.

hackyzh002 (1):
      drm/radeon: Fix integer overflow in radeon_cs_parser_init

shanzhulig (1):
      drm/amdgpu: Fix potential fence use-after-free v2

