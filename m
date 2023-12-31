Return-Path: <linux-kernel+bounces-13722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EDB820BA4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D5B21124
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289C6124;
	Sun, 31 Dec 2023 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh57j8zY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431C16112;
	Sun, 31 Dec 2023 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d4b650bc9cso1947895ad.0;
        Sun, 31 Dec 2023 06:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704034627; x=1704639427; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTz5TyGFzp4ZGQ+lOKRvj2KlDWSDsjrIEBja4htkNhg=;
        b=Gh57j8zYkzIVg9urYyNHY19j5wXzZwnsOSOtGaLC0ZgO7qlOha5voIr2xvUND6UoYa
         g7pAdSeBsvd346NmJi2KQ6O9WhY5kUFshiF+U7Qf6eLgtCRP6UEQ3o6jmO+lNeJxXT8x
         SDPMgAlgG18cSC/f7Zodm3ajSOv3QJUiOb3OdFbr1pbNKClHamUEF8aeUD4IulFs6yr7
         fNPE8pz+vrLIU7Yqg2g23ByoOTHnf0OKe/1GzdNTTYcreojySldf2ITd2Ars0QunOuDo
         ivqtPM8cJMAvv08MHnLQwB56zPcRibwlrM4Gvmo1n4ygxw+tGRP3KmTltUAv5Qyio58a
         DNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704034627; x=1704639427;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTz5TyGFzp4ZGQ+lOKRvj2KlDWSDsjrIEBja4htkNhg=;
        b=AKOrek7jSkze6zUlyhhpNzaHQlRmonX41PpQ0X04EyVLadFHQKR9tPaOg/kE9Cvi9s
         Ch2CY3oKJtVbYNfBhPy6I9TkvR9oOmkqO4Z1USDMCswS+cphtGcix3otiWrqXw+hXanQ
         rEGr1mjWVjgRArLgr6VqJ53ezQBQyrbJOzLRqy9KJHmuAaotDDmlxzge4S/bsDXN/yeA
         vt7ba8XbRi4vMHAc9tYghpmZEJXLOGylx+dNJP5K9z47uAUvhWb+HJHkDtc5LEuSd8j+
         mrujo3rW/m8WHH9Zw8fcOrrVLx/h9+vuQlgLv3xHyZ/ySCwnCBYxlh3RMNRLufBQnez9
         n3cQ==
X-Gm-Message-State: AOJu0Yy+h4CzOB5mL3fe1u8GrCXXsimKf7jWn3j8cPyg5pXcpw0XESiS
	Q5ABPV7R8q7FrX9Rcg9mXz+5txIdaZPOrw==
X-Google-Smtp-Source: AGHT+IFpjDlcTRgrP8bt+8GIv5RObFRd/g2bE84fn78g+W591uHv/dU9aemwKo65bgNn+M8LaDexGw==
X-Received: by 2002:a17:903:244d:b0:1d4:b017:a053 with SMTP id l13-20020a170903244d00b001d4b017a053mr2183914pls.116.1704034627330;
        Sun, 31 Dec 2023 06:57:07 -0800 (PST)
Received: from localhost.localdomain ([154.220.3.115])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902ea4400b001d3f285157dsm18704367plg.124.2023.12.31.06.57.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 06:57:06 -0800 (PST)
From: zhouzhouyi@gmail.com
To: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "zhili.liu" <zhili.liu@ucas.com.cn>
Subject: [PATCH v2] iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC
Date: Sun, 31 Dec 2023 22:56:44 +0800
Message-Id: <1704034604-9846-1-git-send-email-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: "zhili.liu" <zhili.liu@ucas.com.cn>

Recently, we encounter kernel crash in function rm3100_common_probe
caused by out of bound access of array rm3100_samp_rates (because of
underlying hardware failures). Add boundary check to prevent out of
bound access.

Suggested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
---
The format of the previous patch was a bit problematic,
we are sending it again.

Sorry for the trouble.

Thank you very much.
--
 drivers/iio/magnetometer/rm3100-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 69938204456f..fc50b6d4a334 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -586,6 +586,12 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
 	if (ret < 0)
 		return ret;
+
+	if (tmp < RM3100_SAMP_NUM || tmp - RM3100_TMRC_OFFSET >= RM3100_SAMP_NUM) {
+		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
+		return -EINVAL;
+	}
+
 	/* Initializing max wait time, which is double conversion time. */
 	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
 				* 2;
-- 
2.25.1


