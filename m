Return-Path: <linux-kernel+bounces-162123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3938B5643
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8B52847D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE1744C65;
	Mon, 29 Apr 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTs3vNUy"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C43EA69
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389345; cv=none; b=IbdEujdAOWp/6f+/dlKRWm+0FqEYTdl4NwT9KCljq27X4JdeN2512eE6Ufsh4enqhkBhpJOpux1TF+SRvPffNVmBEUpVUBvUsN/inC21vBNMWdBydwblRbi9EH1Luxgo+aiztibyetMQmrXt++skhiu+15OChD1wkjtQzr2rlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389345; c=relaxed/simple;
	bh=WARBLKc8IIwkOZR1KT6Pc8Nf7x5S3Qw6DwX2PgELUbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkrDSQlIk6Ao2MThOkyhAX3uQeM0Ry+VK9tpZHGIyv9PinalSbQybHNgL6t9s/5RhEOOyGwgwSUqJQUcvrhg9lu2SZ2opuXSL5vfGUejqXIZyu//ZPliEw4ufeiIYWgEy/OV7UkQsO2HJolUXNjQ6CYQSImjpDIK/SmkXPIuWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTs3vNUy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so14857385e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714389342; x=1714994142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7YOs9puuo8onPpvdQ4CfanEhu1eADekMseFBdt3Sao=;
        b=eTs3vNUya7bNA5zKpq5cxzIQSNBuHDEUCreP0pieQq2Sop/r3kfOZsVVU309MQ9Q0f
         7pgQTfFHBs3AytKICf15QMgVNsVE27EzR2u3rWOsrtI1/zvLYsiLgqWnki0FdSuYsJuU
         eHTi2RK2/A7VzpeYvIcWhBb8lbwyOqiAcYLcNCynAPUrM0LziqPKCUolszWq8uMIawIx
         l+UKJmavnhKuv3a8kDM53mIaEYkW8Nz0tuPAbTfVASADKbKaNKPtb9PBaVh3USx4O9LW
         GD1AZ+Yw2/ZgyQqgA6p18yLA54bWnVf5YwqXuEir3fb8EBkrSQhDK1Ndp5WOkhX1eBKy
         svKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389342; x=1714994142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7YOs9puuo8onPpvdQ4CfanEhu1eADekMseFBdt3Sao=;
        b=rvZGoRPfiAvYjK41RDEvEMUEOMNakj4I4sUzP02pptGy40Sg/7N8FoB65f03kJT1ro
         FjhHIolOfIj9R0rEeqUTPl8xsa1jyqkcXhjvGw4jUwku2tFpMUTTowCU7BfVhCeLvXkx
         qc3P9YbZSo5BRMxkwOTsPYAlR582NwtZ8cVpQx8PREBfT8xyVzVk/f254JfM2pYK2WyT
         vEW8y4IzoKClOHdmJAHruUV+OVTeE9ALVVnL+kJHnxLcHM7OZyR+WMLAHVEkkb3RzVNT
         H3JdGS6w9VAPTyKTAbKWhEsxFyuYKHFVPuxXifd1MGpOl93yXdvlf4VmFCJxYYUyk9CJ
         chrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHdM3gg+PS8gBZ7EZvguxPyRMnaVYvpAlqdu2ahHTrW5jESelhbav0a0d7Gjwq7seJPkDFtza5sNpQUHNi7UK6p5JJM9jeuT2O1znf
X-Gm-Message-State: AOJu0YyHUb0oTAjPqDePMgtcbRLeozfJ+DuNa4wrzCuC+1scNDFU2XVi
	VDsLOeIkFWK8WTMhqsGdH96THc5u2d4njCaB1Ndg1dqMP+bT2AfkVOPWAEKATDM=
X-Google-Smtp-Source: AGHT+IHgx7Hr77YwfgooYgYOrE6P0eeKNZeE70sQQxjdW6m8A4bLVKtOXlKGH9X3NxEJDcLuotdqVQ==
X-Received: by 2002:a05:600c:450e:b0:41c:7ac7:17f5 with SMTP id t14-20020a05600c450e00b0041c7ac717f5mr381669wmo.24.1714389341861;
        Mon, 29 Apr 2024 04:15:41 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:550a:b373:6b8:63ab])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b0041b434e5869sm16005337wmq.43.2024.04.29.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:15:41 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg compatible
Date: Mon, 29 Apr 2024 12:15:34 +0100
Message-ID: <20240429111537.2369227-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240429111537.2369227-1-peter.griffin@linaro.org>
References: <20240429111537.2369227-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update dt schema to include the gs101 hsi2 sysreg compatible.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index c0c6ce8fc786..3ca220582897 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - google,gs101-apm-sysreg
+              - google,gs101-hsi2-sysreg
               - google,gs101-peric0-sysreg
               - google,gs101-peric1-sysreg
               - samsung,exynos3-sysreg
@@ -72,6 +73,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - google,gs101-hsi2-sysreg
               - google,gs101-peric0-sysreg
               - google,gs101-peric1-sysreg
               - samsung,exynos850-cmgp-sysreg
-- 
2.44.0.769.g3c40516874-goog


