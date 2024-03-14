Return-Path: <linux-kernel+bounces-103327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB287BE24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFA9286F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178226EB79;
	Thu, 14 Mar 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E15lWIZ7"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD95914B;
	Thu, 14 Mar 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424613; cv=none; b=EKAG9t1qEh44I3cu1TFMG25ZmiH1uLShlf5VE+m0Fy+O2JHocPH/qGy67693CPVHeQ2Q2wyP5DxOqIjsmb6O1KmyM8JIle9USmIRdwytpOd7WfTFHxa6rVXAZjAVFAbY1Fw0+fFAePqalo13IumqKU3ShvzuZoqyu66okXELR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424613; c=relaxed/simple;
	bh=+qaZ/4aaT3BK85JCf0n4C3YKOFLdUyyo6bPu0y974dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czkDMKXyp8trjwHLvsU1c32t9wOc4jMecd+U/Aw2kg59TFR3iCIXxxzhIO6Xu6sS8pyfbk8LusQvTsAzCspDEEH4o2tt4qlYpXHMRSV69xThof3DYy2u1aWIjXtbzCUZbiaMdXC1x8+CELaYBNYJuQlGNpFiElZ+WABZoG/QxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E15lWIZ7; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33C044000E;
	Thu, 14 Mar 2024 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710424608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPY+sBymVtGEo48hspVXInRvVKulOZkqYeUVbG9+eUE=;
	b=E15lWIZ7M6ycgKC6edFqRN56DgoPrhCEAWgjp1+G6Tir9NTIgLer82FxkvEpbdFJdjDXMn
	cAFG8W2gdXLoxmtwSdpuJUaTIi48grZTZVvxiaEECgWA/ReJHIcHZa7V3HRBHuHSr01kJS
	NHSPsDNR9s4D1hYLOcuNx7tES5FBikDBBDGfy6eIdw16+J4HBTioupN8Fo4AOy7HVR03+f
	nZhhnWA0LFz3AhSnvLbuR+cKMe6+PrcybKdqUznG/nlqDn4qBhNHxHKFHRJ9W2ZGoeHN7P
	7FOFIbrpciDzgPVP4f6jN/3SJgke4FyIaq4b5i9cd8aGBUT6+7Ib2X9VsDGnVw==
Date: Thu, 14 Mar 2024 14:56:46 +0100
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com, jeremie.dautheribes@bootlin.com
Subject: Re: [PATCH v2 0/3] Add multi mode support for omap-mcspi
Message-ID: <ZfMCHjR2jR-24vTC@localhost.localdomain>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Miquel Raynal <miquel.raynal@bootlin.com>, yen-mei.goh@keysight.com,
	koon-kee.lie@keysight.com, jeremie.dautheribes@bootlin.com
References: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223-spi-omap2-mcspi-multi-mode-v2-0-afe94476b9c3@bootlin.com>
X-GND-Sasl: louis.chauvet@bootlin.com

Hello Mark,

Given how far we already are in the current cycle I suppose this series 
will only be considered after -rc1, will you want me to re-send or will 
it stay on your stack? I know some maintainers prefer contributors to 
re-send and others don't, so let met know what suits best your workflow.

Thanks!
Louis

Le 23/02/24 - 10:32, Louis Chauvet a écrit :
> This series adds the support for the omap-mcspi multi mode which allows
> sending SPI messages with a shorter delay between CS and the message.
> 
> One drawback of the multi-mode is that the CS is raised between each word, 
> so it can only be used with messages containing 1 word transfers and 
> asking for cs_change. Few devices, like FPGAs, may easily workaround this 
> limitation.
> 
> The first patch removes the current implementation, which is working, but 
> don't comply with what is asked in the spi transfer (The CS is raised by 
> the hardware regardless of cs_change state). No drivers or board file use this 
> implementation upstream.
> 
> The second patch adds the implementation of the multi-mode, which complies 
> with what is asked in the SPI message.
> 
> The third patch is the suggested optimization for using MULTI mode in more 
> situations.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> Changes in v2:
> - Updated the commit line for the first patch to use the correct format;
> - Updated the commit message for the second patch, adding precision on how
>   the controler works;
> - Added the suggestion from Mark Brown to merge multiple transfers word 
>   into one when applicable;
> - Link to v1: https://lore.kernel.org/r/20240126-spi-omap2-mcspi-multi-mode-v1-0-d143d33f0fe0@bootlin.com
> 
> ---
> Louis Chauvet (3):
>       spi: spi-omap2-mcspi.c: revert "Toggle CS after each word"
>       spi: omap2-mcspi: Add support for MULTI-mode
>       spi: omap2-mcpsi: Enable MULTI-mode in more situations
> 
>  drivers/spi/spi-omap2-mcspi.c                 | 96 +++++++++++++++++++++------
>  include/linux/platform_data/spi-omap2-mcspi.h |  3 -
>  2 files changed, 75 insertions(+), 24 deletions(-)
> ---
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> change-id: 20240126-spi-omap2-mcspi-multi-mode-e62f68b78ad3
> 
> Best regards,
> -- 
> Louis Chauvet <louis.chauvet@bootlin.com>
> 
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

