Return-Path: <linux-kernel+bounces-166190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C78B9759
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46961C2132C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D2B53388;
	Thu,  2 May 2024 09:15:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4D0524D4;
	Thu,  2 May 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641311; cv=none; b=EitXEjO2KWSghV62T+FwAk/cUkgpBUq0cwf355LrYUKWYL1tNLuihwpAUPAZF5OO7lM6eW4WJMeFl0hp1h8DojDRaRGgiAPDDAQtA1y/Oe68NdpUWwcjBFmTDl5WVVHY3aghCQsdnu3/U4LMAK/tsQ8bohgDlfLYIYEjMZwr3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641311; c=relaxed/simple;
	bh=nVP7nBF0pVr37MYjs2kfu9gN3RzhtanHSJ8hO8bCN00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bp6Sqfxhx6QDER+twJ+71pwhHLIoIncj+goLpunX+Nqnvj0FjoNmEUS0rqnYqZ6MUO2M3SAB8d9JJ5a35wP3lpMAQ7uB1ehwPDvDfSwoSbmEd1FEYR6LZVo58ljYwE4+wluk5Y4uPCMa3JDGIiKSa+/TdBa3On3LyICr+Mu5Om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8E742F4;
	Thu,  2 May 2024 02:15:33 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.cambridge.arm.com (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.3.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B60853F71E;
	Thu,  2 May 2024 02:15:06 -0700 (PDT)
From: Nick Forrington <nick.forrington@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Nick Forrington <nick.forrington@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v2 0/1] Perf lock improvements
Date: Thu,  2 May 2024 09:14:44 +0000
Message-ID: <20240502091446.3037-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improvement to command line handling for perf lock info.
---
v1: https://lore.kernel.org/all/20231031120526.11502-1-nick.forrington@arm.com/

v2:
* Drop previous "perf lock report: Restore aggregation by caller by
  default" patch. Not required for newly collected data with LOCKDEP
  tracepoints.
* Display map and thread info (rather than an error) when neither or
  both of --map and --thread are specified.

Nick Forrington (1):
  perf lock info: Display both map and thread by default

 tools/perf/Documentation/perf-lock.txt |  4 ++--
 tools/perf/builtin-lock.c              | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.44.0


