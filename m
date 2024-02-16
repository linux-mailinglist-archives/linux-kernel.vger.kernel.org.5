Return-Path: <linux-kernel+bounces-69511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F361858A66
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A3F1C22439
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4891534EB;
	Fri, 16 Feb 2024 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tk0vz6RX"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2614A4F2
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127722; cv=none; b=qCz/DtSL7v/8fK/xgBzHma2JUfuENJdtb1qLLVaPG9fNhJ6b2O+Xj5bRCABfjN3b31Qj/4mP7EqbgHr+QPgz1cC9ra6RtfFRO3nxsV2XOd6pPKpjUeQ7lPjhXm+ypAeWPL9zINWFQMQjPV/2a3xrfme77KiUphZ90fNP2CKm+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127722; c=relaxed/simple;
	bh=9QHqj0EQvOX6+a6MNptism09KshtnOJS+VQ0pDYpZf8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eOTevSDhb8Rk536hXm4L0KBCQ1iW6CQEz0XoIOAAmoJlQsgaAqx0cNMySdOmgUk7KzkigNwnpCSGapdqzD+RdKHQPkxzkvmjzKw7spDUqDEIKUV7cgdI6uTXPR/vYMYdkXtaP7ahOwXQ3hqF7z6FmENRbGl3luxgGLjhvCFD8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tk0vz6RX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso4283267276.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708127719; x=1708732519; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwHudnCNl5wfpV2IMol1tp79ctLuVP/i5n4Lz8j3mXY=;
        b=Tk0vz6RXDKQnhcGr+DXY5W/BPJuZhyPUfT2SOUMyg/oXvpHj+Vdv+ABuPQw9kZehBM
         XIkmBgFT3cf9/Fqwi0+DhwCSqnnHhY82jVdYupN5nV2yEOp5e2XY8bxgApYeKN/f7G9a
         umFtZlghzhPR3SB322PueKQWg7GlWlPlfp5B2ubjSiCavMTE5WEcinVnDl+/C4h2OSxl
         Zin/X5QIDBNnE9lhKOjuz/xaeGPsVmLf8iI6gaH93RHqhZ+5K4weHb8ouvtww+04fNDF
         bndnB+JErGtBPvh6n35SCu5Vk/+j/BXzdmxS6nlF/MI1xJ24EGloLbeDTatxaJk6BA2t
         AgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708127719; x=1708732519;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwHudnCNl5wfpV2IMol1tp79ctLuVP/i5n4Lz8j3mXY=;
        b=qEnYx7DWbqxJrQHljExgDIcRBKsHB77W2Yjk3FxLGy+ClioDr3IY7X1TfDDkquUvY+
         g4jiFRNtWAav9lHWiSkzk2Qv5nnskkDj21DX1tuSJ5E2ZtHWGmzhRkYGL5bgYjmfch9v
         +xaahaocl3z5bIqvWb6tJmiV7Ka2xJi6l9LY4iVRYz7fuekFM4/JjeB+Sn6KIyLOW+zE
         Bmolw43rTUAlAFrINt8zhUtqw9GmYLUfUMB85FBBWNEokMfFZZ52FCR9HvFyfHBM6B/i
         tv6+CJwm7grBsX8Bh0sMeZUNryIrpBk+8RvOgvd65hPx2NU69dgtS0dL69LGlhnnewbv
         IqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJcOjlVuAdd5S2225pgZso57Ail+ImJOkpe+Uojd1p34raEClsRflr+fXAjsCSHNYs/DIzRpqY7TJnDbIRHBjrS9dFDItUyp6nr6Ne
X-Gm-Message-State: AOJu0YwCZk9SGNqlZ277SxsE60WAMk2fAaaqfv+X0KUeE7AHmrmjmqa7
	1HTm46ZwzeuPs+vxyhXSy4AKVZpeWSc7c6CBZwTKKw/uvR14CelqSnQ3NdwIttBjtacTo89NgOh
	boScU/A==
X-Google-Smtp-Source: AGHT+IG8QRb2Q7jBDqZB4i9cqOAXtHSKaGeMrSsEOLiLdKXk40XnzjXZ0NQyadsz7ftlgTYp32osL3I2Y+06
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4b5c:352:4272:e34e])
 (user=irogers job=sendgmr) by 2002:a05:6902:729:b0:dc2:5273:53f9 with SMTP id
 l9-20020a056902072900b00dc2527353f9mr224067ybt.1.1708127719606; Fri, 16 Feb
 2024 15:55:19 -0800 (PST)
Date: Fri, 16 Feb 2024 15:51:57 -0800
In-Reply-To: <20240216235203.229256-1-irogers@google.com>
Message-Id: <20240216235203.229256-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v5 3/8] perf tests: Avoid fork in perf_has_symbol test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

perf test -vv Symbols is used to indentify symbols within the perf
binary. Add the -F flag so that the test command doesn't fork the test
before running. This removes a little overhead.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
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
2.44.0.rc0.258.g7320e95886-goog


