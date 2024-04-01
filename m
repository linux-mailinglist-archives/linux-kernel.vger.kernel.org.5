Return-Path: <linux-kernel+bounces-126386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED528936A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4F6281DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7442B10F1;
	Mon,  1 Apr 2024 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs+CVyJ5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21404624;
	Mon,  1 Apr 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711932497; cv=none; b=AhuPLfqTyRDiSGUqR4tD3Ih2H527xlk3OWK8S10WeNofSnRuG5IVaSncAdzRmoMbw14vLEW5MzGSI8Q39SZXUKfoGhIEv07uR3Axid9V5sVWgldhDs8rzJ9GmMCObkuJ3WBIJ8+vG9Sh5Wn1kkWjKgDcTVaX1Up/b/2Nt4c3ST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711932497; c=relaxed/simple;
	bh=aT38k5FEJbwUG/FQI4TVWmBYBpDF28w/xYsS2/K/s14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6VkRKXttkIaiHxEI+RRPCRdFGBJ+2oPqg+88tE7bmZXZHkYEbVdyeecN/RScDwyEw7P9aBduZGI2wfxoTV1esXqXlCGES4rguFzE7p7CFt9cGfg887/YaOV766K1XAHNC986GdrdOPIvh1xGwlM5bAwE1n23yhucc5V7LJ+6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs+CVyJ5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4156863929bso767375e9.0;
        Sun, 31 Mar 2024 17:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711932494; x=1712537294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p52HVfyGMWfC3VvaZSiMnaakyOMfxMtSY2rIkz6LVSE=;
        b=bs+CVyJ5kptuTuQFjJWJEZ1JnUGMiYanIjJ6gOrTuj3OfT9DT0cgJkRzudOvhstXeg
         WSvQvDTCAF5Rp+ThCiaL/0DvacyqFrhyo49EFR8W7/TIApQdKgp3ijqFfE6SZ6vajdwT
         64mCASuX5t+1CCajLIRDM+pklYKdOqF9+SBdYUyiM33S3q8tZn4Xqy51rYluEQlSuWnQ
         151s3Tm+iPqC5qWMkjMLdK4PsZIEBBT+EOaDFq2xelrj5wbVkMjQtMq6nMQo0HK3EsAh
         yQsSodRQXHXCApLooVGAdoywqwYMtUoEnkksh5G8qdWd5/QkfXdGyodcmp95JLCWKK0t
         hEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711932494; x=1712537294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p52HVfyGMWfC3VvaZSiMnaakyOMfxMtSY2rIkz6LVSE=;
        b=ujJ3GL1XtztK+Hqt5dxvXm/X2aiQoa2sjF2Te6L6h5rKu13m2vQwNYOaG0rHHpe8sZ
         8bz/rP5W0LqS0v93c6GyBftRpuykAfSb4hVU2dL2RdUhED/sufhxH20LwT75YUDOpvSr
         8vkymiuTkaWaSjpgiCmqEzmUb/FElaHjqX9zCZ5wY/lSqiTVFM7yvmbbzw6pKfXUlbrO
         GT8RxitsL6nMe+cCbbPJ8ve8/nBi03kSRCz4l93xYkDUpMoUCFHXg15SSzoCQFzIENTy
         17/DNR/aIQC/qlyBswtfa9YiQetthXqo38ulE4ZNkNSgTsiUctMha9tKEwZm+OmUnsVn
         PXKw==
X-Forwarded-Encrypted: i=1; AJvYcCUu7pxh0O82vNdPTUXWo9X5lizLGUeW5addASsgtjLnD8g/A6Rwbyo3e0/RanHG8ZRX8B+iZjsuRgGGpnZr5+bi3MWdk5zN8HweNS9J
X-Gm-Message-State: AOJu0Yw4SuZrpqfQAIWaohxY+aLEWwEpaisv7+hKp5YRiVR6u1YLHSrp
	5phtrU44J6fJp6J8yF62LEU6mIy9ACD/hRy4YwNJjmTQD0xge9p6
X-Google-Smtp-Source: AGHT+IECWUJXut2tQr0lHLx0gLlyVFyXpKdPTkxjiLYCuPzrWgakZlz6WqjEu2peIa6KWsVh3b3hXA==
X-Received: by 2002:a5d:4d89:0:b0:343:349f:99c4 with SMTP id b9-20020a5d4d89000000b00343349f99c4mr4391319wru.5.1711932494098;
        Sun, 31 Mar 2024 17:48:14 -0700 (PDT)
Received: from debian.fritz.box ([2a02:810d:6d3f:e873:d065:717f:51ef:a1b7])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b0041493e21844sm16171886wmq.27.2024.03.31.17.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 17:48:13 -0700 (PDT)
From: Stefan Berzl <stefanberzl@gmail.com>
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Berzl <stefanberzl@gmail.com>
Subject: [PATCH] HID: uclogic: Remove useless loop
Date: Mon,  1 Apr 2024 02:47:57 +0200
Message-ID: <20240401004757.22708-1-stefanberzl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The while in question does nothing except provide the possibility
to have an infinite loop in case the subreport id is actually the same
as the pen id.

Signed-off-by: Stefan Berzl <stefanberzl@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 55 ++++++++++++++++------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index ad74cbc9a0aa..a56f4de216de 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -431,40 +431,35 @@ static int uclogic_raw_event(struct hid_device *hdev,
 	if (uclogic_exec_event_hook(params, data, size))
 		return 0;
 
-	while (true) {
-		/* Tweak pen reports, if necessary */
-		if ((report_id == params->pen.id) && (size >= 2)) {
-			subreport_list_end =
-				params->pen.subreport_list +
-				ARRAY_SIZE(params->pen.subreport_list);
-			/* Try to match a subreport */
-			for (subreport = params->pen.subreport_list;
-			     subreport < subreport_list_end; subreport++) {
-				if (subreport->value != 0 &&
-				    subreport->value == data[1]) {
-					break;
-				}
-			}
-			/* If a subreport matched */
-			if (subreport < subreport_list_end) {
-				/* Change to subreport ID, and restart */
-				report_id = data[0] = subreport->id;
-				continue;
-			} else {
-				return uclogic_raw_event_pen(drvdata, data, size);
+	/* Tweak pen reports, if necessary */
+	if ((report_id == params->pen.id) && (size >= 2)) {
+		subreport_list_end =
+			params->pen.subreport_list +
+			ARRAY_SIZE(params->pen.subreport_list);
+		/* Try to match a subreport */
+		for (subreport = params->pen.subreport_list;
+		     subreport < subreport_list_end; subreport++) {
+			if (subreport->value != 0 &&
+			    subreport->value == data[1]) {
+				break;
 			}
 		}
-
-		/* Tweak frame control reports, if necessary */
-		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
-			if (report_id == params->frame_list[i].id) {
-				return uclogic_raw_event_frame(
-					drvdata, &params->frame_list[i],
-					data, size);
-			}
+		/* If a subreport matched */
+		if (subreport < subreport_list_end) {
+			/* Change to subreport ID, and restart */
+			report_id = data[0] = subreport->id;
+		} else {
+			return uclogic_raw_event_pen(drvdata, data, size);
 		}
+	}
 
-		break;
+	/* Tweak frame control reports, if necessary */
+	for (i = 0; i < ARRAY_SIZE(params->frame_list); i++) {
+		if (report_id == params->frame_list[i].id) {
+			return uclogic_raw_event_frame(
+				drvdata, &params->frame_list[i],
+				data, size);
+		}
 	}
 
 	return 0;
-- 
2.43.0


