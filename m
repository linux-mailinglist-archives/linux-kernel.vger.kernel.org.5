Return-Path: <linux-kernel+bounces-64175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFB853B35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CD528D80D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F260892;
	Tue, 13 Feb 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC5yv0wT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18636612DD;
	Tue, 13 Feb 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852924; cv=none; b=EAomfMVohFx9j0iQ1Q+bxG4nWjIzwWjL1wIFbaoPz+LLp84SYEk6sKXkBLoatAMb79XDSZkcIaWUaZEulBdb9j9YTc2lY9ncFhpwmN0+UPbkw6L7UnGd40X9yCQ6XOlT58PIowyI7CylTJ/VOrNIyBy0aH1Tmqg8mkssA1rIVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852924; c=relaxed/simple;
	bh=io3IHUz4w8uho1fRTkKUDdRHdXN+FkOTbGUXes+HSwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2kNt6sRgG/Bkbo8Soy8Yzb8LbVnd4UMb67JpROlze/Z6NfsSLckN9wo3c9hwEIXlF+WFYct55dm8i7I4Oi8OGZQ9XhV6dSFp+dpKKhmkPa16WIDjxbYFGcGDyH0ZyL1FV/Cd7xBuJQy/4uqaLhlYjSjEENo73Tiw5T8pZ+D8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC5yv0wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3659C43390;
	Tue, 13 Feb 2024 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852923;
	bh=io3IHUz4w8uho1fRTkKUDdRHdXN+FkOTbGUXes+HSwM=;
	h=From:Date:Subject:References:In-Reply-To:List-Id:To:Cc:From;
	b=nC5yv0wT3DgPAYxk67YpeyMCOPQkCYoByAe0P20ibCZ2ZwpRXd+xIv5AqQOnkRr62
	 cxdPJbNSI9jT3FXpYwVYIOXR0ouq46nNz4TLHhI8H+vMT3ps6nVXceSfGHHKwtREYx
	 Sbg3UPfGR/V5C3yWrSox+lIgE9ejNmJT1TANOBTxvAUGXTTudhW4ND1OOaXvjablDm
	 Pq1vKqjSz6KCFP5XAlEcDdsbF21T3QakjhMnzYri2o5fnkDrsWQ6GuLtLe9bTHjiVY
	 BZU+xASTGTnd1z8TXb/DlPot58ZDRaKwIT9h2dNK+T45l/LYEdnroleltXx5US+sPV
	 GKvPP5SxiGlCg==
From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 13:34:30 -0600
Subject: [PATCH 6/6] dtc: Enable dtc interrupt_provider check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-arm-dt-cleanups-v1-6-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
To: soc@kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tsahee Zidenberg <tsahee@annapurnalabs.com>, 
 Antoine Tenart <atenart@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
 Tony Lindgren <tony@atomide.com>, Chanho Min <chanho.min@lge.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Imre Kaloz <kaloz@openwrt.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Mailer: b4 0.13-dev

Now that all the interrupt warnings have been fixed, enable
'interrupt_provider' check by default. This will also enable
'interrupt_map' check.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cd5b181060f1..fce35e4657f5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -340,7 +340,7 @@ quiet_cmd_gzip = GZIP    $@
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
-DTC_FLAGS += -Wno-interrupt_provider \
+DTC_FLAGS += \
 	-Wno-unique_unit_address
 
 # Disable noisy checks by default
@@ -358,7 +358,6 @@ endif
 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
 DTC_FLAGS += -Wnode_name_chars_strict \
 	-Wproperty_name_chars_strict \
-	-Winterrupt_provider \
 	-Wunique_unit_address
 endif
 

-- 
2.43.0


