Return-Path: <linux-kernel+bounces-60921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B779850B02
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB70D1F22381
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E65EE86;
	Sun, 11 Feb 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIRojGTl"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06875E3A0;
	Sun, 11 Feb 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678228; cv=none; b=N3eFln3mRdXWj+iw2yn3qKIn7UnRPYSFeTCfaFRgYR4ULcgj8NDQY6k7GZV+QPUzHVZy4gL+T9cmHWxLwNULxi0KcTiLx4ZIC23UUUATa10dnAgNmZ5pooKISyqbDcHgXEno0+4WHbRTnKG3hVRTWZceJ0Dt2a7QTkEWvn28Lg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678228; c=relaxed/simple;
	bh=R8nbQPilcuK/zTa/Qd5mtxOQqvhrM5GRqlCnYSJHc+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT2Z288QwttQquDb8jt5Y8qarFGNdREWhCcx6vJA+vUwyd4Zhnh6Dgqao+HaLClKBClHAUzJr3kL3v6ywCNF82AIqrKEiARZyXFSMYvCaiTF20ThyYYZfelIqYWe8GXGMMWEVCv5hllEWQ0jDoRlQB3gGCK/qAnCYZZfR58eVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIRojGTl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a293f2280c7so352520966b.1;
        Sun, 11 Feb 2024 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707678225; x=1708283025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X9gXtJ2jH9YgV610FJCPLMZwxMN7PK1ETxRA0Am1hs=;
        b=cIRojGTlU6To90/T0kqNYQjmXXNXtjL8a+nZB4UHzfYKgEF3duf0ydJbfv0Nu2sNqc
         X3R19QEq6EKHpWxiF8gAY2jQSeqGREQTLWWBiWVz0HyYMFb3MCDzkYvheNBhc1+EUZMA
         ESP25u97V/1/NQhI3Ea4B4WeLf71uF6xz+yngJS8byhY9Nh5i9o4D0k07fV2o6MQBRrf
         1m4xoqRIiU/iQk1W+EyajKeZHY6SxWZ9KUWQS83M+ESGCBczN4em9mJtrNK8F1aAYc+4
         L/i1Yz5Q1X+lpmRJMRoNPaUjcWVGq0KJDtyOsKhrEaEXuzeEefsDJtfSrFEKWHNRbeZZ
         MQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707678225; x=1708283025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X9gXtJ2jH9YgV610FJCPLMZwxMN7PK1ETxRA0Am1hs=;
        b=aBYgRU4pW/aiy2lGRrs3EVXrriqZofrEiEJt7DCYfVSoCoXGeCypg875cD5XrH/u1F
         Woh0tOpYaSIpqu304otKVYR8Q3hHQo+m9ml0fLtWSENIaAQ+S91IiZx22JxWGp5gTz10
         itJFcqiasXiTUgx+TlWjeiLoBvil7wXF7Wk4jz45mdO4s+K7xwpfqSF9fRb6af2CI03O
         SoSGhEP5f0IhcBoBUmJfmypeKJzEDThEFeRfgEs9cUzRlulYH0kQtZ09H4QDDezcN2uU
         wk50NnJLK3b3oS7MsaocOXYs7mgobXgRZ/QKuxRjy4Vd7ea/AQKAgXTtHs3X2kyYbQaU
         J12A==
X-Gm-Message-State: AOJu0Yw/3p57dCc/0GGnyPb2Kmz4BvR5HcTp6G9mRZHWplddudsjFd8+
	7NGSVjWi69kxvlxFx25LXla9Oxfg2IW4xCdnbf1Qc4Myy9VbSUrU
X-Google-Smtp-Source: AGHT+IEPGO27Q2F8ELCDw/h+m7Siyc4BpmpJdA/nJa7DZ7pmsIXSCHxT4i7w6iNqHAhI6ZTIOPkhQg==
X-Received: by 2002:a17:906:3596:b0:a3b:acdb:4922 with SMTP id o22-20020a170906359600b00a3bacdb4922mr3451279ejb.8.1707678224766;
        Sun, 11 Feb 2024 11:03:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqqngmGLbiOIGazXprKf+BgTCIh2Ak/6mUEwc2g7kDFfShRBGwlquhYhyBpik6jjhNUJJPBAxke8mnNmTg+PlaArkAShRxOqARChCITho8kM3r8Aml8yq+uAwqIwAwsbiz9mN7nIVQXf5xtwA1XmKcBCHtXWlsK0kvbcvyA0x8/jj+CUPMOC1AZJNHwDMty8FHdqJ+x7U12yY/TIsToOI3C2z+nRR9MZO1Wt36yrPZtrwYPpQwp7ndXkRQqHRSmUCu1dty6KXXBVg5KKTrL7k64x02mFW9xp5DvM9mAnOaJzYGx9f7dgMOAf3Ux8OIeeCArBpLnpH7103xJCeCU+kOlk34qA9BFOjdpk+ywmvU0Pl9WTkBqexSkKhKPxtAREJRDRRx+HNXe9aApt2GpSl+Vekz1rLYG3b60Jx+SKRIHFpqoMC7Au+YnaGPiBh/nT8vwFsoDSElGcBdDm7F+8qkcW59tZeSmVAukj4P3odlQ6whspxLQCDU1a6+X2gfl3BwoX8rG+SZyjufSFRBjylnzHxmDw76Ylz/epwfCtqXQwEFjIOrx48wNTbFvRi61HwjAXftjrOlgwzZNyoKdSd6p5Ho/yZb6GGwC0qyGzY=
Received: from localhost.localdomain ([2a02:8109:aa27:2d00::2d2b])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3c5fa1052csm1207400ejb.138.2024.02.11.11.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 11:03:44 -0800 (PST)
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: mchehab@kernel.org,
	heiko@sntech.de,
	hverkuil-cisco@xs4all.nl,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	alexandre.belloni@bootlin.com,
	maxime.chevallier@bootlin.com,
	paul.kocialkowski@bootlin.com,
	michael.riesch@wolfvision.net,
	laurent.pinchart@ideasonboard.com,
	Mehdi Djait <mehdi.djait.k@gmail.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Subject: [RESEND Patch v13 3/3] arm64: dts: rockchip: Add the px30 camera interface
Date: Sun, 11 Feb 2024 20:03:32 +0100
Message-ID: <d404cf1fe7055b6fad43cbb1df4c679057d76828.1707677804.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707677804.git.mehdi.djait.k@gmail.com>
References: <cover.1707677804.git.mehdi.djait.k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mehdi Djait <mehdi.djait@bootlin.com>

The px30 has a video capture component, supporting the BT.656
parallel interface. Add a DT description for it.

Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index d0905515399b..a8eb5371235b 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1280,6 +1280,18 @@ isp_mmu: iommu@ff4a8000 {
 		#iommu-cells = <0>;
 	};
 
+	cif: video-capture@ff490000 {
+		compatible = "rockchip,px30-vip";
+		reg = <0x0 0xff490000 0x0 0x200>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
+		clock-names = "aclk", "hclk", "pclk";
+		power-domains = <&power PX30_PD_VI>;
+		resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
+		reset-names = "axi", "ahb", "pclkin";
+		status = "disabled";
+	};
+
 	qos_gmac: qos@ff518000 {
 		compatible = "rockchip,px30-qos", "syscon";
 		reg = <0x0 0xff518000 0x0 0x20>;
-- 
2.43.0


