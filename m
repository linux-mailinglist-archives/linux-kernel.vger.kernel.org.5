Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE4811E18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442406AbjLMTGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjLMTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:06:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFDC1FDB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:06:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55163C433CC;
        Wed, 13 Dec 2023 19:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702494367;
        bh=AGCZom7OVVlOaOnsC2HPUrhDBhMiIY14c14sg9kOF7M=;
        h=From:To:Cc:Subject:Date:From;
        b=lZeRod4EXCV7+0IJhASy6kxNzE0EJWZnnrG9fveSR3qn/bpv44TeFjMoV14P/Jnne
         GkQlqGndCbSuuxJi0lFmDVzZC94eAuhsPtGEJPZw030RgAi4Qi+gVQcz0Zh7DzgH6K
         Uu9ZjdDVtZ+7eOs12fWZy9IhkU1qAhM+D6a0cYRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.302
Date:   Wed, 13 Dec 2023 20:05:44 +0100
Message-ID: <2023121345-humorless-acre-4805@gregkh>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.19.302 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/arm/boot/dts/imx6qdl.dtsi                    |    2 
 arch/arm/boot/dts/imx6sl.dtsi                     |    2 
 arch/arm/boot/dts/imx6sx.dtsi                     |    2 
 arch/arm/boot/dts/imx6ul.dtsi                     |    4 
 arch/arm/boot/dts/imx7s.dtsi                      |   16 +-
 arch/arm/mach-imx/mmdc.c                          |    7 -
 arch/s390/mm/pgtable.c                            |    2 
 arch/x86/kernel/cpu/amd.c                         |    3 
 drivers/base/devcoredump.c                        |   86 ++++++++++++
 drivers/gpio/gpiolib-sysfs.c                      |   15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |    2 
 drivers/hwmon/acpi_power_meter.c                  |    4 
 drivers/infiniband/hw/bnxt_re/main.c              |    2 
 drivers/infiniband/ulp/isert/ib_isert.c           |   93 ++++++-------
 drivers/infiniband/ulp/isert/ib_isert.h           |   41 ++++-
 drivers/media/platform/davinci/vpif_capture.c     |    2 
 drivers/net/arcnet/arc-rimi.c                     |    4 
 drivers/net/arcnet/arcdevice.h                    |    8 +
 drivers/net/arcnet/arcnet.c                       |   66 +++++++++
 drivers/net/arcnet/com20020-isa.c                 |    4 
 drivers/net/arcnet/com20020-pci.c                 |  119 +++++++++--------
 drivers/net/arcnet/com20020_cs.c                  |    2 
 drivers/net/arcnet/com90io.c                      |    4 
 drivers/net/arcnet/com90xx.c                      |    4 
 drivers/net/ethernet/broadcom/tg3.c               |   42 +++++-
 drivers/net/ethernet/broadcom/tg3.h               |    4 
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c |   29 ++++
 drivers/net/hyperv/Kconfig                        |    1 
 drivers/parport/parport_pc.c                      |   21 +++
 drivers/scsi/be2iscsi/be_main.c                   |    1 
 drivers/spi/spi-imx.c                             |  151 +++++++++++++++-------
 drivers/tty/serial/8250/8250_early.c              |    1 
 drivers/tty/serial/sc16is7xx.c                    |   12 +
 drivers/usb/gadget/function/f_hid.c               |    7 -
 drivers/usb/typec/class.c                         |    5 
 fs/nilfs2/sufile.c                                |   42 +++++-
 fs/nilfs2/the_nilfs.c                             |    6 
 include/linux/cpuhotplug.h                        |    1 
 include/linux/hrtimer.h                           |    4 
 include/linux/perf_event.h                        |    2 
 include/net/genetlink.h                           |    3 
 include/uapi/linux/netfilter/xt_owner.h           |    7 -
 include/uapi/linux/perf_event.h                   |    5 
 kernel/cpu.c                                      |    8 +
 kernel/events/core.c                              |   80 ++++++++---
 kernel/events/ring_buffer.c                       |    5 
 kernel/time/hrtimer.c                             |   33 +---
 kernel/trace/trace.c                              |   38 ++---
 net/core/drop_monitor.c                           |    4 
 net/ipv4/ip_gre.c                                 |   11 +
 net/ipv4/tcp_input.c                              |    6 
 net/ipv6/ip6_fib.c                                |    6 
 net/netfilter/ipset/ip_set_core.c                 |   14 +-
 net/netfilter/xt_owner.c                          |   37 ++++-
 net/netlink/af_netlink.c                          |    4 
 net/netlink/genetlink.c                           |   35 +++++
 net/packet/af_packet.c                            |   16 +-
 net/packet/internal.h                             |    2 
 net/psample/psample.c                             |    3 
 scripts/kconfig/symbol.c                          |   14 --
 sound/core/pcm.c                                  |    1 
 tools/include/uapi/linux/perf_event.h             |    5 
 63 files changed, 826 insertions(+), 336 deletions(-)

