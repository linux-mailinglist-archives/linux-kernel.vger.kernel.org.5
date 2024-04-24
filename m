Return-Path: <linux-kernel+bounces-157321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCA28B0FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D281F26648
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C11649DA;
	Wed, 24 Apr 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOJ5+UIv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FAC161338;
	Wed, 24 Apr 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976095; cv=none; b=s7RwYNgIKutM5R3fLRGnDkmudMLi1BdV3VK+OjXx93tdZk14CNNQPsToC/5/dk/x5ERCTA6+IGvWEjf33bADYtcOcKrnvIXyoqo1zJY0RaKFpLK//DxSs2JfyQqLHpN09nnv+gbdQrzAS5KDL8UCaQwydPccWk72Tbg9gEJMAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976095; c=relaxed/simple;
	bh=NQcaleV1DawBwUHhy+dB/t7rpwoabLqXSqjQb/XtsfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rYkkfU/rCaL71jTplol8Mt9p5wkHRg16S4CKN0f/2+RkhrJ/6YnxoJEdm9UO4Zdo0/TNeJ+4reaaGArYMpT7j50kyppZnKj9SuPxi/w1p93r5X6FwbXlfrLkqtni0V7zIiHqncNRbfrDzy/ekIVGgyYFg8HeKrMD2sVbhs6xt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOJ5+UIv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41adf155cffso161315e9.2;
        Wed, 24 Apr 2024 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713976092; x=1714580892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGTvGTdmOEkfpJBObdVGs6RBZIv2agsPt8BWCLj0PV0=;
        b=VOJ5+UIvAnnAMs77bp/VumXjnZWPcome8DwJO6rzvias98TF+CHxo5pa8h41YZ0OEW
         oJS6gP6YzFqk7aXzah4m/+8WDUoA9XplU25QUnf9HDM1B6xFfD4fwqnnfsMZSGCgB2mI
         XAgjePsfMFxToQnGYhAezTsLuQ8QIVcvdU7sv4A2Oks4ZLGsfKlb/4OfkZZW8hv5xswu
         69QoI0WOgRotsiYAnk/v7Nn+q1HaO1NRxF0UQJ208ZCcyeC5LKalTOWJ2azatopQlbDj
         t7VZFdp3T3FgKmUX8AVVfNjDhwSBpC5mXKzKupOcEQ0hZIfDInI9TyGF1BihOguTJS0l
         0P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976092; x=1714580892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGTvGTdmOEkfpJBObdVGs6RBZIv2agsPt8BWCLj0PV0=;
        b=guyDEa9FEDSwTQOEttPXv1ibWYGgf5GvDQ3nCvTNW9kvjicn9cTzUZN7dpcOC3A2pY
         xz98OLcmB7gFaIVLkNpOxH0a6JHQ7k7ACetAPOq50mzDOn0BKgYo/4tvrvgyz/he0TcN
         iknxP74O//GbpYjoEim8UQ2k4anJtEJ29sNz/lksStC3nN0pQkAqNSduLaL/48EKeb5a
         YGSKtoVEAh4KXNflFTyb7TO8OL2A07fmE7r4PktAM/fGldqHSchrVY9TPwqo6YGvlAD7
         3/PxUL5mKmtsNv92uJkre/w7XtF/ZS124BISH97TrEd0T0cuTWTQo03i6J35B/DBXF9Y
         aG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8P3TopxBLOiQJpKB85AhKBjVWjr4OGDhbb+9/oCsktEs4ISbWrSspq92b1y/YbUIZ8LXYggu/HqFkklrnW0VzZ9Q2qC4pJb3iZYdC
X-Gm-Message-State: AOJu0YxXwRpsBSMsbGArzbcOBYHYG/h+35IHoWGs/uBM9coB0WdM8pvU
	xHOJy1hoil4aP5BD1Qz4IrcV8wZhvhP8BeGsnU2gfsZfwpZHdqVA
X-Google-Smtp-Source: AGHT+IFdyfgobu/a315DB2FtmY2cDEDxZGBYPtzRDMgTf+H7kT/QhdAaIfpMUsGqdQEDXdl5Xf1h1Q==
X-Received: by 2002:a05:600c:4f93:b0:419:cc9b:420a with SMTP id n19-20020a05600c4f9300b00419cc9b420amr2380021wmq.1.1713976091917;
        Wed, 24 Apr 2024 09:28:11 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00417f700eaeasm24543125wmo.22.2024.04.24.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:28:11 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui.Pan@amd.com,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling various spelling mistakes
