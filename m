Return-Path: <linux-kernel+bounces-154683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A088ADFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F01DB23306
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C7853E1E;
	Tue, 23 Apr 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQZJYx6x"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F57524BA;
	Tue, 23 Apr 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860883; cv=none; b=nVg1Sla/y3xkHDTZzeTERAME5pL9IbyTounSkFtynF2Agcz1OvFmnniOCa7EFtph4mAeew+AoozHOCdTjO/qYtpkX/rV1KwsN+ynH88Hgvn7nNdsWKYTZEkFgkJwaYTgfdhotSHZL5dxeoVP1dlc+BQZHbl4oFoUt+qcYKKVxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860883; c=relaxed/simple;
	bh=W8LjUVAmqv/G+B+i2P0GUBDI1TRWfOmtY46AfJi9z+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DtZCtBQrYz5IVvPajYqvRZmbwrAyQ+qQUpKXy182Aeq4TqxzIvekdlhQfI7jGq8U+HPapMYVOHImiHF8sCT5xzflhiw4TsDFHNd3OnAOpn8qYHxhSnLxaPjriZRnm1p14uAsOks2Z4o5s9UIzdz4eWbNortI0KUDXYRJGYVomRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQZJYx6x; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso6628015a12.2;
        Tue, 23 Apr 2024 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713860880; x=1714465680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlx4itTMzYZnTqS6gtVBP4dI6YRkemDRngd0L+Y36pA=;
        b=XQZJYx6xUFNbe9dyXTfJGXJBpVTacv4NKz0CmLKdD5pDyuFSWadSo5iGDBlA7pm1gj
         dmQn0/ro/+xDGbmDN2nTqQtQG7R+6gkWyaMBPviahSJIZbb0Yt9NUGdtRfkt+xftwQN+
         JQ9Kv6ZdiS4RldTQvaaXoKf3DO6cIp0TwWx4/XJjtbbSqK2WJYzyJyfaZejVVL6+FYTR
         1oUZ8zKf12rTTQIZcrmemeRjuBQvW2+Y06BqT50b2n/NyWdj/6ySQT2BkLLemoc4z2aD
         A1m3JijQUJTrIcRzalSLBD2AfE4bIMtlodYeayI/banpWVo2l16vPwDFbQFWgwmQYLwB
         N3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860880; x=1714465680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlx4itTMzYZnTqS6gtVBP4dI6YRkemDRngd0L+Y36pA=;
        b=POkzTOYeuS5YCU5L/zyaugEZsfFxC2XFSyd2uCml1/89ypkZ89OwVVucd6rWbfoKk3
         y8jvmUAU2P/qzXoFC0K1Ll8f6EeyEQDakxWlAFgiRe6akFWe5AABeD/glnh7dl835JmW
         QRXV3WihCry9XmCn9jyoFOhRQcn/tdTk+bIBMF7CajF5U8qsyS/68WU5O7Ekk+mxTSN2
         MSwZRuIBVhj/8xhxN2nLnshDsuugfajAEVU2zF7zkvKqFzOvBH/KWKwq3A3UYVeqNwM/
         +LQiLS1Z90cY1SobOhr7yuRVlKcrctk4Rnl9VMpAC+gw6crsi/4TulMyQxSB9859635N
         PYDg==
X-Forwarded-Encrypted: i=1; AJvYcCVeMocfCoq7Aiq0A50bzmpe3bFMoeJC1dcVVI/AVLpzXqbmV2KLCc1fuXyxFeIAcaUFMl5dOjhgIk+8gjGB0EGZmF277r9BbxrCEjrR
X-Gm-Message-State: AOJu0YzmheeSUSYCLIqzhciOamxb3mo1LSiI49dq0xzt1GYl85i7X9Y5
	jCOg3QniHLe3jMN7HbDsDrT9aF5qAkT6B7jkZYihCl6x0jt65xg3
X-Google-Smtp-Source: AGHT+IEgxdOZQ8SuuB7L2mai+DTt6vRJ1eD4V2jED1n2XIMDcZibJjv1XGjkC7o73VBe2Wxz1vDU3Q==
X-Received: by 2002:a17:906:f8c5:b0:a55:766b:8caf with SMTP id lh5-20020a170906f8c500b00a55766b8cafmr9485194ejb.6.1713860880537;
        Tue, 23 Apr 2024 01:28:00 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm6798786ejp.60.2024.04.23.01.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:28:00 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 23 Apr 2024 10:27:45 +0200
Subject: [PATCH 2/2] cpufreq: dt-platdev: eliminate uses of of_node_put()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-of_node_put_cpufreq_dt-v1-2-19f51910276f@gmail.com>
References: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>
In-Reply-To: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713860876; l=1568;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=W8LjUVAmqv/G+B+i2P0GUBDI1TRWfOmtY46AfJi9z+o=;
 b=6R9d+vfyMbyfOyLA9B2PJLd8ar7A3d0KSveYfeHYcYbckLNjFMi9yvKi0egueBJEojM7rEHLB
 F4e5COJCckIBtUCbTy77x3J4zH7004A+ZiPQBv/VKtVTjhiBZoujEwg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Make use of the __free() cleanup handler to automatically free nodes
when they get out of scope.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 86d8baa81679..c74dd1e01e0d 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -198,19 +198,18 @@ static const struct of_device_id blocklist[] __initconst = {
 
 static bool __init cpu0_node_has_opp_v2_prop(void)
 {
-	struct device_node *np = of_cpu_device_node_get(0);
+	struct device_node *np __free(device_node) = of_cpu_device_node_get(0);
 	bool ret = false;
 
 	if (of_property_present(np, "operating-points-v2"))
 		ret = true;
 
-	of_node_put(np);
 	return ret;
 }
 
 static int __init cpufreq_dt_platdev_init(void)
 {
-	struct device_node *np = of_find_node_by_path("/");
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 	const struct of_device_id *match;
 	const void *data = NULL;
 
@@ -226,11 +225,9 @@ static int __init cpufreq_dt_platdev_init(void)
 	if (cpu0_node_has_opp_v2_prop() && !of_match_node(blocklist, np))
 		goto create_pdev;
 
-	of_node_put(np);
 	return -ENODEV;
 
 create_pdev:
-	of_node_put(np);
 	return PTR_ERR_OR_ZERO(platform_device_register_data(NULL, "cpufreq-dt",
 			       -1, data,
 			       sizeof(struct cpufreq_dt_platform_data)));

-- 
2.40.1


