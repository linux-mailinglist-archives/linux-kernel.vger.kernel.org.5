Return-Path: <linux-kernel+bounces-36430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8478583A09D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AAB28633C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B5414293;
	Wed, 24 Jan 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvQJOOXh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1EBF9EC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070630; cv=none; b=XgI9Bdd600ctBn8YWgzdUzrWCTlRSwRBDKoCSEjfYovZQuXTP3sicgZw+W8+KOrU/GhYwXTiB0f9eI6aI0EDDwUM2QpW0ojhNDUXBY6gL0JxLuL8+3/Snbm+FOOkUgYWBYtxmHslb4fhYx/N/RDm0GfJPXy2IJdXlg8Hf+D5Byo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070630; c=relaxed/simple;
	bh=/BVg/i0Vw7TAHNOWxEpu0gen2xUd569y8hw0+uU0hkA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=o1yARNjYSXrKZovCM+M9DDO/5MqrcRkXpVXxgMh/6+H8B6LHRH8VfCszK91epsInHyVTQk3CDPJEBpm8Vv/gl/pLCD/oJV804vc7cUVy6KqVRdjSOOOpzumH38Pw/dbC5qVC3To3oSd8sqWviZVw1VmTUhUQdMDfQq0dnj010ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvQJOOXh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf1c3816a3so6012433276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706070628; x=1706675428; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBCtMKasWa4R0QCHWLL2yjNv7OcjwMumfCEw+e3pMI0=;
        b=fvQJOOXh0tGyRzU3GoC2EnLnD6suVdBLp+XPUOpW5Dl9qrNQRsmiLhNk7k7WPU0bOM
         l2posPmK/7pcLpjNGtoep1rLCfyA74El0+LR+IOm4fROdiyZ/1nkhZ2GrL/UBejXm+M+
         iqdhlc2ZII2ccZTGpw9f+D0ZUi6udwUDWvkJbyWD2BhXgwujRj8184QePEwPVF07shKN
         M6vhX9n8txVvoTI3CTRwc2FRz5UtyJpJuDJdEOQxsCG090K2tZp5AOZkvX3P/BdIi2GN
         l3sVdnjHSxTk05PMgfw9/wnrSzaNYozbaRZxSH7W/sm5WL2EFEwXHO4uMKeCf5xRu3VS
         hYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070628; x=1706675428;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBCtMKasWa4R0QCHWLL2yjNv7OcjwMumfCEw+e3pMI0=;
        b=atdGCX9n/vlHeYMB3DUzqY0VRRn7zQIU1oG+LhKIYnX37949yWaI7Z1nj0TcpETzmj
         Ja7/CyCpq+VIHrPRkHBUxebtHgq2AD4xWdxaE94U/wY/bxlE+MZ9DHphd1WCCgHqyjaf
         JLvZF+xYZxb7lHwQqF0iZZU5cUfq038Hvgy1oekdttjB73fPIDggRzdu+fKGkUfzbwFk
         HV7uFlNggumCN2AdaPhgvu5hRB7xBfE4DMDd5Urzo4PxyvBZC79gFkZcKGI4VyZJLL7s
         QqcO//Cm3oyNittR/QwnMo5ntZM/8TmwNHbWAArMbzwX6vf5BBFrt7caWUUtdvwOewlX
         cX8Q==
X-Gm-Message-State: AOJu0YyFNqQjG+nAwhAg1RoMsjwfAxwqELR3+ippsoUmg5CkHTF8AOQ4
	f1DDWzEu1oCtYubopfFGkKqt0TPLtvPruOycQi+MM+6DZ2jAPHgc7ta1kdWM216mTEHK8Em2Vdw
	OiHbVTg==
X-Google-Smtp-Source: AGHT+IGoMPmp+MhVqDbrO4qMt5itGZCzFu67BYoFkcT3YdDBKEXOJXjDZL+eU9woU/MV9jJyImaZTSOzERb/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a05:6902:152:b0:dc2:3268:e9e7 with SMTP id
 p18-20020a056902015200b00dc23268e9e7mr14661ybh.10.1706070628081; Tue, 23 Jan
 2024 20:30:28 -0800 (PST)
Date: Tue, 23 Jan 2024 20:30:14 -0800
In-Reply-To: <20240124043015.1388867-1-irogers@google.com>
Message-Id: <20240124043015.1388867-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124043015.1388867-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 4/5] perf test: Fix script test for python being disabled
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

"grep -cv" can exit with an error code that causes the "set -e" to
abort the script. Switch to using the grep exit code in the if
condition to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/script.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index 5ae7bd0031a8..b43077dbaf98 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -36,8 +36,7 @@ test_db()
 	echo "DB test"
 
 	# Check if python script is supported
-	libpython=$(perf version --build-options | grep python | grep -cv OFF)
-	if [ "${libpython}" != "1" ] ; then
+        if perf version --build-options | grep python | grep -q OFF ; then
 		echo "SKIP: python scripting is not supported"
 		err=2
 		return
-- 
2.43.0.429.g432eaa2c6b-goog


