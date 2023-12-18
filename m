Return-Path: <linux-kernel+bounces-3644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FE816EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE001F234F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9CC76916;
	Mon, 18 Dec 2023 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrBBiWsO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8994676900;
	Mon, 18 Dec 2023 12:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62590C433CA;
	Mon, 18 Dec 2023 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903579;
	bh=9NRGY183+ZrKjPWWEIE9GxstvsmhrLSKBsJzvLGYfcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrBBiWsOQB57cbGiUk3SFIcF1SRqZ4eMDASObSG5rJtZUwTCOhA01zkn5ABf0Hcox
	 XP6PBvUGGmI+Bo9zIdPBadwGAJ8TYQaKPVSBo9Riv1QS3vslpDGJCpP5jnkObo+xZE
	 S3bWGkrwhZx9Gdc0YMpNTSvH0yrtPFIO87VlTjhqZcXF3bI1CMCrkMk9BfXwuIjI6N
	 tp5L3CtYNec+jOg9OKS6PLLusvNig0f7WYkKodgxU9nb+CcijSvjT9j8kPRbVRWYZl
	 87MOoMWpAm9skSskojSLE52gshg6mROiWfMC+zWpDOqdhH+CmvQNeA0IvygxVUpKTI
	 aIzYclVUA883A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 10/13] stmmac: dwmac-loongson: drop useless check for compatible fallback
Date: Mon, 18 Dec 2023 07:45:43 -0500
Message-ID: <20231218124557.1380724-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124557.1380724-1-sashal@kernel.org>
References: <20231218124557.1380724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.143
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 31fea092c6f9f8fb2c40a08137907f5fbeae55dd ]

Device binds to proper PCI ID (LOONGSON, 0x7a03), already listed in DTS,
so checking for some other compatible does not make sense.  It cannot be
bound to unsupported platform.

Drop useless, incorrect (space in between) and undocumented compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 2ae59f94afe1d..a896fadb96b0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -59,11 +59,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		return -ENODEV;
 	}
 
-	if (!of_device_is_compatible(np, "loongson, pci-gmac")) {
-		pr_info("dwmac_loongson_pci: Incompatible OF node\n");
-		return -ENODEV;
-	}
-
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
 		return -ENOMEM;
-- 
2.43.0


