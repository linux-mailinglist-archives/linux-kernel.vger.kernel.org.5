Return-Path: <linux-kernel+bounces-28991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8668A83061A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E93B28B2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0120323;
	Wed, 17 Jan 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1tfevLO"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07831F934;
	Wed, 17 Jan 2024 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495901; cv=none; b=bJ7adSoXCMpg2WB1XYIHryKAXDRtiAiZoTrxBfXqmSHBeLdZn2B0JyIOe3niPTdVEJC8IHcPawyq+MyGWzLMce0ltBfA9xtYIHsoiFCLPcmHX+Fk3Fntdy91Y0aRJsQxbyq3rfs4hVJhBH99PgqXg+d3EzinAtCKggE3phRjV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495901; c=relaxed/simple;
	bh=H/rbY7Fk59oQE+dmC0993b4QcnhAD+ZNBlllja1G44A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=jzKJuRcdwekjCkGcUeZNmPT2YXhlGdz9JSZ8i0GqF1I9HhaqSkeRgjKmahFJvACB31Wf0CUFzYzQ7zspXEujV5n1oSw/GktYPOYvkQ/Ajkf+FJ0yDasiAmzZRYAYQaacX6tHQ2CmTFLYMhseyCq70/0HDnt98RkD0VqeDpcl0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1tfevLO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50edf4f478eso9642264e87.3;
        Wed, 17 Jan 2024 04:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705495897; x=1706100697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxr/9CTeqKC0kqg27NYuTzJNXMtNwRstnFwO4ZakeEs=;
        b=i1tfevLO65lZYhjTUdU+jRL3Jgnf6U4HGzqgW0sX7vkgp0YUaggslAvLqcdkvN5pOa
         e80OtNA9giqrmPB7ROWOvA0EBxQ59+1kQ05qrImiRJb+p8uU+yV1K8yDAPrkuTGQG7Zk
         krGg7JKl60g2cPQO+UxdmcbogWIH3RL5WRLM+Mxi0IbQ+xcdBxZZTyM7LTDzhfTXT2Hz
         Qqk4sMq5nZhq3V6/SQIc732+4tXM7ZJeXbXcYQXPidGrpipTbRk+w4QoAqemehxR36ze
         Vim7D/wYBmCHgmmzpBylVoqs6GR2Bod1UjAlhxXM0KUXwTm30UrzbL2GHulhGAP29QwU
         yvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705495897; x=1706100697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxr/9CTeqKC0kqg27NYuTzJNXMtNwRstnFwO4ZakeEs=;
        b=sraO3M0xvd2fQGwGY0BllUAaGSGZIOom1YO7imN4Ny4OY2G08bkCLvBGtcQ3R2DE2t
         otY6J9MZGD2yVpY8lIzgsbJygR9YJaYRsbXMN+MCuNnNz04EvltQarZW1KWBY5ovAEW5
         NbqQqTzf0XvLSt4UN9irZbmHzuXKZN4lMpKGBdf2PVdBMCjsuLQRM9mWs1+yupNLRxdb
         GAlw1ovnUHiTPnZOuLyeffexinhBw1ofVxm5rhDU0MTg/CZAOxeefezjjVnFg9SOrcoY
         v2IAf+AUKuxDm7iQW1ytNHI1CGedWcjUuBgdq70+sKc7kQm9kLDa+7nsypcrh0c5WDRm
         sIXg==
X-Gm-Message-State: AOJu0YxAdwRe5JSMJTFTq+uEFz5d0cmgF5SUSuChAbiIK3uKSoVqRHiI
	6flGFgnrKaE9p+AVrL6P6JYCRSIQphkd/g==
X-Google-Smtp-Source: AGHT+IFICzlmz3O5aD9LZKZC1UolRUKxilZ8fz0+2YuV5GXF0TnqIzMceEEHZ7RAPrSgse9mGDeAVQ==
X-Received: by 2002:a05:6512:1316:b0:50e:bf2f:cfe9 with SMTP id x22-20020a056512131600b0050ebf2fcfe9mr4642193lfu.90.1705495897342;
        Wed, 17 Jan 2024 04:51:37 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm1277247ejd.112.2024.01.17.04.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 04:51:36 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v4 4/5] iio: amplifiers: hmc425a: use pointers in match table
Date: Wed, 17 Jan 2024 14:51:13 +0200
Message-ID: <20240117125124.8326-5-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117125124.8326-1-mitrutzceclan@gmail.com>
References: <20240117125124.8326-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the match table to use pointers instead of device ids.
Alignment of the hmc425a_state was changed because of the const
 specifier for hmc425a_chip_info.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/amplifiers/hmc425a.c | 39 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index e1162a500daf..b116b54e4206 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -37,11 +37,11 @@ struct hmc425a_chip_info {
 };
 
 struct hmc425a_state {
-	struct	mutex lock; /* protect sensor state */
-	struct	hmc425a_chip_info *chip_info;
-	struct	gpio_descs *gpios;
-	enum	hmc425a_type type;
-	u32	gain;
+	struct				mutex lock; /* protect sensor state */
+	const struct			hmc425a_chip_info *chip_info;
+	struct				gpio_descs *gpios;
+	enum				hmc425a_type type;
+	u32				gain;
 };
 
 static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
@@ -58,7 +58,7 @@ static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
 
 static int hmc425a_gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
 {
-	struct hmc425a_chip_info *inf = st->chip_info;
+	const struct hmc425a_chip_info *inf = st->chip_info;
 	int gain, temp;
 
 	if (val < 0)
@@ -187,15 +187,6 @@ static const struct iio_chan_spec hmc425a_channels[] = {
 	HMC425A_CHAN(0),
 };
 
-/* Match table for of_platform binding */
-static const struct of_device_id hmc425a_of_match[] = {
-	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
-	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
-	{ .compatible = "adi,adrf5740", .data = (void *)ID_ADRF5740 },
-	{},
-};
-MODULE_DEVICE_TABLE(of, hmc425a_of_match);
-
 static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 	[ID_HMC425A] = {
 		.name = "hmc425a",
@@ -226,6 +217,18 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
 	},
 };
 
+/* Match table for of_platform binding */
+static const struct of_device_id hmc425a_of_match[] = {
+	{ .compatible = "adi,hmc425a",
+	  .data = &hmc425a_chip_info_tbl[ID_HMC425A]},
+	{ .compatible = "adi,hmc540s",
+	  .data = &hmc425a_chip_info_tbl[ID_HMC540S]},
+	{ .compatible = "adi,adrf5740",
+	  .data = &hmc425a_chip_info_tbl[ID_ADRF5740]},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hmc425a_of_match);
+
 static int hmc425a_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -237,14 +240,16 @@ static int hmc425a_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->type = (uintptr_t)device_get_match_data(&pdev->dev);
 
-	st->chip_info = &hmc425a_chip_info_tbl[st->type];
+	st->chip_info = device_get_match_data(&pdev->dev);
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->name = st->chip_info->name;
 	st->gain = st->chip_info->default_gain;
 
+	/* Compute index of the acquired chip info in the array */
+	st->type = st->chip_info - hmc425a_chip_info_tbl;
+
 	st->gpios = devm_gpiod_get_array(&pdev->dev, "ctrl", GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpios))
 		return dev_err_probe(&pdev->dev, PTR_ERR(st->gpios),
-- 
2.42.0


