Return-Path: <linux-kernel+bounces-25347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D982CE15
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 19:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355881C211CE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412265695;
	Sat, 13 Jan 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WfAsRK5R"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6FD566B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28d0052beb0so4873853a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 10:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1705169839; x=1705774639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYp2logoMYZ9jMW04gIUzqQcpGYG2bO16WsCcwCZkXw=;
        b=WfAsRK5R9k0BoTppowB96N7enf9j71uKMcSqZ96OdeXhTm6+259OuV7B+pOe5LGbGh
         UtqwJkiR041u/SlvsYSTUVkg5DtuvdDlFp2aVyROn4IWGDfGObMN2VgwkGnEkwpOCcpn
         ZuWDzmWd9C9jrmU3I+pbc52xJ6zeDZYTXPo4nF3aoC/qUKZGyczrJeOhVwZnApEAethC
         iJYzehCYaJ5SP1T5zmNYuPTJySdVYknZqHe+2WgSi95VlhLGGtOCLXwFU8AYXRu4Hvzy
         BstfxfrWXloTFhGHDGoL5BhTFtizG4vmnOI35rN6rV9nNP8cP4Vi76Gm+RVaHNif9rL5
         htzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705169839; x=1705774639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYp2logoMYZ9jMW04gIUzqQcpGYG2bO16WsCcwCZkXw=;
        b=Ig7xN74eFZj1mMNVcu+XXxlHYaZcHu+wkUKViOeTmgrXmOUFQaSsrYH15ykRG/H9Uk
         TmjF0jwsndURYcqDFCqOPEmI1tLm/7+gkNwZH2p+nFZaLrl2vk2GCT/XUOv6ZFKUoiG5
         JCLu1loBCRL8XY4GO+iXooyXufFhHZPZNVOrHVkbB3FYKv9JR3nWn2e+dX7CPaGLJSyv
         LROTtKEcA0Uj5QavCC234MotutomVFBgAKI4xUmCQ5m8AKJbyt1dGOkUzYe6qdEq3mOZ
         NHOD+laKfrWDJgqdyXOc14nW7zDVnCN83z28wKkHdAOJyuYv+gTWsBqAdbcFXRRdv8so
         TB7w==
X-Gm-Message-State: AOJu0YzljmIG9SsEZcz80/EPNjWaaWfklwy9aTGq68PbJTPwt0pgL1Rr
	M/ngu8Mix+gpzqMix50PQOu1qYnEQgyYgA==
X-Google-Smtp-Source: AGHT+IFHhiY0Ruu2VzN4smgoixnnM3AliTiNgFa93KGVhnKCHSbLCXgydKs8mFTkyx0O5aHwb8BbtA==
X-Received: by 2002:a17:902:f68c:b0:1d4:20b8:abfb with SMTP id l12-20020a170902f68c00b001d420b8abfbmr2051519plg.68.1705169839215;
        Sat, 13 Jan 2024 10:17:19 -0800 (PST)
Received: from localhost ([192.30.189.3])
        by smtp.gmail.com with UTF8SMTPSA id v20-20020a170902d09400b001d563e22dc0sm5059233plv.1.2024.01.13.10.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 10:17:18 -0800 (PST)
From: Eric Badger <ebadger@purestorage.com>
To: ebadger@purestorage.com
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:INTEL IOMMU (VT-d)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/vt-d: Check for non-NULL domain on device release
Date: Sat, 13 Jan 2024 10:17:13 -0800
Message-Id: <20240113181713.1817855-1-ebadger@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kdump kernel, the IOMMU will operate in deferred_attach mode. In
this mode, info->domain may not yet be assigned by the time the
release_device function is called, which leads to the following crash in
the crashkernel:

    BUG: kernel NULL pointer dereference, address: 000000000000003c
    ...
    RIP: 0010:do_raw_spin_lock+0xa/0xa0
    ...
    _raw_spin_lock_irqsave+0x1b/0x30
    intel_iommu_release_device+0x96/0x170
    iommu_deinit_device+0x39/0xf0
    __iommu_group_remove_device+0xa0/0xd0
    iommu_bus_notifier+0x55/0xb0
    notifier_call_chain+0x5a/0xd0
    blocking_notifier_call_chain+0x41/0x60
    bus_notify+0x34/0x50
    device_del+0x269/0x3d0
    pci_remove_bus_device+0x77/0x100
    p2sb_bar+0xae/0x1d0
    ...
    i801_probe+0x423/0x740

Signed-off-by: Eric Badger <ebadger@purestorage.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6fb5f6fceea1..26e450259889 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3750,7 +3750,6 @@ static void domain_context_clear(struct device_domain_info *info)
 static void dmar_remove_one_dev_info(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
@@ -3763,11 +3762,14 @@ static void dmar_remove_one_dev_info(struct device *dev)
 		domain_context_clear(info);
 	}
 
-	spin_lock_irqsave(&domain->lock, flags);
+	if (!info->domain)
+		return;
+
+	spin_lock_irqsave(&info->domain->lock, flags);
 	list_del(&info->link);
-	spin_unlock_irqrestore(&domain->lock, flags);
+	spin_unlock_irqrestore(&info->domain->lock, flags);
 
-	domain_detach_iommu(domain, iommu);
+	domain_detach_iommu(info->domain, iommu);
 	info->domain = NULL;
 }
 
-- 
2.34.1


