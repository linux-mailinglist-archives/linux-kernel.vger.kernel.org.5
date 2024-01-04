Return-Path: <linux-kernel+bounces-16493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36206823F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B972DB214EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DD20DEA;
	Thu,  4 Jan 2024 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="C4AEq2zu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3F20B34
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d5ac76667so2352975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1704363198; x=1704967998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQq9mWoAuRync6lZIxargkK61wifjx5nhgFkBV5J3bk=;
        b=C4AEq2zuzkZBbPjwOLxrWDmfsIOuGHJRQgB/K+Ph/RP47OwtHB6ayUJk5L6AcvUfQw
         HOvzAni0DnNa1tjeXcUIRMWGSJZc15ue6iJPfax7346dZtGv8TXeIjGJE1owrocOKqLF
         21pyfEmKY8ImRMisSHdT3I++AVmclaRK9cTN72553M/W6y80uURk1pECHmHGbkyEKDyQ
         JqnZPTBjUdBQqM/hOqsGDv6e3gmGOmjILbJoYHWu6cLC5wEj/ygFVvpYarB8Cu4swZNj
         VFTqdEKMBPH7t4pn51Vi8iyR1cfSX0Aac7hsY5PYRrzG+T4FPcMVhqZbTrHTFx4pnHzX
         pHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704363198; x=1704967998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQq9mWoAuRync6lZIxargkK61wifjx5nhgFkBV5J3bk=;
        b=X1banq525+chf5kvPh9hYeqnB/5GvyCU2HIoylskCCLl8xwUZi2N3BGdg2w0VQDbyP
         3IESmmrZBFBXX6SKbZwT8JVgnCmX2UM2udztJx9KgrT76+p2sgEuo2Y0nZSaFXlJCs0K
         wRKGlnL3pNlGmHyEePuR0/z1aV8ieK2KQfjCua4skYqI4uPKkrEke6VX0ZVxpsG6JQSE
         kLGCkpnM34vEzXTtRE3E15TSGynt28/gpzL6ilVtP+060VQprlkZR5OZ7sf0eNWrbtC0
         uWVJD1fm8PfoGd0QAm0BSQSzAZs2wSdW3zvY5ZolT4jJ9crSjwzCCWQWWXdNAPayQLxX
         SN4g==
X-Gm-Message-State: AOJu0Yy468104KSRyDrZJBiz2iCqRGUwt33JLDSYSbMK+NTvm7KEhhb6
	yBX+JtLysKL+BWu2edlfIXOQY6GKrn8vaQ==
X-Google-Smtp-Source: AGHT+IHOpfY1YAtRMOkO+DBHeSYS9iUnwtSOqtumrfYxn0WNqhySY2NPSe+xp4JG6VT28T4PMDUPhg==
X-Received: by 2002:a1c:7416:0:b0:40c:22e2:14e9 with SMTP id p22-20020a1c7416000000b0040c22e214e9mr215504wmc.29.1704363198372;
        Thu, 04 Jan 2024 02:13:18 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j26-20020a05600c1c1a00b004030e8ff964sm5268535wms.34.2024.01.04.02.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 02:13:17 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: broonie@kernel.org
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: regulator: Fix typo
Date: Thu,  4 Jan 2024 15:43:15 +0530
Message-ID: <20240104101315.521301-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix minor typo.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 include/uapi/regulator/regulator.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/regulator/regulator.h b/include/uapi/regulator/regulator.h
index d2b5612198b6..71bf71a22e7f 100644
--- a/include/uapi/regulator/regulator.h
+++ b/include/uapi/regulator/regulator.h
@@ -52,7 +52,7 @@
 /*
  * Following notifications should be emitted only if detected condition
  * is such that the HW is likely to still be working but consumers should
- * take a recovery action to prevent problems esacalating into errors.
+ * take a recovery action to prevent problems escalating into errors.
  */
 #define REGULATOR_EVENT_UNDER_VOLTAGE_WARN	0x2000
 #define REGULATOR_EVENT_OVER_CURRENT_WARN	0x4000

base-commit: 67ba055dd7758c34f6e64c9d35132362c1e1f0b5
-- 
2.41.0


