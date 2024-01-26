Return-Path: <linux-kernel+bounces-39897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FF83D726
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54741F24B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7C657AE;
	Fri, 26 Jan 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EBsO9U80"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190D657AA;
	Fri, 26 Jan 2024 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260254; cv=none; b=S6LD5GSbHfp7rLFGE7AesSgUu23B4eyTptPX6DBOl7cafkvcWRBbV80KhIE7KBpIR6eksSral1+zHZcprnFCtWX1qA47S+BBMg/oQlOyJCVVdb9GtWk7m5VVTaePhFqHIlQrSkj8IOfs+g4pKZ13VlViQ6M9Lu7lfBCda/QYuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260254; c=relaxed/simple;
	bh=bIj1eE760427Rui5D3HzwJTUewZhLMvbS+Am7GYCxMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FjHCYN1RQ0uiOaQj8g0iMc8op47+RfgMTslJHJQGI2Sgg+dW2i2yhPKf8G76uIJhjLraP3GqPzdZbNBix/QS9rN4dFdd9iVkv8MRedOROnlcfwrbQv6AXGp+dOu+cFHpDrSQy33vsXSWoc806WLysN+qOp71r5jA65UE0QsQtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=EBsO9U80; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=+cDUpkRwZoCkGrsowLN1EeXEXa9KYx2yEQLWfgGSS0g=; b=EBsO9U80tIz2vVWWhX2O2mkFeo
	W1/pNVUwN8m3YVj860izyitoW9TWdbGmhX/sequIUI5EJG8xKexT9iLopnmTSCvVA5DrNtluIyiXd
	9lCzil/59/i6zAbwa61oL50g5l7EtILCaP2mdOzt4epvtqYCS7M21MPiZFOfejEdycryxS8RB8DIE
	/VRdBMe7vyWo0mNERPbc77P2yHwW2v5WqMtnTyi5VOq7vAnbr/KIXEdTU9eNXEYh8ifZRxCsCtnlg
	4f6ZPk/ZGc+ALAb5CUedtTS/Jig6vEH3qOKW4TPm3FqFm3DmA/SUGxsVjx4xC3+lazDNCslNYbGih
	Yn5kBbXw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rTIEX-000Gf6-In; Fri, 26 Jan 2024 10:10:45 +0100
Received: from [87.49.42.9] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rTIEW-0004KL-6V; Fri, 26 Jan 2024 10:10:44 +0100
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
	NXP Linux Team <linux-imx@nxp.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] net: stmmac: dwmac-imx: Time Based Scheduling support
Date: Fri, 26 Jan 2024 10:10:40 +0100
Message-ID: <cover.1706256158.git.esben@geanix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27165/Thu Jan 25 10:51:15 2024)

This small patch series allows using TBS support of the i.MX Ethernet QOS
controller for etf qdisc offload.
It achieves this in a similar manner that it is done in dwmac-intel.c,
dwmac-mediatek.c and stmmac_pci.c.

Changes since v1:

- Simplified for loop by starting at index 1.
- Fixed problem with indentation.


Esben Haabendal (2):
  net: stmmac: do not clear TBS enable bit on link up/down
  net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   | 4 ++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 2 files changed, 7 insertions(+)

-- 
2.43.0


