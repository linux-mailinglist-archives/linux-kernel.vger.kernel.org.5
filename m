Return-Path: <linux-kernel+bounces-118148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4688B4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF92B1C35B37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348582D85;
	Mon, 25 Mar 2024 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BNOI6Q12"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB45A0EA;
	Mon, 25 Mar 2024 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407725; cv=none; b=T1FvhWoxZMKgnq5K3tSzEiR/ZNIqRFa53TEzDvGw2FfZzUwMNtf7+d1R434rU8ThEO5soLeQR1axRhkKITVuCzoF4/19tdlrzzRhyADdb0NPQrgUZTG2itk2DnUJusE/2KONlxiHA07k1MSUwFFYM7aj9I37MhXboDj/8mLGZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407725; c=relaxed/simple;
	bh=bFdl8JXJ77NvIlDmZP/5H64Hrz2n2pfJV5U3jXvdse0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPJgn8kVzCEq/OqOo4Kt2UCFpl68Zz0C33gTZyuHG8Bp71I3Ym5GLpHzzN37uwF84yRVYbvmH1eiWWKbmseu/BwRjDjm76DjDagCAyRodSxTucjulrbo0px7hvLoIfIpw3XgOj1xqAnVP0w8b+phzImuYGuFLpFW7rKVy4bM0es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BNOI6Q12; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711407720;
	bh=bFdl8JXJ77NvIlDmZP/5H64Hrz2n2pfJV5U3jXvdse0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNOI6Q12cS8Ek7mkTm+z7Ht8BFiiCxIHsmiIJTJWod2vxVbuJwWMbdQ9L0tYvaCDL
	 rjDUbAEM5t6PqGKpTeZoDbcLJVqcDCfLKTJ4j2VNyYw0S6s7ev5GQsTisM3lLGyNuG
	 oo8NN/Pz3Lo0LfciU62565hqu23SSTWx40Kx7o8Aw/gaO7aMPLvvnnVE3moN0tW7rt
	 T0x55lm8PjjnltTTNeY7pW5jpmxdMBaa0AOLWwxIiYdgsQ/GAZDcNTpwF9RozJBvGa
	 TVwFpPat4ZXXGrlb0vZbGnn7JZDI4xJxRHPw1hpSParbx8Z/0aStaeqmHmDyEzy0sK
	 bosBxHvjPWP/A==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1A10E37820E1;
	Mon, 25 Mar 2024 23:01:56 +0000 (UTC)
Date: Mon, 25 Mar 2024 19:01:55 -0400
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
Message-ID: <8e0cc005-0b3a-4475-bfe4-82ec46d918a5@notapiano>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
 <dbe90a1c-bac2-4176-8eba-7ad96a182313@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbe90a1c-bac2-4176-8eba-7ad96a182313@linaro.org>

On Mon, Mar 25, 2024 at 08:59:55PM +0100, Krzysztof Kozlowski wrote:
> On 20/03/2024 20:08, Nícolas F. R. A. Prado wrote:
> >> Loic Poulain (1):
> >>       arm64: dts: qcom: qcm2290: Add LMH node
> >>
> >>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
> >>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
> >>  drivers/thermal/qcom/lmh.c                              |  3 +++
> >>  3 files changed, 24 insertions(+), 5 deletions(-)
> > 
> > Hi,
> > 
> > I've started tracking the results of 'make dtbs_check' on linux-next, and I've
> > noticed that on today's next, next-20240320, there's a new warning coming from
> > this. The reason is that the DT change has landed, but the binding has not,
> > since it goes through a separate tree. I thought the binding was supposed to
> > always land before the driver and DT that make use of it, but looking through
> 
> There is no such rule. Of course new binding should be documented in
> earlier or the same kernel release cycle as users get in, but it's not a
> requirement.

So, after giving the documentation a second look, I found this:

"For new platforms, or additions to existing ones, make dtbs_check should not
add any new warnings."

Source: https://www.kernel.org/doc/html/latest/process/maintainer-soc.html#validating-devicetree-files

What is not clear there is what the reference point is: is it on linux-next?
Mainline release?

As Konrad pointed out it's tricky (and maybe not worth it) to guarantee this for
linux-next. But for mainline release it seems feasible (and IMO the target, as
after that stability guarantees should apply).

> 
> 
> > the dt-binding documentation pages I couldn't find anything confirming or
> > denying that.
> > 
> > I expect this to happen again in the future, which is why I'm reaching out to
> > understand better how to deal with this kind of situation.
> 
> Deal as what to do? Are you asking in terms of maintenance of some
> subsystem or sending some patches? In this particular case here, I don't
> think there is anything on your side to deal with.

I'm asking what's the most helpful way to you the maintainers for me to report
these failures in the future.

Rob has already automated running dtbs_check for patches coming into the mailing
list. And I have set up KernelCI to run dtbs_check on linux-next in order to
catch any issues that might slip through, or happen during integration of the
trees, etc. 

Now, if we agree that dtbs_check regressions on linux-next are acceptable, at
least ones like this, where the issue is just synchronization between
maintainers, then I can simply not report them in the future. But we should
have some point where dtbs_check should not regress, and mainline release seems
the reasonable choice, because if we don't then dtbs_check warnings would just
keep growing forever.

Thanks,
Nícolas

