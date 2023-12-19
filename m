Return-Path: <linux-kernel+bounces-5397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E930818A39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE38828CD72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B0A1C28A;
	Tue, 19 Dec 2023 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePdiI+G7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32B1B288;
	Tue, 19 Dec 2023 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d05ebe642so16194875e9.0;
        Tue, 19 Dec 2023 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702996771; x=1703601571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nx2SKSg4StH2xypt44SaUQkkd1sbC97S0Nlq+vY2bSY=;
        b=ePdiI+G7wzNB+cZgmOPfu5SBCYZxJP5ymr/H6Ewcpb84D/VT9wHQ2O2kRdetbaZ+M8
         xKq2CjZbz7FK+2hEI1yxSmG2dNvU4hWxcpQEJ42Ke9SE1Yye93wZU3UdvA6ccwVFcNL8
         56qQ/UHfGs6w8d6TMdrkWtXmvphfnKgz++Xv7HNW/kEePSt8js6RTxy51gP0+ZOdIegw
         lRf/Ps4FIKxSwV0sQ7HabTNXJsVzPlUhZUoOZBDZfvfJnZ4mE5pq2pGheqpJuM/Tb4yL
         l0sSjasDcAifeQRDHEYbLKPNGYHmXrRuAM+clMSXLD5hWgpSTsLg7c4BWSMjIGMmCd10
         SWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996771; x=1703601571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nx2SKSg4StH2xypt44SaUQkkd1sbC97S0Nlq+vY2bSY=;
        b=bzts9Hijyq1dbORZ3IWEoxu/eNSLTT4yiZxOkDXqaE1fHs0beh6w9+TuCL/CwLf/f8
         RvoDYKoTyOZtH62pRVzivPrjiwFTMBbKNfyq3p1P8yHkbmKL/qLb57ONEpovYx5R8RHn
         4bSpPM3k/Chc8ruc+Pj/k2G4ZIOOIrewOtET6dZrXmqBNYCz2T9VV0FSg5p57RvY98DX
         Iut0PGe1eETXT/5IUKLgx5CfGgVG+40omY5o1BptPbmMKVl2KCEgoDJlF53JIJETXey8
         PIO6hORd40m1qOtOxTnBBwTxcmIajPHdLsPE29yuIg5AIyw11LGtriE9d2ptuPEuoaPo
         5IVQ==
X-Gm-Message-State: AOJu0YyhnjUj9tnWFW8WWWcBiAWo1lYZQ4UgkkyTKRHnTcnKVw1FSABi
	meAFPNZv5VgCRlS4WSgd8D1pqHpt4mX3jA==
X-Google-Smtp-Source: AGHT+IHCS4aIMnRNzSW0KQB552BVr+rnmPjXguatBBsBOxpsJevOlQQIsoPsVlfACnz4yy2pQqMfTA==
X-Received: by 2002:a05:600c:6a81:b0:40c:6d5f:7b89 with SMTP id jl1-20020a05600c6a8100b0040c6d5f7b89mr468847wmb.73.1702996770850;
        Tue, 19 Dec 2023 06:39:30 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6b84000000b003365e9fea3esm9354226wrx.31.2023.12.19.06.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:39:30 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: atomisp: remove redundant assignments to variables
Date: Tue, 19 Dec 2023 14:39:29 +0000
Message-Id: <20231219143929.367929-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are several variables that are being initialized with values
that are never read, the assignment are redundant and can be removed.
Cleans up cppcheck unreadVariable warnings.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 .../atomisp/pci/base/circbuf/src/circbuf.c     |  2 +-
 .../pci/runtime/pipeline/src/pipeline.c        |  4 +---
 .../atomisp/pci/runtime/queue/src/queue.c      | 18 +++++++++---------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c b/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
