Return-Path: <linux-kernel+bounces-149863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F88A96F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0704CB21B43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15A515B57A;
	Thu, 18 Apr 2024 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVkuPUpN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BBC15B544;
	Thu, 18 Apr 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434658; cv=none; b=FrolOt4MNWlxmBb+Vxp3HyFCBT2P3rwOgBeRJlQouG5jG+6EUfFO3tMFqaB16Pjza+9zL6ZPZN+aNMRc3Rn/vQoSnv7/hI+w9N7m8nVw3w/Ov5VUR486YiNkdlal6Pibv4DI+ph3ZTPwDG6Hh9ATIiDVQHf0TeSPIaBV+DfbK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434658; c=relaxed/simple;
	bh=UEzTGUe3r7acXf8Yb95hdOs5Y9KDHJwibjjQOPb+gas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDXHor6GZHg6mmbPdI2bprzrh/IdP4q5wwBiEpCigN/tA/Zpnkad5nqAOy/aortSUuBDnHPIduNbRgFuuG7rEfBqk9YNz4XPG/lcADtzoHdtGoQDoyb+yUtnbZqfkr24Xq3iDVQsOXwnJbLV2TA6cmDEel9fvbqbrDPR2GN+kzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVkuPUpN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713434653; x=1744970653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UEzTGUe3r7acXf8Yb95hdOs5Y9KDHJwibjjQOPb+gas=;
  b=LVkuPUpNYT2xUAeIlVikpoce329jAnF4TDNjV1B5dZGhdv1gK2hKkOSu
   OaTNQ+2IQ4xpYFB0kcULOzIje3BEO+r6UdXX2BUMocm0B4oI4LL/bTYvC
   q6gYwQkhDC28NxG8LIHZ51lY7Cw/p1C6IKFensfm7HTJYUyajWYmbTh/1
   ZxelC7euLWHdo9rAL+OCw9S9kXWSYid9wKoBsU3PCHn7k8IKk5s0mZ30D
   cyg5K1qQIn3ZJsjdva4HGlw8zN7nTmj4M1WeLBWBDKuTowJtgxA6IVAYu
   93f8ruPZH1BSLr4MvFE9I6uxHhtjVWIsiTtLyu0zrPiWXk/OjFIdF5LP1
   g==;
X-CSE-ConnectionGUID: DBdKB6/ER7umBdmJ4uK/XQ==
X-CSE-MsgGUID: 9DA3FWoZQxeLomiNoDbB0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20363843"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="20363843"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 03:04:12 -0700
X-CSE-ConnectionGUID: OtIt6GRRTfmFqIAOWqajgw==
X-CSE-MsgGUID: gyZzpVE1TD2D6MPpBuOEIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27367309"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 18 Apr 2024 03:04:08 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 927D428169;
	Thu, 18 Apr 2024 11:04:06 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	alan.brady@intel.com,
	maciej.fijalkowski@intel.com,
	jesse.brandeburg@intel.com,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH RESEND iwl-net] ice: Interpret .set_channels() input differently
Date: Thu, 18 Apr 2024 11:58:55 +0200
Message-ID: <20240418095857.2827-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bug occurs because a safety check guarding AF_XDP-related queues in
ethnl_set_channels(), does not trigger. This happens, because kernel and
ice driver interpret the ethtool command differently.

How the bug occurs:
1. ethtool -l <IFNAME> -> combined: 40
2. Attach AF_XDP to queue 30
3. ethtool -L <IFNAME> rx 15 tx 15
   combined number is not specified, so command becomes {rx_count = 15,
   tx_count = 15, combined_count = 40}.
4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
   new (combined_count + rx_count) to the old one, so from 55 to 40, check
   does not trigger.
5. ice interprets `rx 15 tx 15` as 15 combined channels and deletes the
   queue that AF_XDP is attached to.

Interpret the command in a way that is more consistent with ethtool
manual [0] (--show-channels and --set-channels).

Considering that in the ice driver only the difference between RX and TX
queues forms dedicated channels, change the correct way to set number of
channels to:

ethtool -L <IFNAME> combined 10 /* For symmetric queues */
ethtool -L <IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */

[0] https://man7.org/linux/man-pages/man8/ethtool.8.html

Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 ++++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 78b833b3e1d7..d91f41f61bce 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3593,7 +3593,6 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
 	bool locked = false;
-	u32 curr_combined;
 	int ret = 0;
 
 	/* do not support changing channels in Safe Mode */
@@ -3615,22 +3614,13 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return -EOPNOTSUPP;
 	}
 
-	curr_combined = ice_get_combined_cnt(vsi);
+	if (!ch->combined_count) {
+		netdev_err(dev, "Please specify at least 1 combined channel\n");
+		return -EINVAL;
+	}
 
-	/* these checks are for cases where user didn't specify a particular
-	 * value on cmd line but we get non-zero value anyway via
-	 * get_channels(); look at ethtool.c in ethtool repository (the user
-	 * space part), particularly, do_schannels() routine
-	 */
-	if (ch->rx_count == vsi->num_rxq - curr_combined)
-		ch->rx_count = 0;
-	if (ch->tx_count == vsi->num_txq - curr_combined)
-		ch->tx_count = 0;
-	if (ch->combined_count == curr_combined)
-		ch->combined_count = 0;
-
-	if (!(ch->combined_count || (ch->rx_count && ch->tx_count))) {
-		netdev_err(dev, "Please specify at least 1 Rx and 1 Tx channel\n");
+	if (ch->rx_count && ch->tx_count) {
+		netdev_err(dev, "Dedicated RX or TX channels cannot be used simultaneously\n");
 		return -EINVAL;
 	}
 
-- 
2.43.0


