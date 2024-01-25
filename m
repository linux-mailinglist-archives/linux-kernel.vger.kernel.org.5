Return-Path: <linux-kernel+bounces-38585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5683C29F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC571C23DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6F4F5F2;
	Thu, 25 Jan 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="TJlznXiO"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5F481BA;
	Thu, 25 Jan 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186082; cv=none; b=rXunSPnh6u+bpMpCdNNMcotQVOZams5BxYLJBn4PxDxs2n+1VU5b/qBgv2ABUVtcuBgNKOOvErfYQrCDpevP5q1D6kLBYHNAY1515myKdCZlQwvpgD1N24KIlQM6PLEyVdX7j5zaY27zXoQlCZWB/zVXTWf3QQTqeTNv2zi8cr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186082; c=relaxed/simple;
	bh=9hpKHMzKfhCYbcecGtWjsCp6NQXfEDCbwraey3X3VO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6OCSWnoLAMXQRRktkv4ZG2hyCNvZfwhi7IXbJ+gSlmNRX1CD/AXPMXuqgaPNu2MuJaiK8cZzVHPkUThlS6G2YkK+lo1Smg+jpr3WW05GrRFVoNgHazp0HioAY28GMtbky2u1MQDCWGfLcqpSIf8lQ5obioYnsQ2bXadtPG9oGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=TJlznXiO; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RGm3cvG/FSHbu0unNfOng+T3r1yzerASsV1ePVGWH6w=; b=TJlznXiO0cIAK+jP6jbhWJsSJH
	krsnIMdXoKbYVw14uv1Den1gJgJLs14y6VMBaxKujr0M0eaKtSRsrIcuf+0MsWDPxjlq8QUM3JcyE
	18eNxt3LT/nftstmpvXEi7xKXHS3x/hkBZvRl3Q1hUfivyojoSwbKt5uw2Ra4+siT+xCmLrs06QYm
	nO3RTqfaH/VU5MkBZyCevNv4dXJwKpuQzXUyuqwujYVMYQj4QbY5Mj+kIaxZipDnny+ishJKGxdFO
	RHYryUL20/e/0gcHBDOQvq8IbnKTvMxf247BAnlBtrlNoF105KN8VajjacSzeIN2YIZxLJuGuB3d4
	yg4Krd6g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSywI-0007QC-2M; Thu, 25 Jan 2024 13:34:38 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSywH-0002CN-04; Thu, 25 Jan 2024 13:34:37 +0100
From: Esben Haabendal <esben@geanix.com>
To: netdev@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings
Date: Thu, 25 Jan 2024 13:34:34 +0100
Message-ID: <5606bb5f0b7566a20bb136b268dae89d22a48898.1706184304.git.esben@geanix.com>
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

TSO and TBS cannot coexist. For now we set i.MX Ethernet QOS controller to use
TX queue with TSO and the rest for TBS.

TX queues with TBS can support etf qdisc hw offload.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 8f730ada71f9..c42e8f972833 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -353,6 +353,12 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
 
+        for (int i = 0; i < plat_dat->tx_queues_to_use; i++) {
+                /* Default TX Q0 to use TSO and rest TXQ for TBS */
+                if (i > 0)
+                        plat_dat->tx_queues_cfg[i].tbs_en = 1;
+        }
+
 	plat_dat->host_dma_width = dwmac->ops->addr_width;
 	plat_dat->init = imx_dwmac_init;
 	plat_dat->exit = imx_dwmac_exit;
-- 
2.43.0


