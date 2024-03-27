Return-Path: <linux-kernel+bounces-121700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FFC88ECB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27EEC2A330B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA614D45F;
	Wed, 27 Mar 2024 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qwe7dwQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88C12A14B;
	Wed, 27 Mar 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560755; cv=none; b=Z3Of6hwfuv2OTcS03LZzW9frP4SWiEjzpCqVhZOO+bXmbZVX1KyBetG1niQ6sZe4Tg/Qx3lvV4BVXz4NWCwb5wJ/a5WCHEp6fkpOuI4165y6co0P/LrmiiQJlxuXjNuDnrgtoC0v+jr0/qW6ql3q7Nppvy3d+gLwg9/vrWfbgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560755; c=relaxed/simple;
	bh=3+VqtmATpJblwRQt9MVkGbCCHJ4KeR0YviYHYv4LBC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFHddDgc0R9/g7g6xLbno/28ZrBbMJkSY84zN3NTxCkw0c4Z2ltnOnFiutwARtBcFtUX5HZDybSEMspq+JclLGGYH+/IdsIG8U0YC1JjyQIrLzVwYRbLhUIU66G9Don00tDU/uVivXBKT0xT9l9Kjrx9Xg2JBNiRF507UNvnBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qwe7dwQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396A4C433C7;
	Wed, 27 Mar 2024 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711560754;
	bh=3+VqtmATpJblwRQt9MVkGbCCHJ4KeR0YviYHYv4LBC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qwe7dwQ8aexSMGFGOq7jVjNjV18DghOH/LISpBbFjJI7UDK92aWvKB2T6oE3fIWis
	 mYvWLE5AeVmBAeh7UjBQOFOtmIDfxEH3xfOO6U0abqnePrtntxaI+rrQiOPfen8cOf
	 e/AAkjtKPpJERDcVkSR2RanVewGdjaleblntoazWlO0qzV+O7IyJkYIclSCmISFM1F
	 TcKfgCS/rcH+Tdp8tGQ30ucgET8pnsJP3Qv+dWVXmEtkceaVOTo0N3XXk1KMxY1J6G
	 r0ZC/OhRhLj6ChfuLhqQt3ToSpBf+eRhIjwPRlO4cK3q12k7M7IkUqgDuHDm1X9N/d
	 6mCWkSHWO+gGA==
Date: Wed, 27 Mar 2024 12:32:32 -0500
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: supercraig0719@gmail.com, conor+dt@kernel.org, YHCHuang@nuvoton.com,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	SJLIN0@nuvoton.com, scott6986@gmail.com, perex@perex.cz,
	tiwai@suse.com, robh+dt@kernel.org, broonie@kernel.org,
	alsa-devel@alsa-project.org, lgirdwood@gmail.com,
	dardar923@gmail.com, devicetree@vger.kernel.org, CTLIN0@nuvoton.com,
	linux-sound@vger.kernel.org, KCHSU0@nuvoton.com
Subject: Re: [PATCH v5 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"
Message-ID: <171156075147.3680539.3171999562825718335.robh@kernel.org>
References: <20240327075755.3410381-1-wtli@nuvoton.com>
 <20240327075755.3410381-2-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327075755.3410381-2-wtli@nuvoton.com>


On Wed, 27 Mar 2024 15:57:54 +0800, Seven Lee wrote:
> Add a DT schema for describing nau8325 audio amplifiers. The key features
> are as follows:
>   - Low SPK_VDD Quiescent Current
>   - Gain Setting with 2-wire interface
>   - Powerful Stereo Class-D Amplifier
>   - Low Output Noise
>   - Low Current Shutdown Mode
>   - Click-and Pop Suppression
> 
> More resources :
> https://www.nuvoton.com/products/smart-home-audio/audio-amplifiers/class-d-series/nau8325yg/
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../bindings/sound/nuvoton,nau8325.yaml       | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


