Return-Path: <linux-kernel+bounces-132645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A928997B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573611C20F30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E681465B5;
	Fri,  5 Apr 2024 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="17vS5v1K"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611518659;
	Fri,  5 Apr 2024 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305466; cv=none; b=uKfZsCdztClL/CQRT73/nWOk9xjwZUQpb+egu05DapxnH2ERHcZVgNeYB0LZGl40b0+oXHUKMghgRwaJZ5dPQr2C0SyVFYHZgbs7mY3R8TD1/pcmS1EBfouSN2hEyETI9xN+VTf/RA+55HqzYhl577hARanNO0Q8YoY+l1zPQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305466; c=relaxed/simple;
	bh=HYENBOEyf8xFjjO20wzuUQE69XQvizrgUVV4d2/meG4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4529o3G+jEfMatJwmZHcEymxG0uNhJ0VVVuByApb0riJu+o9jJftzhT+G1aZFX8DS9WTAglWAXB1izK/COzXI4qvwoZGCMriEfbRFwyqgKkPYaUx+rs/H8feFjQ24tpFj1I7QfcTJgrfcl3RdqApFaVrdt0WTwLKRdxMdlR/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=17vS5v1K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712305465; x=1743841465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HYENBOEyf8xFjjO20wzuUQE69XQvizrgUVV4d2/meG4=;
  b=17vS5v1KIusjhBxy7qOWiNkPItLLgfzQMu1Z5yuSj6qV+29giVU9Q+br
   FA756+OdVdKpRbMg19ZLPs5vLyK7KXxAMvKmWHmz13jgrA++6yrBM4MNa
   VLYOr36p30H3yBFCDjJKaQa0KgMboVLdo7JHTmoPD0Bm26xvBLTbHl87v
   7X9/ji8WW+NHdgn70FwyDpbtOtwcFdp1i0F7boi0wmF3oDBs0zYRbp/We
   LGHkTFYootjf55dGnCKS1M9vEz0r5hisvSylOwKd5bKvVmGYYCbFgQ3WV
   3ErSoI/7Dy0cEt2Uz0qgI3n63zz9svUiAIJ8JoxIFbtt7dmjnVGHK9+k/
   A==;
X-CSE-ConnectionGUID: YjdtRCXQQq6Hp7xbmZIMzw==
X-CSE-MsgGUID: axGfHLomSbyvb2c8XoUsNA==
X-IronPort-AV: E=Sophos;i="6.07,180,1708412400"; 
   d="scan'208";a="20152814"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 01:24:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 01:24:05 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 01:24:03 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 0/2] net: phy: micrel: lan8814: Enable PTP_PF_PEROUT
Date: Fri, 5 Apr 2024 10:22:55 +0200
Message-ID: <20240405082257.1552821-1-horatiu.vultur@microchip.com>
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

v1->v2:
- add missing unlocks on error path

Horatiu Vultur (2):
  net: phy: micrel: lan8814: Enable LTC at probe time
  net: phy: micrel: lan8814: Add support for PTP_PF_PEROUT

 drivers/net/phy/micrel.c | 381 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 357 insertions(+), 24 deletions(-)

-- 
2.34.1


