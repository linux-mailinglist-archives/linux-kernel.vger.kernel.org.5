Return-Path: <linux-kernel+bounces-82228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 097748680D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3743E1C23475
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30512FB10;
	Mon, 26 Feb 2024 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0zMHPKD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3041E4A0;
	Mon, 26 Feb 2024 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975283; cv=none; b=KP6PB0PHP+vYGmRVXHg8TtThIvnW573FpYbGGGBFZEWATm+iMR/VnpgB+Dl87KNftxZOKqUCJS8fyn+dJtsYNzDw0UX5kVRWKRHZQV6gpZbu8Gh8+ssO6QmlK9FSQfvF3FOOU8ExiA7CzdDhCernZ9d7w26FYdKNHmFdaVNFlt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975283; c=relaxed/simple;
	bh=wjgaOpqKnPa1lZbDj2bRKbgtOayd+k4TQpqi607Xcfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRizO/r7xYaF85GRQxPXlGbqrxp9aPqe/qrI3IHkVmM8bcdbLJNakpihq+dchSzAw7FYcEvviVzymI9bIn2xhdwnNTKQmJDRYoiiPsyW9OEaY6QcOayfNWsIYhjlSh1H+7dsQb49YILWaoQ5PlQRjEneXpxhhuwuwwLSI56oV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0zMHPKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF66C433C7;
	Mon, 26 Feb 2024 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975283;
	bh=wjgaOpqKnPa1lZbDj2bRKbgtOayd+k4TQpqi607Xcfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G0zMHPKD7EeJ0mhOJu/9CwVwqqTPmaucAJ3Sl5TK9WTWY/XgQ9BN1ZjoqIkHzsIPA
	 BOCSUOP2ys8lt/emCYXSG7eBfW2Jg8QwQk8fkcn/8SCWYXEz1CjjXCy7A2OK76NwLt
	 SE37CBk26HL3kmvm4rFIhEyHkd4kyPFSmBWg+IAXj4r/YOtvRIMA6aIH1Gpc5y75eO
	 opRVMDNsGqzhOhMsaxVqmNG5Xa4IaTR+ZMzK75/wZIiUsujDz5/IEb1pigGgZKtRJI
	 6YNSBZf+PZVNVfAM5wg2mAqh5XCgl3VP0sYezy46pJO2JWhBZbl2P17jRS8s5KlBX/
	 m4nIPxKAGNIbA==
Date: Mon, 26 Feb 2024 19:20:55 +0000
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
Message-ID: <20240226192055.54b4a6b1@jic23-huawei>
In-Reply-To: <20240226-germinate-anymore-fb85ca9bb226@spud>
References: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
	<20240226-germinate-anymore-fb85ca9bb226@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 16:24:47 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Mon, Feb 26, 2024 at 09:08:25PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > Per i.MX93 Reference Mannual Rev.4, 12/2013, there is no interrupt 268,
> > so drop it.  
> 
> Don't just remove it from the example, drop it from the binding too?
> It does permit a 4th "self testing" interrupt.

I'm missing something. See below...
> 
> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > index dacc526dc695..dfc3f512918f 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > @@ -31,7 +31,6 @@ properties:
> >        - description: normal conversion, include EOC (End of Conversion),
> >            ECH (End of Chain), JEOC (End of Injected Conversion) and
> >            JECH (End of injected Chain).
> > -      - description: Self-testing Interrupts.

Eyes skipped over this maybe?  The 4th interrupt is removed from binding here...

> >  
> >    clocks:
> >      maxItems: 1
> > @@ -70,8 +69,7 @@ examples:
> >              reg = <0x44530000 0x10000>;
> >              interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
> >                           <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
> > -                         <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
> > +                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
> >              clocks = <&clk IMX93_CLK_ADC1_GATE>;
> >              clock-names = "ipg";
> >              vref-supply = <&reg_vref_1v8>;
> > -- 
> > 2.37.1
> >   


