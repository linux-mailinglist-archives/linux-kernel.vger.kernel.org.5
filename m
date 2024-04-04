Return-Path: <linux-kernel+bounces-131417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D841589878F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B708B284AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E812D1EB;
	Thu,  4 Apr 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnIv1xFS"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEE12CD9A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233601; cv=none; b=r6UDUimaWWtKr3MkkYbyZ+h77kGYdVkNTpSBFaWshHmO9R9tQGyElJT/5GJof0PbLx+BgNtfAMAUd0m7Ra+EsHmLLdYbTgKo2lFj2PZEd9BA/zOBOa3TcQSQKpyhb9zjViad+OiDFiSl9cqm23BhsAscuC1VTIY2lpjrrdWzVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233601; c=relaxed/simple;
	bh=ZVqYn4HwzkGZ3NORH7tsH/YjN519R6At8CFrNLiJlP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOBsj1PigU74NQveVeZteXz21T8mGWe/hQxzViAT4hqFOf43dRAWGHHkzQ7sqTx7Vdv4hygdEq1+CEvlePicHVCcAXZ6bBrX7wdc3KEFxgXsKfoe55HyOhbr47RvgoGNH2Rp3CtF7FyFCzSzK8GX50tyAK7eFaB2g7rOC+HxE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PnIv1xFS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33edbc5932bso670935f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233597; x=1712838397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXdNsPRMeRxKNgTMvoC/YAjHT8cRrzE1LWBWedHVt+0=;
        b=PnIv1xFSetuTntTpKBn3ADePES8dq7kv/PSI9xfp1L5cxBxSmnEevldAyagG7ANFz1
         VBlsM35fKy1q84sP+yTCZgvJEabTTeyJTX5JG19AtVQt7ZGzrrlwagNFv0PeG5TLfPco
         l7rjb4595TH4api0so9ieOw+DHTAdNU0MW3/yDbg0Is07E4V2acwmfiYJwHtMtZY4N20
         6DRo2lBVwmDo+r2ltBXuOm62WJ5c9rs/GnoUSnulTFM9179hJ/tx6RzJiMHy1Dc7LCo3
         zyqxgZlsEaVA2fxF9ERkCuliO6EElrN5C7lB0IgmRHlCOiKxRkLJ0u7cZ42iQyXpKQR9
         9mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233597; x=1712838397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXdNsPRMeRxKNgTMvoC/YAjHT8cRrzE1LWBWedHVt+0=;
        b=Kh19N1GqqzIrLqSqQqFFo7HXRamz/hJI6/2gdpPyXVYEjS89p5AaeZQPbcG8e2elmG
         Dvg5ptTzlGXCnhMrN48ZQXk29SW6v/0G3dGBUlG/UcCUkrWLVpvF/sBr3qi7sdBj0QRA
         uCWeBNuUwEbtbhyW4ylSAMAoTVkIUwlmPZ3/A3/r13242RYNraOw+KXk1MD9mF1viT1F
         yNjoEu+2I6/L66Z7gE7qYAxBhE4rxc7kLdyQvK1tpPoiEC6qn+15EjoULS21+wodkTgP
         eynxhgntmDQRqoKsjp1+MnEj7coRgSr5zsYq+kSj16IDIgeG+jT0EzYm52AoF3C6m2Bq
         sItg==
X-Forwarded-Encrypted: i=1; AJvYcCUXtIiCcGorU0dQWjuLkOAicgnkWCYHnhFkdMkM3ddRB1/Z/WexcPfPWaZ6E9yWMkZr+GT4FFdLT8h2PgPZDqZ58NckoOMRKRsCyP2X
X-Gm-Message-State: AOJu0YwYg0EWBIFSV2oBVrBrNvFD/lbef5QeDzMWh1WGrDtrHCnUD9Ub
	9XWmMsFqjsPTQrUhdt3p6TPDVw0ZJ71v65+RFSaYmm0mr8bNt9Zg4PIY0uAHrHc=
X-Google-Smtp-Source: AGHT+IG4W3L5dd8Mb63CZZWsH81KaevKLECBBmrLli4fW9RjtXnQf5HkEcp1WxySDAX4sVMmwjF8dQ==
X-Received: by 2002:adf:db46:0:b0:343:7884:fb52 with SMTP id f6-20020adfdb46000000b003437884fb52mr1946795wrj.50.1712233597343;
        Thu, 04 Apr 2024 05:26:37 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:26:36 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 04/17] dt-bindings: phy: samsung,ufs-phy: Add dedicated gs101-ufs-phy compatible
Date: Thu,  4 Apr 2024 13:25:46 +0100
Message-ID: <20240404122559.898930-5-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update dt schema to include the gs101 ufs phy compatible.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
index 782f975b43ae..f402e31bf58d 100644
--- a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
@@ -15,6 +15,7 @@ properties:
 
   compatible:
     enum:
+      - google,gs101-ufs-phy
       - samsung,exynos7-ufs-phy
       - samsung,exynosautov9-ufs-phy
       - tesla,fsd-ufs-phy
-- 
2.44.0.478.gd926399ef9-goog


