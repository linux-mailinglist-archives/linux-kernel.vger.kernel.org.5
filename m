Return-Path: <linux-kernel+bounces-105541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A761087DFEB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB8D1F2124E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB8C200A0;
	Sun, 17 Mar 2024 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmO55PF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CB279E3;
	Sun, 17 Mar 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710705990; cv=none; b=gZepKX1TzKGzGo1AAgk0G0aYSjejq1omIcKrc4ZJJPx4VunNosnk7r1k6oMQmb7nah1dNGqPOCoRw3NmIhPqTzZVpEVFoxZ2FTpKWoB3s+9k39qgt69uBL2dxhstkjNuhZacr7fWa3RVpCKe+e/onBPj5wktlQKeLVY0tJSe+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710705990; c=relaxed/simple;
	bh=sFEHSjac8D3PtwCoVIQIp9ed7NUBbJyBtQx8DW7CYHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKzUl++yTyBePF8DGtD3hyNKMrB6cwuvwMcR2XzbRuDilwty90HR1Zp1NGRQDx64YKiM7G1Uz3SEzdU4o103lwiomTrE/RwhrVhFFHmOOQH36eKUSEuS9Qq5yR/JYmQAdVhexEhPSIHEcnyMJUlreqcNhXwoXyL1p+h+yW2v7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmO55PF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088AFC433C7;
	Sun, 17 Mar 2024 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710705989;
	bh=sFEHSjac8D3PtwCoVIQIp9ed7NUBbJyBtQx8DW7CYHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmO55PF+27CYXtYz0jkopdHUjYs9RksuwoQcqWTdNPRY3OcaqcLkh+pZ+RLVhlpNo
	 jq9am4kudwG9uDvzQjVIlw9RzjLf5HfUAanHe2GwNrFqeKhqbWzVeUzqYbkK1/lta3
	 qBKGqLzx0+h9H+t9hia/j06U/pkAyIHeTvlIfyV83BDI//q84HTPGoI6zuVet1WZ1R
	 ZIKwq/YFAZzMR7wXQBxVn9katyHo9ZCgB3Ys25cj/+yw6GbeiyKYZVoPdy//t0NeKv
	 wVNOjAclCDO603/b/uv3iezx1Ui/mBcALUlTmiUIqnnMItIQfex2kjTE4RRjipQYB+
	 lY+fLrhLuRUIQ==
Date: Sun, 17 Mar 2024 14:06:25 -0600
From: Rob Herring <robh@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, christophercordahi@nanometrics.ca,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, herve.codina@bootlin.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 02/13] ASoC: dt-bindings: davinci-mcbsp: Add new
 properties
Message-ID: <171070598512.2141016.568175668659767924.robh@kernel.org>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-3-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315112745.63230-3-bastien.curutchet@bootlin.com>


On Fri, 15 Mar 2024 12:27:34 +0100, Bastien Curutchet wrote:
> Following features are not described in the bindings:
>  - The McBSP uses an internal sample rate generator to provide bit clock
>    or frame clock. This sample rate generator can be programmed to be
>    driven by McBSP's internal clock source or by an external clock source
>    (located on CLKS pin).
>  - McBSP can be configured in 'free-running' mode so that its serial
>    clocks will continue to run during emulation halt.
>  - McBSP can generate a SYNCERR when unexpected frame pulses are detected
> 
> Add an optional clock item that allows to select an external clock as
> sample rate generator's input.
> 
> Add a 'ti,disable-free-run' flag to disable the free-running mode. This
> mode is selected by default by the driver that's why I add a disabling
> flag instead of an enabling one.
> 
> Add a 'ti,enable-sync-err' flag to enable SYNCERR generation when
> unexpected frame pulses are detected.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  .../devicetree/bindings/sound/davinci-mcbsp.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


