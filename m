Return-Path: <linux-kernel+bounces-84563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94CD86A856
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A31C23839
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C91225AE;
	Wed, 28 Feb 2024 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VaxoA+EV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541724A09;
	Wed, 28 Feb 2024 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709101848; cv=none; b=PAluPeOZmjt5X1fvInLF54s2V7GIhp0RGDlYw+RDEMlzZpOZaH5+EF/zz8+c6AVjIcxR8jiezbIJjqS67zbhFPhDtUEe9IuUxCRW5d9c7Er8B8xA4joI94RjY2QB+IZ4PAfXxNGHNl1g0YhbqT7Wr9c1W3S46Y9WGWAnshcRhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709101848; c=relaxed/simple;
	bh=j+lMa2t7oRxVAAwu6ZMMloqWKciBrtveM9JHrtuZOns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j92mYbIkfEhYVmqfAdWd7ljjU+fRfzhVmk03QT55IZIyOj+xUKw6XszystRAmf7Jx25AO9XXFpQlJRYlVLaN1Ll2dIoxjbxqkInBweshukOEevHuhJ7uNkfQmM5F/tNY9OB07y7s7cJCF0n1SJT9Ipe1Wf2k+R6V+du7KGYfot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VaxoA+EV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709101846; x=1740637846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j+lMa2t7oRxVAAwu6ZMMloqWKciBrtveM9JHrtuZOns=;
  b=VaxoA+EV/ZfICPVX9xDGA74R9vz++2x1S4MEDrA9aRH6eQA8Oulq+ScY
   TeT4oKVm+/J/dR4baXfLTuE88n099jgsP9ztGt1NTzD2HDZCV8TWO/zJ2
   662n8hS4b2PeBDyUMIcP5kJeYzATy8uqA4sFAF12wwFgXGEHSWXFSNo2k
   r2fRotEbBff6MzaeXdcb39lgwTOuUSGE+a5yTzav1ZPr0iueFICVSy3dl
   ftQNP98Dn+Q9hkPiKl8sjs0P2ueD0q3xwhB4dwpmLKFFj9YjA7EBn+o+q
   AwCxAxS2a6qPUkuK0XXDO0t6wEOXPXYjLFTq3fTb4/UmConi20Jq2IXmc
   A==;
X-CSE-ConnectionGUID: QGTWA1AYSTOMJf59wHwGiA==
X-CSE-MsgGUID: jJTQM5UKRUytzBkqvnVAKg==
X-IronPort-AV: E=Sophos;i="6.06,190,1705388400"; 
   d="scan'208";a="17467553"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2024 23:30:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 23:30:03 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 23:30:01 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next 0/2] net: phy: micrel: lan8814 erratas
Date: Wed, 28 Feb 2024 07:28:11 +0100
Message-ID: <20240228062813.1007138-1-horatiu.vultur@microchip.com>
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

Horatiu Vultur (2):
  net: phy: micrel: lan8814 led errata
  net: phy: micrel: lan8814 cable improvement errata

 drivers/net/phy/micrel.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

-- 
2.34.1


