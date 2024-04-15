Return-Path: <linux-kernel+bounces-145666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A46D8A5936
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC701C2168F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A183CDA;
	Mon, 15 Apr 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="gO43wWdd"
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889C83CA0;
	Mon, 15 Apr 2024 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.41.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202571; cv=none; b=F+vEJg5UOA2xpEEb8VSJYJwAFRz5ftpKLN42kOl64n4MDEO7rJ60Yf7pXWlkMaMlwdFgLNeeTbjv9DOWv9X0heXbsRzKoIrGsAM6fvVLwFaDnr32esrJb719UlF06wD5kRHXjJS667Uoz750K36y91LYfJbW8npUa6YOPCYmq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202571; c=relaxed/simple;
	bh=d2zKm+/zdhfl5CA7Wg12p50NPX81IuLX9P5M5V07qnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=leQzlTF+N32bBR7WhOg5nCNkZQfPPWBlDmNC+kkan9thSxiK9kNqkaOclaUj9nK78kvcgbV+2hmrs4eJom9jhZjpqj6sanZP0CBdZskO1o2+A0A1m47+X5K8Q6U6o/p6m3RpTjRApD+Agq9NrGMAEsk+fmmjJfktW27SvFEC+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=gO43wWdd; arc=none smtp.client-ip=95.163.41.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=noytnkEgHrMBgSkifNJIOoTvaSHXWj7qb/La0lbVSa8=; t=1713202568; x=1713292568; 
	b=gO43wWddvbQ49dBXRkoJYsuuwRvZF5ZVq8W569ioAoz6byo8//PPxyARbYIUY0KHPsiemirTTmS
	EKSWc/cfyJT0MGuseAXHuo93F7iQrcY+OStK6CpiI2HI4bjRYh2wl7gnwTn3638Sclq3yhfUBK33O
	0t/ER1OlFrR/YK/7pS047GFlh1FJfXgkNnSxM8bOk8DKLJtf5S7HGBi/rai9TinUsgGQ0hDSnf+5T
	t2FJba49KHNv6oZOxTaQ61zcElTGll84OEC2hdRgJLJoxgqWJVhB646b1P+LcgbivUhuJapQFkDW1
	24wjRh5TIjSUmSlxDanWgNyIEchnToLqjXWQ==;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rwQFK-00000001pHD-1q0v; Mon, 15 Apr 2024 20:35:59 +0300
From: Denis Burkov <hitechshell@mail.ru>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Denis Burkov <hitechshell@mail.ru>,
	Rob Herring <robh@kernel.org>
Subject: [RESEND v3 1/2] dt-bindings: arm: sunxi: Add PocketBook 614 Plus
Date: Mon, 15 Apr 2024 22:34:15 +0500
Message-ID: <20240415173416.13838-1-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp39.i.mail.ru; auth=pass smtp.auth=hitechshell@mail.ru smtp.mailfrom=hitechshell@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D3342A6001465C01AB48AF3E861E45F6F6182A05F538085040D0E3E7AA877CF64D9487ABAC94A94B54C442939BAB2AB9F7C58EB4712ED216F07F2EA087B10D9051
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FEAC828D2BF6EC3CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063703CC57BD203DAB7D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88A94233F0D66DF2BFAF0B375F22606B54695FD7A20AB108420879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C07734D68A6916D8318941B15DA834481FA18204E546F3947C223C850C94764309F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006375A3B25A3A11CE7E4389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006374E7EFF2C31D5F488D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7B65BC19D6BDA280BEC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE76C35E03DDA13F6E3731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5919D774154250ACB5002B1117B3ED6967EBB93CEDE99A7A2CA7E60A991436CA2823CB91A9FED034534781492E4B8EEAD0BC323893F80E328C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFCE1BD7363616B89DF9511A6418CA89A188509E3ABCE938D1CBC1FC93DA4D7B9E614F3626C4CAF433C84F44966DD9651B9F408388B9B2079814A4B3107F7B67BAE103132901890B2EE4FDFA4A036B0C3902C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwhzzK0WJvz03a5neju4wKA==
X-Mailru-Sender: 7219FA8B682B638D379344632618B47A8B23B6DDDF636CFD578FE190226AD4C0824C1BFBD0166F67DD7143E30D734E3D46315093CA775BF3554C0F224C5326CDBE1FA5EEA7DC04A0851DE5097B8401C6C89D8AF824B716EB5DB38D7CCF7198FF1D0BEC28C16373053DDE9B364B0DF289AE208404248635DF
X-Mras: Ok

Add a new board name.

Signed-off-by: Denis Burkov <hitechshell@mail.ru>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..43491e7f8a5e 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -774,6 +774,11 @@ properties:
           - const: pocketbook,touch-lux-3
           - const: allwinner,sun5i-a13
 
+      - description: PocketBook 614 Plus
+        items:
+          - const: pocketbook,614-plus
+          - const: allwinner,sun5i-a13
+
       - description: Point of View Protab2-IPS9
         items:
           - const: pov,protab2-ips9
-- 
2.43.2


