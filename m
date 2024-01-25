Return-Path: <linux-kernel+bounces-39206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91383CC88
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F96D1C22C51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A289613E228;
	Thu, 25 Jan 2024 19:35:19 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F713E209;
	Thu, 25 Jan 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211319; cv=none; b=tLd5I91D1O4wNPHShgfD/LBfQzfmJpfSlywKDE4B/QFB26VjMweM9bhUJxVRxYzrc4dDwlnLqmj0tTr8jmhde/+du4e3iDX4mwhHYYos2NU1T0gQmjjx0tps/0unJx0ngkCBNne7j2gpezudUei0gYDVGjYkMpZvNYTT3b7Fugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211319; c=relaxed/simple;
	bh=S6CEobn82H7aa4VdkMxFBDE3DznWGAYJhFkl8Y123XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l50eIiiABkB1DOhpm9ilx21RHNKwuB2BysdMa0ZrgC8nKRWd43rUUr1UYXJKP4bDxwFeXTeuNLBkqlxJDuN8CQzvXj9E8a5yRXxtnEPc/yO1BtUXyLoCXu5pwJk9oA5tG113a0NMesF4G9rbPtrTsKTAaZqXwZWh88NLDJZhiKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a314ca7852cso175390766b.3;
        Thu, 25 Jan 2024 11:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211316; x=1706816116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QjqvkLmk8VDSM4lbemx7hZHtV6yp8+TOJnRN6X8CIwM=;
        b=hDWQeE2bwnfQvzvO2urhb54P3w+Y1NCA+N8nRIfKzLhsyH5X5lAjXLQv7fr4zRUV+Z
         qhGDdnweFII4dOlbhSy5/8UTaKRa/ecSu86s/gNsALFai/hudZBuTxO6Qkm0uWEY/JOq
         QCfWDz6RXVGKu/4cRycWLdA7SO+pFrjj3Jhu/TWp7w/u3YWggz4nBBEzbL/Oc2qQ/PBI
         TY8OGwSJ/Eohu7iGen0Xi42uBwqJZPzDPzaf56LvQFt+S9KZLbM3kX9lSKCTr/7wos6w
         wajUWt2UmlTvYl1fbwxmcOZBERABHlPtZr8rWZ19cLz7ZJFb5sA3g27lP9V/ZaAffeWY
         5D9Q==
X-Gm-Message-State: AOJu0Yx9wmHFpGgjXOnmtar4SrA2tUJLDgte5oK5hqPCUwJSeu+o4236
	Rc++twGvfYeGOYNLC6dmc3Ygr/GIblxcdOPLiU9RJZIqGlq3Wp8Z
X-Google-Smtp-Source: AGHT+IGw8OBJoLm4ygn5xm5az2pErjzlXXBBw71Cjl+glIux2aHdlBCQjZUfWm+NYYC6eQUQURnlxA==
X-Received: by 2002:a17:906:f291:b0:a31:4378:288c with SMTP id gu17-20020a170906f29100b00a314378288cmr52427ejb.120.1706211315809;
        Thu, 25 Jan 2024 11:35:15 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id vi2-20020a170907d40200b00a30ed424e18sm1330363ejc.41.2024.01.25.11.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH net 08/10] net: fill in MODULE_DESCRIPTION()s for PCS drivers
Date: Thu, 25 Jan 2024 11:34:18 -0800
Message-Id: <20240125193420.533604-9-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
References: <20240125193420.533604-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Lynx, XPCS and LynxI PCS drivers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/pcs/pcs-lynx.c      | 1 +
 drivers/net/pcs/pcs-mtk-lynxi.c | 1 +
 drivers/net/pcs/pcs-xpcs.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index dc3962b2aa6b..853b8c138718 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -398,4 +398,5 @@ void lynx_pcs_destroy(struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL(lynx_pcs_destroy);
 
+MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 8501dd365279..4f63abe638c4 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -303,4 +303,5 @@ void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_destroy);
 
+MODULE_DESCRIPTION("MediaTek SGMII library for LynxI");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 31f0beba638a..52a7757ee419 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1456,4 +1456,5 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
+MODULE_DESCRIPTION("Synopsys DesignWare XPCS library");
 MODULE_LICENSE("GPL v2");
-- 
2.39.3


