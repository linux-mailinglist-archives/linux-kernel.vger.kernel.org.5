Return-Path: <linux-kernel+bounces-82379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA2086837A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA41C21F46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F531131E40;
	Mon, 26 Feb 2024 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQoy0Wb3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722E1AACD;
	Mon, 26 Feb 2024 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985214; cv=none; b=f7E/4nLK9Y7zag6t4/UL2qsZsT+NDDhyyXIiWRQ8p5NSLMlDhxCeJiRgAvDUNLGfYIfEHh+ccksFTTHy6vlg/vo/ANDlfZLuttMeMPwm5Av/pcdZS4gBSw0TOZdMdmItumytdSh6V47E7JJGWXfc+KLO4sbFVyuvmNQtbYIN2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985214; c=relaxed/simple;
	bh=AhAkCYM47O8dKZ4IHxet9r4VJYofKYTUO2jJeRmXvNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJ2Jz0m7mrmtw24FMGB1X969T5Sn87zlQVTGVeu1a0cmV5pSWyTOTFfGuHuXWyDrsQtdmiz0v85s9P8uWEWPGYXiQ1NEmaRvhpE1GcwdcvFa6X656LQlQaW/v3XIGMTAsCHpGDvoqGVnSioChIVFuGU9GKsOYa8/+c5mRhgATpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQoy0Wb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46901C433F1;
	Mon, 26 Feb 2024 22:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708985213;
	bh=AhAkCYM47O8dKZ4IHxet9r4VJYofKYTUO2jJeRmXvNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQoy0Wb3pbFwWi3l8cO0Qvzmaa0DZej3NmaCW4Jvq2S5oSoBZ9TQs90YRXIKOKwji
	 gTaTZbZmlXLHdR3k6qBAC8JdTMwGbBdnCpd5AxjK9VdPh/QijxSq2TWBFryB7ZOBxG
	 4PWHDZvR08tUOpi7o+7UHrzZuLFoa2vVC42hYh0ZDGw8ON/d7N4b++9y2wfakJGJsG
	 yK3XM1YFRiIxLzCxmYNYrXwNszp3FM/H6uKRyj7lQZ9p4lWqNmiHVdaldYs6Dn4hGs
	 Xqhqm2EiKhofgwXmNwlk8Nh1SzH4PMbXn6aXtgdWseilZAm8oASqOyrYlPB6eiftTp
	 mclBdC8x7im5w==
Date: Mon, 26 Feb 2024 22:06:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, haibo.chen@nxp.com,
 lars@metafoo.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng
 Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: drop the 4th
 interrupt
Message-ID: <20240226220637.7bc64b95@jic23-huawei>
In-Reply-To: <20240226-rectangle-pacifist-633ae3b801c7@spud>
References: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
	<20240226-germinate-anymore-fb85ca9bb226@spud>
	<20240226192055.54b4a6b1@jic23-huawei>
	<20240226-rectangle-pacifist-633ae3b801c7@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 21:17:06 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Feb 26, 2024 at 07:20:55PM +0000, Jonathan Cameron wrote:
> > On Mon, 26 Feb 2024 16:24:47 +0000
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Mon, Feb 26, 2024 at 09:08:25PM +0800, Peng Fan (OSS) wrote:  
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > > 
> > > > Per i.MX93 Reference Mannual Rev.4, 12/2013, there is no interrupt 268,
> > > > so drop it.    
> > > 
> > > Don't just remove it from the example, drop it from the binding too?
> > > It does permit a 4th "self testing" interrupt.  
> > 
> > I'm missing something. See below...  
> > > 
> > > Thanks,
> > > Conor.
> > >   
> > > > 
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > > > index dacc526dc695..dfc3f512918f 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > > > @@ -31,7 +31,6 @@ properties:
> > > >        - description: normal conversion, include EOC (End of Conversion),
> > > >            ECH (End of Chain), JEOC (End of Injected Conversion) and
> > > >            JECH (End of injected Chain).
> > > > -      - description: Self-testing Interrupts.  
> > 
> > Eyes skipped over this maybe?  The 4th interrupt is removed from binding here...  
> 
> Huh, wonder how I missed that. I thought I double checked...
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.

Happens to us all!  Applied patch 1 to the togreg branch of iio.git and pushed
it out as testing so 0-day can poke at it.
Thanks,

Jonathan

