Return-Path: <linux-kernel+bounces-37330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC8A83AE54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA2C1F24B53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D07CF34;
	Wed, 24 Jan 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="0M5zVTsq"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1A7C09F;
	Wed, 24 Jan 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113615; cv=none; b=aUPt6ArilkFrC/XCGfVOSerzQJZMtNLw6ZOwciCmYhGH7k2RWgR5zPKQ3lUbK9pDTAWhfqajXbpVYjDGJvwd/1gNkaaHIMo4aIUee5p7caUxwXN+d+DueQ9j6LwFfXk2k2RvGxvMn0OLRppVX7ThDKhgLvE59mB3WK6xEa1A5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113615; c=relaxed/simple;
	bh=FkBGahndcL+2wt8un60StIxILa7keWuwDpgpF3YGcGU=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=ZtmC1ARpUgE77gHkf5gIHxNHg0D5lG/Q+LBfTFyL6oKNziaKqZzhND8bD+smJAWu0sFGC+a+3tmhHC+IsQvtaurJ/Nmgi0WeSoAU2VRUB0oj8RCGa+4hBpNRsAUS/G7Xlma50zD2i4ML0bEKzX1gu7g9lkvouF2YbX8PZgjt6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=0M5zVTsq; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=U6FzMn29Q3diIWjLD9mXETyRYfz/jQ44WEMy3dpyv3M=; b=0M5zVTsqorIsPfxxD3Dw04D+QH
	qRHIYFDPoDubnillgwYC3/PYwpIcuX6m97FyVfK85t7XB6ON1roz+eBsYjfpxuSPqXq2xkXECdP/r
	3o70nzUJ1AoCjaa04vfjsacGrMMkjzPMYAjR7k7onLy2P90OIV/p7UecfATJlttuvsyU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48382 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rSg5P-0007i6-K3; Wed, 24 Jan 2024 11:26:48 -0500
Date: Wed, 24 Jan 2024 11:26:47 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Conor Dooley <conor@kernel.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 leoyang.li@nxp.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 andy.shevchenko@gmail.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20240124112647.04b7c0bb45541684230b81af@hugovil.com>
In-Reply-To: <20240124-evoke-lunar-599e43a99494@spud>
References: <20240124154422.3600920-1-hugo@hugovil.com>
	<20240124154422.3600920-2-hugo@hugovil.com>
	<20240124-evoke-lunar-599e43a99494@spud>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -0.8 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: remove redundant company
 name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed, 24 Jan 2024 16:00:48 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jan 24, 2024 at 10:44:20AM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Company name in compatible description appears twice, which is not really
> > helpful, so remove it from product name.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> This only landed in 6.8-rc1, right?

Hi,
yes.

> With a Fixes: tag this would probably be okay, but this does seem on the
> "not worth fixing" side of things to be honest.

I will add a "Fixes:" tag then, because for me it is worth fixing.

Hugo Villeneuve
 

> 
> Cheers,
> Conor.
> 
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 228dcc5c7d6f..f455c0172c84 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -1026,7 +1026,7 @@ properties:
> >          items:
> >            - enum:
> >                - dimonoff,gateway-evk # i.MX8MN Dimonoff Gateway EVK Board
> > -              - rve,rve-gateway # i.MX8MN RVE Gateway Board
> > +              - rve,gateway # i.MX8MN RVE Gateway Board
> >                - variscite,var-som-mx8mn-symphony
> >            - const: variscite,var-som-mx8mn
> >            - const: fsl,imx8mn
> > -- 
> > 2.39.2
> > 

