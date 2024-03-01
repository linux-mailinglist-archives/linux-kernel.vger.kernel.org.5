Return-Path: <linux-kernel+bounces-89135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99C86EB03
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785A21C22D14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C657335;
	Fri,  1 Mar 2024 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtKXy3Zf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28EB3C464;
	Fri,  1 Mar 2024 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327867; cv=none; b=RRJ0P4WXk3SrPTknOQiP2l1LX1YqGQYsYbMSiwqYOoyV+KPEUzBk1PAw8jOD0qNzYUV6TfA7ZKfDj6mJ2cN0CEl8f3Q8WnEP7HN311Ib5xA8J0+fNoBYZXa2UmtC5kOVer+QpAEuuG0jopu8Z7ngZCSE+qymVKSa/Re934zZDVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327867; c=relaxed/simple;
	bh=ynPmWgUp8GFmhIVQKnFx8IGIML9tTdRJFvuuDRkyDaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHM/J48pLBYT3InoPTv+cjrSqmL+ApVsi5Z4dzME68Mxy9gaxnX14q3EbnCHJzzkYMbmtLVfVVl4r6vaNCCpNMMPffgpp6g7EhEhYgZfPHphTCqd9OG3kDN4w5Nuh889fR6E/lA81dyZdPv2m20A9Y76NhcjmvFSl4kkAsiUPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtKXy3Zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB61C433F1;
	Fri,  1 Mar 2024 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709327866;
	bh=ynPmWgUp8GFmhIVQKnFx8IGIML9tTdRJFvuuDRkyDaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtKXy3ZfVWf6FtTOqVuW2Wud1JOJFOnwvz3IowNi20ZNCtcma9UdHQ+0/MOlR1BdZ
	 RGNkaERN961p0m8tQfxWb75eaYvbzSdCL1kbXKFnGdeyt7AeUtCYkP6j80zre/+reL
	 08DD8D1ckn6w/wTLU8/MXv1NriChSWjVySAfeAwj62gyy0j6lEvxrkPxslFVtOiWbZ
	 ti/RLNgFsB2MmgGG8Eke9aJdJH7u+fg1ps7OQc522PD6t216Xq6iU7G9DRlm+9BSyM
	 pX8YGjCFUezM1VLFK3PEelaFKIyJTxFYG74xqNnht7JPa5u8i6bkfHux1c/Ym1DdyF
	 fgWAa908nBluA==
Date: Fri, 1 Mar 2024 15:17:44 -0600
From: Rob Herring <robh@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-watchdog@vger.kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, linux@roeck-us.net, wim@linux-watchdog.org
Subject: Re: [PATCH RESEND] dt-bindings: watchdog: qcom-wdt: Update
 maintainer to Rajendra Nayak
Message-ID: <170932786350.3053624.11905872350641616788.robh@kernel.org>
References: <20240223161455.4009469-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223161455.4009469-1-quic_jhugo@quicinc.com>


On Fri, 23 Feb 2024 09:14:55 -0700, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> sent there will bounce. Sai has left the company and appears no longer
> active in the community which leaves this binding orphaned. Rajendra Nayak
> has volunteered to take over as maintainer.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
> 
> Rob, will you take this into your tree for 6.9?
> 
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


