Return-Path: <linux-kernel+bounces-154412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099518ADBC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216EF1C20E74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266817991;
	Tue, 23 Apr 2024 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk8u2zb8"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5001095B;
	Tue, 23 Apr 2024 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838064; cv=none; b=qkU5IeGHN6rktnuengrdhCZsGIkYeLFAogsqg5X6FmUl3KSBYMKDAojRlbCp92NVsszdcfHcEXtcSiDQBxT2+L8h1XpNAfrDsfxr+jdMVRav00OM8QKOK+fL1UZ7cnaz2fC7lVLRFDBtoXGtjW7DZd9eH9HM8JXJ+oeGuHRDZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838064; c=relaxed/simple;
	bh=z/Qv+lXQdgekJ2pnx+gyidhX4/1Fp+F/X5B9VaDLhHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cLBiEK3gMblaW3Wo6Dpn+prbZ8O8fM2YxISTmQMrwqu0uwTXNSTBfP+PIuALPoYylgd2iaRjdGdLKwsl4D5lUcrpB+CMuBlrpQrGw2IYWKi5ClKI9eSzu8/atTeDR8fpYqhirlp0xH+pMz4sjd6yeEfiHgAc/6Nw4b5kOlRPS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk8u2zb8; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36c191991e2so1128335ab.0;
        Mon, 22 Apr 2024 19:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713838062; x=1714442862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYc9PG4AdLig2kL4uYy88kS70WFB66OiQXfEpWrHUaQ=;
        b=gk8u2zb8MnCNXNinj31tor2bwvVUYzHYehxpbDk4Zjg3sIB6LijCMOKvI/juQQSzES
         5W5leBJTtIzSRq0TAyJmXEd3I6qRS5wII/99N9bgyRnRs5qHo0B8Mf3aNRi9z0hQixIH
         CtolIF7UI5vdFaN17dZ/SVJ75LY8smkALQupJmoLEOguTWTdS0KCXYD5YG/2Cy8zlkd7
         j3fLe83qkvS2f/0wEzEwo8zpw7Tz+Dy/4oJsNkfr1Z5TLKNzDzvY31dRa0eShzCqHi3H
         gd+NyqbQmkH9ZTn2ll6QrNwmk/UjHXCIc7vRT0rH08+Sl7AQbdt6lOeFqQdL19e1kYh8
         vUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713838062; x=1714442862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYc9PG4AdLig2kL4uYy88kS70WFB66OiQXfEpWrHUaQ=;
        b=U7s0WkVp0Fjo+RCLoFWVw0eBNiNdfHfhBvDnyjgBTABLnhRXZUjN9csPaSce2/poFF
         CF/SQSxZx3Uzz9KEujZLiWXn5iIhAdxf6YLH7YYPG4soH6jXuw5llIfLDVmQXIUANuuM
         TjfVK2fRQ+xhL7aU7i7Gyc6S2m/jPelxG/OD5sJuU9/clAl1XF1yS7cBtgToXCdhIFbO
         r7xCj0RhIpgVz6mfOy5nJR2DODevvw0b9nOq9bE4a05MTHY9Mp/84xwXrFN9twipPeib
         U2TM4imhnZFXjSKTw0AFbD9ffX9tct8ESQv4WFRR03CVex5H40mC5P/CjRXXIaRvDf1H
         0c7A==
X-Forwarded-Encrypted: i=1; AJvYcCWmW0v5U8uUtY6HzRuXOKSTOP66fT0BslhkVB/LO3qJVcgLbdlTdKtkTfzQRnGbcWwvpuw36aO4wSXtntBrllkr7sXPS+jlr6JLIA9T
X-Gm-Message-State: AOJu0YxM5BMd4O6KtBeKCMstR9PEDbQLkkm3GR/cQSm9rDNsTkQV/Lrf
	F6h7JvWOsfgL+zEjGpNsLIlpZ//23ca7wyo/jRUgk92gE7e/Qe3s
X-Google-Smtp-Source: AGHT+IGwxh2OM9tX4e5d2qHncG5fuXlT/Z3UAlim+95OglEJdb4efqOND29R/rfjvdfePDaJsOcRog==
X-Received: by 2002:a05:6e02:1caf:b0:36b:fbae:3d01 with SMTP id x15-20020a056e021caf00b0036bfbae3d01mr16150033ill.17.1713838061852;
        Mon, 22 Apr 2024 19:07:41 -0700 (PDT)
Received: from shiv-machina.. (c-73-169-52-138.hsd1.co.comcast.net. [73.169.52.138])
        by smtp.gmail.com with ESMTPSA id v11-20020a056e0213cb00b003662d874215sm2426565ilj.6.2024.04.22.19.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 19:07:41 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Shivani Gupta <shivani07g@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] cpufreq: ti: Implement scope-based cleanup in ti_cpufreq_match_node()
Date: Tue, 23 Apr 2024 02:07:27 +0000
Message-Id: <20240423020727.776360-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies the ti_cpufreq_match_node() function to utilize the
__free() cleanup handler for automatically releasing the device
node when it goes out of scope.

By moving the declaration to the initialization, the patch ensures that
the device node is properly managed throughout the function's scope,
thus eliminating the need for manual invocation of of_node_put().
This approach reduces the potential for memory leaks.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shivani Gupta <shivani07g@gmail.com>
---
 drivers/cpufreq/ti-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 46c41e2ca727..714ed53753fa 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -347,12 +347,10 @@ static const struct of_device_id ti_cpufreq_of_match[] = {

 static const struct of_device_id *ti_cpufreq_match_node(void)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 	const struct of_device_id *match;

-	np = of_find_node_by_path("/");
 	match = of_match_node(ti_cpufreq_of_match, np);
-	of_node_put(np);

 	return match;
 }
--
2.34.1


