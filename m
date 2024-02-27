Return-Path: <linux-kernel+bounces-84084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38B86A211
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1299D1F24987
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244E11586F5;
	Tue, 27 Feb 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9gcvNa9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A421586D8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071338; cv=none; b=lBKbvWSwESAOEvOaZtGEY4uhbbEtwudtfcPm2UrfdDdA7CzPB3BBBzPbzRje+T343GNSzHukU2madJN8cgJkf53+1VRL024+/dS5oIc6blsGBP7lgVOEEITjyIqbFeb84r61Rwszzmijxc5/rMclk7eeFn0PBrBgWNTkDrpEpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071338; c=relaxed/simple;
	bh=upLg+yhe8A2OZg6p8OFlrhH2yLDrE7BI//l8P1Vylms=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pqyLHTrrjGbQ00RchUxraYd6c6gAvL0DBjILF6gWxAlW2psDGK3kutau1ZdVPGmOTyE62sY5kb5IXMu8o1QdYrPhjhR8id/bYvWAzAnY5xqFxiZKiMDRvXpR+NCUT/lS+9sXL5r0O6PAUbhBqWHq3nBnvvM1Ae134HZ24IwzDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9gcvNa9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso9048506276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071336; x=1709676136; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCV6R+NKRLMYoVC59mA+bYuzdEe0EtrTOitlrlnnMsA=;
        b=s9gcvNa9lW/PIzWihQTBqJP0VhTkZpQ2bDTsbEkPcpPLqGv6NTqfIF9gX+jC0MYySl
         osPkLoPBNizf3K41BZSSLigRaSaGT1Qgn9qYm59CQODGL5LG0zYf6iSoQuyc1c5XWaTT
         TGaQukHZ1EJmX6+JatByB8EPKyCCGxF/6W4NW2krDMsZyfSS0Puzq9ziNCM9koeX4+bd
         a3m6oPYQDeFKyHAykaE2jJN3Ub+EOmpJqxC+j5xjSvgVUIi+U8m0pv6MByvY5wiwAWxH
         thikawX9Nj/Nm83tyMYSPhDXLrrW1TrwDhQ0TjXJs84drugGC6t1l/sekw811eMQguc/
         ZjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071336; x=1709676136;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCV6R+NKRLMYoVC59mA+bYuzdEe0EtrTOitlrlnnMsA=;
        b=TuCGVLZGBMMjIzrwm5aTz8fvWfUzCGFDtb1tkLAQlyNJ9RgUitKxkxEFzhZ0zj8Zjb
         sW5hmNOJFx4PntZBuNqKFTSdg4G1TNDjFxqoGty2rjjo5gizHGiaizj+PJrMD8cLInjK
         C610vH0gbGU8cOxhPlZCjBbnbbdXCx5g3hVSejI2zVy1C7liUcpASJf4z40MiXVvUra8
         nYETtHvchs1eL2ZjAJHO49SrG4TzA/eqnYL4qDMrdsu9+P0cWA8AjHQZGdlt26uTGJgI
         DDnvTq63LoQ2pVO0H2bxtGhUNJxVdBA76kQwZ8HceZm4P2S7LeZLsFndPOwx3MaAos/E
         RaSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWGOFdr6iIIcn9SkUvWRCkzR7cn4SYo/p7nEDmG1QouUEADxUQMSPCqCLTEKIYKM1LKjekI34vBA85UpmrU1yniVp7/jNqO1zto6u3
X-Gm-Message-State: AOJu0YwXcQaVN8i6kAmF3TsrYyukjn3Pgnf8Nyy18E+r3cfU3k4uYtzC
	+xuOjoISYUNIfHiUAJVJ3UCoDrn9ty/PimqSK5NhcPYO5L3uJ963OqZS15mm+zM1BIK/k2PIW3j
	yO9ECGA==
X-Google-Smtp-Source: AGHT+IGEhA+c0sAKulaM8RvsHp0DR9xq8SYgR2yBjBN+6kuK+8Tuz+x8EH8gmVr1C3hn6lBPKxh3uS12sCNZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a05:6902:1204:b0:dc6:cd85:bcd7 with SMTP
 id s4-20020a056902120400b00dc6cd85bcd7mr220673ybu.3.1709071335967; Tue, 27
 Feb 2024 14:02:15 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:50 -0800
In-Reply-To: <20240227220150.3876198-1-irogers@google.com>
Message-Id: <20240227220150.3876198-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227220150.3876198-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 6/6] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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
2.44.0.rc1.240.g4c46232300-goog


