Return-Path: <linux-kernel+bounces-813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAAE814693
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF458285AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A92C681;
	Fri, 15 Dec 2023 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMwvKkwj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B315250E2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3333074512bso933664f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638950; x=1703243750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv1+SAp30QuqxkV8Rm8OeVD8ARUBR+gXbTPrU19ZNuA=;
        b=NMwvKkwjJWMF1euohSkTRUjh2IpaFVybLhPuGfWozFStcvGmAd5yAXLJM6TCD5xchh
         bsyGI60sbfL1iiqHPxLHI5ym68a9uk0syeNxQFWO7wkewos+DN1azF+GZ3siByC+5bSb
         XPF01rEIb9KMG+mV93pUVql8kjjZE2sFEojK4wgnqUO8C01ykxXnbhNX157X/8HNAW8l
         K/X0t5lwA5/8VY8j7lj//yJPQtS87erfPIQyLL7rVPx4Oxhofcn7KN8RzV4UWWC99DRz
         QjHOUWrsJAQfNhF9XJb9wsWjMoZK2RAybQuFCme0auOksUdryaGVUEqKtZHeZoEofko0
         KRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638950; x=1703243750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv1+SAp30QuqxkV8Rm8OeVD8ARUBR+gXbTPrU19ZNuA=;
        b=kBTSsRrxnUseR5EANKeynJgkefRdIvpQlwPT5/jsb1eYPHY/Oa776+dYGyv+VXmS4T
         ZYJfnQYHyaLdB9GNLjR0oF6YQ9gmqzxSrvDbOt3i3/IHT0qBT62TWX1gy56jfyMPYrQx
         2VN3GkTzVWq+TfmJj7H4UB2l7ftRi1AVIyJPKxCqO/DhjY8jm9PyLY26QdGc0w2pbWub
         bGDxgd2bTbvv5UykwWK99vWDkSMDP/t4k179X1imsKKRAy0Dz3s7LSHJm3jbhfr6R2w4
         oK12eqvrKKdAMhGUdPfl5ZKhZE6j4wZpimYx1f/qHbfIE3bzWhMIrFatwo1O8nAN7FT2
         lp/g==
X-Gm-Message-State: AOJu0YwJLL1lTQTkJGNZkgELwd8nAEXfVjF4BoR6gXkWeWlq9Hm5XRNy
	1wApBy/4/83YHNJPlpEZFsM6qZVJqfRpzY1zOVs=
X-Google-Smtp-Source: AGHT+IFbkO7aUALJvcXI1HkyZSixbD3n8NGQAJWtXa/JjL1LZH066Li1MTHmYcLKO8i0Ikaicf2Atw==
X-Received: by 2002:a5d:58cf:0:b0:336:3dd1:e39b with SMTP id o15-20020a5d58cf000000b003363dd1e39bmr2141093wrf.31.1702638949945;
        Fri, 15 Dec 2023 03:15:49 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:49 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/10] nvmem: Simplify the ->add_cells() hook
Date: Fri, 15 Dec 2023 11:15:30 +0000
Message-Id: <20231215111536.316972-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3336; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=qT+nEn+r7xwI19VeUnEAbro3PIHpWLZfcTXcGh7CnWk=; b=owGbwMvMwMVYtfBv5HGTUHPG02pJDKk1puGFn9/q+On/ZLgvrZXkK7eT9Tyr4dsT6ZOm3tC0O GN/tzu6k9GYhYGRi0FWTJFF6bl/1LE/j759l7vbCzOIlQlkCgMXpwBMZOpK9n8mRbYn/nCkrdgU P39HtBl3UcZX9aLp86ef5My2eG6QVzpfyKDvUr/6wTW5wpHv1G/YNGQ+Kr8sVfTn0sUUzn65LaE G77rlrXj0/mhH1ulP9PufqxZqEVp2qvpV8Kun828/0rJKtmG5tqazVXurz9HDy0zFL01aEth6TG zmXm/lVBXRYkOBBaev/IwJT7BYH3pJpHAb74lPHBdUdR/JJvV2bxGXnZpiF1MiO5FdhldcYZWre bLMhLrTXnY6e6Tb/r6LfSE4bU3H59wgiapjvJVywu8FdvHzXMmfVtbRGa37MM3Vt27GfUa3vwFf DJuXPHu2OvpYgqjdutdZGneSOx/8/XMxWeL23UNyLN/cAQ==
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

The layout entry is not used and will anyway be made useless by the new
layout bus infrastructure coming next, so drop it. While at it, clarify
the kdoc entry.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c             | 2 +-
 drivers/nvmem/layouts/onie-tlv.c | 3 +--
 drivers/nvmem/layouts/sl28vpd.c  | 3 +--
 include/linux/nvmem-provider.h   | 8 +++-----
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5e5ce67398f..f63db5e01fca 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -816,7 +816,7 @@ static int nvmem_add_cells_from_layout(struct nvmem_device *nvmem)
 	int ret;
 
 	if (layout && layout->add_cells) {
-		ret = layout->add_cells(&nvmem->dev, nvmem, layout);
+		ret = layout->add_cells(&nvmem->dev, nvmem);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 59fc87ccfcff..defd42d4375c 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -182,8 +182,7 @@ static bool onie_tlv_crc_is_valid(struct device *dev, size_t table_len, u8 *tabl
 	return true;
 }
 
-static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem,
-				struct nvmem_layout *layout)
+static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem)
 {
 	struct onie_tlv_hdr hdr;
 	size_t table_len, data_len, hdr_len;
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 05671371f631..26c7cf21b523 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -80,8 +80,7 @@ static int sl28vpd_v1_check_crc(struct device *dev, struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem,
-			     struct nvmem_layout *layout)
+static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem)
 {
 	const struct nvmem_cell_info *pinfo;
 	struct nvmem_cell_info info = {0};
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index e5de21516387..3939991b3c5f 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -156,9 +156,8 @@ struct nvmem_cell_table {
  *
  * @name:		Layout name.
  * @of_match_table:	Open firmware match table.
- * @add_cells:		Will be called if a nvmem device is found which
- *			has this layout. The function will add layout
- *			specific cells with nvmem_add_one_cell().
+ * @add_cells:		Called to populate the layout using
+ *			nvmem_add_one_cell().
  * @fixup_cell_info:	Will be called before a cell is added. Can be
  *			used to modify the nvmem_cell_info.
  * @owner:		Pointer to struct module.
@@ -172,8 +171,7 @@ struct nvmem_cell_table {
 struct nvmem_layout {
 	const char *name;
 	const struct of_device_id *of_match_table;
-	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem,
-			 struct nvmem_layout *layout);
+	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem);
 	void (*fixup_cell_info)(struct nvmem_device *nvmem,
 				struct nvmem_layout *layout,
 				struct nvmem_cell_info *cell);
-- 
2.25.1


