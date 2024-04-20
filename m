Return-Path: <linux-kernel+bounces-152110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB048AB944
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1AF2B20DDB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8A1118C;
	Sat, 20 Apr 2024 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcYDHe1U"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79510965;
	Sat, 20 Apr 2024 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713584682; cv=none; b=rlekFewE61913JXws8lY/PVY6a4NJNFiSGeYDKHCGrHu0TryBtpkwdWqhpmCJy/vVWDjVBVyuU9/ZBfRUZIzvGs46CKhZwRtNrbOICmAO3tNOtoEAly7WN0aR0J3mS8inJ1zpWzQB+VG+p92SnRUIp7Q+DaaZmk6UzO/0M7smWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713584682; c=relaxed/simple;
	bh=XemlhUoQa9quPFQLHYzAQQ2yJ1nqVZDzPiejak3i0AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGR9jMK8OfK2zQqF5vXzMcRsADgTbIRHdRCg8dUeMaZd0F8esCpLJ88B0S+r2K+n9uNsP2UGIXhMU8STs6d38/5tj3Uelc3gzLZ9umOXvIBWeq/+WRNcwkhwrc957mj+AXrN41B3bpnL0qtnFqoeoiMA2nPgPZ2fVpADRqSkbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcYDHe1U; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c7513a991cso134272b6e.1;
        Fri, 19 Apr 2024 20:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713584680; x=1714189480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75aJ1R46eppO8WQAJHm46Z0JaUnbnEd2ocOE2hNXu7g=;
        b=mcYDHe1U+UWUd5HXL71bx/AZ2xonefxO1ssDdnaSZecFSrGyo8MsVwT3o3pWO2m02H
         /zVGykftXRlcOtdfXeJaKoLhp+h0XSaFxfD0zKj/mXU6ZB6X2J/3Gzo7Nh7B2YtdmObT
         NfxunQP1u0jLbCZXbMW/74ltjPZINMpsQXZ3MM/ueeseOdMv1MwHiulU9W8pNuXHXl0Y
         LAfrHmgALkqIF+H8jmM25FjMslQT71GruZOa7rB25BJ6yjblt2KskLd0FPGdShgcly+j
         gak2GiY7AqyYqb8fdrb2FK9cQ+af8dtpzgkVdVpRciUJ7xrJmnFiowJQzfR2khIwC1ba
         xy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713584680; x=1714189480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75aJ1R46eppO8WQAJHm46Z0JaUnbnEd2ocOE2hNXu7g=;
        b=g4BgbLAk/WJct9Xh+5BFtlSxYUSCuDfwnu2cQLxn/hm10whB+2NXbhF5JC4NolWKEj
         O99MBGgGvwyKpPez3CbJrZ0NwPEFL0yiiRUtEu0mGoSE7zgFCLuYeS+kZlJudfEWyay8
         Qc7rPeH7qlfPNB6onOKh/xt6DBJA6V8FuxJJnn0LMM2db53kF/tMCrTXgXT5rfyuYoIa
         4dSkddvCypJpsyPrQt4IsP+7+++VfSxjUDp/q6e25uX63ALg3CxietDkyKlD67pCINte
         GWLeL1Lr7C2XVlGuZzwvMOqozvleGXBzgifwHvd75CtlD+yHZ1DkVIbXNAqjSWSPkQUX
         /dqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtxauqSigcilDmyksElRa2tbMf5qzSdt50IgzB8v+QflPJSCB/aHkq1dkAbO22WcutUGFVzHRcwUq1T5amXrYaxS2pt9KHlCgYKtd/
X-Gm-Message-State: AOJu0Yx0K51ub1FPxbnT6jS8m07smL8CGOnSkiJWyIzuBo2gNJ45Ud4a
	L5bplw+I/kTG2OQyv2TgGUp98XOP75typLKmY7ybPgyPIpH9B5PFZG7xG7QpEaM=
X-Google-Smtp-Source: AGHT+IGUJLXcWh4FjwYI0/XbLE/c6K90L/I/blQ5uhd1uKtI4lxIHntSHKIz20eTT+o4tOnqAdEzLA==
X-Received: by 2002:a05:6808:1450:b0:3c6:fa20:6c04 with SMTP id x16-20020a056808145000b003c6fa206c04mr5641284oiv.38.1713584679727;
        Fri, 19 Apr 2024 20:44:39 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a00114900b006eaaaf5e0a8sm4005633pfm.71.2024.04.19.20.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 20:44:39 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: arm: rockchip: Add ArmSoM Sige7
Date: Sat, 20 Apr 2024 11:42:59 +0800
Message-Id: <20240420034300.176920-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420034300.176920-1-liujianfeng1994@gmail.com>
References: <20240420034300.176920-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for ArmSoM Sige7 board

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4bd033ade..fd644e32c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566

+      - description: ArmSoM Sige7 board
+        items:
+          - const: armsom,sige7
+          - const: rockchip,rk3588
+
       - description: Asus Tinker board
         items:
           - const: asus,rk3288-tinker
--
2.34.1


