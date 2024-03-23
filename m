Return-Path: <linux-kernel+bounces-112514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B655887B11
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F361F2158A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341E5C613;
	Sat, 23 Mar 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j6Wbfuok"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261C5A11F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711235603; cv=none; b=r9eDwcv0A5DUOxcj+f2ipGkPwnVi/XOVTI2vEqb21/71GMOxiIFjzO5wsZ6nW82LLFjNjgogWKSCaMD3db98gx7rj4FCjBbmjbHvzyzG252Ha1z19w0jHOQlFjAcXNauCTaTWtZjHos6kcZQ9whCEAhDrbK9Lu4Jex8xTe0LKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711235603; c=relaxed/simple;
	bh=+for2EzUMdVVcB71pixcUcddliKFsRuVoSxMFntygCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIxHkDoMf6aPiJeC+HAA8e4NUJlrGDFuFYw2KgivutMkj6pnrpuKMMRFf3ynBXzPJNNgD7LTdVFKDSoVJNOIzTGsfPEJMzNzjZdh7KIRFGZCXwePvteoEh1ZU9iPhBpQR/uhMyu/xeR7xw4FLFHVWn7bhE5TYA4awRt8+wtutyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=j6Wbfuok; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a466fc8fcccso435284066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711235600; x=1711840400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHLbndzNw6n0/nPPeX+nkHQjigbGF8h96E5IS2x3kqs=;
        b=j6WbfuokTtH49pB95m5tkhJkSsfIMrTqR1ymvGSLanqnR5nUmG2PFVtbXmHq+xOyb8
         fLfyCOEGjmfDn2g77IVBl9UftW3EaPBnzVvjdiDCFsE4CKAcNLHtHqScp1DtrflAyLzX
         kit9SyTgpz5ayQAXgmdwIacW0VulwfpoHwvVvLwTytyTlLvfbdT0xOHKYGavI3+Rs+68
         Npw9ep1ehZw6PhIzCC60FBTfgv6iVsxwmHcmZugzzUidaXvRTTRxWaOMyszUSOPNNcy/
         NUB06v2i0ufJIbHGuBxq1bSy8/yfdKlEdpwSySw7OuSpgSOSU9WU7tPfIyOfi30epGWK
         p05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711235600; x=1711840400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHLbndzNw6n0/nPPeX+nkHQjigbGF8h96E5IS2x3kqs=;
        b=j16QLkOXraM2akDeBJbZvFpRljxbOXMklKyWMOIkKwK2PXa/D8I6mVC4yLA+m46EkW
         i5Bod6igztyUcMIMhSy2H04m+Mjx2le32/9+8fKiGH4LLKiubyGAVSY7yxYMakQzSmFe
         PRD8xc4XxXoH9xKQe/UnUebaeDLbmvfeWtR9Us4jzsVEbTHSg4ZCSzeMOOUuCPWZjh7T
         cDtYEP2/ESNISh4ZHKSAc8IihdbL+CK+WQgk+K9I71YGHvL6ts7td2ph4QND3LiVPIvu
         fBbRqArSLztz3fb64fqJlRDZ146ogS6s8tmhreXswLN4KvtFYqUzi0pHx2lG245MQJ98
         /dFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWa5clCPoV0uAlI21vt8VuHGSk7yeJ8QhJrPhSpMk31myF+LOOqCUfH4cqnU6XHXokVJpDB7uT1U2e71YDjxyG3hDjEbsBXyHPMBL+
X-Gm-Message-State: AOJu0YxgVMBMp+SZJcYmjoMgWebsmn9f5paDj9s2lc0RVrudVnQzoILE
	Ij467ZReFh5L/JNYNM5cn8f19U172By9e9WCbKGjlr7lt5FUT1QZNUqw8OTV
X-Google-Smtp-Source: AGHT+IGKgRWuPCIDQnTEsPJfYK+IWle8bUn2rzzxJVKVFHXQcHm8/BEUgXlEOTD90GzgyTG0xNxLUw==
X-Received: by 2002:a17:906:d0d7:b0:a47:5265:9aac with SMTP id bq23-20020a170906d0d700b00a4752659aacmr52570ejb.55.1711235600176;
        Sat, 23 Mar 2024 16:13:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-6fc3-1a00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6fc3:1a00::e63])
        by smtp.googlemail.com with ESMTPSA id h10-20020a170906590a00b00a46196a7faesm1375116ejq.57.2024.03.23.16.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 16:13:19 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	neil.armstrong@linaro.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/3] iio: adc: meson: fix voltage reference selection field name typo
Date: Sun, 24 Mar 2024 00:13:07 +0100
Message-ID: <20240323231309.415425-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
References: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The field should be called "vref_voltage", without a typo in the word
voltage. No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 13b473d8c6c7..2615d74534df 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -327,7 +327,7 @@ struct meson_sar_adc_param {
 	u8					vref_select;
 	u8					cmv_select;
 	u8					adc_eoc;
-	enum meson_sar_adc_vref_sel		vref_volatge;
+	enum meson_sar_adc_vref_sel		vref_voltage;
 };
 
 struct meson_sar_adc_data {
@@ -1001,7 +1001,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 		}
 
 		regval = FIELD_PREP(MESON_SAR_ADC_REG11_VREF_VOLTAGE,
-				    priv->param->vref_volatge);
+				    priv->param->vref_voltage);
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_VREF_VOLTAGE, regval);
 
@@ -1225,7 +1225,7 @@ static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 10,
 	.has_reg11 = true,
-	.vref_volatge = 1,
+	.vref_voltage = 1,
 	.cmv_select = 1,
 };
 
@@ -1237,7 +1237,7 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 	.resolution = 12,
 	.disable_ring_counter = 1,
 	.has_reg11 = true,
-	.vref_volatge = 1,
+	.vref_voltage = 1,
 	.cmv_select = 1,
 };
 
@@ -1249,7 +1249,7 @@ static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 	.resolution = 12,
 	.disable_ring_counter = 1,
 	.has_reg11 = true,
-	.vref_volatge = 1,
+	.vref_voltage = 1,
 	.has_vref_select = true,
 	.vref_select = VREF_VDDA,
 	.cmv_select = 1,
-- 
2.44.0


