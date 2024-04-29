Return-Path: <linux-kernel+bounces-162643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF818B5E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78031F23A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10D085272;
	Mon, 29 Apr 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCSHbLqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277D83CC7;
	Mon, 29 Apr 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406518; cv=none; b=n+fve3wzPMITuiGErWYaKGJoYcSD/IFqDHvvQaB08mCF/8AZD4E3/ddXULqpf5M/MRD1qY1XMQ8ESFvehizRtu1qjVNopVGmSbxAXmU2iO+DGrn5+DyYjNJjgtKc1W0H/OZHA//Jz0U7fEUTSqh0bW/a0+e290QKK+DkWFxjKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406518; c=relaxed/simple;
	bh=UkM343oSMQWEK0dox5ssRSFKZYQm+bsRKHwz7hxlUKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGbzz46inX0LEzijagNrc/MT+GWS+pwja0Z6zokMeEYOdCF6wvbu5eO4LamvO7QN/V6X6IAzQrv1LC+AXtXa1PA3FXFUbtWHGX0Cf4Kn5oCEQYuiGwlFule17AVrzX0JSqhtrcIirKyQvaieYPEE1RKvEM5sBefco7V004ewrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCSHbLqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20301C113CD;
	Mon, 29 Apr 2024 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406517;
	bh=UkM343oSMQWEK0dox5ssRSFKZYQm+bsRKHwz7hxlUKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCSHbLqemrUuzr8Y9IsIyc9/tYXlgGDyYHCqws8PR279di/EongHim/OSoQNpOBC1
	 S6sc0vc9iHCE9Iew3DSGPTG5rzD6JO9QRKQGRgSWBPa6FJCcCa0JA/xCezDJAhasfT
	 jMMWLmUF6726w+EHE4zOt0eQkykMXkah3UFwDRf3rhNzrk6Hk1GYFHAm904IHQvJ7P
	 3QjrM0fV5VoIt94j67JsgxtCjkla6Fw9L7GU/XuLSFs5a2OyV0WwEx+2/uCP3Qcpjg
	 c/7Esq7fCkUyHp/F5x6/mVkYozZsuyUZsjMjEFxWKItHaEWfZyiZOMvFbvGbu8QMJI
	 f5f0U94TUUsUA==
Date: Mon, 29 Apr 2024 11:01:53 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom,smd-edge: Mark
 qcom,ipc as deprecated
Message-ID: <171440646386.1897168.2356516040793552151.robh@kernel.org>
References: <20240425-qcom-ipc-deprecate-v1-0-a8d8034253ea@z3ntu.xyz>
 <20240425-qcom-ipc-deprecate-v1-1-a8d8034253ea@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-qcom-ipc-deprecate-v1-1-a8d8034253ea@z3ntu.xyz>


On Thu, 25 Apr 2024 21:14:30 +0200, Luca Weiss wrote:
> Deprecate the qcom,ipc way of accessing the mailbox in favor of the
> 'mboxes' property.
> 
> Update the example to use mboxes.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,smd-edge.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


