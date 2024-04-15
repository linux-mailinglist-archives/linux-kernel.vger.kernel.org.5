Return-Path: <linux-kernel+bounces-145637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1F8A58D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5180A1C209D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DFE129A7F;
	Mon, 15 Apr 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8f5tY/S"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534E8289C;
	Mon, 15 Apr 2024 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200888; cv=none; b=pOuFRZcgOSedAdAVDQHitfdZinEa0+s9bu98s0c/tSKlbspiWp0OUotvYtx7uKPmYlNuNHkU46kuKI89CikPuA3G46/gk4ea9L6OFwm7TGf5zmJrdNaVN0GWibZ7PLpQPBlfHGF/NlKdv8GlG/+G30qH5rtL+NO5Z2nfD1vrqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200888; c=relaxed/simple;
	bh=nE3yJuMkAdOlRlVY8wIVjXUHI3A8rjm/f6MWM5egj6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ML/hkT6Xf9sogSUxFUXQE4nikK4N/Uv9IVofanwBE81PxYYX+KbKXGIEA7OSLdJ0WSJMQnL5EkEOknF61zD81+Mwj5afnduz8NROES9Awtkw/npoS3bHansjp9deHP2hNebG9m+4sVuF7VQdwSQMWddRcehiQcJp4nnEYnoQK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8f5tY/S; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4266673bbso29755165ad.2;
        Mon, 15 Apr 2024 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713200885; x=1713805685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST7IBP1G+OA+O25mvhaCDcJ5UjWGi92SIHIsGwEi/5k=;
        b=Z8f5tY/SHUvuODR3DaC3T98X17Khjkz/ctKg7CQG439PdxvVTxNHE2g6t8gyX8Qdi8
         hZGtW42wVk+t3MGw+VatKtjjDus2YzWKUelh6sSUeK0vyafQGvaSYy5cn2TkEnLStUcV
         5EKnEYBYYXkJy02rwxUG4zqEtEgWod+nG4AtwVLmIuNAHGcQybkvih5movhsleMj1/T+
         ADxK27uEdAr0MdKZDM2xTc9t/3AYVpBAIRsVKXhcHlyZBo2Mm85bd/3Fodmx0BNd7+lB
         Sve/zD5a6FiXAJpcZlZ30AQMfUp/Mt7Q+grav75l9r/ty++YN3bvo7Mt1LldAlg2sTL2
         /RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200885; x=1713805685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST7IBP1G+OA+O25mvhaCDcJ5UjWGi92SIHIsGwEi/5k=;
        b=ZvCxpL9JERrC6/UeIOb0MZPJcv9Q/vQOvIBpeLd1vfcuG4HXiB75d8UipNWiJ9gQjx
         k5VisddqHZ+jsp2QbIpBxdO9we0xIT03zLPF1/mTZhzhulUi6+2AsLCCqZm66NbgfIY6
         7KzHnN+jijLoFFa+w6WlBHZmX30PjCP1CXcU21A38uXBpxvAr18X67B2f9DsVll+TmtM
         ApTvscGrUos2V0qDRbgbGQU3d4SBAcG0dFLgvLc8SkuI/WhdE5mRXIEw6PXY4ApjN7dY
         AtzQRyNNuHVa5XxHZJTx1t5KyPIC4E9RoJORgGen/dPgu9ztUzck6cgpgKUNo532M9Ut
         SvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm0ozVXdoUu1DLbXp57/g2iDae1+bd4oQgJ62f1+igVbPVh9vDIiMu708YguhiGvI0Ib06Ml5jzM09PVHvL5jsHVN7w1kPd3YHLHIS
X-Gm-Message-State: AOJu0Yw9SspH8jeLSV1epuKkjdKJMC9SW2hkPrNEeJRQyJerm1oO7UrB
	GHgeDZBRpRU5kWPy1idT8DSB52jsOY3jxc+vZ40qczqSM5FOAakiXk2HOy5I9Q8=
X-Google-Smtp-Source: AGHT+IG9VviFqrQQjC21j50z21G2NJ9kg35tvooQmjLYNa13L/WcQWNSZvxAQR6whHJE+p3EEPfRIA==
X-Received: by 2002:a17:902:cf05:b0:1e5:a3b2:3da2 with SMTP id i5-20020a170902cf0500b001e5a3b23da2mr10108003plg.53.1713200884939;
        Mon, 15 Apr 2024 10:08:04 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id r1-20020a170902c60100b001e0b5eeee41sm8203983plr.38.2024.04.15.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:08:04 -0700 (PDT)
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
Subject: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add ArmSoM Sige7
Date: Tue, 16 Apr 2024 01:07:36 +0800
Message-Id: <20240415170737.49350-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415170737.49350-1-liujianfeng1994@gmail.com>
References: <20240415170737.49350-1-liujianfeng1994@gmail.com>
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


