Return-Path: <linux-kernel+bounces-10300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A781D255
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE59A28516D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861A6ABF;
	Sat, 23 Dec 2023 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W2x3Lvyj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E589472;
	Sat, 23 Dec 2023 05:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zx4nae/0xrclCjM8gAvAdTEa4EkprooF8E0KRFjjTTA=; b=W2x3Lvyj9SRKw6ImeEDNTMJn6I
	fPPLv9QZaKEiD8a+mGzc6aECqvM6jNHaLkTsgxKPL6dIcBbDiYXiDNMKua1pHpmbHxMiVJ5A0wdKq
	h/YWUP7M0xbNEsu0qpKwO1StTqy5GNaK5pQ0+jA2vGyRqcjHjcg6HBCykljX6+KGte8zxLjnuTqdk
	XHuz+KY+xL1aETOSS6eG/hTS/qUOZ9ijrULUZVGrfnV1KJT+iWHAkDbUT62OjyeExVae1/+fwWt7H
	TTfTtJ2pPhih6XH3D7quUZF5gmk/BstZGg4dDHolSMAiK3D7rBElrq4wTNwMfMjBO4BZt7CfNTN57
	5rZFACmQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuDF-007Ohp-2e;
	Sat, 23 Dec 2023 05:06:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Subject: [PATCH] net: phy: linux/phy.h: fix Excess kernel-doc description warning
Date: Fri, 22 Dec 2023 21:06:13 -0800
Message-ID: <20231223050613.13978-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @phy_timer: line to prevent the kernel-doc warning:

include/linux/phy.h:768: warning: Excess struct member 'phy_timer' description in 'phy_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
---
 include/linux/phy.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/linux/phy.h b/include/linux/phy.h
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -569,7 +569,6 @@ struct macsec_ops;
  *      - Bits [31:24] are reserved for defining generic
  *        PHY driver behavior.
  * @irq: IRQ number of the PHY's interrupt (-1 if none)
- * @phy_timer: The timer for handling the state machine
  * @phylink: Pointer to phylink instance for this PHY
  * @sfp_bus_attached: Flag indicating whether the SFP bus has been attached
  * @sfp_bus: SFP bus attached to this PHY's fiber port

