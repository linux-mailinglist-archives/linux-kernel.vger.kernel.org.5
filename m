Return-Path: <linux-kernel+bounces-136613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD1889D62A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EED283E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5280BE3;
	Tue,  9 Apr 2024 10:03:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B15339A;
	Tue,  9 Apr 2024 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656984; cv=none; b=DVE1vfQN3vmXNM/p1h7f7H5UOHWd3fom12stDxdEA1i7hWzaOEXH2H3dHMNfK1yZK4jXog1gEMzRcDOQcNI8Jmi2l0om2aOT++akPkSvjf819/obehYLeLtCTX+1SUCVvAltqGX9gqeIzIxN06HwnvxqggScoYEKzsHsaBKQsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656984; c=relaxed/simple;
	bh=dS7hsHyjh0MX9By0wsckkuyBat67T/GfrBNQX6U/xRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MCuCoycrJnWjcUCP3iD1hs+00Zwy2wS6nnUpD4uOga/6w5LmyWatgCNrMY24i1US9MDCOPOivEu6vLUa5zlgYdmeGpSkIB/eqIlwovkVAUw2t5JPVcsDlqthpcbkx4E4sH98CO/N4hARE/Y1Lz5XX3aHGEfpCYQZWSsTPT2lRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FEC5DA7;
	Tue,  9 Apr 2024 03:03:33 -0700 (PDT)
Received: from [10.57.52.202] (unknown [10.57.52.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AF203F6C4;
	Tue,  9 Apr 2024 03:03:00 -0700 (PDT)
Message-ID: <4949d61b-6b25-4433-bd2b-a50b4f22ff42@arm.com>
Date: Tue, 9 Apr 2024 11:02:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Add shellcheck beyond perf/tests
To: Ian Rogers <irogers@google.com>
References: <20240409023216.2342032-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, Kajol Jain <kjain@linux.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Oliver Upton <oliver.upton@linux.dev>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240409023216.2342032-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/04/2024 03:32, Ian Rogers wrote:
> Add shellcheck to other locations of shell scripts, not just
> tools/perf/tests. Fix issues detected by shellcheck.
> 
> Ian Rogers (4):
>   perf build: Add shellcheck to tools/perf scripts
>   perf arch x86: Add shellcheck to build
>   perf util: Add shellcheck to generate-cmdlist.sh
>   perf trace beauty: Add shellcheck to scripts
> 
>  tools/perf/Build                              | 14 +++++++++++
>  tools/perf/arch/x86/Build                     | 14 +++++++++++
>  tools/perf/arch/x86/tests/Build               | 14 +++++++++++
>  tools/perf/arch/x86/tests/gen-insn-x86-dat.sh |  2 +-
>  tools/perf/perf-archive.sh                    |  2 +-
>  tools/perf/perf-completion.sh                 | 23 +++++++++++++------
>  tools/perf/trace/beauty/Build                 | 14 +++++++++++
>  tools/perf/trace/beauty/arch_errno_names.sh   |  8 ++++---
>  tools/perf/util/Build                         | 14 +++++++++++
>  9 files changed, 93 insertions(+), 12 deletions(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

