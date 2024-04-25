Return-Path: <linux-kernel+bounces-158137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC88B1C06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BFE2816B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9F6E61F;
	Thu, 25 Apr 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oaty3V5Y"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA3C2AF1E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030636; cv=none; b=YxAsJk17uohSUtptum9uU3gx7Phdt+NCLX8klgMK3gcsT7GoE5XS5zQptCjAOuv4rrap5zFxgPx9pHgqsFtcHB2QUNOOcv4eJO5KSGj4xXge3a7GnRlqiLcczC30z5r6Sl9gYI/LBpDBM9w2UmIgXH89P9paXv2cKzCPWsX79FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030636; c=relaxed/simple;
	bh=BvmJaWcEjXz9GIa99rQTmLRaFz+8HDPHC+3PB1q9ce0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jGLmbDsl8bpoPBt2Re/ULFKhxpYIggNKlSGNxYEPR2jyeSGQXeaEErKLYypdLCdxm7ZEKWs+gNRwJ7vFke7B+X5/uGfPGz6l8oKTAurfV6wS0hh7rc3il7HO7YsT/05hhjGAvmHO1m84WQJBX4BEZ1rMt7sfvKX0TPdOPTbxoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oaty3V5Y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34c0f5f5cd0so218380f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714030633; x=1714635433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJQtTreS4rRlmFcykkG+1PeKJQ26Urc/O33Jw46EHTI=;
        b=Oaty3V5Y75F1CziU6tjzmGWExdNWmfTX7KJSinrFXXERh9v1FDxjlM5WpqXSsHHn6D
         IF/u23rS5GOBL6HcKHv6kEcg1YnXyu+UW4EaEjNtG3phiIus9Blkjl/eZlnVqssXgxkK
         hbKqc4bNnM9J9gqi2GpZHfqDPIP7rZO2GNJktnsX6WTIWAGyQglcwjPopIgvTYHO3vms
         8qul2ohiKmnrEvbqFbD3K9IbgrNq2oky4byzDXG7d2Mk+N9foP5z4y3xQsyQANyiE1oy
         pQb+JySSp9qsadYyETkqn8puFsErFFHHVIX3DwLPPWyKIVY4imaM6Q3a1HZn8dYRMFl5
         d7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030633; x=1714635433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJQtTreS4rRlmFcykkG+1PeKJQ26Urc/O33Jw46EHTI=;
        b=rzlV2OjB1Hw0RSXg7/UWIhnGGC5X0Urn3oDUiu6tv0km3Nihpk/wn+RCZvHP6SqxFY
         RwABlUEwcj+UucrBAkD7kkGIYq2GnxVzzTWDVScQOXcpWoH8edectgEoudkYHKBikjiB
         kYtsDKtrdAeGoWihXw41EggvIVRPYxCf+rBgaUMi0dYB9wK03u1+YkGFTZN6FDrlr8yD
         si0Ysh3JV+TFzaCQ/6FvxFkuq50vJyZMlP6bG47pVBKK7pNXGqXB8DRq2FVy/FCO2IvE
         sPoKmdJULP/h9TDrKHAXd5Q/HwkLQkXA3XTpPZi3+TcGbMamugMzLuMyfwV8C5rmXAS9
         1NHg==
X-Forwarded-Encrypted: i=1; AJvYcCUo+1/ICQQwTZsP1oQUlhlVSEo+ALG5nCgvM68tMGJcA0nsragWDDcv/djb7WKKxmBGJs80aI2UjhBXGsAeBOcOTYsBWSmrxFRLXxAj
X-Gm-Message-State: AOJu0YydtP6QVXEpQy3hjURiGApMJEpjXNVnav5kP/HdX23vWvQ0DP4d
	2+KkQpJiofNPKEc+YRiB4VRCqHRWqk6QkV9uogljWhv8nSw/vWOJHnT8KaEdDlU=
X-Google-Smtp-Source: AGHT+IHuH23iR2ntL6tx1g8Qm+E/dcqJX9TqgSpUslbuPYM9f8aE9MxTYcUu4lj3SWehxr6lYiM3wg==
X-Received: by 2002:a5d:4b48:0:b0:346:cd6f:3fd9 with SMTP id w8-20020a5d4b48000000b00346cd6f3fd9mr2826746wrs.10.1714030632872;
        Thu, 25 Apr 2024 00:37:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c9e5:6905:625:b832])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b00343d1d09550sm19092060wrp.60.2024.04.25.00.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:37:11 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: lkp@intel.com,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	lukasz.luba@arm.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	qyousef@layalina.io
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] arch/topology: Fix variable naming
Date: Thu, 25 Apr 2024 09:37:09 +0200
Message-Id: <20240425073709.379016-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using hw_pressure for local variable is confusing in regard to the
per_cpu hw_pressure variable. Rename it to avoid confusion.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404250740.VhQQoD7N-lkp@intel.com/
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

 drivers/base/arch_topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0248912ff687..c66d070207a0 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -179,7 +179,7 @@ DEFINE_PER_CPU(unsigned long, hw_pressure);
 void topology_update_hw_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
 {
-	unsigned long max_capacity, capacity, hw_pressure;
+	unsigned long max_capacity, capacity, pressure;
 	u32 max_freq;
 	int cpu;
 
@@ -196,12 +196,12 @@ void topology_update_hw_pressure(const struct cpumask *cpus,
 	else
 		capacity = mult_frac(max_capacity, capped_freq, max_freq);
 
-	hw_pressure = max_capacity - capacity;
+	pressure = max_capacity - capacity;
 
-	trace_hw_pressure_update(cpu, hw_pressure);
+	trace_hw_pressure_update(cpu, pressure);
 
 	for_each_cpu(cpu, cpus)
-		WRITE_ONCE(per_cpu(hw_pressure, cpu), hw_pressure);
+		WRITE_ONCE(per_cpu(hw_pressure, cpu), pressure);
 }
 EXPORT_SYMBOL_GPL(topology_update_hw_pressure);
 
-- 
2.34.1


