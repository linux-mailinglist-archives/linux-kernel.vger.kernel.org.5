Return-Path: <linux-kernel+bounces-12082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7C781EFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4501C21808
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF67A45965;
	Wed, 27 Dec 2023 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SAvW12Uj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158745956
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e77a2805fso2199536e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703690496; x=1704295296; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCTlaMTC6ywPq5vAUIrnIqVxtGJdBQu5ZEYw3o8dV44=;
        b=SAvW12UjadP4Jtx3TP4b4E6kR5qd039f/Rdi/ohC1L28pv38KAAxQIJpMOrdAc2zI6
         guQ/Jr9OEnN8VFXxpjoth1628MdxOUv9HRCxbyNWcgkqrV/bI7bveFeZ5CXCa5A3v0JV
         Cte2a22EbHYWntG8Npjh+WMtDYYZoau/qGRiJNUL3OVdkN28GO/oZPdBrCz6hJsqIspW
         zr4PiO8vQcU9a1lWZeu46kvxGUWktojSuvDViI2tpORQN1SWDQBb0qcf6acjppvh0fkt
         ppSIyAbKHZ2b4o/bDcah+NIScxgLdvxmx4yRNVrYCbAOWKtrssaLlaqCs+zUiU12web3
         EJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703690496; x=1704295296;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCTlaMTC6ywPq5vAUIrnIqVxtGJdBQu5ZEYw3o8dV44=;
        b=vqOf3O/vRiVKevtTdaQsoLjt522fBcA3rsn1wLl3swenGcO2c5Pjg/LH193qwg3Bii
         IdM+10W9ikIi6kdNCdxP3+5Z0P46WAymh09r0zc9Vr4FkyuEwcs4H/lsDWUrMBiw1D0o
         c/8L60MtW234svIi5bT2kN285lQZ57HZmRJf7oWQwDfMSdhOXUrcqs6VJwkQYTKU4Oc2
         owYHjo5Lj21w+qshXRoJdaJRED6zg6TCey5Yb6SmN2bW2WFncwaa0uQPWbt4c7+219AY
         e06nQRxkcX8Ht15EZIyMmvKAy9diE3tqxNl26vUcYk/BceLUJF5ioozG7519QzOBu8uv
         yDgg==
X-Gm-Message-State: AOJu0YwVfEGHMAmrK8byWPjaZ+UM3PSoXCRc94HujDiO+ZARHD/JDD3j
	f14L2G4WLjszVscwUO5WQcwkftPjBmU4Vw==
X-Google-Smtp-Source: AGHT+IFdd1QhiPuQjlqF75Iukcq0/Hgg8WvxFxPm1Kf7M+zTLkMWtqVmTb9QfIGuiphU+bY3qds3vQ==
X-Received: by 2002:a05:6512:3444:b0:50e:79a5:5462 with SMTP id j4-20020a056512344400b0050e79a55462mr1091958lfr.199.1703690489681;
        Wed, 27 Dec 2023 07:21:29 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id i15-20020a05640200cf00b0055404e08589sm8686015edu.85.2023.12.27.07.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 07:21:29 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 16:21:24 +0100
Subject: [PATCH] pmdomain: core: Move the unused cleanup to a _sync
 initcall
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-pmdomain_sync_cleanup-v1-1-5f36769d538b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPNAjGUC/x2NQQqDMBAAvyJ7bsAkBaFfKUXWzVoX4iYkVVrEv
 zd4nDnMHFC5CFd4dAcU3qVK0gb21gEtqG82EhqD6523zg3mk7KQyWtIK4qO9ac0UmTULRvkwYf
 +br1nglaYsLKZCiotraFbjE3mwrN8r+XzdZ5/bny/9oIAAAA=
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703690488; l=993;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UYTPDXSMwDDqu5IXgCZ/QHkjN8Hb0RJgrRT9Yhl3fv0=;
 b=mGKEdP6m2Uc4DcAcbnyehLbza9hmdquGTiwedUuAj4jTyVcMOnntnhEQHlsF726/wEs7AwxHt
 6e4I2PclHqMCfu1lAs+L+KiMCqnI0FqHbZrOnCpDQ9e1EktsvHlJr8W
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The unused clock cleanup uses the _sync initcall to give all users at
earlier initcalls time to probe. Do the same to avoid leaving some PDs
dangling at "on" (which actually happened on qcom!).

Fixes: 2fe71dcdfd10 ("PM / domains: Add late_initcall to disable unused PM domains")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pmdomain/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a1f6cba3ae6c..18e232b5ed53 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1109,7 +1109,7 @@ static int __init genpd_power_off_unused(void)
 
 	return 0;
 }
-late_initcall(genpd_power_off_unused);
+late_initcall_sync(genpd_power_off_unused);
 
 #ifdef CONFIG_PM_SLEEP
 

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231227-topic-pmdomain_sync_cleanup-ae73d04133ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


