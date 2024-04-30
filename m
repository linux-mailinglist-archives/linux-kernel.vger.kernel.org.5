Return-Path: <linux-kernel+bounces-163580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A04F8B6D4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401151F234C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F273127B73;
	Tue, 30 Apr 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NY8SCiuq"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEA129E8A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466989; cv=none; b=ZgYCaZKjKGosauY74H2A4e3/OIFnAlTGroNJjvkCZ43onYt10+9+R8eFe7cIw1AlsgpJAQfG8A0sUgyKDxbbO8fqqS0tXAkMr5ZIPmFpEHGLSTcNtYD4WkL7HgeMU+HjgrwEItY8PrrnndGqsuYzU7Eqtc8I7GAfm4SuJ+tfHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466989; c=relaxed/simple;
	bh=VCkTpId6BInZFl+4kT5cn4VsDCVeE/AYNyGuqTD/jLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/qOnVR3R3CaDFO2udLvypjZ7XLsPZ5ZYRiGI6x1t2iCFdJUreY2SN/jOas1qAi4zfTnjv/j+UwG+swrMtApOY3wQvSSsYk+ZtzSjzaPZvOA09yupUbllPlV3g82zOddJqKZHL/l3PIGMKnscSzXYjqJFLAFnV8QQEfWU6m2uds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NY8SCiuq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51dc5c0ffdbso2184392e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466986; x=1715071786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsLWOB4b70yQp4IQGq23NCJFbtHs36i7ZROP1LVbazk=;
        b=NY8SCiuq8SBYzVg7pRyQVINRJMjK+qd2AIlx0uFOb81SWb3YPhvr2Ev4spPrwWqoWe
         dBLynanPtIsOcM1Yani/7fwoD+WMhpccMmMrfWMPjTfPx3JSWCbFUmpPIrPN0GQIOBRq
         2z+hktiODQ5E+A9V+MUoWg2svY+PG5qiYZJlrNRq8x3K1P4/2BLG+N/+NxnHJbNAfhtu
         FkoeiOQ1LkWKl1XGRybUGPMH1A3HpA69Khwrd82TTVxK3+vuV/nyJZwIq3UH1qgY7ufk
         n656eKmYIMwSH87+rb5Bv1y2ZDgNilp2Yg6JQ5/CV0kTKNA7YGsfUiMhW8nK+cRPkPhf
         sRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466986; x=1715071786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsLWOB4b70yQp4IQGq23NCJFbtHs36i7ZROP1LVbazk=;
        b=sb5HMJ9YIWvJOM/mIveEfxsAgXOw1d3ch9aCPtHbHA1FjZ9M8gO9XRdzqjH9aaAxAr
         Nur+Ad90PKgfBl0rodUUDn7L1NlihjmRKxolCUv5lP6oajNenE4/f1qDnmZzqs1g1ZtF
         sI3bAn7MwBefVQOyoG+1yXT6BCEW7wOrEk4MTfgzSwi6p94M+yYAGSayfq9iJklb9m/K
         GLZZCHQZB3dFDhNeq6iqy7HSniqor/fMoNzK8gxVOgGEoOaij7ospzLYOdgKcJkMA4PB
         8v8b/oOYg1kHdat1J8XDSOTteGiDfAHcdFz1WM/Ou4IO4vBEjGliTjX7x3ZjypXo2fen
         FrFw==
X-Gm-Message-State: AOJu0YzrywEt+AWEbCSSNbRV/OWauG3WbU9dHVcVaoEABHQHPm15261v
	uCrrmECuBbrElsoIvLQZNKLzlN/YdxxbebslRXmhmvT9PaI/yGTW2GvWZWsVKYc=
X-Google-Smtp-Source: AGHT+IEJlo4iXA4QyWlN7MRBTLNeC3gpqpXuKo4wN7f7CHEwrkdGAudpyhbaOW7nwczOLdE0XC+qcw==
X-Received: by 2002:a05:6512:3156:b0:51d:67af:fa6a with SMTP id s22-20020a056512315600b0051d67affa6amr1326989lfi.15.1714466984342;
        Tue, 30 Apr 2024 01:49:44 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:43 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/11] nvmem: core: switch to use device_add_groups()
Date: Tue, 30 Apr 2024 09:49:16 +0100
Message-Id: <20240430084921.33387-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=gOhUeszYWuSczx7dSSZh+ck+cbYa9bh9+1dE60nzd94=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCNwRWI2ZPRQ+RknnjBPyhPjsm+rDd55TG78 0hGqbq9sOSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjQAKCRB6of1ZxzRV N7DCCAC5XzxVB9kUI4jCYODEvYXQRxUL/8p2qz2BSAUNB3KXZnY4+UXWIxrEGUcEdYRZqiy/38J 5qcZgVcLiDaQ4W1PgtSWzYcmWVKWDLPMTH/6+VqhW70M2AeeVE0cFZbQq3/87rQufJZwOAT0lIJ awQHLm/yuvoqq4BTKcRtg5hda/TW9Yl6ffW6ISHoriXkA4qBx2lLh5HO6kULF4ZJytHHNfpNKtf Bjqen+e6d3cWgjuOjWk7oUQeom4RmUPYsufSPkPJaQrFfkWQb4xefWshKN/NF/dzAP3eqQ8ya9x vtMGMHzf7/5bOpWo4DRC2J94oQEpyucAicD3JGyIPBpsu74C
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

devm_device_add_groups() is being removed from the kernel, so move the
nvmem driver to use device_add_groups() instead.  The logic is
identical, when the device is removed the driver core will properly
clean up and remove the groups, and the memory used by the attribute
groups will be freed because it was created with dev_* calls, so this is
functionally identical overall.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2c6b99402df8..e1ec3b7200d7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -478,7 +478,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 
 	nvmem_cells_group.bin_attrs = cells_attrs;
 
-	ret = devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
+	ret = device_add_groups(&nvmem->dev, nvmem_cells_groups);
 	if (ret)
 		goto unlock_mutex;
 
-- 
2.25.1


