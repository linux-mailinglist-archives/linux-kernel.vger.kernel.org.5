Return-Path: <linux-kernel+bounces-155824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365948AF79A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E401C22287
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96D142911;
	Tue, 23 Apr 2024 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2JHEjex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1341428F9;
	Tue, 23 Apr 2024 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901841; cv=none; b=IQhgU0DdTO+FhDh+mCOk8/9Yqqsrri0FpAiigr6ibznRmwNd/6wfyOVxYy8uo4BjZpq2PL7fdTsXlJiHo0e6p5S8QjjvfIre6H/RrwC2JWZvoXhKLxczhUDyJCSzk35aPhunyDOm8U8oHCi770ESj4zyp3ULra/dgYPi35Ws1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901841; c=relaxed/simple;
	bh=RPaFNS9l/BHH+6nZhjyJZOUREm/YUaPsrUWPbkcilYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IW/VJJ8Se2Degub6MP1cWUGPVsoJ9UeuXKFImWapDyTkbAjZqMBTZ2G7r6XQ0cU5q5EckxnUaKF920Wiztf4xQx75XQyHhnT4FRGncTTqHcEtHKZUek7Ta1IoS2UGEGsdTA0Ezc/BFyx35UNUz/YCftua6MHxqK10cMWv3sARig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2JHEjex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093E0C116B1;
	Tue, 23 Apr 2024 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713901840;
	bh=RPaFNS9l/BHH+6nZhjyJZOUREm/YUaPsrUWPbkcilYs=;
	h=Date:From:To:Cc:Subject:From;
	b=a2JHEjexLDd6qO3qFYKtoRZf4jresNmlwdDrp+HTUvIG8F5g4XaH2HXrPc+6nhtkC
	 cZds7n3Ru1hd4uM3tFzuwY6H+OUMRkp6yhdqD4tmtZqw7JkIXMFPElad6UcNMG5+Au
	 NeyrpsMdht+FzPi4E1GLbsY6lhxdrT7gxJytrg395W8UrolAtKjAxG7mwNsWiA3+rc
	 fstA8r2v4/aqcRjNPWMB1dJLbIZ356ZeYfBMpPKqF/IvHganb1CqJPhVDe2mYW7esw
	 cI6kKG8vfLSom8AOR1nFES/LUr88JXoV67DqW4cyNqIPEGJ3LkIMibfNLJXE76E+fY
	 lPtCkIBjKVmUA==
Date: Tue, 23 Apr 2024 16:50:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tests shell kprobes: Add missing description as
 used by 'perf test' output
Message-ID: <ZigRDKUGkcDqD-yW@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Before:

  root@x1:~# perf test 76
   76: SPDX-License-Identifier: GPL-2.0                                : Ok
  root@x1:~#

After:

  root@x1:~# perf test 76
   76: Add 'perf probe's, list and remove them.                        : Ok
  root@x1:~#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/base_probe/test_adding_kernel.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index a5d707efad85cb40..63bb8974b38e0b0d 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
+# Add 'perf probe's, list and remove them
 # SPDX-License-Identifier: GPL-2.0
 
 #
-- 
2.44.0


