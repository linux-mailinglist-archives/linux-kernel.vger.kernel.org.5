Return-Path: <linux-kernel+bounces-160327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3A8B3C04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05AA1F215A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9662F14A4EB;
	Fri, 26 Apr 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/XSHe1f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325D149C4B;
	Fri, 26 Apr 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146443; cv=none; b=e/kNjVAljz9zZ9wpAL149O+oqKXqmqBinlccbQ588T6usLiwhpN7LBbMajizaylRs0hxoyN0crZSxqjDmmP3v2k652WmscsOdobPcUBHl+ZZO+XTRSF6mFIjiDpl25zhRpEas+ypqFywFoy+O2odtkGFtax2yL0kcTwo6LTaE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146443; c=relaxed/simple;
	bh=ND7IVRkE83qoPcEOBhEWCyxEP9oWqtsDaYNPykQg7KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSOr4xxVay+TrXsC6nj/Wl0e9C9Mnx4ZpgL0BK8dN1ek1/I9+uPlVthmuo3Wa4SPPbF7F4BYKJHB9IvSLNBVsk41JJlXlhM9kClsDdFeryjVPJNh39BAGqU3ndBMGxTZMCzLmdx7zwbiYkDDRyn1z1tAyUxolOwf75EfKYjnCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/XSHe1f; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714146442; x=1745682442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ND7IVRkE83qoPcEOBhEWCyxEP9oWqtsDaYNPykQg7KQ=;
  b=c/XSHe1foBVNmXvAOkBKo9zFxfx+xHUkBvq029Dgrkmastlkv3pmAfQM
   tpZCummXc5/f/EG+96qUe7iEaX52uDhIY1pldzXo6YqlZNIEGsayzqvGF
   X5iEuf5sT1LZ6uo4AT40ZwjfVbApkGclEGdaAXvbb2auwSTjGYsOY3Thi
   ltexsHoq/WScf/nrjvJtUIedcgMD2Jqus7NKeeaaEZlkR4MIYV6xPAUDF
   KW38ahU3OyD7X02T+oQ2Uiq+X99AsMWM09Wxo0XnSmDsEhZUQoWtl/ozo
   lvNacNngEexS4y8fmyDMY0ZEk1LG2xt/vJdA+L7tZe0bQWgPl2Uktkcuk
   w==;
X-CSE-ConnectionGUID: lBR2wfJFTauyNP52pSrIYw==
X-CSE-MsgGUID: h2s9EaIUS1C9u/g0W7xTVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9747736"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="9747736"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 08:47:21 -0700
X-CSE-ConnectionGUID: W1DJyWexQii1pugr08vRcw==
X-CSE-MsgGUID: ANV2GgyESfiahgxPhkXgOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="30252216"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 26 Apr 2024 08:47:17 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 43B302FC42;
	Fri, 26 Apr 2024 16:47:15 +0100 (IST)
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
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	joshua.a.hay@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>
Subject: [PATCH iwl-net] idpf: Interpret .set_channels() input differently
Date: Fri, 26 Apr 2024 17:41:22 +0200
Message-ID: <20240426154125.235977-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike ice, idpf does not check, if user has requested at least 1 combined
channel. Instead, it relies on a check in the core code. Unfortunately, the
check does not trigger for us because of the hacky .set_channels()
interpretation logic that is not consistent with the core code.

This naturally leads to user being able to trigger a crash with an invalid
input. This is how:

1. ethtool -l <IFNAME> -> combined: 40
2. ethtool -L <IFNAME> rx 0 tx 0
   combined number is not specified, so command becomes {rx_count = 0,
   tx_count = 0, combined_count = 40}.
3. ethnl_set_channels checks, if there is at least 1 RX and 1 TX channel,
   comparing (combined_count + rx_count) and (combined_count + tx_count)
   to zero. Obviously, (40 + 0) is greater than zero, so the core code
   deems the input OK.
4. idpf interprets `rx 0 tx 0` as 0 channels and tries to proceed with such
   configuration.

The issue has to be solved fundamentally, as current logic is also known to
cause AF_XDP problems in ice [0].

Interpret the command in a way that is more consistent with ethtool
manual [1] (--show-channels and --set-channels) and new ice logic.

Considering that in the idpf driver only the difference between RX and TX
queues forms dedicated channels, change the correct way to set number of
channels to:

ethtool -L <IFNAME> combined 10 /* For symmetric queues */
ethtool -L <IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */

[0] https://lore.kernel.org/netdev/20240418095857.2827-1-larysa.zaremba@intel.com/
[1] https://man7.org/linux/man-pages/man8/ethtool.8.html

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 986d429d1175..1cf3067a9c31 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -222,14 +222,19 @@ static int idpf_set_channels(struct net_device *netdev,
 			     struct ethtool_channels *ch)
 {
 	struct idpf_vport_config *vport_config;
-	u16 combined, num_txq, num_rxq;
 	unsigned int num_req_tx_q;
 	unsigned int num_req_rx_q;
 	struct idpf_vport *vport;
+	u16 num_txq, num_rxq;
 	struct device *dev;
 	int err = 0;
 	u16 idx;
 
+	if (ch->rx_count && ch->tx_count) {
+		netdev_err(netdev, "Dedicated RX or TX channels cannot be used simultaneously\n");
+		return -EINVAL;
+	}
+
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
@@ -239,20 +244,6 @@ static int idpf_set_channels(struct net_device *netdev,
 	num_txq = vport_config->user_config.num_req_tx_qs;
 	num_rxq = vport_config->user_config.num_req_rx_qs;
 
-	combined = min(num_txq, num_rxq);
-
-	/* these checks are for cases where user didn't specify a particular
-	 * value on cmd line but we get non-zero value anyway via
-	 * get_channels(); look at ethtool.c in ethtool repository (the user
-	 * space part), particularly, do_schannels() routine
-	 */
-	if (ch->combined_count == combined)
-		ch->combined_count = 0;
-	if (ch->combined_count && ch->rx_count == num_rxq - combined)
-		ch->rx_count = 0;
-	if (ch->combined_count && ch->tx_count == num_txq - combined)
-		ch->tx_count = 0;
-
 	num_req_tx_q = ch->combined_count + ch->tx_count;
 	num_req_rx_q = ch->combined_count + ch->rx_count;
 
-- 
2.43.0


