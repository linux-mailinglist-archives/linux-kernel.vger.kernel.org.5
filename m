Return-Path: <linux-kernel+bounces-104881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AC587D4F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91601F226A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AED179AF;
	Fri, 15 Mar 2024 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCcHsJn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B361774E;
	Fri, 15 Mar 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534728; cv=none; b=TsbKXCLtYkAD1FPB5T96l/aV7DK+DOxocvHN/dVgAX88ZGg4wYt1Ldlu7XwJroRLBeu+UShk2a4yjAtLnjg9NuxD2HWOpgapHZAKFCZh+nLboPyBooFEIbSUaf3hMOFDI3eyugAn3xSKHHO80BHPcjr/MNa8+eDd5+wIDB3M+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534728; c=relaxed/simple;
	bh=PbZqHEA+YkEJNHdwhMrFP0v5XWegWU4vg4x/7mlNex8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bno+gJMSEvxUlmlhVaGU7Sg5cnFApzh4AeeC4i++U2CMwzVkNUXIJHylAr06tSfdMe7TkJjyguW7xgwvOF1TP30zSaVLDdcJDbIsaOQMN+ZrXHzpnecaBiq5wJrOpo980ivamVAgrHgRwuVigkZl7zyQj7x8PpiTSIiMjA2pm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCcHsJn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2293C433C7;
	Fri, 15 Mar 2024 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710534728;
	bh=PbZqHEA+YkEJNHdwhMrFP0v5XWegWU4vg4x/7mlNex8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oCcHsJn1HkABfY0Wphu7NifOHPIn99tEWiLnojbrfFV/4pFMYhYtJoq974q2j/PKd
	 GZZOlt3NEXmH9R+jh7EaMOEZzUib/RHlcaMhs3qxnhsAm6umvbC8UXHZhlZz8CkjHx
	 Zd8UvN13bQa15njFIk+snfYfKKVXlMFmNsskLXh0cmIYHKKvDz0G9tMt8xzKOvqgDA
	 pbz3K1NH5i+9lHm75GF0zWm9ypGxDduLfkqgC4tUfXqstA+t+quN6lHvNTRDHmPNob
	 BvyGi6PF3kgLuKidAZ0ECN5JqVNHyevp0jm8KsQ7zVnR3KJtDwxfNN7IYCFrNBtcOc
	 aPC3+dS1fos6Q==
Date: Fri, 15 Mar 2024 17:32:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf docs: arm_spe: Clarify more SPE requirements
Message-ID: <ZfSwRP5B1G5RvpOR@x1>
References: <20240312132508.423320-1-james.clark@arm.com>
 <CAP-5=fWGrkjx1vz+2aQU0A+_B3d=nCtK9WBGiSPbDbUaTXR4pQ@mail.gmail.com>
 <0c503c64-133a-705f-9dc4-47c623dacd2c@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c503c64-133a-705f-9dc4-47c623dacd2c@arm.com>

On Wed, Mar 13, 2024 at 09:41:54AM +0000, James Clark wrote:
> 
> 
> On 12/03/2024 19:56, Ian Rogers wrote:
> > On Tue, Mar 12, 2024 at 6:25 AM James Clark <james.clark@arm.com> wrote:
> >>
> >> The question of exactly when KPTI needs to be disabled comes up a lot
> >> because it doesn't always need to be done. Add the relevant kernel
> >> function and some examples that describe the behavior.
> >>
> >> Also describe the interrupt requirement and that no error message will
> >> be printed if this isn't met.
> >>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
 
> Thanks for the review

Thanks, applied to perf-tools-next,

- Arnaldo
 
> >> ---
> >>  tools/perf/Documentation/perf-arm-spe.txt | 12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
> >> index bf03222e9a68..0a3eda482307 100644
> >> --- a/tools/perf/Documentation/perf-arm-spe.txt
> >> +++ b/tools/perf/Documentation/perf-arm-spe.txt
> >> @@ -116,6 +116,15 @@ Depending on CPU model, the kernel may need to be booted with page table isolati
> >>  (kpti=off). If KPTI needs to be disabled, this will fail with a console message "profiling buffer
> >>  inaccessible. Try passing 'kpti=off' on the kernel command line".
> >>
> >> +For the full criteria that determine whether KPTI needs to be forced off or not, see function
> >> +unmap_kernel_at_el0() in the kernel sources. Common cases where it's not required
> >> +are on the CPUs in kpti_safe_list, or on Arm v8.5+ where FEAT_E0PD is mandatory.
> >> +
> >> +The SPE interrupt must also be described by the firmware. If the module is loaded and KPTI is
> >> +disabled (or isn't required to be disabled) but the SPE PMU still doesn't show in
> >> +/sys/bus/event_source/devices/, then it's possible that the SPE interrupt isn't described by
> >> +ACPI or DT. In this case no warning will be printed by the driver.
> >> +
> >>  Capturing SPE with perf command-line tools
> >>  ------------------------------------------
> >>
> >> @@ -199,7 +208,8 @@ Common errors
> >>
> >>   - "Cannot find PMU `arm_spe'. Missing kernel support?"
> >>
> >> -   Module not built or loaded, KPTI not disabled (see above), or running on a VM
> >> +   Module not built or loaded, KPTI not disabled, interrupt not described by firmware,
> >> +   or running on a VM. See 'Kernel Requirements' above.
> >>
> >>   - "Arm SPE CONTEXT packets not found in the traces."
> >>
> >> --
> >> 2.34.1
> >>
> > 