Date: Wed, 24 Apr 2024 17:28:09 +0100
Message-Id: <20240424162809.3948457-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are various spelling mistakes in dml2_printf messages, fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 846b0ae48596..2dea5965d02f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5566,7 +5566,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		dml2_printf("DML: Tvm: %fus - time to fetch vm\n", s->TimeForFetchingVM);
 		dml2_printf("DML: Tr0: %fus - time to fetch first row of data pagetables\n", s->TimeForFetchingRowInVBlank);
 		dml2_printf("DML: Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n", (double)s->LinesToRequestPrefetchPixelData * s->LineTime);
-		dml2_printf("DML: To: %fus - time for propogation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
+		dml2_printf("DML: To: %fus - time for propagation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
 		dml2_printf("DML: Tvstartup - TSetup - Tcalc - TWait - Tpre - To > 0\n");
 		dml2_printf("DML: Tslack(pre): %fus - time left over in schedule\n", p->VStartup * s->LineTime - s->TimeForFetchingVM - 2 * s->TimeForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->TSetup);
 		dml2_printf("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %u\n", p->PixelPTEBytesPerRow);
@@ -7825,7 +7825,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	dml2_printf("DML::%s: mode_lib->ms.FabricClock = %f\n", __func__, mode_lib->ms.FabricClock);
 	dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz = %f\n", __func__, mode_lib->ms.uclk_freq_mhz);
 	dml2_printf("DML::%s: max_urgent_latency_us = %f\n", __func__, mode_lib->ms.support.max_urgent_latency_us);
-	dml2_printf("DML::%s: urgent latency tolarance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
+	dml2_printf("DML::%s: urgent latency tolerance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
 	dml2_printf("DML::%s: ROBSupport = %u\n", __func__, mode_lib->ms.support.ROBSupport);
 #endif
 
@@ -10603,7 +10603,7 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
 				if (display_cfg->plane_descriptors[k].immediate_flip && mode_lib->mp.ImmediateFlipSupportedForPipe[k] == false) {
 					mode_lib->mp.ImmediateFlipSupported = false;
 #ifdef __DML_VBA_DEBUG__
-					dml2_printf("DML::%s: Pipe %0d not supporing iflip!\n", __func__, k);
+					dml2_printf("DML::%s: Pipe %0d not supporting iflip!\n", __func__, k);
 #endif
 				}
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index 0ef77a89d984..d1d4fe062d4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -2023,7 +2023,7 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 	dml2_printf("DML::%s: mode_lib->ms.FabricClock = %f\n", __func__, mode_lib->ms.FabricClock);
 	dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz = %f\n", __func__, mode_lib->ms.uclk_freq_mhz);
 	dml2_printf("DML::%s: max_urgent_latency_us = %f\n", __func__, mode_lib->ms.support.max_urgent_latency_us);
-	dml2_printf("DML::%s: urgent latency tolarance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
+	dml2_printf("DML::%s: urgent latency tolerance = %f\n", __func__, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kbytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)));
 	dml2_printf("DML::%s: ROBSupport = %u\n", __func__, mode_lib->ms.support.ROBSupport);
 #endif
 
@@ -8174,7 +8174,7 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		dml2_printf("DML: Tvm: %fus - time to fetch vm\n", s->TimeForFetchingVM);
 		dml2_printf("DML: Tr0: %fus - time to fetch first row of data pagetables\n", s->TimeForFetchingRowInVBlank);
 		dml2_printf("DML: Tsw: %fus = time to fetch enough pixel data and cursor data to feed the scalers init position and detile\n", (double)s->LinesToRequestPrefetchPixelData * s->LineTime);
-		dml2_printf("DML: To: %fus - time for propogation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
+		dml2_printf("DML: To: %fus - time for propagation from scaler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime);
 		dml2_printf("DML: Tvstartup - TSetup - Tcalc - TWait - Tpre - To > 0\n");
 		dml2_printf("DML: Tslack(pre): %fus - time left over in schedule\n", p->VStartup * s->LineTime - s->TimeForFetchingVM - 2 * s->TimeForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (double)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->TSetup);
 		dml2_printf("DML: row_bytes = dpte_row_bytes (per_pipe) = PixelPTEBytesPerRow = : %u\n", p->PixelPTEBytesPerRow);
@@ -10994,7 +10994,7 @@ bool dml2_core_shared_mode_programming(struct dml2_core_calcs_mode_programming_e
 				if (display_cfg->plane_descriptors[k].immediate_flip && mode_lib->mp.ImmediateFlipSupportedForPipe[k] == false) {
 					mode_lib->mp.ImmediateFlipSupported = false;
 #ifdef __DML_VBA_DEBUG__
-					dml2_printf("DML::%s: Pipe %0d not supporing iflip!\n", __func__, k);
+					dml2_printf("DML::%s: Pipe %0d not supporting iflip!\n", __func__, k);
 #endif
 				}
 			}
-- 
2.39.2


