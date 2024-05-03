Return-Path: <linux-kernel+bounces-167377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7647C8BA8A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F927283105
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A9D149C53;
	Fri,  3 May 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtg4hZx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4F148313;
	Fri,  3 May 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724691; cv=none; b=nLbUFLaETMiSADHcng8j/7A3RaLkyAdH17XLtXMiQupwPp/Wn/R7nvToe6XySkssbB+g2m8Jq26UlclGtrUlURYCVflyM/tzB5OvOXD460K6CT8zqJEGMx7dymvIQz2QWTHPaYrdrwGJOJcCRApa6I/D725IRbEAuh7azBRdIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724691; c=relaxed/simple;
	bh=8krA6oPxNixCEtNeNzJAv63F5yfpATT0K9/1XWZCeGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XahqiRTfxjfjxAq+9bg9SL8qmbHaN4Qwba6LkB5cVC8+7ZWh5aD0YpGaLUjZZT+MFYkhZVCQfLSMgWIXkNFg8TFOoKJUXkb6nnonwF4g9BEWm69SullVMkZ2MyPkY2R8UlLoKefbgvqd91U90Ml85WsyxBpZbpXI96s4V01VYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtg4hZx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7177C116B1;
	Fri,  3 May 2024 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714724690;
	bh=8krA6oPxNixCEtNeNzJAv63F5yfpATT0K9/1XWZCeGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rtg4hZx0dy65+Q3VXMkenm1Z4XbllBwBQU1G2FH2aWOQA/whveWb+LPEE8q9oMiqv
	 GJsAbw8RC2yAbObkT+EzxykcFeEGtq+jOZZSIB62WX51Wwq4xlKgyvvzKWBpQOcCvT
	 fRYkQ+tuOSBUCM6XKm5p96ollDIJE9kIgAJ1136y+91fqsp98csZpqctDViKcQcmX3
	 89JJYyVykEuTmthi6lRYKmiU8i2rPH/LkR54VUZda43brEyTwvyc1ayuTOFE40cDyJ
	 Ba9MVPkLepzSDiWrmAEZWovdIOOwSQdJfS1PjTlETIJpvLYqn/tMO247hOH3+ClBlH
	 Tp+ZV4MWejNhw==
Date: Fri, 3 May 2024 09:24:44 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: mfd: Use full path to other schemas
Message-ID: <20240503082444.GJ1227636@google.com>
References: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
 <a2886f72-210e-41a1-aae0-c079a4d11396@linaro.org>
 <0af10387-ddfb-47b0-b59e-eeba1644be1c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0af10387-ddfb-47b0-b59e-eeba1644be1c@kernel.org>

On Fri, 03 May 2024, Krzysztof Kozlowski wrote:

> On 03/05/2024 10:08, Tudor Ambarus wrote:
> > 
> > 
> > On 5/3/24 08:21, Krzysztof Kozlowski wrote:
> >>  .../bindings/mfd/samsung,s2mpa01.yaml         |  2 +-
> >>  .../bindings/mfd/samsung,s2mps11.yaml         | 12 ++---
> >>  .../bindings/mfd/samsung,s5m8767.yaml         |  4 +-
> > 
> > Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> So this should be Ack. You cannot review part of the patch ("I have
> carried out a technical review of this patch...").
> https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/process/submitting-patches.rst

Reviewed-by is totally appropriate here.

-- 
Lee Jones [李琼斯]

