Return-Path: <linux-kernel+bounces-149165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E968A8CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD786B23773
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52D3FBAF;
	Wed, 17 Apr 2024 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTTx1rE/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3033AC25
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384429; cv=none; b=g011jM3UzhCU0JSw5ffulbwohPXjLqB43QpWhOjV7YayHulIPfHb4IpRVhcYgZ7tsVaifLQoNR3a4zLbCK2P30zjnc1UI0L7EPiBE+QhSeGxnj8b6u6SG7XpCs66N4qCLe2annbEZql1EetenQwIZ6Uc+itCZ+ot/Kn4ZUyzIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384429; c=relaxed/simple;
	bh=K0ao8Vo7sPBfbnwTda3s2I9W96Cl7inckQMbp1qX6wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b216gee6/VcEf1qREQ10uRkFAeJhtZupc3LQzKBypqk8XHp7d2XWo76LUro65cSOFP9Qq2ju3WjRPo2ODfAFEBBIWMf/KTO/L1h8RoO62TYSBqgJ9+ZpYqYUWMMHe/m390AMHosvEt9Lh0hKctXo0hvSmXn2eaAB9qFwzCD0zkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KTTx1rE/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5176f217b7bso115536e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384425; x=1713989225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/wLorb8s/wxRn0nx2P3JnCqrMElCXyUmbwHbfSHp1A=;
        b=KTTx1rE/e0/MJ9ANl1oSARbwv8W7ncBoeGOJX7bNn12ZxzKuQRNcDekxBHw29w6cc9
         YSvzksw11PSlkWLKe010gnfmXoiTNoy0pd9mvKlmb0IeTZVyGN/nnVYkcdGKHwho41on
         4kh2fb2Ra8tQfS46BLOPAQOXVe9mT6OTaRKBJqWDP3XhmlK9ZImcE3uotU670nUb72EW
         CNZKM09h4ySvcSc/muU3IXDW8j1gQqLIM+waStnMb9I5lA/0dIu5LFzJQe8NzXD0xXcO
         g8a83vWH402yIyJ/igUeXrDzZFE2WjssOLqIbuVpTjZbQW6Vs8tWDjOFLJaYwRYX6Pt2
         ld2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384425; x=1713989225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/wLorb8s/wxRn0nx2P3JnCqrMElCXyUmbwHbfSHp1A=;
        b=jICYF1LZgnlKF6FL+Ti1oRE02d2iXv+0D1VnoHHVmLO3sb/Rpavh6aIbZqelEGaWGe
         09MLO+k2aPCuPHNwGl+ZJdnjimpKEuj4jAVjUdSZRjGGfIvnCNSdSwhwYVmqkMmdSvtg
         v9jTx11/JkfDEqly21nV7iKh7/Z6W+Auu8cv3oXLpDkx77+maHKsHlFafNUeV1O+HsbE
         FRGOFtqbWOnTlB+kM35ktrE4064+JKMgKXcDXXFeU4zzpj9WbaeE0pO7yKFDTGVxdRYj
         IhomhbCgZA0fMb31L96loVSaqPVFdRPho3gJ5Zx2DJPkr4mjhFhHxso0jArt/9dM9b/9
         wNpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVITpB9Dy+2WbrryxBGBshaG4jHDdAWu1Pb2OdjiRKAeCzvjvJCbwHSNDAd1brWeWBASMfh1Nu/U43iJHZuqkEkQxXb1OFkzyIHieuJ
X-Gm-Message-State: AOJu0YyPycTIynLDSJuPir9wDisQanTNh5xngbgf629CRbALXkLzuMd/
	mO6Z3Xua5HRt7ELFoz2vaamsBZDzG6Mb/1DmV2bZi7oR6BPVQa8kKH1qDXwy9rU=
X-Google-Smtp-Source: AGHT+IFhc+YiEEchmcEnwplLOB4LzpFRorv1csY8s/d98HoFZzUavjGEBrTgxsRrSSINY1ECFOPWKQ==
X-Received: by 2002:a19:770b:0:b0:518:9ce1:a5bb with SMTP id s11-20020a19770b000000b005189ce1a5bbmr221524lfc.54.1713384425537;
        Wed, 17 Apr 2024 13:07:05 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b00a524e3f2f9esm6128057ejd.98.2024.04.17.13.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:07:04 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 17 Apr 2024 22:06:59 +0200
Subject: [PATCH 1/2] iommu/qcom: Remove useless forward definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-topic-qcom_iommu-v1-1-fabe55b3b7b3@linaro.org>
References: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
In-Reply-To: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384421; l=1236;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=K0ao8Vo7sPBfbnwTda3s2I9W96Cl7inckQMbp1qX6wI=;
 b=6cYUGa8Goag8a2aUNA1eqwMKeX2FK4TOEyCqJmO8C5udyr+6wz+22OMrZWc39n6z6JZ4MLaC1
 WxHuDRgmVY8DzAUtW9uZqmUkiiUQkzrtSPCIaYsmHLZi8HP7Tni0oxk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Simply move code around.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index e079bb7a993e..3dca9293c509 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -41,7 +41,14 @@ enum qcom_iommu_clk {
 	CLK_NUM,
 };
 
-struct qcom_iommu_ctx;
+struct qcom_iommu_ctx {
+	struct device		*dev;
+	void __iomem		*base;
+	bool			 secure_init;
+	bool			 secured_ctx;
+	u8			 asid;      /* asid and ctx bank # are 1:1 */
+	struct iommu_domain	*domain;
+};
 
 struct qcom_iommu_dev {
 	/* IOMMU core code handle */
@@ -54,15 +61,6 @@ struct qcom_iommu_dev {
 	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
 };
 
-struct qcom_iommu_ctx {
-	struct device		*dev;
-	void __iomem		*base;
-	bool			 secure_init;
-	bool			 secured_ctx;
-	u8			 asid;      /* asid and ctx bank # are 1:1 */
-	struct iommu_domain	*domain;
-};
-
 struct qcom_iommu_domain {
 	struct io_pgtable_ops	*pgtbl_ops;
 	spinlock_t		 pgtbl_lock;

-- 
2.44.0


