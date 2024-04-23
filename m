Return-Path: <linux-kernel+bounces-155296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313338AE865
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA74A1F21155
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539C13666F;
	Tue, 23 Apr 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf7q7O3q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8D641;
	Tue, 23 Apr 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879633; cv=none; b=nVn1xasuGoTAzEVYcdRcUze2IzK7fRzdpw3Wre31QKgkO2r5ie1xnciCdsjgYcxOnA7U+w29bl5EW3z3wjJDmI82kdZ5VqKKnqv/AMtttMa5CSSiRhcySu1lUwWDVs97Eftg34BRBcdz9QqX/j0rPtU5O6xN2+A204vx+FqTC6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879633; c=relaxed/simple;
	bh=OjoB4YNf+hVkLOFE5qH5rMcnX+a/LvE6rWEnQacRq94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBQo7B4h4RMVUPEK2sZ2y4rBPV+xgL0fF+ekIeoUu5sC2/mbx4DJ6X/xVwvmDtL9EhsQiYnw03Q3sM+mFv0XfwbMj2ju9YOPUNTWvP5fJ5KVTSOwqEQ2HS/HWe3pOuKvLSflGtf2YUrGFdhp4/6skQXgs2GUJHOfpH365uZstI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf7q7O3q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713879632; x=1745415632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OjoB4YNf+hVkLOFE5qH5rMcnX+a/LvE6rWEnQacRq94=;
  b=Bf7q7O3qhXy1emY8DqEL9IE/r8VVbv7MTdeE7uUJzmUrlB0jxp8FjKHg
   E7dVXbokn973PzeaJyCOcB0Zk2kqpbRLkmWs8uqKgApdAqOzCQey0rpNZ
   fBywjCZhWnlRHnMiSkQ2g2B9vFKLPylf/njfHkyy7zBwC0/Hgy2BstfxW
   Dfi3Flt7FX5p43gk8YuuLXc7PPUgBLbr3K3JGTj5atAmXzPs5/ygJJg2s
   De4T0THc7e6p+iPdVMj1fyVfPxAyF3Tv6oNjBHOu3JnQpP2V39cutYlxw
   D4fKm4ZGkyboV6gWXEeBEcRqHkcTzn30NqTcW1C2j/9yb99wmL7yJGUqg
   A==;
X-CSE-ConnectionGUID: yn1N5DnrSD+uKQO35urRuQ==
X-CSE-MsgGUID: 9Z5dsM0XRsSuVT5zGPIJNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9633408"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9633408"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:40:31 -0700
X-CSE-ConnectionGUID: IuIt3hpzQ3mY+mQzj10XPw==
X-CSE-MsgGUID: iyCcn9/cS7KCiRMYdEZAmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24351668"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.63.204])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:40:28 -0700
Message-ID: <e082dabe-5d1c-4be0-baaa-5be30cff0016@intel.com>
Date: Tue, 23 Apr 2024 16:40:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf scripts python: Add a script to run instances of
 perf script in parallel
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240313123634.4353-1-adrian.hunter@intel.com>
 <CAP-5=fW1bH8qQkD7LrO6_3fJ3NsqoW1GrX8=s-sfaTbrvk58+A@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fW1bH8qQkD7LrO6_3fJ3NsqoW1GrX8=s-sfaTbrvk58+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/24 21:19, Ian Rogers wrote:
> On Wed, Mar 13, 2024 at 5:36 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Add a Python script to run a perf script command multiple times in
>> parallel, using perf script options --cpu and --time so that each job
>> processes a different chunk of the data.
>>
>> The script supports the use of normal perf script options like
>>  --dlfilter and --script, so that the benefit of running parallel jobs
>> naturally extends to them also. In addition, a command can be provided
>> (refer --pipe-to option) to pipe standard output to a custom command.
>>
>> Refer to the script's own help text at the end of the patch for more
>> details.
>>
>> The script is useful for Intel PT traces, that can be efficiently
>> decoded by perf script when split by CPU and/or time ranges. Running
>> jobs in parallel can decrease the overall decoding time.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>


>> +
>> +       def __init__(self, cmd, pipe_to, output_dir="."):
>> +               self.popen = None
>> +               self.consumer = None
>> +               self.cmd = cmd
>> +               self.pipe_to = pipe_to
>> +               self.output_dir = output_dir
>> +               self.cmdout_name = output_dir + "/cmd.txt"
>> +               self.stdout_name = output_dir + "/out.txt"
>> +               self.stderr_name = output_dir + "/err.txt"
> 
> Why use files here and not pipes?

There is an option to pipe to another command.

>                                   Could using files cause the command
> to fail on a read-only file system?

The user chooses the output directory, so they will need the foresight
not to choose a read-only file system.


