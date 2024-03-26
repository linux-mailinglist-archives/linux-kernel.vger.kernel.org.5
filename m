Return-Path: <linux-kernel+bounces-119136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3808C88C4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74EF1F809B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E5B12881F;
	Tue, 26 Mar 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MNCT7dK6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E9128380;
	Tue, 26 Mar 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462032; cv=none; b=bcDSva4Nmz7msPN41XDHlFx9bk04B3rDDDEPbcEFJx7x7YwmqMODt6c79UFnkB51taZzW8OvGo7wzjRkdjMmtxCjDYNIqk1PuI2gvLI5nIOSl1b0uEyEFx9k+yhzNkJPvQVkrAsldJmQ9GSgyWfL6VMD3tBm68Dd2ZQz8q0BjJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462032; c=relaxed/simple;
	bh=MaN4lmkjFkunSKOL0LHCTWZwGrHirAICNbp1KIwx0ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmF5uroa/o2TnFjrIAGAqYJ8LBCcsbd+6XExh0VIpGgC/RR2klMSgPLM25dja6+C3wnR4+aMlLHIhy+HOl5tAUA3T/xPXrrKIzJwf0YtxpiIK9xHulxrMTw75nQ/OBP4hOXsNAPQjtK1FCTu8PgQLofMFvzp41FSbjJ6TCbRWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MNCT7dK6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711462026;
	bh=MaN4lmkjFkunSKOL0LHCTWZwGrHirAICNbp1KIwx0ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNCT7dK62XpPSLOlyY4YN86/RM1dlK42uJoBMr9lUWxquKswuZ8ZqEoGfG36Gnusd
	 gJpKBmXp2MS0sF5n+TSilS/NcWoIr/4K9lCAiPZA4VCXNObdSJPYZQnX+c/18TW/5Z
	 +Z7ADfbN/APo3ad0G0bc8jMRCMPHn0x4w9sHjtYdD1I2arb2pfg1lRhVMfZ4tV1S0j
	 +G5avx5t4tTF0R1qFkRJ+rdfZSP4obCWiciNwsEiR1Cxxl+c96wwslBqco3V2eDXDe
	 LG/vQ28G8paTdzU/x1mXRGX5PY4Odul0zpkQ/MbIn6iCkEEZwpxJ1M5CXwKDc2K+F5
	 qXe5Sta3lVrIw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EF9D437813D7;
	Tue, 26 Mar 2024 14:07:02 +0000 (UTC)
Date: Tue, 26 Mar 2024 10:07:00 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v2 0/3] QCM2290 LMH
Message-ID: <33cb5ab6-1b15-4903-a5fa-f0d2f86fb438@notapiano>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
 <dbe90a1c-bac2-4176-8eba-7ad96a182313@linaro.org>
 <8e0cc005-0b3a-4475-bfe4-82ec46d918a5@notapiano>
 <68dbebe0-acaa-40f0-9a5c-fd49d265ae08@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68dbebe0-acaa-40f0-9a5c-fd49d265ae08@linaro.org>

