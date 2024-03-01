Return-Path: <linux-kernel+bounces-87936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD3A86DB33
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF5282D07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517655E46;
	Fri,  1 Mar 2024 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQLSYKDJ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298554BFC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271430; cv=none; b=KjWWl29lRotJbmej+aXiWnhZCpHkoIqn5w6FxKV1z3d34noQLCgYjYFV4AHMejKkNjD8qvSsz0gpgBs37ctlu6TtM7PSWGE2GxNwpDVQonnOGpnWLK3k/H+5Bjk37U+9svxTLy7r71o5Q99wH9+gMXPKUJxFD5aVfWQpHN7I0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271430; c=relaxed/simple;
	bh=GIegngHqtLjHARUsBjYE1nUvvYzurvCdwBU55T25Zws=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tfJmZsougO3t0uGs7ymIe4kf0sHMfA1TuD4Ymg/grxcW03l2htl1RxGlZ+z2Sf2byy2lywubZ3/TMoa9PtQXsfGzHF8ZF3mwDcj47+lUqRDya0Ds7v9yjnOliQM73t/9zWC1El7+ECcONOG1R0+eoA2+F9tqRgWwNdmp4ilGG1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQLSYKDJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6087ffdac8cso26288767b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271427; x=1709876227; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3EeOnj2LJFuh4Gzgf1odB7yRFHxb61zXSqdlmTf/sY=;
        b=xQLSYKDJmoaE+yJNvdjYjShfCm7eK04b3GLGi2U3N5GvAS9YcB8vCk7OpmItFobhts
         195HdHsABF1tJrM4Bh1DlxbnjDClsKPi/EBzuwfmvOo2JpRXoF6pGIB1DgwxZ8eJJ0N7
         CklgfszI1bqzu19u3ftFqEZB1edr00ki94uK8WaTnVcVmj51booCGqpfjzrwLhF2pBsV
         xxgQT3Ip7mi5zeAtgP9o8sYqF6IvW8WEzWDWFd1HELnTgHOtJwA1HwMmfpY8gADj7T0P
         obIEV+00Ihr42PS5GNDphI2YNA+7meByKQ/Wc9Mn4APnr9JFJ0C44WW3hlikRxzXIPSF
         DmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271427; x=1709876227;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3EeOnj2LJFuh4Gzgf1odB7yRFHxb61zXSqdlmTf/sY=;
        b=Lalglhs8nVshL2VQhlSodGKppLRUkWN4i+HauC4sXreSNFAR3wOIAoatyr05CXPGVX
         Bu5x0Qyq7pXEoCqsvYmyI/EzZaNslTXwfpQ9UrnSXuoTWrWgyyIh6oNrLIHaH1C8axie
         Z2iyghCRrpmLeOhuRi4/zmkRZBoTDc6T7goqYG6etMkS7nUfTTtx+ajRt9gUpwhnNImq
         7Olpg6PyUk6wVlGjaC0Nv+NEi3D4b8hr7rPFXHtYT79Sd8Dbh7ekSimMWgmZBheMmDjs
         6+1fdZPP9ycndS7y/WpGm4Anxxi2i9iaRFKzPsjOjmltjiBCpo/IuYhKMU+IgvO1O/+h
         o0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXc/9LijPozSai6GdZiPpawDZpPxM5wM4AgaWIqnVx4iQmd0B8zScBLksOzrE9WTFNVlCoTASA0S4js7I56cLztW430Xzghu0DmWZi9
X-Gm-Message-State: AOJu0Yy1wnTYkCGjfyD11rqh52XCYz/Gq9Cfk8UR7DrG+Oj1ir2GYMgL
	IbeWgST3SLTHIZfN0fCQRvksVWvh5XYkeARqfFhOW0KbVDNxFTrCpRDrrM5Vi1+CDacSUvvnuyq
	c6lLbDg==
X-Google-Smtp-Source: AGHT+IEu09qcHpz8XVF0bJYUs01j219s9OVd3W8pW3osKdThUV9pFvDfs+miQGs9atOQylZEGB8D3SP3TfJK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:72f:b0:dc7:68b5:4f3d with SMTP id
 l15-20020a056902072f00b00dc768b54f3dmr130791ybt.11.1709271427758; Thu, 29 Feb
 2024 21:37:07 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:45 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 7/7] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.44.0.278.ge034bb2e1d-goog


