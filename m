Return-Path: <linux-kernel+bounces-41863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E383F8F3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6847F1F22B06
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D12E413;
	Sun, 28 Jan 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsT1GXoX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323652D044;
	Sun, 28 Jan 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706464830; cv=none; b=jv8OSSoQSL8gzKVRoJqeKcTTMtEerVNddP1RwpV89Jwgjx69YJpGQtYL4zlWsE9cG2u2lGfynsy5m5TNQi0WghAyYcpdRruOMiU/LvjAWkA+Vrk4YUEUOddxzEnCQYyc++JhaSfa10NFbWziztMF0TDVCMJuIzUUypYqarg1kOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706464830; c=relaxed/simple;
	bh=6qEE5iFXL0RGoiqfGo6GjJkdO/zywWgXuJlLPmA7+5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isJ3TLAzV502IGeCTDWnN0Tv3OEnoP1TrJ+S8zC8GQKcy0i6mD9yRt7kItCX/3WecVxliAn3FwNnl99oOxjTcIjcpKRhuTM5w5MHn13qLgn5PgJoN4hVWLRhU589yjXwBuHI4CcYO/lcB0q2qAd6kSiLuSy9XTyJM+SFRObOhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsT1GXoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FFAC433C7;
	Sun, 28 Jan 2024 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706464828;
	bh=6qEE5iFXL0RGoiqfGo6GjJkdO/zywWgXuJlLPmA7+5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsT1GXoXSH/52LxccsjtDsNIjuDdp8OxanWHiflBkvM4boc+NDZQgx38HErpRkpjr
	 zWNUG4SsPOUwkzQRjwyvB1o9KRmCjIw4WWycMBKjEGkTXf1FAYJZnnk+yWAbIacRSu
	 J2bLdsy2Xs7Ev/FQCB1EqbtLo3KqFCeutoaBwdALuQWsEWpqyItBbN3TWeXzTqotwX
	 VxF5zvN16MRc13vmRb6mx34Osu22+d5xhVzSDqsBrbug2pOW6YnLOZH+RRVSkyLGtF
	 ejemvflsjZmD4nJRYlITF+ri8myBfU6f8pqhQ5mllrbuo6bpZoFxOWEWdkuPb2Th/5
	 t3lTUck/b9GvA==
Date: Sun, 28 Jan 2024 12:00:25 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Amit Pundir <amit.pundir@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] arm64: dts: qcom: sdm845: Fix wild reboot during
 Antutu test
Message-ID: <iiggyplhtyf3pnj37k4tdzymry26uxzpaldhiqfi6abxk5xjgi@6v6ovkdevn7d>
References: <20240116115921.804185-1-daniel.lezcano@linaro.org>
 <CYG4WTCOBTG2.11PA7Q4A3H93H@fairphone.com>
 <5db88d48-4868-49f0-b702-6eea14400e5b@linaro.org>
 <CYG6QOFYOX79.2ROURJ8FK446C@fairphone.com>
 <70b359c6-f094-4874-b903-1dca07d0db7c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70b359c6-f094-4874-b903-1dca07d0db7c@linaro.org>

On Tue, Jan 16, 2024 at 04:38:33PM +0100, Daniel Lezcano wrote:
> On 16/01/2024 15:03, Luca Weiss wrote:
> > On Tue Jan 16, 2024 at 1:51 PM CET, Daniel Lezcano wrote:
> > > On 16/01/2024 13:37, Luca Weiss wrote:
> > > > On Tue Jan 16, 2024 at 12:59 PM CET, Daniel Lezcano wrote:
> > > > > Running an Antutu benchmark makes the board to do a hard reboot.
> > > > > 
> > > > > Cause: it appears the gpu-bottom and gpu-top temperature sensors are showing
> > > > > too high temperatures, above 115°C.
> > > > > 
> > > > > Out of tree configuratons show the gpu thermal zone is configured to
> > > > > be mitigated at 85°C with devfreq.
> > > > > 
> > > > > Add the DT snippet to enable the thermal mitigation on the sdm845
> > > > > based board.
> > > > > 
> > > > > Fixes: c79800103eb18 ("arm64: dts: sdm845: Add gpu and gmu device nodes")
> > > > > Cc: Amit Pundir <amit.pundir@linaro.org>
> > > > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > 
> > > > A part of this is already included with this patch:
> > > > https://lore.kernel.org/linux-arm-msm/20240102-topic-gpu_cooling-v1-4-fda30c57e353@linaro.org/
> > > > 
> > > > Maybe rebase on top of that one and add the 85degC trip point or
> > > > something?
> > > 
> > > Actually, I think the patch is wrong.
> > 
> > I recommend telling Konrad in that patch then, not me :)
> 
> That's good Konrad is in the recipient list :)
> 
> > > The cooling effect does not operate on 'hot' trip point type as it is
> > > considered as a critical trip point. The governor is not invoked, so no
> > > mitigation happen. The 'hot' trip point type results in sending a
> > > notification to userspace to give the last chance to do something before
> > > 'critical' is reached where the system is shut down.
> > > 
> > > I suggest to revert it and pick the one I proposed.
> > 
> > It hasn't been applied yet so it can be fixed in v2 there.
> 
> The patch was submitted without testing AFAICT. So it is preferable to pick
> the one I sent which was tested by Amit and me.
> 

I would have loved to have that feedback in the thread that is wrong!

Due to my lack of understanding of this detail, and only positive
reviews I merged said series. Please fix your patch and rebase it on top
of linux-next.

Thanks,
Bjorn

