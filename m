Return-Path: <linux-kernel+bounces-144596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E5C8A4839
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A524C2812F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB62E851;
	Mon, 15 Apr 2024 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIECwNHa"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4FE2CCB4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163004; cv=none; b=ZwmDFD/uCYnRLhNesPXpc0m8NSmBpVh+UP/ZttjYWibwATQk4OW97lRfMqf69Etz4ARcLnHQEmG6BnFf2lcqQqLOuIbU1HTDeG6wqua+s3vF85CPdwDr0bCEBluNwJJL5AGTqmpaHILWY2AdhrfLld/Nrf4vAtJJSzQEaLs1Xws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163004; c=relaxed/simple;
	bh=jUPnR8Eh1nwHTyI5wvU5SHFzAhN1eHw5S1/Bwquryzg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MhumaudpRG4j6ELdh15Vw9lwQa76vkgjv9QTnQhBabnHyKc1rxbfvqth9RJeqq35VSkw7LJDYnkoNf6z5/0P8yZa9zITFV1i3ewYKvW5HCa+tlKgUJwP4AtSXsStL8seJ7Nr4+8sq0dR3/PyQo6I8s2RxTOsfsM1bnvADa5Whv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIECwNHa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64f63d768so5174062276.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163002; x=1713767802; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJgB8sDKrPml3/XRc3D6gD41xE7ASJL2MP2+Oe/niCE=;
        b=SIECwNHaQmrpfZYnKBB0Ly/Gf8P0kSq0pb5NqjFquI20T7ff8+tTuLTLthb/WZTpLU
         Ri0Vv9K6st0zdgz9XT4lUth6FmBgSxjy+iPE3VXoFqYfi+O/GVsU4WESbmRnB83EBmoP
         yaL+sfQREnEBLVomS9AXYEH3bgP6zqUaIsQTDfOXMC+EGSNTMco4lr+oRx+g00dVVHEg
         rdoPptK3UTggcUEE1kyiFYyf/BFzf8uXwcCW6I0wkRFuOC2XQmb8NMxu4ij5bz76Z2mX
         38CNIHG3UIvrp6cBAdzP7rtazn9Tq67DG9ORLiCP3rd0XdgFKE7yVrjb5h2URXeCHb6S
         2wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163002; x=1713767802;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJgB8sDKrPml3/XRc3D6gD41xE7ASJL2MP2+Oe/niCE=;
        b=mGiVzA18QeGK4wF/VAxpUz3+VhVHWU2MxCyaZkauP4Aos87DfgF5lUBnm4g+cr7Uia
         ZS3ntreF512RvqwVQtZyUENj9DO1stDRKUW5DCmfcQjHIDRGcWNB/VD2o+PxK3FUKFke
         LCwroNslDtSO8fkIXaC+UVVqz9ml82S7EgGIeqrm8AQMclBwMquY3YDNOUdW1Jwt1LrD
         nDIx6Asa5xvRvDzgZBQ3LkxlTUWE46KRhQ7mC8zHH39KAp3Nl+AlOzOtutEmkWVA9pXI
         uQKXLp6JwgWs6beJ3ZoqVP3H2DWKtV2yIT9HawbIw+ECF6ftO4yIHC+YSTHJZBIATTdD
         egWw==
X-Forwarded-Encrypted: i=1; AJvYcCWWQoLFsOn9zyfT4YqBPxCqRYRhvm18MVi6aE+6UPpHwPlspW9ysDrVBJEI/9hui9Em1z1+xv41PyPynue8hUiNVWvc7NWKukHy0+JN
X-Gm-Message-State: AOJu0YwV60Yrj3zDcjJ2YHn7i9n5+VuBgBh4MANBg3uWAp6iYDpSuSp6
	E8zhY2MzixogSpB+m/jVvUeTEV5OMw50jdHgWOVLBkSMjSCxp3a4fTvMiW8F5Bo4sNT2gENInWW
	ZTOXRyA==
X-Google-Smtp-Source: AGHT+IEiiZuVjgyhNgTTLyZ6Sh7UYfcc0UNFuJ2n/bK+2GCusGz73ratukmMFcwYpUzQY+G7b8Ltwey08z2j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:6902:1549:b0:dc6:dfd9:d431 with SMTP
 id r9-20020a056902154900b00dc6dfd9d431mr2983520ybu.1.1713163002294; Sun, 14
 Apr 2024 23:36:42 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:22 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 5/9] perf tests parse-events: Use branches rather than cache-references
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Switch from cache-references to branches in test as Intel has a sysfs
event for cache-references and changing the priority for sysfs over
legacy causes the test to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0b70451451b3..993e482f094c 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -942,8 +942,8 @@ static int test__group2(struct evlist *evlist)
 			continue;
 		}
 		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
-		    test_config(evsel, PERF_COUNT_HW_CACHE_REFERENCES)) {
-			/* cache-references + :u modifier */
+		    test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS)) {
+			/* branches + :u modifier */
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -2032,7 +2032,7 @@ static const struct evlist_test test__events[] = {
 		/* 8 */
 	},
 	{
-		.name  = "{faults:k,cache-references}:u,cycles:k",
+		.name  = "{faults:k,branches}:u,cycles:k",
 		.check = test__group2,
 		/* 9 */
 	},
-- 
2.44.0.683.g7961c838ac-goog


