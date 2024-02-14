Return-Path: <linux-kernel+bounces-64755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69205854274
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B821F24CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117810A34;
	Wed, 14 Feb 2024 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5g9znEn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E087811184;
	Wed, 14 Feb 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707888910; cv=none; b=qQPTk3TbmJsxkeFnb/QyfPbnOwhLglAE41VPcjz7ssuvdLDGSYmSowRnLDDl7aT0l0dFmjR73du3QveQsS/tWTQZMzoczStSc0mcFahEH8vNQUMwpKv4pM+TeFyQXJeKX0Xq8/TY7qTdVEZkNlEc/6gJ19udD9+FfGb0TFDEWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707888910; c=relaxed/simple;
	bh=m1GBJXdml05m+ZQGwL9I84ENjQ47pwGxOdhJnLCsWjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XymJOThSppQ0Dl881x/2QDoSz6R7dLz+QOc0JN2PoNxqPjkvgOpMVfChiGctD7OSUqeY5XC3agt+hQq58mMjIJJH6ver13j9E7uZdVsDyFmMJCeMji04Kvt136IHavHeTScdYeyZ4w2AXXWz4tIrFfdM/eAco0Aw+CCfkWvQSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5g9znEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BDEC43394;
	Wed, 14 Feb 2024 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707888909;
	bh=m1GBJXdml05m+ZQGwL9I84ENjQ47pwGxOdhJnLCsWjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5g9znEnbJEjSemVk9BYdVONj5AnSZzmHN6IIaN6v3ahmNsBNLG3znOX7vSYQe6KB
	 zzaxhrKI6ElmQajiZ0cyp57X3oWz6Dfgg2O7yv2ncvt5Oo48kZvY/whlFiv8iWnhfp
	 OKvC8A2TbBGCtGVQwWNhk51iH8/4i47XyYP6ze86o2QzbNXEy78Talhuyk5DyQoEHB
	 yVo1/QZ+PuwVnnnk8woiRtNrJbkKZHKvsr1/sxStx6E2c6hhl3lIHOUzxNsVHzRaQm
	 jpnLrqfqurzI4HLS677g9RvpW61kDaqLJWWtwP1Js3ASAAkAF7PrPL8gHOHCHyKW+P
	 58FsOyyMffHxQ==
Date: Tue, 13 Feb 2024 23:35:06 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFT v2 0/3] Fix up SC8280XP idle states
Message-ID: <k7v2qov3m43q7vniqu3w6q64277ea5mf7gvt6fzgj4e3a5uagt@fcsmuu24cfqr>
References: <20230619-topic-sc8280xp-idle-v2-0-cde50bf02f3c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619-topic-sc8280xp-idle-v2-0-cde50bf02f3c@linaro.org>

On Wed, Dec 20, 2023 at 11:12:53PM +0100, Konrad Dybcio wrote:
> Comparing the data available in the downstream sources with what's there
> upstream, it was easy to spot some differences. This series aligns what
> we have upstream with what is there on the vendor kernel.
> 
> The big asterisk there is that the downstream sources for SC8280XP can't
> always be trusted. A simple test shows that the lower idle states that
> were previously missing are implemented in the firmware (Linux reports no
> errors and enters them).
> 
> HOWEVER
> 
> The only cluster idle state that's been present until now (the deepest
> one) is now barely used if at all, as the scheduler seems to deem it
> inefficient or so.
> 
> Hence, a request for testing and comments, especially from those who
> use the X13s daily or have reliable setup to measure the power usage.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

What did we conclude on this one? Does the extra state make sense?
The last patch looks useful...

Regards,
Bjorn

> ---
> Changes in v2:
> - Rename the idle states
> - Drop RFC, confirmed with Qualcomm
> - Rebase
> - Link to v1: https://lore.kernel.org/r/20230619-topic-sc8280xp-idle-v1-0-35a8b98451d0@linaro.org
> 
> ---
> Konrad Dybcio (3):
>       arm64: dts: qcom: sc8280xp: Add lower cluster idle states
>       arm64: dts: qcom: sc8280xp: Add missing CPU idle states
>       arm64: dts: qcom: sc8280xp: Fix up idle state periods
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 72 +++++++++++++++++++++++++---------
>  1 file changed, 54 insertions(+), 18 deletions(-)
> ---
> base-commit: 20d857259d7d10cd0d5e8b60608455986167cfad
> change-id: 20230619-topic-sc8280xp-idle-00fc007234c8
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

