Return-Path: <linux-kernel+bounces-134362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9989B0B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BADF1F214AD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB958225D0;
	Sun,  7 Apr 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="rsIuPVSV";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="wAb6PB3x"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56023D69;
	Sun,  7 Apr 2024 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492340; cv=none; b=oynhvfzqynN1Gty0Xsnbabc1ZrPs476lV57dL/q9HNAFHkXTnSK89QRj6MU4efEBTiVlk82xOA+aXyEUxN+dw3w4ZJZZzWfEYu0GZqiP6PQfz0RUCi5mZ9TsW+12R6IrLASOOL1nmClO20RrVOj1Fx2bup2BwtppSehZKo/yXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492340; c=relaxed/simple;
	bh=CB9SVe/1nQccnowqa2Oy0yOfeCmRu1RyfMh4/x6FP/A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UJY7XuaT3xoLPlxEU/XkgpIyhIxMuic7yBCD+cLR2BE4C1T9Z9SgEScmnKyE88rEUIpv/ttgLdm94dq9tnmgJUJZyzSRDxO6DzHa6FtdttiSZMWW8gsantnRAlKrSdJFivLSr1A0D2cDXhUtr9ZCCq9uLLKnffvjzAyTs8Yk2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=rsIuPVSV; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=wAb6PB3x; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 73177C01F; Sun,  7 Apr 2024 14:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712492329; bh=476gbRuIfQWnruL6kbPBxqlAzWZec7nUlTEesb8byRU=;
	h=From:Subject:Date:To:Cc:From;
	b=rsIuPVSVWLqWeRQmVlyDhwPzGm4TXu4FiERvRdU6XTgCMg685Rsi+LAYD7WE5JBSB
	 dRd+I5OZfEHbimtRI4EP+PN+ottTzCuPn7pi37S3rU8SkNNNyPZxX6DoqJzlpZirrw
	 MUvWrvaRgBFKqaLKzWVQlj8QlMgWituGNGX3hdM0uDoOEWWuq5YR6/xNk+qPdIU1a+
	 ysh68T+8joaSZmDNks8GzzjmnP0dz0WqM7IcTOgOPLknMIwHH0FW6OxxZk+P9gblAN
	 ta3IVo+iGIZ9QprVSFD8Rbzm1tISLZKGY6izR2n5YuvAdqxFM1OyPoFbyokaU8I4ST
	 WYdKGxlOf50Sw==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id E6BBCC009;
	Sun,  7 Apr 2024 14:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712492328; bh=476gbRuIfQWnruL6kbPBxqlAzWZec7nUlTEesb8byRU=;
	h=From:Subject:Date:To:Cc:From;
	b=wAb6PB3xxpdvzlZW/pDS0OHO7d65HIWJav4uMGSKhK/hEXLjDcCgDympo99xg3tsV
	 MUrcdxmc5YXjlnDOGpmVvAlnW7+u7//UFB5sNPgy+8dqLQ2eJa1gYL4tCLKIqZsWq1
	 JsBnVhYCXpxH7/yEpW0y+091kgeECIe1IXkHDe2KdLoOdAEI/MqLyAjRAgBDu+6Q9o
	 o2Zm/GOTA28AlOa5XVWd4F+IUM6mvwaz03PeoZGUVZKth8uVfN7iDGt41ZKM/PFOSR
	 rvG6E7CkcLkBK7iQkWy0ZE3z3Gor8y8DH8LNtlNYhI7/mX2LLiXfZMeBawKvzql0qS
	 HayvTUq1zmu3A==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 1674e6f1;
	Sun, 7 Apr 2024 12:18:38 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 0/3] perf probe: Allow names to start with digits
Date: Sun, 07 Apr 2024 21:18:18 +0900
Message-Id: <20240407-perf_digit-v1-0-57ec37c63394@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAqPEmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwNz3YLUorT4lMz0zBJdcyMTE9Mk09SUJDMjJaCGgqLUtMwKsGHRsbW
 1AIdXhYFcAAAA
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <asmadeus@codewreck.org>, Jiri Olsa <olsajiri@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=CB9SVe/1nQccnowqa2Oy0yOfeCmRu1RyfMh4/x6FP/A=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBmEo8enPO1cmisFZv/oCO/4zIoqz3TIhzVByPhY
 bZN0Rt7sGyJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZhKPHgAKCRCrTpvsapjm
 cEfREACcs8tJAf7bxlqZ85mU7XjXzZgnpKnf5hxlEz/1uNAtC3oEOIIjkJIN3oT7/yg4GwQMAu4
 8whERMSEuqNeIA0Lb/yjuY+DFgZ8OJu+6BU9iQ8+3ES1HEIksOH6+FRUZYXwjgqaEMzyP8OWTSB
 /VM7N7V0lAGAVgHFLgqmWRkQM/pNfIR+9rhwOurFdhfDykU5rH7OJwDfQxWqYF5HAQepXZZ6H5h
 eBoN7EUeiISciPkub2WBFuSmSvlBzBS7AsEJ24nZBzEd17VUybKuQUi+RjLkX3v8hepZ0NWO0HT
 XdXJYY3SvoUvgTPavJDHCLQJMBwIZD4BxHFfMipsKNSaVsqsWjNMf+2SAxxem+Pm9aZ42dLNQFy
 Bb6Rp7dOyvxXWhV4X76Tm89daB/yRxmTrxIGL+9AbjTWWISOuIJv02/70pmNq75RFWYU/S+yPKI
 tiW+iM63/SqWj+p0rn4lFeGYHRsmFYIj3OmMKdrw1xbil/Dr3elWCoAZH7adnlE45VKpKCF8P/g
 cSbABwB1Z+h6q5NI5fsvfLNL4v/ogWFoidA4Uk8xS9Z6c9d+apdheA3VhhCkqAVtCsjg8X9uR8Y
 PcJHmkpBARChj+wEuXRUkCMTzSv2XeWk2HCwDaxmzgGJZRq3Z+gmSpQmuAoUzkxu5/JfBeEa1o8
 OcQbOVy09k0Ij3A==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

This is a rebase of the patch orginally sent almost two years ago here:
https://lkml.kernel.org/r/20220612061508.1449636-1-asmadeus@codewreck.org

At the time I was asked to add tests, and Jiri whipped up something to
make the test pass even for probes that don't exist on most systems but
that ended up never being formatted or sent... I asked what happened of
it and got asked to send it myself, but obviously also totally forget
about it myself until I needed it again now.

I've taken the diff from that thread, adapted it a little bit to the
current master branch and checked things still fall in place -- I didn't
see any obvious problem.

Thanks!

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Dominique Martinet (3):
      perf parse-events: pass parse_state to add_tracepoint
      perf parse-events: Add new 'fake_tp' parameter for tests
      perf parse: Allow names to start with digits

 tools/perf/tests/parse-events.c | 11 +++++++++--
 tools/perf/tests/pmu-events.c   |  2 +-
 tools/perf/util/evlist.c        |  3 ++-
 tools/perf/util/evsel.c         | 20 +++++++++++++-------
 tools/perf/util/evsel.h         |  4 ++--
 tools/perf/util/metricgroup.c   |  3 ++-
 tools/perf/util/parse-events.c  | 38 +++++++++++++++++++++++---------------
 tools/perf/util/parse-events.h  |  9 ++++++---
 tools/perf/util/parse-events.l  |  2 +-
 tools/perf/util/parse-events.y  |  2 +-
 10 files changed, 60 insertions(+), 34 deletions(-)
---
base-commit: 7382f9ae4a924c4fdc37f303db019170ce374167
change-id: 20240407-perf_digit-72445b5edb62

Best regards,
-- 
Dominique Martinet | Asmadeus


