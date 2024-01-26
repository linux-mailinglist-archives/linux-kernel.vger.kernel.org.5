Return-Path: <linux-kernel+bounces-39896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBCD83D72C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CD729D1F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862C657A2;
	Fri, 26 Jan 2024 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="FOAZbZQB"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6B65184;
	Fri, 26 Jan 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260251; cv=none; b=Tsdpl7/tX0eUrd3UgMKpMF/e85lyq0uBThTYbRlXXPQz+TYTnh6O4ntOEZ+zFZVQaGQS0qyhpCZkyO6MTG+Oeeh5WTJt3RSKC7By8C5vULFruVcJhHfG1jQwdRw1xWkyJGoZn4PjomiRy/zYG/5gwudJTViLYG7jTsGuBdhXQf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260251; c=relaxed/simple;
	bh=V+AK3plKZ83loJsgfrWwEsHnqolt+UEFeeTqAZesOLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEzPIlF2xNIplk4LjX7uN48bEmawgIN8Ir3GXsa5Rh0fkx2G4wvxwO7RF5D5yyZq4mqVvvGyM16zc+txjHEMxhSFXkqcCWgL16RTa0TDp+g5qz38IiHeWtsFLUrnKELci4KIyweU39CJNWZFx4R8q96wuaySl8MT4y+hTNy2xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=FOAZbZQB; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PfIWJgaCYljkJrkeOSurtuPSrNuyp8EvqXe2SqiBP2U=; b=FOAZbZQB/8TrGEUxHTYEu6+NRW
	tDW7a13KET237Bie/VHxFPTwe/HKP/NsfDka9FALYHW3mOHF/NkFEB4VTRYGoZbUz482tvBY16G/A
	zFWv8dF6JVH1HqgcUUx+R2a/WXJrW/IorJk7xe1IeZ4o+F4dCmdc5uJxW/TSmskHpgU+kNfd7aiIg
	Fcy9/vgXW1QP7yprfy2DrVot7wdJP3N3xEmymh0EFmtbeOR0eFeKMuACpFiOLwnv9hdNWIjNpU1F/
	OtwONQtlE3kuvAC81vmvV5oQY14/sTAFzXy5BECayHlynPIcOJ+QQeQ/l17KViBh4uxxA6wXpwJgV
	9c4mimsg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rTIEZ-000GfM-47; Fri, 26 Jan 2024 10:10:47 +0100
Received: from [87.49.42.9] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rTIEY-0004ZG-03; Fri, 26 Jan 2024 10:10:46 +0100
From: Esben Haabendal <esben@geanix.com>
To: netdev@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Rohan G Thomas <rohan.g.thomas@intel.com>,
	"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings
Date: Fri, 26 Jan 2024 10:10:42 +0100
Message-ID: <379f79687ca4a7d0394a04d14fb3890ce257e706.1706256158.git.esben@geanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706256158.git.esben@geanix.com>
References: <cover.1706256158.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27165/Thu Jan 25 10:51:15 2024)

TSO and TBS cannot coexist. For now we set i.MX Ethernet QOS controller to
use the first TX queue with TSO and the rest for TBS.

TX queues with TBS can support etf qdisc hw offload.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 8f730ada71f9..6b65420e11b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -353,6 +353,10 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
 
+	/* Default TX Q0 to use TSO and rest TXQ for TBS */
+	for (int i = 1; i < plat_dat->tx_queues_to_use; i++)
+		plat_dat->tx_queues_cfg[i].tbs_en = 1;
+
 	plat_dat->host_dma_width = dwmac->ops->addr_width;
 	plat_dat->init = imx_dwmac_init;
 	plat_dat->exit = imx_dwmac_exit;
-- 
2.43.0


