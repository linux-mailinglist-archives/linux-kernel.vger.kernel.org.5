Return-Path: <linux-kernel+bounces-146846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA9E8A6BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF67B20DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B912BF28;
	Tue, 16 Apr 2024 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ss/kIJQt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E112BF15
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272705; cv=none; b=o36FM4kQwgQIEfy3S/jhF2ndZ5K8hUGeb4OMZ1Sy5cXCgtfNptkBn2eaYyaGnkcV5eVg9+aFF6AmJJRJBXizFrJE+Zfyy/CGBga2ATgSMYIlmfgSYcE0CWp/lDDzA4vtBg7gX+qN6/o1ftWPgpNViCpJ61jKi0BxA1q09hmPldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272705; c=relaxed/simple;
	bh=UEzTGUe3r7acXf8Yb95hdOs5Y9KDHJwibjjQOPb+gas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJ6Myv/x5CFUyw4nsRiIrkcNMHfdcZod+KXGkElDksL8UJe43qxfpZJK7cBTT7jdVsMBmqYzxgp5yARvcqB9fyeuCwoY85hF5knpiHWvGP0SExF8HnqvEr0zP8u6GjJm3epBbtq/ZX3CdCK5BjooDVf8GzmFokbcexhxn5bth0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ss/kIJQt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713272700; x=1744808700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UEzTGUe3r7acXf8Yb95hdOs5Y9KDHJwibjjQOPb+gas=;
  b=Ss/kIJQt0zdXtxEjiSitKwj7zdB5qFc5n3xjBi1ZGBBafSqJ7h6TrYDJ
   3YXhT6bUedorDPCFBZXFfCPZIaPeIo8sjZiv9UHyZPt3DSdjGZ7GEKZsw
   OGEd/+jF3rSGT6SefuYmXieE2BkmGDM9VpDQW0Y+Z0tcWIdAeZT0oeGKE
   v8YogGoMKIRA0l90ziYopg22AwajqeKw6fhpd9m0jXyoP22+TtXM/N3cS
   mLe2isZCuErAhXmsj9/m9i5FdfFBka0cIPfNR6cIdXuLSOChrYR7AiWPl
   O0+nsDJFlFUp3sIXlpCpk65J14i8SiSPtaGBV+nqO9P4aEWW/9fW1/TJK
   g==;
X-CSE-ConnectionGUID: C09H0YPgQVO8g29tx/zPrQ==
X-CSE-MsgGUID: ODC00vwjQ+SX1JYJ1SMIng==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8569445"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8569445"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 06:04:59 -0700
X-CSE-ConnectionGUID: fDp3iuRyQJiH1ahnVv75ZQ==
X-CSE-MsgGUID: KKXIiKUHRK6bNxue6PaYcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22321830"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 16 Apr 2024 06:04:55 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DDBE332EA4;
	Tue, 16 Apr 2024 14:04:50 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
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
Subject: [PATCH iwl-net] ice: Interpret .set_channels() input differently
Date: Tue, 16 Apr 2024 14:58:54 +0200
Message-ID: <20240416125856.1263314-1-larysa.zaremba@intel.com>
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


