Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABD78A9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjH1KPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjH1KPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789AA95;
        Mon, 28 Aug 2023 03:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F29636A6;
        Mon, 28 Aug 2023 10:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73EBC433C8;
        Mon, 28 Aug 2023 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217720;
        bh=mrCslVnCuzWQ/BrD/ATgtN4osat06hxrkzjbt7XNgcE=;
        h=From:To:Cc:Subject:Date:From;
        b=Czf7kZp1ZcTWrbf9LATaovv9dtm8DCfiOA3dztLB+EjDoDaOW8V13lLcokSB7nzvr
         h72QAmcsHg4yT2TV1PAFYhor1mMlVDtCl3jzsIik6y2sftW1tgFQa2QCUpsXnneUvf
         x13KIIYtM2DcqjKt5D8hSmJVbUT9AuhqLRKg/ad4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 4.14 00/57] 4.14.324-rc1 review
Date:   Mon, 28 Aug 2023 12:12:20 +0200
Message-ID: <20230828101144.231099710@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.324-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.324-rc1
X-KernelTest-Deadline: 2023-08-30T10:11+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.324 release.
There are 57 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.324-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.324-rc1

Rob Clark <robdclark@chromium.org>
    dma-buf/sw_sync: Avoid recursive lock during fence signal

Zhu Wang <wangzhu9@huawei.com>
    scsi: core: raid_class: Remove raid_component_add()

Zhu Wang <wangzhu9@huawei.com>
    scsi: snic: Fix double free in snic_tgt_create()

Ido Schimmel <idosch@nvidia.com>
    rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Feng Tang <feng.tang@intel.com>
    x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR4

Wei Chen <harperchen1110@gmail.com>
    media: vcodec: Fix potential array out-of-bounds in encoder queue_setup

Helge Deller <deller@gmx.de>
    lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Fix TT global entry leak when client roamed back

Remi Pommarel <repk@triplefau.lt>
    batman-adv: Do not get eth header before batadv_check_management_packet

Sven Eckelmann <sven@narfation.org>
    batman-adv: Trigger events for auto adjusted MTU

Michael Ellerman <mpe@ellerman.id.au>
    ibmveth: Use dcbf rather than dcbfl

Sishuai Gong <sishuai.system@gmail.com>
    ipvs: fix racy memcpy in proc_do_sync_threshold

Junwei Hu <hujunwei4@huawei.com>
    ipvs: Improve robustness to the ipvs sysctl

Alessio Igor Bogani <alessio.bogani@elettra.eu>
    igb: Avoid starting unnecessary workqueues

Eric Dumazet <edumazet@google.com>
    sock: annotate data-races around prot->memory_pressure

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix memleak due to race between current_tracer and trace

Justin Chen <justin.chen@broadcom.com>
    net: phy: broadcom: stub c45 read/write for 54810

Lin Ma <linma@zju.edu.cn>
    net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure

Jason Xing <kernelxing@tencent.com>
    net: fix the RTO timer retransmitting skb every 1ms if linear option is enabled

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Fix null-ptr-deref in unix_stream_sendpage().

Zhang Shurong <zhang_shurong@foxmail.com>
    ASoC: rt5665: add missed regulator_bulk_disable

Xin Long <lucien.xin@gmail.com>
    netfilter: set default timeout to 3 secs for sctp shutdown send and recv state

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: prevent race conditions by a correct implementation of locking

Qi Zheng <zhengqi.arch@bytedance.com>
    binder: fix memory leak in binder_init()

Tony Lindgren <tony@atomide.com>
    serial: 8250: Fix oops for port->pm on uart_change_pm()

Yang Yingliang <yangyingliang@huawei.com>
    mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Russell Harmon via samba-technical <samba-technical@lists.samba.org>
    cifs: Release folio lock on fscache read hit.

dengxiang <dengxiang@nfschina.com>
    ALSA: usb-audio: Add support for Mythware XA001AU capture and playback interfaces.

Eric Dumazet <edumazet@google.com>
    net: do not allow gso_size to be set to GSO_BY_FRAGS

Abel Wu <wuyun.abel@bytedance.com>
    sock: Fix misuse of sk_under_memory_pressure()

Andrii Staikov <andrii.staikov@intel.com>
    i40e: fix misleading debug logs

Ziyang Xuan <william.xuanziyang@huawei.com>
    team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_dynset: disallow object maps

Lin Ma <linma@zju.edu.cn>
    xfrm: add NULL check in xfrm_update_ae_params

Zhengchao Shao <shaozhengchao@huawei.com>
    ip_vti: fix potential slab-use-after-free in decode_session6

Zhengchao Shao <shaozhengchao@huawei.com>
    ip6_vti: fix slab-use-after-free in decode_session6

Lin Ma <linma@zju.edu.cn>
    net: af_key: fix sadb_x_filter validation

Lin Ma <linma@zju.edu.cn>
    net: xfrm: Fix xfrm_address_filter OOB read

Nathan Lynch <nathanl@linux.ibm.com>
    powerpc/rtas_flash: allow user copy to flash block cache objects

Yuanjun Gong <ruc_gongyuanjun@163.com>
    fbdev: mmp: fix value check in mmphw_probe()

