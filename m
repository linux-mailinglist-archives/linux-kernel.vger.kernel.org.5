Return-Path: <linux-kernel+bounces-78409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE7686131A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE87B230ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10387F7CA;
	Fri, 23 Feb 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+1dJ11X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94217C0B7;
	Fri, 23 Feb 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695899; cv=none; b=tifYOgFC0eawqdFKXtCFa2ce7XdeZnVogmk5IlB4ZUeofbLZy+I4AzL5gd+66XV1TTaSXeY5tjSWxNeS94n4omfvJNv+wqyyiaIuWWYRuA72RFDjxc9g14ZQQmfNkB5JbPVal1vzi5HYT5luPhF+wNc5pbS7jjKQZlP2/cB1Ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695899; c=relaxed/simple;
	bh=1F9fR2uIOGyzzAWTvTKIzydyCEWW/JWJN6l0R95QyM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHGLOM1vS1i32/5e9pXCdBDApQO4ZSu9/cq1ZFXT6wzbgDuaZ0FZ2UOoCrhkbhfT4uwFpJdsIO5HC9izxj6ZygJ3Zb3DFgetZHj4JJ98J9BJHkFHUXQelgPwFLet2Tll9ce7LNRVBYHi2yGpmxw5fZJkhtXofWxwkru3y/BZ+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+1dJ11X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F90C43390;
	Fri, 23 Feb 2024 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695899;
	bh=1F9fR2uIOGyzzAWTvTKIzydyCEWW/JWJN6l0R95QyM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+1dJ11XiDSsukq7sXlDNOm+DC5lvXB5fTw/igG6Jv3XmxsANZRBuBg/S2mVOWboB
	 z1N9FtV0lbWrP3FbgyKSjFAfWCBW5142AA0f9RrrRe5HeEXb6sxrYHNexxO9JG32ou
	 4idZO7Lg9DBwq1HnKYrsyBd0weY2/EIetq7VGOxBNQX1WOUD57eeLX2y9AIKeEbdCN
	 Mcw0YJSqtOUWX/o7CLEZCOXKBlN5SpqD8ihY0RQ7NkjBlxsxvlN0uF4WKsQA/ld8Vg
	 WkVpjLtT2F/kY4pG2B7bXtSV8JNc7XN9hR6HppjKZISloGABusIqCqHXTChFey0lS9
	 gCzwGx8UX6G0g==
Date: Fri, 23 Feb 2024 06:44:57 -0700
From: Rob Herring <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: david@mainlining.org, linux-clk@vger.kernel.org,
	konrad.dybcio@linaro.org, sboyd@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, linux-arm-msm@vger.kernel.org,
	adrian@travitia.xyz, krzysztof.kozlowski+dt@linaro.org,
	mturquette@baylibre.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: clock: qcom: Add SM7150 DISPCC clocks
Message-ID: <170869589672.1759235.8199982773056881678.robh@kernel.org>
References: <20240220165240.154716-1-danila@jiaxyga.com>
 <20240220165240.154716-4-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220165240.154716-4-danila@jiaxyga.com>


On Tue, 20 Feb 2024 19:52:35 +0300, Danila Tikhonov wrote:
> Add device tree bindings for the display clock controller on Qualcomm
> SM7150 platform.
> 
> Co-developed-by: David Wronek <david@mainlining.org>
> Signed-off-by: David Wronek <david@mainlining.org>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../bindings/clock/qcom,sm7150-dispcc.yaml    | 75 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm7150-dispcc.h    | 59 +++++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-dispcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm7150-dispcc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


