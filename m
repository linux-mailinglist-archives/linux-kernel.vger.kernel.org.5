Return-Path: <linux-kernel+bounces-141996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA978A25EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51583B232BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C401BF34;
	Fri, 12 Apr 2024 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vE4qVlcD"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDF18E1A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900969; cv=none; b=g8XzYdxjpABzsOSqqPUlRX4Od+M2HaRnDBkB69Qv1Rk67aSWvyHFGf1uzB0w1xP9Bdc0i9Qn6vknWft9AGne1PgFH8K0YZHhnsoPYsxHhUd/zikvt4wF7KKykFCmEjFiaxzGbUixbI1TG+VjtC8cIFTzZcYTHZPsoG0biLm4VMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900969; c=relaxed/simple;
	bh=HAthljiwuBViFJJBjb+H5U2KyTD6d0C1Zd28//jkp94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9PyDDQJrv4L1pzY7iGp5p4e8aPqUCG8g9GAeq71IvhiKHDhk5bYBje08v/z7M6ULSYj+nox2E6P/jXZRTxL73ZzAvYiWcIFG6XItpgwGRQHR9bC6UJMIpyMQQv6aODkIUxmKSuE6KzqADNSVx6DgZd0m3SbVffjFs6A/eHtUA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vE4qVlcD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e411e339b8so4705435ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712900965; x=1713505765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MvmtmcUVFuRUXBUfcB0LZTjo2io+a5fhtUf/9/DBD+8=;
        b=vE4qVlcDONA/iDyNJtyexH3t40EzmIPly8QcyqSzWDzLbUbb/pwcNVWil+gRYyxcP8
         GZ7vDqK1cukgmEFrRqmpZKUWAsgOfu5q63dPd3a4RkchzCrdY2XQ2tZ50u9/ojdPcFA8
         m6ucDiE18NuDThIZwN6JMe3AdykYf/m58bBwAj6cVWbxwAhxUt0fTerNa6sL2r0Rmn/4
         9Ylunkyt2W8/cRExr5/YBSA9Z8b1nawi6nEMOTB4PGTD9/ZVyxpi3txtEuFTSaahzrcS
         Xl5QlHCgaY2+hsN+BYehHkBPsnlHY8e6ghCInn6Zmd5TTubHMr1LPBzfH8n0gXnH8xlO
         PcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712900965; x=1713505765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvmtmcUVFuRUXBUfcB0LZTjo2io+a5fhtUf/9/DBD+8=;
        b=RDDftXWl/nWXq52NWF91NWzbaP+49IvHyv3cov3VYxDUdrngu46hlDkcaWwo2e+0iZ
         toP7TzP9/BdQkEZf37aGT6Z72+Cn4/Vi9ZZUjHBJ1tJr1w/2y3J8VyjU5rcc4X4VJHWC
         P8wZaMqMpagzMxzDzvVLKpGqMTvJrntn1oi1ilXfFhoP7Q3THI5rMYY7cEbJjA4MxyPh
         rwFkZMpuXBNkJ/ELaaIHG7htttJB8hmJhyWW4Aq58CW2XAgtHtfC6EiL3L/Q/bnMjlDm
         M7MCBIbIoqoJBS5aSeOnE/wlKGtANxTdx4tkJgAuRb22db2OGod4DnUfcgMOiQJMsCT0
         8KzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG3sm67JgIQPiGGyqtDGA9KN9XTOyqkOWF7ZQ0AhvrcdN+ildZRuuVQFVpo3zRwA7O4DGQRSuEJvNG4bTBCE8Ou+hPibmJW9Z5JUL1
X-Gm-Message-State: AOJu0YwdoTjIIwoNLc0RyVw/ZCyn8WU6jfbL0Y70z1YYKpkWrdQvagab
	O3WGt0weh96VJRFNMl2k/9QOUu1t4PwT5NfhTqb+Z6Jg5iOXtocMERQ6hkMX+CQ=
X-Google-Smtp-Source: AGHT+IEulNQkTj46jt7TGYa7Lv2mZ9vZ7iuj4wc5vGXi2U02mgb3eWJWjVEMmq0wy6TpDCUIBw0tpA==
X-Received: by 2002:a17:902:bf48:b0:1e5:9d4:9bb4 with SMTP id u8-20020a170902bf4800b001e509d49bb4mr1685950pls.66.1712900965278;
        Thu, 11 Apr 2024 22:49:25 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001e2a4499352sm2124787plh.262.2024.04.11.22.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:49:24 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	sensor1010@163.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: exit() callback is optional
Date: Fri, 12 Apr 2024 11:19:20 +0530
Message-Id: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit() callback is optional and shouldn't be called without checking
a valid pointer first.

Also, we must clear freq_table pointer even if the exit() callback isn't
present.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66e10a19d76a..fd9c3ed21f49 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1679,10 +1679,13 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	 */
 	if (cpufreq_driver->offline) {
 		cpufreq_driver->offline(policy);
-	} else if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
+		return;
 	}
+
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	policy->freq_table = NULL;
 }
 
 static int cpufreq_offline(unsigned int cpu)
@@ -1740,7 +1743,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	/* We did light-weight exit earlier, do full tear down now */
-	if (cpufreq_driver->offline)
+	if (cpufreq_driver->offline && cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
 	up_write(&policy->rwsem);
-- 
2.31.1.272.g89b43f80a514


