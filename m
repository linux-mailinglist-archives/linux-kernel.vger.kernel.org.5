Return-Path: <linux-kernel+bounces-37189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD19D83AC68
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE631C2313F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27D86152;
	Wed, 24 Jan 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="gX3xFsmZ"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF7286140;
	Wed, 24 Jan 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106801; cv=none; b=D77KJ7x9XP3DamjGbwZkozaN5U9fITTShjx0hKPzM26f27ONB4jW2jj9JJvsXPJi1WnIB0sHlGZgsuCGVbV5BhdNvPbORROX1Im3o/nE3E9ocVgCeRarXrJOVZX0DWtlvCua3fpWNQ2leKoNGWgHJ09mOhs+Fg3EObecNwsFo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106801; c=relaxed/simple;
	bh=J8ZnbGicfIizYlxlwcoQNvv53niL2C5JlGn6ghyQ5wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKraiRmS0KbwTF3EwCSoRGTDgHayyhZgxCpbV7g90e+wiyFmy5QY3FAi1Gkl6knYpzbSV/xeWEeK+hxDa0SiIHuEVyGlmHnMb9vJ/nesARt0RnjFHzySdsYmA9CYwBL4klcJgJaGMEUxubwYKIw5cn9IppJ2QH/3lWtZfEXxsSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=gX3xFsmZ; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=43lXa0WU3VYMfy+YKtoNb7AXn3JY+KVVRfKVmYJaNNU=; b=gX3xFsmZxlILiwmvmGybuap8w/
	CtYayO6m6VuK+QhhX5Pnk+brc4gckoiGoV5ESNv/8TjSEQ6VpZPSVmNRiLYJRnDa+AdE/D62XWUVy
	eBDYOpTnliziZF06bme87Y/4UK89aEii+9EfuUzEu1oMQ5Ypc7IgFlXX9oviQNx5lo5Ih2nS+G9+5
	q0ROMsxjZF40qVx4TKCDS0zfQff7+a+R2nfh/J7zg6O17HQ4nY7/LXPJUentt0nRn1TQ583ZA0VVd
	H7vsZ6izsyFEKHRZmoFS+t5kWHt+elaJBU9LSuakv8REzyZ3SxpTCnm4UwvmsSeLuyYJ7ahrIkEky
	p6tthuNA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSeJY-000Nbk-31; Wed, 24 Jan 2024 15:33:16 +0100
Received: from [87.49.43.79] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSeJX-0009kq-8t; Wed, 24 Jan 2024 15:33:15 +0100
From: Esben Haabendal <esben@geanix.com>
To: netdev@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] net: stmmac: Time Based Scheduling support for OF platforms
Date: Wed, 24 Jan 2024 15:33:14 +0100
Message-ID: <b807c2a70dba9711376b265b6da5fb5ff14589aa.1706105494.git.esben@geanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27164/Wed Jan 24 10:45:32 2024)

This allows enabling TBS for TX queues by adding the
snps,time-based-scheduling property. You should check for support for this
on your particular controller before enabling. Typically, TX queue 0 does
not support TBS.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 70eadc83ca68..f0bb49b0f41c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -278,6 +278,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 
 		plat->tx_queues_cfg[queue].coe_unsupported =
 			of_property_read_bool(q_node, "snps,coe-unsupported");
+		plat->tx_queues_cfg[queue].tbs_en =
+			of_property_read_bool(q_node, "snps,time-based-scheduling");
 
 		queue++;
 	}
-- 
2.43.0


