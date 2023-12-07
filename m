Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39A9808DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjLGQfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjLGQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:35:06 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE4610F3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:35:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d05e4a94c3so9686255ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701966912; x=1702571712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXhJZgRGOB5Sycf3QWqHrD17iXmXG1N3cpy0e+e8qfo=;
        b=DMpiC/Hon0R+3JwN8VGCqbuqzpnpWSu5pqBmcD9KUHVsbS11Mi8u5NBERxWWg/lGEq
         wwplDbbfBd7ZotHqL9Hg5bQRfd6wrwiak0rirXKR3XiFEcaoYP4EjjynBVYyxq0N1wLR
         A8EfFRf8m1mZG2VjVsuGib2P1Kx6T69q3Yzi8xvS/rO4eg95ANSkwLA1RVEhyKp8pIao
         gXbWsYjentZeJ0hY7C3HjXFFTEr4Mn548jUcNbQFpvxrDYNkNH/Za0pFvlYD8cG63SAt
         G7QwGBh5XBhmGHtgp7Vs38ha4HQHOxbF8QCBHHTfcyyGLN/MZrYEHTJWyQc7/vy9mxr/
         GbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966912; x=1702571712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXhJZgRGOB5Sycf3QWqHrD17iXmXG1N3cpy0e+e8qfo=;
        b=YMU99r5wq0O+PkoFP34jy6mL91GTsIq8uUzSQRumHpbDwJNXTE+P0iHQ13q7UbZWEz
         Z03HZ9+E/jxH1OV9YjyOKA6YxAS1Q1BJe6Eu+5XebK54/4LKIYkyriZFwRsaZDA7EHiE
         vdZybYcLMjEJ4KZfxvM8/AoGm2TOmV+jqLVFxs7Jpy6jhHQN1EhPPbk7UFmVm2zB+qoJ
         eQNOHKhyiTpHntHx6heiyDOUFhKekFVAsyEsRXR1tgN1E/3YngQaBMz+CJpkDFiN/l8n
         6G8RDAYm8xarN2Lfv1bBkvMnHdWumPuquyYtNzqkNNfhb+qk5SNFXoNuxmiZDPZ/6LO2
         Crug==
X-Gm-Message-State: AOJu0YwTu7zYOo1NGXqcMPAfSX6PoKsNul2ynHNpkwRS2kEh54mtDIwY
        JYfli10R2k3jsOJ++zQvihZTQQ==
X-Google-Smtp-Source: AGHT+IHwJu6hYJPY1MxRyAcC09H7E2C4OK2vcYFScd3fqXrSpb+ZHHISC7s17+15XDaXO2CMHBPIPw==
X-Received: by 2002:a17:902:dacf:b0:1cf:c42c:cfbd with SMTP id q15-20020a170902dacf00b001cfc42ccfbdmr3656529plx.0.1701966912115;
        Thu, 07 Dec 2023 08:35:12 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001d1cd7e4acfsm6143plb.201.2023.12.07.08.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:35:11 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marco Elver <elver@google.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     Robert O'Callahan <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/3] perf: Reorder overflow handler ahead of event_limit/sigtrap
Date:   Thu,  7 Dec 2023 08:34:56 -0800
Message-Id: <20231207163458.5554-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207163458.5554-1-khuey@kylehuey.com>
References: <20231207163458.5554-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf subsystem already allows an overflow handler to clear pending_kill
to suppress a fasync signal (although nobody currently does this). Allow an
overflow handler to suppress the other visible side effects of an overflow,
namely event_limit accounting and SIGTRAP generation.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b704d83a28b2..19fddfc27a4a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9541,6 +9541,12 @@ static int __perf_event_overflow(struct perf_event *event,
 	 */
 
 	event->pending_kill = POLL_IN;
+
+	READ_ONCE(event->overflow_handler)(event, data, regs);
+
+	if (!event->pending_kill)
+		return ret;
+
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
@@ -9584,9 +9590,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
-
-	if (*perf_event_fasync(event) && event->pending_kill) {
+	if (*perf_event_fasync(event)) {
 		event->pending_wakeup = 1;
 		irq_work_queue(&event->pending_irq);
 	}
-- 
2.34.1

