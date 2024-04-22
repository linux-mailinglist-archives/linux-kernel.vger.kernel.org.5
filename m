Return-Path: <linux-kernel+bounces-153836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5258AD3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B93B1F218E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A415444B;
	Mon, 22 Apr 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxv843Tn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9201B977;
	Mon, 22 Apr 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810708; cv=none; b=uDWNnPrb6mrFnY3d1NAK+84YURFXmLeqrjsDiEKIvZQe2Wxg1lujEN0GASuURNTkzkSjM4kGCz/q9iNLX8rrlTCzUkZGRfCGOrIDBQikeNcLf/pYAgzkQU9tXz8ggNiK4RIC6uLH2phqV4cWg//dOrayL8F8iR2R+YAo7MsZyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810708; c=relaxed/simple;
	bh=KuQ5PJtHrCWHxSHKneU9Z0JpuMsrCVLPVVmkGlQ8pO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9PUZjb8SR5f9dBLOWJpstx0TE8uJ/ZbdnSLFC0wloQAlPnbKAUEGdWlYuzBU2UE02vFvqgsB/qM5w0C7+OfSyjkIXXz23TaMsw7VCzyFq4fVD9EH8/uec4mdancLqR29EGiaXRr8+BDP5rtAmvm1ixDUeFQ41q3owm3uEE9IgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxv843Tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEA0C113CC;
	Mon, 22 Apr 2024 18:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713810707;
	bh=KuQ5PJtHrCWHxSHKneU9Z0JpuMsrCVLPVVmkGlQ8pO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xxv843TnIPxiwHND70fOBxRQOE21fAc+W1rjgg/pbmewHydF80Ii5jUdr9hyuXjJN
	 LVjaV2eHo8h5ZyTrPfStdWsMzH6tQW2YRVoKc25L9f95MSv2eoOSFgGKLi4gQhbIAI
	 A7yhtrdjOb8QkYnzky8hWbj9lfriCl6mR+NedBZ7gCYKqAlev+SOZL8REhE2wvmXc0
	 aFHEMEeQKWgd59UDawVofUoVh+8FghpNcvi40xGh0hIK80i4NHWkg1EmftD4AEbzJs
	 BP4G5Tw/S3ELQM1iaICyM5YJ6BLYrqWK3qts288JmtlMl2R4snZU4SUZBfJHqDD0MA
	 6+q86AGCFNPNA==
Date: Mon, 22 Apr 2024 13:31:44 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
Message-ID: <653hocuhibu6xvffxblek4zoot3ryk7ilu6tbqznnliyfi3ma4@uhxfwcpsteny>
References: <20240325085835.26158-1-johan+linaro@kernel.org>
 <171226578689.615813.4474720130637817355.b4-ty@kernel.org>
 <59372e42-2eab-4efd-b7d8-d0ef6f8c2300@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59372e42-2eab-4efd-b7d8-d0ef6f8c2300@leemhuis.info>

On Mon, Apr 22, 2024 at 12:31:37PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 04.04.24 23:22, Bjorn Andersson wrote:
> > 
> > On Mon, 25 Mar 2024 09:58:35 +0100, Johan Hovold wrote:
> >> Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
> >> supply for GX gdsc") the GDSC supply must be treated as optional to
> >> avoid warnings like:
> >>
> >> 	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator
> >>
> >> on SC8280XP.
> >>
> >> [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] clk: qcom: gdsc: treat optional supplies as optional
> >       commit: 6677196fb1932e60b88ad0794a7ae532df178654
> 
> Bjorn, quick question: this regression fix after more than two and a
> half weeks is not yet mainlined. Is there a reason? Or am I missing
> something here?
> 

I failed to propagate it, until only a few days back. It should show up
shortly.

Thanks,
Bjorn

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke

