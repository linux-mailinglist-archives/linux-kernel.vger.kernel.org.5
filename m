Return-Path: <linux-kernel+bounces-21424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F46828EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBDF1C2314A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9253DBA6;
	Tue,  9 Jan 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGoUBh5m"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FB3DB88
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1434801a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836186; x=1705440986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOz0ul5eLLG1EnWl4tq9lX0YDnXeDhj2Cx7kAjJRFmk=;
        b=dGoUBh5mYQxqDMyZVD7ybz5sLuXmdZgY7Fu9ANMC6haJAcd6mq7tajD6bG78VvhaF8
         GOn4xaV03AU7pO/Irk0E5kAVm311/ymWgLUIdoLSVPI+l0EaHp4FcxUJil2PZ+U5SEuA
         dzDkP4zqAywHiC4Sr7XRTFoeIh89hRlnJbsv5bqebW4LxGNCn678gecXsUDu06KY9xbT
         evzqhdHKrj+/qwGPlHN0W5gNWe9JA1zT7uxQ3GS27PeWvP1Iq1ykaz+3sKo4ZmO7Cf6l
         MCjRtcyhc8j5F3wCKrUE7mamggQs1y3oMkbdd4XXc93jPyIHMU5VdeRJsI3l/ms3CMyd
         BOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836186; x=1705440986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOz0ul5eLLG1EnWl4tq9lX0YDnXeDhj2Cx7kAjJRFmk=;
        b=g3zCaSXQfGu2o5LBFZhUtUZbiPBLczQyLuHZozJ1IEQapbeSOBxifAHBzv20ybaXk+
         u8RnSUsCPwmp3GJPqO/YNTUgFG/RJRYuRjufsdsT/uvsB8hCxGvtYQcwOSA9taNLZ/py
         pqsm4G7Xd0TwjVU9b33iYzb94y+35J1XF/n9pkdyNzkedyApm7qU0MuOWqaMfNVaK90n
         dORTfb9y2gUmPEc/MDTKP5YsjNtGmvCqpiHbZ5vAVxSdjBjvWN8+T05Tf0XhWVsZisGm
         P2DhzJeEYJ0Eiio5c6Wz+W6WX1FWnTDoypVJ5/IV6LZVUZLQ2/wbuK+hreFx8M/5Myzu
         rfAA==
X-Gm-Message-State: AOJu0Yyh9ENScmG7TDPk+Ow3xr23sIp9Ss8EGcdMHKjpSWvqhzvIonux
	P/wELCFmuatbzpWYievtkGs=
X-Google-Smtp-Source: AGHT+IH6/RsT5Gw/Q//jEfOfEa2KOHYpoynk4r94Ig+ZFgCzK4jeBwlcSdtis9RC3shFVNJzPOKGEw==
X-Received: by 2002:a05:6a20:aa4:b0:199:9385:b783 with SMTP id b36-20020a056a200aa400b001999385b783mr2717087pzf.62.1704836185999;
        Tue, 09 Jan 2024 13:36:25 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:b4e:5c78:a5b3:ef5b])
        by smtp.gmail.com with ESMTPSA id bj2-20020a170902850200b001d55717179asm1957471plb.288.2024.01.09.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:36:25 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mingwei Zhang <mizhang@google.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RESEND 2/2] perf/core: Reduce PMU access to adjust sample freq
Date: Tue,  9 Jan 2024 13:36:23 -0800
Message-ID: <20240109213623.449371-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240109213623.449371-1-namhyung@kernel.org>
References: <20240109213623.449371-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For throttled events, it first starts the event and then stop
unnecessarily.  As it's already stopped, it can directly adjust
the frequency and then move on.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ce9db9dbfd4c..c80b6aa0e354 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4121,10 +4121,15 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (hwc->interrupts == MAX_INTERRUPTS) {
 			hwc->interrupts = 0;
 			perf_log_throttle(event, 1);
-			event->pmu->start(event, 0);
-		}
 
-		if (!event->attr.freq || !event->attr.sample_freq)
+			if (!event->attr.freq || !event->attr.sample_freq) {
+				delta = 0;
+				goto next;
+			}
+
+			if (event->hw.state & PERF_HES_STOPPED)
+				goto adjust;
+		} else if (!event->attr.freq || !event->attr.sample_freq)
 			continue;
 
 		/*
@@ -4132,6 +4137,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		 */
 		event->pmu->stop(event, PERF_EF_UPDATE);
 
+adjust:
 		now = local64_read(&event->count);
 		delta = now - hwc->freq_count_stamp;
 		hwc->freq_count_stamp = now;
@@ -4146,6 +4152,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (delta > 0)
 			perf_adjust_period(event, period, delta, false);
 
+next:
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
 	}
 }
-- 
2.43.0.472.g3155946c3a-goog


