Return-Path: <linux-kernel+bounces-38584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E283C29D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFFA1F22BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62405481D6;
	Thu, 25 Jan 2024 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="C4uh51dX"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0430481B9;
	Thu, 25 Jan 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186081; cv=none; b=CaVTsCNaphZAyAPd+iF+M0ipb9TMEGyaadvvqZ3paRux4fE2uQaYo67F9AF7Tjnq5Inxr2PL+y0TWzvc0Y4FoKbEt9+KxAdSZhVVJewKYcRCajwqUL/0OKe7LqPR32YmGoHGMeYpeqnCj4CVHMHtv2zj/M7qPLddrbjR1/3DCiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186081; c=relaxed/simple;
	bh=uVcf0VNvF9r7eiInlL/b0K531ErmBBzf5AMiuPl0kog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lutYZ74kEG4fpt3AkELnf3imsldciH8ErqP85kG/dloue+SZrueItRwceCtZOVHGyu8NeYedP5+Tlx97ucJgnelMJDfCbApdJpTCu9B4OI/NhTS9XLbxNKG9SvU7avh/fc9Lq4GE3iuXVvskz1Mntui3uNs9YJb8JM7tatyZ/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=C4uh51dX; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=sqde1eKqHsDxcHA0c/L4ft5EXdAFyz1gweX/+ObrMwk=; b=C4uh51dX/XlieJ7zgcfHMe5mcN
	D8vNmk2uDCQERTOxpyxoTZHeumltyyRkGjjR1sqbJRFuMD1DHu1xVFiHDeS6PgmREtdVdFqR/x1VO
	NxRlLIBZSLzMBZM1e9ST8I+0fN3dQvMhKFsy7RBt3N3c6h+LuHfEZ9YqTb3Yj3okgSo4Hwnx4XzcM
	ONKCH1hwNpVm8daIJEZ9i/u75L85PdldC+dxMyKofRdn4cUQWfwZqc/gkLLBWRX/aubRFbiFnnWzJ
	BEJQejfpXwO7RTO6vJ52ilUe8WjJb4ag9PKC5sWFa/g7nU32tOWy7A3gC13/LtUohrfcQEz7IY1lF
	k4bnULJA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSywG-0007Pw-Hb; Thu, 25 Jan 2024 13:34:36 +0100
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSywF-000258-JO; Thu, 25 Jan 2024 13:34:35 +0100
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
Subject: [PATCH 0/2] net: stmmac: dwmac-imx: Time Based Scheduling support
Date: Thu, 25 Jan 2024 13:34:32 +0100
Message-ID: 
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

It is a rework of
https://lore.kernel.org/all/20240124-reptilian-icing-a95b20f123be@spud/T/

Changes since previous series:

- Changed from using a devicetree binding for configuring TBS support to enable
  it for all TX queues on supported i.MX Ethernet QOS controller. Other stmmac
  controllers with TBS support will need to be updated with similar changes.

Esben Haabendal (2):
  net: stmmac: do not clear TBS enable bit on link up/down
  net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c   | 6 ++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.43.0


