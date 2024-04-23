Return-Path: <linux-kernel+bounces-154443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DB8ADC25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8E0B23345
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9DE1C68C;
	Tue, 23 Apr 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljCMgLmS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7441947D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842262; cv=none; b=k9sz5QVoajXlvJKrQgMlOuse+gISwMBi5uJJF5SHJI4z1VEyBUL7dGI454G4ZMWg56fRjh2fDXnCB/fcSg96Jiu6dabKQXQVfytXoLhMYxNbBG/qsJJYZGPsv4cEVeL6/xVxt4lGKCcn9Lb1Rcn3p1e4fiPfRq1WUTLTe7g9dqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842262; c=relaxed/simple;
	bh=BSADm/2St2RzD/ArABRW7n8F/sOX5AJupKxZq1RwerQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UOyKIo/Y5EoJVUYIIG00JFtoiaixMwHj3MMbhDrfyGQs97/Y+vLBn8+zwl6M97KD/wnB+I2+VHrpvoS41YeR7dTk2030PB9BhhdJz4GlZXURxUeVTJuYrmgktX5ru6qVe1FdCsX4kw/wqmMvUTICSZ5zHaHkB844nXM0/IrGGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljCMgLmS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so7502716276.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713842260; x=1714447060; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guh8O4YIfp8ysMStU/pCY+FOTLUwi/avvI0eH709Ct4=;
        b=ljCMgLmSKJWJ3oiuM/Ovfz+TKBKLYxXMST8ri1svbmCwhAfFFvh672zbEfbl0Vuklc
         Jv90OsYiOQAsO0vQ2Aq0M3PIzfKyzwuK85j9dsvZzQPmTXqpCIqSvJOHNq+SxGSO00Ed
         zIJUC4exy/gjgO/4R7d/mDVtlYtg5L7F80jIBHg1s3i8b8CaOk31XLBfkj+PIfpPRZdL
         qP/zQFME4Q16wgz5YWWJmWvgjuGRpISIOKJ6dmdl2HZ53uJApSrgYiQ4aB8ZYZS9ZhbW
         BXgMEe0tJDmYmvFLgTcwVThdMtDS1gv8nJ8DdGIcfz6Y0uaNzk4ce43sb90Y7Feb7dYu
         ufBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842260; x=1714447060;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guh8O4YIfp8ysMStU/pCY+FOTLUwi/avvI0eH709Ct4=;
        b=Vyn+b4X/Akf2yBNaPDS+OEGbI1U4Ish9WErJeKbx1+H0Hl1Wv4b8OC+m8vApxg7zjT
         qz9j3gMTCuBFJbbFSxR6lq9uJbqw6HeTxz0OsweTYojNAJx8xKpFntBfwk4exHmrqT7u
         AnGSdx5+7N2lkRrFtLoMbitMWOIkWWAxT/r5ohH8baaClcJLi/DGXCfTwOGx8RGTVaYJ
         2AYVoBwyxlk6Q2vMant93sJOElfXXMyfY0Kji3VoWvkQFJXfeWJfmQJWOJJkdII0MqJg
         UeDd1T5c4uDQk+t+IyQeD3vLVoGDYT+nSUmh+l/zSkjDfq79dRoCUzMghLbl5deDSlsr
         1sJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnDqUEAjGY7zW5qlJBuMPP/5rxXfBxkCKXtj8rCzGwFeZgyFOTLGP6561xsTjhDycb7MwE9a1dSnCNNsUqJh1hTmTDj7MYaUeQjQfb
X-Gm-Message-State: AOJu0Yxx3vsq0QOyUpSMalWs0ZLjBfwrAeky4qtlrfSkuh5Y506bjg09
	71YvykKUbdio0hkuD1BPce8L1kUl+Ck/A6+Ip0bBsPOgaALt1IibqpOLwBw68dyLl7ygrEYGC7F
	1Q3bK7A==
X-Google-Smtp-Source: AGHT+IHGKH5+IAFSPrKbSp7HCOUltahfcSA++mKCgkd0vEejKdeJCozwx75DouGBXip/RJvJe4uKwmLEJFd5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a05:6902:c04:b0:de5:3003:4b64 with SMTP id
 fs4-20020a0569020c0400b00de530034b64mr386604ybb.1.1713842260251; Mon, 22 Apr
 2024 20:17:40 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:17:14 -0700
In-Reply-To: <20240423031719.1941141-1-irogers@google.com>
Message-Id: <20240423031719.1941141-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423031719.1941141-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v2 1/6] perf test pmu-events: Make it clearer that pmu-events
 tests json events
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add json to the test name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 47a7c3277540..7b2c34462fcb 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -1105,6 +1105,6 @@ static struct test_case pmu_events_tests[] = {
 };
 
 struct test_suite suite__pmu_events = {
-	.desc = "PMU events",
+	.desc = "PMU json event tests",
 	.test_cases = pmu_events_tests,
 };
-- 
2.44.0.769.g3c40516874-goog


