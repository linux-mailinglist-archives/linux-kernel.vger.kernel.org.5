Return-Path: <linux-kernel+bounces-80273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D8862CCB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A8B28306E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1D51B956;
	Sun, 25 Feb 2024 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTSc2LUl"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE971B94E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708892221; cv=none; b=BVLsjC2bZFFScqI2DMihrez9uNMyo+5iKuWuj2caBPKVtre7iLxKNru+9yXVTnHs2Gx7q/P4Tx3CCs4LPQ1O3pgt6vgaYDZVQIK+i4h7CEA86gBNsiAgtn2y5G1g8cqVr7YCmn56SFAhPG7WF9bExSL7sgGAYCRgSuvbVCIVkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708892221; c=relaxed/simple;
	bh=hYVGG3zCAp5q9wfPxfygwzoMeHDq1lD0TOw/nA3SQqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nf+t7ch3aXJ3tTSpIu1lulPVBNlImvGzfwTPLuJmY3RBrcjylqCpGc2znCG720pI17tdEmaRCXVAJ4wFUKkRVJIkp9toFNAd2GaPzDp7/hN+8hWe+OyXbQgYLQDeSulkpiruViitOQiFSis7J9MGyqpiLsiIw5xHW/7b7cUzq6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTSc2LUl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e75e30d36so473536866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708892218; x=1709497018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RDTCOuw+4/YmutiadjBWbj6E1uINYYJEFoH23miprM=;
        b=jTSc2LUlfL9HNZQxdkHaTC4xuPsQJARzz3Z4OQYdm6h9WFT+s78aJ9mxdKQykCf/mm
         a003kjvKslqH6b+R0LviKWzJzmmvx5Kgc+UwzeFfkxLyS/wlTt/Drk0pf+pslbLlMo/0
         lFM75bX//fGjirj6usSAZM3DWQhHl2FDxs1v0VjdHKjMM3yhR8s61MIQ4IfEEuspG+kn
         tuZsstHtpvfeCYJ81KjrSWQbEo+iLLwPkBM8SY4RGISq7G45PB4aJ0dFxzzQjpcyf8Lc
         lENV1ZEe2CAfaqHqr78qUuJCDD788KCzdWqNcZroxggMT7SXZ/A0x1roGY33Nu5Aa97n
         PDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708892218; x=1709497018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RDTCOuw+4/YmutiadjBWbj6E1uINYYJEFoH23miprM=;
        b=l2IMvOrJrjLMr2tVjbTU8vtQLMxSrxpYBjnhEZz/HlstKrpwh+GF2+kV1O8k8qiHJz
         8ayVNYjU3ze8njZMqyBgJNh/X+PVGdxeAExlgqCjfSe4eDSaOetKtuYC+ijB1RSc56oJ
         vxfoicCJ4ueDvqdp9gjzEJyaqpPnGeCfHvB+Chs869TSgokEL9yE8mgR6QZ58sswfzYl
         2Kj/tz5SCV90iFA9tctrgCma0CwjD0AN/ffnFfej85iekPT2W6Czu2+q0TcaKzxkuFPY
         p6Kts5piDifGtS371MA6rgekdrTTxGUX8Tzro8Y5rYma5Q5B9OWdmZshUq+X6Vw2ahQG
         iwjg==
X-Forwarded-Encrypted: i=1; AJvYcCXpeo5iTAMJFlXiZ6SiWAgj2Vk7B2QErJst32BnGOuj9AkDZ04OPlPfcWj7fEuRUs+WqE4seIy6H2d3/Di7cXR1mn1pH7fIIae2Blcw
X-Gm-Message-State: AOJu0Ywrl1/HE8DODA2oxlBjD1U2MsfgQZ9UhOpuc8Xo/k3tDJadZoBH
	fg/YlBMtCMXUedsd3ShYMB8FsVdRed3XsHYSv16qnyZ6tsQ/+8qstMCc2q90oH4=
X-Google-Smtp-Source: AGHT+IFmzrcv6/CgvFP65oBr1ISELI6gDrREcQehqqpSKx151vTi5mDUavH7OKS2JjWHlw2haKthsg==
X-Received: by 2002:a17:906:b798:b0:a41:3d8b:80d with SMTP id dt24-20020a170906b79800b00a413d8b080dmr3872738ejb.37.1708892218531;
        Sun, 25 Feb 2024 12:16:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ck13-20020a170906c44d00b00a3d7bcfb9a1sm1741045ejb.128.2024.02.25.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 12:16:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] iio: proximity: isl29501: make use of of_device_id table
Date: Sun, 25 Feb 2024 21:16:54 +0100
Message-Id: <20240225201654.49450-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240225201654.49450-1-krzysztof.kozlowski@linaro.org>
References: <20240225201654.49450-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reference the of_device_id table in the driver structure, so it will be
used for module autoloading and device matching.  This fixes clang W=1
warning:

  isl29501.c:999:34: error: unused variable 'isl29501_i2c_matches' [-Werror,-Wunused-const-variable]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rework according to comments.

An old v1:
https://lore.kernel.org/all/20230810111933.205619-1-krzysztof.kozlowski@linaro.org/
---
 drivers/iio/proximity/isl29501.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index bcebacaf3dab..4982686fb4c3 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -995,17 +995,16 @@ static const struct i2c_device_id isl29501_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, isl29501_id);
 
-#if defined(CONFIG_OF)
 static const struct of_device_id isl29501_i2c_matches[] = {
 	{ .compatible = "renesas,isl29501" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, isl29501_i2c_matches);
-#endif
 
 static struct i2c_driver isl29501_driver = {
 	.driver = {
 		.name	= "isl29501",
+		.of_match_table = isl29501_i2c_matches,
 	},
 	.id_table	= isl29501_id,
 	.probe		= isl29501_probe,
-- 
2.34.1