index d9f7c143794d..06f039236abc 100644
--- a/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
+++ b/drivers/staging/media/atomisp/pci/base/circbuf/src/circbuf.c
@@ -207,7 +207,7 @@ bool ia_css_circbuf_increase_size(
 {
 	u8 curr_size;
 	u8 curr_end;
-	unsigned int i = 0;
+	unsigned int i;
 
 	if (!cb || sz_delta == 0)
 		return false;
diff --git a/drivers/staging/media/atomisp/pci/runtime/pipeline/src/pipeline.c b/drivers/staging/media/atomisp/pci/runtime/pipeline/src/pipeline.c
index 3d8741e7d5ca..966cb47b95d9 100644
--- a/drivers/staging/media/atomisp/pci/runtime/pipeline/src/pipeline.c
+++ b/drivers/staging/media/atomisp/pci/runtime/pipeline/src/pipeline.c
@@ -693,7 +691,7 @@ static void pipeline_init_defaults(
 static void ia_css_pipeline_set_zoom_stage(struct ia_css_pipeline *pipeline)
 {
 	struct ia_css_pipeline_stage *stage = NULL;
-	int err = 0;
+	int err;
 
 	assert(pipeline);
 	if (pipeline->pipe_id == IA_CSS_PIPE_ID_PREVIEW) {
diff --git a/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c b/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
index 2f1c2df59f71..c4d4062206a2 100644
--- a/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
+++ b/drivers/staging/media/atomisp/pci/runtime/queue/src/queue.c
@@ -81,7 +81,7 @@ int ia_css_queue_uninit(ia_css_queue_t *qhandle)
 
 int ia_css_queue_enqueue(ia_css_queue_t *qhandle, uint32_t item)
 {
-	int error = 0;
+	int error;
 
 	if (!qhandle)
 		return -EINVAL;
@@ -138,7 +138,7 @@ int ia_css_queue_enqueue(ia_css_queue_t *qhandle, uint32_t item)
 
 int ia_css_queue_dequeue(ia_css_queue_t *qhandle, uint32_t *item)
 {
-	int error = 0;
+	int error;
 
 	if (!qhandle || NULL == item)
 		return -EINVAL;
@@ -193,7 +193,7 @@ int ia_css_queue_dequeue(ia_css_queue_t *qhandle, uint32_t *item)
 
 int ia_css_queue_is_full(ia_css_queue_t *qhandle, bool *is_full)
 {
-	int error = 0;
+	int error;
 
 	if ((!qhandle) || (!is_full))
 		return -EINVAL;
@@ -225,7 +225,7 @@ int ia_css_queue_is_full(ia_css_queue_t *qhandle, bool *is_full)
 
 int ia_css_queue_get_free_space(ia_css_queue_t *qhandle, uint32_t *size)
 {
-	int error = 0;
+	int error;
 
 	if ((!qhandle) || (!size))
 		return -EINVAL;
@@ -257,7 +257,7 @@ int ia_css_queue_get_free_space(ia_css_queue_t *qhandle, uint32_t *size)
 
 int ia_css_queue_get_used_space(ia_css_queue_t *qhandle, uint32_t *size)
 {
-	int error = 0;
+	int error;
 
 	if ((!qhandle) || (!size))
 		return -EINVAL;
@@ -289,8 +289,8 @@ int ia_css_queue_get_used_space(ia_css_queue_t *qhandle, uint32_t *size)
 
 int ia_css_queue_peek(ia_css_queue_t *qhandle, u32 offset, uint32_t *element)
 {
-	u32 num_elems = 0;
-	int error = 0;
+	u32 num_elems;
+	int error;
 
 	if ((!qhandle) || (!element))
 		return -EINVAL;
@@ -338,7 +338,7 @@ int ia_css_queue_peek(ia_css_queue_t *qhandle, u32 offset, uint32_t *element)
 
 int ia_css_queue_is_empty(ia_css_queue_t *qhandle, bool *is_empty)
 {
-	int error = 0;
+	int error;
 
 	if ((!qhandle) || (!is_empty))
 		return -EINVAL;
@@ -370,7 +370,7 @@ int ia_css_queue_is_empty(ia_css_queue_t *qhandle, bool *is_empty)
 
 int ia_css_queue_get_size(ia_css_queue_t *qhandle, uint32_t *size)
 {
-	int error = 0;
+	int error;
 
 	if ((!qhandle) || (!size))
 		return -EINVAL;
-- 
2.39.2


