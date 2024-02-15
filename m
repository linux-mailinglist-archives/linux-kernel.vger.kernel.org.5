Return-Path: <linux-kernel+bounces-66737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA68560DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76491C2098D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66B130AC9;
	Thu, 15 Feb 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="DNHvgkzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IRZkryi8"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBE812A158;
	Thu, 15 Feb 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995087; cv=none; b=NdF4IT8F9eXcEuyf518rt9Ir/YBMkPYpvU5evV3BWMfTXgBrgeQaiY+UZNbhHwYlOid8U4ZaBOTD0Aeol7cozvPPwL2ecp1MMJWIM9SSyYDb4MgySlr4F8eiU3KLOOhMt0vJCeOT8ukDuAjNQW7NPrFleNJABNfHwrwS4/K/48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995087; c=relaxed/simple;
	bh=rbGRMZ3cxaswu2boeOYhbDqIEk0uTkwd0y6N3QTqW6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Stq5X5BIpm8AVVlaplrlyCXNEFz1QtEeO+QBaw85w0/KI0jOBITGxyUff1a6AAaX2nhGcRCYiotDV/cXlk8skWH3zJFcJlrTGTC/xAgYjHiVYdXe3/OITK8aLDf/9OQl44GW/YwVkV90G50JVjURc127/tIGmWc2/UmgP0Iide4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=DNHvgkzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IRZkryi8; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8A60B11400F9;
	Thu, 15 Feb 2024 06:04:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 15 Feb 2024 06:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1707995084; x=
	1708081484; bh=hqHAzAJRp5parpjb2dKyLOoSMeJsSciKAVogkFU4n+A=; b=D
	NHvgkzYEPk8GTM9yH6mWs5KT75juXzU1Xy9lXVPDOROGK/R+u/SWC/b+blV1y3Er
	7bEgxVvVgJ2XrFJ6LZgmphbiRnAQJE3fSOsvKczogEEWs1A5KS3rfxl5iAcrksng
	9uJTro37kW+pJq6sFtGWTPUvNL7cM+kmqrB7j1DeG4FQDIZsBfO84PJu/vEltKzj
	1yWhjvePWBjZNoK51FoR8cT8gxFhC0T0X+lgzxQVKWqfYlo/s4YCDzGKrgfNQ3Ng
	g6ZVHNgBP5Itxnc1Iu+BNXqoMZ4GlAKlShwBzm6vIhUKWZEJYT+v3SbM/CftbpOI
	QvzpPxNkPYJ4BOtk+eK5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1707995084; x=
	1708081484; bh=hqHAzAJRp5parpjb2dKyLOoSMeJsSciKAVogkFU4n+A=; b=I
	RZkryi8Ke/Jwufb+MQJO1MHvX4AIHt6l46gM9MKkh1fvwfHgpXTI32aH8iWGVYH+
	5HKQ3QXLE1Tgmv4/N42emfZ6BqYeihj+4J4uenCBr6UzoQpWjzw25lIaqPzuV5FU
	fludYWQbLoA4aqb5/wnZ3PQeGbmxhOnKITvFS8XNgHSt7n1jCWloTGTCDFEn0ewP
	YpOQwiYYcDd3ng0tyZMUpMX5E/QsHuJ00pDIBvNCI1+y6NwISBOYJicnKIvCc+Oo
	IQCSMY4XkFUMrQvmkR3XM+owg2lW42Gzni1Gaz76zE7EGqEa905+fKOnxLjUTUcx
	mY/ogjD9ATFLmTT22j4bA==
X-ME-Sender: <xms:zO_NZQ9pQoafWuWOnXDmgNEe5NBqxTKwJpMe2iYQsk_OmDbYux-NYQ>
    <xme:zO_NZYtRdPgl4w0cTxPICMjlHVnA2xXHIUm7SvbomjJk3aFEihWGPtTKGx2WSfQRh
    _9Oy4b6LA>
X-ME-Received: <xmr:zO_NZWDyTfgf33-XtLKc9KSAf_1DjUM08tYcJtc2Wp5HHSu350BGyN16E8gu-dr3pzJg6KLDeSzbD6xEpHh1IjyXItxx6QVVNtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhmucfn
    uhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvghrnh
    epfeffuefhteegieekjeevgfdtfeethefgvdfhteefueffuefhhfefkefgkeegheeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfh
    gvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:zO_NZQffVbYi2mbZ7VI5A-6Y7L4_vt9RBm6z8QHpnz-txczs6Nv6XA>
    <xmx:zO_NZVMEqLF-Zw-vDK2h5uZMOrZUFl_CzG7n2_E-3RAx9M-W3Z6BLw>
    <xmx:zO_NZakF1w81Q2glqMLLZzbCJRHBc6xv4qDM_KEsGw7bNwtlF7fVxw>
    <xmx:zO_NZYrPzMMp3IRmRurbE-mROc9Cq-JDUVwaSOxnNDXWgBk-U7qP2Q>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 06:04:40 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Thu, 15 Feb 2024 22:04:36 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org
Cc: Tim Lunn <tim@feathertop.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: mmc aliases for Sonoff iHost
Date: Thu, 15 Feb 2024 22:04:24 +1100
Message-Id: <20240215110425.934740-2-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240215110425.934740-1-tim@feathertop.org>
References: <20240215110425.934740-1-tim@feathertop.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add aliases for sdio and sdmmc to ensure consistent ordering of
mmc devices on boot

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 arch/arm/boot/dts/rockchip/rv1126-sonoff-ihost.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rv1126-sonoff-ihost.dtsi b/arch/arm/boot/dts/rockchip/rv1126-sonoff-ihost.dtsi
index 32b329e87a0c..ba6c3a674f22 100644
--- a/arch/arm/boot/dts/rockchip/rv1126-sonoff-ihost.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126-sonoff-ihost.dtsi
@@ -8,6 +8,8 @@ / {
 	aliases {
 		ethernet0 = &gmac;
 		mmc0 = &emmc;
+		mmc1 = &sdio;
+		mmc2 = &sdmmc;
 	};
 
 	chosen {
-- 
2.40.1


