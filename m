Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CACA81333C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573512AbjLNOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573513AbjLNOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40F0128
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702564550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O7PG39gRe2IdSBVDmGaMuuDnG6wKh0cGgqB3JijHhU8=;
        b=FTnDCL3xZr5p1dTX3c1T656FJRamHmeHQYgGaRVB1fEepO4bVP8Lvf2rPIFN6Yax2HF+bI
        uNyIQhHRccUCq7uDluBD+EPPZJA7WAc6o7YIze+LNFxuWfiqkvMKwvku/YpHMnKYKbJVWb
        TOJcnvb8qWggMgSj2IhnjL/PynHnzJM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-5Llg8FIVN0eQRZQwh0sCUQ-1; Thu,
 14 Dec 2023 09:35:48 -0500
X-MC-Unique: 5Llg8FIVN0eQRZQwh0sCUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 326472820B79;
        Thu, 14 Dec 2023 14:35:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F0B82166B31;
        Thu, 14 Dec 2023 14:35:43 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.7-rc6
Date:   Thu, 14 Dec 2023 15:35:15 +0100
Message-ID: <20231214143515.27817-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Notably this includes the fix for the NIC driver issue you reported and,
quite peculiarly, no fixes from any subtree.

No known regressions standing.

We plan to send another PR for 6.7 next week. Should we send it earlier
than usual to avoid conflicts with the season holiday, if any?

The following changes since commit 5e3f5b81de80c98338bcb47c233aebefee5a4801:

  Merge tag 'net-6.7-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-12-07 17:04:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc6

for you to fetch changes up to 7bb26ea74aa86fdf894b7dbd8c5712c5b4187da7:

  net: atlantic: fix double free in ring reinit logic (2023-12-14 12:10:59 +0100)

----------------------------------------------------------------
Current release - regressions:

  - tcp: fix tcp_disordered_ack() vs usec TS resolution

Current release - new code bugs:

  - dpll: sanitize possible null pointer dereference in dpll_pin_parent_pin_set()

  - eth: octeon_ep: initialise control mbox tasks before using APIs

Previous releases - regressions:

  - io_uring/af_unix: disable sending io_uring over sockets

  - eth: mlx5e:
    - TC, don't offload post action rule if not supported
    - fix possible deadlock on mlx5e_tx_timeout_work

  - eth: iavf: fix iavf_shutdown to call iavf_remove instead iavf_close

  - eth: bnxt_en: fix skb recycling logic in bnxt_deliver_skb()

  - eth: ena: fix DMA syncing in XDP path when SWIOTLB is on

  - eth: team: fix use-after-free when an option instance allocation fails

Previous releases - always broken:

  - neighbour: don't let neigh_forced_gc() disable preemption for long

  - net: prevent mss overflow in skb_segment()

  - ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX

  - tcp: remove acked SYN flag from packet in the transmit queue correctly

  - eth: octeontx2-af:
    - fix a use-after-free in rvu_nix_register_reporters
    - fix promisc mcam entry action

  - eth: dwmac-loongson: make sure MDIO is initialized before use

  - eth: atlantic: fix double free in ring reinit logic

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Andrew Halaney (1):
      net: stmmac: Handle disabled MDIO busses from devicetree

Chengfeng Ye (2):
      atm: solos-pci: Fix potential deadlock on &cli_queue_lock
      atm: solos-pci: Fix potential deadlock on &tx_queue_lock

Chris Mi (2):
      net/mlx5e: Disable IPsec offload support if not FW steering
      net/mlx5e: TC, Don't offload post action rule if not supported

Dan Carpenter (1):
      net/mlx5: Fix a NULL vs IS_ERR() check

David Arinzon (4):
      net: ena: Destroy correct number of xdp queues upon failure
      net: ena: Fix xdp drops handling due to multibuf packets
      net: ena: Fix DMA syncing in XDP path when SWIOTLB is on
      net: ena: Fix XDP redirection error

David S. Miller (3):
      Merge tag 'mlx5-fixes-2023-12-04' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'octeontx2-fixes'
      Merge branch 'stmmac-bug-fixes'

Dinghao Liu (1):
      qed: Fix a potential use-after-free in qed_cxt_tables_alloc

Dong Chenchen (1):
      net: Remove acked SYN flag from packet in the transmit queue correctly

Eric Dumazet (2):
      tcp: fix tcp_disordered_ack() vs usec TS resolution
      net: prevent mss overflow in skb_segment()

Florent Revest (1):
      team: Fix use-after-free when an option instance allocation fails

Gavin Li (1):
      net/mlx5e: Check netdev pointer before checking its net ns

Hariprasad Kelam (3):
      octeontx2-pf: Fix promisc mcam entry action
      octeontx2-af: Update RSS algorithm index
      octeontx2-af: Fix pause frame configuration

Hyunwoo Kim (3):
      atm: Fix Use-After-Free in do_vcc_ioctl
      net/rose: Fix Use-After-Free in rose_ioctl
      appletalk: Fix Use-After-Free in atalk_ioctl

Igor Russkikh (1):
      net: atlantic: fix double free in ring reinit logic

Ioana Ciornei (2):
      dpaa2-switch: fix size of the dma_unmap
      dpaa2-switch: do not ask for MDB, VLAN and FDB replay

