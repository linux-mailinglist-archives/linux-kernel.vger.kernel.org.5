Return-Path: <linux-kernel+bounces-90135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92286FADB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5901C21709
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A117C6E;
	Mon,  4 Mar 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="WETvWYy8"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07C17C69;
	Mon,  4 Mar 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537433; cv=none; b=oejoVK0bSPIx7PAgNbWHQDlu3G/VG/Pym3jKt4CUt/bp9nI1vMPXLHqSMHjjepPcxGBRbci3wVRd++7x6uT3kEfgRkLMhKzyCD83zI6hf9rmCC3RVVmM596Cd9MMqly2IiViEkKQwbeodIdEBuhaPKYM/52ZTRfDSBhEdAo82YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537433; c=relaxed/simple;
	bh=465cP31JRMr94nU0gRhI1fk1wJXGTQoV5XYegVLKIvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lg+Yy5clq/RqivEYNF6QTN9Bpi2xO/ST5BbgbkOJL1wVLK4DPC17nDpXfKYSINuPKNDV7QOnUO3cV7HHDb/yLnFuGE/05lvQo20ozSjyguB+H9muAdXNPEAUCgKjurqkAiiWvC04X4RWtG/YnnlOegdbCzy/tIoti/X7Q3wm0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=WETvWYy8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tp9Mm0bnbz9sQJ;
	Mon,  4 Mar 2024 08:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1709537428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPqo6ggfchf8Eo8IzHB61o1N1czixDrkgbYRsxezN8c=;
	b=WETvWYy8KnRKnpbEBwTCtY8rSUlT4nt1jNvhqkNc7xjfoZzwJPVQHAgNrO8QQCCfC2Ywf4
	DFAprV6WH9qCU0kujsvsYd8/nRlBCUw2OwJNmuGm+QqSOENyuQ8amvQ1dhtH6x3Kg1Gl4X
	I2m5dRMkohZwACsniickAn39G80NZIJp/c9VBFlA5X00F+c4LUK2A1ppjrVeIb8PK7nDmg
	mfFNbnARLoF0iWW8pvNzbACozuHmMbXE73vyAoZeVoYyg6cf7qFuLkdjJsMPCUdkOul1uW
	YNzJLqC29oEqXFppvJxiup0jTTbUGYilnYIO7sh0Cn4BHpcOviVrmqqIBkAryw==
From: Frank Oltmanns <frank@oltmanns.dev>
Date: Mon, 04 Mar 2024 08:29:21 +0100
Subject: [PATCH v3 5/5] arm64: dts: allwinner: a64: Run GPU at 432 MHz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pinephone-pll-fixes-v3-5-94ab828f269a@oltmanns.dev>
References: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev>
In-Reply-To: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=465cP31JRMr94nU0gRhI1fk1wJXGTQoV5XYegVLKIvk=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBl5Xhx9BxlpyXsETgIPW4+KIkZfwF26bL53VDWZ
 sb0uVOWRt+JAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZeV4cQAKCRCaaaIIlErT
 x0iXC/9kAUvpZfp08Fa9Etq3guQAB/WTkntp+YOU5esogHDIPMLVL9s8J3BmVymEMsrwcZGWYf6
 /Fg40Ek4gdlb7ubQx+uwcRrSmoQlnM7iALQdSnV0PVDLR9BGdfyegX+5OkVcOVxe0eodfmqylN4
 oQ/6hL7exkBjTiHjeZjtrt3nfyl5DGK8cyXLjjo+Xz1oV6C5BXsb4NMN1otFkAlhud8aV80lQgE
 WcQo7zr1B6odwuTnMTZVNAZMfeUdu2uc3WHI7AM4djqvj8EdkJk8Xtwm2mRehBL4gk7ezigkrDi
 mk+GFzrdamKg9XQEZ8STQdRlG6xq7XmefS+Vyl5hB6WnjdFZ8iW3rTYcvsBWn6UxVtXAtDNEXUn
 B2F6Z5ZT6oJlKqw78J0U2SkrNpUMd+7oChTyDKWGXGk7Y/yxW48gCU1r1jXw6eVkf/K7Rb3Vyor
 VPpbsDlGiGPIEdOUugWl5YknQ41mKlMtr1azRyBGMTeM7sW4CcVJajx2QDdwhnQMvG2cI=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7

The Allwinner A64's GPU has currently three operating points. However,
the BSP runs the GPU fixed at 432 MHz. In addition, at least one of the
devices using that SoC - the pinephone - shows unstabilities (see link)
that can be circumvented by running the GPU at a fixed rate.

Therefore, remove the other two operating points from the GPU OPP table,
so that the GPU runs at a fixed rate of 432 MHz.

Link: https://gitlab.com/postmarketOS/pmaports/-/issues/805
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57ac18738c99..c810380aab6d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -107,14 +107,6 @@ de: display-engine {
 	gpu_opp_table: opp-table-gpu {
 		compatible = "operating-points-v2";
 
-		opp-120000000 {
-			opp-hz = /bits/ 64 <120000000>;
-		};
-
-		opp-312000000 {
-			opp-hz = /bits/ 64 <312000000>;
-		};
-
 		opp-432000000 {
 			opp-hz = /bits/ 64 <432000000>;
 		};

-- 
2.44.0


