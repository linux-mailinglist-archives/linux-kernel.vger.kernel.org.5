Return-Path: <linux-kernel+bounces-74006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 486FD85CED8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E97B23AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E036A36120;
	Wed, 21 Feb 2024 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cGf2UnQN"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E923C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486926; cv=none; b=cjpfNnajM2YiZmo4xQclx7AVReRmyThcCLto0rT7af1mAUW1Dgyb5juEJ48VUQeNFWMJ9sNNIEKTdvXU+BETmODMFQT2Fuq17JxhiFpF6tDcuSu5JnvUknJrfmI0O3LV3LRsSW2Fmu/yzuVfy5CQhOSUq4AY2ukgTAkipfIFS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486926; c=relaxed/simple;
	bh=qBBWee4bsjohLiPXM4U45YwIA5H1h0d6lKaukzf7Cio=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=sIFHS3R/jmQLODd1GWXa3a0rKaBCWFh4lGARp/jRre5xKvpjXGUYI+eazRQhY9J9ySuxg5+Us7q/ZRuwv3rEQkFYS4ARQeYsPriA3jFkjJjTY8o1CAZYbrcvpfDnZJMOxJBGl9Pbn0MOkq7rJVq5j2dOEWD1P5hTnDwD+Tus2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cGf2UnQN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so7677949276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486922; x=1709091722; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7WjKSr2mVwiWkPP/U/UgciWSCHgFfzH5V639nNOP7Y=;
        b=cGf2UnQNAA/+B9S5vIMIjz2mHAINSKNxDcN5ZliGGpGmWmNIGZ3ndXHVzomscplwkD
         rrAHA6w4wlaDQssm+PnHzkzJburKkV8sMh17u8eJCx3/keMRDpwGy5wEvYaRURSc9j8K
         VH4UZgyj21nOgyWh/1Z6bGSeFgVAQgYb17El76H56bJVallx7K06Nzhoihd5LJBeeISD
         cL+85gX6eqxVA/NLto5StBsH1omzTuWRsMaTwjONhcUBJubOsxYzgM1pyV7UmWGW7hvx
         lRd+om0C7aZUuuYDcGwT0wT/DGjB8Cmfad9mAzC6QSISxuPrxOGCyOkU+106ua+CTZgq
         lhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486922; x=1709091722;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7WjKSr2mVwiWkPP/U/UgciWSCHgFfzH5V639nNOP7Y=;
        b=SH853Zj2xjsfyD8hQ3oaJxp+gBuWPOo3/+/CSBJka48cjaNXJZcwJ5bZvz3Pxytbg4
         BYemo9R8WQk+7AN5qGwY7Hw9Rp8uLTV47L0KYLCwjwGhZkhhiDM+hIOi4+OUp1A+PDVA
         zvOhXYrbp2Ti4JUsb7a+GCTmkPqsQEKkwQmiZ7dMrfSIDqZ5Gno95nqvsTCG5TPzO+mV
         BJxwEpztLfuvMAs2exxYE9ORjhWO/nOgsjQG8O2cLgWG90iHSpraEdJWAKeA66mkg/Kt
         i4TSuYzrtcX8xTgCihC7nCc3cTQordDzIo5OhnRl8/c+JcbAB8UJL2kPul/m7hKBwzaF
         mkwg==
X-Forwarded-Encrypted: i=1; AJvYcCXIRirY0yI8tSH/Gj4yym3wqa65TM0mc8lkqeUK1E9Xek9LHCW325CUmHTNbbMNyfPt9fXzqzUC/5wBh9xbptAwJhxU3MbJUNyKPaS6
X-Gm-Message-State: AOJu0Ywk/xlYPx4QAlKe/eDLBagCcUKZRLN8HkHsSc2O+Zx5QBnWpof/
	tbVrgjelOhHyWSX7QRaj0Nju1QYOVWpOxWaV7Ilr0JRdde2TGGDQQhiS9/2Su+exvudAJ48MSEM
	Fced+OA==
X-Google-Smtp-Source: AGHT+IFrvrVz/STekeJ0Kw066vLWgDLKhldWGJrVTkT+Pmf7Wne7BKkr3s7PpVJuEJj3xYqUV9Sas2NxDudg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:110d:b0:dc6:44d4:bee0 with SMTP
 id o13-20020a056902110d00b00dc644d4bee0mr1005962ybu.7.1708486922283; Tue, 20
 Feb 2024 19:42:02 -0800 (PST)
Date: Tue, 20 Feb 2024 19:41:47 -0800
Message-Id: <20240221034155.1500118-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v6 0/8] Run tests in parallel
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

If command line option '-p' is provided, start/fork all tests in the
main thread and then gather them in order at the end. On a laptop test
time was reduced from 5 minutes 21 seconds to 1 minute 50 seconds. The
option isn't default as the test shows up perf and test flakes.

The '-v' option is modified so that 'perf test -v' will give verbose
output only from failing tests.

v6 - fix/test alpine linux build
v5 - fix a -Wunused-result
v4 - fix bug in width computation.
v3 - fix a crash if shell test directory isn't found, remove merged patch.
v2 - fix parallel test output/verbose issue
v1 - initial PoC

Ian Rogers (8):
  perf thread_map: Skip exited threads when scanning /proc
  perf list: Add scandirat compatibility function
  perf tests: Avoid fork in perf_has_symbol test
  tools subcmd: Add a no exec function call option
  perf test: Rename builtin-test-list and add missed header guard
  perf tests: Use scandirat for shell script finding
  perf tests: Run time generate shell test suites
  perf tests: Add option to run tests in parallel

 tools/lib/subcmd/run-command.c                |   2 +
 tools/lib/subcmd/run-command.h                |   2 +
 tools/perf/tests/Build                        |   2 +-
 tools/perf/tests/builtin-test-list.c          | 207 ----------
 tools/perf/tests/builtin-test-list.h          |  12 -
 tools/perf/tests/builtin-test.c               | 378 ++++++++++--------
 tools/perf/tests/shell/lib/perf_has_symbol.sh |   2 +-
 tools/perf/tests/tests-scripts.c              | 257 ++++++++++++
 tools/perf/tests/tests-scripts.h              |   9 +
 tools/perf/util/print-events.c                |  13 +-
 tools/perf/util/thread_map.c                  |   9 +-
 tools/perf/util/util.c                        |  19 +
 tools/perf/util/util.h                        |   8 +
 13 files changed, 510 insertions(+), 410 deletions(-)
 delete mode 100644 tools/perf/tests/builtin-test-list.c
 delete mode 100644 tools/perf/tests/builtin-test-list.h
 create mode 100644 tools/perf/tests/tests-scripts.c
 create mode 100644 tools/perf/tests/tests-scripts.h

-- 
2.44.0.rc0.258.g7320e95886-goog


