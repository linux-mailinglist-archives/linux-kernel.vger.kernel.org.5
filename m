Return-Path: <linux-kernel+bounces-141956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11508A257C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1CD2866B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302D241E2;
	Fri, 12 Apr 2024 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnBS76uQ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325D2230F;
	Fri, 12 Apr 2024 05:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898709; cv=none; b=iaBmLkOJpRVe4W0t0d7jqxRi/Q5RLR7wEj7JFYuxzXz9XRaIM4eVeUU4yeVUdOW4U0Hs+dZo2lfZu0AN/Vxx61veHW+yKdEYDwA3Vk2adsXGWK45byVCGZm3AjEJjlmWtE3NtPukIKENKRusj7Ev25y9JC1Gmg6ZGfmxDhe5oXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898709; c=relaxed/simple;
	bh=m8UmET64JFRSVNpBc2wrAPbmY40xINLq85Nvqqp+9Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip2ufXRfEjUC2OMf+6uheArhfrE2lvcc3Zz8zst5CMGFbP/qalTIPVwqfdjLdII1rpprFeQ+J/D+jFNGRXoSOovC6VGMRLbsS1jD4fMoEbwXC9VDQY9pwOGogGasHLCCY1cxmWf9y715Yu1Asji89ypRMwEIm/oMl08Bjdp8V1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnBS76uQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso553007b3a.0;
        Thu, 11 Apr 2024 22:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712898707; x=1713503507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7qId9+jfJUCqQ/SkIwlhCGmFKyY/JbOZZwyRJiXokA=;
        b=jnBS76uQEPptrNNIuu1sp5Bib9/MTmwQVPv8iz2rJLZjuPq1NgGks1eXRqvLBc3S8D
         OPlZR/8yHdU9Qn49Kp3wEn6OTORHocT8evfTOCpL2uD+s+XBxOoajjUzeklZWXzBmwv+
         mkmBSH4pG5OPOMwJc0NK9e6IblZIO3KitmauUNWhwtEuhkm/TymKTLhfhQds5kdMxLWn
         okzqgbJIiHZPhCc6bfDZa7hRoaIWgzxIqY38Wbwi8Nznbp/nVw4CZNM3SKAovbAIMBCa
         HX+tCay5gWqAPmNtcXHIoiQZhdOajf6isGya/5BDF6hAh0PN4O0OUGKFBYHNzGVDplPc
         9HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712898707; x=1713503507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7qId9+jfJUCqQ/SkIwlhCGmFKyY/JbOZZwyRJiXokA=;
        b=DVFkauOaIB9dYvGHbQp7bs9xvknbWbdYwsBcSNmZ+cPx8e699tSqR/Z9p+vtu6JCQR
         q8R9/3m03WPrwPQAbllf7hq+WJ65Y0Gw2EiQCLpjHU19inIffwFqmOXI0F+iBvIEsHnd
         P2gCbbf98EawyNOa78X7crbM0/psYuVw+17KdgjF10aVvsjLnuPx1B4cpYeYcJMEBN/D
         aD/rddCX5k915MWyXZiaIuaf/R92EWyr7ZaGxbr/GYEuRX+x3ppgdEwMmFYHFjBI/4P2
         tL2+kGfz1xAu5tRn+6qb0IPsfUq+CQ6MtxTjkbewQ7xNJJsLVmhBBEfkDy/R5ANKjpq9
         ODUA==
X-Forwarded-Encrypted: i=1; AJvYcCWaH1SIJWyVjJlORi81Jzp3VdksWRYcOEaU/zVFvP9p94svc9hZO+uaO7M1K0Ew9K9psSAES0U32EBhKnJ7SQ8iHhVlHt1CfzzKXDIV
X-Gm-Message-State: AOJu0YwcDZxkoxmzUHBJHyIAtn3aVqIkV8j87MegyGRDOkv+OBMFF+VF
	xaf+Bc4DCZ3WkYNCn0yhWbUkOcOQRKpc9XmSLcLIH3tqHYmMGfjtGFFEHmt7
X-Google-Smtp-Source: AGHT+IEjzTZw44VqYWO0ZLqMwP+QTBp9hJHhPOoxfo0lSDGaTCAoe7WctbVTSCpKYyglPWJsMEiMCA==
X-Received: by 2002:a05:6a21:6da4:b0:1a7:2e17:efd3 with SMTP id wl36-20020a056a216da400b001a72e17efd3mr2297800pzb.5.1712898707012;
        Thu, 11 Apr 2024 22:11:47 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.200])
        by smtp.gmail.com with ESMTPSA id fh16-20020a17090b035000b002a53b9cf356sm3734902pjb.0.2024.04.11.22.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 22:11:46 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Yang <mmyangfl@gmail.com>
Subject: [PATCH v9 04/13] clk: hisilicon: Remove hisi_crg_funcs
Date: Fri, 12 Apr 2024 13:10:33 +0800
Message-ID: <20240412051041.90376-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412051041.90376-2-mmyangfl@gmail.com>
References: <20240412051041.90376-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After refactor, no one use hisi_crg_funcs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index bd8e76b1f6d7..db2324309d41 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -11,15 +11,9 @@
 struct hisi_clock_data;
 struct hisi_reset_controller;
 
-struct hisi_crg_funcs {
-	struct hisi_clock_data*	(*register_clks)(struct platform_device *pdev);
-	void (*unregister_clks)(struct platform_device *pdev);
-};
-
 struct hisi_crg_dev {
 	struct hisi_clock_data *clk_data;
 	struct hisi_reset_controller *rstc;
-	const struct hisi_crg_funcs *funcs;
 };
 
 /* helper functions for platform driver */
-- 
2.43.0


