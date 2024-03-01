Return-Path: <linux-kernel+bounces-87837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BA86D9AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8A21F216DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198E3C060;
	Fri,  1 Mar 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PozDELNI"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4523BB41;
	Fri,  1 Mar 2024 02:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259818; cv=none; b=aNbU4DmzMVNx/4wUtRAxR4N1CUYH/WMVQ7bgb2giNOfv7Ghm5MUP9ii66EcwztRzCcq5n+Gq6nNx1l+2lmgeiZKDWxjHwPaw6D07tgI2lOLcKhz8hw+z3t05m7AQ02yVrdAO69TVcubNU7bvVB+Ssu1oZ2g48JCeELpr4BJwxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259818; c=relaxed/simple;
	bh=D4v7OqiIcxtnB9pKJJT77NSxSlEQbl7AwhhYwqVhKYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIlnvdOZgktQAZi4K3tvXRLWKOfOXNQxoqLcrxj49qQgvun1wKuzi4HfjUzev6m/8/jAc/4Zv/FrkyYYRi6JdHKxias5Qie6UpscuZ72JR1b219FwCT6PQuwB0Nazey+3AMqPhdlf+IiX+184/1fPMmaxbvFuF5fLE61gPpzN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PozDELNI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da202aa138so1154378b3a.2;
        Thu, 29 Feb 2024 18:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709259816; x=1709864616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7TTF4h++4LUefmTdShl2ARCsRJ9gzf0rRngFA47wRE=;
        b=PozDELNIFS83s/EJ5FTYZkTK9hyfkdVMbl3h+KebVhLbs+eUsE8z6k+U987MwNju3+
         UbLKCHe3/CrLM24J42BDwHaJWfOvQp3ElN9huJ/R3ZWMgZfnLJ6RWSbWoChohXxu/K6Y
         sg/zhhfa7ZSrMC3NE4BCffMe904BY5bZX53d3in9Cbq1Clnb8wZQXmavIB6beEJCpEI8
         mVvijg/0F1A3yhWYxJQKyxY2JHMe6lfYscQy/AP0dnkkQAlE5yQUiZ9nxxunHKD0HQ3f
         Jh0WjP8D6Xp1JSJ62gifgqgsc0LkGODrt/kKfWDJQpMKqygIXHH5P8YlUF2ddSp+kp/J
         TWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709259816; x=1709864616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7TTF4h++4LUefmTdShl2ARCsRJ9gzf0rRngFA47wRE=;
        b=RGAJ0fqnNLNkXuaV8EWNbQf+XBebVr+ZuUWk7sngVDBbQ1pjWEdj8ig9U/Ca4HarRl
         na5+vB1DNkb6UioRnADs95xvfsAua7iy6qILa+03IMcJqcOh9355ShWBY9KIENFxezgf
         s0EgyESw2lLvNk5rlWVEtRvR+NyPEx4bceB9Ag2/PUHu109Rgdb8nqeEqhZsFmYLK/e4
         BBoH+BGA9iyx5wSvzixWvJrXKtR5P7UaT9tsihtZpOS2GS42b16n8aUN6EyyFggoaGl8
         ZL4OHOunj7LGIXNwyZwed//5iIWuhkPscEaBlYPmvfCuA/FGCk9ijF9SlIU6FXniWs5Z
         lk8w==
X-Forwarded-Encrypted: i=1; AJvYcCWdfJfVOxA07H7v6Zh3zc/bYE7q0Uap6PnxRfpWDlOiYwXzoo8B8ZbJc485x5ZC9fAOhZFEkkq7kLSm+CbBltQTm6XJvijNWTiubMnF
X-Gm-Message-State: AOJu0YzjvhCF3VLd8OGgC1Gnc9mLi+FC2SovlUWrXvqwJDgO+hPh9K1p
	q6q8zRbl+KcNdgxOK3vTrGetMffOTqUZXiwFR1TXzQEPF9Nz8k2x4zINF/OtH5NKAQ==
X-Google-Smtp-Source: AGHT+IEWtD/qcODefZZC9kzum2ASLC1h+xeYlqdZDWQ0qT1wY8iZ2OLZDAb+EIJ7nivbAiNSSsbP2g==
X-Received: by 2002:a05:6a00:1913:b0:6e5:5597:822d with SMTP id y19-20020a056a00191300b006e55597822dmr617763pfi.33.1709259815981;
        Thu, 29 Feb 2024 18:23:35 -0800 (PST)
Received: from VM-147-239-centos.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id f22-20020a056a0022d600b006e0737f2bafsm1928824pfj.45.2024.02.29.18.23.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Feb 2024 18:23:35 -0800 (PST)
From: hyper <hyperlyzcs@gmail.com>
To: shannon.nelson@amd.com,
	brett.creeley@amd.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jitxie@tencent.com,
	huntazhang@tencent.com,
	hyper <hyperlyzcs@gmail.com>
Subject: [PATCH] pds_core: Fix possible double free in error handling path
Date: Fri,  1 Mar 2024 10:23:25 +0800
Message-Id: <20240301022325.20861-1-hyperlyzcs@gmail.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
calls kfree(padev) to free memory. We shouldn't call kfree(padev)
again in the error handling path.

Fix this by returning error directly after calling
auxiliary_device_uninit().

Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
Signed-off-by: hyper <hyperlyzcs@gmail.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 11c23a7f3172..d6eedd78d5cc 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -174,6 +174,8 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 
 err_out_uninit:
 	auxiliary_device_uninit(aux_dev);
+	return ERR_PTR(err);
+
 err_out:
 	kfree(padev);
 	return ERR_PTR(err);
-- 
2.36.1


