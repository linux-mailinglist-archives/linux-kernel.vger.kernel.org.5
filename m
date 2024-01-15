Return-Path: <linux-kernel+bounces-25676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B882D483
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA9128162A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08C14428;
	Mon, 15 Jan 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKggr1Zn"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB583D62;
	Mon, 15 Jan 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so2916559a12.1;
        Sun, 14 Jan 2024 23:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705303394; x=1705908194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3zxCYUmaML8ov7vohntDD30tq3BZHVZqgdXMQmkL3E=;
        b=SKggr1ZnwUygXw5Kbu/Tw0lWbicsNwsRjb+cgNK+jAhgPDec+brrzIisTeoE9YOPXH
         njkdyFvOe2t4FNobaLIyZjB7+XrQOonPNTcm+LqVPAixyE6SqR+XUslosdkJXKf0SeEC
         xaCbenkiUNQyFVOXPVRs0YzYRwil0yiMfmiKPsX1GDABNR2qsUUcQapBWdGp5ByB9aWE
         UYPWDutZxFkWKK7nbtbiqauogHLM8d+9pg3n7XkJA4vao65P4fOw/Dyo8VxRERgx2h+y
         0S33SnDIeMXXFvfK88TNsqmHD6mUwH5fRUV0Q+cldw8s/c+xjPXdcdjBNwWPKsdJ0G/a
         GoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705303394; x=1705908194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3zxCYUmaML8ov7vohntDD30tq3BZHVZqgdXMQmkL3E=;
        b=u6dfTutwj52hTKioskZDVEaj9fs/EAoOc4l0DzuFwKwTs+3KUGoY6KLqlp2oUtow2R
         W6RMtbphmdS9UCdOCHry3eijza3w6gp3Vk3Le/uSwCmvF3lK+2J9BnPaEtNvFScFQ7xV
         AF642LKegupsVj+b/AmxunT78JkupHfuxVwSw2RYXuWWMg9v3/c5DT/VbHVdFLVjuPtx
         W9hbuvwRMK2cJvgPqeDdNFg+jksTIW33kuqnAYu2835xRJ/w36M8ovzh/xQDYcMfyoPc
         eUWkfYHQhK4qx/1OmZHrrxy6Xdqd8QdVilJ+P1LKwp1+owG7PPPgSjQkFTTvroK3zQWX
         AVbA==
X-Gm-Message-State: AOJu0YxnayXrfwq9zdQTYpcI3q6C92csTECGsigf8uvoc9hyALfstPbm
	c9rWJ6RlZLTAZ1H3CDTJ2h6AnA2eve8Ff/R+
X-Google-Smtp-Source: AGHT+IH4YCLsBQ0/rvbCMji8had+gIVZ5KIpUrEMPF6T8Sm1IIjK+56a91AoPq1tBjAuqqdV1/FxEg==
X-Received: by 2002:a17:90b:1986:b0:28b:2a79:dcd with SMTP id mv6-20020a17090b198600b0028b2a790dcdmr2461709pjb.67.1705303394200;
        Sun, 14 Jan 2024 23:23:14 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.googlemail.com with ESMTPSA id mp13-20020a170902fd0d00b001d4ac8ac969sm6990545plb.275.2024.01.14.23.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 23:23:13 -0800 (PST)
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
Subject: [PATCH 0/4] perf sched: Fix task state report
Date: Mon, 15 Jan 2024 02:23:02 -0500
Message-ID: <20240115072306.303993-1-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The problems of task state report in both libtraceevent
and perf sched has been reported in [1]. In short, they
parsed the wrong state due to relying on the outdated
hardcoded state string to interpret the raw bitmask
from the record, which left the messes to maintain the
backward compatibilities for both tools.

[1] has not managed to make itself into the kernel, the
problems and the solutions are well studied though.

Luckily, as suggested by Steven, perf/libtraceevent
records the print format, especially the __print_flags()
part of the in-kernel tracepoint sched_switch in its
metadata, and we have a chance to build the state str
on the fly by parsing it.

Now that libtraceevent has landed this solution in [2],
we now apply the same idea to perf as well.

Regards,

        -- Ze

[1]: https://lore.kernel.org/lkml/20230803083352.1585-1-zegao@tencent.com/
[2]: https://lore.kernel.org/linux-trace-devel/20231224140732.7d41698d@rorschach.local.home/

Ze Gao (4):
  perf sched: Sync state char array with the kernel
  perf util: Add helpers to parse task state string from libtraceevent
  perf util: Add evsel__taskstate() to parse the task state info instead
  perf sched: Commit to evsel__taskstate() to parse task state info

 tools/perf/builtin-sched.c |  57 +++------------
 tools/perf/util/evsel.c    | 146 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h    |   1 +
 3 files changed, 157 insertions(+), 47 deletions(-)

-- 
2.41.0