shanzhulig <shanzhulig@gmail.com>
    drm/amdgpu: Fix potential fence use-after-free v2

Zhengping Jiang <jiangzp@google.com>
    Bluetooth: L2CAP: Fix use-after-free

Armin Wolf <W_Armin@gmx.de>
    pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()

Tuo Li <islituo@gmail.com>
    gfs2: Fix possible data races in gfs2_show_options()

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: platform: mediatek: vpu: fix NULL ptr dereference

Yunfei Dong <yunfei.dong@mediatek.com>
    media: v4l2-mem2mem: add lock to protect parameter num_rdy

Immad Mir <mirimmad17@gmail.com>
    FS: JFS: Check for read-only mounted filesystem in txBegin

Immad Mir <mirimmad17@gmail.com>
    FS: JFS: Fix null-ptr-deref Read in txBegin

Gustavo A. R. Silva <gustavoars@kernel.org>
    MIPS: dec: prom: Address -Warray-bounds warning

Yogesh <yogi.kernel@gmail.com>
    fs: jfs: Fix UBSAN: array-index-out-of-bounds in dbAllocDmapLev

Jan Kara <jack@suse.cz>
    udf: Fix uninitialized array access for some pathnames

Ye Bin <yebin10@huawei.com>
    quota: fix warning in dqgrab()

Jan Kara <jack@suse.cz>
    quota: Properly disable quotas when add_dquot_ref() fails

Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
    ALSA: emu10k1: roll up loops in DSP setup code for Audigy

hackyzh002 <hackyzh002@gmail.com>
    drm/radeon: Fix integer overflow in radeon_cs_parser_init

Nathan Chancellor <natechancellor@gmail.com>
    lib/mpi: Eliminate unused umul_ppmm definitions for MIPS


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/mips/include/asm/dec/prom.h                   |   2 +-
 arch/powerpc/kernel/rtas_flash.c                   |   6 +-
 arch/x86/kernel/fpu/xstate.c                       |   8 ++
 drivers/android/binder.c                           |   1 +
 drivers/android/binder_alloc.c                     |   6 ++
 drivers/android/binder_alloc.h                     |   1 +
 drivers/dma-buf/sw_sync.c                          |  18 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   3 +
 drivers/gpu/drm/radeon/radeon_cs.c                 |   3 +-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |   2 +
 drivers/media/platform/mtk-vpu/mtk_vpu.c           |   6 +-
 drivers/mmc/host/wbsd.c                            |   2 -
 drivers/net/ethernet/ibm/ibmveth.c                 |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  16 +--
 drivers/net/ethernet/intel/igb/igb_ptp.c           |  24 ++---
 drivers/net/phy/broadcom.c                         |  13 +++
 drivers/net/team/team.c                            |   4 +-
 drivers/pcmcia/rsrc_nonstatic.c                    |   2 +
 drivers/scsi/raid_class.c                          |  48 ---------
 drivers/scsi/snic/snic_disc.c                      |   3 +-
 drivers/tty/serial/8250/8250_port.c                |   1 +
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |   4 +-
 fs/cifs/file.c                                     |   2 +-
 fs/gfs2/super.c                                    |  26 +++--
 fs/jfs/jfs_dmap.c                                  |   3 +
 fs/jfs/jfs_txnmgr.c                                |   5 +
 fs/jfs/namei.c                                     |   5 +
 fs/quota/dquot.c                                   |   5 +-
 fs/udf/unicode.c                                   |   2 +-
 include/linux/raid_class.h                         |   4 -
 include/linux/virtio_net.h                         |   4 +
 include/media/v4l2-mem2mem.h                       |  18 +++-
 include/net/sock.h                                 |  11 +-
 kernel/trace/trace.c                               |   9 +-
 kernel/trace/trace_irqsoff.c                       |   3 +-
 kernel/trace/trace_sched_wakeup.c                  |   2 +
 lib/clz_ctz.c                                      |  32 ++----
 lib/mpi/longlong.h                                 |  36 +------
 lib/test_firmware.c                                |  39 +++++--
 net/batman-adv/bat_v_elp.c                         |   3 +-
 net/batman-adv/bat_v_ogm.c                         |   7 +-
 net/batman-adv/hard-interface.c                    |   2 +-
 net/batman-adv/translation-table.c                 |   1 -
 net/bluetooth/l2cap_core.c                         |   5 +
 net/core/rtnetlink.c                               |   5 +-
 net/core/sock.c                                    |   2 +-
 net/ipv4/ip_vti.c                                  |   4 +-
 net/ipv4/tcp_timer.c                               |   4 +-
 net/ipv6/ip6_vti.c                                 |   4 +-
 net/key/af_key.c                                   |   4 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  74 +++++++-------
 net/netfilter/nf_conntrack_proto_sctp.c            |   6 +-
 net/netfilter/nft_dynset.c                         |   3 +
 net/sctp/socket.c                                  |   2 +-
 net/unix/af_unix.c                                 |   9 +-
 net/xfrm/xfrm_user.c                               |  13 ++-
 sound/pci/emu10k1/emufx.c                          | 112 ++-------------------
 sound/soc/codecs/rt5665.c                          |   2 +
 sound/usb/quirks-table.h                           |  29 ++++++
 60 files changed, 325 insertions(+), 351 deletions(-)


