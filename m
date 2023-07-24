Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41175FAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjGXPcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjGXPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:32:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101EE57;
        Mon, 24 Jul 2023 08:32:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so34803575e9.1;
        Mon, 24 Jul 2023 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690212741; x=1690817541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh131th5kq2SQHF8kYtNRQvjlJTlYiaIhaFGooO8kUo=;
        b=rMuYTyo8xrub4HIbmV+wNnF3zawKWt48DGl+hNOsmEvnykYpXH4QrT+L/D2lXI4/fd
         XrUZdfZ+c4oAQjQ+qqP1qc5ydHikAV181XknINdkQjAJozlQP87I6BHPqsi1r8Wo4sh7
         DEFJnLOwQj5fx10GZ2RCO97YVdr+JX1gZCxheKeqVR+GreqTj9YjSaUUnITXEIcLFD/y
         0vS7QgcHs8/eP5PATEDKZVmcBHHsvPMWnxHsB37cjEGJvUNxr7Ut4+0KldWH5g8zObE8
         OG5ZTyLR20BVWVIVyEcato/71JCk9WGsuzyLpQi40ZOOpuNBenDPeLJ054/ORVLFnW9f
         TTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212741; x=1690817541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uh131th5kq2SQHF8kYtNRQvjlJTlYiaIhaFGooO8kUo=;
        b=jSNT7JtkJ7JMLV6aG4tavcaZuL9j7MQkcv3EKzg2rQLfuwZyv4aDuRcRVMrHcNeMO4
         8UWVlMkwdPw6Rn+eXR1YhSDfb3ygwUxwFvQRky7/+n5xhQnL39RwfZygvmWDNagKfqG8
         YBHtkWGysjLavZf9Hzrv94zwFAu4mGDVaiVvsEjwgMhQMBzZT0KhsknMjw6ROZc10R/L
         +KCJLEJgGhA5qbYHAU6zFfwIstHccPyQ21/nm1yeh+8OTehoUScLCyk6G4q/K+8mQCOt
         6dFbU646lsuY7MSIjZiZ01iKdRwVQmhtFdB1HGNiJRWa0gF46GrNWbiUWapGE9QtK1es
         v/uQ==
X-Gm-Message-State: ABy/qLbbdtNUicwfkLXDvSYqr5WtjXmo7nhcVFBww21xhYqJN0MztnDt
        MnG4vEO5thHkFZEo/GYctrM=
X-Google-Smtp-Source: APBJJlFhTU1ecL9j/gFKbaH5gK0fEaTlhKkfzjQhu1xlFRomN6TcIQhbLQ8V5jkTu1RMqDxyjdvgQA==
X-Received: by 2002:a05:600c:22cf:b0:3fb:ffef:d058 with SMTP id 15-20020a05600c22cf00b003fbffefd058mr5972219wmg.0.1690212740858;
        Mon, 24 Jul 2023 08:32:20 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l8-20020a7bc448000000b003fb40ec9475sm10676900wmi.11.2023.07.24.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 08:32:20 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/3] nvmem: u-boot-env: Permit to declare custom env-size
Date:   Mon, 24 Jul 2023 10:26:31 +0200
Message-Id: <20230724082632.21133-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230724082632.21133-1-ansuelsmth@gmail.com>
References: <20230724082632.21133-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permit to declare a custom size of the U-Boot env that differs than the
partition size where the U-Boot env is located.

U-Boot env is validated by calculating the CRC32 on the entire env
and in some specific case, the env size might differ from the partition
size resulting in wrong CRC32 calculation than the expected one saved at
the start of the partition.

This happens when U-Boot is compiled by hardcoding a specific env size
but the env is actually placed in a bigger partition, resulting in needing
to provide a custom value.

To declare a custom env-size, the new property 'u-boot,env-size' is
introduced to handle this special case.

If the property is not declared, the mtd size is used instead.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/nvmem/u-boot-env.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index ee9fd9989b6e..b64c37308789 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -24,6 +24,7 @@ enum u_boot_env_format {
 struct u_boot_env {
 	struct device *dev;
 	enum u_boot_env_format format;
+	unsigned int u_boot_env_size;
 
 	struct mtd_info *mtd;
 
@@ -149,14 +150,14 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	uint8_t *buf;
 	int err;
 
-	buf = kcalloc(1, priv->mtd->size, GFP_KERNEL);
+	buf = kcalloc(1, priv->u_boot_env_size, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	err = mtd_read(priv->mtd, 0, priv->mtd->size, &bytes, buf);
-	if ((err && !mtd_is_bitflip(err)) || bytes != priv->mtd->size) {
+	err = mtd_read(priv->mtd, 0, priv->u_boot_env_size, &bytes, buf);
+	if ((err && !mtd_is_bitflip(err)) || bytes != priv->u_boot_env_size) {
 		dev_err(dev, "Failed to read from mtd: %d\n", err);
 		goto err_kfree;
 	}
@@ -179,8 +180,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
-	crc32_data_len = priv->mtd->size - crc32_data_offset;
-	data_len = priv->mtd->size - data_offset;
+	crc32_data_len = priv->u_boot_env_size - crc32_data_offset;
+	data_len = priv->u_boot_env_size - data_offset;
 
 	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
 	if (calc != crc32) {
@@ -189,7 +190,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		goto err_kfree;
 	}
 
-	buf[priv->mtd->size - 1] = '\0';
+	buf[priv->u_boot_env_size - 1] = '\0';
 	err = u_boot_env_add_cells(priv, buf, data_offset, data_len);
 	if (err)
 		dev_err(dev, "Failed to add cells: %d\n", err);
@@ -224,6 +225,10 @@ static int u_boot_env_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->mtd);
 	}
 
+	/* In absence of a custom env size, use the full mtd partition size */
+	if (of_property_read_u32(np, "u-boot,env-size", &priv->u_boot_env_size))
+		priv->u_boot_env_size = priv->mtd->size;
+
 	err = u_boot_env_parse(priv);
 	if (err)
 		return err;
@@ -232,7 +237,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	config.cells = priv->cells;
 	config.ncells = priv->ncells;
 	config.priv = priv;
-	config.size = priv->mtd->size;
+	config.size = priv->u_boot_env_size;
 
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
 }
-- 
2.40.1

