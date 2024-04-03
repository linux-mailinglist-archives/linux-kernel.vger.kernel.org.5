Return-Path: <linux-kernel+bounces-130073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD7897425
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E51B2224B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BF152163;
	Wed,  3 Apr 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZT1g5gm"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4014BF96;
	Wed,  3 Apr 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157310; cv=none; b=oTBI2YTLJx1J/exzazRqTTei9nVTQWCBX8a2xO36tcj+oCynYUBVhkf/xFo6iFQqS6WGgqMxAcZYPqAYo5a6lihldNF2D1/EAlGr5l/SowfNiBtmJyUawRTbOxt6MS9Yf3qkLy7KE8CfzR750w/wn2WAjrRKZlicTfKOJ4lXFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157310; c=relaxed/simple;
	bh=uTHBJcc7y/HIoMrmE5WnHMHHOZMMQgUixx1II2fzdt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V10HVjFVfGLc6cYJKslgX9j5+0F1EHoV8R7XQHaWxb6qUnrXX9ndmus+JwrLeAXkXarSKBvzXkI0ng4ERskImYK9dl3Szk8HqtLA+22DA3oulKDGLpdLHWc/K8bdTWk5rUI0nhM1uvpez6RFPPVX844RgS4ksCD53tQ25+PQVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZT1g5gm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-515a68d45faso7467692e87.3;
        Wed, 03 Apr 2024 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712157307; x=1712762107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9DvDDhS7AAIoJbW8z9CAGKW4h0e01rZII/6xw2xvNo=;
        b=PZT1g5gmH8vauDh4xBMSxBVKp+M92Ayxh/i/QJRiGdPj8YrqCzaqE+FePCTMLnRKuy
         fbxNd4zCZAVGvQfWMmRRTRycmR3KjlWfYlptMnfgAixJsd00VO5VyYzb/CPy6kR5Zvxn
         U/I1Ij7GvzzG+9d26F5IobplMOwm3zciRuZtYeXGjFB3CqMK0UlCdc3I7xLyt2NGOrRO
         v0BJUJkmeqvQjQdx05+NwrBUped5viCu8mHHRwg+e0T5wMC+Wj5SaYcAUokAobMhV+yQ
         G0Uqa8OmN62ciqnrQUpkAEOoHeWXn9COqLzfVyUWnSkex6k8OsoIejnE093mlHT6xhGJ
         5uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157307; x=1712762107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9DvDDhS7AAIoJbW8z9CAGKW4h0e01rZII/6xw2xvNo=;
        b=HVObhGs3TJx1ORIpnNow4Azipp7WLuW7usz6k7CvX3immWSg7dFBeBBrcNfMBt7ggt
         iou7d7k6BcvS7eFEJqwWJC7DeuaHuSPkRvpz/L0sUZBXsEbqEOsoMKn1/w4OY/tqpSeO
         9NRWJUDLqvpMS7cM1H5O0/DTjZpLxRy03s7hL5ZNncpoN1G7z7t2sashwjaiMzSXJAMj
         1jZ2D9Q2+Y+6EthpMH71Yt41pNEKCBuDCW/TpSNrJHvJxnMJzF5TVJj659B+benOXIKt
         yKW0+aEqL0ADWZrqlUlOIld0ym7+BWBAa8A4w8SKBPUj3udYKv8+9bKeqEG9yVTO8MLL
         oJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7jUNAs2RnIyNGJFTyv2fc5c4sqmlxkKvscPJlQqpxxvv/RaONqtpx8+oc3Uj/YzBfNJJtNIXUNoiE8esAsg3G0hqcqt9KOizdiW9r8jPpvpc+ybf58YEOvkWlYPVi726YAyp94o7E2A==
X-Gm-Message-State: AOJu0Yy4A3sJL1XylEjSbHmxlhw9tDbiyCXl2HYjGYf3pEShbmJPKLOq
	kQyzCew9qOnUnSBRoWKW8I2R1q9nKlM4+pk7p419q9rBtzHyvuWu
X-Google-Smtp-Source: AGHT+IElyLvQavifnocrB9GexBBa7fY1VWFgDzAzVxIUg7DTS2DEPfT1SI7ZYNsjLQcPQdpLzjfp6Q==
X-Received: by 2002:a19:6459:0:b0:515:d10b:522a with SMTP id b25-20020a196459000000b00515d10b522amr9939503lfj.30.1712157306999;
        Wed, 03 Apr 2024 08:15:06 -0700 (PDT)
Received: from yoga-710.tas.nnz-ipc.net ([178.218.200.115])
        by smtp.gmail.com with ESMTPSA id d6-20020a0565123d0600b00515c1b1fb85sm2055092lfv.233.2024.04.03.08.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:15:06 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: rockchip: add Forlinx FET3588-C
Date: Wed,  3 Apr 2024 20:12:27 +0500
Message-ID: <20240403151229.30577-2-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403151229.30577-1-dmt.yashin@gmail.com>
References: <20240403151229.30577-1-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FET3588-C is an System on Module made by Forlinx based on Rockchip RK3588.
This SoM used by OK3588-C Board.

FET3588-C features:
- Rockchip RK3588
- LPDDR4 4/8 GB
- eMMC 32/64 GB

Add devicetree binding for Forlinx FET3588-C SoM.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v1)

 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 99bd5e2c76a0..2e61c3980444 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -198,6 +198,13 @@ properties:
           - const: firefly,rk3568-roc-pc
           - const: rockchip,rk3568
 
+      - description: Forlinx FET3588-C SoM
+        items:
+          - enum:
+              - forlinx,ok3588-c
+          - const: forlinx,fet3588-c
+          - const: rockchip,rk3588
+
       - description: FriendlyElec NanoPi R2 series boards
         items:
           - enum:
-- 
2.39.2


