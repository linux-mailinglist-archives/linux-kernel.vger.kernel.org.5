Return-Path: <linux-kernel+bounces-134365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548789B0B6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C4EB214C1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558102C6A4;
	Sun,  7 Apr 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Cyax/H+Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="KhnIXrBU"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FF2C19E;
	Sun,  7 Apr 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492348; cv=none; b=IOM3Ngy1U/b3DwIEv76xeY6NWlpc/4JxO1OFlNz5f31oEFX8JFgVCNBAIaGvzSwhyQYUEewfk5zejvxKBPmquejs9Y9scyigEydFfg/vACUEwZINXCmpsnOBApdfEe0D/7s6EiSYOE/G22dAD0qmehrFzq2/hH2e4NwI7aO4b04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492348; c=relaxed/simple;
	bh=w5Zn22WWj7w05leupcr7VGf15okWuJstVq9VJGRWJo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RIsNro/k6S/kNKKB0Zuw8duA4JMMyTLkrjYbuuYvUPBiEFJa0RLraQvjs5szEVD6P5LqnTMXrWc+Pm5zp2HcXO+iKF9zHBQfGSCDye/Oih5EJYEnVvMYWKBIq2CzH4nFhngHUNjWhdExS+1/rh1BUa5RjRLZTuCnoQuB2LE5Crs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Cyax/H+Q; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=KhnIXrBU; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 937BBC024; Sun,  7 Apr 2024 14:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712492345; bh=a7MS0gbG0hu3f7XINu31Ujv3Gow1bMpNC1YjoG+hAyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Cyax/H+QzHjRht5/enmstCvaq0twK2hf5Fa++UfzQiiqINCqk6Bw71EmtP28XIy79
	 8+Cl2bOBrQ/Ua11IjKPzwh74JJQojpBqNGdF9/xtuhcIScjqB+Hn+lQ4CzgP3kO32c
	 O2kcC0Ha7AhLmtF7okr0HO67KsDDP5fDbwl+GViCdBNjgkJboa/QFr7Nm4i00PsuE2
	 RJrSSGOlYC5rLq8/vaEsMdX6PKKUY5wYkxO7o6RRThXvgzuZjBpaeaUBtFORAeRssf
	 ATMjXemckqm0hm3DiABZqdNPnl58jCBapgpctmgyw+j4uzbxvry7OxhiqZsrCEbbou
	 IrDgVsnKUUrRw==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id D05A1C025;
	Sun,  7 Apr 2024 14:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712492344; bh=a7MS0gbG0hu3f7XINu31Ujv3Gow1bMpNC1YjoG+hAyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KhnIXrBUGjiJYFbQBL8j2EkSl/MhtE06FkJAGbZ4Of8sr4q1VJrhUAB2XSeYjxWj2
	 +n50IbctlvX6DBXkEru4fFj0UYisz22rH9rKsh4xr0ueMjRmxGlhV5f/zIoHiks1Iw
	 Ns7aJ9sYmmksMrRBTMvsEQ9V7ImRLZi4CR2IILoVn5c9uPWbJgmEXKLZH1agsIEM4i
	 3+w1YtnIHLAtS8pvav+Y90aGoClEOQ6K8ajsOKcP0Oe7MOm66ycBFXkudYJ0EHLmq2
	 777hegniVg8u0b6y5sVoIdMQU2YbCUPyYxWqqoa0js/DPJrV9NmGS04S02vp5Wt+oT
	 eTHoVrsP2Hd8w==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id db87db60;
	Sun, 7 Apr 2024 12:18:38 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Sun, 07 Apr 2024 21:18:21 +0900
Subject: [PATCH 3/3] perf parse: Allow names to start with digits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-perf_digit-v1-3-57ec37c63394@codewreck.org>
References: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
In-Reply-To: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=w5Zn22WWj7w05leupcr7VGf15okWuJstVq9VJGRWJo8=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmEo8eb3DyARjfSxS7XoZUAZqEO5aTXazPO4Awl
 cVasWS8B/6JAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZhKPHgAKCRCrTpvsapjm
 cPXkD/0VzdFZbxx3ZK7tEX9ErXA1hSu4NV+bFosKN41gxD7lPgvfL77ogj3LbPw+1RIRyY0JLxl
 M0/rm9ixXIU1qsch1I9r12PIsa2x0sz+XOEwtPoDCUWogwd5ZpZQqDiSea/mI+d1/QhMZcLpoMJ
 uhL4mQJ34iNpGGXp2DijKYbUZkUNDaAQLjEHZSWr1gAx5zKO8n06VYH8tvgapjZOYx3goGLHvS3
 EleYhJID/tNC2bu2yOPUKloxLiXGbxjV9pZok8qFyxV6h4lMksXn0KFE7UN6WAW1UYimqNtR24I
 AZmwDmm01BJcpwQQC1VBgPsMQtwmtxeIoz1+Y2v57ok4GxFQWt7dSwdaRgaXNTu15/W6XyoNPtf
 RSK0RlgTeZBYvsiiao/lzdi+XCvkJ0cliIKbnK+a9KObiuj34yLxRQT2q56tFbYn1pX7Th1mV8+
 fAWNhYZkBY7mKt1WdAWsxIorO4sJfyaiDw8Y6+O0ir8mpOtTCz5bUUi+heZ1WkZV9xNYmlsWd17
 4ELEa2TWgLD8vnMjgQkf2l+gJbN56lwpH4CJu248IV2Z4CEJ98s4lWBMgG3j+zQ6EY3FQvQ17Np
 XaZj5Cn1KxGLB/6K9EOcNLXB5AudQJnAYOmyA+SSHWVn5bQWNHIbJV4tfKTWGfSFASA0J3WNmW6
 rZ1WahTRoM0K/HQ==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

Tracepoints can start with digits, although we don't have many of these:

$ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
net/mac802154/trace.h
53:TRACE_EVENT(802154_drv_return_int,
..

net/ieee802154/trace.h
66:TRACE_EVENT(802154_rdev_add_virtual_intf,
..

include/trace/events/9p.h
124:TRACE_EVENT(9p_client_req,
..

Just allow names to start with digits too so e.g. perf probe -e '9p:*'
works

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 tools/perf/tests/parse-events.c | 5 +++++
 tools/perf/util/parse-events.l  | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index ef056e8740fe..6cf055dd5c09 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2280,6 +2280,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_2_events,
 		/* 3 */
 	},
+	{
+		.name = "9p:9p_client_req",
+		.check = test__checkevent_tracepoint,
+		/* 4 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index e86c45675e1d..41c30ff29783 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -158,7 +158,7 @@ event		[^,{}/]+
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]{1,16}
 num_raw_hex	[a-fA-F0-9]{1,16}
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
+name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!\-]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?

-- 
2.43.0


