Return-Path: <linux-kernel+bounces-64724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68C8541F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A070284895
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3B5C154;
	Wed, 14 Feb 2024 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="YH9VuHQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Go6Vd+SG"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B610A28;
	Wed, 14 Feb 2024 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883692; cv=none; b=Dwkjvpo+NDAjepWdvq8hcCYSmzgCrxk1/BTK8ezcxv7G+gOo8IlRu0U96RJMC0hXYrzkbiM2UsBt416wkaeKVajA/yeUDJG0U6ZMmJrugDJKmR9PF99NgN6Wq/K10u4BiPQ/lcyZF912PPEGvhOiIDvNP/GlO2j3rUBnIkfJ4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883692; c=relaxed/simple;
	bh=WIPXldr7rt2nv+AA+Qa/EugihC5nrB6pjmkbXJy1Kc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JdHAzw2EX1nf4JGhpUUzkun9lnTSOT0Er6Bu1+mlEVgg9fQQQpucWeXVlZckPNm6U4lAO6qMjHLA1FH+iChOKpmeSDiCMIOaRJFrJwe2W0JkDdkkPibeKYot7o1MSkQzj+TlYOBZttMdBYivI2yPVEjDzAn0hDTSily1UJy6n9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=YH9VuHQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Go6Vd+SG; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id D2A9C3200A57;
	Tue, 13 Feb 2024 23:08:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 13 Feb 2024 23:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707883688; x=
	1707970088; bh=ZgKlogej5kEsDAelsgKtI++EiRhH8bz+YU8ZTjCX1gw=; b=Y
	H9VuHQL3Ki8PzSB+5R++ADwflmChe/ctiawDTdoeQlmVTGASzFDwjJlR7NRX4f5s
	FNuejuC8E6nfKNctQ65vN2a98+6X6/2tkqRFLXu0wtyo0JE6VgdVAX1cbiurBLh9
	2jXaXkhmtmJj+J4J3+G1efoPl5+1OYtpnCFvz7JQ33+0Avto0Aj0ieY5C6FqPpAZ
	0vpkGLPz77+4kIAfszwuCRPIW7edME502cmJH/W5JqTEkhNTgE6pc8svnL2Lqt9q
	kiIQ9aT30XRvEL8Jrys5F/SNRA15qMzN1uby97+iPMUdQBwHc076y+GHS/VChtD5
	ThCly1DV6nM1XCgqTFM4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707883688; x=
	1707970088; bh=ZgKlogej5kEsDAelsgKtI++EiRhH8bz+YU8ZTjCX1gw=; b=G
	o6Vd+SGbalIk+4g9eigho5oVkz11WIsKwcQcAZ9PGgqwKae0uE6c3fpjAGsSg3KL
	B94P3EhWr1Gt3YqvwM+dO5teDWciocem3Eppk/GcgFaNKNdV+jW7+Ugy9tnIaN8j
	QTZ5jO0lTTYB4t0O4ZGdJJipAGbDmNBSVSEmQ7glyr3KA7IvI0E/hTKhxfW4JIt0
	fEFgJON6aiolTOIjR80AArmrvQj8uEwYoTsx/76CKDgjl8kS+hE9djbB1lCeDaOo
	T4MpTKmyqzftgg/6fhdjMZaQBBMH+7e8TWM0DXa6ykysUpY7zfsn8u420+qNbvQq
	kJgn5MBk/i1rT5hckWG0A==
X-ME-Sender: <xms:pzzMZcMBFn7Y4bXAoFBduMW3wNEhHuUe6ptKM0yiF8GXzU-MK1MgLQ>
    <xme:pzzMZS8OrnbaoVGfLw4kOUfR9i9OFF1QvW_8oSfzEaIt3itQ7BwpXDWlGr1OfRs54
    mSNP3Rdcw>
X-ME-Received: <xmr:pzzMZTScjrXXGWKVn58owgnaWQjNzKfgrRLHMo18_P07Vvymtsa9m1NrM18kVP3xkj6fpEKkR3-f7UKTju7EJP_WCoE4F79KVfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhmucfn
    uhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvghrnh
    epfeffuefhteegieekjeevgfdtfeethefgvdfhteefueffuefhhfefkefgkeegheeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfh
    gvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:pzzMZUum4spCywaKF4u0quVisiK_ZEGs6GR-T9H5uAkI9yhPvTdTKg>
    <xmx:pzzMZUf0T5fefeXpg8EitQQLZUXLHvwjZg_JeFZXADu1usNew0f3EA>
    <xmx:pzzMZY1o3YbI04k2cmtxK61DXP_VscOVa3wwO1GXqMv1xIFkkGIDpQ>
    <xmx:qDzMZY24gneFQO2LNAYJg30fMdlfLcRxeXDrLdxaYM_IuL4EkvAzkA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 23:08:03 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 14 Feb 2024 15:08:00 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org
Cc: Tim Lunn <tim@feathertop.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	David Heidelberg <david@ixit.cz>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: rockchip: adjust vendor on Banana Pi R2 Pro board
Date: Wed, 14 Feb 2024 15:07:30 +1100
Message-Id: <20240214040731.3069111-4-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240214040731.3069111-1-tim@feathertop.org>
References: <20240214040731.3069111-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust compatible string to match the board vendor of Sinovoip

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index f9127ddfbb7d..7b5f3904ef61 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Bananapi-R2 Pro (RK3568) DDR4 Board";
-	compatible = "rockchip,rk3568-bpi-r2pro", "rockchip,rk3568";
+	compatible = "sinovoip,rk3568-bpi-r2pro", "rockchip,rk3568";
 
 	aliases {
 		ethernet0 = &gmac0;
-- 
2.40.1


