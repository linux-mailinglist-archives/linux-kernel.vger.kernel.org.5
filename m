Return-Path: <linux-kernel+bounces-87541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28286D5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3AA28E54B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85611527AA;
	Thu, 29 Feb 2024 20:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5XNv89M"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607A6145675
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240169; cv=none; b=BGoe+x0N6AtciOC5exkRk8unl7MlinQGF42nfgLgNkGzlyZcNdFq8lV0ZlPgq/w+WUE/ERB1FeQ8L3dmk5tykJHeH5y/K1Azi6IevmrRkR6fSFVJt6RQcRQ7fwnmQfXFB5q5rM0D7EsGzdBAMPvYQhdIHNZfd6dsHN73oyS/bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240169; c=relaxed/simple;
	bh=Am0NKmlCwgLy7Njo99K+o5i4CrEnaQkPIJSAd0GcvZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqDaCv+kUmxWSuxa0lPyzmzXWEXwDpvPw5AwP01hVjatQdR4BvCVvtCAkX0ZEgFv/vCGPWJ5uQHiIYtVm8f/y90Q7yuFL0FsVCXNhFlKJ02mzApn7nBVeUcgenYkfKVtWl9xrrUJ5tYK2ZupOb1Mx8JKKmXYOsq21uy7VVPJ1Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p5XNv89M; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-364f791a428so7239975ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709240165; x=1709844965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D+lwpw4B4CqzaxbOzMn85Ig/zR5F9N9xKtP1WaY0I4=;
        b=p5XNv89Mx3GinPIQt7BOa5mzCvf/PZDTGIBL5xIWL8fCGRJ5YGPK1rvoFth/QbJ3gD
         zGPZRSN+xiGDhiGCUotcbnxzs0fqH4qgxgjOY4aO8nfH5HYSTDuUTwC/apU1QoVcy4CC
         rCMJa2gYWvL6XKKCItvU8a2kB5rfioMzBb9zjs+3jXspSAyXnU8sy7de2jDM94OfkA11
         a56iRAYvu0c69qRfZRgWIwDLaPKi/d4lFPrI9pDkFW3fjMujDqjBajQzBUEx4lLFc9fL
         kcK5EOSHHr5WxKm7qUgiHg0lFjniHUtBe9bbPNxdN6eep7LCssmU1YYl1c+PzrNU8cv3
         pp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240165; x=1709844965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D+lwpw4B4CqzaxbOzMn85Ig/zR5F9N9xKtP1WaY0I4=;
        b=G10WbXZHcBib8+Ts7GCLgCxLBWScy+7t1qZazMHSusMkfztMZbkyPGSO0vLBDrQVXQ
         vmxMUNtk1xIMypLwH8MAgk1rRI6mVhC+sNkrH29uyvAQ8sBG4XKPVnGaavfl6fyLvP6n
         X4oeuSQbq2CmJV0VlyVp1vGsXfVHepqC9nYp74OUoweakQ8kvM38HCn5TbeeX2bZLhUp
         RI4CPKX0c0psny50+svLKN9uWL28SQo41UdiUzPftI8ytAQHuhJVSXft0zOlWI2tBFeZ
         K4uMvIrq4w9Nbj9fQqtMOsuQ8y3lbG9nmiTWlZ/dW9Xp5ulMF4oNg17yOVHCtlhp5sgV
         ABiw==
X-Forwarded-Encrypted: i=1; AJvYcCXzm2stm0WNSJ/5dpxwd7KXqhuXbHuqtGaHlLDfA3ReSU/Z6hFnUAaYAeeJEwaMohbMPF0oAvfYKHfeovi9l8K/tPhMBb5meYlzZsFn
X-Gm-Message-State: AOJu0Yweo4sNZ+lNlnMpBIPynRZMJK9UsgflwmxxNs3Jn644XNhnE6HC
	X0uYaEq4ZX7YIUjCTmc1Z4S816Jc1VpxWfAiVidDDcnDDesF9kXvXniciONK8jE=
X-Google-Smtp-Source: AGHT+IGcOfVrDqhNCWn1fNLEGXylxBZpA2oid/ypDYM6J5i+Mj7J0q56fj66lxK0j1ZvfW//1Sz22w==
X-Received: by 2002:a05:6e02:b29:b0:365:4e45:658f with SMTP id e9-20020a056e020b2900b003654e45658fmr193247ilu.22.1709240165712;
        Thu, 29 Feb 2024 12:56:05 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id h14-20020a056e020d4e00b003658fbcf55dsm521551ilj.72.2024.02.29.12.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:56:05 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] net: ipa: pass a platform device to ipa_smp2p_irq_init()
Date: Thu, 29 Feb 2024 14:55:52 -0600
Message-Id: <20240229205554.86762-6-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240229205554.86762-1-elder@linaro.org>
References: <20240229205554.86762-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using the platform device pointer field in the IPA
pointer, pass a platform device pointer to ipa_smp2p_irq_init().
Use that pointer throughout that function (without assuming it's
the same as the IPA platform device pointer).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_smp2p.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 5620dc271fac3..8c4497dfe5afd 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/types.h>
-#include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/panic_notifier.h>
@@ -179,14 +179,15 @@ static irqreturn_t ipa_smp2p_modem_setup_ready_isr(int irq, void *dev_id)
 }
 
 /* Initialize SMP2P interrupts */
-static int ipa_smp2p_irq_init(struct ipa_smp2p *smp2p, const char *name,
-			      irq_handler_t handler)
+static int ipa_smp2p_irq_init(struct ipa_smp2p *smp2p,
+			      struct platform_device *pdev,
+			      const char *name, irq_handler_t handler)
 {
-	struct device *dev = &smp2p->ipa->pdev->dev;
+	struct device *dev = &pdev->dev;
 	unsigned int irq;
 	int ret;
 
-	ret = platform_get_irq_byname(smp2p->ipa->pdev, name);
+	ret = platform_get_irq_byname(pdev, name);
 	if (ret <= 0)
 		return ret ? : -EINVAL;
 	irq = ret;
@@ -261,7 +262,7 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 	/* We have enough information saved to handle notifications */
 	ipa->smp2p = smp2p;
 
-	ret = ipa_smp2p_irq_init(smp2p, "ipa-clock-query",
+	ret = ipa_smp2p_irq_init(smp2p, smp2p->ipa->pdev, "ipa-clock-query",
 				 ipa_smp2p_modem_clk_query_isr);
 	if (ret < 0)
 		goto err_null_smp2p;
@@ -273,7 +274,8 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 
 	if (modem_init) {
 		/* Result will be non-zero (negative for error) */
-		ret = ipa_smp2p_irq_init(smp2p, "ipa-setup-ready",
+		ret = ipa_smp2p_irq_init(smp2p, smp2p->ipa->pdev,
+					 "ipa-setup-ready",
 					 ipa_smp2p_modem_setup_ready_isr);
 		if (ret < 0)
 			goto err_notifier_unregister;
-- 
2.40.1