Jakub Kicinski (6):
      Merge branch 'qca_spi-collection-of-major-fixes'
      Merge branch 'bnxt_en-misc-fixes'
      Merge branch 'ena-driver-xdp-bug-fixes'
      Revert "tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set"
      Merge branch 'dpaa2-switch-various-fixes'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jianbo Liu (2):
      net/mlx5e: Reduce eswitch mode_lock protection context
      net/mlx5e: Check the number of elements before walk TC rhashtable

Jiri Pirko (1):
      dpll: sanitize possible null pointer dereference in dpll_pin_parent_pin_set()

Judy Hsiao (1):
      neighbour: Don't let neigh_forced_gc() disable preemption for long

Kalesh AP (1):
      bnxt_en: Fix wrong return value check in bnxt_close_nic()

Karsten Graul (1):
      MAINTAINERS: remove myself as maintainer of SMC

Krzysztof Kozlowski (2):
      stmmac: dwmac-loongson: drop useless check for compatible fallback
      MIPS: dts: loongson: drop incorrect dwmac fallback compatible

Leon Romanovsky (4):
      net/mlx5e: Honor user choice of IPsec replay window size
      net/mlx5e: Ensure that IPsec sequence packet number starts from 1
      net/mlx5e: Remove exposure of IPsec RX flow steering struct
      net/mlx5e: Tidy up IPsec NAT-T SA discovery

Maciej Żenczykowski (1):
      net: ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX

Michael Chan (1):
      bnxt_en: Fix HWTSTAMP_FILTER_ALL packet timestamp logic

Moshe Shemesh (2):
      net/mlx5e: Fix possible deadlock on mlx5e_tx_timeout_work
      net/mlx5: Nack sync reset request when HotPlug is enabled

Nikolay Kuratov (1):
      vsock/virtio: Fix unsigned integer wrap around in virtio_transport_has_space()

Patrisious Haddad (2):
      net/mlx5e: Unify esw and normal IPsec status table creation/destruction
      net/mlx5e: Add IPsec and ASO syndromes check in HW

Pavel Begunkov (1):
      io_uring/af_unix: disable sending io_uring over sockets

Piotr Gardocki (2):
      iavf: Introduce new state machines for flow director
      iavf: Handle ntuple on/off based on new state machines for flow director

Radu Bulie (1):
      net: fec: correct queue selection

Salvatore Dipietro (1):
      tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set

Shinas Rasheed (2):
      octeon_ep: initialise control mbox tasks before using APIs
      octeon_ep: explicitly test for firmware ready value

Slawomir Laba (1):
      iavf: Fix iavf_shutdown to call iavf_remove instead iavf_close

Sneh Shah (1):
      net: stmmac: dwmac-qcom-ethqos: Fix drops in 10M SGMII RX

Somnath Kotur (1):
      bnxt_en: Clear resource reservation during resume

Sreekanth Reddy (1):
      bnxt_en: Fix skb recycling logic in bnxt_deliver_skb()

Stefan Wahren (3):
      qca_debug: Prevent crash on TX ring changes
      qca_debug: Fix ethtool -G iface tx behavior
      qca_spi: Fix reset behavior

Vlad Buslov (1):
      net/sched: act_ct: Take per-cb reference to tcf_ct_flow_table

Yanteng Si (1):
      stmmac: dwmac-loongson: Make sure MDIO is initialized before use

Zhipeng Lu (1):
      octeontx2-af: fix a use-after-free in rvu_nix_register_reporters

 MAINTAINERS                                        |   1 -
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi |   3 +-
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi          |   3 +-
 drivers/atm/solos-pci.c                            |   8 +-
 drivers/dpll/dpll_netlink.c                        |  13 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c      |   3 -
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  53 ++-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |   5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  38 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |  11 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   5 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch-flower.c |   7 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  11 +-
 drivers/net/ethernet/freescale/fec_main.c          |  27 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   1 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  27 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h        |  15 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 179 ++++++---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  71 +++-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |  25 +-
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |  11 +-
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   5 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  55 ++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  25 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |   6 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  56 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  22 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 441 ++++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  27 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  25 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 162 +-------
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |  15 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  35 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   2 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  54 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  29 ++
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          |   1 +
 drivers/net/ethernet/qualcomm/qca_debug.c          |  17 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |  20 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |  19 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  10 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |   6 +-
 drivers/net/team/team.c                            |   4 +-
 include/linux/mlx5/mlx5_ifc.h                      |   9 +-
 include/net/addrconf.h                             |  12 +-
 include/net/if_inet6.h                             |   4 -
 include/net/netfilter/nf_flow_table.h              |  10 +
 io_uring/rsrc.h                                    |   7 -
 net/appletalk/ddp.c                                |   9 +-
 net/atm/ioctl.c                                    |   7 +-
 net/core/neighbour.c                               |   9 +-
 net/core/scm.c                                     |   6 +
 net/core/skbuff.c                                  |   3 +-
 net/ipv4/tcp_input.c                               |  22 +-
 net/ipv4/tcp_output.c                              |   6 +
 net/ipv6/addrconf.c                                |   6 +-
 net/rose/af_rose.c                                 |   4 +-
 net/sched/act_ct.c                                 |  34 +-
 net/vmw_vsock/virtio_transport_common.c            |   2 +-
 64 files changed, 1156 insertions(+), 589 deletions(-)

