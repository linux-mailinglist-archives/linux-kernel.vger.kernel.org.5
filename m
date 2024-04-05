Return-Path: <linux-kernel+bounces-133079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1CB899E83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F3F283064
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF6516D4FD;
	Fri,  5 Apr 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmKeQDbV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9516C68C;
	Fri,  5 Apr 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324354; cv=none; b=TBpehYoT2HaSHRZ+VbMX8GaELc1nbAYiUxQWwdsgcYmzir2qZsALOuVdxkCH+JowFIj0hyDsTNHSPmR6/EWeuxk6zwtuiapdlg2BKBVgTPnP8Ncj9VbW0k9jBIW3U8be2dY+d377B8JsK25atmHgl1+SPt1YKXcBTeQCSbQFejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324354; c=relaxed/simple;
	bh=yWQCwLrQZoT1UXlDqF5ZcZ98bGIprS17RgS9M+Wu8Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgpsY2BcDJbqJWQfURHGq5/5a0pYTnnhYN59MTHMF/WPEmuFUE+bpQyHPaL1I27UP3uUgYev+alNLmj3PgLmfSwbMJn1NEI3iOFdICpZn3ubjmsw7P964Xz06RuXV7V9VYxV1BZ7P5LU8+K8xKaEGz+a+qpEmkJ0PY0P403M1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmKeQDbV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712324352; x=1743860352;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yWQCwLrQZoT1UXlDqF5ZcZ98bGIprS17RgS9M+Wu8Ao=;
  b=NmKeQDbVdhhX7ztDcwyMi8iOor/qMU5J+fj/6jDhoLeVv4hlVpW55Hwy
   dMwz0K7v/AqSvFyrbLmfRxLVdTQ83slchihUmjXOiEGkfpOpah8b0FWH4
   /z1ju1RWbtbQYi9EFUTDG6GL/BLvBDQcfdUVIFFgBKXoTMAb7lcqcfwuP
   dJlvK+qj+QJU6BhryaC0LFxB1Ss0FsOrgtGHoarjCJGnpEnj+LhESM4zM
   vAQ7kV9OBXRgv7SLi03LwEcj2etFWeCZzztnPbaO4X0kK8Fx7UgZEPY0f
   Kob8DdDx3hJvBKtpkXDRiAi8xzkhpqIJpYf3TDyMbhpU2TUGbPWowRNaQ
   w==;
X-CSE-ConnectionGUID: 0WKEKhFLSbCqZMHMvASjMQ==
X-CSE-MsgGUID: mII/TiZlS92vA5iEKzs6jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18219537"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18219537"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:39:11 -0700
X-CSE-ConnectionGUID: qZoM6zepS5SkcnsKi+wIRg==
X-CSE-MsgGUID: QipjC6sjQiOBbzbx7MROuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19600077"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 06:39:09 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 0/7] netdev_features: start cleaning netdev_features_t up
Date: Fri,  5 Apr 2024 15:37:24 +0200
Message-ID: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETDEV_FEATURE_COUNT is currently 64, which means we can't add any new
features as netdev_features_t is u64.
As per several discussions, instead of converting netdev_features_t to
a bitmap, which would mean A LOT of changes, we can try cleaning up
netdev feature bits.
There's a bunch of bits which don't really mean features, rather device
attributes/properties that can't be changed via Ethtool in any of the
drivers. Such attributes can be moved to netdev private flags without
losing any functionality.
Start converting some read-only netdev features to private flags from
the ones that are most obvious, like lockless Tx, inability to change
network namespace etc. I was able to reduce NETDEV_FEATURE_COUNT from
64 to 58, which mean 6 free slots for new features. NETIF_F_NEVER_CHANGE
is gone, so ETHTOOL_A_FEATURES_NOCHANGE Netlink reply will always be 0.
I may've made some mistakes with feature inheriting and also some of
these are compile-tested only, so this is marked as RFC to discuss
the changes. There are obviously more read-only features to convert,
such as HSR (4 bits), this will be done in subsequent series.

