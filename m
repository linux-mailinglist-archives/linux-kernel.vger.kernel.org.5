Return-Path: <linux-kernel+bounces-12283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FA881F250
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A6E1F20EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A731482C8;
	Wed, 27 Dec 2023 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="in8ZK8Fh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DC481BA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso2361573a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703715349; x=1704320149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QF50W+U9K2q+OXtEuQkW7nHtEV7kil/7qyeX3qRNKd4=;
        b=in8ZK8Fhm7D0rqT4uiyxXABcaJMzFIHF3TTEw13+o30Y2B3LoBxbT820g+DzoncXK7
         /HaH4TEVVs6DIg/HVq3uHPxGHiMRtk1cGyd8KpHK867gaZHZZ8DvMF52Xay0w8pYLtuK
         1WpHd4bsf+kRYtr1wOuU5WMcx1AHzLu2DBQnNBctR1jCclnff1bdu4pomlwQq/w8FUQI
         o5H+CdZMsQ/oPBw2YThjRR2g6lL1QvR7YJ+7M/bmn97WgQJYsKHFkjiX5CNh4U1lFoae
         PHxX78CmFJ1LKC6XwJc8LOsjbNnz6tAcG6BYnX0oup+18BF4OurXaszewNKYJfbawvhV
         wS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715349; x=1704320149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QF50W+U9K2q+OXtEuQkW7nHtEV7kil/7qyeX3qRNKd4=;
        b=Ohd6GZ7yzsbR6jiIYTa25nuxvJxKyWtAIBpyPGBFCt8aTEkr362bwf6dYNPPY4cr6Q
         hbVl8dr+3chbwHn5uuzS/BSWrU4iT8VJzH395BAWRAXG4C/bl7YFc7PzAjZy046ODPLL
         DjePrbv+6k24hSoIQ/ZK8rAxB+E8AQ171DSbc4L/zCUnwktN/zDDcQaEgHET7q2eg+RU
         +GebGZUUJLpv1FwAKtmPbQM8ORMsMtnS/GgOlZNaFSH65YbcwzP/WoA6Tnk71WzhTRvh
         W2/YpSHDx2kLXWImnoXY3J5sfod61PN5co6pXgnN+YtYGXpq1sgbfhSlKs1T2PfSLAHB
         Cb3w==
X-Gm-Message-State: AOJu0YyPS5O4SGLg9NEM4SVkjOFCYRSe2HbrWNkrawDrQMvFBepdK2bx
	JjqcV++BcLR4iZvio5iKbc3aFCnSLiaUxYJe2WRWpxbWdik=
X-Google-Smtp-Source: AGHT+IE8u8NcolYC9CAgacNBPSEa/rRVqoJKk6Yds8s8XyKxpSPEgcmBrYMh794UszMqjYcJGZcBoA==
X-Received: by 2002:a17:906:768d:b0:a23:713d:57c0 with SMTP id o13-20020a170906768d00b00a23713d57c0mr1984365ejm.234.1703715349284;
        Wed, 27 Dec 2023 14:15:49 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id vw17-20020a170907059100b00a26f3d6062csm2821501ejb.50.2023.12.27.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:15:49 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 23:15:30 +0100
Subject: [PATCH 1/2] firmware/psci: Set
 pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-psci_fw_sus-v1-1-6910add70bf3@linaro.org>
References: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
In-Reply-To: <20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org>
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703715346; l=1200;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BOcN6TOkFupHjjux6yybqx6vqjcZtP/Ge6E7xFQ3Z1Y=;
 b=VqjR+6LtgrQAcFZLsGBSO7LUmQI+i23yymh1HGczYfwmvtx9rhxhsZTc5WKsyY/cald/Wznu4
 dssyitvO+fmAE6L1tdpTAk5ZzwxVPqDLF3ouBmxVNbIdfCWRCKgI9pA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some device drivers are curious to know whether "the firmware" (which is
often assumed to be ACPI) takes care of suspending or resuming the
platform. Set the flag that reports this behavior if SYSTEM_SUSPEND is
implemented.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/firmware/psci/psci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d9629ff87861..1bcb752977b1 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -505,12 +505,22 @@ static int psci_system_suspend(unsigned long unused)
 
 static int psci_system_suspend_enter(suspend_state_t state)
 {
+	pm_set_resume_via_firmware();
+
 	return cpu_suspend(0, psci_system_suspend);
 }
 
+static int psci_system_suspend_begin(suspend_state_t state)
+{
+	pm_set_suspend_via_firmware();
+
+	return 0;
+}
+
 static const struct platform_suspend_ops psci_suspend_ops = {
 	.valid          = suspend_valid_only_mem,
 	.enter          = psci_system_suspend_enter,
+	.begin          = psci_system_suspend_begin,
 };
 
 static void __init psci_init_system_reset2(void)

-- 
2.43.0


