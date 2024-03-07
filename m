Return-Path: <linux-kernel+bounces-95961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3A87555C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189501C2444F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F0013329F;
	Thu,  7 Mar 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tykL8nx3"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F381130E24
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833233; cv=none; b=Tp1eO1Zhfkf4M2Haf+6rvH4GiC6/ScL+L+RNTDxCjYAtS5bkWAITuxV1Stcc6C5hvey2rHWYfSx7QidYBe8B1YAZQcwXHQf3BeAYirb8+wYlkMHqfyKwlX0INaPEsNVRJSEBn0x6DniEwGtkkZ5WjPNzM+9yRMtPTipOURspOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833233; c=relaxed/simple;
	bh=FRTaxqQ9z0fdBOTvorH6lKFlBCFvX2RUJshMGjEelbw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FhOvW6gvBB1xNc3XehDjwn0XeuouSqyOSmFFQmoMtaSIHULXLm5cDWYTWdY6RtCZc/mJKIfBavNXziCDOEV785TgiD4jQatS9fTNm3hM7Q1vRbx5vu8vtgNifT4dASWTnMMBXPnyFf6U/juhUxMh1HsiujS+zZMI2lB2UqanLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tykL8nx3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608e4171382so18079307b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833230; x=1710438030; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMafHwnxZN4CIEYFiJO7IENRNxeo2KK0p3Rv7PcNfpc=;
        b=tykL8nx3Lxmlbhg/ZCcq5S1PjFn+xnzTOXsN60VZEC9SuTp5pVRQNfLi6hT60+W+u+
         Qoa39y4717dnKRSLIieopMSabY8/VcAmEu1V+RCX0v+rI5Mcd5o/wy8VrycR0ct1ST9/
         9S0pJhhnKjMh3tlWPPzDYs3uujPnThhlTUYjweLGmNI992lh5AWgagOh6/CtNfivkcvl
         l7YjTe85okN32csOLud2/XOIpLQeH8/s30T7aUkx06aU+L0tEBskYWtmM4kTijPCESc1
         boIXM8cBgjpxzf+SzWnSlZ0ZsSxj+jOVz4theRY7TwdfvWQodQ2enq2T6SYoab+QGONE
         c/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833230; x=1710438030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMafHwnxZN4CIEYFiJO7IENRNxeo2KK0p3Rv7PcNfpc=;
        b=JrIJT3QN0jTHt18eHNUrnlHPYrmGnaxaNQNkR72xKe1h6w6Ke4QTPToqIq5FtjEcLL
         qP5UudnnUuO+MYX/j04h8/YivyaWhPHBJKDAvvffb9akgkMqagXcGkPelZm3pfeYdEyO
         hh63IcJXYd4bbSKfoTqZp9ahGGsb3DwXPfda3FcwXWom2sn0obCnBEGKmUJlbfwCVN22
         ZVjMjho5+icv9kmHe2UNtk12nQbnELr1HrQt05JY8mXagSvRG2u6iV0FkiqGkQwhwupm
         SJuhr31zxce3NG72u2yf7kowUOc1KeF2Fhkx3M8t7L9Y2GrEaapDm2O+a+mvpacf99YV
         jw4w==
X-Forwarded-Encrypted: i=1; AJvYcCX13hy22mR0IiF02Py3jL4/wdlN6BEAvYJ5YOz/V+ABpb9PvxjMnrLE9b22aCLO/jdRB7fzMIkCydnwAZM9eFGLyNxBwTlh9uwpwNnL
X-Gm-Message-State: AOJu0Yz7qgSCqA5jS+LBbV+k9OHwmTK7lZNNGyaDCv7N89iqNvX+cvag
	bN+RGR6z5/n+3I9oOPMEs4iRspikSO3MxKxYgLZuJuoHqwM3hTkt+vc+Z08xJlyBE+k7ogpGTuY
	QjALOqg==
X-Google-Smtp-Source: AGHT+IFsavMJluR8mAKN+8BZP435zJgd3jnYIlb4VLH0oAUuObBtrUSpcNLiEJF/6LxQU5VIFDyxCLzLZ+XX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a81:9945:0:b0:609:781f:a7ab with SMTP id
 q66-20020a819945000000b00609781fa7abmr4000841ywg.1.1709833229919; Thu, 07 Mar
 2024 09:40:29 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:52 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 3/6] perf list: Allow wordwrap to wrap on commas
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A raw event encoding may be a block with terms separated by commas. If
wrapping such a string it would be useful to break at the commas, so
add this ability to wordwrap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 02bf608d585e..e0fe3d178d63 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -22,6 +22,7 @@
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <linux/zalloc.h>
+#include <ctype.h>
 #include <stdarg.h>
 #include <stdio.h>
 
@@ -76,26 +77,38 @@ static void default_print_start(void *ps)
 
 static void default_print_end(void *print_state __maybe_unused) {}
 
+static const char *skip_spaces_or_commas(const char *str)
+{
+	while (isspace(*str) || *str == ',')
+		++str;
+	return str;
+}
+
 static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 {
 	int column = start;
 	int n;
 	bool saw_newline = false;
+	bool comma = false;
 
 	while (*s) {
-		int wlen = strcspn(s, " \t\n");
+		int wlen = strcspn(s, " ,\t\n");
+		const char *sep = comma ? "," : " ";
 
 		if ((column + wlen >= max && column > start) || saw_newline) {
-			fprintf(fp, "\n%*s", start, "");
+			fprintf(fp, comma ? ",\n%*s" : "\n%*s", start, "");
 			column = start + corr;
 		}
-		n = fprintf(fp, "%s%.*s", column > start ? " " : "", wlen, s);
+		if (column <= start)
+			sep = "";
+		n = fprintf(fp, "%s%.*s", sep, wlen, s);
 		if (n <= 0)
 			break;
 		saw_newline = s[wlen] == '\n';
 		s += wlen;
+		comma = s[0] == ',';
 		column += n;
-		s = skip_spaces(s);
+		s = skip_spaces_or_commas(s);
 	}
 }
 
-- 
2.44.0.278.ge034bb2e1d-goog


