Return-Path: <linux-kernel+bounces-86736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B1786C9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566F01F21684
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814407E10E;
	Thu, 29 Feb 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcMO1HHt"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F97E0F9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212305; cv=none; b=Z4Y/CholFhwqmAiUC8Qx1WGId1nAtOPpvM/rM4PiQGv4iOYfnfQKvT/afszVhmSCrUWTckrg4G4B4j4H99I50COVcRW6HuxJkuJnq1iNyotvmNXMnQ/KJH5Bm47FJe+kECEOl/LW9VO407jua/3pM9jLPB8QtgE8/OY3zgh3ukQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212305; c=relaxed/simple;
	bh=lQEzSztbGwuMcXFF6UoVbrUM+PR6UEuexVzSDmGCcRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rmhPgD4oJdwp87ex8mqlrc2QwUbPI4SK7CALS0IhE73SZOcuRC2kSFupsXrKuYYmmF5cZpVcbBosQT/RxBmRC9O4XDn9dHAQBS0FFupm27p6x5pOMl2Ql94ntxu5KzfceSd0XRKqbhh8w8E9EW8VY3ssNJWmv5NB2YnNtQbDfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DcMO1HHt; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412aec2505dso6328075e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709212301; x=1709817101; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lg2hnToVZ/EBQAxgZOoEwHDmIEWKGQv1sU1Wb9UKAB0=;
        b=DcMO1HHtRTX6QJOoTLOMlxgbshExarEF6zmAzlNZGW6Ffw38fZMv4hBvFm2heWxTex
         ZNz/Y5/703WBmemRR4ODRgRIiXn5ruW+KkqY72++NnNAaLw+ioexydWpGR16diwu0rBH
         XaDeJdL1cmWr/6uJLudpP5gjbt7OWWI4ufPrbfmMMb67IcJwILxPG08OLsWEL+bS7VQK
         vg/ZKg7dK12DrmpDLSXEnUuGtJUcePyubOGU4IDsWVe5aqa0cNZF+kadi5A/u3zLGwYy
         SI6/Hy4AJ/Hxq0Cn1V5v/n0a8GnQ+j4dalvUTtYCYpwF8vtPDlDp4Wb8aMfbMEp9mq02
         tWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212301; x=1709817101;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg2hnToVZ/EBQAxgZOoEwHDmIEWKGQv1sU1Wb9UKAB0=;
        b=EWE0daHQQl5dHnov+meKRF6IQ61cBrnmNOItIQf/Nujxqe0P3kSX/7PYgH4LEHyVmu
         H3ME63KE/DJUbmdbObROjhJNqvj0D6hSReoApdtOmll4Wu1P+fGSZ4+1HthersCeJ0tL
         NLXv/Th1hWNOocjkAgWXZfmuBDWRhzO31kDXu7qb+n4ejohWAfZmLW0lEIWZXsTARYdw
         qU+jYz3/+OqamRcXHV0lGpA+uKjcgoQKzLgDtN8r5ncALtU1QC2nv88E/VzKsmfeYllE
         2f7LwpdO0oh6Q/mUc5oIjguOz7BJeh1zz2fJb/pwSJRg544C9XgFghu4eRuGFmlvNLOK
         jWwg==
X-Forwarded-Encrypted: i=1; AJvYcCX0eeYawAadsfoKN0l56EtndfhfeH+Ii08f99hvavBMwhPO4FSOR/hIaXrzyoEp2U9+viC9TfXE1/cOY1hJ7kj+KPY8Hf/kScgVPpE0
X-Gm-Message-State: AOJu0Yy8n0RBeePjpOgLmBbTe5B0QUYWFuxo8MOry+d80rzb0fdryQ3t
	BRCjPkr8XlbLONHntY4h/jNuz/6Tmj9tcxtpu3Dvyni/GW+Vj5J9gP1TPhsj60o=
X-Google-Smtp-Source: AGHT+IHo6JyA2wmSz5Sf2SkJPUbSX5WC3VJIKq8+L2nyxU86/uGcghVzDXPtXTd9UjeiMZU/E3gBug==
X-Received: by 2002:a05:600c:4587:b0:412:bdc1:d0f9 with SMTP id r7-20020a05600c458700b00412bdc1d0f9mr1300832wmo.38.1709212301127;
        Thu, 29 Feb 2024 05:11:41 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id jp21-20020a05600c559500b004126101915esm5165227wmb.4.2024.02.29.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:11:40 -0800 (PST)
Date: Thu, 29 Feb 2024 16:11:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shravan Kumar Ramani <shravankr@nvidia.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/mellanox: mlxbf-pmc: fix signedness bugs
Message-ID: <a4af764e-990b-4ebd-b342-852844374032@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These need to be signed for the error handling to work.  The
mlxbf_pmc_get_event_num() function returns int so int type is correct.

Fixes: 1ae9ffd303c2 ("platform/mellanox: mlxbf-pmc: Cleanup signed/unsigned mix-up")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
The code in mlxbf_pmc_valid_range() has a check for negatives but that
has a signedness bug too.  Fortunately "(u32)-EINVAL + 8" will not
result in an integer overflow so the offset is treated as invalid.

 drivers/platform/mellanox/mlxbf-pmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 250405bb59a7..bc91423c96b9 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1496,8 +1496,9 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_counter = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	unsigned int blk_num, cnt_num, offset;
+	unsigned int blk_num, cnt_num;
 	bool is_l3 = false;
+	int offset;
 	u64 value;
 
 	blk_num = attr_counter->nr;
@@ -1530,9 +1531,10 @@ static ssize_t mlxbf_pmc_counter_store(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_counter = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	unsigned int blk_num, cnt_num, offset, data;
+	unsigned int blk_num, cnt_num, data;
 	bool is_l3 = false;
 	u64 evt_num;
+	int offset;
 	int err;
 
 	blk_num = attr_counter->nr;
@@ -1612,8 +1614,9 @@ static ssize_t mlxbf_pmc_event_store(struct device *dev,
 {
 	struct mlxbf_pmc_attribute *attr_event = container_of(
 		attr, struct mlxbf_pmc_attribute, dev_attr);
-	unsigned int blk_num, cnt_num, evt_num;
+	unsigned int blk_num, cnt_num;
 	bool is_l3 = false;
+	int evt_num;
 	int err;
 
 	blk_num = attr_event->nr;
-- 
2.43.0


