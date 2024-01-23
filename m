Return-Path: <linux-kernel+bounces-34440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0308837917
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CDC0B278F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB531482F9;
	Tue, 23 Jan 2024 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nH3pPjWn"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086AF1474D5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968385; cv=none; b=IHdZfi59TuEdhzRQHXk4OpwacUrtVPCxYR0QwZ9aZAnCIltDBMliEEIBHwRZDPTdyy0qmVDNXbf1cVlle7QQWFDOIHsdUdcynPTf+znsA+kWjhRKWWrf/49bIzyd6HO6St+wOywKIJj79jLkjYpRga1yWmB3pa/6VGoiC5cZ270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968385; c=relaxed/simple;
	bh=FCUxXLEqX6wbauWA6R/m3LLJXqQAbHJBX+CMyQoYlc0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PQvnfx+abIkwwt8q/+XDIZNozIfJ8GDGNuyooVModRQj7gWLLl9mkYftbMxJTqK0ZEvvdLekZOGCpmhg8jV1MGjMUivfnXLpG1Fm7+XAZEg3uzXrzpcWkMn4eotVNWiDRVZ7+WjaGH8f9btIiLv2jzYmCcLLEr2tCnItvtp+03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nH3pPjWn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f325796097so65306467b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968383; x=1706573183; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdBgE5wIVLj6TuJkMA8Og1unwB8wxsizIZfcekxtMQI=;
        b=nH3pPjWnwi6JgAGKa/p8fnkmY3+bZgE8U7E6wBrSOJqAivLHmyX05OjLpEHvmVEG5k
         bl2iUPOlNsAbcYuOK2zY4cC3EdknIRdD7au0Re22vRhn0bo8xZS3R+u1EJM5zmzH1+Ej
         J/A2NMoaUQQMPxudflVyR8xDV8UoDWiA3jgsdD+q76uwCRkyi5iXfr/d92WDK0cgnUT9
         BEhnNXYla4pvLBqTPl0SsIwQ7c6/GU7aBQpvUVsZFr6lIQEtWnAazK+DVr1X31fkPGWg
         ngOCy6O8jEE4g7iu+KlFsNs456iRmlC7Ri7CEEb3HiVA98w2ePzIt8VnyiP83/kHEEuZ
         tGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968383; x=1706573183;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdBgE5wIVLj6TuJkMA8Og1unwB8wxsizIZfcekxtMQI=;
        b=AHiLcJt+qHgRAXANn+Dj5Ccf0izhJ3Ai8l6471j5aGC+ukRKeIg4bLcEGM/EtqSEuB
         2Gxh8yyUMFGmeMZvhRPmsDGRNioLffqXIITMxUsLcjtiPEExPW2ABb/fgKaGomNkWSMZ
         zrBT68ibledBvqyX+2FV0C9M71JRQ8MCairmwfYmnmVSnnZxGglAMbB8WSL1UVYM2xlp
         vbfXvwVk0mZFa9SsVIfEWkonsQ8YCs9lEN6JkaQacl5e03JURn/HJZzClUhmQBJWVZKY
         9yc3gzVNXZ55yu+b0/zWE94pipEar7Ezw1XExm4T2feUsAVoNhTAhvhZBTnLTF84YSCN
         xZDA==
X-Gm-Message-State: AOJu0YwTSpdd2pyes230Y3V4Y81efCOHkt0xCc0t2/FzqwJEUhWvHVhv
	sJCiG3ZJk/zE3mMvOQmKYImOJn9Wa0QwuR+cQlnTvc5seqII7kvcwm7fJzpdn9utYewE9Lehmpz
	o6EUVmw==
X-Google-Smtp-Source: AGHT+IF40DW7beEP6LTntZgRUa2pLjVbP44McWXuRjTan4RCDTY3XGmJ4cj9qSB8WXz9ayNmLE7L37EG0Uov
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6aba:f97a:4dc7:7e92])
 (user=irogers job=sendgmr) by 2002:a0d:cc52:0:b0:5ff:a9fa:2722 with SMTP id
 o79-20020a0dcc52000000b005ffa9fa2722mr2416222ywd.3.1705968383026; Mon, 22 Jan
 2024 16:06:23 -0800 (PST)
Date: Mon, 22 Jan 2024 16:06:04 -0800
In-Reply-To: <20240123000604.1211486-1-irogers@google.com>
Message-Id: <20240123000604.1211486-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 5/5] perf test: Make daemon signal test less racy
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

The daemon signal test sends signals and then expects files to be
written. It was observed on an Intel Alderlake that the signals were
sent too quickly leading to the 3 expected files not appearing. To
avoid this send the next signal only after the expected previous file
has appeared. To avoid an infinite loop the number of retries is
limited.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/daemon.sh | 34 ++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/daemon.sh b/tools/perf/tests/shell/daemon.sh
index 4c598cfc5afa..de61e7898578 100755
--- a/tools/perf/tests/shell/daemon.sh
+++ b/tools/perf/tests/shell/daemon.sh
@@ -414,16 +414,30 @@ EOF
 	# start daemon
 	daemon_start ${config} test
 
-	# send 2 signals
-	perf daemon signal --config ${config} --session test
-	perf daemon signal --config ${config}
-
-	# stop daemon
-	daemon_exit ${config}
-
-	# count is 2 perf.data for signals and 1 for perf record finished
-	count=`ls ${base}/session-test/*perf.data* | wc -l`
-	if [ ${count} -ne 3 ]; then
+        # send 2 signals then exit. Do this in a loop watching the number of
+        # files to avoid races. If the loop retries more than 600 times then
+        # give up.
+	local retries=0
+	local signals=0
+	local success=0
+	while [ ${retries} -lt 600 ] && [ ${success} -eq 0 ]; do
+		local files
+		files=`ls ${base}/session-test/*perf.data* | wc -l`
+		if [ ${signals} -eq 0 ]; then
+			perf daemon signal --config ${config} --session test
+			signals=1
+		elif [ ${signals} -eq 1 ] && [ $files -ge 1 ]; then
+			perf daemon signal --config ${config}
+			signals=2
+		elif [ ${signals} -eq 2 ] && [ $files -ge 2 ]; then
+			daemon_exit ${config}
+			signals=3
+		elif [ ${signals} -eq 3 ] && [ $files -ge 3 ]; then
+			success=1
+		fi
+		retries=$((${retries} +1))
+	done
+	if [ ${success} -eq 0 ]; then
 		error=1
 		echo "FAILED: perf data no generated"
 	fi
-- 
2.43.0.429.g432eaa2c6b-goog


