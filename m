Return-Path: <linux-kernel+bounces-149029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348568A8AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658E41C2162B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061F172BDD;
	Wed, 17 Apr 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlHYWZ4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF34018C19;
	Wed, 17 Apr 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377167; cv=none; b=F2BaGDJRN0Oqz8wVTNFwiPt5mcVtdIcwaSJtE32a4BgnCYSW0WkmHfNQqRbH8bcPUEzm+D8OXu6SGhMw060f61gCtTiG/XO5/cI9DrW6w/RyX5jZep/GBenRmhtjLGVe1zU38h43tNehenP88vikTbQvoOQvT1Qr+73sPSphQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377167; c=relaxed/simple;
	bh=ohNY41T1tA08oPYLXwz2Hy7udzvVB4jwFRZPjYTMWT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pbm+Q29cmFB/kP2JDHoZA+AcqmIQjXRU8vjjWLYNcD1+8ePn61tKMg2yst9tllI0eKcWKdrD+avirwAqpWGfPhU5sWmwe5x6+BPZGwf88hDXT/Muv0ts9hPoOjMQSBUSG5b0IFv+k0scsLoHMRTiuIxRCRVxSH1ReRNauWqIklg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlHYWZ4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DED2C072AA;
	Wed, 17 Apr 2024 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713377167;
	bh=ohNY41T1tA08oPYLXwz2Hy7udzvVB4jwFRZPjYTMWT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlHYWZ4jT+Nd8gWymj5v+z9YO6KUsyhEL4d4o4MTNFnMJVMhEoUMCPMpYG32N4+Cx
	 UPBS3PWsMJmTocmI38PVBSrjwtJlFrHkZ6OjRjrl7c3i1+t+2DJdg1gJA2AxYNWdar
	 sQOX7vAaTUtl1Na7oZgyHKJUDAIJ9ztvyaTTecEvfokKzhsJq7zF9gItt/EzVYLtMw
	 Ee3Vjy4dWeC+39hCLbSqH5tsyFgEDzl3R2ojT9wRmTnGxZv8DvwwKT2hg7JOT+Vdjf
	 e1iwDwgYm9t6+7n4tZbxk6/jU7hjqHeHSqqLiO6LKPKm89FIgXKAJKiJFhLzRbQkzc
	 ZEFs9mUXfVnmg==
Date: Wed, 17 Apr 2024 13:06:05 -0500
From: Rob Herring <robh@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Satya Priya <quic_c_skakit@quicinc.com>,
	linux-kernel@vger.kernel.org, andersson@kernel.org,
	chris.chapuis@gmail.com, Lee Jones <lee@kernel.org>,
	benwolsieffer@gmail.com, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: qcom: pm8xxx: Add pm8901 compatible
Message-ID: <171337714570.2877662.5365206887003853128.robh@kernel.org>
References: <20240415123038.1526386-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415123038.1526386-1-github.com@herrie.org>


On Mon, 15 Apr 2024 14:30:38 +0200, Herman van Hazendonk wrote:
> Add missing compatible for the pm8901 model used in msm8660
> such as (HP TouchPad (tenderloin).
> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


