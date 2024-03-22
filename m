Return-Path: <linux-kernel+bounces-111635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EF4886ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADB51F2426B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B34481D0;
	Fri, 22 Mar 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uClOB4Sv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18643AB2;
	Fri, 22 Mar 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118491; cv=none; b=pTNPkxfT/UEjD/jdmmdgCrqx6bYMjizeAx7Ec+aciMcsvDtTNZV0brzWg+0Ycv3z1mnE1Mxr51HRbyXJQuUbTPOSTv8MaAzs1LSeKF5b+LXVGF0tqqBI/8qapmKijkPzEB8dXxmDrpEdTl3YvN4Jpp8S28nN2gxenQ3j2JoZLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118491; c=relaxed/simple;
	bh=16sLAJcl0MZQgKUeoiTBiaAboUx1ep7Ye0HMAREA4V8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S1k2HpR1pozEGqf/MOXb/gdoJe7bcjhcIaQzL7drH3wx3J1qRkzF3sCiijMm16QRo+UdxMYfjtPlXqlLezjqkp272AEuc/4t7ANAYQFofz+A2RmvvBZvy8bvUJVB4zbZo/im4I1h3vlDCcOB101QlBD3xnmqlGRVf4u6nHD46gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uClOB4Sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AFAC433C7;
	Fri, 22 Mar 2024 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711118491;
	bh=16sLAJcl0MZQgKUeoiTBiaAboUx1ep7Ye0HMAREA4V8=;
	h=Date:From:To:Cc:Subject:From;
	b=uClOB4Sv+zZ4rnOX8xMvFEwzdJPT3kwncTdtyNEgDTXPp0xL2GU1JM/AN6oSXpOTf
	 GlVCcIJbK+k9BZt3l++rnnHVF0XOvG209+2YaWrmT2vrcT4Km6ZP6b2sKRNFWb7Pks
	 Bi5wvxmZLGHyjLhc8hBqE5474QfMne8Tye67nAae4Jt8fO4whInWB7pcdYrtT8Qhri
	 JsHKo4CC9C8grs6mkdDix+55p1FphgJnOOzZNIvEdxE7p6Vd6PifmHFxToieIXwVns
	 RdM+Vzz5LWQc0SB3uIBvWpiHEwBGgyG1LkqQjqSsZvo7oxlQx4A3tSIuPeTEEmvwxC
	 fVoS+ML4ZY2LQ==
Date: Fri, 22 Mar 2024 11:41:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tools: Add Kan Liang to MAINTAINERS as a reviewer
Message-ID: <Zf2YlxkUObfNqFgC@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kan has been reviewing patches regularly, add him as a perf tools
reviewer so that people CC him on new patches.

Acked-by: Ian Rogers <irogers@google.com>
Acked-by: "Liang, Kan" <kan.liang@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43b39956694ae69c..91a867845d0c2ab8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17264,6 +17264,7 @@ R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 R:	Jiri Olsa <jolsa@kernel.org>
 R:	Ian Rogers <irogers@google.com>
 R:	Adrian Hunter <adrian.hunter@intel.com>
+R:	"Liang, Kan" <kan.liang@linux.intel.com>
 L:	linux-perf-users@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-- 
2.44.0


