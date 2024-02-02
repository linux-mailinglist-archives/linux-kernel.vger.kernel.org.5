Return-Path: <linux-kernel+bounces-49252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7888467E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388EE28DDF7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9BA282E9;
	Fri,  2 Feb 2024 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gtwdmomx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8751AAD2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854579; cv=none; b=YXTAm53w5C2bsBCLZ4aT1uZrQGHEvLqF1tJAk7RyWpzKwSwXZCpiR0TxBm8lumgiSzcSjMo3V5xa8CNjYQ3M2HuCFnMubxrWUjVVjqZXNNFXsShzahoFQY6EdDuZNPC62Y/ZkTY8MlDytuDBX0y2OFu3Iz/+5Zfn5ktuL0d13qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854579; c=relaxed/simple;
	bh=x/5fHTR183S/2RfEcYCstWfa0bGQ3QCOM8/PnsO9ubE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=be9JDWWSnZflCjqxCiX9QnQv0pLyY7cmyrDiT53HjYLH6SJpyQANF5pIesHAXBAYpb4qawNYVc61b5GjAvx4lpLfqv/tNhrgEsBPRVMpDf6PaqTyyypGgKZ0OAECzvMRwRC545Q+akXMVogNO3h3HAjKn5ClPIT4JmpbuLHVzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gtwdmomx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041dbb7a78so25540717b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854576; x=1707459376; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rt20z4T5VPT3LRcytD9SJzsjA7tToX3uHX4SxOAPIZ4=;
        b=gtwdmomx2Cp+Mp32uFL94bep/cCR2gYlgs/3O7l6drunD0zB5E+ROXF0LAJg4mS7td
         V9c1sye0U63OOIwjoCg66JjJRdDIjyPXQhYVe4to8pYXthL4/fNelEVEUny1BOeaEBHz
         GkVvGREGlPESkavGdja3hKtySNT4g1Qk8bb1UlvO2r+nHOc5sCJd/8n8gVLULZMXBr3y
         inXC6NNB0s7nNUBUC6gBIV2aruABwj9vrdgmpOEH9ZZmeCsBiwd2PUyb8A7g9rE1nZ8m
         +xqFUYScUgWJpOCs2vZX9yctlGhVsb262klCmEGP59BtKoYS/tbl6kOM2t3lwCmlymnk
         3RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854576; x=1707459376;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt20z4T5VPT3LRcytD9SJzsjA7tToX3uHX4SxOAPIZ4=;
        b=KEcRDAanDMbrVtuXsDXqayJxb02PwsfrEIc+ABqBTil9XDaK9vHnC/Z8VJxYT+kPh0
         2xPRRv8qFeQTD9SxrFcQoGXfq1RpgzLuuLL1118C3qEBTSTjs/seCl7KUpoR9wrJcdBu
         r2b7ey5hpy4jpDPZXrktXlCXKm/E/Mm1joL8PtdkWSF9xSIeYgqkd6dqEviIpS1N2lYg
         T9WoUVnPlQo99N7HgPJk+tLEaUgX7VBhK00Hoc3LFEob35itanImbnJN61TKdN0bocvT
         CM5dJgeWdCtdkYR2jvPN8+zWA2yEL87LpljfR6F4x9/04HenDjI/hJ2FV59W+CBriTdo
         TQiA==
X-Gm-Message-State: AOJu0YyxUvd18hhmxSQji3/1/J9Ww3yNrSv591VfGVED4hJuZB3HKy+C
	u01Y7V1+t2hZ4pLy6JhmmdKG7UmSXq74wncsJYLk0iAaqVaeTe9qcF4JkvJm12hoHyYfyNxz/+Y
	D7i06hw==
X-Google-Smtp-Source: AGHT+IEBQHtYwlklbn54N9Ht8fI3AKZRBb5Edl1j5ad4THW2Y+Ju0CB5RXWFqxp7O53WFGKMIBhIisrWFeIS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a81:9b4d:0:b0:604:5ca:5ab2 with SMTP id
 s74-20020a819b4d000000b0060405ca5ab2mr1614230ywg.9.1706854576529; Thu, 01 Feb
 2024 22:16:16 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:20 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 13/25] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.43.0.594.gd9cf4e227d-goog


