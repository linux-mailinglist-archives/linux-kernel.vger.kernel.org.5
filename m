Return-Path: <linux-kernel+bounces-133795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CF289A8CE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 06:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D7F1F22C2B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9FF19BDC;
	Sat,  6 Apr 2024 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3zBk0Xr7"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01A18029
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712376560; cv=none; b=kg2HBOLHn/K0fvBIJdqd8XuDbVf01X1iwL/Djm4b3TDmi5AMV9tDt0Lo/TbviVbN0PalBqY45SXX9Zp0JDnogxPK+X9HdzUSApQtJ6L4nMki/tZZRKnEu5LzeYhDkFxJSZZhFb7d88as2Lx/SMSRGmUCGNQ7dfCZpRlJAXj6on8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712376560; c=relaxed/simple;
	bh=ryhaCjT8y83e6nm9rSvWXbKLjBmeKFK9uS2+aXyQEW0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fQAGoLGjdrtoxkj6G1eLj6/6f6V6TB5Uletw/ddiU5i0TMxehHPbzSADQhXz9mScElmP9tkKj4ng6vjinSaB3EaivqLWmPz7OfM4sBBqqffghr5lDB9fTSrRO8ifWYmQYZZoS6SuzUy0wUgH1aqaJnLHO5WeFBdyQaRivs5uabg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3zBk0Xr7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615110c3472so51157657b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 21:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712376558; x=1712981358; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sNu7c9amoaI33ZXVqjycoBCCoj/nNGvrPWP0zIU3JJE=;
        b=3zBk0Xr7z/O6DQ7wPX07f9FomFCdMKYk+5o37Ytw0tYuIrpnIAtC3TjJcAycYEYmK4
         8rjVaH7lXIa6Xel7D2it7fad1mWR2UbUMNUlrlnkDSKMdqSYcBd4L526I1caImigrENJ
         wokRdsmVG2KuNTgb2kCSu8BM8XixsY9/VFaRf3muRRqr7Vh4XfurriIDhyHh1o3zXQOC
         NSQoUYtzDiPlA34Dzn4WXbxpQET1AuD/caeXMd+cXp1s2hv07GrVSUjIGWmeHo0afjDw
         Ew0c1EaU0addIEkgbwFjvlTBsaGUs2LRloTptPy1TIrjT6Ta/hTKYvmWOk2UBNu3B5lD
         smFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712376558; x=1712981358;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNu7c9amoaI33ZXVqjycoBCCoj/nNGvrPWP0zIU3JJE=;
        b=fX09wBuiWT0wQSAGVPpEw5noRgFy9xeghNmOOAbLAqqU9iaAY8cz5JH1bfI+o8uZ9h
         VyJM9Jt6wjUrzjCyTCg+7qXHgwWu0t+Sfsha2bI4qsYvtERggNXCf436OAD5IIP6oRvv
         UKQSmyjWLPLnJ5aiTnbjDmoGTybaeFlgXDy84PYyr5pnixfMmkYqvoPOnPqugPFZOBmH
         h4eQTZuvcyp8W2JiPiPuea73KC3VuarRn0IpHeFAQqNZYXD3GubwW13yfKmEblPaCrBE
         fCOwuO0VF25PBMyR6B+T/M/j7jz1s75Aoe0kTTd1tLgfHYlmxG6DrAcvQGIoNd0Md/vP
         3D+w==
X-Forwarded-Encrypted: i=1; AJvYcCUn2CR9Yicen7PtuRcFK++tWksjEHtTbxd1tKzsDl/r+ctjx5vycxCcBRTBmCXxx155Esns6RTAr4yUHw8w+dyjz1Z8vgxL1CRC/vDb
X-Gm-Message-State: AOJu0Yz1t83EkNx+BWchOQHo8QQAK2AkB0GdI5YFegcyKPFRu9bhumez
	zTkLCXCXrz+/juLOzX4A2V4VJu5SEcdNTq+qg/C/M3H/BOxSLIZUlOwDLZXpPFRlESbAB+y7J9Y
	NSDsLpQ==
X-Google-Smtp-Source: AGHT+IH7IGd2BpRVCyTAOvsnf3SjaXVdsGIlIFz5FXVc55i7Tlr9PCarJ5xLRb9aFCQWhPs6faG7upJWWRWK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51c1:e2b:9198:3cdc])
 (user=irogers job=sendgmr) by 2002:a0d:ca88:0:b0:614:ff0d:2c7b with SMTP id
 m130-20020a0dca88000000b00614ff0d2c7bmr806437ywd.10.1712376558227; Fri, 05
 Apr 2024 21:09:18 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:09:10 -0700
Message-Id: <20240406040911.1603801-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 1/2] perf bench uprobe: Remove lib64 from libc.so.6 binary path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kees Cook <keescook@chromium.org>, 
	Andrei Vagin <avagin@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_program__attach_uprobe_opts will search LD_LIBRARY_PATH and so
specifying `/lib64` is unnecessary and causes failures for libc.so.6
paths like `/lib/x86_64-linux-gnu/libc.so.6`.

Fixes: 7b47623b8cae ("perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 5c71fdc419dd..b722ff88fe7d 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -47,7 +47,7 @@ static const char * const bench_uprobe_usage[] = {
 #define bench_uprobe__attach_uprobe(prog) \
 	skel->links.prog = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.prog, \
 							   /*pid=*/-1, \
-							   /*binary_path=*/"/lib64/libc.so.6", \
+							   /*binary_path=*/"libc.so.6", \
 							   /*func_offset=*/0, \
 							   /*opts=*/&uprobe_opts); \
 	if (!skel->links.prog) { \
-- 
2.44.0.478.gd926399ef9-goog


