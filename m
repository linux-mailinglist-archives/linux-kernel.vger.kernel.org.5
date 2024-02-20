Return-Path: <linux-kernel+bounces-73256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 930BF85C01E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1AB284E24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062E277622;
	Tue, 20 Feb 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYsQRekN"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691A76C68;
	Tue, 20 Feb 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443365; cv=none; b=jfjXeE8T+10NEKBdFUn4qTHBGwobmv3WH2XgU+r4w75yRna4MyHevysaB96uL0R4biUOSUWybXlT+afadq6Iqq+Sb+k52hZPSlIiOj/J2dBjkxCFkkt8nuUgHgZuow2pFGBpYMVi0V+GxNnbL6XV8VZhGkgydthMBdBZrJxTW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443365; c=relaxed/simple;
	bh=IiDK8yjRUxAAf2eafMvrRy3vAP1cD3YZP0awk3yNZro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMSyGj2e/kcOeV8afhoHnFGFxxIs631KMkdtWESZNefxBI3X+NvnfNsWfmvvV8b6Z+KG2+f1cUWvXJCRhwoUW9p7tEXKKOSSejt6BiGbTdfT4ezO7Y8vf9vPo7XFbYrEMQQYbevfzZP8oR36soy0nZbSqCOsB2Hrz3Zyi99Ci0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYsQRekN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so247033166b.2;
        Tue, 20 Feb 2024 07:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443362; x=1709048162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSirVdQH3Tykgt6W5khgr86vPv5b/vVw8tafLC16Tz8=;
        b=bYsQRekNegqaLcx5k2y/G9jVKd55Pp4MnUD+lErY0k23fkE9LJ6nufjgiz2P7oYrYa
         873AAP3Vnp0GOpR+YLd/S2m6ZCbuVRa+N5I2eSMZImlUxZ4qG0vVYz268Y37fYuhWWjY
         fjmqVX49eTV7HUACwwcF6flMjVhIpv8CyqsiJV3n2POR6gOxCRRZVVNaMs7gHnfK7Vg+
         jZSaofI7PCkz+HZjvAGfktvGmeVnsgNBzwxOQStKBkqQwZT8SIgDMSUCHWuKukUovUbI
         BbEf/b5GjE0eXrSqEbVwwQ7PWuGShTwNwHp7p5br7PtVIOjH2ZJsBCZN/JYRoyBXJhVB
         MPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443362; x=1709048162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSirVdQH3Tykgt6W5khgr86vPv5b/vVw8tafLC16Tz8=;
        b=erhYpvcRVJfQPVyv/6dTf1ihO1C0zbqeQ64JpY0dHCBOv0wQMnSk0cyVBSvCMxMgFb
         igxSqgwkM2tLGuBNmmO6qVPkCHKi/LTK4wkuoJVAuBFCwvOp1SjOXjgDtBnKOiJxgSO3
         JOEHyYrvOM1mixALRXaZxHi+yEEoZ8zVc5cvku/qrztgpiJcDFxJQGDnu/zthrx9MRyb
         8eUMQ9aYLZkqyNGE+LbFpzzB7BOqReVVocOtmdbn4acYnhmmLIL3C3saqUDLjQfvX5Rt
         c19mDjXprLcgbxsNTJAMy6O97v1ziZbpnYQfckhxzcx4b424Fvwdt3vAlOjCG8ITM0bZ
         QteQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqNx4yvio74leN/N8JVxFqtFwc6j7nLSs03QmPx0a+8uVWqenBbPm3GJN4aKRp2KK9XO1rhu6WbR+mpr/ZHEmnE3jOcBx0UYG6ZvILk9+xh30WOkZUmlZcS1Yqt2fAhwuzTihMr22zlB6f8ZF8wwXuhKMQP6Sl3HApmUtRZSqO2dbUmw==
X-Gm-Message-State: AOJu0YzGswmT3+QdFWB1S7mZPQVybW/Q7GWftUK0VhGuppZwQmkUsFJA
	TND3sMromm8IvoOoEkDUHdXaXEkZecPhIwZrZ2XH1AbxmmFYXDTYyJiHeGbSI35RurRa
X-Google-Smtp-Source: AGHT+IHRV+GuDs3DqGt4SME+xZgCY62LQ+Goz0qze+WwzKZBwCPcFmieVPunxTRVi7O1WAixQyzshg==
X-Received: by 2002:a17:906:7f1a:b0:a3f:c10:4355 with SMTP id d26-20020a1709067f1a00b00a3f0c104355mr1275849ejr.26.1708443361447;
        Tue, 20 Feb 2024 07:36:01 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906281600b00a3d777aa8fesm4039024ejc.69.2024.02.20.07.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:36:01 -0800 (PST)
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
Subject: [PATCH v5 4/5] iio: amplifiers: hmc425a: use pointers in match table
Date: Tue, 20 Feb 2024 17:34:51 +0200
Message-ID: <20240220153553.2432-4-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220153553.2432-1-mitrutzceclan@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the match table to use pointers instead of device ids.
Remove type from state as it is not used anymore.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/amplifiers/hmc425a.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 13e018a59637..77872e2dfdfe 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -41,15 +41,14 @@ struct hmc425a_chip_info {
 
 struct hmc425a_state {
 	struct	mutex lock; /* protect sensor state */
-	struct	hmc425a_chip_info *chip_info;
+	const struct	hmc425a_chip_info *chip_info;
 	struct	gpio_descs *gpios;
-	enum	hmc425a_type type;
 	u32	gain;
 };
 
 static int gain_dB_to_code(struct hmc425a_state *st, int val, int val2, int *code)
 {
-	struct hmc425a_chip_info *inf = st->chip_info;
+	const struct hmc425a_chip_info *inf = st->chip_info;
 	int gain;
 
 	if (val < 0)
@@ -205,15 +204,6 @@ static const struct iio_chan_spec hmc425a_channels[] = {
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
@@ -261,9 +251,8 @@ static int hmc425a_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->type = (uintptr_t)device_get_match_data(&pdev->dev);
 
-	st->chip_info = &hmc425a_chip_info_tbl[st->type];
+	st->chip_info = device_get_match_data(&pdev->dev);
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->name = st->chip_info->name;
@@ -295,6 +284,18 @@ static int hmc425a_probe(struct platform_device *pdev)
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
+/* Match table for of_platform binding */
+static const struct of_device_id hmc425a_of_match[] = {
+	{ .compatible = "adi,hmc425a",
+	  .data = &hmc425a_chip_info_tbl[ID_HMC425A]},
+	{ .compatible = "adi,hmc540s",
+	  .data = &hmc425a_chip_info_tbl[ID_HMC540S]},
+	{ .compatible = "adi,adrf5740",
+	  .data = &hmc425a_chip_info_tbl[ID_ADRF5740]},
+	{}
+};
+MODULE_DEVICE_TABLE(of, hmc425a_of_match);
+
 static struct platform_driver hmc425a_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
-- 
2.42.0


