Return-Path: <linux-kernel+bounces-72637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0085B68D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A352F28A3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94C75FDDB;
	Tue, 20 Feb 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L++1ZMrc"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DD5D48B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419751; cv=none; b=m6RTR6TD4L+erTeYsyJ4Fphd4qP5VzlTdjrM44R7Fv2OSNhQceVGSXlbMNV8rIwmsIGgQCItl7CewdsMjrwgCqq1OFjsuoxb5hxlPk5QiIfPZand4y+7x5LXB5dd9OaUd72CcvQ6j9oHOYnMxsVVouHYkoFOwalKXAv33Q+Mr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419751; c=relaxed/simple;
	bh=KkdvrdrLCm8OQrPK+czFlLaYo1JrtJ3rNvWITsPyWBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BxFdRJydnxYGff/+SfvrJ9OGKQKxzPsb44p+d4lrehJdnS96OUBNr77x6fBTBxqHaOHyY4BJq1m0iP5Y3notCFSSNZY9Vr0XlNiF32kvDjIg5Riw1Dqx7S+uC5f0kvEFZB+piX2gL8zyt60/IS/MQZWt82PUXKO+DkVzNld0cBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L++1ZMrc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564d780d55fso196805a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708419747; x=1709024547; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GySeikmcOETTtUkW23ZAy9xSze7pMX1co+DBAoFFtok=;
        b=L++1ZMrcA87+UCoRJwNqCkJS7F7NjPmFQG4LOmyo8au3KzMhVERSaypbb1x/ycszjU
         Y1Set/ojJWLeEbT7cW+MzEyvt2hWL4BW3b1RELOXZykZKcU2TY0CzsGzwnumjofquvgU
         LROp3az+8alvECAWpT3ADV19lapVSbGPwKaoRVwFW7dSnxOJH+RcD+fGMPpF4ckhDq7k
         ehjqGKaygEMJwfNw/4g8bdS5ANgdCRSqS4mAT7lMMaVHL2m1FQyNxQxK0SPH4hQRS1Gc
         w8XbzHEQcDaGPGIsp6/nA44jFi/5N5Rq4tC7Zcd7IXuxbsn+rY7HKp++AGx39pyXpTR6
         DPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419747; x=1709024547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GySeikmcOETTtUkW23ZAy9xSze7pMX1co+DBAoFFtok=;
        b=a6dy264GumI+y2mh+7e9lx2NmLmX2dDClK8LIIpt9S+oAtdCYUCmpXPRa6a/cwcbmO
         UB5b4SxPIhwC2HQakFo2CLfcis5TUv+cx5yOjW2gVw4GCB2jQmy9WmCgupF5fDqjK0dk
         7M7HgcsRYwmNXKVJ0u96/2CKEZNpKKktuc2vb1kvv1zk/g8D0BLkbbZyMijyttsfzlsD
         EjeyUVeySxuxM/8hVdEEsG7sYj+XEfmT1dW8UiKRt/A0qFCONCySXEJIHbFqAdgm+pV1
         Fp1+T4Pv6w1F9bSVmjfICNwrYdVMFl1nSJlTG5YQdpDZPHxqGzOyZLum0DUGDP3arXq8
         sHEw==
X-Forwarded-Encrypted: i=1; AJvYcCVOzO1kLnE/yW8V0jtuPuUzwZW0ld4JuXt4n+Cl4T6WFrpTTR+bRBtuRD662yQ/ApyhQgGFmatV+WMDZG0guhVQC7lyxKPLvLASeGFu
X-Gm-Message-State: AOJu0YwGhcPoPTeQgvtHaUcwrAIFnFYs1VAoGzJ51iF/+n3AjApODJu+
	zmeOr5tfdAdoGLiok30nw7B5E7k5i0LxThfRzTv9xINpujdL21GtaH5U51d/kig=
X-Google-Smtp-Source: AGHT+IGRNgfAmknQQNAQTmkYMX7dHuxxFdKG4tPqJyx65Xsqquei5GLgk/bTHagMZc1sLtAZLPPT+g==
X-Received: by 2002:a17:906:594b:b0:a3e:9df6:7f0a with SMTP id g11-20020a170906594b00b00a3e9df67f0amr3294880ejr.68.1708419746720;
        Tue, 20 Feb 2024 01:02:26 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id wb8-20020a170907d50800b00a3e9c4fa24esm1757200ejc.96.2024.02.20.01.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:02:26 -0800 (PST)
Date: Tue, 20 Feb 2024 12:02:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] power: reset: xgene-reboot: Fix a NULL vs IS_ERR() test
Message-ID: <fe1b90d0-7234-4e03-accc-69a119f6a7eb@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_platform_ioremap_resource() function returns error points.  It
never returns NULL.  Update the check accordingly.

Fixes: 7ddfd33c6ee5 ("power: reset: xgene-reboot: Use devm_platform_ioremap_resource() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/power/reset/xgene-reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/xgene-reboot.c b/drivers/power/reset/xgene-reboot.c
index 867162dfe7ea..b5eee19bac42 100644
--- a/drivers/power/reset/xgene-reboot.c
+++ b/drivers/power/reset/xgene-reboot.c
@@ -51,9 +51,9 @@ static int xgene_reboot_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ctx->csr = devm_platform_ioremap_resource(pdev, 0);
-	if (!ctx->csr) {
+	if (IS_ERR(ctx->csr)) {
 		dev_err(dev, "can not map resource\n");
-		return -ENODEV;
+		return PTR_ERR(ctx->csr);
 	}
 
 	if (of_property_read_u32(dev->of_node, "mask", &ctx->mask))
-- 
2.43.0


