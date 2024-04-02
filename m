Return-Path: <linux-kernel+bounces-128336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9000F895971
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0A51C22107
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544955FBA6;
	Tue,  2 Apr 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYigrtOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADD14AD1D;
	Tue,  2 Apr 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074552; cv=none; b=NmBWCk/1ihaNM7zkyfGdhJnGOzSINU9uC86LsQzCaq2R9Dsgi8dwigCfEQTMqwkINmqSfV9BCv5gLXyO5dRNsZMX2MpZqY300pRh5fTMc+BQVwbVaCk9kCy+60jjc1M7r4saEymcgeay6OVxQUQYH+iC2VSYeHah1YPH7zI0KI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074552; c=relaxed/simple;
	bh=4NxXywfhlZNac9KSvHpb7hWlGWljpny7k88YW/fGUtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flCQUwx41yutz/xZ2g/pzzDQyb1YNmm9jAtIKtnagD4CJOYWy2BgYvNm8b+UTvrdhWmdsyW4sdbUsbfvnb2Pbho98I+IZDL84BFzFmquWeJUGAJfKG+z5SWnU5jb6kchOJPjyZvld+MUU93T+uXoXWln/LUHXfxOdchIq6Lp2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYigrtOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58D2C433F1;
	Tue,  2 Apr 2024 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712074552;
	bh=4NxXywfhlZNac9KSvHpb7hWlGWljpny7k88YW/fGUtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYigrtOV+u4k7E1CeM0cd+q9lkmsaFscaPs1nNLOAqFwYz8G17Ph2vC+xr8IdutUL
	 cFM4JMecXBBoB1YV7yahrKuuGu9A/6+zF03a1bDuF1HwYEjwwUfVzKsMNTijLC4gmO
	 zESBiNaA7778fOaKb1l5Mkv7YA8ytOSZ3dk8MNz5VKzheg7nh6/ugVelxwpD1mkurB
	 Gk2GZlhaodniLa3fanI7P/eaAuHnjjYFMnM/FjCSix5fHcLFaAh2qhfNS5iniYKc2i
	 AA1LjoO0ZnbBmT7b7Itx6P4OSeSol10+lJ8WY4nP7rUeEpD/CnxRpXj0k4Mb1VpETV
	 fWb+aCVYfKDRA==
Date: Tue, 2 Apr 2024 11:15:49 -0500
From: Rob Herring <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: davidwronek@gmail.com, manivannan.sadhasivam@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
	konrad.dybcio@linaro.org, linux-phy@lists.infradead.org,
	conor+dt@kernel.org, kishon@kernel.org, devicetree@vger.kernel.org,
	andersson@kernel.org, vkoul@kernel.org,
	linux-kernel@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: qmp-ufs: Fix PHY clocks for SC7180
Message-ID: <171207454539.241562.7875961224491277526.robh@kernel.org>
References: <20240401182240.55282-1-danila@jiaxyga.com>
 <20240401182240.55282-2-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401182240.55282-2-danila@jiaxyga.com>


On Mon, 01 Apr 2024 21:22:39 +0300, Danila Tikhonov wrote:
> QMP UFS PHY used in SC7180 requires 3 clocks:
> 
> * ref - 19.2MHz reference clock from RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from GCC
> 
> This change obviously breaks the ABI, but it is inevitable since the
> clock topology needs to be accurately described in the binding.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


