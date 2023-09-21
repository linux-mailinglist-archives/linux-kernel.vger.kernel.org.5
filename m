Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE93B7A9B42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjIUS5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIUS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC650923AB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KuUb7/dHBSUvxxI26y7gow8oVuAu2ofMS9Ynj/UtmZI=;
        b=L2f+SeIVi3Z0iNwZbP95vSOfjev3TJ11ygjObB5OwoBXqoqNGx/60hjUisUDGoDmGOQJzu
        2AlNzA4KoYBLVlo2ux0ZtD+XvhIBMhxud4tE5+W08SaairRUPUt8P8l5oO4pQ2r6H+U7we
        uc/7IYUUwHrUXuVgVAbqIbSvgTv2aCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-ndf3Zp1iMNS1Bd4HEZl4tQ-1; Thu, 21 Sep 2023 07:31:32 -0400
X-MC-Unique: ndf3Zp1iMNS1Bd4HEZl4tQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99B71101A550;
        Thu, 21 Sep 2023 11:31:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65F88492C37;
        Thu, 21 Sep 2023 11:31:30 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for 6.6-rc3
Date:   Thu, 21 Sep 2023 13:31:17 +0200
Message-ID: <20230921113117.42035-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit 9fdfb15a3dbf818e06be514f4abbfc071004cbe7:

  Merge tag 'net-6.6-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-09-14 10:03:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc3

for you to fetch changes up to ecf4392600dd86fce54445b67a0e2995bf96ba51:

  Merge tag 'nf-23-09-20' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2023-09-21 11:09:45 +0200)

----------------------------------------------------------------
Networking fixes for 6.6-rc2, including fixes from netfilter and bpf

Current release - regressions:

 - bpf: adjust size_index according to the value of KMALLOC_MIN_SIZE

 - netfilter: fix entries val in rule reset audit log

 - eth: stmmac: fix incorrect rxq|txq_stats reference

Previous releases - regressions:

 - ipv4: fix null-deref in ipv4_link_failure

 - netfilter:
   - fix several GC related issues
   - fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

 - eth: team: fix null-ptr-deref when team device type is changed

 - eth: i40e: fix VF VLAN offloading when port VLAN is configured

 - eth: ionic: fix 16bit math issue when PAGE_SIZE >= 64KB

Previous releases - always broken:

 - core: fix ETH_P_1588 flow dissector

 - mptcp: fix several connection hang-up conditions

 - bpf:
   - avoid deadlock when using queue and stack maps from NMI
   - add override check to kprobe multi link attach

 - hsr: properly parse HSRv1 supervisor frames.

 - eth: igc: fix infinite initialization loop with early XDP redirect

 - eth: octeon_ep: fix tx dma unmap len values in SG

 - eth: hns3: fix GRE checksum offload issue

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'fix-the-unmatched-unit_size-of-bpf_mem_cache'

Andrii Nakryiko (1):
      selftests/bpf: ensure all CI arches set CONFIG_BPF_KPROBE_OVERRIDE=y

Andy Shevchenko (1):
      net: core: Use the bitmap API to allocate bitmaps

Arnd Bergmann (1):
      net: ti: icssg-prueth: add PTP dependency

Artem Chernyshev (1):
      net: rds: Fix possible NULL-pointer dereference

Artem Savkov (1):
      selftests/bpf: fix unpriv_disabled check in test_verifier

Benjamin Poirier (1):
      vxlan: Add missing entries to vxlan_get_size()

Cai Huoqing (1):
      net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'

Christophe JAILLET (1):
      bpf: Fix a erroneous check after snprintf()

David Christensen (1):
      ionic: fix 16bit math issue when PAGE_SIZE >= 64KB

David S. Miller (8):
      Merge branch 'sparx5-leaks'
      Merge tag 'nf-23-09-13' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net- queue
      Merge branch 'hsr-supervisor-frames'
      Merge branch 'tsnep-napi-fixes'
      Merge branch 'mptcp-stalled-connections-fix'
      Merge branch 'ax25-project-links'

Eduard Zingerman (2):
      bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
      selftests/bpf: Offloaded prog after non-offloaded should not cause BUG

Edward Cree (1):
      sfc: handle error pointers returned by rhashtable_lookup_get_insert_fast()

Eric Dumazet (3):
      scsi: iscsi_tcp: restrict to TCP sockets
      dccp: fix dccp_v4_err()/dccp_v6_err() again
      net: bridge: use DEV_STATS_INC()

Florian Westphal (3):
      netfilter: conntrack: fix extension size table
      netfilter: nf_tables: disable toggling dormant table state more than once
      netfilter: nf_tables: fix memleak when more than 255 elements expired

