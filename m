Return-Path: <linux-kernel+bounces-108424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B74880A55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E485A282B54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19BA12B8D;
	Wed, 20 Mar 2024 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ko5bP5ba"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A022064;
	Wed, 20 Mar 2024 04:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710908628; cv=none; b=GRSns7Sg1JEsi745VtmDGzl3Ow3+RzY9wIwPwq7E71KLuIjd07ge/OGfkvcugwclFZDMplmDAhvEJUvF5ytt6YLUtd5qgzULLd4qq3AFDowti0jLecDUfVLT2Z5cXyVEZsHvY/Lc7ZbCWOJTpGnD6hdPSgj7Ys1mDVUyBTbo1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710908628; c=relaxed/simple;
	bh=j0Xx8CezLx+JIrQCRbrnkcKjveTEivUHSZclHS8KqQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VAwcuEZ/WQFXD9jxerrM/JGISoXRufcZER0YZXor1lT47hNEnj1UdOEFmtMeb4eeaUTjASgcPKQsUtMjWCZVA9aWekc37V2UrPheGAZDLIrQLuvmfR6xLxcTzTPbwH9AXkCFP+S7uFh4fBcFDylvFHjUQfcGyeBYFhcgtQc9+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ko5bP5ba; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710908625; x=1742444625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j0Xx8CezLx+JIrQCRbrnkcKjveTEivUHSZclHS8KqQw=;
  b=Ko5bP5baa9rgByErKe5iT0Zqfyz+aeaFjhz68yd4bUDhytb45HWXXwFg
   5M4ldnnbrv1G2TyeszDN93Mx6XCYlrhpDL0NptYSHTwVKskTp2x/hBZyY
   86dJJlJciDKuH1pXRoSNhIHk1CcK5XS0mZz3CCowTwYVDZfKVVuOjyzg3
   zzrXJmdFY1gjPvMva7P3KYmWlkJwrT4IB7ydqqwFYm3FSVBSg04Xj+4fg
   ky2MTzvoXDu5lb9YDFUEzJveRVsNHISZtGhB/byvSlco+clINmWjXf7I7
   yQx76tFYg3fu1jc/crSSLYYqJEghDkfCUZJCwVDOfNHx4E4aHT1C5lxsG
   g==;
X-CSE-ConnectionGUID: 21w888ukSzuTtDKIpokYoA==
X-CSE-MsgGUID: e1s4TD75RauALo3/bJfJdw==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; 
   d="scan'208";a="19637468"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Mar 2024 21:23:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 21:23:34 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 21:23:31 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net V2 0/2] net: lan743x: Fixes for multiple WOL related issues
Date: Wed, 20 Mar 2024 09:51:05 +0530
Message-ID: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series implement the following fixes:
1. Disable WOL upon resume in order to restore full data path operation
2. Support WOL in MAC even when PHY does not

Change List:
------------
V1 -> V2:
  - Repost without patch V1 3/3 - net: lan743x: Address problems with wake
    option flags configuration sequences
V0 -> V1:
  - Include the missing maintainer's email ids in 'CC list
  - Remove the patch "Address problems with wake option flags configuration
    sequences" from this patch series. Will fix this in next patch series.
  - Variable "data" change from "int" to "unsigned int"
  - Change the "phy does not support WOL" print from netif_info() to
    netif_dbg()

Raju Lakkaraju (2):
  net: lan743x: disable WOL upon resume to restore full data path
    operation
  net: lan743x: support WOL in MAC even when PHY does not

 .../net/ethernet/microchip/lan743x_ethtool.c  | 14 +++++++++--
 drivers/net/ethernet/microchip/lan743x_main.c | 24 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h | 24 +++++++++++++++++++
 3 files changed, 59 insertions(+), 3 deletions(-)

-- 
2.34.1


