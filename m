Return-Path: <linux-kernel+bounces-47613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771284503E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35A3B226B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDC740BE7;
	Thu,  1 Feb 2024 04:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gaf4U68S"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF73B199
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761386; cv=none; b=uzuUSBS+FO+p4SZ5eWz+BbxWYTZoUeXUq4Mh6/CzLS7+weRSIExecS0UdK9/EQuFM1w73T14t0vXDvojQCDEDETkQDsLPulx4ADl1OahWA1OGMIEl4RNWpA9CIGhM1m3YeczqNxZ5u+DrQUUQQ4vI6TID9/zCdsFiDCLd+vMq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761386; c=relaxed/simple;
	bh=muMEVPjwxm6q3RlQ95/IKAyqTZstFA5meu7x6+UUwZg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Az3M5OnLQgya7kipYH9hoVBtHQPM7LJElzk9HTue4Xv8XD8Q1ZZUuiMbbBdApxHEAQBpfUIpZfFjtb6X7RqjlAFJA/b2uQElu83pAgseaKQG9C5u8wXkn4wz8VOzKEl4/xLX0YkYlMR+Y661v/4MzAL3HcM4iwI0UeRwChQtoYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gaf4U68S; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60405c0c9b0so12941867b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706761383; x=1707366183; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrRDV2OgW3nzJBdkuc2LAITTVB+J1bOMfWE+IFXHyeo=;
        b=Gaf4U68Sz9/QKPH9L2e8HKiqhb471OZd3yjy6feCZpg9lE2I+Yt0vV9fLFE8L5pz0g
         SnsBNITjMtVa0Dy29qhlXpe+rqk8okRPuUOPpAujU8j41N4yVTrr4+JIOyNLYVvbQzUP
         ERAtrSojrsORooiW7q9dVbSk84BC9b2yt11QfzpCJdMny8CIW/4/zQqQM7X5C3QtCvU8
         oPdHkjFXcm7jPXTI338Tz/Gwo2ulzdtm//QYmEYE1OGL1bB7DSZAilcNzFqz2sSOII/h
         7CANjNTdk+bQg46pELw7fpwayHHvs/ROmVsbkwzo3cAQTfLG8/+T2G+b2ivr3nmp1HA+
         5gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706761383; x=1707366183;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrRDV2OgW3nzJBdkuc2LAITTVB+J1bOMfWE+IFXHyeo=;
        b=ZrkwLt6cGZ+1CKz4x9TO9BP7fDkgKINsU5cHWEoQvox76AfGpSfZGhnqpR5XeSFIPN
         k9e1OGCkFqTGvvAVaTxNlJXcNCk6gF1eM2mGtSH8qn0RP99aRsW92qdQEvtV6vcElh87
         76Rbh5w1D9Ynw674neIK1gf0aViaNLf6+8nUvrbh5twTF3Vd+kq7ZIP2aOWz9pzFulx+
         3jvCrE6ImNTj8yq7pMOJfXL4UToIl/2k1xXXhYvXr9hNVgA+dFoA0Yh2xjjPx7Pz7Mpd
         cNVtOKfblD8QfOF8BnJs3OhSbLU6KqvFFJ46i8bsp+FBM2akVRAItQRtQJIlv8WH4trT
         iDig==
X-Gm-Message-State: AOJu0YwCYdDVcInJTQpjR0/a/AFca1uBA7j8RltDeOZMjX6Gry9lRZVh
	+B+ckvDwVVLS/BHyQ1H8vdrhF4nKhqGA3LWp3/AueZ5NNNus9Snwacylbg+ciFJZogDVfUX/TZX
	lgu1xfg==
X-Google-Smtp-Source: AGHT+IHv2O8VUbbF42oYcEoSvj2zyIzzBYr0IR+xIhh6JLaWfzzkVzgzvhvYusGBJ3wuD/mw4QrkRZGlA0nR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a81:57ca:0:b0:5ff:5866:bc37 with SMTP id
 l193-20020a8157ca000000b005ff5866bc37mr830069ywb.3.1706761383514; Wed, 31 Jan
 2024 20:23:03 -0800 (PST)
Date: Wed, 31 Jan 2024 20:22:34 -0800
In-Reply-To: <20240201042236.1538928-1-irogers@google.com>
Message-Id: <20240201042236.1538928-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201042236.1538928-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 6/8] perf arm64 header: Remove unnecessary CPU map get and put
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In both cases the CPU map is known owned by either the caller or a
PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/header.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 97037499152e..a9de0b5187dd 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -25,8 +25,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 	if (!sysfs || sz < MIDR_SIZE)
 		return EINVAL;
 
-	cpus = perf_cpu_map__get(cpus);
-
 	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
 		char path[PATH_MAX];
 		FILE *file;
@@ -51,7 +49,6 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
 		break;
 	}
 
-	perf_cpu_map__put(cpus);
 	return ret;
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


