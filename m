Return-Path: <linux-kernel+bounces-51684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6422848E38
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764C128436F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE54225A9;
	Sun,  4 Feb 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="DTzBkPzT"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E050224F0
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054978; cv=none; b=dO8vJ+MfaQP/fEvA5v73m3sgTDQFLGyKFOfMRwweV9dn2rzUZ6JHJWe84VaWN4mpQYyDXrnEX175Ot/JD1Kysp1NdOnsXg3vBQ/8CZBJ/HJSSozOyzWnFslMgfNBbVxogJisRtKBvB80AiqZSzUg67Sf0rOtYduPSpudVlyv0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054978; c=relaxed/simple;
	bh=CWCmw+q8+rNcU7KE14U/0u/vJ9GVZxEXQBqUqExR7Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UQIPNDtSO4PbjM9ZRzDVDUXvasH2AWz1OePoJUeDtNQzV0NPWOIvQqJkVGIvbGd4CndrmyZJmIAnPoxu8baoau/xRpX0gc6wOyEEMNEpxrkH1tz0epX8Bq7KVD34IeZ9qS0s2OonbG30A+pWPTBahTJm7p3tb1nyAEyc5CTNajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=DTzBkPzT reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7354ba334so31755915ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 05:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707054976; x=1707659776;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrYrWoc/y4nC4exOvP3RPIgnp7H0XmmPP6togG8Mk2M=;
        b=m1jsvaz0gFLa4vDmRdtC0i7rT9gVuaxh1umkKl4adQmSAJIjMLD93g5H/8RAHrZVd8
         NmSBcDgM0ItAEpWyBrF82xaiNeMdnQYUyGichSh0LAu6/oT+3WtRZeaVqLKd401nggzN
         3xtn1y2k203lWbClbY20ZPnczmGYNtJFFaSxUYCVDO7JQRH0CvnB2ZUWSsnmNVEkx1i9
         8wJnRS0Vqq8jck/qDOgCjExZlTOAOOpJudFO+tLFSaAXz+1lPvRJW/97VWqwc2k6R3X3
         2Zz9vh8FPXOZMSPyv68jSsHpOvM93N7J+NE3CRe8OzOwmIwj1iVCjsoMNTBBMYGmQUru
         sHIw==
X-Gm-Message-State: AOJu0Yx4lblkn4C1uUtmN8UFOJMXeHJURuov8Xh68h8yr0HbpwX42tCB
	yW3IJUYLko8s3a3lXH2xMOH80DC4eGQbwJLJkfAQEDem3xflFpxVcxSpZeodDtN3eA==
X-Google-Smtp-Source: AGHT+IGGbmmk4LlzLpC0xdxNjYT7caSKvOL13KrhAi+gbqTSvA0gvEqIZdWtVF/UZo9SErK8/8WjvQ==
X-Received: by 2002:a17:903:228e:b0:1d7:7b3e:f6b5 with SMTP id b14-20020a170903228e00b001d77b3ef6b5mr17919269plh.3.1707054976442;
        Sun, 04 Feb 2024 05:56:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU1VApz3XCIuPysdmULoWwQUZxul8+iaQ2xUcu+7+pa9T6VMKRHEp36lIz+Ag5ZJ56A0RHwBb/CVXiKiedUMYQ7B9qv2u3TCldjbe56EurEPRNbXHEOOkLAMh64Lh2wtjlBH7AVsOG4fA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ss8-20020a17090b2ec800b00290a6b587fbsm3299341pjb.48.2024.02.04.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:56:15 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707054974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MrYrWoc/y4nC4exOvP3RPIgnp7H0XmmPP6togG8Mk2M=;
	b=DTzBkPzTknwoMeYL2DHvC2TooAZwjOSSMyMr+kt9WHGDvy1dJgMy5L8rfb7f6Agl3RWYGj
	EqS5nocafOPecx9ubsWao8lcM7Cn6+x4k1zQSG/QFSgs8VoDnhXdQ4L9ahZOwOSQv6S/vO
	2oqbM/wTEo7WnQIaNm/6FYzWSnf7zL0J5AYTw7TJjXca+CF7ArwAeFsJGAN0sUu+GCWza/
	v6wM7/LP6v/ZmA+05vHaCPOTpiJUzr3t/VY/DnDrDxS12d8oMXQFVd/n68Xm7oOsbGgCWN
	D+Xq/Vc5TzNVx312ZGeiMXuTJ+Yjv/U1xqLlPud9mybmyVwLsTJO97yL12m5sw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 10:56:44 -0300
Subject: [PATCH] memory tier: make memory_tier_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-mm-v1-1-00f49286f164@marliere.net>
X-B4-Tracking: v=1; b=H4sIAJuXv2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3aTS4vjknNTEvNIC3dxc3RSLZCNLY/MUs8Q0EyWgpoKi1LTMCrC
 B0bG1tQClQvn0YAAAAA==
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=CWCmw+q8+rNcU7KE14U/0u/vJ9GVZxEXQBqUqExR7Qs=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv5ecmXZL6DYx8a/tQMruRiNtOKdoIv0ZOvUuZ
 2tt5PLagYmJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+XnAAKCRDJC4p8Y4ZY
 pvcIEACaDpFDNTOPjGhb57aA/GAb1DZlCs1HIZNYhYHfpJtolP7UWUfhe1yqWrrDrDLL1XzJvcS
 bDRy2JC2Iy5r7RxqxdcReCCuC9T5O9i6v+qWmq4zwRy/SdSDoTUZsCD/bYTE+aCSl6vM0PQhlM4
 0J2FE4HH8AgSsTt5DicHWe2pB4n4oFpJCyVW4Kn+dCFcbDe0UCZ0Nxt5qUaMlXn/VfVPgogqgOv
 ACGoo6jtfANm5MbeOF41laiNBK/6jJfHxuyTRZzsY31GRKr3/0LZJlPtoMjJi49kwi3IDbkt0Bs
 3PslcLN2i2KZfr+DrL/SsjcWEO1p5qo5MpQ0i5H8I3Jct9PwKxAtx5oVQysxz+AoYlxwCqq7cao
 46kasOXsh3QsP+Cczrxn8m+cQohA0WKBRrHicpjJspHpzJXrTq4OjMpCfsP7tlcFbNU5GnxeSbe
 5P/RqN5YMAioHqe0XfYA24diUj6gaQBfVqCsHankVVyYq1Vgej1aroilh5UFvo6DWUZH0RSCqDu
 if1xnvx9z62wYLjaUYYBnkhekAJjBoyDrAI/2VwWm7EaQElTbDpQgYbIvGJ1vjKuCPOHNNHujtJ
 OSC5Jevtmh2cQey4OKRebGXZZA3T3Y6kd0jvqgq2BdIkbtJxk2CJrfWDjCtW5GtB16xlI3Mg3m6
 BZQllqJm5Aq/WuA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the memory_tier_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 mm/memory-tiers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 5462d9e3c84c..ed20f96bf89d 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -39,7 +39,7 @@ static LIST_HEAD(memory_tiers);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
 
-static struct bus_type memory_tier_subsys = {
+static const struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
 	.dev_name = "memory_tier",
 };

---
base-commit: 91f3daa1765ee4e0c89987dc25f72c40f07af34d
change-id: 20240204-bus_cleanup-mm-d8c2937d6af4

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


