Return-Path: <linux-kernel+bounces-121440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC3888E7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9332E690D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E04714388C;
	Wed, 27 Mar 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVDYdcZs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F912FB37;
	Wed, 27 Mar 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549905; cv=none; b=WApmHqIt7n3wlCqPaD9n8I4xM3IOS3IVgPuRTmewEZJDpA0pjwYambvFoXP1Saua3IudEj6RmXwUepqanSTUCjaofR1oPCQonfjF6JJHhyqJCwHKTTvmhOrdcCIrjES8r/LqnScuPKXalZXzK5jdDDAMeV8vueyU/0ucokrQ8p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549905; c=relaxed/simple;
	bh=WSfFHYPX7LiFm5Qc/Sh1jixIZvZpfvnCSHlkNIVG6LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqlY4tCxhdfqgI9+m0FFm5Hc51epksvZWsPKj4pzifcdoDV6IaxIT9zbTTc12uaDEwdT8PFgdqueGJKiC+iKIMVbESZQg+UtCaeHCrXekb7d78aI7oGvz0i53F0ahZpXRn2/PxS0olVHJCWouuwuhFE0YrPlp6ZAWoxber+Oz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVDYdcZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DA6C43390;
	Wed, 27 Mar 2024 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711549905;
	bh=WSfFHYPX7LiFm5Qc/Sh1jixIZvZpfvnCSHlkNIVG6LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVDYdcZsMxwev24HHNXmT2hRITCKPMOqWZCGAM/36OnKO0XEnKJd9oU5d3U0LW7kz
	 LWuhSCveHFa7unOrGwUrabmzR2dCcSQjrFrCDD59rG86bjyEE4oIXWV2cWtWKSaTrK
	 FdIGFZXefFzxR35etpZUAgWRuXjLY32Aaa52R4qvuLtAukSZ/oBwwZD7x4WVg85J9c
	 pOprFar3IwmNrjNSBUTflL+cTrKkV5yQ//diOkCJ7mwXs8Jr6h6h8Dhj/59AVgNsXB
	 OBdWGAOTlrUQ9nhOBKuYvTEVE1Yfg8HQkhIMsg7FShYIRWwY61iaB9MdVhYoAhEt/m
	 C7uEbjl4EXWWg==
Date: Wed, 27 Mar 2024 09:31:42 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: ufs: qcom: document SC8180X UFS
Message-ID: <20240327143142.GA3267090-robh@kernel.org>
References: <20240326174632.209745-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326174632.209745-1-krzysztof.kozlowski@linaro.org>

On Tue, Mar 26, 2024 at 06:46:30PM +0100, Krzysztof Kozlowski wrote:
> Document already upstreamed and used Qualcomm SC8180x UFS host
> controller to fix dtbs_check warnings like:
> 
>   sc8180x-primus.dtb: ufshc@1d84000: compatible:0: 'qcom,sc8180x-ufshc' is not one of ['qcom,msm8994-ufshc', ... ]
>   sc8180x-primus.dtb: ufshc@1d84000: Unevaluated properties are not allowed ('compatible' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rob, considering limbo status of this binding, maybe you can take it
> directly? Would be the fastest.

Applied for 6.9, thanks.

Rob

