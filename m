Return-Path: <linux-kernel+bounces-80729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F6866BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCB21C21514
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D57F1C6B8;
	Mon, 26 Feb 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M+wTcX7x"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FA1C69A;
	Mon, 26 Feb 2024 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935101; cv=none; b=Tw1W++Mn/IoBJfQENk1c4Vx/WPXn5IoOdGiSUUxkvOnlDHdegZpYT4VRsZ9vrok7eSluufBBh3doW8Ym865fgx24Q8/CvKy/0AMpmqoqRSxDg7ogM913j/JavZscyBQhgrzVZxRMljNkn/ZhMn0vaxvR8vh5eJCvWmZG8cNqF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935101; c=relaxed/simple;
	bh=iVYZwkDhMcFRUnUuzDyyomGJypM8ZgenECp2q6HRhhs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5WM7q1XKAuKEe3vqf5MVERlMgAW2zm+a3MpiB8QKaRB+zERWA5ls0HYTMxF3bWS9mw3hHI6w9Xzu/hB96Oi78yquOMSVXT60kPNR+WFKcP0DeY3IQ8ke67oXhsWKDaFH/sv5dmgVVLmBYiR44e+cgm+T3YHHooOysFYkZoSVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M+wTcX7x; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708935100; x=1740471100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iVYZwkDhMcFRUnUuzDyyomGJypM8ZgenECp2q6HRhhs=;
  b=M+wTcX7xbBKH++D3tlu6JJ1Xy8SEHrSpwe68tNKN6JyQJnlsuE9Iccbl
   P89XYWrpSJVx07Ow8iuLbwDotb+ssZdOXsYErH1sqO4rv882snsRzbIub
   g7z+o1Q24Z/0NJbK+Jjlko4ax0G57DQuSKhzACmfaCd4tG/n/wcfSoRhO
   f/MzLzB9IzGDM7XQB6E475adzwzy3ZB3Z016+pVhsAOfFjC2OPijzqUL2
   6d39XL0f38NxdaCY5Mit9iSs3itBM7tnZK/l1sBznOKTvCfH2vXkYXS/f
   uAtC6nurZ/wAWbasbtHPWDjAIBiObm+9oz2JVdHzrYmnPIx2TyNHiR7RR
   w==;
X-CSE-ConnectionGUID: Af2UcUQzQhuuU426y0lnaA==
X-CSE-MsgGUID: SGRabUegT8q+ABh4d9s+BQ==
X-IronPort-AV: E=Sophos;i="6.06,185,1705388400"; 
   d="scan'208";a="247559921"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2024 01:11:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:11:26 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 01:11:23 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <richardcochran@gmail.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net 0/3] net: lan743x: Fixes for multiple WOL related issues
Date: Mon, 26 Feb 2024 13:39:31 +0530
Message-ID: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
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
3. Address problems with wake option flags configuration sequences

Raju Lakkaraju (3):
  net: lan743x: disable WOL upon resume to restore full data path
    operation
  net: lan743x: support WOL in MAC even when PHY does not
  net: lan743x: Address problems with wake option flags configuration
    sequences

 .../net/ethernet/microchip/lan743x_ethtool.c  | 24 +++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.c | 24 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h | 24 +++++++++++++++++++
 3 files changed, 69 insertions(+), 3 deletions(-)

-- 
2.34.1


