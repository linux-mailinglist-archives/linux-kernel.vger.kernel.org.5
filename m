Return-Path: <linux-kernel+bounces-32409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247FA835B66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B731C215AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FEFBF3;
	Mon, 22 Jan 2024 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgcQS3L8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D24F9DE;
	Mon, 22 Jan 2024 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907453; cv=none; b=IYYMZl8gATy+m+mNKDo6yfC1KllGXOrcfRqSLotK/+0nbYczQ7JRHABzrU44eEjhy259rjq87ZCwdOT9+NJvVoR3CzuEvWK58fxrwLjhtD6Wp61tm91cDv+YCD4HKhxmRS/gRUTfPMGQF39vVpn7bfDOS0UogA27nf7hKfGhjrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907453; c=relaxed/simple;
	bh=r/ehZCziQ5mB2O0dOK+KkcrR87VE1zkqb85/RQs0jgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol/8dagJKVahLmsCNIAodHuYrxLVlQABLrtz38nDEZYbnqg1Lki3h95esKJvY8xfWhfPqZ76Z3JpDgr5PSfimdUbR+vjrLvJ31ZHEEjGt02XsUOx0bRJFpYX4JELmirq3V9K595MRLhoy4ZzyD+4SvpDN3u5uCuXWFl16FVltqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgcQS3L8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7431e702dso2020245ad.1;
        Sun, 21 Jan 2024 23:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705907452; x=1706512252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DlrDFe5Y9kinmI2EZideUfaxC8SBA39wYnKFZevMC4=;
        b=lgcQS3L81zM0xRXaXrX65c/W8eirs6dyEc4VN538fGSe521DAx8YvzlpsyWw+QCRSL
         lWTT+rdpUDljT69B65gZ22kGj2qVGNtj3EWy70CFfaK+MpjCnpXhFHyxNc5T70fHpEDl
         vaIHKxHSyFMnbHVEdgp3KCBoowlu/AVatqvwYxbdYl/gEuYPE87EA8G0ih4eY7shapho
         qlCta2CEKJ6d8xASAjgqFHIJm6EjJ3uttR6ggj/Sf7VBDqgrgoRVcz/6yzAWZSoOtJi3
         EQzcI5hDFVr2I5083j5D7F3NVg7TumGVjqiN8JeJHK+nz8lsmPkqAu/+QZBt7Onlb/qh
         fYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907452; x=1706512252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DlrDFe5Y9kinmI2EZideUfaxC8SBA39wYnKFZevMC4=;
        b=cRfuWpqmtwufLJxDL4BjZxVlQBB2vwgGWKa4veef2gGf7a+Yd+kGDkDecZ7qXrTxEN
         RQim/kfQKwSV3ls+O7CFLrlTJj9JFUnhrtc/pnL4t3lo3timAGNg5rIDxn8XbqaYplwt
         VtC62p3CqsGT0tSu0yxX80O0xWzM29/kiGxv7g+Xq8VYtCPye5l0U+I7hEz2ZqmdtlPW
         skj16iZV78ux8lXP8mRIENHVylGiqTzMgGpzlNQbM9pfZwCUvr5Er5z//pogA7XyNDv2
         Il/1QgodGnGH2shLg9nO89nZb0ubFErRCaZNx1HhoJyU037jla/qdY+uNWnVcihdgiuK
         gg1A==
X-Gm-Message-State: AOJu0Yy95PeYuoHzmkh67syige744ZVFiPRTOPCWHpfyK9qCVEtn7dcq
	I9b3PwTXgXkGmDMVXB6ZDyStAMwxDEQJa2ymJa7xWJFA0QgtG1zV
X-Google-Smtp-Source: AGHT+IFTuJx1omZMnOjDAV1d4HiZgPXBgzBG3ZSbjMjZ96lN3hpbmXXFQXzDgIugy43VFQM7xfJS+A==
X-Received: by 2002:a17:902:edc3:b0:1d6:f2c0:3e3c with SMTP id q3-20020a170902edc300b001d6f2c03e3cmr1357035plk.87.1705907451645;
        Sun, 21 Jan 2024 23:10:51 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.45])
        by smtp.googlemail.com with ESMTPSA id t10-20020a170902d28a00b001d72b3b0ee6sm3463365plc.248.2024.01.21.23.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:10:51 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH v2 1/4] perf sched: Sync state char array with the kernel
Date: Mon, 22 Jan 2024 02:08:56 -0500
Message-ID: <20240122070859.1394479-3-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240122070859.1394479-2-zegao@tencent.com>
References: <20240122070859.1394479-2-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update state char array to match the latest kernel definitions and
remove unused state mapping macros.

Note this is the preparing patch for get rid of the way to parse
process state from raw bitmask value. Instead we are going to
parse it from the recorded tracepoint print format, and this change
marks why we're doing it.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index dd6065afbbaf..ced6fffe8110 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -92,23 +92,12 @@ struct sched_atom {
 	struct task_desc	*wakee;
 };
 
-#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
+#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
 
 /* task state bitmask, copied from include/linux/sched.h */
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
 #define TASK_UNINTERRUPTIBLE	2
-#define __TASK_STOPPED		4
-#define __TASK_TRACED		8
-/* in tsk->exit_state */
-#define EXIT_DEAD		16
-#define EXIT_ZOMBIE		32
-#define EXIT_TRACE		(EXIT_ZOMBIE | EXIT_DEAD)
-/* in tsk->state again */
-#define TASK_DEAD		64
-#define TASK_WAKEKILL		128
-#define TASK_WAKING		256
-#define TASK_PARKED		512
 
 enum thread_state {
 	THREAD_SLEEPING = 0,
-- 
2.41.0


