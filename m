Return-Path: <linux-kernel+bounces-64721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5051E8541F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BB51F29FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B126EBA38;
	Wed, 14 Feb 2024 04:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="ebR+hSrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HLb9vM5R"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EFB671;
	Wed, 14 Feb 2024 04:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883665; cv=none; b=l2xAGVysEL57ol1Pr/DrNiw5N+5rf32X+e+bEdia3AcJAV+Rc2DciySTaaZWSu4DCOp5fbzwPjB3rtOXVMjgrVOh2xcf3b+MMQPiMVfnIm8tr/8Lr4YbRbR+n2Nn13/QkiHC2pbzZbLIt5Ee5MxIdpTo5g78CQmo7z4/7PyKFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883665; c=relaxed/simple;
	bh=dUo3yxdmkqC+hy7MzzWVVzN6DArkH2DGsfRJLDSaD4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=imNdCAF54mlHDPCIfB2fR8D/vxh9uRP8tgxJ9eyJ7mGbBtXXx+Lhqjao1aYzjhK5i5zb/D3xZWySXswwvgXe8Wch2Es5gr1kUTEs2lX8j7+TrxJCS62fiVKa/bnSxQOEe4IWva8pXHCluUhEamUNXE3XrlzqeH27a4uK2Kv9fVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=ebR+hSrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HLb9vM5R; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9682D11400DB;
	Tue, 13 Feb 2024 23:07:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 13 Feb 2024 23:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1707883662; x=1707970062; bh=GMD1NKF1HH
	t+RaafvyimydvnSFyaZ2fb3JV7JnKUS70=; b=ebR+hSrTOh4SXfVdX9WXf5CCSH
	F1hfMdPYN320S4GnAUTMmQV/tAoTNgzdrL8o/7atBQs+JLHlnr4ECa+BKCyGZbXA
	/At99rhI8/S/bdOL3ncXP3FVwpkDH3qyEbVqmRa2Ws2SHEhauB/Q+G2jWDJ1jQZb
	0BpW1QFMlzrkinbqvbGcLyCQGr/MFeSUxx3chJdru6sdGl3+b0IfeJeMNXT+083m
	+dRwJA4Lio+Q7fk9YJTJB6HcvgbQFH9h4xaSbKmMplv5rIXf+ibpjEp2cDNYcyM8
	uZzhKTRIW2aQb0b6EBrLeQc8dKBZfiwySRun3o4BUVdEBdkDir+BvPxnnu+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707883662; x=1707970062; bh=GMD1NKF1HHt+RaafvyimydvnSFya
	Z2fb3JV7JnKUS70=; b=HLb9vM5R23RtTQhnSenl8J0NO7Zfr7gCOR4ZU4kCS8IC
	AZbSytJtWZhK6SREcZpF0Usc5hhbgKqwu2WLTFw7XB4C5omYdxPza74VNHbW/YAt
	nFCjpZ+3I2AqTB1I+mihViyZf3aOjCXI8Y+gMivdlUw6gcnJ6MPPxH9xxPQvq6Wm
	crMYY8kunBZz6TUMddUZDQh7E+7g+k2O8fCu1R0Gpv0QVb0u6OB9D/PgJ5gyKHDN
	V9md3MAahGDt6kN3AXM+K2M9mSGjct37Ghc/0josdjLIfXdlD+sic+mrCgUycA4M
	n6iepWhZxfuEPS/IfNlUxbKYQ1eN03nfrWXnQd/CBw==
X-ME-Sender: <xms:jjzMZaIh425qthGnrtisE3LtQsIfyxwMZUNVZzQgNxWOqrTm4ROrWg>
    <xme:jjzMZSL6OgxAE3u2RL124CZEFrfLVOHGXBXyHIbcl-6CVzha9UNypDB-6hET7vWxB
    NEFZkxsKA>
X-ME-Received: <xmr:jjzMZatkjzzVThQer2AyBQ5TXqejeWyDwxfcP-7npb3bwDnIQv4AGPxHFHI60Rr2wTQJ5WslcRrb_av9tAs7MmdUQ4S2Zbzxeqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhmucfnuhhn
    nhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvghrnhepud
    fhtdevueejjeejffeivefgtddugeefffevudfgteetheduveetheetgfeiiedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfhgvrg
    hthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:jjzMZfbqBvpkA_Mo_wpkQGRMDhbQSLe07kjK3pHRGKNgl1JxafZCJQ>
    <xmx:jjzMZRbTFtet1k3gmneSZ3XR9jm8oZjKuPS9UtYr5-IwkaZSkO7wgw>
    <xmx:jjzMZbBAjEMxE4OgBx8yd7vIl7yTh4XM-qG-DXO4pYSL_uuwUwDmQg>
    <xmx:jjzMZeTAi0zUkPBzcBlG9pHBUmE4wk2ZK6Crwf4rI2H-k4Ac3tJO3A>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 23:07:35 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 14 Feb 2024 15:07:32 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org
Cc: Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	David Heidelberg <david@ixit.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jagan Teki <jagan@edgeble.ai>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Ondrej Jirman <megi@xff.cz>,
	Rob Herring <robh+dt@kernel.org>,
	Tianling Shen <cnsztl@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fix vendor strings on Rockchip boards
Date: Wed, 14 Feb 2024 15:07:27 +1100
Message-Id: <20240214040731.3069111-1-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


A couple of rockchip boards incorrectly list their vendor as Rockchip
when they are in fact not manufactured by Rockchip.

Fix the vendor strings to correctly list the manufacturer


Tim Lunn (4):
  dt-bindings: arm: rockchip: Correct vendor for Orange Pi RK3399 board
  dt-bindings: arm: rockchip: Correct vendor for Banana Pi R2 Pro
  arm64: dts: rockchip: adjust vendor on Banana Pi R2 Pro board
  arm64: dts: rockchip: adjust vendor on orangepi rk3399 board

 Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++----
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.40.1


