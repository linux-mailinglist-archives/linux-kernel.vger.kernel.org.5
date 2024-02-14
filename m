Return-Path: <linux-kernel+bounces-64739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F1D854225
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1229328D60D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06F711716;
	Wed, 14 Feb 2024 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ka1HKHnw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CA1119E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886481; cv=none; b=F9iJ1Av0O8Duy8PjK43igjhCAy0K0VBP5NEJXc7Ys7JW7i4vq05Pv3fxkdVbTy7ua5M8hWMl3sgyxeVhjQWpoQ2dVN9e/0CzIT2J6MWYXZfNvczzkLA4ljkuNzFmLtwzY7LClqL2mHa4dv1KHQPMDEqfeAdSibmlVa5rArmd9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886481; c=relaxed/simple;
	bh=cEoquvI2Ge+v6/Ow4yXCwb905NVQF3PwLLtFQnXzKG0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gzogAVducOJe0CAVqsrMwN6+cEF9uRPaPWsbGxEkE+9vmF3iwsnATDjbp5zfYgfVi3CORvdHYsCLFDPVkz81fJ0fFNHqFsUoY8a7Y2XWlY4Xp5Dy0k3CyVGWzlgi15XCghhtFjHjdS3xSCP35lD89x/tUBTU9ZRYDFpbuwaZNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ka1HKHnw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6077fa2fa9bso30720987b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707886478; x=1708491278; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQsEsQdYL+F7rq54Mfa+75HgoPY/TwxmW9rhD6V78kU=;
        b=ka1HKHnwUZf/VtZmg13XfpuL356/CJEiYDRvGxg8or1taZebth0hH+3EF/v2bsJ1K/
         T6HJTlUU9Xj9GUPg4+Jh0hiaxXlC53GVqNGHmIhMOOXKpWEMQiSvm5P/WfCWaNItYR/i
         c2N6g4fgB6wDiWqFCQjUNHfWzYwLtpCzVVJLyKo2oFfUieIF1vlPOU1VTYfI8RVC/1Rx
         WmNflBbWD0iBrarDoOFTfkuuH5WEDHNhQbFC4ehOGJIepaez3U+7mVMY6+Ut7lXRTCWv
         O0e39iaA27ZfMz1noSy6ESsD2RsnuCm2L9do1rqEHImu0PYWzBCHXfeW/2sPgYWVvzRG
         XNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707886478; x=1708491278;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQsEsQdYL+F7rq54Mfa+75HgoPY/TwxmW9rhD6V78kU=;
        b=UHbaT4BYkgu8P/ZncBxiOPqGXwobjXLGVTKHEzzcmuhmi8a0jefzbm2Xu7FNesErjD
         zig/9Bz5gQPtWmLcEdthA2mwMmsvPh3LbpbDRa+DJvVlUvLpTRmkTyeH1Vn6GBFBylzh
         AzJkBli4lMb2JrgbDCx8YpLfhAJzGT4TpmEG1NtTHm0WYXgo3eRB0Em00cwxYXWRbBd+
         6fEku3G2P59sDKCdXYGJOuQ8ajMmrJu0SZa/mh5sCvFtaiEmVSpexz3IFj9B1pRNOH2D
         x5SP23pCEe4+EIj0ceEpFwvt8uNHBECF4/Q60VGKIU5DrZHX3vX+yI3LrJE+oYQZSmpC
         FlZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV/N6qlcwf/iCsP/6PpeczyAeyT7knV6BRIKzZnxqJVpjUUfSM4SX6d7JkDUM+/pfkH1Mfgx7YEkR5bEXc1zputzreOAEICV27+E0Y
X-Gm-Message-State: AOJu0YyoQRzse9KaQzb5NXd4XD4wl4965mI5iA+1j1RGdciwbYASAZLj
	QCFtIJ6ZA1JR4iEfGhVR/Zap7nAwGMX+TjDL4joWNzFEvwlPd+FslUlFTD7UJjLGiYgocOW86bf
	nn4CmSw==
X-Google-Smtp-Source: AGHT+IEyHbP+pckfFvabgFHrAtPTPFgzZnnrvWiKaPJToQmUliMu4+e+EktFDuhWE7n5StUlVnHejJ0MRW+a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a0d:cb4a:0:b0:607:83bd:bea3 with SMTP id
 n71-20020a0dcb4a000000b0060783bdbea3mr244497ywd.10.1707886478458; Tue, 13 Feb
 2024 20:54:38 -0800 (PST)
Date: Tue, 13 Feb 2024 20:53:51 -0800
In-Reply-To: <20240214045356.748330-1-irogers@google.com>
Message-Id: <20240214045356.748330-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v4 3/8] perf tests: Avoid fork in perf_has_symbol test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
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
2.43.0.687.g38aa6559b0-goog


