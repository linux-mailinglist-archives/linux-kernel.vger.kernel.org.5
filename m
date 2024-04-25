Return-Path: <linux-kernel+bounces-159297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C19A8B2CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F0A1F2A07F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACEE176FDB;
	Thu, 25 Apr 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwC3JTSG"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144D175562
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082715; cv=none; b=mT2R/To3Kevys51Ge3IE0jQvyL4ZqlVZa4dh4n+JmifXj1SwvcnEhiMMMfbkiivfBeHkMGHh96A70Fr8Y/Pa5clapF+gTOQMyj1bEMSI+SaKBUhwtkA3LjzIbFhCCdkSYOih/z1M3O2kS1QdZWHAGxx9bGY6eh5ACcMrhDrwywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082715; c=relaxed/simple;
	bh=W25+yILfHx9cXQCv3wX2OvycXnIRZUSZb4Hv7dyII64=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L/jY/Roh0MN/xMfQ3kuHoZPDmr+zWUD92igJDOk6oMQT5MkCkBwSs6rJH5Z9B9nQlS1SaEWf+6KGfZL97/u0QzaFZwJbBXkWSMJJ0Q2idTInPIMhAKW70F674GU/WcB8LVgU5l4B8IeolaI2wqLHLmowUjwrgxpw94qTrd6Kg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwC3JTSG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6156b93c768so27156507b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714082713; x=1714687513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qcaXVQm7LCKx33Z9bMfhR6q1MTnTq6iFanOK7BRu6Ak=;
        b=dwC3JTSGZS33OxIsD8n4H/zVXWx2LJ9Q9PH/AuUD2eyQY7I0zmqi+dh+BPVFhRZZcq
         0Tsx5R8SwrPmmEqNEKe4n7MIa7THwnrlsFFnOFCriL7wwqnCbvSnYX+Hs1bKBOCl+Hs9
         K+Ii5x1JLXrv8Vb6ZFLCCxfXuhI2a4VOEG4N+WaGIDc4Vv74aI75YkwTwYgQ+Q6JEKab
         UMs7XhNeHft5OBp0EZvGJywYMN5ZT7EXIuOlE+tUpk2kXYR3qZjvSpTSLzTNR/6VUukc
         0ZHozhBqEyDI/ZCA37lEjvwXfx8YD3e2c+0rnF646chQSpAP4cCqQPLeePQThvtugdw4
         J8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082713; x=1714687513;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcaXVQm7LCKx33Z9bMfhR6q1MTnTq6iFanOK7BRu6Ak=;
        b=gkS3GEmor6x6ritvwATgfDVF5QijOvzYFOaozeOJgT4qQmJ+ahdtRGnTC4oXdhaVyp
         HQE6OwFk7zLmLn7FslahxoTznHBgWNP24GA7fVr1jlr+0Q5pjIfaevOGVEig2F55Auc2
         HDQ5afzuQqRv3TAI5Q/gx43IYGkIsdOEzpVHN1botjtASo92FjsS86GKQUyixtFB7qaQ
         zFWSll8huzLvJSQRKBpY1yXlsNw97VWxTaisR2ZEBoHfAy/i2ZtRaiNk84rxFMET98oq
         bIUlIko0i2RKsoZzWa0Xht0ZCe0axtA53PAy/p9Y2EER5yXII1uF4hrs/DITAb+NMiDC
         oOgw==
X-Forwarded-Encrypted: i=1; AJvYcCWQlWs2tYmP0RhDT8wV3TkcnR2Avobs4doz8eRsG0Qahu841zuE0CxRy1zuozT1M1lxKlZQaXoUQsUnKJHs1HP3+XaORMWwiiJ84OcF
X-Gm-Message-State: AOJu0YwRVXY8HUPQjXj4bFWh4sGtCkniVJd8T6gFUBz0tSUO6j1IgdFu
	XRkcyuZJvJecMyyEiOymEyohvZD4ZJEmTHQYmvn75oXMGNgap/eAg+iclWcyRxu5XT5j3aWXynn
	1
X-Google-Smtp-Source: AGHT+IGfIbmFsEwmFhyZU9NYy8jBN5kODQgCvl1EUXhUfJCXDGd+jb9kPgFMgTYB5Bio4WYcTkJpszvc0RI=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:b177:fe3c:94d3:f359])
 (user=yabinc job=sendgmr) by 2002:a05:6902:1549:b0:de5:1f88:ae4e with SMTP id
 r9-20020a056902154900b00de51f88ae4emr270433ybu.2.1714082713376; Thu, 25 Apr
 2024 15:05:13 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:05:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425220509.1751260-1-yabinc@google.com>
Subject: [PATCH] perf/core: Trim dyn_size if raw data is absent
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, perf_tp_event() always allocates space for raw sample data,
even when the PERF_SAMPLE_RAW flag is not set. This leads to unused
spaces within generated sample records.

This patch reduces dyn_size when PERF_SAMPLE_RAW is not present,
ensuring sample records use only the necessary amount of space.

Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper")
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..d68ecdc264d3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7688,6 +7688,10 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		data->raw = NULL;
 		data->dyn_size += sizeof(u64);
 		data->sample_flags |= PERF_SAMPLE_RAW;
+	} else if ((data->sample_flags & ~sample_type) & PERF_SAMPLE_RAW) {
+		data->dyn_size -= data->raw->size + sizeof(u32);
+		data->raw = NULL;
+		data->sample_flags &= ~PERF_SAMPLE_RAW;
 	}
 
 	if (filtered_sample_type & PERF_SAMPLE_BRANCH_STACK) {
-- 
2.44.0.769.g3c40516874-goog