Gerhard Engleder (3):
      tsnep: Fix NAPI scheduling
      tsnep: Fix ethtool channels
      tsnep: Fix NAPI polling with budget 0

Hou Tao (5):
      bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
      bpf: Don't prefill for unused bpf_mem_cache
      bpf: Ensure unit_size is matched with slab cache object size
      selftests/bpf: Test all valid alloc sizes for bpf mem allocator
      bpf: Skip unit_size checking for global per-cpu allocator

Ilya Leoshkevich (1):
      netfilter, bpf: Adjust timeouts of non-confirmed CTs in bpf_ct_insert_entry()

Ivan Vecera (1):
      i40e: Fix VF VLAN offloading when port VLAN is configured

Jian Shen (1):
      net: hns3: only enable unicast promisc when mac table full

Jie Wang (3):
      net: hns3: add cmdq check for vf periodic service task
      net: hns3: fix GRE checksum offload issue
      net: hns3: add 5ms delay before clear firmware reset irq source

Jijie Shao (1):
      net: hns3: fix fail to delete tc flower rules during reset issue

Jinjie Ruan (6):
      net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_keyvalue_test()
      net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_actionvalue_test()
      net: microchip: sparx5: Fix possible memory leak in vcap_api_encode_rule_test()
      net: microchip: sparx5: Fix possible memory leaks in test_vcap_xn_rule_creator()
      net: microchip: sparx5: Fix possible memory leaks in vcap_api_kunit
      net/handshake: Fix memory leak in __sock_create() and sock_alloc_file()

Jiri Olsa (5):
      bpf: Add override check to kprobe multi link attach
      selftests/bpf: Add kprobe_multi override test
      selftests/bpf: Fix kprobe_multi_test/attach_override test
      bpf: Fix uprobe_multi get_pid_task error path
      bpf: Fix BTF_ID symbol generation collision

Jisheng Zhang (1):
      net: stmmac: fix incorrect rxq|txq_stats reference

Johnathan Mantey (1):
      ncsi: Propagate carrier gain/loss events to the NCSI controller

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Lukasz Majewski (1):
      net: hsr: Properly parse HSRv1 supervisor frames.

Martin KaFai Lau (1):
      Merge branch 'Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init'

Mika Westerberg (1):
      net: thunderbolt: Fix TCPv6 GSO checksum calculation

Muhammad Husaini Zulkifli (1):
      igc: Expose tx-usecs coalesce setting to user

Nick Desaulniers (1):
      bpf: Fix BTF_ID symbol generation collision in tools/

Pablo Neira Ayuso (6):
      netfilter: nf_tables: disallow rule removal from chain binding
      netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
      netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC
      netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
      netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
      netfilter: nf_tables: disallow element removal on anonymous sets

Paolo Abeni (8):
      mptcp: fix bogus receive window shrinkage with multiple subflows
      mptcp: move __mptcp_error_report in protocol.c
      mptcp: process pending subflow error on close
      mptcp: rename timer related helper to less confusing names
      mptcp: fix dangling connection hang-up
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge branch 'add-missing-xdp_do_flush-invocations'
      Merge tag 'nf-23-09-20' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Peter Lafreniere (3):
      Documentation: netdev: fix dead link in ax25.rst
      MAINTAINERS: Update link for linux-ax25.org
      ax25: Kconfig: Update link for linux-ax25.org

Petr Oros (2):
      iavf: add iavf_schedule_aq_request() helper
      iavf: schedule a request immediately after add/delete vlan

Phil Sutter (2):
      netfilter: nf_tables: Fix entries val in rule reset audit log
      selftests: netfilter: Test nf_tables audit logging

Radoslaw Tyl (1):
      iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set

Randy Dunlap (1):
      bpf, cgroup: fix multiple kernel-doc warnings

Sabrina Dubroca (1):
      selftests: tls: swap the TX and RX sockets in some tests

Sasha Neftin (1):
      net/core: Fix ETH_P_1588 flow dissector