Ahmed S. Darwish (1):
      net: arcnet: Fix RESET flag handling

Alex Pakhunov (2):
      tg3: Move the [rt]x_dropped counters to tg3_napi
      tg3: Increment tx_dropped in tg3_tso_bug()

Anson Huang (1):
      ARM: dts: imx: make gpt node name generic

Armin Wolf (1):
      hwmon: (acpi_power_meter) Fix 4.29 MW bug

Boerge Struempfel (1):
      gpiolib: sysfs: Fix error handling on failed export

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Check vendor in the AMD microcode callback

Cameron Williams (1):
      parport: Add support for Brainboxes IX/UC/PX parallel cards

Claudio Imbrenda (1):
      KVM: s390/mm: Properly reset no-dat

Daniel Borkmann (1):
      packet: Move reference count in packet_sock to atomic_long_t

Daniel Mack (1):
      serial: sc16is7xx: address RX timeout interrupt errata

Dinghao Liu (1):
      scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Eric Dumazet (2):
      ipv6: fix potential NULL deref in fib6_add()
      tcp: do not accept ACK of bytes we never sent

Evgeny Novikov (1):
      media: davinci: vpif_capture: fix potential double free

Greg Kroah-Hartman (1):
      Linux 4.19.302

Ido Schimmel (4):
      netlink: don't call ->netlink_bind with table lock held
      genetlink: add CAP_NET_ADMIN test for multicast bind
      psample: Require 'CAP_NET_ADMIN' when joining "packets" group
      drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Jason Zhang (1):
      ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Jozsef Kadlecsik (1):
      netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Kalesh AP (1):
      RDMA/bnxt_re: Correct module description string

Konstantin Aladyshev (1):
      usb: gadget: f_hid: fix report descriptor allocation

Kunwu Chan (1):
      ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Lukasz Pawelczyk (1):
      netfilter: xt_owner: Add supplementary groups option

Masahiro Yamada (1):
      kconfig: fix memory leak from range properties

Mukesh Ojha (2):
      devcoredump : Serialize devcd_del work
      devcoredump: Send uevent once devcd is ready

Namhyung Kim (2):
      perf/core: Add a new read format to get a number of lost samples
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources

Peter Zijlstra (1):
      perf: Fix perf_event_validate_size()

Petr Pavlu (3):
      tracing: Fix a warning when allocating buffered events fails
      tracing: Fix incomplete locking when disabling buffered events
      tracing: Fix a possible race when disabling buffered events

Phil Sutter (1):
      netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

Philipp Zabel (1):
      ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

RD Babiera (1):
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Randy Dunlap (1):
      hv_netvsc: rndis_filter needs to select NLS

Robin Gong (2):
      spi: imx: move wml setting to later than setup_transfer
      spi: imx: correct wml as the last sg length

Ronald Wahl (1):
      serial: 8250_omap: Add earlycon support for the AM654 UART controller

Ryusuke Konishi (2):
      nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()
      nilfs2: fix missing error check for sb_set_blocksize call

Sagi Grimberg (1):
      IB/isert: Fix unaligned immediate-data handling

Shigeru Yoshida (1):
      ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Steven Rostedt (Google) (1):
      tracing: Always update snapshot buffer size

Thomas Gleixner (1):
      hrtimers: Push pending hrtimers away from outgoing CPU earlier

Thomas Reichinger (1):
      arcnet: restoring support for multiple Sohard Arcnet cards

Tong Zhang (1):
      net: arcnet: com20020 fix error handling

Uwe Kleine-König (2):
      spi: imx: add a device specific prepare_message callback
      spi: imx: mx51-ecspi: Move some initialisation to prepare_message hook.

Yonglong Liu (1):
      net: hns: fix fake link up on xge port

YuanShang (1):
      drm/amdgpu: correct chunk_ptr to a pointer to chunk.

