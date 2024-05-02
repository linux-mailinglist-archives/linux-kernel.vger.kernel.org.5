Return-Path: <linux-kernel+bounces-166855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F948BA0E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C246B1F22365
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0F179202;
	Thu,  2 May 2024 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7INwTzP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147659B56;
	Thu,  2 May 2024 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677092; cv=none; b=rMme2Ju635T0IUjoSiylfg2B57LGgXXPaum0wQ12WVdAnh06hjtFGJ7s+YuPi1cvpK5/uwYPzbVWrxKAn6LDkGK+tbPrzeS6a+hrSC6m5/sZ6AoFQiEmpUqjc3O8GGz7HhiOfZnarVSDBBPRasHQEVFMqJpUL5GH2xJMyubywYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677092; c=relaxed/simple;
	bh=2qrWzJQe18l9LseF6v6TDvXLVsNFZ07hmBA1OvCRqf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esl//mfy1TzmM7/A1UvwIc/4gMoZFvxJK6iboqOWtmrMGbp7xHqqgglFf9+iP3HCZTTMEdS/YB1bv2rT+D3mYE0WBR3Rx6o7rObQV6wtpXVDQy60xfI7zhrrJQLBDSGyW+X1YPiw6IQdk3UXFczoXmyzoU64lVk2NX0nZx7u8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7INwTzP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714677091; x=1746213091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2qrWzJQe18l9LseF6v6TDvXLVsNFZ07hmBA1OvCRqf4=;
  b=g7INwTzPMac9Fac2BPgYA5bRhz+EnPwUn50slIl7PBesnwKqeuWlcAIm
   G1IkiWonubugKffePXy2St8gUx8TPfGK38/QWf3n0vw99zwvbHFs7/E7k
   VNh5eeYw78RlXbJTS5amqCgL1imGFUE8PABYgjYDwOUTnzTpWXKUztudj
   4uMRiQQSr6DutvfWmqmrm3GJeViA7Ru4JN/isV7qRg0PymtGhGdoBiR0R
   tOFmnxJhvwB28MN2gPQdTjCCfE8tDnLfUSIRiNxrc8vROjo/73XRE/TtS
   thtqqjph/ZzR0MpBYszcPgMFyDeMa0BOPtUlttnjih+xBSERJKvTtATM8
   w==;
X-CSE-ConnectionGUID: xfV+QQSyTyGMuf7fh8HYxw==
X-CSE-MsgGUID: rAD04/T0R6KCKucKimTGGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10628804"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10628804"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:11:30 -0700
X-CSE-ConnectionGUID: wW8kAQMeRISNLh+M+iXxwQ==
X-CSE-MsgGUID: RrCNsgiZSFOWQexB0cKfqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27275345"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.136])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:11:25 -0700
Message-ID: <8c29642d-9e1e-46a8-83b5-03019e151807@intel.com>
Date: Thu, 2 May 2024 22:11:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] x86/insn: Fix PUSH instruction in x86 instruction
 decoder opcode map
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
References: <20240502105853.5338-1-adrian.hunter@intel.com>
 <20240502105853.5338-3-adrian.hunter@intel.com> <ZjOX-mE_CUOisltJ@x1>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZjOX-mE_CUOisltJ@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/05/24 16:41, Arnaldo Carvalho de Melo wrote:
> On Thu, May 02, 2024 at 01:58:45PM +0300, Adrian Hunter wrote:
>> The x86 instruction decoder is used not only for decoding kernel
>> instructions. It is also used by perf uprobes (user space probes) and by
>> perf tools Intel Processor Trace decoding. Consequently, it needs to
>> support instructions executed by user space also.
> 
> I wonder if we should do it this way, i.e. updating both tools/ and
> kernel source code in the same patch.
> 
> I think the best is to update the kernel bits, then, after that is
> merged, do the tooling part.

For objtool purposes, it might be better to do both at the same time.

> 
> To avoid possible, yet unlikely, clashes in linux-next, for instance.

Always gonna find out about clashes at some point.


