Return-Path: <linux-kernel+bounces-160064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA28B389A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2362B1F21764
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68051482F0;
	Fri, 26 Apr 2024 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xW18gLq6"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E27147C62
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138714; cv=none; b=nVxUZH8Tu2rR6FyO9ExfjJp9jzk1uLgip63NWL5T6QggDhH4Pvm5SGG9eOt65Ipb8oRKN/2a32isf+Q//dp3TkWsk9y9sMTB0xfUMo+byehEz2e6yHarzjpfBKcv54G2fYCgi2CKGjPuo1ohHfcSO+IbI4sy6hPYyeA2GdpRmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138714; c=relaxed/simple;
	bh=WARBLKc8IIwkOZR1KT6Pc8Nf7x5S3Qw6DwX2PgELUbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkGpF6y4k9qLetK/omfh3wE4KlvnZBnFJizZW5wIpz2d4QNMdBFgiVONofqqv7dsOpOL/4eFvB+XqPstlAQrSOdTZvfzY48R0wmVxmxUpTObM3tGdhjdmBjOn3WTTblac1+exalHhwiaX4MtBYADmJKpsAdfNczD6Y4+CVhpDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xW18gLq6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34b3374ae22so2318625f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714138711; x=1714743511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7YOs9puuo8onPpvdQ4CfanEhu1eADekMseFBdt3Sao=;
        b=xW18gLq6O77muoho41UjwG/7HoYHAiE5MStXCyuH6YMhGfAKd3GoaMyfMG2yG+HNUQ
         6WKNgV6TpVzz0BdTVk78QgIkZPiEtEVUGkW8URXJcL28T8pp7exFysNM6WywDqkWugsI
         0bmTSOyWrnkRJBjLAFA/9WIr1oxT4/Dwkqo8qf06Ht2ydiVxA4mxnRyguu8evuI6H3h6
         CKl/oGcs9uozdJ1t22zJA/TBK29oHM9IoqziQlcLnckLPlb0M3AEZa+SjuwQ79GczqUg
         PSO+s5ssrTNk7O5SMvq2T/pOBgdJ/3iI2dJEIk22mdmRPIqbmoiRANNVRG4IEIh6z4H6
         kpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138711; x=1714743511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7YOs9puuo8onPpvdQ4CfanEhu1eADekMseFBdt3Sao=;
        b=powmN4HFUXrNnGKFOtF+A/ho8RIU3PHkRoxob5WXNAlnwaBNWdqVnsQuV00KL7kjnJ
         UNOmmY7TAAnH6F10TJKn/4rgTOg65Px3Za0xtMCJ5sNpq95nn08+gtomTrzz5/Sg2WYQ
         tMpHkjjPO4xWn9Rho93Iyxxl/X21mVO07pXdbOfskW/W1P/umJtOq855Ut4aV0dutlY8
         TIzjxZbrU07n8bE/PkasSbQuPLI7dW8bo8XwwoVx2CE5JwXIUi5BkkEIMXNYfi92Y1rB
         glYl4AMCBZ+5XqJbgcGEK3Vab6d71+FIpkmouq6yUBR/pVJaNbL2zpzN9OkeIwCCvQDs
         0Q4w==
X-Forwarded-Encrypted: i=1; AJvYcCWSY2hHoqdoFn5wkXjpAFqP2WB7GKer6lIepHDQS75bT0AO1l5RuOGv8JhO3Mr5b3rawSfZGGyLvfioOQbym4C3Wib3Z/dNinpRJAgY
X-Gm-Message-State: AOJu0Yw5R5r/HbLcP99JZF8qSpFu87Np0deoFvB0Kol6Zfwsk2HXXvXI
	lPHv6nCB+JWYC/MueV2+Dgno6LvNqNcXT7uFX5iP0iB01hv/kOA8+jLS/YSXElM=
X-Google-Smtp-Source: AGHT+IEW6lN/nMVbLs2cr1R62IxVhVzas4gPNLfg/YNhTIYexmEWP/7n/0P1dbJmlPX3TjrfE2dhUw==
X-Received: by 2002:a05:6000:239:b0:34a:4227:e9e8 with SMTP id l25-20020a056000023900b0034a4227e9e8mr2605785wrz.47.1714138710599;
        Fri, 26 Apr 2024 06:38:30 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d6383000000b00341b451a31asm22327689wru.36.2024.04.26.06.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:38:30 -0700 (PDT)
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
Subject: [PATCH v3 1/4] dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg compatible
Date: Fri, 26 Apr 2024 14:38:21 +0100
Message-ID: <20240426133824.2283144-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426133824.2283144-1-peter.griffin@linaro.org>
References: <20240426133824.2283144-1-peter.griffin@linaro.org>
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


