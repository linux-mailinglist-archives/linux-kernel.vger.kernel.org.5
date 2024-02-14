Return-Path: <linux-kernel+bounces-65320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A8854B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB9CB227D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E355778;
	Wed, 14 Feb 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxxk8g7s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18FD54672;
	Wed, 14 Feb 2024 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919773; cv=none; b=ccnA/YTODp6WKSbfYCUfwRR0/37q5iiPpxLbk5ud/c176SnnhTMJiSdnKBSKwI7Z5/0DKGrY0xob7V7enkR2NnKwYdQBZTmPsAiN2ETBkcZ0QDc0FSRSsZ74tcjaY/Idy6owj4Gjzxr/rvw34padKiIXuKaOkXB14URZM/dLowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919773; c=relaxed/simple;
	bh=prrU+2rb8WSBlJKg4/DaFqxlc6JwuwO2bPcuZ3Ze08k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAAMLMNhKI7hvdNaaSVjtsmHl/6/TYM8ANl5IM6I3g8yfzdEXCKMvE/co1nkG9VfSM1WbHmHiSg984ZnSBv7vrF0VxulRZQ6g6bIG2vpty8N0heGz8CPS0Fpyn//92zz6mkGJX/bHv5jh/9CxmKhOOmUNcXJcsvjzLQei2Bw+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxxk8g7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212ACC43390;
	Wed, 14 Feb 2024 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707919773;
	bh=prrU+2rb8WSBlJKg4/DaFqxlc6JwuwO2bPcuZ3Ze08k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxxk8g7sB7afAAW/gxhROlk2joqPCmi6oLP7cD4lpuJD4tTP0LsMm9BQHGuHGwk5+
	 gukv+3lWrnu8m/vZaKr4PURClWA0OrPaZGMup5ko8BZmAZA+fBaZ73FdVrPBKDGu6l
	 bYAGijLpQ0RBt4m3SR5xmt/KMAMy8aakxXd5FfqVqICLOk14S9QmVRtO61/+KdNpSs
	 N6jqRqN4sOy9gp72ihb/ETq+71AIY2JJ7Ei20odHIfv3fcxUvDIpDPLHxFselFE0S4
	 XiNU8gElC74TBDEj+xw4kzULx6xdNdwC4CiRmVtrC5YgdNfxj10BgKSlElcTCKk2n3
	 V2zzIxjjovR1Q==
Date: Wed, 14 Feb 2024 08:09:31 -0600
From: Rob Herring <robh@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, nm@ti.com,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	francesco@dolcini.it, linux-usb@vger.kernel.org, b-liu@ti.com,
	afd@ti.com, srk@ti.com, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, r-gunasekaran@ti.com
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <170791976957.762179.4700463999378462794.robh@kernel.org>
References: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-4-147ec5eae18c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-for-v6-9-am62-usb-errata-3-0-v3-4-147ec5eae18c@kernel.org>


On Wed, 14 Feb 2024 11:46:48 +0200, Roger Quadros wrote:
> Add PHY2 register space to DT binding documentation.
> 
> We use minItems: 1 as DT update will come later and we don't
> want warnings for existing DTs.
> 
> So far this register space was not required but due to the
> newly identified Errata i2409 [1] we need to poke this
> register space.
> 
> [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> Changelog:
> 
> v3: no change
> 
> v2: add minItems and update commit log
> 	https://lore.kernel.org/all/20240205141221.56076-5-rogerq@kernel.org/
> 
> v1: was sent as part of different series
> https://lore.kernel.org/all/20240201120332.4811-5-rogerq@kernel.org/
> ---
>  Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


