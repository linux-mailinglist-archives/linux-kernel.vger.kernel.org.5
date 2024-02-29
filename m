Return-Path: <linux-kernel+bounces-87385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D642E86D3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3F21F21DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFC13F42C;
	Thu, 29 Feb 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FFcwUqec"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA8513C9CD;
	Thu, 29 Feb 2024 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236381; cv=none; b=ofUQvxJl1sTurV2ZRW7T43b7ni5oUgEYO3R1dRdhiqfMMF+VUY1NIr/vIDYQs/Ipl0G/aYSsDq904xm5c5MVQz4oD87EAog1stzYjUkxFqrU8/Yh1dWBWYIPT4+uaMglY9B9puhqMBWuMFhAVZ9sKM4TksrLJwHgNtajsocTo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236381; c=relaxed/simple;
	bh=fRVcWf5mL1gagzxIJm87iwzhYx0evaIHjsoZZkgDEmQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IeHnxMDQe9N7YJR0Gqrkt2Hy9tg0cbCAkqyQNBuhgfhwkUVMsx16r97Uxl/fkxNYLIs+E+dhIfmuTT5648h89vRg3/rY+bv1oNZh/Qkdr3TXq40zoyPYeypvdV7vfU1F0bWz8jaYcN+UDYNQ+X19udgMlNaH4uxgvf4zt5gzStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FFcwUqec; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709236379; x=1740772379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fRVcWf5mL1gagzxIJm87iwzhYx0evaIHjsoZZkgDEmQ=;
  b=FFcwUqecxtMN/EAVIujm2aoWbb1Xw8AonpvpLSePqntbqqZPuPPC2RH2
   oQS4Hg82zcssNg0DjJFFZBkF8cxrut/yLWGEnC6lE/noYt2fendJ0doYW
   XBou7RAgSq3AxCaqaZBYq7mPt5i3MSk8/t0bFKaoVrk7he0KhdthB96aW
   9CGUeGzpznY96Z2WnTDNIwLKy29sbBPP1oMj5q3yRvAOi0pSAj+OI1UUt
   gkuBarBPlhs5p8kVpvY9kemzbvstojlhe0zUVaQFKl+6tsYcNbBN/BerM
   rVHWIaGs0MQ1khaH14JTPNIVYmnk6tLFnwDwg3G8V0vI/gZcXCdt8vqzA
   A==;
X-CSE-ConnectionGUID: 1amprSseSNuxLnYX5OpglQ==
X-CSE-MsgGUID: kh2rHzcxQIaEdMxHQ4S7gQ==
X-IronPort-AV: E=Sophos;i="6.06,194,1705388400"; 
   d="scan'208";a="247788406"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 12:52:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 12:52:38 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 12:52:35 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 0/2] net: phy: micrel: lan8814 erratas
Date: Thu, 29 Feb 2024 20:52:18 +0100
Message-ID: <20240229195220.2673049-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add two erratas for lan8814. First one fix the led which might
stay on even that there is no link. The second one improves increases
length of the cable that can be used when used in 1000Base-T.

v1->v2:
- separate errates such that each errate has it's own function.

Horatiu Vultur (2):
  net: phy: micrel: lan8814 led errata
  net: phy: micrel: lan8814 cable improvement errata

 drivers/net/phy/micrel.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.34.1


