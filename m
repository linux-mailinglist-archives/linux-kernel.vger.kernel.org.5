Return-Path: <linux-kernel+bounces-21197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A422828B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FCCB212EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA513BB33;
	Tue,  9 Jan 2024 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRAyS3Ze"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF483BB24;
	Tue,  9 Jan 2024 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3367f8f8cb0so3146331f8f.2;
        Tue, 09 Jan 2024 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704823132; x=1705427932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBLORV9f1wdNQ5IV3RUD+Re4v0t7IkYwSTUQvtOoQHE=;
        b=RRAyS3ZeBbS3UNU6P4y9mPuHsS4DsRNNV2JEMu5owtilJ8Oy/1FyxhDziZ33hXioUc
         lcQT/Bm5teNPhUVibxh4HPPjBZCr+D9kGZNtj3MSTxfxbme6GauPY1cR2L6ho4LOoSa7
         w+7oMaleOlrD7VWcwDon6o4MVL9xkQ6g2lS2SgZosM9btwxDPK6UjZaFWxJ+HOTNjHIj
         +CgpIK8PmuDdyW/rnBz6sBlxSMqjwLGTujABacVz14yKaZc5yDJWNyMO0mBKmInBiKde
         lf68esbRDaWfJeUAnGPS0ljSQUqmZrn0pyDFuEf7u40KXsQ3E8ThmdX0uJfYeMxiAWxj
         UxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704823132; x=1705427932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBLORV9f1wdNQ5IV3RUD+Re4v0t7IkYwSTUQvtOoQHE=;
        b=mnXr2eQeiJRSjG1zD1otrSmUTr3oiokHOXc4tkV8XlL6cHTsqrgSwwsBI8d3tff+B+
         0OOVT/qJXgPza9oHHpzDbQQ8bCa32S06r7xwyk25Id+SdMuyZfsmOrcm0BtPqhAtPKaK
         pWf7iEyC5YjiXCuOqrm6J/0ITGAoMXiBnkCWk64vh+l9ZWYO2Xnw53Jt/U3YQ6MJKOmd
         o6wPmTDyW/D4z1eMyYPP5m9sHkiEmwXn5CVOcJONJwS45yohWmdpHTOIxacCBgvOC8po
         8+fEV4lUtjkORtAqnb1yVIGyyDEWWwSvhbVTzS/hNyZ6i6Fcnk+f5QeyVrfBgzbbU79o
         ydsQ==
X-Gm-Message-State: AOJu0Yy2D0K51xrfODWqrAKGyHZqBoxqOm/L06s+NNY7xPSgWMpYf1Oi
	ip8HtnPPQqO6UrL/IB80v6uWKtqQjjY=
X-Google-Smtp-Source: AGHT+IFilyxnHtVyC4EuAKfjm8Ax+uaTvo3R173eY/2PB3iZc28H5rRAPG+mchtL7jV/uQuB4fOMsg==
X-Received: by 2002:adf:f80d:0:b0:336:ec3f:fcf5 with SMTP id s13-20020adff80d000000b00336ec3ffcf5mr856094wrp.49.1704823132208;
        Tue, 09 Jan 2024 09:58:52 -0800 (PST)
Received: from macminim1.retailmedia.com ([2a01:e0a:b14:c1f0:617b:c61e:d65f:861e])
        by smtp.googlemail.com with ESMTPSA id q10-20020adffeca000000b003367eae8e18sm2978993wrs.57.2024.01.09.09.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:58:51 -0800 (PST)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Huang Rui <ray.huang@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq/amd-pstate: Adding Zen4 support in introduction
Date: Tue,  9 Jan 2024 18:58:42 +0100
Message-ID: <20240109175844.448006-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd-pstate is implemented on Zen4, adding this architecture in the
introduction.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1f6186475715..9a8d083f6ba5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -14,7 +14,7 @@
  * communicate the performance hints to hardware.
  *
  * AMD P-State is supported on recent AMD Zen base CPU series include some of
- * Zen2 and Zen3 processors. _CPC needs to be present in the ACPI tables of AMD
+ * Zen2, Zen3 and Zen4 processors. _CPC needs to be present in the ACPI tables of AMD
  * P-State supported system. And there are two types of hardware implementations
  * for AMD P-State: 1) Full MSR Solution and 2) Shared Memory Solution.
  * X86_FEATURE_CPPC CPU feature flag is used to distinguish the different types.
-- 
2.43.0


