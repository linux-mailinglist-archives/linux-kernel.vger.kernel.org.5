Return-Path: <linux-kernel+bounces-38583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C7283C29C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24EC292196
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62399481D1;
	Thu, 25 Jan 2024 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="sGzqxBb7"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FE481A8;
	Thu, 25 Jan 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186081; cv=none; b=n7VGdUBZD47o3R5qibxZ+8F71JFyVhkJb7jn7q8ult73MlHyMEWJLZaCuTd1fvtHYBPrX3kaYDduWAsn68qRmHsO8Zgul4Hjkeeb21GYQNUZbXuVApzah5a2S44LcNQixwmNu6MOfYkL62lVtcMSzZJhy+2NFXo+MOOl92iy4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186081; c=relaxed/simple;
	bh=iqbcOpTlEh5SlO47biheNN9vN+dMs8WVH0huJV/6Kbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnbWn70+8LBPTDmmHirkh3P7BFk5/gKJvjx11Pmr85QP4At+nixW8xzrV5bV2WEo/ZxhNDyF0oDBf8Ac2itzbB2uYffqSyAuxMeI0U+SNYpDpb+PnccZd4O1NwLspnxGR3GGK8Ty7Ueyz/Xr9191TIK+0Mfhh0bM1XAG7Ztui44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=sGzqxBb7; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=O99d2OhA5yD9439wbiGDNw8gbQ6j47VNjuChaGpSepE=; b=sGzqxBb73IUlg1OF5UY4xH9Z5F
	AysdrkIa0xJpoLD8gMXgkc/z5ha1KwdVV70NGn5p3Dh+kUkcO77WgN+qRvnRcxFoMfOXPTHxuSBQH
	uVZVmh4+4NRKVv4XnENVG4mX0vp7nORlguxiznDauOvXjdY8I5wpV9o5+zwSaA5DBWAqdvHQdX/6E
	DzlIA7SjLnFbKzdxDh4LfscplRPCKXcbCl6sHBWda0fjBDge9cS4Po29celBW83U+Vy5Dth535GqM
	c60paXmj8wDQd5j4JcPSLw6by9EabOYS24CdkV3ildwunOpoQvv1rL4gKLgBNoXiSQu3e7SMPI8Je
	miA9LTbw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSywH-0007Q2-4N; Thu, 25 Jan 2024 13:34:37 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSywG-00028s-9l; Thu, 25 Jan 2024 13:34:36 +0100
From: Esben Haabendal <esben@geanix.com>
To: netdev@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] net: stmmac: do not clear TBS enable bit on link up/down
Date: Thu, 25 Jan 2024 13:34:33 +0100
Message-ID: <a1d6f5ca9aad795dfc8e0bbb9bb06d8bb7b46649.1706184304.git.esben@geanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706184304.git.esben@geanix.com>
References: <cover.1706184304.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27165/Thu Jan 25 10:51:15 2024)

With the dma conf being reallocated on each call to stmmac_open(), any
information in there is lost, unless we specifically handle it.

The STMMAC_TBS_EN bit is set when adding an etf qdisc, and the etf qdisc
therefore would stop working when link was set down and then back up.

Fixes: ba39b344e924 ("net: ethernet: stmicro: stmmac: generate stmmac dma conf before open")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b334eb16da23..25519952f754 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3932,6 +3932,9 @@ static int __stmmac_open(struct net_device *dev,
 	priv->rx_copybreak = STMMAC_RX_COPYBREAK;
 
 	buf_sz = dma_conf->dma_buf_sz;
+	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
+		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
+			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
 
 	stmmac_reset_queues_param(priv);
-- 
2.43.0


