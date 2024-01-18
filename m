Return-Path: <linux-kernel+bounces-29929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D45831551
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5A02869B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FDF13FE0;
	Thu, 18 Jan 2024 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WtEWCMsV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1936B65B;
	Thu, 18 Jan 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568455; cv=none; b=Jw/ic3+dE3r28cKNlGleeulm41TN9Xn488u8HPvWV4Qz8eYBzaMOPTqd83DDFTRH+qdyQuCkp77lwnq5RFEsOsg4Ja5JD/F6LoDSZ4PZo9BebuogKrkfNVO2PBSo3Q77kxtUC42mGcJIcZT+BX0PMdsYDO5+3IQ5RItvZEDKKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568455; c=relaxed/simple;
	bh=wQDYeQ0wmedqZ4GGIB5Y5Vs5FdTbUXc48coPNKVmCnc=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type; b=T2aJa6/vlyN1pBHdByXtRZA34pF1wN/ejsUpYB+KEjFTNIblnEZHLn4/4csmHYzWaXrQHFE0JZ9STP58Lhijjs+HMUd4kuRd0HojZT1YxffgRJeizGlXOoFU6aZ2Glr85Ye2K4/D1BQrM++sUT8at+nzQtjz2DSyrlAL4CTffLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WtEWCMsV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705568453; x=1737104453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wQDYeQ0wmedqZ4GGIB5Y5Vs5FdTbUXc48coPNKVmCnc=;
  b=WtEWCMsVzBXL3Lhy2mdqHhnZbxtMAUmGoQPUjDZcOoGmOY30HVb6BlI4
   3iP30V/+WGcWGShfdlxLhjMOIWeNEU0oxIIcy968zvggi942uM2Xm8dJR
   3VCUVAvTtLiNajgYv3K0e6Y4JHq5XbJV/N1vYTTmynNY/d8tAeQ7jRAxc
   zqeIPktWX5JObvrjOmIZWGS08ri2rvLm57nSuLXRB+w7RHUpEM5C0zKFS
   cwOnsOYMq32h6Lhd8/idVFMETGQN0IzXx4SknA1d8/JDzfBB+N5SQ6yR0
   f/46HjD6hs+CECbUcu99xiQnQMhRgHijDOMGjOX32bAGcqUSnB3LTV7c4
   Q==;
X-CSE-ConnectionGUID: c0bxj8ciQ9SPhZEQOBFaUw==
X-CSE-MsgGUID: 0lM+YwTKRzC6hB25oihWCA==
X-IronPort-AV: E=Sophos;i="6.05,201,1701154800"; 
   d="scan'208";a="15403437"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jan 2024 02:00:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 02:00:47 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 02:00:44 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Divya.Koppera@microchip.com>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net v2 0/2] net: micrel: Fixes for PHC for lan8814
Date: Thu, 18 Jan 2024 09:59:14 +0100
Message-ID: <20240118085916.1204354-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are different issues with the PHC of lan8814.
First issue is similar with the one on lan8841 which it has enabled by
default the check regarding minorVersionPTP in the PTP header frame.
So all the frames compliant to 8021AS will not be timestamped.
The second issue is with setting and getting the time of the PHC. The
issue is seen only when setting a time which is bigger than 2^32.

v1->v2:
- replace hardcoded values with macros for PTP version

Horatiu Vultur (2):
  net: micrel: Fix PTP frame parsing for lan8814
  net: micrel: Fix set/get PHC time for lan8814

 drivers/net/phy/micrel.c | 72 ++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

-- 
2.34.1


