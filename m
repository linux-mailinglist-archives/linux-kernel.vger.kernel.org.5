Return-Path: <linux-kernel+bounces-85125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7655586B0B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D788AB27354
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0F14F979;
	Wed, 28 Feb 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="O/YgCYQD"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772014DFD6;
	Wed, 28 Feb 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127998; cv=none; b=eNBYffaLUvDhNfOfUwA+IPw5/g07D61AQ219fi/2arZwIEHsvxNXGUbPHKoqtMV56cfFRFE4rxQpYaH6Axh1qN8h4PZZCJFbNBa5GgwFDM6IKypRg+gZwTEVFoP/19L3XtL9kKGsQc2aGRsBoSz8bn6Q6hj5xJ6aHoaagjSW9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127998; c=relaxed/simple;
	bh=5ClQvTqbw9dWroMtzRxVjJD1S/jKRAq+aYt+MzEpEoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fZCDjx2IzDYmV7kPlnV4mapXgyC55Mb8YA8unB86fEQUOCFNqFpQWVDYZ02IeTl8n6fxMbNy+ikcE3Yj3Piw7NNeEU4moVyP1na+VmDRUGbcyKmcUIxZNNC5fGkpCaW01lrj+rFKTcDFH7g8F0+OS8+hvZlK5r75a2HwVvZXqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=O/YgCYQD; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e4b03f0903so754570a34.3;
        Wed, 28 Feb 2024 05:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709127995; x=1709732795;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T00DVPV0QDu6L2fFl0PLla69pcFGEB7rCw/GF1ZnL7w=;
        b=JBicfe4HPZGCDHaIAWvbN7cYRG1Fdz4u2kOxnhpHfUUQSOFSkIeorAP48poNNdu7u5
         MxGgSi0LFdYL7HfQ+YKK0+GVN/yFJF6bUNOqdnXHvb91MEhyfvekmng52SI03AbM7zut
         ZyPXG3JwtoYHW1+v9i/RGFmqVD2V5GH6lXmPvKoW/eUKo0KxdGFF73zfyXaNAiNDZI0e
         X2PoXFijqHy34HXN2dGlCngOw00N275foaicISkmCsxmFHE/ImO6kft33PRGM4Am7Bdx
         CklKcy9fyDuSsB/s+FtzX/8CCW49Tr7EeeyOkEekK57+rLba1ILzH5HKtbyKQ5giRjjm
         I4eg==
X-Forwarded-Encrypted: i=1; AJvYcCXlvUm7kimX9qCvydwEidXa8qZO7B4zRYUgx3+sjmT+sTQyN206Iveg9+1mnWOl3x9KhHWkzInZOJB8HRFZHcOSWlcmovzqz0qoWXIqpiIYUZozGiOfkK0vvIW8SbaJI7DguVlHVpc=
X-Gm-Message-State: AOJu0YzxbW7JfbPyeMSQVg9lrFk1SdhhxeGNeOsGv39orKr8o+A8ELQF
	24xu/Vgl+kzueoeBRBtewC8AI8pTQS5nPgINHXGSR0rEiYfr0ikCEdxfphhBDWP8bw==
X-Google-Smtp-Source: AGHT+IFQrJSaXarzg2sYFI/mJxr1sNz23Vi7MjRP4ReJT24KWmrBTE9rLgMG064q1zb5IiWVCi7EiA==
X-Received: by 2002:a05:6830:1da1:b0:6e4:2c63:66d with SMTP id z1-20020a0568301da100b006e42c63066dmr14153009oti.27.1709127995222;
        Wed, 28 Feb 2024 05:46:35 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m24-20020a635818000000b005dc9ab425c2sm7675389pgb.35.2024.02.28.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:46:34 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709127992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T00DVPV0QDu6L2fFl0PLla69pcFGEB7rCw/GF1ZnL7w=;
	b=O/YgCYQDhzPZ/UGlnWaSH6IBlcN5LqqTVGZhcyL57h+ENricyGdnXwXxLpLmK+UlZHnBab
	r4bEYvO0Bhuq83RlVVszlhRSdAVgu6KrbHwQHhRc2UhabLxtzPIvz8+JzzNd2DBgX2XNmh
	CnmgLR5YIALtgPSpbth7tb4BKEvbsH1//NlNXDDDd9Duee47hHbMvfBTRi1YAEcsCzieg8
	VP8oRG5GksucpI8OUSzV4xHXSzIk+3VIZFMiZ0L2m1ObHGC3HMu1Iq0ertPVcBk/6iwnNW
	wfhN2srJg5MsdrtIbmyLaMUniqHTGQF/JLEplyU/R/Q3tSZ6ikeahVSgoLyjUA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Wed, 28 Feb 2024 10:46:28 -0300
