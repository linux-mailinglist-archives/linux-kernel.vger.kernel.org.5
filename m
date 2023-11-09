Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332537E7328
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 22:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbjKIVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 16:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjKIVAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 16:00:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE13C07
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 13:00:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED92CC433C8;
        Thu,  9 Nov 2023 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699563614;
        bh=oIh278dcWNjBT0LI/g+XCy7IbgEEDqp4JdWUWTmbWyM=;
        h=From:To:Cc:Subject:Date:From;
        b=fD1hWpg9Jf42SkxaJPNzhHeq4FGL9+qkMsKrdtqJZPeEUUtBAtOvweKDNpHah4RrF
         3eWqAzUGMr3EFjeixz0j6/nMEeShOKFBh6u7MXw3o1kL3LQVZOn6gRgQurMQfi6poF
         Qz3kswyUzecij9Imt691R+vLP/+qu3DSx1G0tePeGcWK2PHXQGism7MfsTa38MGKOR
         luMpvwVV/y+TvnUV+ebI00RkvQIMeofwAa3fiz2BOnnpHtdY70edcrYJUONzHkHOhJ
         rjV04c9hefQbZEHRtzxVD7FiplrAdWUuOxRG2T8N7MBJrBahzbiQw3i0EJYYsTfmSt
         pvI7/XIvj6CjQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.7-rc1
Date:   Thu,  9 Nov 2023 13:00:13 -0800
Message-ID: <20231109210013.1276858-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit ff269e2cd5adce4ae14f883fc9c8803bc43ee1e9:

  Merge tag 'net-next-6.7-followup' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-11-01 16:33:20 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc1

for you to fetch changes up to 83b9dda8afa4e968d9cce253f390b01c0612a2a5:

  net: ti: icss-iep: fix setting counter value (2023-11-09 13:15:40 +0100)

----------------------------------------------------------------
Including fixes from netfilter and bpf.

Current release - regressions:

 - sched: fix SKB_NOT_DROPPED_YET splat under debug config

Current release - new code bugs:

 - tcp: fix usec timestamps with TCP fastopen

 - tcp_sigpool: fix some off by one bugs

 - tcp: fix possible out-of-bounds reads in tcp_hash_fail()

 - tcp: fix SYN option room calculation for TCP-AO

 - bpf: fix compilation error without CGROUPS

 - ptp:
   - ptp_read() should not release queue
   - fix tsevqs corruption

Previous releases - regressions:

 - llc: verify mac len before reading mac header

Previous releases - always broken:

 - bpf:
   - fix check_stack_write_fixed_off() to correctly spill imm
   - fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
   - check map->usercnt after timer->timer is assigned

 - dsa: lan9303: consequently nested-lock physical MDIO

 - dccp/tcp: call security_inet_conn_request() after setting IP addr

 - tg3: fix the TX ring stall due to incorrect full ring handling

 - phylink: initialize carrier state at creation

 - ice: fix direction of VF rules in switchdev mode

Misc:

 - fill in a bunch of missing MODULE_DESCRIPTION()s, more to come

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alex Pakhunov (1):
      tg3: Fix the TX ring stall

Alexander Sverdlin (1):
      net: dsa: lan9303: consequently nested-lock physical MDIO

Alexei Starovoitov (3):
      Merge branch 'bpf-fix-incorrect-immediate-spill'
      Merge branch 'relax-allowlist-for-open-coded-css_task-iter'
      Merge branch 'bpf-fix-precision-tracking-for-bpf_alu-bpf_to_be-bpf_end'

Andrew Lunn (3):
      net: phy: fill in missing MODULE_DESCRIPTION()s
      net: mdio: fill in missing MODULE_DESCRIPTION()s
      net: ethtool: Fix documentation of ethtool_sprintf()

Andrii Nakryiko (1):
      selftests/bpf: fix test_maps' use of bpf_map_create_opts

Aniruddha Paul (1):
      ice: Fix VF-VF filter rules in switchdev mode

Björn Töpel (1):
      selftests/bpf: Fix broken build where char is unsigned

