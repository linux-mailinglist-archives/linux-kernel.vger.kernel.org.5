Return-Path: <linux-kernel+bounces-88046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAAA86DCAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEF1283B15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DDE69D14;
	Fri,  1 Mar 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mZSWsqbI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE996930E;
	Fri,  1 Mar 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280379; cv=none; b=fDRcopBhw7rBkJfKFvOXNZZz8RHgEyeSDIG0/0MX05iuRhgHXP8nhSaeam4a9c1ylEX1o+ZPPCAr0mCoL0xTk7H5P1FdfKnvOB9oiyefn474tDu06D0qvmooWNjYDcaXLGYkogBuWnLEB7CZmpMD/CpdOb9g0DBZD3jV01JuWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280379; c=relaxed/simple;
	bh=yI37i87UqneOzVmTClYz+I31zKh2W/A+wihChWmk0Kk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ddGvE1SkM8WztxgUmaREEPAj+kGUmY4reYNkLThiTJSSClM1BI6/64iU9/3z0c+sl2WA/PHQ61FqjhQJQblyolf2SYIU3ZUueJh+woecBSMLQ4skrXNsE3T2pjQtTfJmjU0M5rEfPLvpfXTNpauTNb14rX+bZaZKpoaZgSeqJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mZSWsqbI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709280377; x=1740816377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yI37i87UqneOzVmTClYz+I31zKh2W/A+wihChWmk0Kk=;
  b=mZSWsqbI/Upxee9fzIGcrL2jQO5mBjMhO4ItNufEUUXs/7Z6zvLMiPAf
   3pZpWg37+MBXeJWB3TFXDfRyZkDqpe60gTGTr3RQ8oXCuKtz+YIdg+ei6
   ALdy9qVtaaow9T/G/uT/KGglu/XPx+WR6I43X8xg7fbdrcjGEpjIG7lo1
   JAGnyaw72B/u5oj+MoEJq2RFMq6dFq4/XACfDcvBEFhL+3u5/2s2EytC2
   j75b3eCMVT7TVlSsmXBChOpmg7/x+qnaUHIOB3dV3MC4y2hULOt2uBuSk
   RFsbBn8CbDGt9lCIxeCVeLozTqpvxlVE7qsJzDou2pErWaxlt7xrT3tQ3
   w==;
X-CSE-ConnectionGUID: KhfOYgZRQh2P8hw7PiCldA==
X-CSE-MsgGUID: 1AUvhw2rQpqUKBk3Czq4Hg==
X-IronPort-AV: E=Sophos;i="6.06,195,1705388400"; 
   d="scan'208";a="18668063"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2024 01:06:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 01:06:14 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 01:06:12 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lars.povlsen@microchip.com>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <bjarni.jonasson@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net] net: sparx5: Fix use after free inside sparx5_del_mact_entry
Date: Fri, 1 Mar 2024 09:06:08 +0100
Message-ID: <20240301080608.3053468-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on the static analyzis of the code it looks like when an entry
from the MAC table was removed, the entry was still used after being
freed. More precise the vid of the mac_entry was used after calling
devm_kfree on the mac_entry.
The fix consists in first using the vid of the mac_entry to delete the
entry from the HW and after that to free it.

Fixes: b37a1bae742f ("net: sparx5: add mactable support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 4af285918ea2a..75868b3f548ec 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -347,10 +347,10 @@ int sparx5_del_mact_entry(struct sparx5 *sparx5,
 				 list) {
 		if ((vid == 0 || mact_entry->vid == vid) &&
 		    ether_addr_equal(addr, mact_entry->mac)) {
+			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
+
 			list_del(&mact_entry->list);
 			devm_kfree(sparx5->dev, mact_entry);
-
-			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
 		}
 	}
 	mutex_unlock(&sparx5->mact_lock);
-- 
2.34.1