On Tue, Mar 26, 2024 at 07:29:17AM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 00:01, Nícolas F. R. A. Prado wrote:
> > On Mon, Mar 25, 2024 at 08:59:55PM +0100, Krzysztof Kozlowski wrote:
> >> On 20/03/2024 20:08, Nícolas F. R. A. Prado wrote:
> >>>> Loic Poulain (1):
> >>>>       arm64: dts: qcom: qcm2290: Add LMH node
> >>>>
> >>>>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
> >>>>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
> >>>>  drivers/thermal/qcom/lmh.c                              |  3 +++
> >>>>  3 files changed, 24 insertions(+), 5 deletions(-)
> >>>
> >>> Hi,
> >>>
> >>> I've started tracking the results of 'make dtbs_check' on linux-next, and I've
> >>> noticed that on today's next, next-20240320, there's a new warning coming from
> >>> this. The reason is that the DT change has landed, but the binding has not,
> >>> since it goes through a separate tree. I thought the binding was supposed to
> >>> always land before the driver and DT that make use of it, but looking through
> >>
> >> There is no such rule. Of course new binding should be documented in
> >> earlier or the same kernel release cycle as users get in, but it's not a
> >> requirement.
> > 
> > So, after giving the documentation a second look, I found this:
> > 
> > "For new platforms, or additions to existing ones, make dtbs_check should not
> > add any new warnings."
> > 
> > Source: https://www.kernel.org/doc/html/latest/process/maintainer-soc.html#validating-devicetree-files
> 
> It's just "should"...
> 
> > 
> > What is not clear there is what the reference point is: is it on linux-next?
> > Mainline release?
> 
> Does it matter? There was never a new warning introduced by this
> patchset. The patchset itself is correct. No new warnings.
> 
> > 
> > As Konrad pointed out it's tricky (and maybe not worth it) to guarantee this for
> > linux-next. But for mainline release it seems feasible (and IMO the target, as
> > after that stability guarantees should apply).
> 
> I don't believe in such guarantees. Different maintainers apply patches
> differently, especially bindings, so this is beyond our control. Often
> also beyond SoC maintainer control.
> 
> > 
> >>
> >>
> >>> the dt-binding documentation pages I couldn't find anything confirming or
> >>> denying that.
> >>>
> >>> I expect this to happen again in the future, which is why I'm reaching out to
> >>> understand better how to deal with this kind of situation.
> >>
> >> Deal as what to do? Are you asking in terms of maintenance of some
> >> subsystem or sending some patches? In this particular case here, I don't
> >> think there is anything on your side to deal with.
> > 
> > I'm asking what's the most helpful way to you the maintainers for me to report
> > these failures in the future.
> 
> The most effective way is LKP-like or Rob's-bot-like automated replies
> to original email threads, by testing the original patchset on
> linux-next. But Rob's bot is actually doing it, just on different base.
> 
> Other reports, like for cases when only parts of patch is applied, could
> be also useful but I am afraid you will generate way too much of them.
> Binding is supposed to go via subsystem, DTS via SoC, so basically 90%
> of patchsets might have some sort of delays resulting in dtbs_check
> false positive warnings.
> 
> For my SoC I check my trees, mainline and next, and keep adding list of
> exceptions for expected issues. What's useful for Qualcomm? Konrad,

Is that list of exceptions in-tree? If there are known false-positives (issues
that can't be "properly" fixed), they should be public knowledge. And if we all
collaborate on such a list we can remove the noise from dtbs_check's output so
it only contains real regressions and a backlog of issues that can be fixed.

> Bjorn, any thoughts?
> 
> Have in mind that expected warnings can be for entire cycle when dealing
> with technical debt, because DTS goes N+1.
> 
> > 
> > Rob has already automated running dtbs_check for patches coming into the mailing
> > list. And I have set up KernelCI to run dtbs_check on linux-next in order to
> > catch any issues that might slip through, or happen during integration of the
> > trees, etc.
> > 
> > Now, if we agree that dtbs_check regressions on linux-next are acceptable, at
> > least ones like this, where the issue is just synchronization between
> 
> Yes and no. True regressions are not acceptable. Expected intermediate
> regressions as a result of patchset being applying, but not yet fully
> applied, are OK. Expected regressions for intra-cycle-work are also OK.

Got it. So I'll keep KernelCI running dtbs_check and tracking it, but I won't
report failures caused by partially applied series.

> 
> > maintainers, then I can simply not report them in the future. But we should
> > have some point where dtbs_check should not regress, and mainline release seems
> > the reasonable choice, because if we don't then dtbs_check warnings would just
> > keep growing forever.
> 
> I invite therefore to my session:
> https://eoss24.sched.com/event/1aBEf?iframe=no
> We'll see if they keep growing :)

I won't be able to attend EOSS, but will catch the recording later ;)

Thanks,
Nícolas

