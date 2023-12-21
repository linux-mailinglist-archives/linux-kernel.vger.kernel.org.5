Return-Path: <linux-kernel+bounces-8662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451981BABC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562891C25C27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5B55E44;
	Thu, 21 Dec 2023 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFB8QSux"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4CC1D6A9;
	Thu, 21 Dec 2023 15:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5639C433C7;
	Thu, 21 Dec 2023 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703172415;
	bh=m3O9CScU6xqdwkvpQ3pWK3reUb7snyZyNRDnrg4G2nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFB8QSuxYGCoIVrL5jKjAjDJscJuC+Imt+qCV9X8AX2MnFCVfYSaOAMSn+3arG/YJ
	 NpdPmFSH/jrXbIQuyQ28ztxvPn4Sn40mvLREKqyc1aJaTgO09wJbNDXHVRG2NSnkMd
	 xZb7NXCkdugkPK3l15tbcCRSpNKilPJWWq5gqRvqSY1kkdqKwqOUACwluBvdfcl0fd
	 8rZ+EeXwP2hr62g8m9lhbC+932AQ8o3H6xznKTTS/DZ6j2tsmkvt6lI2Qznm4CiwoU
	 QdFblIcPRCq802AKdcutMfucxqiMUqLgq77wpdTwVuSyAJ62QggJOq3UF/ezkpgq97
	 asdZ8fw3t4Lhw==
Date: Thu, 21 Dec 2023 15:26:50 +0000
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: fuyao <fuyao1697@cyg.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH RESEND] iio: adc: sun4i-gpadc-iio: adaptation interrupt
 number
Message-ID: <20231221152650.GN10102@google.com>
References: <YxmR5SPPY18O7LaG@google.com>
 <YwdhTlk+9h+9Mrwm@scg>
 <20231220115412.65bbc8c7@donnerap.manchester.arm.com>
 <20231221152553.GM10102@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221152553.GM10102@google.com>

On Thu, 21 Dec 2023, Lee Jones wrote:

> On Wed, 20 Dec 2023, Andre Przywara wrote:
> 
> > On Wed, 20 Dec 2023 15:23:17 +0800
> > fuyao <fuyao1697@cyg.com> wrote:
> > 
> > Hi,
> > 
> > > __platform_get_irq_byname determinies whether the interrupt
> > > number is 0 and returns EINVAL.
> > 
> > can you please say what this fixes, exactly? Is something not working at
> > the moment? Can you please provide parts of the error message?
> > 
> > And maybe expand the explanation a bit more? For instance mention that the
> > identifiers are used as IRQ resource numbers, where 0 is treated specially.
> > 
> > Cheers,
> > Andre
> > 
> > > 
> > > Signed-off-by: fuyao <fuyao1697@cyg.com>
> 
> You have to use your full real name as well.
> 
> > > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > ---
> > >  include/linux/mfd/sun4i-gpadc.h | 4 ++--

Also the subject line is wrong.

This doesn't have anything to do with IIO.

> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> > > index ea0ccf33a459..021f820f9d52 100644
> > > --- a/include/linux/mfd/sun4i-gpadc.h
> > > +++ b/include/linux/mfd/sun4i-gpadc.h
> > > @@ -81,8 +81,8 @@
> > >  #define SUN4I_GPADC_TEMP_DATA				0x20
> > >  #define SUN4I_GPADC_DATA				0x24
> > >  
> > > -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> > > -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> > > +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> > > +#define SUN4I_GPADC_IRQ_TEMP_DATA			2
> > >  
> > >  /* 10s delay before suspending the IP */
> > >  #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
> > 
> 
> -- 
> Lee Jones [李琼斯]

-- 
Lee Jones [李琼斯]

