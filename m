Return-Path: <linux-kernel+bounces-88153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2B86DDF0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F96428957B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA76BB22;
	Fri,  1 Mar 2024 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jlaP7MK5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Z9+iwUyt"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8186A8DF;
	Fri,  1 Mar 2024 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284484; cv=none; b=UCar2c8N+hgPPEuXG/Y4NtWpN6lDfA7hnLwQtYQaat2TmfF1mmDHMb+4WTo1HvNS9Gg+VXkYxE95nHJIiR7YGpm2dB86v4NRS+L1Cp5QF80pxC6Vpu0/B+Zwt3H/NzrY5yLSKZo0oaUxhzCiVdYv8pyETHxgIyrWbRpvbAILP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284484; c=relaxed/simple;
	bh=opkE+5l36BtfO7mWRYzut+e6GovVR6un6oQxccMTb24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDN7V+2OLJVP1yOoe0sduq60zBNP98HFfsv1GaPMkOXCbKITe8NT+40mzeD93dTiglmw5gVleplaDbL3Mr0FZuEKJOgGjbpsANn/ZJb2qXxviJadHFhwf1ryp6r+rI9Vd8fxQSsgLYQHLATRBkDN3QY5g3+KSj3KZIRjBZ9phVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=jlaP7MK5; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Z9+iwUyt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709284482; x=1740820482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nkp26N0RJUFIoFiA/JvHPHTGX6QmCu2O7lzECrLEt+w=;
  b=jlaP7MK5oM1/lqVnfKKdwxOgKGV7/H6r/0Cg1r8ZtfIuSSk9h6qpT1aL
   SAshVwTjRtA84ZkgUy6NxIOgSbbb8BdQVVuy9oECqC3HHdohsLDow2jIE
   NX8kQ6gDVsf/T6RLn57vqklvdZ4Ml0EH17qgGH+zd/LAy+qf21F/V3PM7
   ks6xZwVvq8GcNdVIjdwJDQxKXjR7EfvCffONZtjP3sqMoT6nTtI8P7qfc
   sZt5UeVS7TLLsRL1OqvIwAdKAM3NAkWyKZqxDRoaxKmBzUCSriy/yYpj3
   mKfnRl/ecUneAX0zYtjp2WcXkYtbh6w1kBcF3CBE8UDLl2ttwBAfhToOL
   g==;
X-IronPort-AV: E=Sophos;i="6.06,195,1705359600"; 
   d="scan'208";a="35682467"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 01 Mar 2024 10:14:41 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5BF701735BA;
	Fri,  1 Mar 2024 10:14:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1709284477; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Nkp26N0RJUFIoFiA/JvHPHTGX6QmCu2O7lzECrLEt+w=;
	b=Z9+iwUytXNxkL4XU9MZsYN4Jff1vCk3u8RFxR0qAnAyXTYXBYf+gFSwraxd0w4b0D81Vxx
	7QdQRDGd0LwdYBqZ+edDaantvi1wU7SD36xRChKYpSh3piGhR/ip3uxpPlpzoNqkzhqKeN
	L5lNZjFjwtsW9QEIQkLapfCeqHZh+/jSz/KFB7m1BY0B19EpqKaRDUwSj6d2uGARMAY9L3
	wPQzvmP5HCOU+eHh3gaHZ0I3ZMNzJDbgt2RF9K/+frG+K7vW+Ir8Z8ELF3xfV4GHt8fFXB
	EfP0HCn7Z/OjhOLpJsjY8VcaDVQul728raMlPpz6SVAZShd5L3qYNfUyEC1AAw==
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
Subject: [PATCH 4/5] arm64: dts: imx8mp: Add empty DSI output endpoint
Date: Fri,  1 Mar 2024 10:14:12 +0100
Message-Id: <20240301091413.3050689-5-alexander.stein@ew.tq-group.com>
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

Also add a corresponding label so overlays can reference that node.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6afefbb851842..922b7dc2edf66 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1751,6 +1751,13 @@ dsim_from_lcdif1: endpoint {
 							remote-endpoint = <&lcdif1_to_dsim>;
 						};
 					};
+
+					port@1 {
+						reg = <1>;
+
+						mipi_dsi_out: endpoint {
+						};
+					};
 				};
 			};
 
-- 
2.34.1


