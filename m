Return-Path: <linux-kernel+bounces-36427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D235183A09A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DB1283803
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA9AE55E;
	Wed, 24 Jan 2024 04:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKwuifcd"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2C7C8D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070623; cv=none; b=OTjSxqvcrds1hwL+bIDFn3p0xBdFJ5GpVNprOGaWP/jsSDpN/MxK5e3WFDeRT2/hVkBy6sIlXCpL6hQrCcF22IGgXCdedL2qBSUH9eSFeaj6tDSVsoQTsiBEQf+bHxuyTPhBq6XS/w8tHrJEYZn0m3ECTDOwwzW43HpSARkHPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070623; c=relaxed/simple;
	bh=Vi/GfW1dMQPoGBuKzYbsciwSwEbn5gukZ6R2a6MtY+w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Eqph+cR3psER+fHjSdFcmh56CVkUP17Non6dTamOyG66vc8rz5xdsF80Gpnf0YooWXukHF4Uc8OR36i+q3g6bufIGb7gFyCMuDbymFgppSpFY7ysx3vVpH5Fbsd7EUPoOAekOf/hXD0n30Ce22MJ1EpPnCS9dZe9Tdd2KkqswsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKwuifcd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f0fd486b9aso63562927b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706070621; x=1706675421; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGesi/lkn/z+ibscMuM5m5HKI16hb6v/aTcwmpsw9TE=;
        b=ZKwuifcd1sXYBpwthPqpMbGMO0e41n7mnUDZ2amFZvyquT1643vj4e4rrBRmICD3vK
         zXPU0gkOW6zZ7jAOShcWzT3B4jFEXUBMkQJ5oel7Tz5ZL6qbOE8SND+b6AEHI437NVxD
         quMteipk7AdAobMNh1lpnLFXMIZip9ztVhu067S4OyeCSYl4v3Ow0kfj8fYGPUq4jn8k
         tZJtINh6MhGnoeiuP0cGgsza2U+D/aMyRfmpL5+IrGrzbBkV5PgitNUrIceusAiKLawy
         St9+YX+ruz1/jqUvHxGf8mvymMecdQWVmCjz/6oW1F80rw9S6FTJgMWfnA/GpW3juacB
         a9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070621; x=1706675421;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGesi/lkn/z+ibscMuM5m5HKI16hb6v/aTcwmpsw9TE=;
        b=LqkF4VNDcYySPC6ujHQIxxn+iNd3FN4ymxBGHElGPP93NaJsT6GJkcJRwOHclvItdh
         lItHMGiv07gdKo9fHxwH8lU3KSKaQ1GUSZPOsLqLDEvgHl/Fl4H86iOSxQoB9JBxdZcv
         OxiWF9uBRh0gkaFd7r2gX+OP+UXFOqnOMzhbSZoZWm+FHjcUguOcviJtLncl7GJFEQC5
         c6E73z2AulPUTJ8XmJNYb28vRDso4lD+k+8FAoNMR+ARjNYJGvyvFU3pVb+PmErdPTEU
         yV/eF5YnAqny2D6meEjg1DQu/QLn3CxYqGzayIksunH7fqhn1MIRs2DeVjrFgJ7jX8hw
         EXrg==
X-Gm-Message-State: AOJu0YwKinBzuNPy/FMkCnIWvfY/1QKUcRSZTFZ18F02IfVhT5hP8uKI
	+j6wDCKPhSqzUU43x0xADf4sYydMu09QIkcKPCJr6Tbh6M5HTbZCfFFlhqbtp+/+91Lb3S8qWNR
	6xONoWA==
X-Google-Smtp-Source: AGHT+IFuyLICJEIzRyi+Jplw1i4utF9oYp3mAPPTFQaHlqHi3G4RBhbpQUYe7uRk+csKQHqIDFE1YEy6OGoA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a81:99d6:0:b0:5e6:1070:44e0 with SMTP id
 q205-20020a8199d6000000b005e6107044e0mr74539ywg.5.1706070621186; Tue, 23 Jan
 2024 20:30:21 -0800 (PST)
Date: Tue, 23 Jan 2024 20:30:11 -0800
In-Reply-To: <20240124043015.1388867-1-irogers@google.com>
Message-Id: <20240124043015.1388867-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124043015.1388867-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 1/5] perf list: Switch error message to pr_err
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Using printf can interrupt perf list output, use pr_err which can
respect debug settings and the debug file.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/print-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index b0fc48be623f..9e47712507cc 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -66,7 +66,7 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 
 	put_tracing_file(events_path);
 	if (events_fd < 0) {
-		printf("Error: failed to open tracing events directory\n");
+		pr_err("Error: failed to open tracing events directory\n");
 		return;
 	}
 
-- 
2.43.0.429.g432eaa2c6b-goog


