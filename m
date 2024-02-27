Return-Path: <linux-kernel+bounces-82760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76F786892A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FCF284978
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7D653389;
	Tue, 27 Feb 2024 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dd26fzy1"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93353388
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016514; cv=none; b=b+c5yb42NQG+BBD0CwPDB1dtTqXeDpVQglHExYzP91vULywLJ7C1XAzcZmaFwbfUww5RRyo8h0DpvQ3NcLwWDIFUsRm2GIuCqRzEwEOJp+Y419iNejWo2oRsrb8Imxs3Y4FPGTJN8DNmjpBecSJ0FA+uhaAWYVSjVZ08ZYEvj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016514; c=relaxed/simple;
	bh=gAZmDrTV3gdyDJKZeIBaeyHPyu+CA7GYjfEYzBnrUmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uyqFNvzKboJiHYCbdCQxgDs96Pfbm08e77XSN2dMAB5+bzC6AuDpKUhwTNnis8gZ/NhvEVBBXmwiv45KlHuS3/rrW/aViQ36LR1udgpm2QYJQ4izfNKjpMXDHPcHkXdR4+EBbXRN2gzMszn7ojkW9f0s8ki+jYGaWlQnx3YsK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dd26fzy1; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c19e18470aso1539688b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709016511; x=1709621311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FBYjN6sLTi7L4W/93/wTWpFgwkV8FUHLIcwh/+Iuvc=;
        b=Dd26fzy1QUAT4wMOv5svkbmLPrnltN8NjAXGlcQAo2RZJeb31arZ7dzhq/xTvn32vz
         IXLfo/o+T0WgVWP4NsW/WFx59vcnr6fxrkCm2MvtQBmPvCh/vtXSOJ6CGj385xrIQueN
         ut+rnpgT+PeouIfYrxfyMdXQC2rcsIyJtqwqdpbhuAQQV7KIYt0WDO4v7l1xQY43UDmT
         S80RQvfsf4s6EQOTY9aQ51Mi2Z18JUF0+PiMHCRArnIp2NaUSCnZID8x7oE56tTP0/Pg
         wnkTLVOJsZxCVU3NaY7bDW5qSnVdzpZSkyt9I/NeR2lDUnfTJ+P9UPChEB1Qw+HVC1l9
         WlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016511; x=1709621311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FBYjN6sLTi7L4W/93/wTWpFgwkV8FUHLIcwh/+Iuvc=;
        b=HxZgnHMZEee+p2e3s7Ar0SXy38pB9XB2Che4qFORJ8uI9OHL4VIzp73oLsfiwkjXKm
         eZs+H1zPcXUjNuO0TMJCaAwUtWP7UHBCToW5ObhNGG+8mQrDobVihq3i3I1w7/OVRIrP
         6YvgHolO82Nvv5JeD7WeSIouK1GJYD8Pr4fWJmqRmR4OOmmFovAsBmBpx3qOEpDh+1Xl
         uHck31vBWEphM5TsUeo/00rh/4xX5uJ6h0YgcC0pcCnq4Ro4vfNY3XSYA56pBh9x/GQ7
         WTxEWujYCVlA7x4wNrOj1+QkOkvkhynCEFyIR02/Nv1NLCqbklXP1Z/V6aAVOCsSeK1t
         XGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoPbxujtri6aszLpFgvptwiyHv35wSLiEfghZzI/vbhhnCsnDtdM+nyTUOX5940wrXkXdqa0jDL8ACV0iXvpiYb9sli2c8ik3ICKGs
X-Gm-Message-State: AOJu0YzXx6EceF0V8WW4XC/N2V419oNRTZv3VquUs51ZZZOx5MzXprzA
	kLYOYnwsVNaaVIUM2z4X3/l6HcD/Y4tCD+zaVsQN947n9Zgz+Fl6/DRDgiVjzHY=
X-Google-Smtp-Source: AGHT+IHHvWagKMC3ICJDsaCVFk4z/6NgugJGHX4oq4lQrnzeCIAv/oIyshplmumfnjLVpI40nRGNvw==
X-Received: by 2002:a05:6808:1a1e:b0:3c1:adf7:c169 with SMTP id bk30-20020a0568081a1e00b003c1adf7c169mr1037171oib.4.1709016511725;
        Mon, 26 Feb 2024 22:48:31 -0800 (PST)
Received: from localhost.localdomain ([114.103.193.174])
        by smtp.gmail.com with ESMTPSA id k2-20020aa788c2000000b006e13a88d52esm5107113pff.61.2024.02.26.22.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 22:48:31 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	baolu.lu@linux.intel.com,
	"Zhang, Tina" <tina.zhang@intel.com>,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH rc] iommu/sva: Fix SVA handle sharing in multi device case
Date: Tue, 27 Feb 2024 06:48:21 +0000
Message-Id: <20240227064821.128-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_sva_bind_device will directly goto out in multi-device
case when found existing domain, ignoring list_add handle,
which causes the handle to fail to be shared.

Fixes: 65d4418c5002 ("iommu/sva: Restore SVA handle sharing")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
Based on rc6

 drivers/iommu/iommu-sva.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 7f91c8d0064b..65814cbc8402 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -117,11 +117,11 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
-	refcount_set(&handle->users, 1);
 	list_add(&domain->next, &mm->iommu_mm->sva_domains);
-	list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
 
 out:
+	refcount_set(&handle->users, 1);
+	list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
 	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
 	handle->domain = domain;
-- 
2.34.1


