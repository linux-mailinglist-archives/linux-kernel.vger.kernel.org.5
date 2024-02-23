Return-Path: <linux-kernel+bounces-78415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2F486132A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEE1B251F4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E75C8FE;
	Fri, 23 Feb 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyUPSWf4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E237E779;
	Fri, 23 Feb 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695963; cv=none; b=uzXerCPPKZP1ZqEDpT7gxpD93EFVHemKFgndF4V3zNH2L8gdiS43iJcciqabfhyfsgwoZr1afK113y0rAXwc9ecyKUEVF3UYymzz4FV8fbNXl689kC+9vX1NcDnyv19zOCEkjaH/h2/jIDlr/yvXukDyHIwrdEtW4a+NzGOUGig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695963; c=relaxed/simple;
	bh=yHKE8iCyFnaVY1u7Z7xo7dhXjG5IiAU0ATJQ41IPm7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqhGTZ2MIdvjis18qkske2h6LlqpJZl6DDkDAuVoO1pN/KpXWpQ6fasVnv5Sn9zRHhFTzghVL/EHtoliU1/aTBltNDbLWuWqyYm/TR9q8xMamB5z3+aQATrJrEeEN/v072CEdgvt0iEdwRre/WIoFjtgYuaG8YZMvngNyL3Dx3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyUPSWf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0B8C433F1;
	Fri, 23 Feb 2024 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695963;
	bh=yHKE8iCyFnaVY1u7Z7xo7dhXjG5IiAU0ATJQ41IPm7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LyUPSWf4EEOn7Z5deDEaGz/CUWw14RNRPjyg+paa0U7TwIrk6Cd37O9nhkyw8YlCZ
	 HaqYjSXGd74dtooNa+5v4cq0f39oOglGhJF+kkIsk5OJzmW1Lv4PZe30JP7YnUsUgj
	 NQ1upwbXYmKojvYjF0qQMECp/cyo4ZruHIgCHNq6ExVEE6++tK02lcmmPSaAhKzbks
	 GG5JtVfnnMP/ywBY+yBVauUoJWEzW/jDSpgMay9HQ/TH06KfCo/bK3Xhe/HFxNG1mn
	 +GFgthicFJABSFlAbbFgr8jUNxqQ94YvQaOn6xl5eH9nOIgxWypVKFSFi5hyVtv1xB
	 sVdeuQgQDWSEg==
Date: Fri, 23 Feb 2024 06:46:01 -0700
From: Rob Herring <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: andersson@kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
	adrian@travitia.xyz, david@mainlining.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, mturquette@baylibre.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: clock: qcom: Add SM7150 CAMCC clocks
Message-ID: <170869596032.1760474.1949121239875836418.robh@kernel.org>
References: <20240220165240.154716-1-danila@jiaxyga.com>
 <20240220165240.154716-6-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220165240.154716-6-danila@jiaxyga.com>


On Tue, 20 Feb 2024 19:52:37 +0300, Danila Tikhonov wrote:
> Add device tree bindings for the camera clock controller on Qualcomm
> SM7150 platform.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../bindings/clock/qcom,sm7150-camcc.yaml     |  60 ++++++++++
>  include/dt-bindings/clock/qcom,sm7150-camcc.h | 113 ++++++++++++++++++
>  2 files changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-camcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm7150-camcc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


