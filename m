Return-Path: <linux-kernel+bounces-112823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE06887EAD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037E22811EB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548DB1A28C;
	Sun, 24 Mar 2024 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4YqvKVr"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD49DF60;
	Sun, 24 Mar 2024 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711308038; cv=none; b=XVeKCjc5a2o5MvhgtwObXaiVTVny2Rn2U1+26Mp7J6LBkPGCVPBsiauKjkAD+352Z1rPTiGBMp2syMnji6rzXjD2RSmkZNWMOFyNTWqeGudHPiCXAEaMtk4Nq6UQvZ+zmMGZoepojA4qLmT8Ue0U2tTvs4ALNgtJo2d3sHiCzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711308038; c=relaxed/simple;
	bh=7xiP7a7c+JxaaenvtRnKz3pbYlEuJfkFC57nCHzqmio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YAklrFitwlWuGuOVw/uIf3THhREqTFox3JnxYB3EGP7lQ6NYyD3FffwXjxISTGFS0TlK6N1nnZv1baliFwenNZGMdsnODJyRTgvNMIV/2vkOcLR2gu4rKb9koObW+Zu5q2Wwud/R4NX/a+2EC+k9djq35ot14fNmUR8AKUtUON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4YqvKVr; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d28051376eso70575651fa.0;
        Sun, 24 Mar 2024 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711308034; x=1711912834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wjCWlFIYSFB5yCG74NtFNwwkx6eRRKsau/wQBzaYZI=;
        b=m4YqvKVrV95IOKN8w43VSilrFj/7jsg3QAnSHJxgKDvMyOemye18PtUqHcRjcYpQlT
         2h1hS2EvTdjyQgZ5pBzqWGXUyhtzLQy4iKkOUgx0710W68BOvLmIBWvhaVmg+X2wlWJs
         ITJoqQ3o73mUqvxG3EXJVvLUV/mnQ1h03RcMOY3P0akaJEp2dSTWmuguqC/PNS3YFAuZ
         xj1BdUyUfOgNUXsvZGbIeqPv3pUA1FgThXXZZz4wSJ2CiI6mapW5nwvAxKBt0vFuMVl0
         v8Ov22GHst+DFTNs/ScT/bHEejwOgMEvtwH7iLLC3FtQw1/D5KrM5Vcmc3lV8bJQuRR2
         7WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711308034; x=1711912834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wjCWlFIYSFB5yCG74NtFNwwkx6eRRKsau/wQBzaYZI=;
        b=uyVgmpiDjj3hPOmniDxW2OOPOBTFuNZSiITDzaRlxKakhXtCrJPjVvMr8P1TmSuRzM
         CtH/3Q81cB1RRQOUUjvdfSunoJGlwiUCCGsJzPLEs+jsRViIhRK+lcF4T8UUv40Zciik
         3qaqidlwpMBKy71QgOSj8ku0RH6FZ1BeUsYojyVAGHMQ5IFY5/2DkQmgC3oyImNuwYYZ
         SuIm8OEVUNnkm3LaxO/PU1ipgypKl6u0VQNkho8roCqOKhKAnFu2lyXIKbjrRfZMX8m4
         cEr55vJA1KpC1AStSpREM9Ng+h9qxJaQPiIQORnHhaZqsN/eNY4r3jcrsfMMHxJ9heZ/
         0Gpg==
X-Forwarded-Encrypted: i=1; AJvYcCWPQiKxDjfStREO1ObtHnCLFE0EH2O+VaF3/gkH4FaxXlIJkEbvyHEBcoUg5m/m1+P5jd57Ate6LAqUSxtLB2fjgI8bQPf31hVgd3P+qoTiYAULNu83ARa46PnVMMgpXlCa6Mc+dUNhAg==
X-Gm-Message-State: AOJu0YwYyR4NhcCdVe2KNFGNh0xQOcEGL8m9WyChCVDvKoYzS16oJF0w
	cRqAi/nd0zC/OJBxGXDeMzYmdth0GA9koCafLlrITvYq7gL6PK3+MRJMMZv72Sopow==
X-Google-Smtp-Source: AGHT+IHavYd8spLhyeQFjvZDMW3NjuNiOTPvJc6e8eW4eyUkSLEdX9oRDBDq4fMjkVf9SCAc1t0gjw==
X-Received: by 2002:a2e:8055:0:b0:2d4:6bab:15eb with SMTP id p21-20020a2e8055000000b002d46bab15ebmr4120105ljg.12.1711308034456;
        Sun, 24 Mar 2024 12:20:34 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-2e5e-f14e-aa7c-2010.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:2e5e:f14e:aa7c:2010])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090639c200b00a471cbc4ddbsm2248205eje.26.2024.03.24.12.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 12:20:34 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 24 Mar 2024 20:20:29 +0100
Subject: [PATCH v2 2/2] iio: health: max30102: add support for max30101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-max30101-v2-2-611deb510c97@gmail.com>
References: <20240324-max30101-v2-0-611deb510c97@gmail.com>
In-Reply-To: <20240324-max30101-v2-0-611deb510c97@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711308030; l=1134;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7xiP7a7c+JxaaenvtRnKz3pbYlEuJfkFC57nCHzqmio=;
 b=ZIhZQxFriY3rYD9NfH1Fh7pSZhQQ1vajuMhHB/O6TxymWQpWUFOaN2+pTyBLsSmOs5aEKxNxR
 wj19lp5GNLEDD5ECl6h5XrXmUtFxOpeAKiz0pU7D0UF41X+IHxIqZLq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The Maxim max30101 is the replacement for the max30105, which is no
longer recommended for future designs.

Their internal structure is identical, as well as the register map,
configuration options and sensitivity, which allows for code recycling.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/health/max30102.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 37e619827e8a..6616729af5b7 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -613,6 +613,7 @@ static void max30102_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max30102_id[] = {
+	{ "max30101", max30105 },
 	{ "max30102", max30102 },
 	{ "max30105", max30105 },
 	{}
@@ -620,6 +621,7 @@ static const struct i2c_device_id max30102_id[] = {
 MODULE_DEVICE_TABLE(i2c, max30102_id);
 
 static const struct of_device_id max30102_dt_ids[] = {
+	{ .compatible = "maxim,max30101" },
 	{ .compatible = "maxim,max30102" },
 	{ .compatible = "maxim,max30105" },
 	{ }

-- 
2.40.1


