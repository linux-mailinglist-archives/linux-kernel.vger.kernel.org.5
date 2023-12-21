Return-Path: <linux-kernel+bounces-8858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6E81BD56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07811C25E80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793F464A90;
	Thu, 21 Dec 2023 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liA0Yvjl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19463506;
	Thu, 21 Dec 2023 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5540a2516b6so1286143a12.0;
        Thu, 21 Dec 2023 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703180077; x=1703784877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uejKEmqNBQrYztiORMBuyN6ikCtupKPpOgESMooLig8=;
        b=liA0YvjlEOUb10M0I2PvB4S1k/zgdP0U+v/sdy1ew72RLTqt5J/FbF8D/OK+kKri5s
         LgnAN4uOosVgdw4YamomhMif+nKUJB2xs5QsWAWgzEJDG8OC06nE5KXDjklTE7MXiswy
         TkuA+SBzV3QgZ8PMXxKl5gH7bg0jnMxWTvyAqzEdP96uEihdff/Pwf0WMvKDtwUquPIi
         jsQ+1JEYnC6ltwtc3RfnAcl07xFUOmG+nYYbmtB/i/vBzqor2n/rvqKXwsj3NRLQY8ol
         yYqGIQfGnNl/RGAjA4hIFxI1KEnxEBlVSoCwsq1JLdDhTkn2c5ZitOs3t8TqoopCNBS4
         3U8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180077; x=1703784877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uejKEmqNBQrYztiORMBuyN6ikCtupKPpOgESMooLig8=;
        b=RZNRcTvJTjZR1/5wFYJHBgkrBlyas+M9FQZlXwBvR/hfoNyWeT9j+FLFCeYOOJt66+
         h2RD3THUUfj4gt8q1S9LZ/ljXUOIYSy4b87cwgdH8I45yTnFX+3zd7gMXvrOqB3XhFdr
         2ZN6sRtXEYo8qkkLKT6cjr9CcoaBgme7CS4KFvCLP1vWXBdrsm1VnsHusYTcwQ1b4OWP
         Jj9b4tAjZgPt0m8Hfs8Y9Q2xeEI7RlrDMMpAN7D9eXRQMx0p9B1imk9EOX0X6YG2iunK
         t/mfliTYG041f0vwpgoMwtg2q+9dBFHie70vLQkbXndpXajXSph60YzOHBCI38rkryxN
         uEXg==
X-Gm-Message-State: AOJu0YyA1TR16g8ssXZ4el7d2qOODwp1i+4KGbWn141EQGN2WkCB2wGi
	B7sddsi7duCmFmqmqehU6jo=
X-Google-Smtp-Source: AGHT+IHBM2cuaZaaA6HZDolSKAmB6b+hcQMYNNQNKu4rhLvbzqoo/2RVerHBx7krYnQ1piWwRFQhkw==
X-Received: by 2002:a17:906:29cf:b0:a23:8a00:cfbe with SMTP id y15-20020a17090629cf00b00a238a00cfbemr73085eje.132.1703180077492;
        Thu, 21 Dec 2023 09:34:37 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:34:37 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	u-boot@lists.denx.de,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 4/6] nvmem: u-boot-env: use nvmem device helpers
Date: Thu, 21 Dec 2023 18:34:19 +0100
Message-Id: <20231221173421.13737-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221173421.13737-1-zajec5@gmail.com>
References: <20231221173421.13737-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Use nvmem_dev_size() and nvmem_device_read() to make this driver less
mtd dependent.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
V2: Don't introduce memleak when handling nvmem_device_read() failures
V3: Split PATCH 3/3 into two

 drivers/nvmem/u-boot-env.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index dd9d0ad22712..111905189341 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -127,27 +127,34 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
 
 static int u_boot_env_parse(struct u_boot_env *priv)
 {
+	struct nvmem_device *nvmem = priv->nvmem;
 	struct device *dev = priv->dev;
 	size_t crc32_data_offset;
 	size_t crc32_data_len;
 	size_t crc32_offset;
 	size_t data_offset;
 	size_t data_len;
+	size_t dev_size;
 	uint32_t crc32;
 	uint32_t calc;
-	size_t bytes;
 	uint8_t *buf;
+	int bytes;
 	int err;
 
-	buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
+	dev_size = nvmem_dev_size(nvmem);
+
+	buf = kcalloc(1, dev_size, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
-	if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
-		dev_err(dev, "Failed to read from mtd: %d\n", err);
+	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
+	if (bytes < 0) {
+		err = bytes;
+		goto err_kfree;
+	} else if (bytes != dev_size) {
+		err = -EIO;
 		goto err_kfree;
 	}
 
@@ -169,8 +176,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = priv->mtd->size - crc32_data_offset;
-	data_len = priv->mtd->size - data_offset;
+	crc32_data_len = dev_size - crc32_data_offset;
+	data_len = dev_size - data_offset;
 
 	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
 	if (calc != crc32) {
@@ -179,7 +186,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		goto err_kfree;
 	}
 
-	buf[priv->mtd->size - 1] = '\0';
+	buf[dev_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
 	if (err)
 		dev_err(dev, "Failed to add cells: %d\n", err);
-- 
2.35.3


