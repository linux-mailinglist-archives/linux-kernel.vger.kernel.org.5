Return-Path: <linux-kernel+bounces-131076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6634A8982C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE850B2189E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDCE5FEE3;
	Thu,  4 Apr 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xTAbamQK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8745D73A;
	Thu,  4 Apr 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217885; cv=none; b=sf/yhuHd/OjyaZNuIJ3ot5j1AM/C6downp0xZpT5nFMHv+cSTFZeKQE7OSp00hHnGJS2+BxP67mBrLLhj+efOesARAqkXDmGGTrJppOvEmObROCox3yPZAjp6QAkO2qVkSt/89DgOqH0l99htHx9Ki14v24fVwQrPjlPBRNl4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217885; c=relaxed/simple;
	bh=X1GctJvEBCORgKljirWAIXfLa3Hvgr0uFQWr0R44aHw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q8zp23o+SNzbl/vT1yRBZqSZUr8Rp86Lo4FNXrI2n3DzFHIAIUR6axP/QW2rXDsMJmA5GFILP0VhWhlI9T3zbRGUQ/MMzdfuq/wlW0nnYPp4NprGpu6sr+hEHZjBi39wjnaDg+tXvAqmXD10DqY6mABsoS86ECj6VtXa1gMNsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xTAbamQK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712217884; x=1743753884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X1GctJvEBCORgKljirWAIXfLa3Hvgr0uFQWr0R44aHw=;
  b=xTAbamQKe3eXHpOsrSIQCJVGXA7WR7Cp9/yAIxFNOGaz81H3c8ntBtQp
   DkTcr4eYZr4HVtyxlQk6y1TMnQ4UDvdJzXz7MnDv/WwPLfLFpnSlWNii5
   gO+4lb9o3gZfuXCM4x1HGOf4pSFggoPge6Zxv4ge547aFBNMtoeUXbuMS
   UwZyomnqM2+G3FIzZ3WbMdpvrzZhowhllngGGrg4rCVm/5g+G49IplUhW
   KTSKd9gKuJTCYbMl2Y3hAgeBs7Xx1HpBAT7f4Kqq6qdTo/FrvSBX0w4Gx
   niwm059+FazJx/gyghpmJn9q+mmKmEN1cs6ui30jucfGF2bUnG+XasaUk
   Q==;
X-CSE-ConnectionGUID: dlpw0rggR4WYgOJDui2PAg==
X-CSE-MsgGUID: IqhGjgYfS7qAbPAyxk+qrA==
X-IronPort-AV: E=Sophos;i="6.07,178,1708412400"; 
   d="scan'208";a="186710219"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 01:04:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 01:04:32 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 01:04:29 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 0/2] net: phy: micrel: lan8814: Enable PTP_PF_PEROUT
Date: Thu, 4 Apr 2024 10:01:13 +0200
Message-ID: <20240404080115.450929-1-horatiu.vultur@microchip.com>
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

Horatiu Vultur (2):
  net: phy: micrel: lan8814: Enable LTC at probe time
  net: phy: micrel: lan8814: Add support for PTP_PF_PEROUT

 drivers/net/phy/micrel.c | 379 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 355 insertions(+), 24 deletions(-)

-- 
2.34.1


