Return-Path: <linux-kernel+bounces-5706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD27818E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FC51C246AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62C37D37;
	Tue, 19 Dec 2023 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL598i1n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E6137D02;
	Tue, 19 Dec 2023 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a235500d0e1so322067266b.2;
        Tue, 19 Dec 2023 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703007644; x=1703612444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvbpVGdOkFoSIrqGEOI2u72GgRBjNjQRomAfCiRlrrE=;
        b=jL598i1nG6qrlZgp6X8/F0jOHeTsKWpXzkau1Thp1dbXEsq+V7ECjJ+7Kf+p8e29E6
         9UwsDwK7JBDiV9Dvs4KCg/vIaRgA0rBTSpe3kaC+Xu9pB0HX9xfdJbJf61gEucwlhXjL
         1vWLlFZMunozo8iA2yrRGdflpgk3MWwJyVsfBqRDKNxE7KddLH7Kj4tNzLCJRyEyCdCI
         RalV3SJaKRft8kVthhNg90CmnEpSFOsnqNYH5RRwwm/WewdSXg577K8BubxjqS3F5GIc
         g4QpRzIn8pWXMz/2fpVEI9+u7m67VQIzOnT8Og2sxUMQ6j+cOM6BmwUSFNlXRi3Njx06
         fufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007644; x=1703612444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvbpVGdOkFoSIrqGEOI2u72GgRBjNjQRomAfCiRlrrE=;
        b=Cj7cwxG9dYiKNqB3EaWkZBDr1kyRhTQiE83cseP0XH4y+pAU45E1pUYrdYOjQeG8jd
         nJY73abE5CRnDopl4Lj1dtKwMG/eT3bNrkrKjLUy/VNLq5ek7BfPGHshhJ3umzg/JBCe
         Z5l28cS0OymiE/IUkL1w+gm47fopBJu+R8SF7y4k1LaByq/7HsVP6n1jZnpz8xb+s6DG
         CLE+GrJBNRWUuYe5yEaB+XGIpJnbdYLvqu/GWgJzOTewV2Z8MWXy+Yzp4uUhM5meyL5T
         2TVN4zQNStH0q9a9ozABlKkkhdh/32aedo9R0GQh4N5bVwL1Ls7+yrsEV3LcHksQ7wf6
         hR1w==
X-Gm-Message-State: AOJu0YyaIKBY3SvZkYOpc5cK6y1w79Z38379K5Vd5tBPIC4SkPvXiPI8
	qQG3oJAzDdBuFmQ7gGWn+c8=
X-Google-Smtp-Source: AGHT+IF7v0el0xOUJw8FCEGpmE14E0MqTBdoBv0Uaj9ZYjmK4P8W4YVF7oTGw5Pmx8ydiXStN/I61g==
X-Received: by 2002:a17:906:da04:b0:a26:8919:6d99 with SMTP id fi4-20020a170906da0400b00a2689196d99mr274634ejb.2.1703007643985;
        Tue, 19 Dec 2023 09:40:43 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id tx27-20020a1709078e9b00b00a1c85124b08sm15834840ejc.94.2023.12.19.09.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:40:43 -0800 (PST)
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
Subject: [PATCH V2 4/5] nvmem: u-boot-env: improve coding style
Date: Tue, 19 Dec 2023 18:40:24 +0100
Message-Id: <20231219174025.15228-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231219174025.15228-1-zajec5@gmail.com>
References: <20231219174025.15228-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

1. Prefer kzalloc() over kcalloc()
   See memory-allocation.rst which says: "to be on the safe side it's
   best to use routines that set memory to zero, like kzalloc()"
2. Drop dev_err() for u_boot_env_add_cells() fail
   It can fail only on -ENOMEM. We don't want to print error then.
3. Add extra "crc32_addr" variable
   It makes code reading header's crc32 easier to understand / review.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: New patch with suggestions from Miquel

 drivers/nvmem/u-boot-env.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 111905189341..befbab156cda 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -132,6 +132,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	size_t crc32_data_offset;
 	size_t crc32_data_len;
 	size_t crc32_offset;
+	__le32 *crc32_addr;
 	size_t data_offset;
 	size_t data_len;
 	size_t dev_size;
@@ -143,7 +144,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 
 	dev_size = nvmem_dev_size(nvmem);
 
-	buf = kcalloc(1, dev_size, GFP_KERNEL);
+	buf = kzalloc(dev_size, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto err_out;
@@ -175,7 +176,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
 		break;
 	}
-	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
+	crc32_addr = (__le32 *)(buf + crc32_offset);
+	crc32 = le32_to_cpu(*crc32_addr);
 	crc32_data_len = dev_size - crc32_data_offset;
 	data_len = dev_size - data_offset;
 
@@ -188,8 +190,6 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 
 	buf[dev_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
-	if (err)
-		dev_err(dev, "Failed to add cells: %d\n", err);
 
 err_kfree:
 	kfree(buf);
-- 
2.35.3


