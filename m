Return-Path: <linux-kernel+bounces-13142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E3C820043
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49145B225B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9093125B8;
	Fri, 29 Dec 2023 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5zMz23n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9C125A5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d5b7b8adfso16733015e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 07:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703863964; x=1704468764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yo3pw4Y4+/DAbEUX10gW3U2RPDSnEOGK2Vwoc7osW1s=;
        b=C5zMz23nbrrnPx1B6mbk0E8eyY5PIPduiscEf2VmBuyY6m1AQEZQPxatcr9Iejssxl
         MMblJ55mwB5WMiYjyEU3YK1+6mQ3sLgT6B0jsTy728BnhdrBfabuUPuQna9N4TyoIQLf
         U1AzCWAQDLhFCD6E3FwRboVIxJhIDUaAvgdSDMKmrSYAVlyKibTTJwq0casNKA/1w1KY
         9aZdFT02y19HeeEgimKfCvYMwjbA06NmXZKogY42mi6CsPPolcRDMnJeRJxAl+ZCVf68
         MO9HFUjq4s/PEr/UYe4ab81pJpyuSqBTNmsgssb6hs3fFk/WKloQkDCoRwITVDbLQmmu
         o4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703863964; x=1704468764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yo3pw4Y4+/DAbEUX10gW3U2RPDSnEOGK2Vwoc7osW1s=;
        b=BU2mJxGf+c2nITBv1QDe5ucv5Z9CX6PWZfc8r45GKKZgJw6NjmKoo5nt2xTZq8aH7s
         tVZccsktpuvvjBqJZi9jArlP6K9MpV+P8GVymJoxFXxmWf6MrNS5ZE4k0p1KFG4VR72N
         3n4HSD+9aQVKdUhYNU8zTokH9S5TeHw2P345uKHXq+FrA+gs6otvyMaucRaka3cWham/
         40rgb/8cfW3wM38NRD8u5D9OTl9JVLvDV1vfRW+/1tfHzHkZ9uZm85EQHrsBMC+/Rq+F
         K3YKUKr5d6KU7MKLRIhW2ZluEt3lap6BChBQNteadQTwwRIOoL5vEbY3Ec2UkfxxFB/t
         7uDg==
X-Gm-Message-State: AOJu0YzpqV1A+i2Gp9kgCyv6sR7bQ+y3XcvcbiOKQMY2vSLqT9kpByPS
	h2ke2pDgc6mpbVoSrqqqpSQ=
X-Google-Smtp-Source: AGHT+IH5ZGNbcMiuoJlPgrjarRzArMuK9NHvdETSpqmDfslLSZeuxnixjew7u7zUSzIF05ZviZyFMw==
X-Received: by 2002:a05:600c:3110:b0:40d:6eb4:4b81 with SMTP id g16-20020a05600c311000b0040d6eb44b81mr1188643wmo.47.1703863963743;
        Fri, 29 Dec 2023 07:32:43 -0800 (PST)
Received: from localhost.localdomain (bl17-216-113.dsl.telepac.pt. [188.82.216.113])
        by smtp.googlemail.com with ESMTPSA id j10-20020a05600c1c0a00b0040d5b7b9ba1sm12058259wms.6.2023.12.29.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 07:32:43 -0800 (PST)
From: Malkoot Khan <engr.mkhan1990@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Malkoot Khan <engr.mkhan1990@gmail.com>
Subject: [PATCH 1/2] mm/cma: Move opening brace to next line for coding style
Date: Fri, 29 Dec 2023 15:32:37 +0000
Message-Id: <20231229153238.153627-1-engr.mkhan1990@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the opening brace of a function definition 'cma_for_each_area'
to the next line which resolved the error

Signed-off-by: Malkoot Khan <engr.mkhan1990@gmail.com>
---
 mm/cma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/cma.c b/mm/cma.c
index 2b2494fd6b59..01ccd26e8bc2 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -579,6 +579,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
 }
 
 int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
+
 {
 	int i;
 
-- 
2.34.1


