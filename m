Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC977E6AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjHPQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245193AbjHPQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C2DE4C;
        Wed, 16 Aug 2023 09:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1750A628C6;
        Wed, 16 Aug 2023 16:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2515FC433C7;
        Wed, 16 Aug 2023 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692204057;
        bh=yrNHmyMIE12UcOcrpvYA80W3gZTXuyxgspKIaFD6FH8=;
        h=From:To:Cc:Subject:Date:From;
        b=sFEEH/HUyIAzXUZdwIUkSrRPOudS/IBXIdv08R3l+bRhAqwKbR24ul4tP0RjD6bRK
         H3+WJCPkO0DcoaK09Yi23OVvuplHBw3X0T1bEb4p/Gmj9nRpQJC6L2o2KIupjGfc0/
         Nc1C9JMeZsJqel3F7IriSf+irXi7F/NzYwf9us+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.254
Date:   Wed, 16 Aug 2023 18:40:52 +0200
Message-ID: <2023081653-cupbearer-evict-c527@gregkh>
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

I'm announcing the release of the 5.4.254 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/alpha/kernel/setup.c                                 |    3 
 arch/x86/entry/vdso/vma.c                                 |    4 
 arch/x86/include/asm/processor.h                          |    2 
 arch/x86/kernel/cpu/amd.c                                 |    1 
 arch/x86/kernel/cpu/common.c                              |    5 
 arch/x86/kvm/x86.c                                        |    2 
 arch/x86/mm/pkeys.c                                       |    6 
 drivers/android/binder.c                                  |    1 
 drivers/android/binder_alloc.c                            |    6 
 drivers/android/binder_alloc.h                            |    1 
 drivers/dma/mcf-edma.c                                    |   13 -
 drivers/dma/pl330.c                                       |   18 +
 drivers/gpu/drm/nouveau/nouveau_connector.c               |    2 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h         |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c         |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c         |   10 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c        |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c         |    1 
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c         |    1 
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c |    2 
 drivers/infiniband/hw/hfi1/chip.c                         |    1 
 drivers/isdn/mISDN/dsp.h                                  |    2 
 drivers/isdn/mISDN/dsp_cmx.c                              |    2 
 drivers/isdn/mISDN/dsp_core.c                             |    2 
 drivers/mmc/host/moxart-mmc.c                             |    8 
 drivers/net/bonding/bond_main.c                           |    4 
 drivers/net/ethernet/ibm/ibmvnic.c                        |   15 -
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c           |    3 
 drivers/net/tun.c                                         |    2 
 drivers/nvme/host/rdma.c                                  |    3 
 drivers/nvme/host/tcp.c                                   |    3 
 drivers/scsi/53c700.c                                     |    2 
 drivers/scsi/raid_class.c                                 |    1 
 drivers/scsi/scsi_proc.c                                  |   30 +-
 drivers/scsi/snic/snic_disc.c                             |    1 
 drivers/scsi/storvsc_drv.c                                |    4 
 drivers/usb/common/usb-conn-gpio.c                        |    6 
 drivers/usb/dwc3/gadget.c                                 |    9 
 drivers/usb/storage/alauda.c                              |    9 
 fs/btrfs/extent-tree.c                                    |    5 
 fs/btrfs/extent_io.c                                      |    7 
 fs/nilfs2/inode.c                                         |    8 
 fs/nilfs2/segment.c                                       |    2 
 fs/nilfs2/the_nilfs.h                                     |    2 
 include/net/cfg80211.h                                    |    3 
 include/net/netfilter/nf_tables.h                         |   31 ++
 net/dccp/output.c                                         |    2 
 net/dccp/proto.c                                          |   10 
 net/ipv6/ndisc.c                                          |    3 
 net/netfilter/nf_tables_api.c                             |  166 ++++++++------
 net/netfilter/nft_flow_offload.c                          |    6 
 net/netfilter/nft_objref.c                                |    8 
 net/packet/af_packet.c                                    |   16 -
 net/sched/sch_netem.c                                     |   59 ++--
 tools/testing/radix-tree/regression1.c                    |    2 
 tools/testing/selftests/rseq/Makefile                     |    4 
 tools/testing/selftests/rseq/rseq.c                       |    2 
 58 files changed, 336 insertions(+), 193 deletions(-)

Alan Stern (1):
      usb-storage: alauda: Fix uninit-value in alauda_check_media()

Alexandra Diupina (1):
      scsi: 53c700: Check that command slot is not NULL

Andrew Kanner (1):
      drivers: net: prevent tun_build_skb() to exceed the packet size limit

Arnd Bergmann (1):
      x86: Move gds_ucode_mitigated() declaration to header

Christoph Hellwig (1):
      btrfs: don't stop integrity writeback too early

Christophe JAILLET (1):
      dmaengine: mcf-edma: Fix a potential un-allocated memory access

Colin Ian King (1):
      radix tree test suite: fix incorrect allocation size for pthreads

Cristian Ciocaltea (1):
      x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405

Daniel Jurgens (1):
      net/mlx5: Allow 0 for total host VFs

Douglas Miller (1):
      IB/hfi1: Fix possible panic during hotplug remove

Elson Roy Serrao (1):
      usb: dwc3: Properly handle processing of pending events

Eric Dumazet (3):
      net/packet: annotate data-races around tp->status
      dccp: fix data-race around dp->dccps_mss_cache
      sch_netem: fix issues in netem_change() vs get_dist_table()

Felix Fietkau (1):
      wifi: cfg80211: fix sband iftype data lookup for AP_VLAN

Greg Kroah-Hartman (1):
      Linux 5.4.254

Ilpo Järvinen (1):
      dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Josef Bacik (1):
      btrfs: set cache_block_group_error if we find an error

Karol Herbst (2):
      drm/nouveau/gr: enable memory loads on helper invocation on all channels
      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes

Kirill A. Shutemov (1):
      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Maciej Żenczykowski (1):
      ipv6: adjust ndisc_is_useropt() to also return true for PIO

Mark Brown (1):
      selftests/rseq: Fix build with undefined __weak

Masahiro Yamada (1):
      alpha: remove __init annotation from exported page_is_ram()

Michael Kelley (1):
      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Ming Lei (2):
      nvme-tcp: fix potential unbalanced freeze & unfreeze
      nvme-rdma: fix potential unbalanced freeze & unfreeze

Nathan Chancellor (1):
      mISDN: Update parameter type of dsp_cmx_send()

Nick Child (1):
      ibmvnic: Handle DMA unmapping of login buffs in release functions

Pablo Neira Ayuso (1):
      netfilter: nf_tables: report use refcount overflow

Prashanth K (1):
      usb: common: usb-conn-gpio: Prevent bailing out if initial role is none

Qi Zheng (1):
      binder: fix memory leak in binder_init()

Ryusuke Konishi (1):
      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput

Sergei Antonov (1):
      mmc: moxart: read scr register without changing byte order

Thomas Gleixner (1):
      x86/pkeys: Revert a5eff7259790 ("x86/pkeys: Add PKRU value to init_fpstate")

Tony Battersby (1):
      scsi: core: Fix legacy /proc parsing buffer overflow

Yiyuan Guo (1):
      iio: cros_ec: Fix the allocation size for cros_ec_command

Zhu Wang (2):
      scsi: snic: Fix possible memory leak if device_add() fails
      scsi: core: Fix possible memory leak if device_add() fails

Ziyang Xuan (1):
      bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

