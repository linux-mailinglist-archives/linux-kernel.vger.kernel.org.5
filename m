Return-Path: <linux-kernel+bounces-10979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EECA81DF96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DEA2819E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E5154BA;
	Mon, 25 Dec 2023 09:54:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6401798A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjterm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjterm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07944658|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0484377-0.000797998-0.950764;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=fuyao@sjterm.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.VsRwBJW_1703498043;
Received: from localhost(mailfrom:fuyao@sjterm.com fp:SMTPD_---.VsRwBJW_1703498043)
          by smtp.aliyun-inc.com;
          Mon, 25 Dec 2023 17:54:03 +0800
Date: Mon, 25 Dec 2023 17:54:03 +0800
From: fuyao <fuyao@sjterm.com>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	Lee Jones <lee@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>,
	fuyao <fuyao1697@cyg.com>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH RESEND] iio: adc: sun4i-gpadc-iio: adaptation interrupt
 number
Message-ID: <ZYlROwtUv1iZr5Kj@debian.cyg>
Mail-Followup-To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
	Lee Jones <lee@kernel.org>, Andre Przywara <andre.przywara@arm.com>,
	fuyao <fuyao1697@cyg.com>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	maijianzhang <maijianzhang@allwinnertech.com>
References: <YxmR5SPPY18O7LaG@google.com>
 <20231220115412.65bbc8c7@donnerap.manchester.arm.com>
 <20231221152553.GM10102@google.com>
 <4953611.0VBMTVartN@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4953611.0VBMTVartN@jernej-laptop>
Organization: work_work_work

On Fri, Dec 22, 2023 at 06:54:53PM +0100, Jernej Škrabec wrote:
> Dne četrtek, 21. december 2023 ob 16:25:53 CET je Lee Jones napisal(a):
> > On Wed, 20 Dec 2023, Andre Przywara wrote:
> > 
> > > On Wed, 20 Dec 2023 15:23:17 +0800
> > > fuyao <fuyao1697@cyg.com> wrote:
> > > 
> > > Hi,
> > > 
> > > > __platform_get_irq_byname determinies whether the interrupt
> > > > number is 0 and returns EINVAL.
> > > 
> > > can you please say what this fixes, exactly? Is something not working at
> > > the moment? Can you please provide parts of the error message?
> > > 
> > > And maybe expand the explanation a bit more? For instance mention that the
> > > identifiers are used as IRQ resource numbers, where 0 is treated specially.
> > > 
> > > Cheers,
> > > Andre
> > > 
> > > > 
> > > > Signed-off-by: fuyao <fuyao1697@cyg.com>
> > 
> > You have to use your full real name as well.

> 
> Isn't that enough after
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330 ?

Thanks

> 
> Best regards,
> Jernej
> 
> > 
> > > > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > ---
> > > >  include/linux/mfd/sun4i-gpadc.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> > > > index ea0ccf33a459..021f820f9d52 100644
> > > > --- a/include/linux/mfd/sun4i-gpadc.h
> > > > +++ b/include/linux/mfd/sun4i-gpadc.h
> > > > @@ -81,8 +81,8 @@
> > > >  #define SUN4I_GPADC_TEMP_DATA				0x20
> > > >  #define SUN4I_GPADC_DATA				0x24
> > > >  
> > > > -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> > > > -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> > > > +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> > > > +#define SUN4I_GPADC_IRQ_TEMP_DATA			2
> > > >  
> > > >  /* 10s delay before suspending the IP */
> > > >  #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
> > > 
> > 
> > 
> 
> 
> 
> 

-- 
CYG Technology.

