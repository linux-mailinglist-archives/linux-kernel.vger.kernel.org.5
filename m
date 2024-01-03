Return-Path: <linux-kernel+bounces-15411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71819822BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7C2B21FB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450BE18C3A;
	Wed,  3 Jan 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFlix0eG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15318C2D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbb4806f67so5926962b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704279134; x=1704883934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMMpHFwbYIixD5jke+2dMO327Ye7pNGps79GYRqFlIQ=;
        b=TFlix0eGrF0ae3rf6oTFWHjxTKHcRbyAh6eNJHIMtYM/x4phXtowIrZz09RBtqvZY2
         f002XKf92Nym77jmIymUTTin8GLYY3DZyGHDxUd+xbJpTOkiGtcWip8wtK67a4lxvmTP
         L7UQAFVe42LVW67WdKEYHZ/mf4i3f1f3ARnvRR3f/qaVDdCKVgwKJnY0bZr0fSX8eoad
         x7KzYWnPYcibVVIch1DuHqiX+jm2Lxb6qUrYax7PavAUDccAjh3bj7oVwRz21jRv4lMy
         MuHLCm0q+au6DgZu3PJ8dVsXmdXOlP0GzuM70TdkmFZZPiFdiTAYdTI1KA5zOXYQCk2z
         jhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704279134; x=1704883934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMMpHFwbYIixD5jke+2dMO327Ye7pNGps79GYRqFlIQ=;
        b=GVwry8yPPyT/+sStw2BeTDGyJf10y1qRNgQKq2t714bKyCdXj2YdmrkhbfkU+gC/T4
         6645NA24ByE0KOISSL0rM1y7x7gzaSdDWgHsOwy4WBzO3N4KD8jv3TZPexmkXuZm90Bb
         zP4L2c1150VsuOEuFN0NScOHWoPTtpMf83AQ1PuaYJAgyZV0JHmMq7T3ifFBG/1r6gVj
         JKWxV38yi0YHOJQIV2U7zqnTxRbLFWcLo/e8QCgfw7xn3MUQvlEv0DMma6+lZtAe+FXt
         1n4zLWx+4AhpSCUZ/OVmQTqkEObr3hPPoZZAu++ECBN+fjXvdK8iXnI+4Z1hC3VsbPV1
         ZPjw==
X-Gm-Message-State: AOJu0Yzx/0C427/YipQUQ9Z6wTDQSBpb1LSec6fkqX2CzvA5MBN8zJIt
	4mUK8cfR+9VkWZAm9171qPd3MtwYwZMAmw==
X-Google-Smtp-Source: AGHT+IGB3o4aQ9oTUBETxAEAW3t3ETj7JH0FcAUn1/gGrs1Hl2rqiiUzXZIww2T44LjFcv/bDWjFXA==
X-Received: by 2002:a05:6808:1391:b0:3bc:23b6:5d78 with SMTP id c17-20020a056808139100b003bc23b65d78mr997901oiw.16.1704279134381;
        Wed, 03 Jan 2024 02:52:14 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id q26-20020a62e11a000000b006d994a0bba7sm19616273pfh.189.2024.01.03.02.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 02:52:13 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Move dev_pm_opp_icc_bw to internal opp.h
Date: Wed,  3 Jan 2024 16:22:09 +0530
Message-Id: <3b82024c5ba93e7a0db2d0b9635ca6b28338efd7.1704279120.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It isn't used by any driver or API, privatize it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/opp.h      | 12 ++++++++++++
 include/linux/pm_opp.h | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 23dcb2fbf8c3..558c9ac6a6fa 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -50,6 +50,18 @@ struct opp_config_data {
 	unsigned int flags;
 };
 
+/**
+ * struct dev_pm_opp_icc_bw - Interconnect bandwidth values
+ * @avg:	Average bandwidth corresponding to this OPP (in icc units)
+ * @peak:	Peak bandwidth corresponding to this OPP (in icc units)
+ *
+ * This structure stores the bandwidth values for a single interconnect path.
+ */
+struct dev_pm_opp_icc_bw {
+	u32 avg;
+	u32 peak;
+};
+
 /*
  * Internal data structure organization with the OPP layer library is as
  * follows:
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 74768c47d790..76dcb7f37bcd 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -45,18 +45,6 @@ struct dev_pm_opp_supply {
 	unsigned long u_watt;
 };
 
-/**
- * struct dev_pm_opp_icc_bw - Interconnect bandwidth values
- * @avg:	Average bandwidth corresponding to this OPP (in icc units)
- * @peak:	Peak bandwidth corresponding to this OPP (in icc units)
- *
- * This structure stores the bandwidth values for a single interconnect path.
- */
-struct dev_pm_opp_icc_bw {
-	u32 avg;
-	u32 peak;
-};
-
 typedef int (*config_regulators_t)(struct device *dev,
 			struct dev_pm_opp *old_opp, struct dev_pm_opp *new_opp,
 			struct regulator **regulators, unsigned int count);
-- 
2.31.1.272.g89b43f80a514


