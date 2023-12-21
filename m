Return-Path: <linux-kernel+bounces-8859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F37081BD58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0637F283609
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD264ABB;
	Thu, 21 Dec 2023 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibHSrjko"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CE64A93;
	Thu, 21 Dec 2023 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26988a86f0so123099366b.3;
        Thu, 21 Dec 2023 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703180080; x=1703784880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XhPv1RG5GYBxA6YK5orD14R9QXHs06Ax0C4Bquly6M=;
        b=ibHSrjkoqUrQVwNbv+6lGv+GikDlzwgAP+9X5zCWMiCasyBG/yWi5mgmaMTKDbdrQe
         CFlIMqGDULcVpbJDMZnkB77xjnEGa2BJK0uGKiPvmPZiUeAl/GOc0YXqmo4GbcLMsfmS
         QraHrgur1+MLrpyHvMWcdn0fMwQjltwmtByS8tECG9AX53FzzJ4p2uaYAod+qAzztxlH
         K4Vz/VzJSr48dYikbeoJCSIWAwUSqpV7cDCbwS4K4p2bLL4p0MImrRSARVn1azIr2+qV
         FFeMAGi04+GlAQl88cRUERs+xgJ1RcbRQrjBvvkWASo/IAw1YSELkliC8ON7oospy9w+
         U8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180080; x=1703784880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XhPv1RG5GYBxA6YK5orD14R9QXHs06Ax0C4Bquly6M=;
        b=fMDlAbhNSXEFt2BlNAJX03h7Ohd7IZUKPQCQfqNd2bkxpZQ4KFl3IjKZ1/lbVUZQd+
         rIRXXlwnl76jz4S3kGmAgMJBOcYdIRaMM1Sjtg8T8g0PJsXiAJYhA2wc4l/8apMBos5b
         FZozXcW2S1Nr0+50UCxATwHP9HONZDXjcM/VMIaSCs949dToVkA2wihY5lKGv5fLrasI
         2OmWWBwNYTO8WlEhHizqEBsBWbTOMSMAHBlbKZQ6/jPVSqYlBpYsRiBW2us4zfy6DBvG
         HOXkUYs+gY2beZcPtKv2lViLpU8EWbycLg4dXE3rDRUQ5BDSfUgHtbhW7WY0qFN3IeKr
         czTQ==
X-Gm-Message-State: AOJu0YwL8jvtpmzxVQ8XU7BnWlmpNRzgeKXNkAfOicfet5wOleut7aSw
	3SfkfofxqdpfBLISgPbMS/M=
X-Google-Smtp-Source: AGHT+IEY+7wyVZIZ+h3uGtQYr+kF581gR4pDcml555wj8gHDXaLod5c5pIXzSSoJp59GcB1hlVt2Ww==
X-Received: by 2002:a17:906:3c18:b0:a22:e2ea:4fad with SMTP id h24-20020a1709063c1800b00a22e2ea4fadmr83814ejg.83.1703180079840;
        Thu, 21 Dec 2023 09:34:39 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709060ad900b00a23499f1d7dsm1176118ejf.209.2023.12.21.09.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:34:39 -0800 (PST)
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
Subject: [PATCH V3 5/6] nvmem: u-boot-env: improve coding style
Date: Thu, 21 Dec 2023 18:34:20 +0100
Message-Id: <20231221173421.13737-5-zajec5@gmail.com>
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

1. Prefer kzalloc() over kcalloc()
   See memory-allocation.rst which says: "to be on the safe side it's
   best to use routines that set memory to zero, like kzalloc()"
2. Drop dev_err() for u_boot_env_add_cells() fail
   It can fail only on -ENOMEM. We don't want to print error then.
3. Add extra "crc32_addr" variable
   It makes code reading header's crc32 easier to understand / review.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
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


