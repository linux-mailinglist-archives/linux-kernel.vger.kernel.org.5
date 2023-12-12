Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC8580EB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbjLLMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjLLMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:05:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A3C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:05:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED45EC433C8;
        Tue, 12 Dec 2023 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702382706;
        bh=ESTzSJJ7/rLv2BGu31Y5Yc3pLMcmjSxqifZVMoG9XBo=;
        h=From:To:Cc:Subject:Date:From;
        b=0ysL421XgG5CQ8mWXoUqy//av9LgvM0W51b6XYlcI7xo8LSzrrYeZSQgu+EAmSc3k
         sSLxmpTclb77rcwZqYwoBLEtzqcPjpC7LX6cGasIDkav2xuxktb24/U845tZisPnHO
         pUtytssks0wbBKvBDyW+mz4IsLKnAYcK9sjXKDgM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: [PATCH 4.14 00/24] 4.14.333-rc2 review
Date:   Tue, 12 Dec 2023 13:05:03 +0100
Message-ID: <20231212120146.831816822@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.333-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.333-rc2
X-KernelTest-Deadline: 2023-12-14T12:01+00:00
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.333 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 14 Dec 2023 12:01:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.333-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.333-rc2

Ido Schimmel <idosch@nvidia.com>
    drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ido Schimmel <idosch@nvidia.com>
    psample: Require 'CAP_NET_ADMIN' when joining "packets" group

Ido Schimmel <idosch@nvidia.com>
    genetlink: add CAP_NET_ADMIN test for multicast bind

Ido Schimmel <idosch@nvidia.com>
    netlink: don't call ->netlink_bind with table lock held

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing error check for sb_set_blocksize call

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390/mm: Properly reset no-dat

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250_omap: Add earlycon support for the AM654 UART controller

Daniel Mack <daniel@zonque.org>
    serial: sc16is7xx: address RX timeout interrupt errata

Cameron Williams <cang1@live.co.uk>
    parport: Add support for Brainboxes IX/UC/PX parallel cards

Daniel Borkmann <daniel@iogearbox.net>
    packet: Move reference count in packet_sock to atomic_long_t

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a possible race when disabling buffered events

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix incomplete locking when disabling buffered events

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Always update snapshot buffer size

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Jason Zhang <jason.zhang@rock-chips.com>
    ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a warning when allocating buffered events fails

Armin Wolf <W_Armin@gmx.de>
    hwmon: (acpi_power_meter) Fix 4.29 MW bug

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Correct module description string

Eric Dumazet <edumazet@google.com>
    tcp: do not accept ACK of bytes we never sent

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: fix fake link up on xge port

YuanShang <YuanShang.Mao@amd.com>
    drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Increment tx_dropped in tg3_tso_bug()

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Move the [rt]x_dropped counters to tg3_napi


-------------

Diffstat:

 Makefile                                          |  4 +--
 arch/s390/mm/pgtable.c                            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
 drivers/hwmon/acpi_power_meter.c                  |  4 +++
 drivers/infiniband/hw/bnxt_re/main.c              |  2 +-
 drivers/net/ethernet/broadcom/tg3.c               | 42 ++++++++++++++++++----
 drivers/net/ethernet/broadcom/tg3.h               |  4 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 29 +++++++++++++++
 drivers/parport/parport_pc.c                      | 21 +++++++++++
 drivers/scsi/be2iscsi/be_main.c                   |  1 +
 drivers/tty/serial/8250/8250_early.c              |  1 +
 drivers/tty/serial/sc16is7xx.c                    | 12 +++++++
 fs/nilfs2/sufile.c                                | 44 ++++++++++++++++++-----
 fs/nilfs2/the_nilfs.c                             |  6 +++-
 include/net/genetlink.h                           |  3 ++
 kernel/trace/trace.c                              | 42 +++++++++++-----------
 net/core/drop_monitor.c                           |  4 ++-
 net/ipv4/tcp_input.c                              |  6 +++-
 net/netlink/af_netlink.c                          |  4 +--
 net/netlink/genetlink.c                           | 35 ++++++++++++++++++
 net/packet/af_packet.c                            | 16 ++++-----
 net/packet/internal.h                             |  2 +-
 net/psample/psample.c                             |  3 +-
 sound/core/pcm.c                                  |  1 +
 24 files changed, 232 insertions(+), 58 deletions(-)


