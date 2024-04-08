Return-Path: <linux-kernel+bounces-134849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D9B89B7D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AD31C2178C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497BD1A5A2;
	Mon,  8 Apr 2024 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XVkY7ilI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F032111A8;
	Mon,  8 Apr 2024 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558739; cv=none; b=LIgHSJWDuxZL6HpP590wm/7S7CFCAVOBOroKPvmdJrpwoHvr63ctfMvxtu4ZThDZ/aVRfITbG0JcyOVqFax94hk8dK6kW7p4HXSpVQU4oaTtwCTvGQ+xoqM8moBUFmLrCMzeLMuH9q5friaV9hBvrMh0Belk965pV58RJpoxttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558739; c=relaxed/simple;
	bh=rH2ZvfTRn6x6o8HdVnQP3miTMN83+rwBW1YTozrVN1k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZORGHfAwr+Ta5XRAWj3jzAPK2xjzU6kRyr4wEd1xabyuIAZD6kTKMgCrJK1iSME10iQUp54iCQbafxHYYXxkL3D9toEJTSf3rsU1FrqZ+Uc73OSTeelkgVlqOZjh70+yUyFQ+dzeZ2TYmEOR8wJQ59iLPNyqu5oS/goeRT3s7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XVkY7ilI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712558737; x=1744094737;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rH2ZvfTRn6x6o8HdVnQP3miTMN83+rwBW1YTozrVN1k=;
  b=XVkY7ilI9QUPX8HzNvdczd+XaNil/tA5hXd/vaCh3METhtqszReh/f0b
   7AUJOkV0O91Ug3m1ypmkwYTlivlDp0lKL06YA/Xtxzbekg9i273S5NfYZ
   eBL1lksCd+wTIKxpakdcDniTbwBEMqv8xzAsbqeVqx8H5gkuOliVa2IS0
   vlkqQFpLnx1NSGDTnTU1RqWwPnsGK6H98x9xu+KUE3tzP2jBPnflSZ4OK
   KXJTdggt4Nh7B6lOLQ+Epcp5XWKHOxMzT7j9zJRjuOaVb0YMk7bdh4Mt1
   63Ka/0FAwHiZkCXWw/fK53g6mKdHWKsPhVluNaA+8AqEtXQAqAmuCO3Uh
   w==;
X-CSE-ConnectionGUID: 2+TP0aPMR5me/Arb7xwZJg==
X-CSE-MsgGUID: 7Kz87cL8TR6Juj76gqzNuw==
X-IronPort-AV: E=Sophos;i="6.07,186,1708412400"; 
   d="scan'208";a="250762788"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2024 23:45:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 23:45:14 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 23:45:12 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<divya.koppera@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 0/2] net: phy: micrel: lan8814: Enable PTP_PF_PEROUT
Date: Mon, 8 Apr 2024 08:44:30 +0200
Message-ID: <20240408064432.3881636-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for PTP_PF_PEROUT to lan8814. First patch just enables
the LTC at probe time, such that it is not required to enable
timestamping to have the LTC enabled. While the second patch actually
adds support for PTP_PF_PEROUT.

v2->v3:
- rebase on latest net-next

v1->v2:
- add missing unlocks on error path

Horatiu Vultur (2):
  net: phy: micrel: lan8814: Enable LTC at probe time
  net: phy: micrel: lan8814: Add support for PTP_PF_PEROUT

 drivers/net/phy/micrel.c | 381 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 357 insertions(+), 24 deletions(-)

-- 
2.34.1


