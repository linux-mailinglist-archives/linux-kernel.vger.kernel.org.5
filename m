Return-Path: <linux-kernel+bounces-53241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1A84A285
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E48B25CF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7647F7B;
	Mon,  5 Feb 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdWZOVHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C90482CC;
	Mon,  5 Feb 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158280; cv=none; b=W7ktC2RxHQ3LfnuEOSFItU++mrcljY62lovZH6wkj984IQcbl9TH1eo3fyNRnjI+ssYs8Gq9CSc1+TNrFZ5Bpc+QFAh1NAPA4DRPxMReWR3MtXeYWOkDX1yva3nJaeMeVs8BrV/s5w0nZki5aQu+OTzGDewzKDEogOWZrAyFrXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158280; c=relaxed/simple;
	bh=KwFuWmMKdMtUD3SifcTFtEjFlbDRjJdQmm2314Bkh1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kkb88/BHe0dQuQZ2gvUl6HXOiVxalxjHDyGVaigwaV+dBjCqTbjMMk6D7fFgbvJIckE/UHR8tMo6nDP9FYO6N9kX0iNgBlPE+C8oN06JWd7Dvkd58Emohiz1OtM2JHBkv9FnrKCyIpc0ZZjAI3AZBKUsCREMLvxK1bCeJEV6+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdWZOVHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA20FC433C7;
	Mon,  5 Feb 2024 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707158280;
	bh=KwFuWmMKdMtUD3SifcTFtEjFlbDRjJdQmm2314Bkh1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdWZOVHgYa4McuTwIMX3ruSsvqnYybA78d052fK8+34bUmF5k7+GKfb1cPwMj6Tpy
	 gVj58bt+8VRpA7TT/6OVATtNuhGM0RZQXNdZbF/ZWkLbDMr/fIKm1jk3JxAI8KVFdc
	 eqmpDu8gBapaksk03H/1C7t1YJHY5ZYH65fZ+HP+ddSdkMVycrzGfIcybsNYXMrZFi
	 jn3X/4Hw6wNvPw6ZBCjILN2VkrWZNAON+9HDIvNdT3lNsse9GP90diKKBeuLPynGZU
	 lEJTmtUg9mqcV3f9CzjGHqpSS9ty3iL2AOilrMeFfd0dXk7hixwQz769j7XTDu12W3
	 43iGVFWZpO/8g==
Date: Mon, 5 Feb 2024 18:37:40 +0000
From: Rob Herring <robh@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
	djakov@kernel.org, linux-pm@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
	quic_okukatla@quicinc.com, devicetree@vger.kernel.org,
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,rpmh: Fix bouncing
 @codeaurora address
Message-ID: <170715826040.3958103.13885911803274019580.robh@kernel.org>
References: <20240202181748.4124411-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202181748.4124411-1-quic_jhugo@quicinc.com>


On Fri, 02 Feb 2024 11:17:48 -0700, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain have long been retired and any
> messages sent there will bounce.  Fix Odelu's address in the binding to
> match the .mailmap entry so that folks see the correct address when
> looking at the documentation.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