Alexander Lobakin (7):
  netdev_features: remove unused __UNUSED_NETIF_F_1
  netdev_features: convert NETIF_F_LLTX to priv_flag IFF_LLTX
  netdevice: introduce IFF_LOGICAL as (IFF_NO_QUEUE | IFF_LLTX)
  netdev_features: convert NETIF_F_NETNS_LOCAL to IFF_NETNS_LOCAL
  netdev_features: convert NETIF_F_HIGHDMA to priv_flag IFF_HIGHDMA
  netdev_features: convert NETIF_F_VLAN_CHALLENGED to
    IFF_VLAN_CHALLENGED
  netdev_features: convert NETIF_F_FCOE_MTU to IFF_FCOE_MTU

 Documentation/driver-api/usb/dma.rst          |  2 +-
 Documentation/networking/ethtool-netlink.rst  |  2 +-
 Documentation/networking/netdev-features.rst  | 31 +-------------
 Documentation/networking/netdevices.rst       |  4 +-
 Documentation/networking/switchdev.rst        |  4 +-
 drivers/net/ethernet/tehuti/tehuti.h          |  2 +-
 include/linux/if_vlan.h                       |  5 +--
 include/linux/netdev_features.h               | 26 ++----------
 include/linux/netdevice.h                     | 31 ++++++++++++--
 include/net/mac80211.h                        |  1 +
 include/net/net_failover.h                    |  6 ++-
 net/mac80211/ieee80211_i.h                    |  4 +-
 drivers/firewire/net.c                        |  2 +-
 drivers/infiniband/hw/hfi1/vnic_main.c        |  3 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c     |  3 +-
 drivers/net/amt.c                             |  4 +-
 drivers/net/bareudp.c                         |  3 +-
 drivers/net/bonding/bond_main.c               | 42 +++++++++----------
 drivers/net/dummy.c                           |  4 +-
 drivers/net/ethernet/adaptec/starfire.c       |  2 +-
 drivers/net/ethernet/adi/adin1110.c           |  3 +-
 drivers/net/ethernet/aeroflex/greth.c         |  3 +-
 drivers/net/ethernet/alteon/acenic.c          |  2 +-
 drivers/net/ethernet/altera/altera_tse_main.c |  3 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  5 ++-
 drivers/net/ethernet/broadcom/bcmsysport.c    |  4 +-
 drivers/net/ethernet/broadcom/bnx2.c          |  2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  5 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  6 +--
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  4 +-
 drivers/net/ethernet/broadcom/tg3.c           |  2 +-
 drivers/net/ethernet/brocade/bna/bnad.c       |  9 ++--
 drivers/net/ethernet/calxeda/xgmac.c          |  4 +-
 .../net/ethernet/cavium/liquidio/lio_main.c   |  4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  4 +-
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c     |  3 +-
 .../net/ethernet/chelsio/cxgb3/cxgb3_main.c   |  4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_fcoe.c   |  6 +--
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  6 +--
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  6 +--
 drivers/net/ethernet/cisco/enic/enic_main.c   |  2 +-
 drivers/net/ethernet/emulex/benet/be_main.c   |  5 +--
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    |  6 +--
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  5 +--
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  4 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  3 +-
 drivers/net/ethernet/freescale/gianfar.c      |  3 +-
 .../ethernet/fungible/funeth/funeth_main.c    |  5 ++-
 drivers/net/ethernet/google/gve/gve_main.c    |  2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c |  4 +-
 .../net/ethernet/huawei/hinic/hinic_main.c    |  4 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c     |  6 +--
 drivers/net/ethernet/intel/e100.c             |  2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c |  6 +--
 drivers/net/ethernet/intel/e1000e/netdev.c    |  5 +--
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  6 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  5 ++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  5 ++-
 drivers/net/ethernet/intel/igb/igb_main.c     |  4 +-
 drivers/net/ethernet/intel/igbvf/netdev.c     |  3 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  4 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 12 +++---
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  4 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 +-
 drivers/net/ethernet/jme.c                    |  6 +--
 .../ethernet/marvell/prestera/prestera_main.c |  3 +-
 drivers/net/ethernet/marvell/skge.c           |  2 +-
 drivers/net/ethernet/marvell/sky2.c           |  2 +-
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  7 ++--
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  5 ++-
 .../net/ethernet/myricom/myri10ge/myri10ge.c  |  4 +-
 drivers/net/ethernet/natsemi/ns83820.c        |  4 +-
 drivers/net/ethernet/neterion/s2io.c          |  4 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  2 +-
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |  5 +--
 drivers/net/ethernet/nvidia/forcedeth.c       |  4 +-
 drivers/net/ethernet/pasemi/pasemi_mac.c      |  4 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 +-
 .../ethernet/qlogic/netxen/netxen_nic_main.c  |  6 +--
 drivers/net/ethernet/qlogic/qede/qede_main.c  |  6 +--
 drivers/net/ethernet/qlogic/qla3xxx.c         |  2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  6 +--
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  2 +-
 drivers/net/ethernet/realtek/8139cp.c         |  5 +--
 drivers/net/ethernet/realtek/8139too.c        |  3 +-
 drivers/net/ethernet/realtek/r8169_main.c     |  2 +-
 drivers/net/ethernet/rocker/rocker_main.c     |  3 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_main.c   |  4 +-
 drivers/net/ethernet/sfc/ef100_netdev.c       |  3 +-
 drivers/net/ethernet/sfc/ef100_nic.c          |  2 +-
 drivers/net/ethernet/sfc/ef100_rep.c          |  3 +-
 drivers/net/ethernet/sfc/efx.c                |  4 +-
 drivers/net/ethernet/sfc/falcon/efx.c         |  3 +-
 drivers/net/ethernet/sfc/siena/efx.c          |  4 +-
 drivers/net/ethernet/sgi/ioc3-eth.c           |  3 +-
 drivers/net/ethernet/silan/sc92031.c          |  4 +-
 drivers/net/ethernet/socionext/netsec.c       |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +-
 drivers/net/ethernet/sun/cassini.c            |  2 +-
 drivers/net/ethernet/sun/niu.c                |  2 +-
 drivers/net/ethernet/sun/sungem.c             |  2 +-
 drivers/net/ethernet/tehuti/tehuti.c          |  9 ++--
 drivers/net/ethernet/ti/cpsw_new.c            |  3 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c  |  3 +-
 drivers/net/ethernet/toshiba/spider_net.c     |  3 +-
 drivers/net/ethernet/tundra/tsi108_eth.c      |  2 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  2 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  2 +-
 drivers/net/ethernet/wiznet/w5100.c           |  2 +-
 drivers/net/ethernet/wiznet/w5300.c           |  2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c   |  2 -
 drivers/net/geneve.c                          |  3 +-
 drivers/net/gtp.c                             |  3 +-
 drivers/net/hamradio/bpqether.c               |  2 +-
 drivers/net/hyperv/netvsc_drv.c               |  4 +-
 drivers/net/ifb.c                             |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 13 +++---
 drivers/net/loopback.c                        |  8 ++--
 drivers/net/macsec.c                          |  6 +--
 drivers/net/macvlan.c                         | 12 +++---
 drivers/net/net_failover.c                    | 36 ++++++++--------
 drivers/net/netdevsim/netdev.c                |  6 +--
 drivers/net/netkit.c                          |  6 +--
 drivers/net/nlmon.c                           |  5 +--
 drivers/net/ntb_netdev.c                      |  3 +-
 drivers/net/ppp/ppp_generic.c                 |  2 +-
 drivers/net/rionet.c                          |  2 +-
 drivers/net/tap.c                             |  3 +-
 drivers/net/team/team_core.c                  | 27 ++++++------
 drivers/net/thunderbolt/main.c                |  3 +-
 drivers/net/tun.c                             |  5 ++-
 drivers/net/usb/r8152.c                       |  5 ++-
 drivers/net/veth.c                            |  6 +--
 drivers/net/virtio_net.c                      |  3 +-
 drivers/net/vmxnet3/vmxnet3_drv.c             |  3 +-
 drivers/net/vrf.c                             | 17 +++-----
 drivers/net/vsockmon.c                        |  5 +--
 drivers/net/vxlan/vxlan_core.c                |  3 +-
 drivers/net/wireguard/device.c                |  5 +--
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  6 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 ++-
 drivers/net/wwan/t7xx/t7xx_netdev.c           |  3 +-
 drivers/s390/net/qeth_l2_main.c               |  2 +-
 drivers/scsi/fcoe/fcoe.c                      |  4 +-
 drivers/staging/octeon/ethernet.c             |  2 +-
 drivers/usb/fotg210/fotg210-hcd.c             |  2 +-
 drivers/usb/host/ehci-hcd.c                   |  2 +-
 drivers/usb/host/oxu210hp-hcd.c               |  2 +-
 lib/test_bpf.c                                |  3 +-
 net/8021q/vlan.c                              |  2 +-
 net/8021q/vlan_dev.c                          |  8 ++--
 net/batman-adv/soft-interface.c               |  5 +--
 net/bridge/br_device.c                        |  9 ++--
 net/core/dev.c                                | 34 +++++++++++----
 net/core/net-sysfs.c                          |  3 +-
 net/dsa/user.c                                |  3 +-
 net/ethtool/common.c                          |  5 ---
 net/ethtool/features.c                        |  2 +-
 net/ethtool/ioctl.c                           |  3 +-
 net/hsr/hsr_device.c                          | 19 +++------
 net/ieee802154/6lowpan/core.c                 |  3 +-
 net/ieee802154/core.c                         | 10 ++---
 net/ipv4/ip_gre.c                             |  5 ++-
 net/ipv4/ip_tunnel.c                          |  2 +-
 net/ipv4/ip_vti.c                             |  2 +-
 net/ipv4/ipip.c                               |  3 +-
 net/ipv4/ipmr.c                               |  2 +-
 net/ipv6/ip6_gre.c                            |  8 ++--
 net/ipv6/ip6_tunnel.c                         |  5 +--
 net/ipv6/ip6mr.c                              |  2 +-
 net/ipv6/sit.c                                |  5 +--
 net/l2tp/l2tp_eth.c                           |  2 +-
 net/mac80211/iface.c                          |  2 +
 net/openvswitch/vport-internal_dev.c          | 12 +++---
 net/wireless/core.c                           | 10 ++---
 net/xfrm/xfrm_interface_core.c                |  2 +-
 tools/testing/selftests/net/forwarding/README |  2 +-
 184 files changed, 462 insertions(+), 498 deletions(-)

-- 
2.44.0


