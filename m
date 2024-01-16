Return-Path: <linux-kernel+bounces-28215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D174682FBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFEF1F283EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9E9169B99;
	Tue, 16 Jan 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFyx9LWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DA169B87;
	Tue, 16 Jan 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435481; cv=none; b=FcARg7kARpjNMnh6Ru17saUqMHpqQYhgGZHr1OVFZKhURFmmakcnAsE2/2y9+fu6ve/oK3LVufJegbNDjYBdz6o7/eIfdw8MCmzG3sizaW0qb1YQlHuVOAqNK0vZzgkEsi22SaatwrtdKNi/mKRyz0/6C9tChl6LAUvfNaIRwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435481; c=relaxed/simple;
	bh=6zi+yWREyYzv3jiX/W5aIJMdN2SWzBlhr9DgfmpwPKQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=PoL1AceWJY6ewqPw7CcScGZvO3ugebIvwTrr7e7lpcddjF1Y2iPpIrfWXuGtisxnmG/0AvI/bHDXPFtINA+ICSGj+C6LUXN52GcWcTmJQu+2vZ0r/mbTFtdCYKkKcRJ/bNH1WFw9XwX5KQuLO6EBjAgzvliPluTIlzm+6pOMgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFyx9LWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87796C433F1;
	Tue, 16 Jan 2024 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435481;
	bh=6zi+yWREyYzv3jiX/W5aIJMdN2SWzBlhr9DgfmpwPKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFyx9LWjw3IY4Pabko4uSRqLdVxe+SwzfkllVu5+PaGmW2Lcc86hu2zKbNNolqVXS
	 kIAsC2Sz3v4yvAQePjpDPEp/QzFeRivPZYAi5gf6eT/BKYhFtEVvNAobPsbk4tmcsS
	 m5RWzrlfl9Akqj3YugxiZP+rYT9ktYwzthMA05hFOJVCjUAbuXbIvOyZJu7CFcrGT2
	 A9hG6siPd4LSFXShXlT/dnrymiOLj9MiH1s1jF6bGG0IHsP1IQLRWVt6nlYoNMtQVh
	 2KLanRFRtqnuNRzwUOGADOGfJ92DaQxBk6f4AyxE5KxJZX3zDH/2hNQPN+L5Oq6osk
	 PAq7GlRLgbzSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 04/22] ARM: dts: imx7s: Fix lcdif compatible
Date: Tue, 16 Jan 2024 15:03:58 -0500
Message-ID: <20240116200432.260016-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200432.260016-1-sashal@kernel.org>
References: <20240116200432.260016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 5f55da4cc37051cda600ea870ce8cf29f1297715 ]

imx7d-lcdif is compatible to imx6sx-lcdif. MXSFB_V6 supports overlay
by using LCDC_AS_CTRL register. This registers used by overlay plane:
* LCDC_AS_CTRL
* LCDC_AS_BUF
* LCDC_AS_NEXT_BUF
are listed in i.MX7D RM as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 36c00fe29f4f..ebe954f94e09 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -701,7 +701,7 @@ pwm4: pwm@30690000 {
 			};
 
 			lcdif: lcdif@30730000 {
-				compatible = "fsl,imx7d-lcdif", "fsl,imx28-lcdif";
+				compatible = "fsl,imx7d-lcdif", "fsl,imx6sx-lcdif";
 				reg = <0x30730000 0x10000>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>,
-- 
2.43.0


