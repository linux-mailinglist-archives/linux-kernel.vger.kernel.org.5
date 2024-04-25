Return-Path: <linux-kernel+bounces-158876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4A28B261B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213301F23DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465AE14D6FC;
	Thu, 25 Apr 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvq2lU3Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079714D6E0;
	Thu, 25 Apr 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061639; cv=none; b=YYyqQpOTRtJKwOKy0KZUe+2eIGBM+Tb04iRWNEy9aYh8umANSMJe2A4fr8ZIKADSXhJk6BuOiJHk4xHMyzirCpEx1uP/A2mMaew1q7P/WPqq84LgsvWIANwbhgTk6bf/4tO17EhwXuO6UORL8inOBExUjkej54d25qp+YHrXScs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061639; c=relaxed/simple;
	bh=feTbD2uTqi+ngg+EWsqq4nTtcv2X2wbI6YTY0TM5urQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI8OeoXLgUYh+5kieiS0CxW6NVqnLCXon3bIsxkqoxfZkuLrmqrnXoORDOVXOhm/IEpHiiKHn1o2mbB/Z124I3aWkKmjcAywMkiQdgacZnhDewCIisk1mL73jW1OKZsdoIpcjYMykYnVWj5qZhc65ql5Kh8jN7qSqwJO062s7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvq2lU3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF1C2BD11;
	Thu, 25 Apr 2024 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714061639;
	bh=feTbD2uTqi+ngg+EWsqq4nTtcv2X2wbI6YTY0TM5urQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvq2lU3QMJOQ+m997z8dJi9QqF2Q0BJX048hYDevUOtGvMTTjFfZ3HOY75CNckttF
	 hDbsgGv5Sd5pFeLj7PDQpsqBRsNRZROMQEXoRbVGz9OFNJGCwo6lnzv/pU7Rjx2D4D
	 DgiBCs8Q2mKW9E5I25hrmc8IKI3M9axUGIe4/eIRnGTzQ5jHk10bKgiTfDzbcYbSRw
	 FtNGrYcbHe2AwnBUQwHohsxqyqlp71QhB81cqLw2VDWgRFM/R/TvFcdz5b2Tid/Egs
	 b+ZqzWIS9yzkrw8hhfo7SUYIoUck09smLMhcR3FUWJNuqGlH48MYqIfRdORB2RbojJ
	 yQlx4fZOuxR3A==
Date: Thu, 25 Apr 2024 11:13:56 -0500
From: Rob Herring <robh@kernel.org>
To: Xilin Wu <wuxilin123@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junhao Xie <bigfoot@classfun.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Tengfei Fan <quic_tengfan@quicinc.com>,
	Molly Sophia <mollysophia379@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 08/10] dt-bindings: vendor-prefixes: Add AYN Technologies
Message-ID: <20240425161356.GA2729350-robh@kernel.org>
References: <20240424-ayn-odin2-initial-v1-0-e0aa05c991fd@gmail.com>
 <20240424-ayn-odin2-initial-v1-8-e0aa05c991fd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-ayn-odin2-initial-v1-8-e0aa05c991fd@gmail.com>

On Wed, Apr 24, 2024 at 11:29:13PM +0800, Xilin Wu wrote:
> Add an entry for AYN Technologies (https://www.ayntec.com/)
> 
> Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index e4aeeb5fe4d1..c2365b0f4184 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -194,6 +194,8 @@ patternProperties:
>      description: Axentia Technologies AB
>    "^axis,.*":
>      description: Axis Communications AB
> +  "^ayn,.*":

It is somewhat preferred to use the domain name (ayntec).

> +    description: AYN Technologies Co., Ltd.
>    "^azoteq,.*":
>      description: Azoteq (Pty) Ltd
>    "^azw,.*":
> 
> -- 
> 2.44.0
> 