Chuyi Zhou (5):
      bpf: Relax allowlist for css_task iter
      selftests/bpf: Add tests for css_task iter combining with cgroup iter
      selftests/bpf: Add test for using css_task iter in sleepable progs
      bpf: Let verifier consider {task,cgroup} is trusted in bpf_iter_reg
      selftests/bpf: get trusted cgrp from bpf_iter__cgroup directly

D. Wythe (3):
      net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
      net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
      net/smc: put sk reference if close work was canceled

Dan Carpenter (2):
      hsr: Prevent use after free in prp_create_tagged_frame()
      net/tcp_sigpool: Fix some off by one bugs

Dave Ertman (1):
      ice: Fix SRIOV LAG disable on non-compliant aggregate

Dave Marchevsky (2):
      bpf: Add __bpf_kfunc_{start,end}_defs macros
      bpf: Add __bpf_hook_{start,end} macros

David Howells (1):
      rxrpc: Fix two connection reaping bugs

David S. Miller (2):
      Merge branch 'smc-fixes'
      Merge branch 'vsock-fixes'

Diogo Ivo (1):
      net: ti: icss-iep: fix setting counter value

Edward Adam Davis (2):
      ptp: ptp_read should not release queue
      ptp: fix corrupted list in ptp_open

Eric Dumazet (5):
      inet: shrink struct flowi_common
      tcp: fix fastopen code vs usec TS
      net/tcp: fix possible out-of-bounds reads in tcp_hash_fail()
      idpf: fix potential use-after-free in idpf_tso()
      net_sched: sch_fq: better validate TCA_FQ_WEIGHTS and TCA_FQ_PRIOMAP

Filippo Storniolo (4):
      vsock/virtio: remove socket from connected/bound list on shutdown
      test/vsock fix: add missing check on socket creation
      test/vsock: refactor vsock_accept
      test/vsock: add dobule bind connect test

Florian Westphal (3):
      netfilter: add missing module descriptions
      ipvs: add missing module descriptions
      netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses

Furong Xu (1):
      net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs

Geetha sowjanya (1):
      octeontx2-pf: Free pending and dropped SQEs

George Shuklin (1):
      tg3: power down device only on SYSTEM_POWER_OFF

Gerd Bayer (1):
      net/smc: fix documentation of buffer sizes

Hangbin Liu (1):
      selftests: pmtu.sh: fix result checking

Hao Sun (2):
      bpf: Fix check_stack_write_fixed_off() to correctly spill imm
      selftests/bpf: Add test for immediate spilled to stack

Heiner Kallweit (1):
      r8169: respect userspace disabling IFF_MULTICAST

Hou Tao (1):
      bpf: Check map->usercnt after timer->timer is assigned

Ivan Vecera (2):
      i40e: Do not call devlink_port_type_clear()
      i40e: Fix devlink port unregistering

Jakub Kicinski (10):
      Merge branch 'net-sched-fill-in-missing-module_descriptions-for-net-sched'
      Merge branch 'add-missing-module_descriptions'
      tools: ynl-gen: don't touch the output file if content is the same
      netlink: fill in missing MODULE_DESCRIPTION()
      nfsd: regenerate user space parsers after ynl-gen changes
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'nf-23-11-08' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      net: kcm: fill in MODULE_DESCRIPTION()
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jamal Hadi Salim (1):
      net, sched: Fix SKB_NOT_DROPPED_YET splat under debug config

Jian Shen (1):
      net: page_pool: add missing free_percpu when page_pool_init fail

Jiri Pirko (1):
      netlink: specs: devlink: add forgotten port function caps enum values

Klaus Kudielka (1):
      net: phylink: initialize carrier state at creation

Kuan-Wei Chiu (1):
      s390/qeth: Fix typo 'weed' in comment

Kuniyuki Iwashima (3):
      dccp: Call security_inet_conn_request() after setting IPv4 addresses.
      dccp/tcp: Call security_inet_conn_request() after setting IPv6 addresses.
      tcp: Fix SYN option room calculation for TCP-AO.

Linus Walleij (1):
      net: xscale: Drop unused PHY number

Maciej Żenczykowski (1):
      netfilter: xt_recent: fix (increase) ipv6 literal buffer length

Manu Bretelle (1):
      selftests/bpf: fix test_bpffs

Marcin Szycik (1):
      ice: Fix VF-VF direction matching in drop rule in switchdev

