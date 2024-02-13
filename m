Return-Path: <linux-kernel+bounces-64473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E761D853EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D3328E54C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B962808;
	Tue, 13 Feb 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yq/gZYhp"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D9627E4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863996; cv=none; b=M2bJXwKw51QvV8fmqsFBUbG2+0O4S3V9cBWDMAKhZE9VhmS6yTNUqZqX9FFAeyQGXwzFqs/SObgjmRgh//xo0pfeuQWHFTD6LNxwn1HAc2klnCpkjiepSL6bVqZErtkHpgAILUH+D8UhSOeDeFLWn/6izaUeJKMZ5W0NQgZp/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863996; c=relaxed/simple;
	bh=d08dvCKpJiUuiTN0yYybtSwR0TELwLw/HbrdWXQYfhg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FrLduG/7lJDmiQI84EXaVn5VxWx9sQoddHI7IpCBjTtSz+LQQ+wJQazQQhCNcmFpDuwKFuId3YFE/RK+Xqcvu2yfTej2C9xwCHSDO3MJla1rVzWXDEn4+jd0yaTqYvKwbMXDbvuW36X9ewpfi8RIziUkPewASoZqQB7pjTCx0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yq/gZYhp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411dd149beeso2178225e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707863992; x=1708468792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuynJYD3Xp/+mml/cq1YcpkhYxewgGFG3LGCjX78mXU=;
        b=Yq/gZYhpMb2vdIqWmZxKODdI43aGZG0fFHvPBLOTx2gPC0lDg5pgK+LqgfUI/ejTBg
         LyVI687rHmKM9ed4OTFqnNyp1CdBHzfYp6gh/lZRETHYDdjcuDYJ+bQzCzMJ+/qxDqgn
         Mf+psQ4cEJzSQW6YirXo2BmyhmMzJELjYFaS56kotj4eZuRAFPAi7WhB8lg6LPBwUNPN
         nwyHG5tW6eJQB99UZPBWMoNmROOMKlZCjqXTAb97r0fWHBkqymc/dDfB/51VzbylbHY6
         YIhyGz4ltObq0duLenypzqCHsYnRnEq2LvfBEfS7bwijVjyjY5mWr1E1liOF+TxCHbGq
         nP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863992; x=1708468792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuynJYD3Xp/+mml/cq1YcpkhYxewgGFG3LGCjX78mXU=;
        b=mVatTNeqfhQMGw8ocUu3OeWwBkJQjQFnSbUSahyLFnRTBNcc5DKUi/zQIMQBQHAnZE
         oHfqfWRiJGts7BB3BTC3ej2DMELMDAYT8E/ht2xRWK/ii2uUMJD2Z4DRXHKZlFUJ2izy
         36fHdADXXlk1cRtHPev5wc6d8g0SAzUbzEo22Iel8JXlnoFEZWNMgwkjQG1T+amdhE8A
         aN0ZMGg/QjvBZH1hkKMS6QuKNVSlujDrva/lCv8v9eTLI52uUWh0zI+w4e+CUWvPEsvO
         HRb34QQvobE/vIJTr7bhOyWS3BsJukmOENJZ6K+oSlqHO1HMuHxq50f6nS4lCJAI49RB
         iLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl5ou++Yqckg6aIIhMxHH2Xr9m+sXaWvqBVGXp54WNPRgIeY8ALfpuAGAFS1sgsDryFm9/WwU0j7fxDMunf67zVeGueT+T5A3Kd7qT
X-Gm-Message-State: AOJu0YzrU4+5sluhkCclFOFCiykqVCLE7plbsQeJ9EvQv7c8V3zRYi90
	CCjbxdaK4gvodo1qHyPyWs8zbLXQV9zs9eh6LPTtrjsfpRB6AmaabUE/pnjOifs=
X-Google-Smtp-Source: AGHT+IEquYAlTbz4tEeO3qGgDFZtdhh1eHK8IH7BWWYx0J2UOrXAUkuzWH539LA7Fh3CMP1/Wz3VZw==
X-Received: by 2002:a05:6000:152:b0:33b:1562:cf4c with SMTP id r18-20020a056000015200b0033b1562cf4cmr444177wrx.14.1707863991725;
        Tue, 13 Feb 2024 14:39:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr+hBO00mzvvfxEO9hjMx9Smls2h+bP1VjNTj2DM23IxtVMKIaxxeO3ICJX4r/y3qBkudHjThNp8OLLr/Dh3LIGhrAZOb6G6gJRfyquvp+kIfRN+GcYaJs2Ikz0/bzaCtknumC90BP
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id cc5-20020a5d5c05000000b0033b75a1e8cfsm9262191wrb.24.2024.02.13.14.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:39:51 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH] powercap: dtpm_cpu: Fix error check against freq_qos_add_request()
Date: Tue, 13 Feb 2024 23:39:47 +0100
Message-Id: <20240213223948.1865489-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller of the function freq_qos_add_request() checks again a non
zero value but freq_qos_add_request() can return '1' if the request
already exists. Therefore, the setup function fails while the QoS
request actually did not failed.

Fix that by changing the check against a negative value like all the
other callers of the function.

Fixes: 0e8f68d7f0485 ("Add CPU energy model based support")
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 9193c3b8edeb..ae7ee611978b 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -219,7 +219,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 	ret = freq_qos_add_request(&policy->constraints,
 				   &dtpm_cpu->qos_req, FREQ_QOS_MAX,
 				   pd->table[pd->nr_perf_states - 1].frequency);
-	if (ret)
+	if (ret < 0)
 		goto out_dtpm_unregister;
 
 	cpufreq_cpu_put(policy);
-- 
2.34.1


