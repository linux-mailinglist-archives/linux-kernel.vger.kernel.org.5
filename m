Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588BD77AB55
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 23:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjHMVUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 17:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 17:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C54310D0;
        Sun, 13 Aug 2023 14:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC3C2612D6;
        Sun, 13 Aug 2023 21:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E7EC433C7;
        Sun, 13 Aug 2023 21:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961646;
        bh=Jh4KJjsbQaS+JEF+w7qDObZ/RSPYn8hd8PmpmYAz1TE=;
        h=From:To:Cc:Subject:Date:From;
        b=buJLSgPRpDUpkwqQX/Q7RqtebFIn3Bp/2tvIXbaakhyT7f9JkdU3ch9jcuCbnbkGC
         41jE4qpjKRMP/Ap44BibjL9hGA2wNq7uF58VYk97mAQcLkuDPPBruKvOsAUyXiEdk1
         Z15hwoYZujRBs88+wSHcbIkio+RGcawrX5/y4P7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: [PATCH 4.14 00/26] 4.14.323-rc1 review
Date:   Sun, 13 Aug 2023 23:18:53 +0200
Message-ID: <20230813211702.980427106@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.323-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.323-rc1
X-KernelTest-Deadline: 2023-08-15T21:17+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.323 release.
There are 26 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.323-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.323-rc1

Masahiro Yamada <masahiroy@kernel.org>
    alpha: remove __init annotation from exported page_is_ram()

Zhu Wang <wangzhu9@huawei.com>
    scsi: core: Fix possible memory leak if device_add() fails

Zhu Wang <wangzhu9@huawei.com>
    scsi: snic: Fix possible memory leak if device_add() fails

Alexandra Diupina <adiupina@astralinux.ru>
    scsi: 53c700: Check that command slot is not NULL

Michael Kelley <mikelley@microsoft.com>
    scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Tony Battersby <tonyb@cybernetics.com>
    scsi: core: Fix legacy /proc parsing buffer overflow

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: report use refcount overflow

Christoph Hellwig <hch@lst.de>
    btrfs: don't stop integrity writeback too early

Douglas Miller <doug.miller@cornelisnetworks.com>
    IB/hfi1: Fix possible panic during hotplug remove

Andrew Kanner <andrew.kanner@gmail.com>
    drivers: net: prevent tun_build_skb() to exceed the packet size limit

Eric Dumazet <edumazet@google.com>
    dccp: fix data-race around dp->dccps_mss_cache

Ziyang Xuan <william.xuanziyang@huawei.com>
    bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

Eric Dumazet <edumazet@google.com>
    net/packet: annotate data-races around tp->status

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes

Arnd Bergmann <arnd@arndb.de>
    x86: Move gds_ucode_mitigated() declaration to header

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Elson Roy Serrao <quic_eserrao@quicinc.com>
    usb: dwc3: Properly handle processing of pending events

Alan Stern <stern@rowland.harvard.edu>
    usb-storage: alauda: Fix uninit-value in alauda_check_media()

Yiyuan Guo <yguoaz@gmail.com>
    iio: cros_ec: Fix the allocation size for cros_ec_command

Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
    test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput

Colin Ian King <colin.i.king@gmail.com>
    radix tree test suite: fix incorrect allocation size for pthreads

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Maciej Żenczykowski <maze@google.com>
    ipv6: adjust ndisc_is_useropt() to also return true for PIO

Sergei Antonov <saproj@gmail.com>
    mmc: moxart: read scr register without changing byte order

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    sparc: fix up arch_cpu_finalize_init() build breakage.


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/alpha/kernel/setup.c                          |   3 +-
 arch/sparc/Kconfig                                 |   2 +-
 arch/x86/entry/vdso/vma.c                          |   4 +-
 arch/x86/include/asm/processor.h                   |   2 +
 arch/x86/kvm/x86.c                                 |   2 -
 drivers/dma/pl330.c                                |  18 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |   2 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   1 +
 drivers/mmc/host/moxart-mmc.c                      |   8 +-
 drivers/net/bonding/bond_main.c                    |   4 +-
 drivers/net/tun.c                                  |   2 +-
 drivers/scsi/53c700.c                              |   2 +-
 drivers/scsi/raid_class.c                          |   1 +
 drivers/scsi/scsi_proc.c                           |  30 +++--
 drivers/scsi/snic/snic_disc.c                      |   1 +
 drivers/scsi/storvsc_drv.c                         |   4 -
 drivers/usb/dwc3/gadget.c                          |   9 +-
 drivers/usb/storage/alauda.c                       |   9 +-
 fs/btrfs/extent_io.c                               |   7 +-
 fs/nilfs2/inode.c                                  |   8 ++
 fs/nilfs2/segment.c                                |   2 +
 fs/nilfs2/the_nilfs.h                              |   2 +
 include/net/netfilter/nf_tables.h                  |  27 +++-
 lib/test_firmware.c                                |   8 +-
 net/dccp/output.c                                  |   2 +-
 net/dccp/proto.c                                   |  10 +-
 net/ipv6/ndisc.c                                   |   3 +-
 net/netfilter/nf_tables_api.c                      | 143 +++++++++++++--------
 net/netfilter/nft_objref.c                         |   8 +-
 net/packet/af_packet.c                             |  16 ++-
 tools/testing/radix-tree/regression1.c             |   2 +-
 33 files changed, 228 insertions(+), 120 deletions(-)


