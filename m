Return-Path: <linux-kernel+bounces-151111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B38AA93C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1411C20E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9710743AAA;
	Fri, 19 Apr 2024 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWttLJRS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00226AE7;
	Fri, 19 Apr 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512029; cv=none; b=L1JVw1siR8x67IRHZmfe06M2V2VJcoIAGFCd9f+NypjBJaTVrnRyEvR+lp6ZsZ20Y4LG9Hv0Q8TlBeyIqNIf8N81UrWuV4YS8uK3DFIRQ3ILArLw4wvGYich7uVL8Aicj5aI5suNYhDe7pBbkXZwdNaTi2OotewnXH/tDFdOxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512029; c=relaxed/simple;
	bh=u5fYgOonRjt0u0BZvBOxYOe2u93esfHuGjTF33hwr2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYpT0xHJbiMhl0d7RIjl55uATfPMBARSRJgtvx1YMbCFw5/g9NiZtv37R/bVPZXxuH2HFfqKe1bD/C0oWuIovZ77DKVzIEPcb3sEBtkdErZFClWi04f6AzSCWu3cAmLa8wZaTOdgV9meL7XWAJSgjief7B7VpG/3JsvPTBMTW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWttLJRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C3EC072AA;
	Fri, 19 Apr 2024 07:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713512028;
	bh=u5fYgOonRjt0u0BZvBOxYOe2u93esfHuGjTF33hwr2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWttLJRSdTi+0/qGHKRJON9S/VpK9g7TDcrpkLbfSeYZAmKG5uC7usNC8QZfn1Z/3
	 N3IaHmz/zlIeZhhxy9lvs6cjpmyJynOE8pPfWJh7LyABHJkm9H7TgSBVzg+Ix8/V4z
	 HlyLvC9lSlCcn/7ZGXVB5UjSZWkrLf4H7T6eGkqtcha8AK9WRUOrHN7IKWUf6fmo/Y
	 C0JdShsYc7BhFutS3vbzFJd5poxqAvmaUcTq0hdIVGRlKSr0MBtDQsUpNxfH+lBCr2
	 AALPdOwWEWhqqxFzfZkoH9hXgs+g1hQ0q7Vq015cZ5uGzMK6DVaR43BGnQkn8ZZZnC
	 uwXIiGHLEmkKA==
Date: Fri, 19 Apr 2024 00:33:46 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: kernel test robot <yujie.liu@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [x86/syscall] 1e3ad78334:
 will-it-scale.per_process_ops 1.4% improvement
Message-ID: <20240419073346.xlpx4qaocbo6bhip@treble>
References: <202404191333.178a0eed-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202404191333.178a0eed-yujie.liu@intel.com>

On Fri, Apr 19, 2024 at 01:49:26PM +0800, kernel test robot wrote:
> Hi Linus,
> 
> We noticed that commit 1e3ad78334a6 caused performance fluctuations in
> various micro benchmarks. The perf stat metrics related with branch
> instructions do have noticeable changes, which may be an expected
> result of this commit. We are sending this report to provide these data
> and hope it can be helpful for the awareness of overall impact or any
> further investigation. Thanks.
> 
> kernel test robot noticed a 1.4% improvement of will-it-scale.per_process_ops on:
> 
> commit: 1e3ad78334a69b36e107232e337f9d693dcc9df2 ("x86/syscall: Don't force use of indirect calls for system calls")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Thanks, these are significant regressions.

Since this is on Skylake (with IBRS enabled, presumably) I'd expect that
these regressions are fixed by my "Only harden syscalls when needed"
patch.  I'm planning on posting a new version of that tomorrow, but v3
[*] should be good enough to fix it.  Could you run these tests on the
same Skylake system with my patch added?

Also it would be helpful to see the same tests on Cascade/Ice Lake, or
some other system for which the 'spectre_v2' sysfs vulnerabilities file
shows "BHI: SW loop".  On such a system it shouldn't matter whether my
patch is added as it won't disable Linus' syscall change.  But it would
be very helpful to see the performance impact of that combination.

[*] https://lkml.kernel.org/lkml/eda0ec65f4612cc66875aaf76e738643f41fbc01.1713296762.git.jpoimboe@kernel.org

-- 
Josh

