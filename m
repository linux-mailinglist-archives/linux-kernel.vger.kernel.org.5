Return-Path: <linux-kernel+bounces-34438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECB5837913
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B832A28B9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826FE1474A1;
	Tue, 23 Jan 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpPC+nHC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753114690C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968380; cv=none; b=FC5yszm/DV/tuKA5BoSFkcSstQ1bKiQmwZkJTBLf2SohmACx1laHPCp31AdgNxdGOS9Lr4htE1BBAzOjHhRkEXTvPJderQABWW0h9FddBmIHAwBdbWGeVDLR0WtTPjP3x04urR8BvEog/gAYhT+hw2wf0ex8jm4wMvtKCY5QNnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968380; c=relaxed/simple;
	bh=QSzzoS14vis9dIlzEyaQe1hPLIfMWnirr9zB3yUAZLk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oB6CLx0pABUfqsYadZkbcKJlJqfK2qhZGgkGs2OmRpYr09cUMa+waPc87CjOe68mxo8Znysi2dWGrVhfZJBWz47bugNrlLYCYwEKMzIaFCm9xoy/VAEYKHDE32C1h5vB46hFSYnDO1LC1I7/4k+mwV0rjs1Dq38SDg4f3qaFwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpPC+nHC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e73bd9079eso61260357b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968378; x=1706573178; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbGGf59DA5QM5LIqtEUDehzpONrkGjjAENgF7jFRKl8=;
        b=UpPC+nHCQdCOlLooBJLVq3GMj0wxnKG3qiQ6zlfCVZIFwzTFOSEW1bSV7kZYOttOK4
         euGBwpgbe+ZzkNc6JImgQYqk+uQ837CIq75cqeU6EqmSkmVSnJZr/m+WxQn2KJr95KPB
         xijjmiPBPiaz8Vp4jHeB/BRxgPcCq/CtCEqxl7wTJkFNMfoP+hJ4IlhzyzgIIkS7hQpz
         g945mKYkZa+6DRZ+P+D17CiFlrzSvv0v89lEkA4KVJAcROd7CwZ+rQ4MPBV2w/2oCOsm
         xpc+hPzL3Y3/0NTfTvV9vBb76Q/k09RZEItKDjRi31allhCr6uLu1M5dG6Ioo323tp3a
         ddtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968378; x=1706573178;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbGGf59DA5QM5LIqtEUDehzpONrkGjjAENgF7jFRKl8=;
        b=EANp0bELlB1uURupFGFrbzkvy9GnuyGrqdtzIs/xbwCL6caG5tgICi9zRecmcZok74
         8p5tpkSFRLcZBoGPvjhIAlAOGc780n4R23WUmYjQw+GEb1OFuxf/oxvNW/w4pTpaUiXI
         KRERJVDp0hEOOj48uNA5plSacJydRIUdomzr+elZTi2p2z+HGhb31Y4/6RCtdTo9I+aP
         mJOcTf+6Ovu63Dx4a55Kh1Psy1UNkolNhkBoAydTWHDbdOqsKYUVfaqE9aYb5R3SLDTn
         TNWEJkrgeSqSAKgq4DE1NcsGzZpXFtXNhtdcmOigiWhSj+cUnp26kllmOY5CpPTTZmlp
         vP7A==
X-Gm-Message-State: AOJu0YwRZX/vyBA5lw7h4xSNxCFyk12mQdOt760C1DRQtUBuFWoW3tbc
	Jd/hVD2DAWxNKMxfjeTRvuUXVPcKRkgbfdb6eiLR5zShcSWN2lpxmdq0Sds5/TehwB7MpzbpX0H
	jE9S9bA==
X-Google-Smtp-Source: AGHT+IFI9v9ErrrriPidwIImxOgMDIe4nG5RZVJxqXZFbvLOe/Avzwb/T5Juc7eC1YqaDNWzCNVV6o+VlJkw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6aba:f97a:4dc7:7e92])
 (user=irogers job=sendgmr) by 2002:a81:5709:0:b0:5f8:bd56:176f with SMTP id
 l9-20020a815709000000b005f8bd56176fmr2362476ywb.2.1705968378456; Mon, 22 Jan
 2024 16:06:18 -0800 (PST)
Date: Mon, 22 Jan 2024 16:06:02 -0800
In-Reply-To: <20240123000604.1211486-1-irogers@google.com>
Message-Id: <20240123000604.1211486-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 3/5] perf test: Workaround debug output in list test
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