Martin KaFai Lau (1):
      Merge branch 'Let BPF verifier consider {task,cgroup} is trusted in bpf_iter_reg'

Matthieu Baerts (1):
      bpf: fix compilation error without CGROUPS

Michal Schmidt (1):
      ice: lag: in RCU, use atomic allocation

Nathan Chancellor (1):
      tcp: Fix -Wc23-extensions in tcp_options_write()

NeilBrown (1):
      Fix termination state for idr_for_each_entry_ul()

Pablo Neira Ayuso (1):
      netfilter: nf_tables: remove catchall element in GC sync path

Paolo Abeni (1):
      Merge branch 'dccp-tcp-relocate-security_inet_conn_request'

Patrick Thompson (1):
      net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Philipp Stanner (1):
      drivers/net/ppp: use standard array-copy-function

Ratheesh Kannoth (2):
      octeontx2-pf: Fix error codes
      octeontx2-pf: Fix holes in error code

Ronald Wahl (1):
      net: ethernet: ti: am65-cpsw: rx_pause/tx_pause controls wrong direction

Shigeru Yoshida (2):
      tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING
      virtio/vsock: Fix uninit-value in virtio_transport_recv_pkt()

Shung-Hsi Yu (2):
      bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
      selftests/bpf: precision tracking test for BPF_NEG and BPF_END

Victor Nogueira (3):
      net: sched: Fill in MODULE_DESCRIPTION for act_gate
      net: sched: Fill in missing MODULE_DESCRIPTION for classifiers
      net: sched: Fill in missing MODULE_DESCRIPTION for qdiscs

Vlad Buslov (1):
      net/sched: act_ct: Always fill offloading tuple iifidx

Vladimir Oltean (1):
      net: enetc: shorten enetc_setup_xdp_prog() error message to fit NETLINK_MAX_FMTMSG_LEN

