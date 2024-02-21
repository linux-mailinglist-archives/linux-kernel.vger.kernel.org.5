Return-Path: <linux-kernel+bounces-74135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E20485D056
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51941F22889
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB6F3A1A5;
	Wed, 21 Feb 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dm5wpxWO"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98439FE0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496322; cv=none; b=SmJXDQaobNb+BzND22hpsgmTdBB8ZsbaPaoEqrPyh6ya7znbPQJJbtnwOmLbQz3YomgQeELtUP6rN4glc5aIQJhe/JSvfSaJk2mDIllt5p9ZPNOMc8nT/twDTUDPVgNjezLHIwrIsQvfL/HfT/aYfXhlkFWB28nLqNjpusN3BEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496322; c=relaxed/simple;
	bh=/4RHrvnMyEixH5aM1Nq8oXQ5flTobU8B+tYnhQcL4Os=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tG0EpkIl+7UgHdKSn+FKrDqd7aKpljRG+R4uMDRZc4xpi/Ot/MHwsC5+PzpvEDPfFtobwluFKBGuYOdKS5UbUMDvweO7BSpQKv67WTmHG5BDGJHc1ymMOQJsfg1owHlI+LY5/NkWj3g4efhgMWiA9D4rJHPIdjhq9tww3JkVFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dm5wpxWO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e46db0cf82so195609b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708496320; x=1709101120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LntZkoOS3XoaCq85kDcQo9fQHTCSCfK6GDoagwWHxow=;
        b=Dm5wpxWOigGDcFHnO8g2CqDrETI4Q9cUsgTrUAMFxthVbkEuNcRfo9LSuuK0MjFPLb
         s7RARIwhIlggIAv5+q3Ak9mOQ+F/+4+1xAfkeNZJvIDpaDpcDTx/66UetzVwGMVXCkpW
         0Oa2XqeSikpB9cmLTBkpb46jMqN9Sih9G918S5+soBdzPTpbF4H2naiWwQSr3XcOOOcP
         u67PU2q+BY4LrDwVvwSi7r5othjmMs7uiJj3YRArMIMHpKCJ2S7JBHR6gMfSzwHupDhj
         bxSFeDfCFSiK6RHSQDjCJwpE3jpsjN51VHJleDWdkNjUuAIFG0805SCoQrEv5RJPWo1S
         YKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708496320; x=1709101120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LntZkoOS3XoaCq85kDcQo9fQHTCSCfK6GDoagwWHxow=;
        b=RteVIHl+oBi8fQ39K27mkvemxks73g600I99QhwfzwZAfgVJOJl/bi0vAguChfUUNo
         +2biiNiWa+STeJ0azf2M6ZofAtgGiQdwPST8uRc/0MJktmJpooTZMKQyRFfmxAVoYbqF
         JPSXIJmPwphdntEamNPaTl2jETxd+5cCYjZFYU78yBRDoPvXYZgs2be53dJ7xF9pDb0s
         KsFWUhRPwCmM1qZiWiPiuTOu7O++rc6eEYYjwsV490LexCnnHI4NG3jYoBR5Bya1H/Wq
         U3KLJcMfFo/uVjbQeaglxLg0DstMiA/v4lClKuty3E8DZb+cU6qdEuqKUrb0kcLVsXc4
         JY2A==
X-Forwarded-Encrypted: i=1; AJvYcCW1UlpqCozyU8M6Ut49IpJF1S1Lb9k1vxptVU+pg3Cl8JQiPSM6Q2V7M5J5IYcvHYX7OsTc//IgzF8/UlTUGGkqC3ykrgwu13gc77j+
X-Gm-Message-State: AOJu0YwurgPitY+EU7RXsk05WOZfRgMeR6fOVjAf/6LMxdhI8O8H9fAv
	z1cbMm4RPX5eM8oqfQcR4ujPF3zyyoILWNpbnciqVyTXgNakfbL7i8UdhYa+K4ZRoMh19yaYfsp
	TsuLbBkLD
X-Google-Smtp-Source: AGHT+IGT+S8AxMv9UxHFZdTHR/6lXjWjId5nAxpLnWFRYLl39FJzcYxcBUFoJ8SwJesdwsPw+N+U4Q==
X-Received: by 2002:a05:6a00:93a3:b0:6e4:8bb0:5f10 with SMTP id ka35-20020a056a0093a300b006e48bb05f10mr1788718pfb.17.1708496319949;
        Tue, 20 Feb 2024 22:18:39 -0800 (PST)
Received: from localhost.localdomain ([114.103.195.43])
        by smtp.gmail.com with ESMTPSA id r12-20020aa78b8c000000b006e3a9bdeb99sm6751342pfd.40.2024.02.20.22.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:18:39 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	baolu.lu@linux.intel.com,
	"Zhang, Tina" <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] iommu: Fix iommu_sva_bind_device to the same domain
Date: Wed, 21 Feb 2024 06:18:32 +0000
Message-Id: <20240221061832.430-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The accelerator dev can provide multi-queue and bind to
the same domain in multi-thread for better performance,
and domain refcount takes care of it.

'commit 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
removes the possibility, so fix it

Fixs: '092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")'
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommu-sva.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c3fc9201d0be..a95c8f3a5407 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -91,7 +91,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	/* Search for an existing domain. */
 	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
 		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
-		if (!ret) {
+		if (!ret || ret == -EBUSY) {
 			domain->users++;
 			goto out;
 		}
@@ -141,8 +141,8 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct device *dev = handle->dev;
 
 	mutex_lock(&iommu_sva_lock);
-	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (--domain->users == 0) {
+		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
 		list_del(&domain->next);
 		iommu_domain_free(domain);
 	}
-- 
2.34.1


