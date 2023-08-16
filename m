Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6002F77E680
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbjHPQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344762AbjHPQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8D199B;
        Wed, 16 Aug 2023 09:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF94666C34;
        Wed, 16 Aug 2023 16:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F3FC433C8;
        Wed, 16 Aug 2023 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692203714;
        bh=a6BcsZPgiAyQp2xBGBPKR62wXTX/t20Ec2iw9iCoe5I=;
        h=From:To:Cc:Subject:Date:From;
        b=d82aeOxDj+pvYmLO+v8dhQbbVE5fp6gYWIme1pBP+h2OgN4lSZjk5Tr3+q0jpZFVq
         koORI0EkIscZ8BJ7bTvmvK//EiblQT3aQkuIV/8L0KQhiUgwmaeySWfPkkG9redBsz
         bFe7WdrwuFKaWYa56a8D5nbTe7lE/PrHaeTzzCsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.323
Date:   Wed, 16 Aug 2023 18:35:09 +0200
Message-ID: <2023081610-lukewarm-defy-2e9d@gregkh>
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

I'm announcing the release of the 4.14.323 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
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
 arch/x86/kvm/x86.c                                        |    2 
 drivers/dma/pl330.c                                       |   18 +
 drivers/gpu/drm/nouveau/nouveau_connector.c               |    2 
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c |    2 
 drivers/infiniband/hw/hfi1/chip.c                         |    1 
 drivers/mmc/host/moxart-mmc.c                             |    8 
 drivers/net/bonding/bond_main.c                           |    4 
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
 include/net/netfilter/nf_tables.h                         |   27 ++
 lib/test_firmware.c                                       |    8 
 net/dccp/output.c                                         |    2 
 net/dccp/proto.c                                          |   10 
 net/ipv6/ndisc.c                                          |    3 
 net/netfilter/nf_tables_api.c                             |  143 ++++++++------
 net/netfilter/nft_objref.c                                |    8 
 net/packet/af_packet.c                                    |   16 -
 tools/testing/radix-tree/regression1.c                    |    2 
 33 files changed, 227 insertions(+), 119 deletions(-)

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

Douglas Miller (1):
      IB/hfi1: Fix possible panic during hotplug remove

Elson Roy Serrao (1):
      usb: dwc3: Properly handle processing of pending events

Eric Dumazet (2):
      net/packet: annotate data-races around tp->status
      dccp: fix data-race around dp->dccps_mss_cache

Greg Kroah-Hartman (2):
      sparc: fix up arch_cpu_finalize_init() build breakage.
      Linux 4.14.323

Ilpo Järvinen (1):
      dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Karol Herbst (1):
      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes

Kirill A. Shutemov (1):
      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Maciej Żenczykowski (1):
      ipv6: adjust ndisc_is_useropt() to also return true for PIO

Masahiro Yamada (1):
      alpha: remove __init annotation from exported page_is_ram()

Michael Kelley (1):
      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Mirsad Goran Todorovac (1):
      test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Pablo Neira Ayuso (1):
      netfilter: nf_tables: report use refcount overflow

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

