Return-Path: <linux-kernel+bounces-144247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81BC8A4390
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2951F20F3F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BA3134CC0;
	Sun, 14 Apr 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dm00pbtN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDA91946B;
	Sun, 14 Apr 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109777; cv=none; b=NaVAf99s8AEjCIeBz5pvB+VutF8ga03LapaOuAU56Pxusd+JxzxaCJ6qMTApjWiCoidqi9vKp0KanNXvoT3sX0ZZ2fslnRfm5sccB6cwZk5EC7YJ2JhIgr90jIN0G5TzSZ4CEpCqjO9or6gB21vqH6aogtJiiYxju2+fQj5sqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109777; c=relaxed/simple;
	bh=vCsq4zNZCgl5SrWAOnz2TdTN3i0qeRkTl74j/gYlBr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=izDx9RUBBWUCgdPEsh9hNT+ZtIVNSu8IZDcZ5IG3Lal0gdwomzwFq5S1gsjH8C68rA0CAtWocv+xfsHJwRusLrdd2sin2p+UjzjiiQYigCsNtcM7p2+MG+pSPe7Hcik0jNfPNSLbi6Ws7duLRHuUiMSQjNaPNxlKvxZy/uYdyLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dm00pbtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F668C072AA;
	Sun, 14 Apr 2024 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109776;
	bh=vCsq4zNZCgl5SrWAOnz2TdTN3i0qeRkTl74j/gYlBr8=;
	h=From:To:Cc:Subject:Date:From;
	b=dm00pbtNpET02QCofKXVDNb1EjWeep/pPqBUE3vEv0OZJr9KnNGIkKVIsB6K6kuCa
	 /m2NmI0TsNeRsl/6OubN5LWhX5wBuLD3EQ3C+oYEzA8HukYrpShmQq5Azg8Jj7wf64
	 m8Knk4USoLXGz0zrnRENM/JB9gOATzoP6U04p1yLdslt4zk/ZMnNAFxQg4uJN2YtPf
	 GJpV6x6je8E7/5OpvenkINRqMCc5Qj/4qho0hsELYsBDdq6XyVBUqixem0DfmPXqOQ
	 WVDK5KkExzCFgstS8kNzDZPqwN6TRn/NodDFFk7MURWkDSqWX/KGl/C70og9mwwd+j
	 Cmy14+wymRdXA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH net-next] net: dsa: microchip: drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:49:29 +0200
Message-Id: <20240414154929.127045-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID table already has respective entry and MODULE_DEVICE_TABLE and
creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index c8166fb440ab..cdc4add5f5b5 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -233,13 +233,6 @@ static struct spi_driver ksz_spi_driver = {
 
 module_spi_driver(ksz_spi_driver);
 
-MODULE_ALIAS("spi:ksz9477");
-MODULE_ALIAS("spi:ksz9896");
-MODULE_ALIAS("spi:ksz9897");
-MODULE_ALIAS("spi:ksz9893");
-MODULE_ALIAS("spi:ksz9563");
-MODULE_ALIAS("spi:ksz8563");
-MODULE_ALIAS("spi:ksz9567");
 MODULE_ALIAS("spi:lan937x");
 MODULE_AUTHOR("Tristram Ha <Tristram.Ha@microchip.com>");
 MODULE_DESCRIPTION("Microchip ksz Series Switch SPI Driver");
-- 
2.34.1


