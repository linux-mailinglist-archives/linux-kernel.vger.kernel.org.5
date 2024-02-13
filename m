Return-Path: <linux-kernel+bounces-63707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854C85337C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AEE1C26A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660F57897;
	Tue, 13 Feb 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="PVdccqyq"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828091DFEF;
	Tue, 13 Feb 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835583; cv=none; b=b/06GiAcw3SXzcueuO0cMMVS1ab1ERxBwNrMtMyKd+vIhDU4HFwtDGvx7UKfocdBhhcBu/4XMvSB4mUUIyMc8Hr3bxcnrHrPwHUbQmcFCmWzBVMKNlyBtYTntp2/qYTcDDb29B7NLddw/ghQMquUp1A2Dc5flqh4xGc9hULUduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835583; c=relaxed/simple;
	bh=kidUoxZFy0ItNuGI2h/7jIZ1Rx2PFnX1Nqv9fUCuTZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E7UN2uLdyYQsZv+UUUGfzsi7h+1KrH3wh5tZsYGjHEks8scAa0ovYQKuX0DH1BWVH7xKAW6ovuQKjB2vkxjqIKKQDSLMc1U7B7HNbDhCvrFcguGqe0JQuREL7vf7aguro8hvFKBolTRQ+VeqjcQU6keEZVU9nauH2IbeQQwP+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=PVdccqyq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7393de183so6619735ad.3;
        Tue, 13 Feb 2024 06:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835582; x=1708440382;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDX+/k3S1WfBQBndw34XooQzIlagCadUhSWUJs4bwp8=;
        b=nN+SxagZzO9mK31myAaI3CTBhKgfQMmFfSYMfV+kyiFhNX4PxI9npTlF85cFFv2Chr
         KY2Yig0AD7e9H7scf4J7RGhc/WMuNrwTlnB96JJl08qWXnTeF0xHX5lZXjnFe7fuRgpr
         3wLlEDsSCeVfpGL7Af0WPXhmXeJS5wa/CnV/rp7NZEh+6hZ6CAOsci/0C2boUVp3ikz7
         efNeptLnsD21RwZ0iUIvY+uZiNiyR2MzcrRXNh8bQFOfvF27ALrG+VhpL6RzxX9jgMuB
         pbWfYtabAxIPib/WS8WA+LXulRPzAQWW+/i0gdmi8csRyAC1M6ASQ1z++bhZZvl1LwCD
         0eFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPRwMcXB65FQWWYvxjXh771C/RwDDLvL8NINsgQ2P9TIvC8usiPfBkF1+0+72GgL6/oYZyu2apwrpjqLAs8YsjFGIY3XWkZ/MlJlR3
X-Gm-Message-State: AOJu0Yw76Ce2udoB7UIQTHHU+6omt1L+OPB3X8n7IPQEKTyLvckGNMh3
	1Qm+DU0PGNrKjwimiEaM9rwcq73O3YdZq9YPZiqa1cuzRMCO4/XK3dt8CnqtBOXFMg==
X-Google-Smtp-Source: AGHT+IF40mFHNtNQdI9WqArg42wC8EzpbdeRlv+YcKbvG7yTqNGnYdvC2DeJ02i2xc+xF+iQmRWsww==
X-Received: by 2002:a17:902:bd82:b0:1d7:147d:6a1d with SMTP id q2-20020a170902bd8200b001d7147d6a1dmr8480320pls.55.1707835581715;
        Tue, 13 Feb 2024 06:46:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWlqvLCjz6dLzZyb4bQ1wPUqP/LhVfb4vID02jXpavGta5VbDKzZCh0GeGSUKr8G7LkBfoy3WeGJgisgzQQHCuKBeEG93nq97jc6w/1ECp6U5mu2lWIc4Pm6hT6WQkkScEP8yXKEx4+SXxGyGeBpP8izQ6ROI2L2li6vxq9b/CUqBm5aIZkpehEXBt/prhwHup7aWDX2c1fdgqm9gWwaGRRXUK3hl6VdaQND58NuMRLj4H6xKxXvpEBt8rFK10BVH2sEoPdh1NlSy79kijapzRoV4Hx7SIY10UcNUtWKVnvGhn5E98jgIMDBd+cwlI28eFlqgowOTXGs9q4+Nzqa36
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b001db47d7cf50sm537758plb.272.2024.02.13.06.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:46:20 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eDX+/k3S1WfBQBndw34XooQzIlagCadUhSWUJs4bwp8=;
	b=PVdccqyqiXomAyi9C4t3SJqszMvzJglljIsrhu5zE0dfVKwM9XQ1xITqTBKJIvRZWJ/Kj+
	tfTBgSL7T5V9HJjKFeedvcwzC6DyZZHYWU0R13WejjZ4XrA0Ouwt3GEeuliFu9FK5s1jkC
	K22Kfgtktz5mDjkHGH9YU5L0b/kZcNXcskA02TVNIKvifClA6N8r3P+vDUN9CGGqSLQpWP
	XIx6EE4s/3SZwlRu1pNk4K+imt10SBpmT30C6nj8jDWEkwvbG3UkO5M+FmxZxJpIHcJDPr
	fkWehVnvCjc2aBmMnGhYuZegugu/GhLjplILKJpY6CqPrXlLCl1w5FY/GLgHQg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:46:59 -0300
