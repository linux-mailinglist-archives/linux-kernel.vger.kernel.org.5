Return-Path: <linux-kernel+bounces-104369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41087CCED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663C2282DC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E341BF5D;
	Fri, 15 Mar 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="j08CrM8f"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A4175A5;
	Fri, 15 Mar 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503290; cv=none; b=Zmey16IFKIr/8laHPel4O2fGsb5GC4FJThZ629nNq1FPPuWrwglvHzpAWfnSzkaFpeCDdOTtYP62uZBgWqe/SzS9pf047Cvpm8OQRn/Am5UhBWABfBlKd6M/uXQ/5TNcsaji0Cj7bsQSNQucNpkY9REbkF8lri7NLZlINfO6KwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503290; c=relaxed/simple;
	bh=KLnCZlkM1BKYgCnXPjdoc+/v79+p6MeSATpJ+Tv8p+M=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=TTojhSAN4QiUL86/pRTeEqVQw218iGI8D2WAJWCna2uQv3BSrX6ollFWUloKvragq1Anbs9c0ARxzPtcUz38jLfRpzx13buatIXTclmb/ldQfilQczVSYfktsvUw0c6X5md4brEDw/iM8++u8Tt0aw/tJVMps2RWe2GzS0piECs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=j08CrM8f; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q6iaqWZ35Ho9QJO468pOuORhmj0rHw6LUzE5ftm3Q4g=; b=j08CrM8fgkMUvrGYz5jDV900Q6
	GFVjLAW982+ssaEOWfr98hnHdUKhY74wXL93ssxMZRIdJm8W1ypa+SiaYsPM7eR0ZI0LfWJE3wkqP
	1v1J6RJ9JKlvw3Wop2zZ5OcxIO7aXAfKTswOq0fOOKXHtD/OAS+rGIl3rgbxmO/r8J/TJPvJQnoYt
	5FcVse0+CMeOQHQOHe+wxmPI0IePH4QKu8gY2xqT8w8TaGQLqXPn+QrSAjqLTDZOAafBgrST0IUiL
	9G4fZIEBEFEuvQV26QoiDq472ENVRQ0xj1IAv39KpLcGTfpNKGmMsWqB7BRJs5znDehykmNIjQIGP
	bDsSwB1g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50004 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rl62V-0001Zu-2g;
	Fri, 15 Mar 2024 11:47:55 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rl62V-004UFh-Te; Fri, 15 Mar 2024 11:47:55 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>,
	 mturquette@baylibre.com,
	 sboyd@kernel.org,
	 linux-clk@vger.kernel.org,
	 linux-kernel@vger.kernel.org
Subject: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 15 Mar 2024 11:47:55 +0000

Report an error when an attempt to register a clkdev entry results in a
truncated string so the problem can be easily spotted.

Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/clk/clkdev.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ee37d0be6877..3146f26ab997 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -158,6 +158,10 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
 {
 	struct clk_lookup_alloc *cla;
+	struct va_format fmt;
+	const char *failure;
+	size_t max_size;
+	ssize_t res;
 
 	cla = kzalloc(sizeof(*cla), GFP_KERNEL);
 	if (!cla)
@@ -165,16 +169,34 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 
 	cla->cl.clk_hw = hw;
 	if (con_id) {
-		strscpy(cla->con_id, con_id, sizeof(cla->con_id));
+		res = strscpy(cla->con_id, con_id, sizeof(cla->con_id));
+		if (res < 0) {
+			max_size = sizeof(cla->con_id);
+			failure = "connection";
+			goto fail;
+		}
 		cla->cl.con_id = cla->con_id;
 	}
 
 	if (dev_fmt) {
-		vscnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
+		res = vsnprintf(cla->dev_id, sizeof(cla->dev_id), dev_fmt, ap);
+		if (res >= sizeof(cla->dev_id)) {
+			max_size = sizeof(cla->dev_id);
+			failure = "device";
+			goto fail;
+		}
 		cla->cl.dev_id = cla->dev_id;
 	}
 
 	return &cla->cl;
+
+fail:
+	fmt.fmt = dev_fmt;
+	fmt.va = &ap;
+	pr_err("%pV:%s: %s ID is greater than %zu\n",
+	       &fmt, con_id, failure, max_size);
+	kfree(cla);
+	return NULL;
 }
 
 static struct clk_lookup *
-- 
2.30.2


