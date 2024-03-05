Return-Path: <linux-kernel+bounces-91720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE4D8715AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321311F21AE9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A87B3DE;
	Tue,  5 Mar 2024 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="K/KSsDs3"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7F7E567
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709618928; cv=none; b=stsBVm502gOBg+ZLE+fs6p/vnKgu4Tp0XxlAWMJboJvoP7/D3iPirWH+LzoDu2F/AcukF+3zNP65spe8N9bV2FbpyOkdjQjgifg+n4aLMzD9eBM5S7pgWAcyhEBqBVzYxMTJaGstptPi432zmJ2pU9MWcOuT/2jIqYmqXT3acpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709618928; c=relaxed/simple;
	bh=rI+UFBLzHgh5osY1C+DB3EoIdb5NuomFAo9d4P0bbRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dM1bUcyj8e0ySyCkFidzAkPzj4aNQujgrUa2r3T4w+vxlFV+7gkwWeCGDEqlqIc7IT7xDGYwEoGG4kqMH0PWr7KKepg15+xSWS5i692Ud6FSCQB9vQCC1RIXSHiX4Ze+WDRU/+t7TeV3b4pjiJDYQW05Vv/ZYDieDnUWRT6LYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=K/KSsDs3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29aa8c4710bso3847484a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 22:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1709618926; x=1710223726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5V8y3dySFl8kdmMCLan3vQixGPkJBiAZiaFJHDPmSXw=;
        b=K/KSsDs3cZvhHTgSRLVUU81HWOMLNTgsNjsv92bB1zIiKKdJQGqLpSTmZT8I9vmJw4
         CVxYDliWh0MJgeHACZJSVkXbok2QtfX2Dk0hnQzVMk1WC4Z6RWWAMaT5gbK2+mrcKuFR
         mgXonqUZIrIy8/XTA7sPTFxzlzf5XbnoOotdKX1F0kW3PSKSCdjjFhmYqzOvUex60LBn
         efiJTOeGDaul+QlfczCOKYb6hRUKZZBk6I/FpCIo1UQ8FDv3bMJCbBBSVux3AfTLb7Q0
         fZi4uEFuGbOgZE2I4eO2WkP7mdg9MzMAuiXUYPTbyChZ9VlNnBYxftpXiT1K0w/pyq7e
         v6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709618926; x=1710223726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5V8y3dySFl8kdmMCLan3vQixGPkJBiAZiaFJHDPmSXw=;
        b=osLrhkIhoTrBYJKfImOKM2vzlatgvpXbLz828m1KXUUZNExKhZHeLn2f6rkDjvCKYs
         JczgiL4OzorqySwCR8UbQwerPwoZOevAeWcBCtYRSw3q79o4WMSAoDKAIEuK4jZmpvTb
         rNOGQXTspUtefKYgfkGGYQpODov6awHZQ4qjFEEpKdMyhxK2CMLWSeRyORdMXvgRuYPQ
         Uaee/rZR2yqOWAr5KJxLfe5+vatk+jiNlrE8bIX4yLqXZXZjsx5zMt3bNRFYJYC1863C
         vqrRIrKiSEtqPWFkyagJ+/JPWX4ZPXdB8PEGnkxdzNXWBn3l3Z4rMTxfl+oyTX8yO0vR
         MFIw==
X-Forwarded-Encrypted: i=1; AJvYcCWpJYIp2nePeW1Cl5dW2WbClPycnV7FyxSso6R/Yg4pCgpijHVv4zJOu9ssMzv+t1NG16Wcn6GvzGivJas6q9HSzJNl2PLQ0ljH8ELG
X-Gm-Message-State: AOJu0Yy0NuqMK7hgtby6RcMzoIw7U/ETMUHxeS/Vr8l95EVacVUAYe4S
	/LNejdE81hyYocnkAQbfjxwHdrXHEJYzjCA9M/W1yDGfa77KBqj9IUkyznDHGw==
X-Google-Smtp-Source: AGHT+IGOEpXZTnOK5iI6B5DC1+LZXkbdTDnSB+eSncz2xsnVcoJBCg72j+iep0MPpUIqYZuf2r80xA==
X-Received: by 2002:a17:90a:a89:b0:29b:2c47:37d5 with SMTP id 9-20020a17090a0a8900b0029b2c4737d5mr2169834pjw.13.1709618926532;
        Mon, 04 Mar 2024 22:08:46 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b001d7057c2fbasm9601708plg.100.2024.03.04.22.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 22:08:45 -0800 (PST)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	Robert O'Callahan <robert@ocallahan.org>,
	linux-kernel@vger.kernel.org,
	Ian Rodgers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/2] perf/ring_buffer: Trigger IO signals for watermark wakeups
Date: Mon,  4 Mar 2024 22:08:42 -0800
Message-Id: <20240305060844.9499-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_output_wakeup() already marks the perf event fd available for polling.
Add code to trigger IO signals with FASYNC too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 include/linux/perf_event.h  | 8 ++++++++
 kernel/events/core.c        | 8 --------
 kernel/events/ring_buffer.c | 3 +++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c8bd5bb6610c..c077968d7e52 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1914,4 +1914,12 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
+{
+	/* only the parent has fasync state */
+	if (event->parent)
+		event = event->parent;
+	return &event->fasync;
+}
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a329bec42c4d..36b5fbdf8e6e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6684,14 +6684,6 @@ static const struct file_operations perf_fops = {
  * to user-space before waking everybody up.
  */
 
-static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
-{
-	/* only the parent has fasync state */
-	if (event->parent)
-		event = event->parent;
-	return &event->fasync;
-}
-
 void perf_event_wakeup(struct perf_event *event)
 {
 	ring_buffer_wakeup(event);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 60ed43d1c29e..033e54bb5c62 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -22,6 +22,9 @@ static void perf_output_wakeup(struct perf_output_handle *handle)
 	atomic_set(&handle->rb->poll, EPOLLIN);
 
 	handle->event->pending_wakeup = 1;
+	if (*perf_event_fasync(handle->event) && !handle->event->pending_kill)
+		handle->event->pending_kill = POLL_IN;
+
 	irq_work_queue(&handle->event->pending_irq);
 }
 
-- 
2.34.1


