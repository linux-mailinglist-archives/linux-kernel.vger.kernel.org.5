Return-Path: <linux-kernel+bounces-45283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65018842E09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6F41F257D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9F6E2AA;
	Tue, 30 Jan 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBLrAF3v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FF5C5E0;
	Tue, 30 Jan 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647226; cv=none; b=p/VMFUv72WGoB/brdrVsjRp55VfLIrlUcUkmjTFCudI5wp651eDC4pzcfSQR5v7MYL1emURpd15jwzFyGhoKPLk2gMPa9y59ClygwSfEgMRiexAKnp7pSpkZVrjRHEcguRdUFQhjfAsZbMNjyizp5H4+hXJQLDjJcQIwY9sxPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647226; c=relaxed/simple;
	bh=Tziik9bKi4tX2YkRAA2j4gTiRkT+EbSxGXtn+OgXeg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAM0CbXyPmWxd9Hb6P2yD9Y3EyKHFwiX0dBbvsKDQU0jt9bXlaP719ytfTxyZjrgpjjj3sER/S+gxrQhEJDTG4Sk6voZh7uiqCVTfBRKjxsnwKpVu1G1i0wtl8fyC5L8O0ldm9i1iFg67RijyMOmsYJbpfEm87J7O2qaQuNKKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBLrAF3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D70C433F1;
	Tue, 30 Jan 2024 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647225;
	bh=Tziik9bKi4tX2YkRAA2j4gTiRkT+EbSxGXtn+OgXeg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBLrAF3v+scJrwZ4tZtmUo8NS5KdBeub8PBKcLvqvbdbj6Q7RqEatgXoOa0HyyOGI
	 JYTVQ/zrhEnt74X2C2f6KbCMrlf/ejWZ9Yle+YxkQSN0DPOqprZmgL8w2WhqFkd7dI
	 V8ZkqzRcvNJX/158pWnnPFg/3xahgXnj9eUP+vUpNinC7sBe+SzJWaJiy26/IA/4Nj
	 ayuo181THVN7pSuhlVE9QqSP95SBjGQPNZYTiglthoFTM5Pku+kTGFSgsy2UnKgWzu
	 SKFbwQq+1V3uTV424Reop3y46Wg3f48peoHMhVEG6W/3Cf+FrVjzMmYIqDbNhXGIEp
	 zNjKHSpuiwl4w==
Date: Tue, 30 Jan 2024 14:40:21 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: fsl: narrow regex for unit address to
 hex numbers
Message-ID: <170664722118.2304751.35687320401186535.robh@kernel.org>
References: <20240123083505.21029-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123083505.21029-1-krzysztof.kozlowski@linaro.org>


On Tue, 23 Jan 2024 09:35:05 +0100, Krzysztof Kozlowski wrote:
> Regular expression used to match the unit address part should not allow
> non-hex numbers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/soc/fsl/fsl,layerscape-dcfg.yaml        | 2 +-
>  .../devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


