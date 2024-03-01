Return-Path: <linux-kernel+bounces-89145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE52E86EB1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AF48B25200
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B9F5811E;
	Fri,  1 Mar 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugeuB6tS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8C25788F;
	Fri,  1 Mar 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328416; cv=none; b=GtdcYMEK1TFMNLO8dnH2haTkEKClNlNHTHweaYOEloH1Lkq6/Zid1D/aO+VdM5JuEU2I8XrNrh68qzdIcuijgt5TMH6A6JNuetK99l4GR+jA+mZUG5jt05SGUNh0YLgUzzwA3IDxPK7dBnGwycMcl8G4pEMzVwQAjEI2RbFtfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328416; c=relaxed/simple;
	bh=LJhDcUWUX1NzmdtO9WA6LfJwGILMllsjGn+KovvtI3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p421jMG8SQcAZ7poWevIcXzgod9/B6Yo1MPqS4ReYb1csWXcxaXaEOvIcT0CldgN1WhympQtIXnmI3OPk5xd1Dw85dcehMQzc3HvOucb71wdq+QHptkmXHgoxuH9sTcIAcPUfG+SSzu6pSJrnFBVdvgjS8qlBR0Bggy8H6Ofr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugeuB6tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5F2C433C7;
	Fri,  1 Mar 2024 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709328416;
	bh=LJhDcUWUX1NzmdtO9WA6LfJwGILMllsjGn+KovvtI3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugeuB6tSUb3Rk7j/+mvje9YJb7UvtD/Y85YRJDM9wLqGA6ZirdzBIK8s8gtr7zIAp
	 E8B3nPuRLLdtF2s9nBNWT+t139+bp6l9Top5Kql8cmuljnG2+lS2Qnztlo+Z2sxhVN
	 bRU0epV/yZ+DiwFeNkeoEtmDFf9tpqbVQq4k5MR2VQen2XI0CENgsHl8xIKtWNUtF/
	 jTOckQ8P0DOVe53GOalewzw90LvGJXU60HvUX0mghGoJKcpbyl3yIW9v+4G7I6ZXMN
	 bEBoJrPtKTLaYLs52rS8UjNIgaxTNdyr/Au4aie9Bt/XOP3Ax1mwquHvCvFK5GCvo4
	 N2Ylbz67vZAHw==
Date: Fri, 1 Mar 2024 15:26:54 -0600
From: Rob Herring <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: alexandre.belloni@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andrei.simion@microchip.com,
	robh+dt@kernel.org, nicolas.ferre@microchip.com,
	linux-arm-kernel@lists.infradead.org, claudiu.beznea@tuxon.dev,
	devicetree@vger.kernel.org, mihai.sain@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 38/39] dt-bindings: arm: add sam9x75 curiosity board
Message-ID: <170932841355.3066947.7730098425368875692.robh@kernel.org>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223173100.673543-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223173100.673543-1-varshini.rajendran@microchip.com>


On Fri, 23 Feb 2024 23:01:00 +0530, Varshini Rajendran wrote:
> Add documentation for SAM9X75 Curiosity board.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


