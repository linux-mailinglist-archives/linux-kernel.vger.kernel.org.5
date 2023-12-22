Return-Path: <linux-kernel+bounces-9578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C70681C7DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7EA1C224AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D9311727;
	Fri, 22 Dec 2023 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ivr/vWLx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A292101E6;
	Fri, 22 Dec 2023 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703239803;
	bh=sOvFaR1NZ9Jh9l7ePgit1IhBHGU3t9hoYasnTch1on0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ivr/vWLxd06/abc0srWkJe31YnwBPe4FM/GeC2JhVeVwItQ71/tG++Tf1N1zAz2dJ
	 ha0XR6bRgIQ7XXEZt7VN77vhdQz1XLDDGa3JEjGMKFsL2LdJcutpntXSkc6Rd6nluV
	 WkYvPju9/yI96zSjwK0BMoHrEfEPhxB9Xlscy58sLEm3PikQNG1IQ7Iq4ukFVGrUVV
	 CWVnlD7SAzilSj7RvP7/7txeAPYzCOl7mqZarGCqAYWsP6JbGGclutTS4NN/UCmlkv
	 Y3728o0ktMZJMC4pvZiNlVy7S/j4sr2WPWxMwd2y4JkFxDepiG1S8INOLLNteqG6zs
	 zTVAWrOH5uY0w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8A9183781F92;
	Fri, 22 Dec 2023 10:10:03 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v3 0/2] StarFive DWMAC support for JH7100
Date: Fri, 22 Dec 2023 12:09:58 +0200
Message-ID: <20231222101001.2541758-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just a subset of the initial patch series [1] adding networking
support for StarFive JH7100 SoC.

[1]: https://lore.kernel.org/lkml/20231218214451.2345691-1-cristian.ciocaltea@collabora.com/

Changes in v3:
 - Optimized jh7110 resets & reset-names properties (Rob)
 - Added R-b tag from Jacob in PATCH 1
 - v2:
   https://lore.kernel.org/lkml/20231220002824.2462655-1-cristian.ciocaltea@collabora.com/

Changes in v2:
 - Add the missing binding patch (Conor)
 - v1:
   https://lore.kernel.org/lkml/20231219231040.2459358-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (2):
  dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
  net: stmmac: dwmac-starfive: Add support for JH7100 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   | 11 +--
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 72 +++++++++++++------
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  6 +-
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 32 +++++++--
 4 files changed, 88 insertions(+), 33 deletions(-)

-- 
2.43.0


