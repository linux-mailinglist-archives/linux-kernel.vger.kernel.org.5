Return-Path: <linux-kernel+bounces-52896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5EB849DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BC6287C53
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CE93FE5B;
	Mon,  5 Feb 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="p5BOTlx7"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18463FE5D;
	Mon,  5 Feb 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146607; cv=none; b=D1YACqvJzQuFMRcMxk+20iM2G68oiOQx9inGUK+L1fWORg4pSAjwjmWageyI++LVjrKenRWZCMUqt8TIb6KZ4DaLbL6sLoYuAm8T4e3VxTLPCzASVqMILf6MEG/2oXRZZOgBoa2NNuNiYQS1I7nJqym3npusjnndNvIhTZLMfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146607; c=relaxed/simple;
	bh=zwBfjIxPZERVFfsaNgpqFLdeiKWw7hboXJ6uRiKwYxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVemkB+gQPWRl6IC/Qo4ZRfcIKk4uEO1H9dE99Peoee6umr0sqhLSxLnmJYBnefvzMRJ7E1ZLONdyA7ga4+zEZ0LPwFSbXovKf0nPQTUURa5fzJvD8RO3CfXjDJf4+wzw7OHlURYy1Kb3S1zHiTQkJIwjzoPvZ03y/pK6cY/qnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=p5BOTlx7; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TT9BJ5DfPz9swV;
	Mon,  5 Feb 2024 16:23:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1707146600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qC4mq/tsfLRuzLmRs5JjHQXl/DynYoHApRzxf1WL2uM=;
	b=p5BOTlx7BFzH5jfkDYpQViWSxKs5abIL8hm2KzHBy21+XzrQNcnG7drDYZmaNPxgoq6svd
	VOSQLdXUhkmNUjvvyni3MqpxfHJ9FfT9ALjLCZUljFNWk19ObC6iFsezdkutZunV5B8fHZ
	jB+XIXs90OYNf3K9Mt+jErTvhXbdBH2ROAKG4uAEMbwpQOo1819ukPoEBy4tBSRQqt/JOf
	8anff4Wsl++LcK4cx5OCjA5bJWAMRppsY9M4jJCNb+xzJPwHfl2rW/S52m2QxEs4zPnOTp
	iljLh3JK+krTqxPfsWyMMUrjP6VeycUjCDdi+Autvy4D6dY/G0E7QW2NosNGUQ==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Mon, 05 Feb 2024 16:22:29 +0100
Subject: [PATCH v2 6/6] arm64: dts: allwinner: a64: Fix minimum GPU OPP
 rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-pinephone-pll-fixes-v2-6-96a46a2d8c9b@oltmanns.dev>
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
In-Reply-To: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=zwBfjIxPZERVFfsaNgpqFLdeiKWw7hboXJ6uRiKwYxM=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBlwP0/YywsMvB2h9f3zxar+UUpwxyriOAGKTLGS
 ZdrqQvmPRqJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZcD9PwAKCRCaaaIIlErT
 x3RxDACBLK+cLnbt4nqBmvnVYYuwNDvDRxFAxO4EA3xfHnuyUi9obGXAhbHRwu5r0O73xHPRVNr
 4Wom+6tBs3/fQuItFP79IP5TmiAFQrzSkoGLQ92bS5iXGhBEcIYFwlpkUXgOrCTqtXWypBAdp29
 RAQI6ih2i6NilPU/cyy0Y+cdmz/NlslvlnloC2NIgNtCgna8EqxXVuznxxOIsfw70TXsMZa7FEL
 nG4hYb1xsmY98DZy2qeZA3OJNg+sXOyxL+J3Vey8KfaAx3NJdZ5eQo0RiwX/Lrvc/bOweP6oovx
 Bs8nYRM/GJ5zndYzn49FwuuIIzmtWco7Era813fL1BsSdT0EdMFQSE4b/7TqbKkE3zj9Xnq+9BD
 /P0du+E3yb6d8fHwBbUqfBL6QtBVwrxvsC68I5utxurpsD07McLUo54uaOBRrufJoJHceUfjGRV
 vGonUD0GohydlHH8bkAhELUd6IZTEOOawyGWyIOycvEhaBrM5Rmbdj1jFE/oBIptqjiM0=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4TT9BJ5DfPz9swV

The PLL-GPU has a minimum rate of 192 MHz according to the A64 manual.

If run at less than 192 MHz the pinephone (based on the A64) sometimes
replays the last few frames that were displayed over and over (see first
link below).

Note, that running PLL-GPU at 240 MHz and using a divisor of 2 *should*
circumvent this problem as well. But unfortunately, the GPU shows the
erratic behaviour even more often, even though its parent is driven at a
supported range. This might be due to a similar issue to the one
observed on the Allwinner H6 (see second link).

Running both the GPU and PLL-GPU at more then 192 MHz reduces the
occurrenc of the issue.

Therefore, increase the minimum rate in the GPU OPP table to 192 MHz.

Link: https://gitlab.com/postmarketOS/pmaports/-/issues/805
Link: https://lore.kernel.org/linux-arm-kernel/2562485.k3LOHGUjKi@kista/T/
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57ac18738c99..448d7fbdd1a9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -107,8 +107,8 @@ de: display-engine {
 	gpu_opp_table: opp-table-gpu {
 		compatible = "operating-points-v2";
 
-		opp-120000000 {
-			opp-hz = /bits/ 64 <120000000>;
+		opp-192000000 {
+			opp-hz = /bits/ 64 <192000000>;
 		};
 
 		opp-312000000 {

-- 
2.43.0


