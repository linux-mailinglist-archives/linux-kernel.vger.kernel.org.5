Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B377E682
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbjHPQfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbjHPQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:35:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C162721;
        Wed, 16 Aug 2023 09:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F340764B14;
        Wed, 16 Aug 2023 16:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE15C433C7;
        Wed, 16 Aug 2023 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692203724;
        bh=6j0E2hHTfDHM8bEWxO9QLQpVCLupvYN++5E3F8zEqd4=;
        h=From:To:Cc:Subject:Date:From;
        b=HCKEGbdThpMpSeIXZlrqpLbza56MN2QA4xyK9LnsCzd88FCv4AmnuAqeewrhLZvFA
         fvEq5uqqGr0IIrTyWjjTqCJEfzaSDkMwnVTn1+s8aLvZmaQuBpHy4KMiXPut//lIC6
         giLWKLJQxGAJxkZs7mH+AvOwCNF4eLjGRkzTe8Uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.292
Date:   Wed, 16 Aug 2023 18:35:17 +0200
Message-ID: <2023081617-dwindle-justifier-8ca9@gregkh>
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

I'm announcing the release of the 4.19.292 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                  |    2 
 arch/alpha/kernel/setup.c                                 |    3 
 arch/sparc/Kconfig                                        |    2 
 arch/x86/entry/vdso/vma.c                                 |    4 
 arch/x86/include/asm/processor.h                          |    2 
 arch/x86/kernel/cpu/amd.c                                 |    1 
 arch/x86/kvm/x86.c                                        |    2 
 drivers/android/binder.c                                  |    1 
 drivers/android/binder_alloc.c                            |    6 
 drivers/android/binder_alloc.h                            |    1 
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
 drivers/net/tun.c                                         |    2 
 drivers/scsi/53c700.c                                     |    2 
 drivers/scsi/raid_class.c                                 |    1 
 drivers/scsi/scsi_proc.c                                  |   30 +-
 drivers/scsi/snic/snic_disc.c                             |    1 
 drivers/scsi/storvsc_drv.c                                |    4 
 drivers/usb/dwc3/gadget.c                                 |    9 
 drivers/usb/storage/alauda.c                              |    9 
 fs/btrfs/extent_io.c                                      |    7 
 fs/nilfs2/inode.c                                         |    8 
 fs/nilfs2/segment.c                                       |    2 
 fs/nilfs2/the_nilfs.h                                     |    2 
 include/net/cfg80211.h                                    |    3 
 include/net/netfilter/nf_tables.h                         |   35 ++
 net/dccp/output.c                                         |    2 
 net/dccp/proto.c                                          |   10 
 net/ipv6/ndisc.c                                          |    3 
 net/netfilter/nf_tables_api.c                             |  180 +++++++++-----
 net/netfilter/nft_flow_offload.c                          |   23 +
 net/netfilter/nft_objref.c                                |    8 
 net/packet/af_packet.c                                    |   16 -
 net/sched/sch_netem.c                                     |   59 +---
 tools/testing/radix-tree/regression1.c                    |    2 
 49 files changed, 348 insertions(+), 168 deletions(-)

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

Colin Ian King (1):
      radix tree test suite: fix incorrect allocation size for pthreads

Cristian Ciocaltea (1):
      x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405

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

Greg Kroah-Hartman (2):
      sparc: fix up arch_cpu_finalize_init() build breakage.
      Linux 4.19.292

Ilpo Järvinen (1):
      dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Karol Herbst (2):
      drm/nouveau/gr: enable memory loads on helper invocation on all channels
      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes

Kirill A. Shutemov (1):
      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Maciej Żenczykowski (1):
      ipv6: adjust ndisc_is_useropt() to also return true for PIO

Masahiro Yamada (1):
      alpha: remove __init annotation from exported page_is_ram()

Michael Kelley (1):
      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Nathan Chancellor (1):
      mISDN: Update parameter type of dsp_cmx_send()

Nick Child (1):
      ibmvnic: Handle DMA unmapping of login buffs in release functions

Pablo Neira Ayuso (2):
      netfilter: nf_tables: bogus EBUSY when deleting flowtable after flush
      netfilter: nf_tables: report use refcount overflow

Qi Zheng (1):
      binder: fix memory leak in binder_init()

Ryusuke Konishi (1):
      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput

Sergei Antonov (1):
      mmc: moxart: read scr register without changing byte order

Tony Battersby (1):
      scsi: core: Fix legacy /proc parsing buffer overflow

Yiyuan Guo (1):
      iio: cros_ec: Fix the allocation size for cros_ec_command

Zhu Wang (2):
      scsi: snic: Fix possible memory leak if device_add() fails
      scsi: core: Fix possible memory leak if device_add() fails

Ziyang Xuan (1):
      bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

