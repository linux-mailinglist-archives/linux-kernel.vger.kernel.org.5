Return-Path: <linux-kernel+bounces-156810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E58B087C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEBB1F2417D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49A615A4B7;
	Wed, 24 Apr 2024 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BH/bbbvm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D815991B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958974; cv=none; b=DiHRD/pLP/BwYrTtAIEB7T+rH6riOZ108qaELjXS6zGffoAxrLrvSjZXI2N5umaedLQ6XHNc3EablIvk7yR/CUbBBk2pwk+R9UwLKXbIsLkbjuiMV/AYA2nh6nGq6oUEPAGeNykQnjxaDtJibQkKcL8gyscVAZCPc84NYltC4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958974; c=relaxed/simple;
	bh=LjqvDUtZmVAzGUJviYvub5dECgtHavs/7iS97QqYmoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jOZMlOdFizJz/mrOBP5QxpeuqguQ7hU0TpmCTq0M0iww2AtHPhEsFHENSCYupt+20ZcBxIf6UZg8x70y+bsx7b85LZM9mT+0QxbJcoeX2znkvrNFTl1B4Q56ykcU5/6P25ARPPyNWM+S48nhs3xeWgrjQOlNj70ZWpFgfOCvqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BH/bbbvm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b21ed1985so735605e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713958971; x=1714563771; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/p5xEC+QNfkoqFIrbne/L0mxnmolg90yRpPIRqFDoaY=;
        b=BH/bbbvmTAI8em0b7wb4kx6H49tMUbxF53WuSTE82vaViPZ7iKMsi2Rgm+dkyJMC3i
         Ndp1NrIanoY+W/jOd1bBOC9kxd5nXUXnyyeS08rZq5GNg6k52P6vaw+IQzXvFkW4LqMu
         jb/hTBOOF58DSGBYPcVBKgTkHl51NcLPPXCqk1Bj5UVX5HQDRmAUJ0tuc3BKmdUPrnWV
         arJS4EJdF/6NbuMFm0PEGOyeRkE7H59VRE9frmD0EHE468Keelg7lCy3kRwhvekpJUTM
         9/6Nzq14NOU7dahX3g1QZvdXkH+lwBmu7NyrHOGOfE7xozvEobba0Ok11AlwcUOZtGJF
         QKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713958971; x=1714563771;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/p5xEC+QNfkoqFIrbne/L0mxnmolg90yRpPIRqFDoaY=;
        b=JepX542iyOeP1qFrrsKrBx1lLMUk62DCDUh8nJV/XyPbwv/8C1mWeXFOgBv4qbxA4o
         q4vNHFnSIgpdzHgj+ThZ3SPuIFCue8nSXCacZtxip0TrMMvsfHGyJ4kqNwoKiBNCLIzW
         8QHUpp5GOLPuCL3haqWLQgeN6MDmrUG9YKonnoEtFvccfl6vlzo08APdKzKF4DQ0iFRR
         EpXdU15KqTQWly0r7zgRR/kxQkMY/I0nqF4h9QLbmYHgEpnZpupdJYsqsKNoS+rwwuYh
         GawXsIvpcoqHRATYVRIqimW1nm3Pvv5bY1r/QIPhLNKgBvKPFYT097BfH2s2ApYkzoWf
         8W0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+xETjYVhZYM70dCNLdvr3YRj4rYORmJ8dCH5mpF9SCvyo1AsEXVnWezVaOXM6nR71XIOLNq5ckFIDodUvyJ5NFWldTeuwxseNIVwX
X-Gm-Message-State: AOJu0YzaNcpr9MwRinrXbR1Zkp32ZV1P6dL4NKyEcqg9mVgyFQMB7a2+
	jEbJm6Uu8nR/fW3VRjwWMuBMR15fDx3qt1r9902hFB22wyrtass28En+Hgz+Izg=
X-Google-Smtp-Source: AGHT+IEuDDTDOp6nrVspCs313QlQ+BLrwhk8yHmVsdozM7Mct2igZhyLOPAei4HREOaQFZD/RxCk/w==
X-Received: by 2002:a05:600c:468d:b0:418:f307:4b82 with SMTP id p13-20020a05600c468d00b00418f3074b82mr1649916wmo.39.1713958970614;
        Wed, 24 Apr 2024 04:42:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b00418f7605249sm21455887wmq.24.2024.04.24.04.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:42:50 -0700 (PDT)
Date: Wed, 24 Apr 2024 14:42:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spmi: pmic-arb: Fix of_irq_get_byname() error checking
Message-ID: <53c31752-c8a2-4098-837e-2f84f03c8748@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are two bugs in this code:
1)  The "irq" variable needs to be signed for the error handling to
    work.
2) The of_irq_get_byname() also returns zero on error so change the
   comparison from < 0 to <= 0.

Fixes: 932282f154ac ("spmi: pmic-arb: Register controller for bus instead of arbiter")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spmi/spmi-pmic-arb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 0a17ff02c827..791cdc160c51 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1672,7 +1672,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 	void __iomem *intr;
 	void __iomem *cnfg;
 	int index, ret;
-	u32 irq;
+	int irq;
 
 	ctrl = devm_spmi_controller_alloc(dev, sizeof(*bus));
 	if (IS_ERR(ctrl))
@@ -1721,8 +1721,8 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 		return PTR_ERR(intr);
 
 	irq = of_irq_get_byname(node, "periph_irq");
-	if (irq < 0)
-		return irq;
+	if (irq <= 0)
+		return irq ?: -ENXIO;
 
 	bus->pmic_arb = pmic_arb;
 	bus->intr = intr;
-- 
2.43.0


