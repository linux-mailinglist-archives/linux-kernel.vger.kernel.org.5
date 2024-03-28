Return-Path: <linux-kernel+bounces-123630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87002890BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3137AB211DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8A113A407;
	Thu, 28 Mar 2024 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvlsDCvp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DC12F385;
	Thu, 28 Mar 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659065; cv=none; b=JBrvdLp0xALs83Lg32SD6XGBqSV4fz2iAOah59h3duoCH+gKdkYAO00OmJwJDdohjtQ+skY+b54zsXc2GVWZEq7zr6TSmSkhO/p2eqZF0FaJIcJ4FU8ubpANe4pTO2cmHwH2rk6spZ+fsnRdMW3dm/79es6FSQL22W0RK9Ff3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659065; c=relaxed/simple;
	bh=iOyWwbSJk+L+ozP+CdGJ5tWsDyrn3ZFA+c6SRWUyhZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEJkKWeZqRwUTmaydzX6IJNvObWhcEXVDFajG/83OsO/M5Sz6uk5tMP0On7FrIT0zoXftBDOVqbXPQTkvpnhwL/ZqvB9wzvxSxH1cR6+iodAo+q6ro7CoPzoutrkdXiigah6osfHAaSjL4LxPVz44NBu60Q3tayJtOnL/g6aAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvlsDCvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2A8C433C7;
	Thu, 28 Mar 2024 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711659065;
	bh=iOyWwbSJk+L+ozP+CdGJ5tWsDyrn3ZFA+c6SRWUyhZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvlsDCvp5nvBMzJIew5rLj4PkeBWXO81h3W+/fgJBa1a5k7xSTMCLMJ3p1bBJh9YT
	 UrB72nDFPCpzBAjsVo/tf7vgoVWlrW4DSV7tY6vt4r+hIWJIV1Xz8APeKXRUeSunzS
	 oQZ4yJ/4ft5PCnU8aRuPKeQobdVfUFfHFqzHvr6q8KwjIqEnREVaafCs5o/Vd0/1RK
	 XOCbRB4Ma0zXwEmsWZ/A3ACYIi+Vey1SIj6cABbPaVy8trgJakk2wh5HlFYJn0tTi2
	 DhikL8dzknvtYreOW59zlvYToENi7KXeQSFQFBvhnzJSLNfv+OoZjwA34gf8qI++xH
	 EL20FRmVuMOnw==
Date: Thu, 28 Mar 2024 15:51:03 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
	Daniel Vetter <daniel@ffwll.ch>,
	~postmarketos/upstreaming@lists.sr.ht,
	Rob Clark <robdclark@gmail.com>, Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Kuogee Hsieh <quic_khsieh@quicinc.com>, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: dp-controller: document
 SM8250 compatible
Message-ID: <171165906079.323814.7495184633421494076.robh@kernel.org>
References: <20240328-sm6350-dp-v1-0-215ca2b81c35@fairphone.com>
 <20240328-sm6350-dp-v1-1-215ca2b81c35@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-sm6350-dp-v1-1-215ca2b81c35@fairphone.com>


On Thu, 28 Mar 2024 10:42:44 +0100, Luca Weiss wrote:
> Add the compatible string for the DisplayPort controller on SM6350 which
> is compatible with the one on SM8350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


