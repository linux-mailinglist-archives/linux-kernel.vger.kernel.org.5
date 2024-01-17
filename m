Return-Path: <linux-kernel+bounces-28471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FEB82FEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FAB1F25B83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC228FC;
	Wed, 17 Jan 2024 02:46:04 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471BA7F5;
	Wed, 17 Jan 2024 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459564; cv=none; b=ovGzjuhdrg4Ce2q722GZswnTteMv6JXF1gZfyEbk9wFH6IssPKWFk/J/67PeBWtYumHZmdsvLV3Fxld079rrzCAYY0CPLbZkGQkp+S/MU7o/GqyNhrTfZD4PfFasHJ0R9EL0lMMCBa61mi7pJNyKZNImujCCecPwRda6Q13wIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459564; c=relaxed/simple;
	bh=L+322wxPKL4eMRTYmUzw04vNs6lJ31cNwDNHzWkMclo=;
	h=Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Originating-IP:X-ClientProxiedBy; b=T+x1guc+wp7RwAbynEzA7NIP1de/zbyuBwU+QKWACU14nJqnYdjTUZ1l+r1ZHXQeNalBIheGZyTgz2i/11TIvxHTZXWBhT7iQ9HzW8beUkUxZfZogvSy58/GR+KnZXflaV3fW/ATvIBaT/R7eEBS6wTa3WT2+JizIAnEo+9ZVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TF9Gq2rBvz1wnCy;
	Wed, 17 Jan 2024 10:45:39 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D746140113;
	Wed, 17 Jan 2024 10:45:58 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Wed, 17 Jan
 2024 10:45:57 +0800
Date: Wed, 17 Jan 2024 10:45:46 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Andi Kleen <ak@linux.intel.com>
CC: Changbin Du <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 0/3] perf: script: Intro capstone disasm engine to show
 instruction trace
Message-ID: <20240117024546.2npqrprazaobyogn@M910t>
References: <20240116113437.1507537-1-changbin.du@huawei.com>
 <87il3tl6zf.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87il3tl6zf.fsf@linux.intel.com>
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Tue, Jan 16, 2024 at 05:53:40AM -0800, Andi Kleen wrote:
> Changbin Du <changbin.du@huawei.com> writes:
> 
> > This series introduces capstone disassembler engine to print instructions of
> > Intel PT trace, which was printed via the XED tool.
> 
> FWIW at least on x86 in my experience capstone isn't that great an
> disassembler. I used it in another project and ran into many decoding bugs.
> They're mostly in obscure corners, but can be fairly annoying.
>
If so, I will preserve the old --xed option as an alternate.

> My other concern with your patchkit is that you change the default
> output formats. Since perf script is often used with scripts
> (as the name implies) there is a certain expectation that the output
> remains stable and parse-able. There are actually use cases where
> the raw bytes "insn" output is needed.
> 
> I would rather define new perf script output types for the new decoded output,
> but keep the old alone.
Agreed. What about these?
  - Add a new field 'insn_disam' to display decoded output.
  - Add params to '--insn-trace' option, that is '--insn-trace=[raw|disam]'.
    'raw' is the default value.

> 
> -Andi

-- 
Cheers,
Changbin Du

