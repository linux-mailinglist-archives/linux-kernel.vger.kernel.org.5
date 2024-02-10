Return-Path: <linux-kernel+bounces-60434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B98504E2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2841F22308
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B55C5EC;
	Sat, 10 Feb 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ml2Dfs/y"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EC5BAEA;
	Sat, 10 Feb 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707578077; cv=none; b=Fu4CsIZHZNefNjhCCeTY1mZyIOd6hAwZIZffc4iWq2gKT1KLc/gPjkZ6s7GKiwGzQzB3HYXCcHrDfi7wJrsbSiL7tq1bpfH3qQ4jefEbVaDhO3cexw8mXo58x8SAiHtdwhNvKKQiVKcHXaTc8ASC3N3oLfWeQ7APnl3GcVzWx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707578077; c=relaxed/simple;
	bh=nd1L9dsPPe4pngs/YiF6AK1x1qGLgM6QNIrQbX5TN/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GnyGPV2rer1BCWDOtFDOgxvWhyhFcijxJOppvbpQ6LJaUBISgtiM8sFYhenjP98KVpnRHey3Zfcieh6MH5R2Uq11a77JP21Jzy3Y599VtYGG8Ix/fB0hPN9Jcj2gkStSFoNRd5HlWwES6PhGFV+5Ce/ZIwHWcC8E99+3wlXSrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ml2Dfs/y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d73066880eso17385165ad.3;
        Sat, 10 Feb 2024 07:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707578075; x=1708182875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1YK2Xi7YoM6Fuw/uyfUPTKNXnj0Kxs588qJa21lTm4=;
        b=Zw0k4CAGK9a6zB/KMcuH7EGDSdmivnnKzPblc1AsyN38ESlPub/+Bv0Jc/lm1DVz88
         lhOQ20oIcS3P+e5DPWQjl96jjhAePVg/4O+1JIl88coqwazFMjpwmVB2BoTuQveIZ3vG
         LFWN39HSVs03NzfiqqN8yjsfdsu+O1jHdYhYZZYRJXeJiqmt+rvsJsFvjkL2a70nrcg3
         y6XgvwJNgn8bMABVFEgDkxs3zUwZhXw0J/Qh7+n9uHICGGb2hcKUTVW9ETNA5sdPW+o0
         eDTaMXLHfTGn0eTAY2wDORag78oEtLu3aoebrXdT4GdbU5CV892XI66PMISFvRxy3kLD
         W4HQ==
X-Gm-Message-State: AOJu0Yx8yS2kZxpLPU86qAa6uMESnjnvlnrpg4Uaw7ibG/+qiS45qQQQ
	lnEPWwvUO94qKX8hw2j3P9EppCNUnGCHEPasrA8GUDUku2V/DhRqRowwCzNohwnlrw==
X-Google-Smtp-Source: AGHT+IGmdJrNjvf8sjLdPp67KHOvEcnSFXCaSJbAOt2nQe0shE9bmb1whSEgQK9jDVKiBXGK+a0NhA==
X-Received: by 2002:a17:902:e986:b0:1d8:d5b0:aadb with SMTP id f6-20020a170902e98600b001d8d5b0aadbmr2420584plb.66.1707578074912;
        Sat, 10 Feb 2024 07:14:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVysw4uwwqZM+3PW+p4GJ2oKWLOl0X8to2u7NQ+S0omnTUHuoggCPfs59loVOHLZBdgy7ZGgjsdTYY6sSiPD5H91x96R44jCrL/xGmLZzFyOBVYu5+6pFqe/ENj7HMbCBiz2aeFLojLFQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902c18300b001da1ecb05f9sm1093870pld.240.2024.02.10.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:14:34 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707578073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1YK2Xi7YoM6Fuw/uyfUPTKNXnj0Kxs588qJa21lTm4=;
	b=ml2Dfs/ycTINTElcOg8QE2BFISiBR6ggIOrwVGol9uIuyfwPY8uttZRR5ks6rlsBYiNnXN
	hcBIxaDSea7L63Q9J/0Z+lDI14bYG7wGLgOO0oCPMj9eem3W5tnXAwnhS/gaZ2OYOuUn8W
	0HU0LPtyscwUdFZPQLwGXsBn56JpD+mT837sAEDzOGGSMQicKU4Nvzx/3dvi5MxQsuKJMs
	XtY5MDECvVpx01wXrpRZRy5AjYioRpislfmqch0q+kZT3ifG4jxzANjJIc5ho3sAjvRQjT
	eSHrJ9zXen+vddFKdDehVZnC1K+iaZcWeTCJXnDQJzHK6NHAItm7XPGjYK8afw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 10 Feb 2024 12:15:01 -0300
