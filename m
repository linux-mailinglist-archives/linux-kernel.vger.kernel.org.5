Return-Path: <linux-kernel+bounces-88154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544E86DDF2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C67289E37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085986BB33;
	Fri,  1 Mar 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="coPv98aJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HZLW+IDr"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA226A03D;
	Fri,  1 Mar 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284489; cv=none; b=eHZ5Eavr8L0aOgK/F4bZL7Lv6SZIUJPgOBSX1aiH55pZ+r8jhzRI+m9iNN8E51FLggMK63liGdYUUNzmNfL+xg5+5DaZpNeJrVFjJ5wXbx/IdcgyUvxhb3ko1/F+mO95j9rcgIJp08yoPDvGCzPdinzZjvuZQ5F7C43Idj/x/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284489; c=relaxed/simple;
	bh=4JxCZkA3jktVDeSpS1znKohQppyqfLeAMgfFvoR5y1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYp+VUlB68aeUsR6kqR3ixj81sXGsvMT8yQwP77XL0klXgNJoLpKfuspTuqO466H1H+q7cS5yO7MHV6OEKFiQNhDkrFmO7TB33VADdm6kWmmtC9WnygMR2OqOWd5vsh/knaZ5n7pJ//4/YLncheIX5e0/+SlgyO26t5H0VOwwJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=coPv98aJ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HZLW+IDr reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709284487; x=1740820487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PXvX0hFsuJrk1ftU9mDsDWBiQoXDy5dHNCiqky9uoes=;
  b=coPv98aJwnGiQfWIjLMUMJfdWEOA5wuqk5PuYBuSk7ZpTePG1oH/qjQ5
   /v9kLArxMhtFMynEZnt5LKdxdEb8hJU3O7yRZ6x5AKiiMX3jP0+j5C2Na
   fh7wQndszJTEjWiQuGhvmDICNY7MpKdfx9Vmtlmi9gGVfPXzSD/jkSu/I
   XUq+FB38PWqiTYQUVNNYub1Fny60Yf+pLnGxOG/zEUQn4gxy2Lq89XTY5
   De9X4bVWsNTPZYS3fprALWROmrDgEhSyvSEZiq9Wv5wVLPF95PjLKO/jj
   aW+WFMiVyL4+i8MJhZMRBcbkNxSe31CdwqwjMoFMPQwlJvHW0dczZYY04
   A==;
X-IronPort-AV: E=Sophos;i="6.06,195,1705359600"; 
   d="scan'208";a="35682472"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 10:14:46 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4910717361A;
	Fri,  1 Mar 2024 10:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709284482; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PXvX0hFsuJrk1ftU9mDsDWBiQoXDy5dHNCiqky9uoes=;
	b=HZLW+IDr3Vxskzw6gOH6pQuVmOC0p2/JQ5WlZZwXtxSB1oD2ZVkssWKoTRZBEyGiL9//+F
	saqKZdYO2vvzcWzCrYAOAYY/BGc49ROHSDl7jfBkoGon3kCE8BVoZyd8um4iUKcGHUb/Vr
	qd/g9D0pqpIRQmRUJXJBwC90X8i4bRbovMXUtq6Bz/hH3jqm7o4Ko7u5eODAensTL1Bcr1
	DCPRa9JT60uDYZC002dkqMQsW3iB9557Qno//+qpahQaWph8cHKbkNN6czCFFFyNdylXus
	VbR9lCgpDrwUM+azgLuaWUhjkJi5j84e89T38oqQfDp//FMw7Bpx3gXNZuKDEg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 5/5] arm64: dts: mba8mx: Simplify DSI connection
Date: Fri,  1 Mar 2024 10:14:13 +0100
Message-Id: <20240301091413.3050689-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
References: <20240301091413.3050689-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With the DSI output label in place, use the phandle directly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/mba8mx.dtsi | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 9843c42a3eb49..daba4ba146277 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -359,17 +359,11 @@ lvds_bridge_out: endpoint {
 &mipi_dsi {
 	samsung,burst-clock-frequency = <891000000>;
 	samsung,esc-clock-frequency = <20000000>;
+};
 
-	ports {
-		port@1 {
-			reg = <1>;
-
-			mipi_dsi_out: endpoint {
-				data-lanes = <1 2 3 4>;
-				remote-endpoint = <&lvds_bridge_in>;
-			};
-		};
-	};
+&mipi_dsi_out {
+	data-lanes = <1 2 3 4>;
+	remote-endpoint = <&lvds_bridge_in>;
 };
 
 &pwm3 {
-- 
2.34.1


