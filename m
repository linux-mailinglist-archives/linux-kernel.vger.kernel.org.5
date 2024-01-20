Return-Path: <linux-kernel+bounces-31737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 100AD83331F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 08:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADDE1F23BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 07:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E81210B;
	Sat, 20 Jan 2024 07:31:15 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156820F5;
	Sat, 20 Jan 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705735875; cv=none; b=GPCEsVk8Osct1/URTmuw3zIU92Qge3DGYZvvXiCW/jWjO4vL6cIGiQ/hINZhKNzmJdaX18pQ5+RiSN64MHHSs/HXA6W7XyYyJT36Nq5qaCGzZY2t8bKlLy9eaHU7DB+jN9BguxZpK4xvMKWMC8MH+1ID0MOGbeWippW/JMmY9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705735875; c=relaxed/simple;
	bh=7aCKjwQxFKN95nvYTWAtACTvKPEMQJL6jNispB1Uqbo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS+QPtN0MNUFQIEnQluMu3r6kJLA2rtPfFZblwdLQJLaEsSj1jCevY270l4qTFoVFUX4Frt5c5uJbcatKKXyFqf+OvHYAEa1XZ4s36Ry2Y8kWe2HhvNr3hlNRIiESpo494NXIHGJjAuOUl6dz8b5VRoowWqCC2VfyUgxSilVGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TH7Ry14Jgz1xmQq;
	Sat, 20 Jan 2024 15:30:22 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E85418001A;
	Sat, 20 Jan 2024 15:31:10 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Sat, 20 Jan
 2024 15:31:08 +0800
Date: Sat, 20 Jan 2024 15:30:58 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Adrian Hunter <adrian.hunter@intel.com>
CC: Changbin Du <changbin.du@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas
 Richter <tmricht@linux.ibm.com>, <changbin.du@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>
Subject: Re: [PATCH v4 4/5] perf: script: add raw|disasm arguments to
 --insn-trace option
Message-ID: <20240120073058.salpvxizmijojp7n@M910t>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-5-changbin.du@huawei.com>
 <dea4ffb9-9442-4b5a-bf1c-73a7fe6652d9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dea4ffb9-9442-4b5a-bf1c-73a7fe6652d9@intel.com>
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100002.china.huawei.com (7.221.188.184)

On Fri, Jan 19, 2024 at 08:39:50PM +0200, Adrian Hunter wrote:
> On 19/01/24 12:48, Changbin Du wrote:
> > Now '--insn-trace' accept a argument to specify the output format:
> >   - raw: display raw instructions.
> >   - disasm: display mnemonic instructions (if capstone is installed).
> > 
> > $ sudo perf script --insn-trace=raw
> >               ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: 48 89 e7
> >               ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: e8 e8 0c 00 00
> >               ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: f3 0f 1e fa
> > 
> > $ sudo perf script --insn-trace=disasm
> >               ls 1443864 [006] 2275506.209908875:      7f216b426100 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rdi
> >               ls 1443864 [006] 2275506.209908875:      7f216b426103 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: callq _dl_start+0x0
> >               ls 1443864 [006] 2275506.209908875:      7f216b426df0 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: illegal instruction
> >               ls 1443864 [006] 2275506.209908875:      7f216b426df4 _dl_start+0x4 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: pushq %rbp
> >               ls 1443864 [006] 2275506.209908875:      7f216b426df5 _dl_start+0x5 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: movq %rsp, %rbp
> >               ls 1443864 [006] 2275506.209908875:      7f216b426df8 _dl_start+0x8 (/usr/lib/x86_64-linux-gnu/ld-2.31.so) insn: pushq %r15
> > 
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/Documentation/perf-script.txt |  6 +++---
> >  tools/perf/builtin-script.c              | 17 +++++++++++++----
> >  2 files changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> > index fc79167c6bf8..9ae54f5bcb4d 100644
> > --- a/tools/perf/Documentation/perf-script.txt
> > +++ b/tools/perf/Documentation/perf-script.txt
> > @@ -442,9 +442,9 @@ include::itrace.txt[]
> >  	will be printed. Each entry has function name and file/line. Enabled by
> >  	default, disable with --no-inline.
> >  
> > ---insn-trace::
> > -	Show instruction stream for intel_pt traces. Combine with --xed to
> > -	show disassembly.
> > +--insn-trace[=<raw|disasm>]::
> > +	Show raw or mnemonic instruction stream for intel_pt traces. You can
> > +	also combine raw instructions with --xed to show disassembly.
> 
> Perhaps this is a bit clearer:
> 
> Show instruction stream in bytes (raw) or disassembled (disasm)
> for intel_pt traces. The default is 'raw'. To use xed, combine
> 'raw' with --xed to show disassembly done by xed.
>
Updated, thanks.

> >  
> >  --xed::
> >  	Run xed disassembler on output. Requires installing the xed disassembler.
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 12d886694f6c..2e3752b3b65a 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -3769,10 +3769,19 @@ static int perf_script__process_auxtrace_info(struct perf_session *session,
> >  #endif
> >  
> >  static int parse_insn_trace(const struct option *opt __maybe_unused,
> > -			    const char *str __maybe_unused,
> > -			    int unset __maybe_unused)
> > +			    const char *str, int unset __maybe_unused)
> >  {
> > -	parse_output_fields(NULL, "+insn,-event,-period", 0);
> > +	const char *fields = "+insn,-event,-period";
> > +
> > +	if (str) {
> > +		if (strcmp(str, "disasm") == 0)
> > +			fields = "+disasm,-event,-period";
> > +		else if (strlen(str) != 0 && strcmp(str, "raw") != 0) {
> > +			fprintf(stderr, "Only accept raw|disasm\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +	parse_output_fields(NULL, fields, 0);
> >  	itrace_parse_synth_opts(opt, "i0ns", 0);
> >  	symbol_conf.nanosecs = true;
> >  	return 0;
> > @@ -3918,7 +3927,7 @@ int cmd_script(int argc, const char **argv)
> >  		   "only consider these symbols"),
> >  	OPT_INTEGER(0, "addr-range", &symbol_conf.addr_range,
> >  		    "Use with -S to list traced records within address range"),
> > -	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
> > +	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, "raw|disasm",
> >  			"Decode instructions from itrace", parse_insn_trace),
> >  	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
> >  			"Run xed disassembler on output", parse_xed),
> 

-- 
Cheers,
Changbin Du

