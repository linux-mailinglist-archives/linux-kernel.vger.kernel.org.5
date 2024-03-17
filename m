Return-Path: <linux-kernel+bounces-105544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AE87DFF1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07867B20E89
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19643200DB;
	Sun, 17 Mar 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJuKQxQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D091EB2D;
	Sun, 17 Mar 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710706232; cv=none; b=Qf8NfKpWOgvE02r1rQnbFQYeix4OCHL5HZ18Xcy2SFPEN5SBOP4N56YrRAbN+ROGe4HcjQ+QiamtaDBEnNOEpl2qogG4HiixKKWUNlII3Bj1g1CTpl3j5Re1POlKZZTMezZkZWOloL4alyBA5I7+Mmq1s8TUu92x48ltYK6HK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710706232; c=relaxed/simple;
	bh=m0qaEC2rBea95oHX1LSUKuzhZbY693N8ozdemzKvcfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgGiHs3adbuPn3Eois2jSCyRuX5VTbBJwWd39qXiTtmq5dEPpLWetAsXbgNdBPVi+SnUWIYJGQ0W1FYVZTHBiiTX3XDFs6blz7qh/KUuxxyZCaZTNX5d9MT+mvCwTBC29cckNRB99WsBu0OPY0/vqpCoZ2n9UQjXwcZIUAUwmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJuKQxQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D30C433C7;
	Sun, 17 Mar 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710706230;
	bh=m0qaEC2rBea95oHX1LSUKuzhZbY693N8ozdemzKvcfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJuKQxQ5HZ3emFjVOQPKMNrHwcgYFfTz/i6fuJAowij7C8t0S89MKrmXb7xbqlfOk
	 sKXlLKOE2cdhaEXLfnUwHL7pDPdVAvcakFZmXi+aZ9s5UjyGS1C6hBDH4OkLqJsPQl
	 aqQnfkzXhJoPH5AjWdicJUfQXzFdVBS2uj6HlvfFLRLjKJRTEj5TyY5rYzQRk1cUlG
	 keqOyTmchEDnZBzdhUHqyfgJFbmtsKvbsyXsnU1l0NdcImwQZ7d0FGij04rt0aGWJ9
	 Zmg/pJ/Yp4e87znvzb/txLPuf3KsUIedXw0KieQP/7z009jRf1cLsGtUbwb2hsb1tc
	 XR3fXDcPUsenw==
Date: Sun, 17 Mar 2024 14:10:26 -0600
From: Rob Herring <robh@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	herve.codina@bootlin.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jaroslav Kysela <perex@perex.cz>, christophercordahi@nanometrics.ca,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/13] ASoC: dt-bindings: davinic-mcbsp: Add the
 'ti,drive-dx' property
Message-ID: <171070619705.2172467.4945077110707168777.robh@kernel.org>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-13-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315112745.63230-13-bastien.curutchet@bootlin.com>


On Fri, 15 Mar 2024 12:27:44 +0100, Bastien Curutchet wrote:
> McBSP is able to handle capture and playback stream.
> The McBSP's DX pins that outputs serial data during playback streams can
> be used to output a chosen pattern during capture streams. For instance,
> this can be useful to drive an active-low signal during capture streams
> (by choosing <0> as pattern)
> 
> Add a 'ti,drive-dx' property that can be used to repeatedly output a
> chosen pattern on DX pin while capture stream is ON.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