Subject: [PATCH] cxl/port: make cxl_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-cxl-v1-1-a601adabb391@marliere.net>
X-B4-Tracking: v=1; b=H4sIAOKAy2UC/x3MQQqAIBBA0avErBPUQqKrRITaVANiohSCePek5
 Vv8XyBhJEwwdwUivpTo9g2i78Be2p/IaG8GyeXIpRiYedJmHWr/BGazYxaVmbRQaLiBVoWIB+X
 /uKy1fgsO4fxhAAAA
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=kidUoxZFy0ItNuGI2h/7jIZ1Rx2PFnX1Nqv9fUCuTZg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4DjKDfvpbSDgYsZrfSINaJgVcHmJzTkzIRwo
 O+5P4d3ak6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuA4wAKCRDJC4p8Y4ZY
 plfcD/0Wd8xybfRLmDZfS2VmK10pdyWVZZ8eTC+t9SeCEp3AFGerk1QyH9TJJjF+jUQnLxmqRQ2
 I2FlEntHodgMESLBKSsSn3Kd1XVvBKWokP6F2JDYplYXP9SD14WTub/+O2vRtIYUtZcus8Tnqke
 oc7EyGYNpzq/VRdSSR3S7gIjEYuQ0OngZq1qV7G//TV4+ZAtOCjteWqVNGavSxjoJWg0tUUkbX/
 5+lxvVUGtvvElFE/clQgCqYbnATKfxRaYpIVzhELOqVpMXoQXgR3yGdSU45Xn7LZ1X57iP0xg4G
 Z8WIqkXBwuuGd5+XWUaHIpGHIrSnpwPtZN2Mhi4F8LvyVsXIPZuZPmY7qirICsITUzs56o9WHdo
 zMHhGCJCo+1MDPKozBXRmv87cmS00fPEhHkfsF9CGntMGveKJ5lqNEZ2swrC2HKJKhAxwjQITXg
 0Z7ttVKm+xMza5z2waUzknnPhgnpmAdz/X/5IAweIAyTo1NA3hTP01LFZiujKFyyw6Bu8aE6Q+J
 XL1ht9nAf+5LVwz2zFVhaiGYgkxaj6VfWPKgeYpm+GFV417pPqjhgHPJlVyupojaVjkht6n/Tqp
 lkfS4oNBrVx1ETrZiQOiDKTC79Bhg1pbOZQonIODZ3Kg2BIHeyzAdLYpTCi1bSoXURvxKJ7gQOF
 bt9q5/SkeWnA98w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the cxl_bus_type  variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/cxl/core/port.c | 2 +-
 drivers/cxl/cxl.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e59d9d37aa65..a73c1d1dd4c4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2197,7 +2197,7 @@ static const struct attribute_group *cxl_bus_attribute_groups[] = {
 	NULL,
 };
 
-struct bus_type cxl_bus_type = {
+const struct bus_type cxl_bus_type = {
 	.name = "cxl",
 	.uevent = cxl_bus_uevent,
 	.match = cxl_bus_match,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6017c0c57b4..122015f7a558 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -803,7 +803,7 @@ int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 
 bool is_cxl_region(struct device *dev);
 
-extern struct bus_type cxl_bus_type;
+extern const struct bus_type cxl_bus_type;
 
 struct cxl_driver {
 	const char *name;

---
base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
change-id: 20240213-bus_cleanup-cxl-ce6b8a16eb0b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


