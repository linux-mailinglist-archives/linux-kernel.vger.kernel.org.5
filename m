Return-Path: <linux-kernel+bounces-4987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661248184DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11E8B22529
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E71426E;
	Tue, 19 Dec 2023 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci4Hah1H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7814275
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e23c620e8so4073085e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979821; x=1703584621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDfnExpJZu5lDtrGL4NOnG533YvholurjpF0JSG0JHA=;
        b=ci4Hah1HusaAfkhFUlev9YKN0euH1YO2uv8BG0ypsGpbCXP1fDANr9jvslc2EUUN1l
         QMcDw7Z1lo5M4ZUA1TAXAN/SZ7KRF3qoq0iSn8gWoVRnaql5Q2hPPYQqk7QwClky/Cjw
         4Gj4e0E/Yv5YpblrB+S6W0jOHs+tcMNQLDxDx9l5LCl3qzpN2nvhQe4EZ2WFfW+lT7sN
         CKPJh8f50mtDS7Nm8mUKOY5XG/V/qbsbxxrapCydcaRK8MPEnVvTeMHm5mbbqmWMIljf
         SZaXLH3Ot2PFDqppGD4+Paun4tPoIA4qbjocxl0270dVRMQVXBdns1mjKyer0emUphY6
         Rxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979821; x=1703584621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDfnExpJZu5lDtrGL4NOnG533YvholurjpF0JSG0JHA=;
        b=oVUm8vVzlH/B7n9Q8yUfaxoCaxB0rul2/6O0iU7qGnUZg6EKbyOsy1BNkLyzUUb05g
         gpVajH93kinMg2R1eOXSTEFA02Jd+RFPoRK6odzvXTOE5WIqPW4ZRkyyBJIb1Gy4gQyV
         6nFVzX5TXgDUhQyWGGRLv7w8S1AQi0iTbuhPBaKTvCzFMg5A+FI2Bk6f3R6CEUOv9j6h
         P44auqw/tH0Bh2/gScE3agG88B4qN9W920hA/4sag9/crJuxUZMprAqT9BTCdCf+jwSv
         YWFYAmsSZ0G99OwMiz3hgQqs+D0akPdA4qS30c3JiB5fpUcNmyjqp758lyKw/3su5/VI
         9FRQ==
X-Gm-Message-State: AOJu0YzICGd37WxNYqxEz3ZUWHxAfPml9x/QsYi771rUz5oQW2bvonxt
	stwMYfwuupty8R73y9CCoqZmhSZ5Dw0=
X-Google-Smtp-Source: AGHT+IGmH6tQaWng9DmUEo7tJ+H2ieWBpq+2KSusC/Wh+epp/uLa0Ak8oJA7k9P12ScuED1BDdKDBA==
X-Received: by 2002:a05:6512:508:b0:50e:3b86:bf6a with SMTP id o8-20020a056512050800b0050e3b86bf6amr1212955lfb.43.1702979821250;
        Tue, 19 Dec 2023 01:57:01 -0800 (PST)
Received: from alsp.netis.cc ([2a02:2168:8a0b:bd00:ec0a:381e:719d:789d])
        by smtp.googlemail.com with ESMTPSA id eq24-20020a056512489800b0050e233d2533sm991151lfb.159.2023.12.19.01.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 01:57:00 -0800 (PST)
From: Alexander Sapozhnikov <alsp705@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	ToWill Deacon <will@kernel.org>
Cc: Alexander Sapozhnikov <alsp705@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: amd: NULL value may be dereferenced
Date: Tue, 19 Dec 2023 12:56:34 +0300
Message-Id: <20231219095636.17203-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer 'dom' which was dereferenced at iommu.c:1993 
is compared to NULL value at iommu.c:1998.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a0924144bac8..64a88e67be9c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1985,6 +1985,9 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 
+	if (!dom)
+		return;
+
 	domain = to_pdomain(dom);
 
 	if (domain->dev_cnt > 0)
-- 
2.40.1