Willem de Bruijn (1):
      llc: verify mac len before reading mac header

 Documentation/bpf/kfuncs.rst                       |   6 +-
 Documentation/netlink/specs/devlink.yaml           |   4 +
 Documentation/networking/smc-sysctl.rst            |   6 +-
 drivers/net/dsa/lan9303_mdio.c                     |   4 +-
 drivers/net/ethernet/broadcom/tg3.c                |  56 +++++++---
 drivers/net/ethernet/freescale/enetc/enetc.c       |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_devlink.c     |   1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  10 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |  18 ++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        | 114 +++++++++++++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  15 +--
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  81 ++++++++------
 .../ethernet/marvell/octeontx2/nic/otx2_struct.h   |  34 +++---
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  42 ++++++++
 drivers/net/ethernet/realtek/r8169_main.c          |   6 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   2 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  14 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   4 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c           |   2 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |   3 +-
 drivers/net/mdio/acpi_mdio.c                       |   1 +
 drivers/net/mdio/fwnode_mdio.c                     |   1 +
 drivers/net/mdio/mdio-aspeed.c                     |   1 +
 drivers/net/mdio/mdio-bitbang.c                    |   1 +
 drivers/net/mdio/of_mdio.c                         |   1 +
 drivers/net/phy/bcm-phy-ptp.c                      |   1 +
 drivers/net/phy/bcm87xx.c                          |   1 +
 drivers/net/phy/phylink.c                          |   2 +
 drivers/net/phy/sfp.c                              |   1 +
 drivers/net/ppp/ppp_generic.c                      |   4 +-
 drivers/ptp/ptp_chardev.c                          |  23 ++--
 drivers/ptp/ptp_clock.c                            |   8 +-
 drivers/ptp/ptp_private.h                          |   1 +
 drivers/s390/net/qeth_core_main.c                  |   2 +-
 include/linux/btf.h                                |  11 ++
 include/linux/ethtool.h                            |   4 +-
 include/linux/idr.h                                |   6 +-
 include/linux/tcp.h                                |   2 +-
 include/net/flow.h                                 |   2 +-
 include/net/netfilter/nf_conntrack_act_ct.h        |  34 +++---
 include/net/tcp_ao.h                               |  13 +--
 include/uapi/linux/nfsd_netlink.h                  |   6 +-
 kernel/bpf/bpf_iter.c                              |   6 +-
 kernel/bpf/cgroup_iter.c                           |   8 +-
 kernel/bpf/cpumask.c                               |   6 +-
 kernel/bpf/helpers.c                               |  39 ++++---
 kernel/bpf/map_iter.c                              |   6 +-
 kernel/bpf/task_iter.c                             |  24 ++---
 kernel/bpf/verifier.c                              |  33 ++++--
 kernel/cgroup/rstat.c                              |   9 +-
 kernel/trace/bpf_trace.c                           |   6 +-
 net/bpf/test_run.c                                 |   7 +-
 net/bridge/netfilter/ebtable_broute.c              |   1 +
 net/bridge/netfilter/ebtable_filter.c              |   1 +
 net/bridge/netfilter/ebtable_nat.c                 |   1 +
 net/bridge/netfilter/ebtables.c                    |   1 +
 net/bridge/netfilter/nf_conntrack_bridge.c         |   1 +
 net/core/filter.c                                  |  13 +--
 net/core/page_pool.c                               |   6 +-
 net/core/xdp.c                                     |   6 +-
 net/dccp/ipv4.c                                    |   6 +-
 net/dccp/ipv6.c                                    |   6 +-
 net/devlink/netlink_gen.c                          |   2 +-
 net/hsr/hsr_forward.c                              |   4 +-
 net/ipv4/fou_bpf.c                                 |   6 +-
 net/ipv4/netfilter/iptable_nat.c                   |   1 +
 net/ipv4/netfilter/iptable_raw.c                   |   1 +
 net/ipv4/netfilter/nf_defrag_ipv4.c                |   1 +
 net/ipv4/netfilter/nf_reject_ipv4.c                |   1 +
 net/ipv4/syncookies.c                              |   2 +-
 net/ipv4/tcp_ao.c                                  |   5 +-
 net/ipv4/tcp_input.c                               |   7 +-
 net/ipv4/tcp_output.c                              |  72 +++++++------
 net/ipv4/tcp_sigpool.c                             |   8 +-
 net/ipv6/netfilter/ip6table_nat.c                  |   1 +
 net/ipv6/netfilter/ip6table_raw.c                  |   1 +
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c          |   1 +
 net/ipv6/netfilter/nf_reject_ipv6.c                |   1 +
 net/ipv6/syncookies.c                              |   7 +-
 net/kcm/kcmsock.c                                  |   1 +
 net/llc/llc_input.c                                |  10 +-
 net/llc/llc_s_ac.c                                 |   3 +
 net/llc/llc_station.c                              |   3 +
 net/netfilter/ipvs/ip_vs_core.c                    |   1 +
 net/netfilter/ipvs/ip_vs_dh.c                      |   1 +
 net/netfilter/ipvs/ip_vs_fo.c                      |   1 +
 net/netfilter/ipvs/ip_vs_ftp.c                     |   1 +
 net/netfilter/ipvs/ip_vs_lblc.c                    |   1 +
 net/netfilter/ipvs/ip_vs_lblcr.c                   |   1 +
 net/netfilter/ipvs/ip_vs_lc.c                      |   1 +
 net/netfilter/ipvs/ip_vs_nq.c                      |   1 +
 net/netfilter/ipvs/ip_vs_ovf.c                     |   1 +
 net/netfilter/ipvs/ip_vs_pe_sip.c                  |   1 +
 net/netfilter/ipvs/ip_vs_rr.c                      |   1 +
 net/netfilter/ipvs/ip_vs_sed.c                     |   1 +
 net/netfilter/ipvs/ip_vs_sh.c                      |   1 +
 net/netfilter/ipvs/ip_vs_twos.c                    |   1 +
 net/netfilter/ipvs/ip_vs_wlc.c                     |   1 +
 net/netfilter/ipvs/ip_vs_wrr.c                     |   1 +
 net/netfilter/nf_conntrack_bpf.c                   |   6 +-
 net/netfilter/nf_conntrack_broadcast.c             |   1 +
 net/netfilter/nf_conntrack_netlink.c               |   1 +
 net/netfilter/nf_conntrack_proto.c                 |   1 +
 net/netfilter/nf_nat_bpf.c                         |   6 +-
 net/netfilter/nf_nat_core.c                        |   1 +
 net/netfilter/nf_nat_redirect.c                    |  27 ++++-
 net/netfilter/nf_tables_api.c                      |  23 +++-
 net/netfilter/nfnetlink_osf.c                      |   1 +
 net/netfilter/nft_chain_nat.c                      |   1 +
 net/netfilter/nft_fib.c                            |   1 +
 net/netfilter/nft_fwd_netdev.c                     |   1 +
 net/netfilter/xt_recent.c                          |   2 +-
 net/netlink/diag.c                                 |   1 +
 net/openvswitch/conntrack.c                        |   2 +-
 net/rxrpc/conn_object.c                            |   2 +-
 net/rxrpc/local_object.c                           |   2 +-
 net/sched/act_api.c                                |   2 +-
 net/sched/act_ct.c                                 |  15 ++-
 net/sched/act_gate.c                               |   1 +
 net/sched/cls_api.c                                |   9 +-
 net/sched/cls_basic.c                              |   1 +
 net/sched/cls_cgroup.c                             |   1 +
 net/sched/cls_fw.c                                 |   1 +
 net/sched/cls_route.c                              |   1 +
 net/sched/cls_u32.c                                |   1 +
 net/sched/sch_cbs.c                                |   1 +
 net/sched/sch_choke.c                              |   1 +
 net/sched/sch_drr.c                                |   1 +
 net/sched/sch_etf.c                                |   1 +
 net/sched/sch_ets.c                                |   1 +
 net/sched/sch_fifo.c                               |   1 +
 net/sched/sch_fq.c                                 |  10 +-
 net/sched/sch_gred.c                               |   1 +
 net/sched/sch_hfsc.c                               |   1 +
 net/sched/sch_htb.c                                |   1 +
 net/sched/sch_ingress.c                            |   1 +
 net/sched/sch_mqprio.c                             |   1 +
 net/sched/sch_mqprio_lib.c                         |   1 +
 net/sched/sch_multiq.c                             |   1 +
 net/sched/sch_netem.c                              |   1 +
 net/sched/sch_plug.c                               |   1 +
 net/sched/sch_prio.c                               |   1 +
 net/sched/sch_qfq.c                                |   1 +
 net/sched/sch_red.c                                |   1 +
 net/sched/sch_sfq.c                                |   1 +
 net/sched/sch_skbprio.c                            |   1 +
 net/sched/sch_taprio.c                             |   1 +
 net/sched/sch_tbf.c                                |   1 +
 net/sched/sch_teql.c                               |   1 +
 net/smc/af_smc.c                                   |   4 +-
 net/smc/smc.h                                      |   5 +
 net/smc/smc_cdc.c                                  |  11 +-
 net/smc/smc_close.c                                |   5 +-
 net/socket.c                                       |   8 +-
 net/tipc/netlink.c                                 |   4 +-
 net/vmw_vsock/virtio_transport_common.c            |  18 +++-
 net/xfrm/xfrm_interface_bpf.c                      |   6 +-
 tools/net/ynl/generated/devlink-user.c             |   2 +
 tools/net/ynl/generated/nfsd-user.c                | 120 +++++++++++++++++++--
 tools/net/ynl/generated/nfsd-user.h                |  44 +++++++-
 tools/net/ynl/ynl-gen-c.py                         |   7 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   6 +-
 .../selftests/bpf/map_tests/map_percpu_stats.c     |  20 +---
 .../testing/selftests/bpf/prog_tests/cgroup_iter.c |  33 ++++++
 tools/testing/selftests/bpf/prog_tests/iters.c     |   1 +
 .../testing/selftests/bpf/prog_tests/test_bpffs.c  |  11 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/iters_css_task.c |  55 ++++++++++
 .../selftests/bpf/progs/iters_task_failure.c       |   4 +-
 .../selftests/bpf/progs/verifier_precision.c       |  93 ++++++++++++++++
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c  |  32 ++++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   2 +-
 tools/testing/selftests/net/pmtu.sh                |   2 +-
 tools/testing/vsock/util.c                         |  87 ++++++++++++---
 tools/testing/vsock/util.h                         |   3 +
 tools/testing/vsock/vsock_test.c                   |  50 +++++++++
 178 files changed, 1242 insertions(+), 434 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_precision.c
