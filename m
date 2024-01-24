Return-Path: <linux-kernel+bounces-36429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F1883A09C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA7D1F2D5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E710CF9E4;
	Wed, 24 Jan 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2h5VVtCi"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEAC8D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070628; cv=none; b=IIv4czOrB/w/2jrs4aS59/tXBjfv0LcLVE4/fPZckMNaA1eemLWk9WxxZLOVrJoHVuDrG07p8sOWaj3WXvZA7zf/wQvcS4aFLhbuwXs9nZ6uTSZTLADEzQ6fs0mNiyD5Uh1ZEiv0czrUxD+xMidnkt7PsiyiIsGAC/E+rw56Gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070628; c=relaxed/simple;
	bh=wAPN92LmutrG1J7tODQK7l+NELlZtviSaofT8hDTZX8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qqDn/i8di4BuHqO0ehuDjTBpv5RiV9hpTVEIoST6tdprjkzGPYOIf6hQn1+CssP8E1MR7GAOEWrm+sJljeLG3IX0UC7YN8IM6O3TyLj5/Jdh3g+xN6OcL9Z4sie/BqaZ/+TqffpZ/od2qRQjy11sMzRCEMaQ0E5J1s3pa3LQo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2h5VVtCi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e8d2c6903dso93622327b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706070626; x=1706675426; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZ4oZgP0u854CsY5ow/oTQ92HkoqG8y7HxBbY77RLxY=;
        b=2h5VVtCikY8ahjW8YJ56VzXPTIRlujumIx4cYrX7gyOhzHAEL6/IouAoZF4kSrDmc7
         NMV53qNIBrOmw+MPnnJqJHDq41hxr4RV4ut/JJPXWASFjD3rNV/DVM7QK9csL9JP/pFy
         lJI6FUYJOALsN8LIRp7kzzh4vsKm5LelvmzKMs0LL8AzeZ9XqQm5LHKm9yQ4x4FWJbp4
         KspVg83i27ebyk1Q4ssFW7FVTOFGOJYHEaPwPga8pC5snnwa6Tnmhin/G7B+QGzMcsUi
         iBizrhjsUifySqMMG8SMsFgoOpCo6TC+iZ8EeFs2w2A79t7pOkq9sahFhFgBHWaZpPPp
         GRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070626; x=1706675426;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ4oZgP0u854CsY5ow/oTQ92HkoqG8y7HxBbY77RLxY=;
        b=VmLzkCYoMMn11dZiQQ2zlj9bNCag+d1DLa6+xt0Tdh96S2CAuUeEkSsFiZ7jxN0IKd
         7R5f9OKze3eaZ3ANOCVrnZZcSsKV79KRilXl8eVi4zEXYDu9r2gB9+B16nLfxK8TZF+I
         ZYgQVOzOTEzQb6toP5+gY8uuz0HpIA7Y3XAaSoCu+oZKOGiLYavcjg+W02jWDpI4u31y
         O48XTeg2tc0v3PrMHxPs/KJ5xCx4yZ/XOzXKOH1YDikDyG12cs8vb617g1yqeSfNHtaB
         pisXFKaZojnGVwaeAQ2ZSPjPgCs+4zIYor/gHMqGjAK4CwfM8+8PFLQmO2Dy03gvf9BE
         deTw==
X-Gm-Message-State: AOJu0YwsP1VYjhKtmC7DT6esW7O22yRChrtTQ2+aqhlPY5FeMJV6jaaP
	Z10X57L/AKRf3dJAaYCXCeiiShZdTs50jSBdxJvABPci/JBCDtlFtvRzKyNiRxfAvkEPHIj3tnI
	rYQxu3g==
X-Google-Smtp-Source: AGHT+IGz1evaAtu5wd1hbGCCuNwF5lnKKQm7avVw1zbNQRovesO9EjIJpUKhNkORobP3DGp98F/q3jJTkbX3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a81:57d8:0:b0:5ff:9315:7579 with SMTP id
 l207-20020a8157d8000000b005ff93157579mr142336ywb.6.1706070625900; Tue, 23 Jan
 2024 20:30:25 -0800 (PST)
Date: Tue, 23 Jan 2024 20:30:13 -0800
In-Reply-To: <20240124043015.1388867-1-irogers@google.com>
Message-Id: <20240124043015.1388867-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124043015.1388867-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 3/5] perf test: Workaround debug output in list test
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

Write the json output to a specific file to avoid debug output
breaking it.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/list.sh | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
index 22b004f2b23e..8a868ae64560 100755
--- a/tools/perf/tests/shell/list.sh
+++ b/tools/perf/tests/shell/list.sh
@@ -3,17 +3,32 @@
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-err=0
 
 shelldir=$(dirname "$0")
 # shellcheck source=lib/setup_python.sh
 . "${shelldir}"/lib/setup_python.sh
 
+list_output=$(mktemp /tmp/__perf_test.list_output.json.XXXXX)
+
+cleanup() {
+  rm -f "${list_output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
 test_list_json() {
   echo "Json output test"
-  perf list -j | $PYTHON -m json.tool
+  perf list -j -o "${list_output}"
+  $PYTHON -m json.tool "${list_output}"
   echo "Json output test [Success]"
 }
 
 test_list_json
-exit $err
+cleanup
+exit 0
-- 
2.43.0.429.g432eaa2c6b-goog


