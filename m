Return-Path: <linux-kernel+bounces-92489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E987211B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B951C2183C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E51686AC2;
	Tue,  5 Mar 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mKJ/As3N"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C90E8663E;
	Tue,  5 Mar 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647644; cv=none; b=NacoEkipkNaQorFsWzTC0kk+bPwgKofL5PMzHxk017DLNoIo3OtIOD1e6NXg7RcN8UbgT2BNruD/MW5RTRdoA58HjBhvaQZhMIDLPJScb0WwMECGmSl1ryqL4CYgaDNUt0fXsxI4hQFiJq1zdZY5HGedJqNz15po1zJl1Iajazo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647644; c=relaxed/simple;
	bh=OCWByTDlSAOYwh/VIzepEs26ct4znatcq/z2wwX8uS8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcm2GEe1AnLUxKfUk+L+0uSbJDRzSF2M9tmz5249FUnREJKsj3dTWLkXR66pBVzLUMLITDvEOZPWGYAoD3DiOK9sT78idQLHxekXVFfzrkDskopG5oYXCLAXeH1+Hz8sAziwdqaRRuyeUqVOmQLZ8w/Kw7R+xjrWKuIrog01MMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mKJ/As3N; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 974621BF20A;
	Tue,  5 Mar 2024 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709647639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlSdtS9gPl3MStQDE6pU+wB4e620UH09fdWfMjz3JdY=;
	b=mKJ/As3NrkbIh4PqASWy22hOM4m+EZHgPI+zhZQrt886iDFGwkdhs8cK5LSEZHlRUbVD7J
	c7gx2HJ7SrSF1AXWtqe70ZWhjiOFzpE6or4k+k7JaHKoojt9TQzfREwGwIu3Zmm9Tk9p4X
	84q8AGfD9BW+fuoqymLP5MswVra4Wa44dcIWDJASp6/tMbEfUurr0NqwX5/Kacul2npFcU
	gfJndI9ZTkBq924ykcXEhGAoaI1U3t5rdSpaN0U8+aKBa9m1aGxeTuf/pxA4DwRAS+m+sJ
	1bkxO0ZxdojAXtO+RHCjuqZIMygma3rFAfi2SyNMjO2uuy5+jEpbdcXkTl4PZg==
Date: Tue, 5 Mar 2024 15:07:16 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner
 <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/7] ASoC: codecs: Add RK3308 internal audio codec
 driver
Message-ID: <20240305150716.0fca0e33@booty>
In-Reply-To: <09c275d0f0a1bf85f37635d9570514e8fc631e72.camel@pengutronix.de>
References: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
	<20240221-rk3308-audio-codec-v3-4-dfa34abfcef6@bootlin.com>
	<09c275d0f0a1bf85f37635d9570514e8fc631e72.camel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Philipp,

On Wed, 21 Feb 2024 14:21:23 +0100
Philipp Zabel <p.zabel@pengutronix.de> wrote:

> On Mi, 2024-02-21 at 11:22 +0100, Luca Ceresoli wrote:
> > Add driver for the internal audio codec of the Rockchip RK3308 SoC.
> > 
> > Initially based on the vendor kernel driver [0], with lots of cleanups,
> > fixes, improvements, conversion to DAPM and removal of some features.
> > 
> > [0] https://github.com/rockchip-linux/kernel/blob/develop-4.19/sound/soc/codecs/rk3308_codec.c
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >  
> [...]
> > diff --git a/sound/soc/codecs/rk3308_codec.c b/sound/soc/codecs/rk3308_codec.c
> > new file mode 100644
> > index 000000000000..61bfb75f92a3
> > --- /dev/null
> > +++ b/sound/soc/codecs/rk3308_codec.c
> > @@ -0,0 +1,993 @@  
> [...]
> > +static int rk3308_codec_platform_probe(struct platform_device *pdev)
> > +{  
> [...]
> > +	rk3308->reset = devm_reset_control_get(&pdev->dev, "codec");
> > +	if (IS_ERR(rk3308->reset)) {
> > +		err = PTR_ERR(rk3308->reset);
> > +		if (err != -ENOENT)
> > +			return err;
> > +
> > +		dev_dbg(&pdev->dev, "No reset control found\n");
> > +		rk3308->reset = NULL;
> > +	}  
> 
> Please use devm_reset_control_get_optional_exclusive(). That already
> returns NULL instead of -ENOENT if the reset control is not specified
> in the device tree. Then dev_err_probe() can be used to report errors.

Good point, thanks. Queued for v4.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