Subject: [PATCH 1/2] Input: synaptics-rmi4 - make rmi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-bus_cleanup-input2-v1-1-0daef7e034e0@marliere.net>
References: <20240210-bus_cleanup-input2-v1-0-0daef7e034e0@marliere.net>
In-Reply-To: <20240210-bus_cleanup-input2-v1-0-0daef7e034e0@marliere.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=nd1L9dsPPe4pngs/YiF6AK1x1qGLgM6QNIrQbX5TN/4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlx5L5/4DucfC8X49Z3npp/MXnWapGcnKf32oMU
 nGVkTlnWymJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZceS+QAKCRDJC4p8Y4ZY
 phMqD/95yAoKPPBvjJHk2CFOTXRI25iw6mZ4Of4kaFPvmMIeIgGGTAb5hoo2QiFXj/KPbw8CWSh
 YcJP15jwWWL/y0YoxKQWBZ0EuMf85j7IiQH5PP9clsSSOYvHdTkBFJwTkhklSzsDN/KqPBYnMsN
 aTEM1MPDln2HTg//+hfgmiHk7aHBoBwtOc6/wm5W8VpGcwLJ3YWm4PleumV37bKSBX93Kg6HyW3
 HmQKBLwKYhgWWsxvxvY4CMhJ/MENpAbv6MAyrcycuZk97O4mvoy+Z3IqkSNngGi165xqaQA0laz
 dYzYrG+JbMYpWoJaVaEw3wHn2DeLqDMKWF89VaJ0q0gP6JuoyzT8gAt/AsBIUQ8cTe1cMcNiIgs
 n0V9zW0P5AsMH4bq9fZlloHfx9mHrCfjWnOi2Xjn7hCr/KjBJCvxqWakTVgPF9R+hPm8tByKZ4M
 sb6wvwU/6ZaoLxHk6nCRNF/uyBIjYxC+/HqtKYAkYE0pGuGazhGnmxxO/CIcyDr/n4v/LsKqFmy
 8sAqItaN9TnviaIGgHX2prM9KIzbk2mdCREE6LTwF7CF/MUVfPVacyyLwRrfkT4EObbQy5tS+pN
 XtURW4NWQTHhy7V0xRJRW4iToF5FhPAGZm7AtkJjt797E1pULIIiyHrV9X4g8mcgIuF/SfAzrPK
 jfvVVfqE8EM49KQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the variable rmi_bus_type to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/input/rmi4/rmi_bus.c | 2 +-
 drivers/input/rmi4/rmi_bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 1b45b1d3077d..343030290d78 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -344,7 +344,7 @@ static int rmi_bus_match(struct device *dev, struct device_driver *drv)
 	return physical || rmi_function_match(dev, drv);
 }
 
-struct bus_type rmi_bus_type = {
+const struct bus_type rmi_bus_type = {
 	.match		= rmi_bus_match,
 	.name		= "rmi4",
 };
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 25df6320f9f1..ea46ad9447ec 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -185,7 +185,7 @@ static inline int rmi_write_block(struct rmi_device *d, u16 addr,
 
 int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void *data));
 
-extern struct bus_type rmi_bus_type;
+extern const struct bus_type rmi_bus_type;
 
 int rmi_of_property_read_u32(struct device *dev, u32 *result,
 				const char *prop, bool optional);

-- 
2.43.0