Sebastian Andrzej Siewior (7):
      net: hsr: Add __packed to struct hsr_sup_tlv.
      selftests: hsr: Use `let' properly.
      selftests: hsr: Reorder the testsuite.
      selftests: hsr: Extend the testsuite to also cover HSRv1.
      net: ena: Flush XDP packets on error.
      bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
      octeontx2-pf: Do xdp_do_flush() after redirects.

Shinas Rasheed (1):
      octeon_ep: fix tx dma unmap len values in SG

Stanislav Fomichev (2):
      bpf: Clarify error expectations from bpf_clone_redirect
      selftests/bpf: Update bpf_clone_redirect expected return code

Toke Høiland-Jørgensen (1):
      bpf: Avoid deadlock when using queue and stack maps from NMI

Vinicius Costa Gomes (1):
      igc: Fix infinite initialization loop with early XDP redirect

Ziyang Xuan (1):
      team: fix null-ptr-deref when team device type is changed

 Documentation/networking/ax25.rst                  |   4 +-
 MAINTAINERS                                        |   6 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |   6 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |  18 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   9 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  13 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   3 +-
 drivers/net/ethernet/huawei/hinic/hinic_port.c     |   3 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   8 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  17 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  31 ++-
 drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |   8 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c  |   8 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h  |  16 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  19 +-
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |  59 ++++-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  10 +-
 drivers/net/ethernet/sfc/tc.c                      |  21 +-
 drivers/net/ethernet/sfc/tc_conntrack.c            |   7 +-
 drivers/net/ethernet/sfc/tc_counters.c             |   2 +
 drivers/net/ethernet/sfc/tc_encap_actions.c        |   4 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |   7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  16 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  16 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |  16 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  16 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 -
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  32 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 125 +++++-----
 drivers/net/ethernet/ti/Kconfig                    |   1 +
 drivers/net/team/team.c                            |  10 +-
 drivers/net/thunderbolt/main.c                     |   3 +-
 drivers/net/vxlan/vxlan_core.c                     |   4 +
 drivers/scsi/iscsi_tcp.c                           |   4 +
 include/linux/btf_ids.h                            |   2 +-
 include/linux/if_team.h                            |   2 +
 include/net/netfilter/nf_tables.h                  |   7 +-
 include/uapi/linux/bpf.h                           |   4 +-
 kernel/bpf/btf.c                                   |   2 +-
 kernel/bpf/cgroup.c                                |  13 +-
 kernel/bpf/memalloc.c                              |  94 +++++++-
 kernel/bpf/offload.c                               |  12 +-
 kernel/bpf/queue_stack_maps.c                      |  21 +-
 kernel/trace/bpf_trace.c                           |  20 +-
 net/ax25/Kconfig                                   |  16 +-
 net/bridge/br_forward.c                            |   4 +-
 net/bridge/br_input.c                              |   4 +-
 net/core/dev.c                                     |   6 +-
 net/core/flow_dissector.c                          |   2 +-
 net/dccp/ipv4.c                                    |   9 +-
 net/dccp/ipv6.c                                    |   9 +-
 net/handshake/handshake-test.c                     |  14 +-
 net/hsr/hsr_framereg.c                             |   4 +-
 net/hsr/hsr_main.h                                 |   2 +-
 net/ipv4/route.c                                   |   4 +-
 net/mptcp/options.c                                |   5 +-
 net/mptcp/protocol.c                               | 165 ++++++++-----
 net/mptcp/protocol.h                               |  24 +-
 net/mptcp/subflow.c                                |  39 +--
 net/ncsi/ncsi-aen.c                                |   5 +
 net/netfilter/ipset/ip_set_core.c                  |  12 +-
 net/netfilter/nf_conntrack_bpf.c                   |   2 +
 net/netfilter/nf_conntrack_extend.c                |   4 +-
 net/netfilter/nf_tables_api.c                      |  79 ++++--
 net/netfilter/nft_set_hash.c                       |  11 +-
 net/netfilter/nft_set_pipapo.c                     |   4 +-
 net/netfilter/nft_set_rbtree.c                     |   8 +-
 net/rds/rdma_transport.c                           |  12 +-
 tools/include/linux/btf_ids.h                      |   2 +-
 tools/include/uapi/linux/bpf.h                     |   4 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |  10 +-
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/config.x86_64          |   1 -
 tools/testing/selftests/bpf/prog_tests/empty_skb.c |  12 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  37 +++
 .../testing/selftests/bpf/prog_tests/test_bpf_ma.c |  50 ++++
 .../selftests/bpf/prog_tests/xdp_dev_bound_only.c  |  61 +++++
 .../selftests/bpf/progs/kprobe_multi_override.c    |  13 +
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    | 123 ++++++++++
 tools/testing/selftests/bpf/test_verifier.c        |   2 +-
 tools/testing/selftests/net/hsr/hsr_ping.sh        | 266 +++++++++++----------
 tools/testing/selftests/net/tls.c                  |   8 +-
 tools/testing/selftests/netfilter/.gitignore       |   1 +
 tools/testing/selftests/netfilter/Makefile         |   4 +-
 tools/testing/selftests/netfilter/audit_logread.c  | 165 +++++++++++++
 tools/testing/selftests/netfilter/config           |   1 +
 tools/testing/selftests/netfilter/nft_audit.sh     | 108 +++++++++
 93 files changed, 1489 insertions(+), 540 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_override.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_ma.c
 create mode 100644 tools/testing/selftests/netfilter/audit_logread.c
 create mode 100755 tools/testing/selftests/netfilter/nft_audit.sh

