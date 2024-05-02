Return-Path: <linux-kernel+bounces-165951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A088B93BD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C51AB2224A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849071CAB3;
	Thu,  2 May 2024 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKjMP7fS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C71B966
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622495; cv=none; b=S35hNcAkrTo2F3+fIZkPUMkG7VdEDgCYIkKVLA8fPZuUx4JFo/EFIJTMIb+P74BjbVpBXchwgmNUzZEtkhus4VA8bPml2XDSrZ2lqIqeGYPVceup97zjZrZq10+F+DtrrvwFLmJaHW7QsHE1TAPK6dsNA43P1KH75Rac875ZNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622495; c=relaxed/simple;
	bh=01vMB1KAw5wjuORt+f71dP6s7wJwUTqpWCn3nJ5VDhk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=AvuBmdwhpXpl+yoe75VhuMhP+5R8EYObtgEkt1HX71YGFEBVe+HhbVy48mGp3H+wF8W0pYvdIJfCJYU15IYEeuYaIslxPj1mp3spPaIsirvIBxvVIkPQUb0ietJ7b+TcStzwc2y/zR97V48Q1EZVXNiAP2+CZvnG/jiTFlr9LLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKjMP7fS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54ccab44aso15392310276.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 21:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714622493; x=1715227293; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTAc4mAl8zd/O4NoKom13X8oEiD4EoCVZF5Gt5A9RVY=;
        b=SKjMP7fS62qF2LO38WyzqKzIqL/CLrMrPLrMHRAi3kLYurekiYTQqajFCxCM0W6RCR
         mU7o8s2e4SixEv8/qCdV8Rjhtw3MKMJKAH3MXCXGJj/GLxeMOiFAzUu1p7Shi6kkmngy
         0NswzalFaRaNlUqK3MPOM4CVqvvlJmzKnyJKdarWAgU8hsLiu8Kg8cNbTTcj1op4eTDt
         BhBJfawK+GJS8BTNEzM9Gtm0zhGwWLah4gYWe/aM3ZvpqNcGlciKDuNl9S6wzPT1GZXm
         ncvLTzMtPaimSqPqkvlvViQU0GJZ3L2kBkiu9geL88lqb5dZFrxCED6ViF2vRMvwj26c
         Cgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622493; x=1715227293;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTAc4mAl8zd/O4NoKom13X8oEiD4EoCVZF5Gt5A9RVY=;
        b=ceUiGg+fkfpTpJfalKQP8dp5urtswBJfLwQzWyBq6WisEVtjmi97zlCqGl2X2UG1H9
         hO242USq/uL4e/fXyF/1RjneM4DuM+aLmjepk13IuMWjf01R+Oukt4OhSQANDffSxZCd
         H5l+LqJCFkoimGs+7kGz+jtzbAc56sMdnoHEJ64EQN2qcrHsJuo+MzrqruPGTeQKwQOg
         k+vYOsyeqdqil/xx2s3fiQibqdxp2Cyrg1OOx19pCfAArlvrTWZ/sZGcl/++1D3ihN0f
         aUDPPDiZBOh1OiM29gidKN02WIvPV6+uNsAIzbwNuOoOWHDF6XQqfJ2+en9w/jF6xMhu
         CI4g==
X-Forwarded-Encrypted: i=1; AJvYcCXxGAcvM61H724uCkvNMJFqecgWedSS5tAtiih3E6kLzhYc5o1QmzAE2/Hw+hDOKSq3Ts3kVIn3Hx0/baHsEwO6VPfH9eAj128DqoA8
X-Gm-Message-State: AOJu0YxRWlu5ClAbPlF8ZfF6XmNH0W2NZsgnkT888a5+3RrLHGD7gFc4
	OdKl0xH3Oixt0gteOi0CERHIU16zK4CuAOPpk7osaf3cJLuPkOHolqr9M1AgOidnR2sAqfZdMcy
	Q1HEqSw==
X-Google-Smtp-Source: AGHT+IHery9aso1o+6JwiNEaTVoNE485WqWMxBoHyyVYKWymEIvRiBj05j1BTb66Gp07jSFp+uVsFpUuj+Nn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:53b9:bbda:1daa:17d3])
 (user=irogers job=sendgmr) by 2002:a25:6806:0:b0:de4:5ec1:57af with SMTP id
 d6-20020a256806000000b00de45ec157afmr221754ybc.10.1714622493557; Wed, 01 May
 2024 21:01:33 -0700 (PDT)
Date: Wed,  1 May 2024 21:01:07 -0700
In-Reply-To: <20240502040112.2111157-1-irogers@google.com>
Message-Id: <20240502040112.2111157-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502040112.2111157-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v4 1/6] perf test pmu-events: Make it clearer that pmu-events
 tests json events
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
2.45.0.rc0.197.gbae5840b3b-goog


