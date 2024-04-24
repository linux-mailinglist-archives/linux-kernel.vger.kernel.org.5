Return-Path: <linux-kernel+bounces-157296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D908B0F72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3AC1C24880
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE458165FC3;
	Wed, 24 Apr 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJDsKM5c"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1A1635D1;
	Wed, 24 Apr 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975122; cv=none; b=nRMafbGhH5KyEXtGHiD8II5t8DDjC7Uax2L+x5pmHqBAYkuWI4jMzQ1zAcfqoWOaxTunxWhUPk2OlCfBd7HWmPwYa40rW754c4nnQVFIsMQ3uKi0XqkeBPzbGLtUvoDdCnav+1AsVFmwdZcAgchxdbmcKfvqCUMRQ928OUyTeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975122; c=relaxed/simple;
	bh=hWNae6vbnA4iCNH0utg1R+YhNmf1tQWghhuQryyve40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OfDkuT7dAgCt9wehf3szGYLi/Z3fIkfYdrrwria2RwX0kmV/X4Pvk3519XOD+H3tdjdroHmJ18X0Jdk03J3+sFZi6fA7daS3Ymm+d+Xkh8EfsgeYaXo4VMpnXJ6r4du1BW9Qp0ooIlTwkM8Csp5FAhUYQXx3/z5E89DlZHGvfkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJDsKM5c; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so6233148f8f.1;
        Wed, 24 Apr 2024 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975119; x=1714579919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7fwhYCByqsyxtduNgA8zx5Qp4wn8aktE/VYg2R/KyU=;
        b=AJDsKM5cwaMPuaKUHp1NwBgjyjOhDjBhdjkj7/s/sLPcVGI5zQFYeYFqlXqYLUZ0ew
         LvHRYv4fqquyfN7MYCIUP+do4bqBXC9nAhp9HjNRY1tz7Sgz9K9uOKeLj7bmNZB/GVsJ
         Bwnjso5LBDFkB3tZCid1SbkQjnUW0fe+NHgKqkXwJeKwqkbYlwGYc0InsAtpDfNk96WG
         eP9A/1AUMUkUeM5OTZV0dviMLDxk+HzfLl7QNZZHdZFMfGNmEvCXui+Dv6QLS5omq0O7
         ECFvipY7FKkDs2WcUhzBkcrVmoj5Q6boFtvHBjXIRe6J/Ngt4L8lkFNe9/xm4HFlZ7sJ
         GF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975119; x=1714579919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7fwhYCByqsyxtduNgA8zx5Qp4wn8aktE/VYg2R/KyU=;
        b=L+IywMx+uHBk4PF6D8bUkkDAUzy410mzyRJ4SZA09N4QryFTWl0ohn3Pbob3zCQTlX
         HU2OR0BiYt26yKpea7Q3X2CyWPlZaYiTJOD8B+5BeIUN5kwlvjs/uOfg9/YHzvK9jJab
         eQKIUyAPctsTgzSEoP1yLPZ/d+akvnVngXYep7PqJHnm8VRA5lEC54nl4lVvjJBqAmFs
         jl6dOlnD3zSkw06YAJfmWqsS7qmibUiLE5tndBEEtKh2YQwYNHHPSQy/feioKPFqGwuI
         PXoOjS9+VNQ++vK5FGQsLjNMcNzTDrtc9iOvj7234umxpVXo7D01wldqhfsr4NnQd1Vj
         6wOw==
X-Forwarded-Encrypted: i=1; AJvYcCXM0iaOWW66J1g2mQ+BQNmACben9f0ALKWeYQvQts4UCLEK5r5T6+NLjL5g5ajwyqQvQyrj8zIM9RXmO0MsvKn03OirEZvs6mur/52T
X-Gm-Message-State: AOJu0Ywx87ahUdrH55qzTy41IXzLZFdxNf0NQRFoz1BoVtwv36gnosXs
	eEvI0KBtC+Ut2Pcz+6P1ht+9smZHC5waykL9V9pJqUuQNufXpjLp
X-Google-Smtp-Source: AGHT+IH3jYf42AlOaYiK+FEIyw3LbLPxAlyd2I+vNCGrces4wHDtdBSa9HS2eMuzoJpicBrPQ5yBVw==
X-Received: by 2002:a05:6000:4e6:b0:34b:3f27:89cd with SMTP id cr6-20020a05600004e600b0034b3f2789cdmr1584655wrb.71.1713975118431;
        Wed, 24 Apr 2024 09:11:58 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d4bc1000000b0034ae73a8b25sm9639884wrt.37.2024.04.24.09.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:11:56 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui.Pan@amd.com,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: Fix spelling mistake "PRORITY" -> "PRIORITY"
Date: Wed, 24 Apr 2024 17:11:55 +0100
Message-Id: <20240424161155.3946451-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in a literal string and enums, fix these.
Currently there are no uses of the enums that got renamed in this fix.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 +-
 drivers/gpu/drm/amd/include/mes_api_def.h     | 2 +-
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index fbe31afad1d4..44f1af6da21e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -111,7 +111,7 @@ static const char *mes_v11_0_opcodes[] = {
 	"RESUME",
 	"RESET",
 	"SET_LOG_BUFFER",
-	"CHANGE_GANG_PRORITY",
+	"CHANGE_GANG_PRIORITY",
 	"QUERY_SCHEDULER_STATUS",
 	"PROGRAM_GDS",
 	"SET_DEBUG_VMID",
diff --git a/drivers/gpu/drm/amd/include/mes_api_def.h b/drivers/gpu/drm/amd/include/mes_api_def.h
index bf3d6ad263f9..ed479575df18 100644
--- a/drivers/gpu/drm/amd/include/mes_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_api_def.h
@@ -54,7 +54,7 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_RESUME			= 7,
 	MES_SCH_API_RESET			= 8,
 	MES_SCH_API_SET_LOG_BUFFER		= 9,
-	MES_SCH_API_CHANGE_GANG_PRORITY		= 10,
+	MES_SCH_API_CHANGE_GANG_PRIORITY	= 10,
 	MES_SCH_API_QUERY_SCHEDULER_STATUS	= 11,
 	MES_SCH_API_PROGRAM_GDS			= 12,
 	MES_SCH_API_SET_DEBUG_VMID		= 13,
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 410c8d664336..5b8fd9465cf3 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -54,7 +54,7 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_RESUME			= 7,
 	MES_SCH_API_RESET			= 8,
 	MES_SCH_API_SET_LOG_BUFFER		= 9,
-	MES_SCH_API_CHANGE_GANG_PRORITY		= 10,
+	MES_SCH_API_CHANGE_GANG_PRIORITY	= 10,
 	MES_SCH_API_QUERY_SCHEDULER_STATUS	= 11,
 	MES_SCH_API_PROGRAM_GDS			= 12,
 	MES_SCH_API_SET_DEBUG_VMID		= 13,
-- 
2.39.2