Subject: [PATCH] power: supply: move power_supply_attr_group into #ifdef
 block
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-device_cleanup-power-v1-1-52c0321c48e1@marliere.net>
X-B4-Tracking: v=1; b=H4sIADM532UC/x2MWwqAIBAArxL7nVBLYHSViDBdayFMVnpAePekz
 4GZeSGRMCUYqheELk58hAJtXYHdTFhJsSsM2GDXIPbKFcnSbHcy4YwqHjeJQme9MXrRHhcoaRT
 y/Pzbccr5A9PBCnxmAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5ClQvTqbw9dWroMtzRxVjJD1S/jKRAq+aYt+MzEpEoA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl3zk0PGu+fqVQdG3FmeC1+n1bpwoDK9QHapBf2
 qsIVmwVFKOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZd85NAAKCRDJC4p8Y4ZY
 piZgD/4qFM8l4BNkjHTpBgOGWwXMnCoNlfYp/T8vfxZ9NyECILlWfT6OGDgN+lY7Qc3KpYG55uj
 Jdz/JM8WS/YSeXz5OgbXLRxj+forZNZfvLMfE2OxqO908rOYrocSrtIs3hwa+eC6by7XVJW8kFb
 TKT//i0NB0X/F3PpObEYvdhE5OQGptyt02Y3XxpSXgc/CFnlqVaz58L+jlmh7dqBTPg2faVWw+o
 MxPdxSiSR96SKo00THkOPOgYzMNj+RCsNj2jv8+ZI6+LX/d1d0tqr+L5Bss4lb+RfsKAhssN9U7
 WGjUpEJTZocvt+kIqKNU/+IbDPVJHNernq0zpmiCsbjFm/xuCDdbLydGwaD5GM3Uyxvlcdeebqb
 XQrrXAeBNOKBwK06QUaFB9QSMNTqO7cLw/ED87Uc0huSun0FkeOBqwoT0XPaP5y30bjQyYP6LvL
 xE0JCaDJk9HMCm7TBcS9pcSgKpNMbKnRF7iu8uQ97y5NDnzWlgxpUBr+DCRh9ofyK4eIRs5iyxx
 J1fqDje9FhZehx1eSzatIE9DPR2AWlxunkGI586/6TRjSPEd4mCmc+HFBwHS2+RvLFRhTWVe+Hi
 qAEXmf/I/F9UKGjUJN1zvQdBCfw2jJfvzttisoV1ER33MezsmvfrYt6qu9wkm96tmqqpwzLjmub
 ThURccE9y4tvxyQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

When building with CONFIG_SYSFS=n, the build error below is triggered:

ld: drivers/power/supply/power_supply_core.o:(.data+0x0): undefined
reference to `power_supply_attr_group'

The problem is that power_supply_attr_group is needed in
power_supply_core.c but defined in power_supply_sysfs.c, which is only
targeted with CONFIG_SYSFS=y. Therefore, move the extern declaration into
the #ifdef block that checks for CONFIG_SYSFS, and define an empty static
const struct otherwise. This is safe because the macro __ATRIBUTE_GROUPS in
power_supply_core.c will expand into an empty attribute_group array.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/all/20240227214916.GA3699076@dev-arch.thelio-3990X/
Fixes: 7b46b60944d7 ("power: supply: core: constify the struct device_type usage")
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
This patch depends on [1].
[1]: 20240227-fix-power_supply_init_attrs-stub-v1-1-43365e68d4b3@kernel.org
---
 drivers/power/supply/power_supply.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 7d05756398b9..06749a534db4 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -13,16 +13,16 @@ struct device;
 struct device_type;
 struct power_supply;
 
-extern const struct attribute_group power_supply_attr_group;
-
 #ifdef CONFIG_SYSFS
 
 extern void power_supply_init_attrs(void);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
+extern const struct attribute_group power_supply_attr_group;
 
 #else
 
 static inline void power_supply_init_attrs(void) {}
+static const struct attribute_group power_supply_attr_group;
 #define power_supply_uevent NULL
 
 #endif /* CONFIG_SYSFS */

---
base-commit: 837af6b0cdb2b8df56d2df35db0444cfa1ea47c2
change-id: 20240228-device_cleanup-power-2dcfaa7b7f2b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


