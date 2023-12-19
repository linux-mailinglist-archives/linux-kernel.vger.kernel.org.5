Return-Path: <linux-kernel+bounces-5133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C98186DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F288B249EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AFB1A594;
	Tue, 19 Dec 2023 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu4R23wm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820231A58B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso5425892a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702987280; x=1703592080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ggc4MgLow8E4fR59OH6SNMuCU7W9ARSM1t4iHs9v3xw=;
        b=Pu4R23wmRkGbtNwaOBlmVDK368m9BQRw5SwnCY23I9aTpkuh3Gfc1pfypjyTS/fS1C
         AksBEjnY3dZ9Jbzx7vlMdyIU496euKfIFCau2/ffLwqA7g0rN4USBpaEb4y4Hk0/oji9
         3JMsS0jKhHXHqVNVRumVvV/IoujYQmAxZUo5HFwW++3qpr5MVTPTXs8/n7fMbatzfZIf
         64Cwsxye0KPdXBidRmKGBULgu0p5htxGVmkO3bU3UO/roTZkgJtCXX98Go+BVWO5JaWU
         bbyj8csvUmRr3uslIZogfZXMX3TGxgR2PfrVwcvl052HAHduzg3iQD8x6azuOdCdq1YG
         xQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702987280; x=1703592080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ggc4MgLow8E4fR59OH6SNMuCU7W9ARSM1t4iHs9v3xw=;
        b=HVfYi7aIfUqB7M8K8xBgQzFsdU+reWi0N9uJZz0CX40nylFZZkPOD3Ejx8ygfTYTv3
         RuduVRA9yyzfs+n+zJ6IZyn8LmAz6XIh5DiQ0Faw0VQAOE6irfUPey6/SwcpHmSqH/Zg
         PN1vzzzlUrbB/dni3xzrzU6iyP4Lz4wz89otUQTaCuYzXxuNzLKJ6zhkOPrcwwiG06GE
         tI/XrvCvgtAfzuTaeJMgGLD+6ieqCGsRMZTLKUAt+SpaZ/2WaBxNrJoW6viUC7F6cRrV
         OCx0so6KvEnfF8w7YqT63JmGX/WEU2FFzooHdOxRz5i8gc799WUs6us+nyqorKIaSRjX
         RhqA==
X-Gm-Message-State: AOJu0YwwNCA/rz2loWz15D4JzfmeueTmMu5WT4efXL66HzRK13QBgNL4
	YrPcVw29ZLV5Nfr5sfSKhwU=
X-Google-Smtp-Source: AGHT+IGbWu9nYmKMlQOgTvvIAYGTbf9goRDVatn2xCQG7tStTbISUYi0agdhw2nFSCl3wzgngLUGMA==
X-Received: by 2002:a17:906:c3:b0:a1f:830a:b621 with SMTP id 3-20020a17090600c300b00a1f830ab621mr8866169eji.109.1702987279434;
        Tue, 19 Dec 2023 04:01:19 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ux4-20020a170907cf8400b00a230f3799a4sm6767478ejc.225.2023.12.19.04.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:01:19 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH v6.8 1/2] nvmem: layouts: refactor .add_cells() callback arguments
Date: Tue, 19 Dec 2023 13:01:03 +0100
Message-Id: <20231219120104.3422-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Simply pass whole "struct nvmem_layout" instead of single variables.
There is nothing in "struct nvmem_layout" that we have to hide from
layout drivers. They also access it during .probe() and .remove().

Thanks to this change:

1. API gets more consistent
   All layouts drivers callbacks get the same argument

2. Layouts get correct device
   Before this change NVMEM core code was passing NVMEM device instead
   of layout device. That resulted in:
   * Confusing prints
   * Calling devm_*() helpers on wrong device
   * Helpers like of_device_get_match_data() dereferencing NULLs

3. It gets possible to get match data
   First of all nvmem_layout_get_match_data() requires passing "struct
   nvmem_layout" which .add_cells() callback didn't have before this. It
   doesn't matter much as it's rather useless now anyway (and will be
   dropped).
   What's more important however is that of_device_get_match_data() can
   be used now thanks to owning a proper device pointer.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
Those changes complete layouts refactoring process so I'd very much like
them to go with the rest of refactoring stuff to v6.8.

It's difficult to add Fixes tag due to the nature of refactoring.
Callback .add_cells() existed even before refactoring so I'm not sure
what commit would be fair to blame.

Srini, Greg: could you see if this could still make it into v6.8?

 drivers/nvmem/core.c             | 2 +-
 drivers/nvmem/layouts/onie-tlv.c | 4 +++-
 drivers/nvmem/layouts/sl28vpd.c  | 4 +++-
 include/linux/nvmem-provider.h   | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ba559e81f77f..441d132ebb61 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -854,7 +854,7 @@ int nvmem_layout_register(struct nvmem_layout *layout)
 		return -EINVAL;
 
 	/* Populate the cells */
-	ret = layout->add_cells(&layout->nvmem->dev, layout->nvmem);
+	ret = layout->add_cells(layout);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index b24cc5dcc6ee..9d2ad5f2dc10 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -182,8 +182,10 @@ static bool onie_tlv_crc_is_valid(struct device *dev, size_t table_len, u8 *tabl
 	return true;
 }
 
-static int onie_tlv_parse_table(struct device *dev, struct nvmem_device *nvmem)
+static int onie_tlv_parse_table(struct nvmem_layout *layout)
 {
+	struct nvmem_device *nvmem = layout->nvmem;
+	struct device *dev = &layout->dev;
 	struct onie_tlv_hdr hdr;
 	size_t table_len, data_len, hdr_len;
 	u8 *table, *data;
diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index b8ffae646cc2..53fa50f17dca 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -80,8 +80,10 @@ static int sl28vpd_v1_check_crc(struct device *dev, struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int sl28vpd_add_cells(struct device *dev, struct nvmem_device *nvmem)
+static int sl28vpd_add_cells(struct nvmem_layout *layout)
 {
+	struct nvmem_device *nvmem = layout->nvmem;
+	struct device *dev = &layout->dev;
 	const struct nvmem_cell_info *pinfo;
 	struct nvmem_cell_info info = {0};
 	struct device_node *layout_np;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 6fe65b35ea97..81a67642ac55 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -173,7 +173,7 @@ struct nvmem_cell_table {
 struct nvmem_layout {
 	struct device dev;
 	struct nvmem_device *nvmem;
-	int (*add_cells)(struct device *dev, struct nvmem_device *nvmem);
+	int (*add_cells)(struct nvmem_layout *layout);
 };
 
 struct nvmem_layout_driver {
-- 
2.35.3


