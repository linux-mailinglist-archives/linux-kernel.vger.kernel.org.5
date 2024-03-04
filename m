Return-Path: <linux-kernel+bounces-90288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B84886FCF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27410282D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2469F2134F;
	Mon,  4 Mar 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RCSvexr2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C61B819;
	Mon,  4 Mar 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543811; cv=none; b=L7ZAGzul6pcDpbcBmUhLH0ofu0rIxXwwzDKYtLXidoiORzp8iFBRIXAAdZaqQnz4JaXgMC8iTM8FBCYnuwmIlLVVR5dlxcVj1ee5aVV8mPDTi0RfgWij92N2y0rain1m9+szJQmflsN3LYjt4LcZliOjANLveF7LxxcbLRJdBg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543811; c=relaxed/simple;
	bh=omI7syTwtxzQJWIcgXvF3unw5rgHvMYUQ0Fkje2aE70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qVZxNaZIwzXP5nKojV5C7Zz3X7Yf4SeR2XA6ozAVWMIDuFwfMvjEJmnjX6dl2ezjC5c4Dp4cTRDnANLKR4/W15tcYKl8fgCRUv41cw6ZPUkfFKc7VLJ53VctSSkEiAwcAVMN3/hhQbQAx/FybqBAs8EhGAWp+INjFKrHQojdGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RCSvexr2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709543810; x=1741079810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=omI7syTwtxzQJWIcgXvF3unw5rgHvMYUQ0Fkje2aE70=;
  b=RCSvexr28aMEAM7gdvyPKRCnvETGBjjTPzpyqNW616STZyJzW+I28ydv
   FTiVD9l5+mqZ3NR4C1bQUYOzA0H8A2kp0L+8ouBP08qD4tueJexxDPN8M
   4tg7qDRKM2E0IMjyQpvaLMvDyKb+5/lu6Lt/UXcFxjrWDS/ID5uScawG5
   UcZJhxpAnrq687f3d6GLHoPFreamgixs7MmTDq9dDJWxlSTOKce2sC8Ok
   ktgKPVXub3zogD/2SV332kSJB1ewi4jPTcY6XhNFVZ+sxSo+tKncujV0e
   3cEcszXuxxqaw0OcwtEiVtGbobWqQhPYRcpx+rZLYPR2jD7AjkgFCs3Jl
   A==;
X-CSE-ConnectionGUID: 7oblNlVzTXGpgkVkuiMXRA==
X-CSE-MsgGUID: NvHMxlTPQxuHcFf0bus05A==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="247914617"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 02:16:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 02:16:22 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 02:16:20 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wojciech.drewek@intel.com>,
	<arun.ramadoss@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 0/2] net: phy: micrel: lan8814 erratas
Date: Mon, 4 Mar 2024 10:15:46 +0100
Message-ID: <20240304091548.1386022-1-horatiu.vultur@microchip.com>
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

v2->v3:
- drop trailing underscore from register definitions

v1->v2:
- separate errates such that each errate has it's own function.

Horatiu Vultur (2):
  net: phy: micrel: lan8814 led errata
  net: phy: micrel: lan8814 cable improvement errata

 drivers/net/phy/micrel.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.34.1


