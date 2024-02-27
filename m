Return-Path: <linux-kernel+bounces-82555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD46C868651
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF8B1F253CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8EC1E89A;
	Tue, 27 Feb 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goKYSfKC"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815A1CD01;
	Tue, 27 Feb 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998455; cv=none; b=DRTnafwXwkwnF7MggIt9uXGHoGo096TbkBWHj/nWhoItJm7WFnKjIXXqGinAY1KQGbgfQqDF5SKZFLdwNoBuvlbcY2FewPF1ibIU3Oi7joyDa8hsUdYuD0OknfhzYIlezrxs2/ngeLtUXIpjTRJYZFerxcnSamozmMCtbjqqRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998455; c=relaxed/simple;
	bh=CebN2e7M+eUIq88kq6SwDH4xYTCQZktEekF7C3lknbI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmNwFJTGyaaN2aFthUP7mL9GAC9/cue8WKr2BiqwgbIxLanPDlCd4AAva8fHQLp940rdfMKGrTLFka7LZA9EP9KEfT9ZNVlC46hMlc9SMgBK9l88QX8eUdc2Ec3dFwCpwlXWZ2wjj68Y4yN2MIC6N0AdPXsoHQC4upDtIrgYkOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goKYSfKC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dca160163dso15394945ad.3;
        Mon, 26 Feb 2024 17:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998453; x=1709603253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=goKYSfKClu1FzRXOw7yjR2lb+4JbtS65cU31tnCVyFlaK4Hptkio9k15MyGbHHdV2J
         zfPHtsPSU3+8MysG2nxdEEwa/j0dV5xzhggwglVFzOy1Bg1fr4RHuw+nCA9wZm/lLH1Q
         HgsKEqmlCuAm2Rsw191cADDpFXTGLsVPT0n1MswMxCDz1yLTzf0VSFycAQm2lFzkR3aT
         Oj8W+bX5vcFEa9wmEOOAqTbQkRUth8UHm40vJGNb4i8t4CZysVdkZqm2+DrUwZMajyar
         0PEbi7zFFjeVNyP/KDI5namXk7VbO8BxJlJEmj3ybweHMJsVwQ8Zt7URvRhg51XK/+Nb
         ACTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998453; x=1709603253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=llCRNMurt5HJHWXj7FHQzRHVrZDIKvioLiMWfWT0LblfOdUqWwK++vYqk39aGfkeDZ
         5BPt8m/lJ2Hlc+QMjaonMY3Ki5EtLCJmhMI5wzyfllh/09OLd+yhlyXYferRmx0gqmSv
         IeA1APgte3J4Frro5bs4epxB6OSI/Nta1r2FA6+f5G3NDqU+3+4mVFNW4kJd70LPUZt5
         Kd9lxZry4qaiE+wvjQ1AURKGuRP9N1nDA3Bo6Wm3SIJTscVUOQUECiKSyIRjArBsDW7s
         DDrVxXrFrC0Y2KBtK0DYB0fDoQ9poWfhmWR69lHfOCsxQT/JgjkJelsf3CEQvz1/8k+m
         YAbA==
X-Forwarded-Encrypted: i=1; AJvYcCXuF6ytcOSXTylOs4+NkzSoyhPrXsB8Gx+gW9EU41PvXkfvj6drHZNYN0VhjeJWIC8ZLceX/KP6liY17Ak4jTVwrBrf/Koc+NUL8skkK7i99jkIFNRc/OG97TxdIb+cGl/eQAcvieKySA==
X-Gm-Message-State: AOJu0YzAmsjHF7CpYnBlAz+l4EnE5cD4VvkCJijx9IKbahYNWVVxDUTu
	lgNwAi4yy76fEb8rBVHszNcGb303o4W7RVUujCPAD+V99G4XRkaK
X-Google-Smtp-Source: AGHT+IHnr/SXQx/TUhSGNxXmsbhpF3PDlZn9SdYcK9U4yVXvMpnTPJMMe0fvrUhJncD1RfdDQF4Wyg==
X-Received: by 2002:a17:902:c412:b0:1dc:4190:38f3 with SMTP id k18-20020a170902c41200b001dc419038f3mr12706737plk.13.1708998453069;
        Mon, 26 Feb 2024 17:47:33 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:32 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/10] ARM: dts: aspeed: Harma: Remove Vuart
Date: Tue, 27 Feb 2024 09:47:12 +0800
Message-Id: <20240227014719.3037588-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove vuart to avoid port conflict with uart2

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index a0056d633eb1..5d692e9f541e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -100,10 +100,6 @@ &uart_routing {
 	status = "okay";
 };
 
-&vuart1 {
-	status = "okay";
-};
-
 &wdt1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


