Return-Path: <linux-kernel+bounces-47415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F5844DAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E128D9C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32F7259C;
	Thu,  1 Feb 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUbMionP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEBD1848
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746528; cv=none; b=IR+VDrEB/FmdCbdu5vKIQvqLhJX60c9tYZJtcjhOm2nSAJJfZWrxfejyYSzxhAhpMpPmwaMdAr7f1nR+golooeyNkOue/rQcUkRCWjDQFUVD2rKNx+erGy8j9nkGVbTtUsFpNUwmpnkDKdXAbia6b2fowoZWUVqTl6z2/VDTX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746528; c=relaxed/simple;
	bh=QRpCkX5OhiFVAf9wMaNKpBHKt1xJJ+6SZA8XPyhesEY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QyIJIyT/UGwjKqXTGiGVRXYu23JXg4j4TShlPad6Kz09+SOWhRVAmPL1GvqK/jhqFbMLrxId7XAIwaxmmLCwAbbNXmIPypNNZTbyCu6PLIwegjxQnRMpHSBzQNTAssw4qcO6lOnjIbNHijGm4MZWFx+KTRB0VXT8/GNR/5hDpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUbMionP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269b172so1982022276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746526; x=1707351326; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LQceo5LZaawmvLGjPJXI4UEv1n2dckt3DrjRuadtZ8=;
        b=OUbMionPdUueFuACGn/SYdbdUFsuVd3V7G+dNiYBLeKomxRjELs8P4v2Y8bJIBUEwM
         8Ivf6Cteqe13qhhWk92G0UV/ptuTcUZ1kygj3iNzC/p6TmZJN4oYF3zS8R0EedL2Jw6U
         5juRTchEw39kegM3VoQP1Kanihf4msAYOMnIHU05W+aJ1tRlxSP1TOQAzlD5LIBLp+D3
         xqC+CuYLu/PitSaLeC1yZG2o+h99uU4o8/L4mQLqbUKuvElePiFeLji/XNL9LA41fYrN
         jZW+yJU+/xGAe7fwB6t7Iv3SguO/tdcv8Ddcvh0zVikLVh9mxNYa0orzLfUS1exa2L80
         8Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746526; x=1707351326;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LQceo5LZaawmvLGjPJXI4UEv1n2dckt3DrjRuadtZ8=;
        b=MSAmhMWJc8Kz4qABVRzbuT1QUtHTARLS/w1YL6msDEzuz4v+SHxFnCGZN41k68AVtI
         oTucypSgRJFZJqtiQ52PLt6s5kZ2KDWSDQFvwfNXDP1sL+enSGCmIQH9wgtv5z9RnCH3
         +wfe6mHmoc8UsIX7Nsyjl6tBAlRnuAmVgck2GZdaNVD3v6TF8c4P6S2IAySHrDmS1LYV
         KHFnPO1ZTUDwfUgE8hiLgG8weuayH80ctCt7Qml65QTf4dRH9j+0APjXeOA79I5FHavc
         2Uqc0vg6/iMGPiB08WjLVZRtnGqaKLDG8wsT2NHHaPu8o2CJKi3roO8IOZZm6CV7Pal3
         BW0A==
X-Gm-Message-State: AOJu0Yx8NeUG4NqKkf318y1wabDWbxaVyNRLOlfjAbG9IGWbsXq80+p9
	o9v+sbAqxZSqRliTX04jH53q5JqzIvfKZipbUJpZ2uuHnGyaCXzHZsLYZ0gDp0/q4RbEtD+opJ0
	UYlU1Fg==
X-Google-Smtp-Source: AGHT+IGkcSdrvh1eVOyXefE7wqxHzsyE+LRzj7VdVg3SWOtaKEzHNjBSiBdZCUHM6S5SRjI90vPm5BkpRox9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a5b:803:0:b0:dc6:c9e8:8b0d with SMTP id
 x3-20020a5b0803000000b00dc6c9e88b0dmr446549ybp.1.1706746525831; Wed, 31 Jan
 2024 16:15:25 -0800 (PST)
Date: Wed, 31 Jan 2024 16:14:57 -0800
In-Reply-To: <20240201001504.1348511-1-irogers@google.com>
Message-Id: <20240201001504.1348511-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 3/9] perf tests: Avoid fork in perf_has_symbol test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

perf test -vv Symbols is used to indentify symbols within the perf
binary. Add the -F flag so that the test command doesn't fork the test
before running. This removes a little overhead.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/lib/perf_has_symbol.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/perf_has_symbol.sh b/tools/perf/tests/shell/lib/perf_has_symbol.sh
index 5d59c32ae3e7..561c93b75d77 100644
--- a/tools/perf/tests/shell/lib/perf_has_symbol.sh
+++ b/tools/perf/tests/shell/lib/perf_has_symbol.sh
@@ -3,7 +3,7 @@
 
 perf_has_symbol()
 {
-	if perf test -vv "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
+	if perf test -vv -F "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
 		echo "perf does have symbol '$1'"
 		return 0
 	fi
-- 
2.43.0.429.g432eaa2c6b-goog


