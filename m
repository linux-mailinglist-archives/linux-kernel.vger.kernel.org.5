Return-Path: <linux-kernel+bounces-51239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70384882F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D236285097
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD385FF05;
	Sat,  3 Feb 2024 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="Gzl+rbpt"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86A5FDCD
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706984688; cv=none; b=eIBFGUJfjTgCCuteK49dI5OpnexCrUXWyOhxw7gIToD5/gy/WFVJW77y1YKo0RUklgVxyTLX7hsuXPssLxRCF+hKREVysfeiDdr3fOlhcRRmAYR04Vef4b65W8Qa/ZK/KyJXPFWNAcx26elD8/3R3qGN5IjfJ7zadPpn+GraIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706984688; c=relaxed/simple;
	bh=Jb2CPAEe0Zv9sdkMFnExsmwVmtr4EceLYp23eTMTLN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usgbFgKdnPiwTn743n0+6ceCZwZLMm1SXe2Ym1IaJcLePH8AX9/ilaFTiaZDgIFY08wZ4XfhRDEevaqIv+rVejyEenCRilIgz2pobtIrP+6uSEXRkdO90g+/Evps0R5ITLH8vZI71OtXHJQPc1qkLBZ2G4nkBXZ0AP9szQBuu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=Gzl+rbpt reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6daf694b439so2311607b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 10:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706984686; x=1707589486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wvmygpMXKch9KjcDbs26g5cam8cyiZFx8cVfTokl0Q=;
        b=e7UPHrGnUVv9rV0dqSY21VPGcz0nsKecpiqFrPvT+2FdNVcM3ctzeUMjheHV5WowfF
         +VFyxnnmKdNbjrfIEDGRsCkfP5/s+EviiEPH+cBML3EYzeWN7H3+IyKU2IWnUDUeN+ZH
         /Q0ONxMZ2/TDapQakFIrOaGvnZdAipCrU5jWihazv3/Mw1+els1t9SxbWzrEZYDeUyNV
         X8fGI6w7IKNcAtRLyKQuq9qASyPrM7Hwpuims+S0J2R9KriDq1MbNrc59md7+9NhLenz
         rT9YFTdH2jx8Ctm32nYGyo3z6joIiXM08CxcETH7N5DygLqa5IrwnOeefC80PhnvWxzK
         JBzg==
X-Gm-Message-State: AOJu0YxffbwA3qUf05cAFk8/DYAZLfkWWI1q66Sv452DQAGOh8R/2w0C
	pS1tvSDpqZjz5z6gRsXELSZUGG1BKTfIA/zBnazlR1FnksQa2C2l
X-Google-Smtp-Source: AGHT+IFQVCelozL/GNnweEhB8CUVXpac1LsrkVkHvqyHoNGMKBPqqiNx8r/TGIcpMURRFb1sdCXDUA==
X-Received: by 2002:a05:6a00:2b56:b0:6e0:3361:ab48 with SMTP id du22-20020a056a002b5600b006e03361ab48mr770083pfb.1.1706984686331;
        Sat, 03 Feb 2024 10:24:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUGEKQka4PJeL/5J+MzrCxnk8WdgpBGlxgHwEEaqc2IgzivGeBfvhzQUawlnZT0L4o6juNzHqaUhrTB5CycOYSXmoyBbPMIiPXnMckA606crreFBMb+r70h5O7f9De5u1Mzohx1Ja786Y1hmgHX64bUZ5Ej32DsDGQS1vzFuqSlCFFtjfdlE0wR/c+LG/KcOOY5GrAmbfbJ/CKuByMmpe6INFNy01b8/Z7p8q2DNU2I+2wN/Iow
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m13-20020a63ed4d000000b005cf9e59477esm3979859pgk.26.2024.02.03.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:24:45 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706984685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wvmygpMXKch9KjcDbs26g5cam8cyiZFx8cVfTokl0Q=;
	b=Gzl+rbpt03600Z5QlubY2Uz0IOXHrdFq6L09LLKOLrscLk37b4a3dHA1QCZWduMcw1ZYCv
	EFw2NxDVEEP8VW4tyS/ArufOSydhNEFzGOWgbTQYVdFJC2ZfmsaXer2x1j6UPhQrHcJCmC
	i5GGluBBcdSK0lBR+lmSybIKo9NHYea00Vtzbfo6lg0UFu2ijRWHWD+uz5OGSciKxHmmrv
	oZlOheH2XlsqnjAgOzJRJzbUDH8am86XqUjkj5d2ckfFPbt8f+pyyeebO6FbDBrGtoD8dM
	ooaPr9lj/Ezj3PuFgtNl0lLZC3xagAqCcI06Nj0deTQoTFFGcab/M4v1nQ3uEg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 15:25:04 -0300
Subject: [PATCH 2/2] drm: mipi-dsi: make mipi_dsi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-gpu-v1-2-1b6ecdb5f941@marliere.net>
References: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
In-Reply-To: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Jb2CPAEe0Zv9sdkMFnExsmwVmtr4EceLYp23eTMTLN0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvoUC/Lz6356r1q0GAvsmkQCwWxHc5uvTWgroU
 kdL/uMoE6qJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6FAgAKCRDJC4p8Y4ZY
 pl10D/9i67GeFbwaTagf1GafrmidveAEGjCdW+xMz/LNxIarAFa/ouvJKDcube/GztA9Z0OXUAX
 9CZhxQJhglbI/CAFkJix/ooeAVD2l5wxWlJLMvdwdj0TIZCkomI4eh/cGp0PG7WLdNo9GODNQfU
 o7Zdp2uWzVVFL9z/Rj01C86bVVUU+AKelJBM9D2EaTd7gPrWVinKD2r4/KnVk9m5O8JTm7Sjp9I
 OFpc8UOPECwR6ibfvjwroqaVvs+6eAxpSBXjmhT2h2dMRqnWrMcJnXGoRaXBl4x+TMjfTdmgN7+
 r9PX6tHQq7mCh63bjRxl1j7DHNulfiIXmQpjSI5X9gzPGQ5msCOMS5uygT5Qseld3343Q7FnhVX
 rlSCUpaXYfU9dDKmNoWcl3tdD/DLXrRyb4Fjftlpkqphuvu7ynfe/tJHq5HM47LKa7SOYV86g4d
 KHln5o0G5hzTCAQR3NYcuxs7FxzyF6+TsJ/Z3hd0ULHzUhQTzOc9EP09QI14nJlzay6KFFaPkZA
 bs5n0kjvA8QLCBpmOhemY0l7b6ooODQCnSU0u2WFA1hd8iUnugqCrCBNBxHW532DmuchW+ADjik
 snN5nmZQLzF2ugSNvpQ+em677ZXlUixigIuchhPxwZjeUIySzrXrVWXN+NX0RuMCWEdrs4Vox3E
 xVD+kjlhTvOptWQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mipi_dsi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 843a6dbda93a..ef6e416522f8 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -89,7 +89,7 @@ static const struct dev_pm_ops mipi_dsi_device_pm_ops = {
 	.restore = pm_generic_restore,
 };
 
-static struct bus_type mipi_dsi_bus_type = {
+static const struct bus_type mipi_dsi_bus_type = {
 	.name = "mipi-dsi",
 	.match = mipi_dsi_device_match,
 	.uevent = mipi_dsi_uevent,

-- 
2.43.0


