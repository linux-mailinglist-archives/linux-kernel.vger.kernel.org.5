Return-Path: <linux-kernel+bounces-64725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D58541F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650701F29F67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3526510A01;
	Wed, 14 Feb 2024 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="n4r+WwaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ix29FDKW"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9BBA46;
	Wed, 14 Feb 2024 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883701; cv=none; b=qx9EHnjdf4xZDGmDizg7seAy4XEC9G26gnUd64DcLo5sHzfSqm2FJ/3WOa9AWnmZsbNdwKyq1juy80uBKJmztZTtxVGSuzxoDGHWO5e5xnlBGZNMx69fOay5R7xIdavEh+GLaIAT7bH8jtLJ12cswN+aJx77LT0Dot8bpdjxhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883701; c=relaxed/simple;
	bh=q3m82E7/yf+o8OwFMcBEiYpHUYOuWXod+duJNvWLjqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrHWbOiiUD/+sNhH29Cn7Ai4bWZq3uSA7RhYnFoQd6KroOUNwb+kxcGEIz4j1ApUCJQoQmxm8ZPWW2QdikjRH5TZ/4872IM0xqNptwrHEjY7M5M7xPH0UgbjJxuXNpKToYnZJYNJo/u0PVKnRQZU2UD15jcfn1QbwapZaLldxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=n4r+WwaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ix29FDKW; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 274931800084;
	Tue, 13 Feb 2024 23:08:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 13 Feb 2024 23:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707883697; x=
	1707970097; bh=dpyL4PQAJGDQZibg4w7Ubg9AMrLDbdkCnl9FxVnyHf0=; b=n
	4r+WwaM94dlOXT/D2fCePU0mDJEFJKT97Kc95S9ZpC9rsOrsJElLpsvLtHH7MQI2
	NDrqwkYBSJ0NT5lHDuTFBuVj9rVoatVxgy9o3fpzXZIRU64QA2LmK2i30Gqd1fkV
	vJQaD7YwKx+ImdamncZk53Xsjv4N7tcsk8cRU6v5yNgoPeEiWUlsVu8s6EUuN9/e
	ogpO3PuwYKIGtD8PuyYrnNhzTcjVUJRhd7QtYXVTgJX9xceyK7sZ7/BKGuIZfJnn
	s3mSkrTOoLS5alPIP4vIn9YJRzgkMsttKJuqREdbBNCQ4xPdHaAUieiU8+E5eQqP
	9wScZhOGUHJw+GrxcGkiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707883697; x=
	1707970097; bh=dpyL4PQAJGDQZibg4w7Ubg9AMrLDbdkCnl9FxVnyHf0=; b=I
	x29FDKWXdVs7BNpW0s8y2Qno9puAUdzgTYRMKcYudtYqr9LH34UXklzYBnyjzYUX
	9cXKTFGN58Ij75uAtA8f7icUGWwsEdSy9kfCTvjr9suoLo7bwPUxxYt5o84KuuZN
	QJYj6A/UJUAPZPAmAMwMU9CfFVCAgDOnhUx5TvigoM2UqZbT5SDILw5DoHy6aor8
	5vQWxyzfIwOGPiTGCJMHN9xYyz16KDvymtcQJMh7YyYfz2maoZcY1ULVKartWrkT
	vhrs3WB8K1Pnn+xLc7Del+yHgr8UIRXMG25727mcGToJb+zO6DOszW+mNk8k1fnL
	diASMEFJ8D9T0sgWpSJnA==
X-ME-Sender: <xms:sTzMZVQFUAkzubDY17qTsgCkmuM1203vJ_VY5oxHKQZOg9AdxaMrhg>
    <xme:sTzMZezYQeX5vd4DhGLrGthU0T-6jJQn94vMXJQOaHsH9yQuuwUsvkahcdqE0lxHY
    g15rUORSw>
X-ME-Received: <xmr:sTzMZa283V77HkV4VPU3NgT5MPZR8klXM2i1Vz2i_jp8x_WPNienyRkuuKuVj7SmUVJRdTThYd-zo4B4O1-nDdZsY0ROVDXdLEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeigdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvihhmucfn
    uhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvghrnh
    epfeffuefhteegieekjeevgfdtfeethefgvdfhteefueffuefhhfefkefgkeegheeinecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfh
    gvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:sTzMZdAvTNaPVIf5q8f8f4yS1dwou4jbN2iCpMK5ZxAFsA-yJRlNxA>
    <xmx:sTzMZej_aGGJctJe_3QGJOyQ5Tevhvdn7hMCjShE4Tl1dEmmcmv4WQ>
    <xmx:sTzMZRoCZmr52-Rf1ZrRnXMmcU4a0THBA2VKNLZfUYAzHgETZ21ayQ>
    <xmx:sTzMZTZcLxMbZXAttWLlCVh7O971ZoRNnWXcx0lHkKXZyjfIGxKPKFiLfdQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 23:08:13 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Wed, 14 Feb 2024 15:08:10 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org
Cc: Tim Lunn <tim@feathertop.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: adjust vendor on orangepi rk3399 board
Date: Wed, 14 Feb 2024 15:07:31 +1100
Message-Id: <20240214040731.3069111-5-tim@feathertop.org>
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

Adjust compatible string to match the board vendor of Xunlong

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index e7551449e718..e26e2d86279c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Orange Pi RK3399 Board";
-	compatible = "rockchip,rk3399-orangepi", "rockchip,rk3399";
+	compatible = "xunlong,rk3399-orangepi", "rockchip,rk3399";
 
 	aliases {
 		ethernet0 = &gmac;
-- 
2.40.1


