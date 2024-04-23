Return-Path: <linux-kernel+bounces-154682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C28ADFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC5F282E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FA7537E9;
	Tue, 23 Apr 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsgONNVZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D751C59;
	Tue, 23 Apr 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860883; cv=none; b=a038XcZilsU8JI4eUfj6rJ9kxs9ZyOif/fQl1ewR550FkuMaWVr93v/zau6uON6/OR9dVUqkxxs3dzYCuNW7USq+WYPCdT9frSqIsCVsvpkMcLT8soBMDtpJF2JdXqvWO/rp3r4AtrXHgAQaDQ5FCjF0wCdqRvVpjV+lXgvnvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860883; c=relaxed/simple;
	bh=d0C33HQybEZzIdgZN8yAFVztmrggKfPv2Wce7jGP7xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gymPShMfyx/uuYIPX52hNZZgSxD5cwKR6/lzaonhbHbrAGDFnEVtngd3szTzvukZaNAvC8sZqNJR/reFv3mOixDG/mdm+9FZp+O8PEm8A1XwS4XKjtWg7mBrKJO42XusUjXy9c8QUfoTg5o1QYkWzuIZ7zvnUkjU/hP8kYcEpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsgONNVZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51bafbe7509so357401e87.1;
        Tue, 23 Apr 2024 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713860880; x=1714465680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oi+kksVAmLiDnfPl3EhNSxJEKMAcV8AHjUA/UGReHCA=;
        b=gsgONNVZE6U6Aohy3FczIrLW23DrBP/jV/0qY2q58SmEbFhgLRLagY/t4wuKL6no00
         9DBr1bM4mRjRuVE3IBwaBSFCTCGE4trzq8pwl8Nh9cZOvUmv5uBqHs8AVMh1A8c6V0mT
         loXUIYFzdx1ePFwMHvWamyKj7GPwQPamd3wYJQUG3xZXk5J4PucwEGoDV5jHR7ghtMX0
         tQSkodE3cBWtuk+VEbvQ0bht8EmwaRcWs8VUrj4hvyeQBt16jchwM3v2Kp21Z+DKd6iV
         PBvI7zQtBZSEEFXCtX20LWmzdLZpHoJ6eKF78Ke20zKSWmtHllzsA3WZWePRNyRtJnva
         pLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860880; x=1714465680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi+kksVAmLiDnfPl3EhNSxJEKMAcV8AHjUA/UGReHCA=;
        b=o0EoZ4cwTvBMnjA6ozlTA4dTimXx2vmkW+A/utcSPg0QJOyRXFWlBT13GWhF6rN2Xr
         aJrHgnIda91jUGiWoxyteEffD1qpR9dcLTYbhHg9G/mNpRIs4whMypmohsx399WejZPw
         9XRVQ05ZM3x8BQoT5jspSlmnnEkZsByIX6QXpubnRA5gug4NudWy62OhXH1uRWcNvXP4
         bbnOp26Euqp0UBY0jBoi8C+secjn5F4mDXXRtp2Jfszx+/dd/B8xiLRK8oamS5P/eK5z
         ZHRVeSvtqv0s9yZLFCHj2Kb69R3uB/AUXkk0V5VqvQidNRW9ceNwXlpM71DkzfxaUZAG
         bzOA==
X-Forwarded-Encrypted: i=1; AJvYcCVmsDRK99lDwxbb76AnVuMHm7PkZyZVdXEXzoSusaYzYEUcmZocmk5rNYzDI71NnwEWl7it9HyxNYDMorfyjeYpLjWZortxYhE9v7Pd
X-Gm-Message-State: AOJu0YzA9cc+h64mfyzp5rUC3RwWttQuO2rgWkmPJ7H/QIkyf+0CWLC5
	d9PKGjW8RfaSC97si2tpREpuSl162BoadB7BdooMILyXNDO934eF
X-Google-Smtp-Source: AGHT+IF7Icf4xFnq8lYBnuZCWCXdkLjK1vKPpxojgtOUi/4kBIDOFWXaPzHZSfD6HdK0tdaphd9tmQ==
X-Received: by 2002:ac2:4e4f:0:b0:516:d1af:adc1 with SMTP id f15-20020ac24e4f000000b00516d1afadc1mr9369519lfr.9.1713860879667;
        Tue, 23 Apr 2024 01:27:59 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm6798786ejp.60.2024.04.23.01.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 01:27:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 23 Apr 2024 10:27:44 +0200
Subject: [PATCH 1/2] cpufreq: dt: eliminate uses of of_node_put()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-of_node_put_cpufreq_dt-v1-1-19f51910276f@gmail.com>
References: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>
In-Reply-To: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713860876; l=1637;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=d0C33HQybEZzIdgZN8yAFVztmrggKfPv2Wce7jGP7xc=;
 b=RWxlXNGqAG/TzyjJ70OIBiL7qItq1KzVbtL8EjAHW9lv+Zct8riu3DAV+6NSqD9Qpj64+t6V/
 e0dvN/UHMaGDrsbAb/94lBB4RZUzqrd3DhG9AyFIb95pLTwRSJsKe03
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Make use of the __free() cleanup handler to automatically free nodes
when they get out of scope.

Only find_supply_name() is affected, and the new mechanism removes the
need for a 'goto' and the 'name' local variable.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpufreq/cpufreq-dt.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 2d83bbc65dd0..907e22632fda 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -68,12 +68,9 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
  */
 static const char *find_supply_name(struct device *dev)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) = of_node_get(dev->of_node);
 	struct property *pp;
 	int cpu = dev->id;
-	const char *name = NULL;
-
-	np = of_node_get(dev->of_node);
 
 	/* This must be valid for sure */
 	if (WARN_ON(!np))
@@ -82,22 +79,16 @@ static const char *find_supply_name(struct device *dev)
 	/* Try "cpu0" for older DTs */
 	if (!cpu) {
 		pp = of_find_property(np, "cpu0-supply", NULL);
-		if (pp) {
-			name = "cpu0";
-			goto node_put;
-		}
+		if (pp)
+			return "cpu0";
 	}
 
 	pp = of_find_property(np, "cpu-supply", NULL);
-	if (pp) {
-		name = "cpu";
-		goto node_put;
-	}
+	if (pp)
+		return "cpu";
 
 	dev_dbg(dev, "no regulator for cpu%d\n", cpu);
-node_put:
-	of_node_put(np);
-	return name;
+	return NULL;
 }
 
 static int cpufreq_init(struct cpufreq_policy *policy)

-- 
2.40.1


