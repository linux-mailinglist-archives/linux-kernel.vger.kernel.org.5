Return-Path: <linux-kernel+bounces-48784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135C84614B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32250293379
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B585293;
	Thu,  1 Feb 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4nJJQ5f"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927F84FC7;
	Thu,  1 Feb 2024 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706816762; cv=none; b=IWVnwro5EMYvb6pHAf0hFWH30gEEZ++VUZIh/ARrFSDAbsZIUPCyK3AWPNzjXbcjqC3NI8oTH4lRYWD3SgA3yKpNasDcpkpBCtGQ7VTNnw0h3vLVS1M1WtPx8bpl3duAqIaYDHr2Zw4NgzOdziy0Wg60pOP+Rn6JPSSjNmn08ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706816762; c=relaxed/simple;
	bh=eIrKHZ8wcHMGmXE4h/S/mZzcEHXyVOhkK7dWpYxqZws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/TrkYY2IuX22KVRz8DgwpAS02HxBCYQV1j9yVqD/A4CrbuMqTH0X9PHN3MZ1enc1gUFNbJByACBlNxPvBM3XqymF3NclqFIJclZ+Umv23yQAqzUoQOxyRESXnebMXvrDJlumOy9YQYtBeRYhYj1gUS3ALa+3PjgsClZJeYrcwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4nJJQ5f; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51109060d6aso1955193e87.2;
        Thu, 01 Feb 2024 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706816757; x=1707421557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Go0sAqla2a5Ya4OBAwwEZLy2UuNkDvjwTq09pNv5ZA=;
        b=Z4nJJQ5fn1zlCWqrDjLDTlx7wpWQB3ghRsR4MB7Y/0EFCYHcgyKDnFoOT9o5+NzCLZ
         w+AApm8jIV1bxaknLsile2LVQDx10yF4nr176WTg+QlDIvAwO4bbJuiX5yV9g+gaaNcA
         29zFikSNDH89FbczBjVlvsJ0eOc/bHZ6J3cbMPDlLONdnnUdgLWZ5FRvVWF5A20VTnZ3
         YSA8P7/6YrYeKyj27nQgpZS/r33FVFGV0uGQVBBxa9BKWVKag3VrX4pZ6F4d6oShiGda
         Tdj5mjdQdQbDXAO4PLlk8Hj1EIhFPhEUCalk1uzxHeLhw74gBDkqQukA+ONTE0rQz7Tc
         Sc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706816757; x=1707421557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Go0sAqla2a5Ya4OBAwwEZLy2UuNkDvjwTq09pNv5ZA=;
        b=nC9ccLO7bHuth0f/AOIb/PC00QwHk2Zy2E3fm5DGd81Nwkk/lPhdVkmwXmLAr5LSJR
         cszhw/uhX2K8aDH16UnolQmqz/p7dyZ7xmoDYGHneezGDXxLvBnRNeIYLLQFkJo9/50H
         qKsy2pGBGlyA4ZNk8ZeWBounJ0v7DE7BOXERr5ZwGUWTNU+g6iwL10jyaYjlt8I9+tbM
         SIcNFMxOfqwqBoA8AcBwR9rEJY7hn5aScaZ3yhOQHvKw6ruxkOacqJvfRyRc18oRXL9D
         RDFPU+mu74WJwGLSNLEqWqKTipkMc69hg9XfMiQGSlNaOIEP22N6kz9r5RoBeoKTC/q2
         IuQQ==
X-Gm-Message-State: AOJu0YyyJBoa71+y90//+zLm5Oo8psdHPvTAo7JHGsqAeKkiS1p85CE/
	JxqWv2yYPtlULwyioAW2y161IEoG9gYZWbjIx68wXMUaTl0WUUw+
X-Google-Smtp-Source: AGHT+IGP7PhqkeeAE9/EIVIgwVwKXKZ/fh6YyFBEOJy+CDewmEHopQT2m7o2QqaEtuz6oXOM0H780Q==
X-Received: by 2002:a05:6512:2eb:b0:50e:8eff:3980 with SMTP id m11-20020a05651202eb00b0050e8eff3980mr2539919lfq.30.1706816756827;
        Thu, 01 Feb 2024 11:45:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUg5iYvwrRH+6thFcmdCETvJsvZzVhvtb+IKHt49BslMaFmAGWxQNUsHBNxAOitBxv0JY7t9do7aFcJGoBrRPbmHlk4u5UVVcVnuDMuOIYEYIIlpx+jYncuXW6926geF82ZhpOP8fFl96qiXFquaLdDWq+Os2imy3z3GW4XCmt2Z1YB5tBJe8d3Y5QAGqRB3cQVPrfTvqyEYEzhp18d344Qk99OI0jkgWV0GK1DC+7cqRuU1prSGxczUUHa+IemAbZDrl/emBD2Fckl23ZKmdZ6HNqh0jpzKNR0GMxWs8lK4E91Ih9mc+WU+cijgb2SM30AXIpdcE2W84bQghb7hDQvsQinCAdYHKgNub/1fTV9Qht1G5+vHKdGfJEhkg3SiUn4ukPhV8Y+1TXRlnuz4jwFoHD24hc3BbaWmebRNZVbpQ8pM3imEITEWB2psI79suur8JvT+1mGeeCX+/LEWTVtsuSJvDHcFSR8hp9ZuGdfZesBBY9//ByQWITDaCmBxe/axSTEq9cKkCZy7xwlr5zkBleRCfOo/W4mQDHyEGs3nI0OsgpArLAYkM4Xdxr2E/wsvLCzOMp3HFRtqDoom/KXBJL3fKzF6sD1
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id j27-20020a05600c1c1b00b0040ef622799fsm5373482wms.37.2024.02.01.11.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:45:56 -0800 (PST)
Date: Thu, 1 Feb 2024 20:45:54 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"khilman@baylibre.com" <khilman@baylibre.com>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>,
	"martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 03/20] drviers: crypto: meson: add platform data
Message-ID: <Zbv08i_Yn0wrjkwH@Red>
References: <20240123165831.970023-1-avromanov@salutedevices.com>
 <20240123165831.970023-4-avromanov@salutedevices.com>
 <ZbC8qLXogjxJD8LD@Red>
 <20240201171352.ut5xhw3u2b77v33d@cab-wsm-0029881>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201171352.ut5xhw3u2b77v33d@cab-wsm-0029881>

Le Thu, Feb 01, 2024 at 05:13:56PM +0000, Alexey Romanov a écrit :
> Hello,
> 
> On Wed, Jan 24, 2024 at 08:30:48AM +0100, Corentin Labbe wrote:
> > Le Tue, Jan 23, 2024 at 07:58:14PM +0300, Alexey Romanov a 'ecrit :
> > > To support other Amlogic SoC's we have to
> > > use platform data: descriptors and status registers
> > > offsets are individual for each SoC series.
> > > 
> > > Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> > > ---
> > >  drivers/crypto/amlogic/amlogic-gxl-cipher.c |  2 +-
> > >  drivers/crypto/amlogic/amlogic-gxl-core.c   | 31 +++++++++++++++------
> > >  drivers/crypto/amlogic/amlogic-gxl.h        | 11 ++++++++
> > >  3 files changed, 35 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> > > index b19032f92415..7eff3ae7356f 100644
> > > --- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> > > +++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
> > > @@ -225,7 +225,7 @@ static int meson_cipher(struct skcipher_request *areq)
> > >  
> > >  	reinit_completion(&mc->chanlist[flow].complete);
> > >  	mc->chanlist[flow].status = 0;
> > > -	writel(mc->chanlist[flow].t_phy | 2, mc->base + (flow << 2));
> > > +	writel(mc->chanlist[flow].t_phy | 2, mc->base + ((mc->pdata->descs_reg + flow) << 2));
> > >  	wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
> > >  						  msecs_to_jiffies(500));
> > >  	if (mc->chanlist[flow].status == 0) {
> > > diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
> > > index a58644be76e9..2be381e157c4 100644
> > > --- a/drivers/crypto/amlogic/amlogic-gxl-core.c
> > > +++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/platform_device.h>
> > >  
> > >  #include "amlogic-gxl.h"
> > > @@ -30,9 +31,10 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
> > >  
> > >  	for (flow = 0; flow < mc->flow_cnt; flow++) {
> > >  		if (mc->chanlist[flow].irq == irq) {
> > > -			p = readl(mc->base + ((0x04 + flow) << 2));
> > > +			p = readl(mc->base + ((mc->pdata->status_reg + flow) << 2));
> > >  			if (p) {
> > > -				writel_relaxed(0xF, mc->base + ((0x4 + flow) << 2));
> > > +				writel_relaxed(0xF, mc->base +
> > > +					      ((mc->pdata->status_reg + flow) << 2));
> > >  				mc->chanlist[flow].status = 1;
> > >  				complete(&mc->chanlist[flow].complete);
> > >  				return IRQ_HANDLED;
> > > @@ -245,15 +247,34 @@ static void meson_unregister_algs(struct meson_dev *mc)
> > >  	}
> > >  }
> > >  
> > > +static const struct meson_pdata meson_gxl_pdata = {
> > > +	.descs_reg = 0x0,
> > > +	.status_reg = 0x4,
> > > +};
> > > +
> > > +static const struct of_device_id meson_crypto_of_match_table[] = {
> > > +	{
> > > +		.compatible = "amlogic,gxl-crypto",
> > > +		.data = &meson_gxl_pdata,
> > > +	},
> > > +	{},
> > > +};
> > > +
> > >  static int meson_crypto_probe(struct platform_device *pdev)
> > >  {
> > > +	const struct of_device_id *match;
> > >  	struct meson_dev *mc;
> > >  	int err;
> > >  
> > > +	match = of_match_device(meson_crypto_of_match_table, &pdev->dev);
> > > +	if (!match)
> > > +		return -EINVAL;
> > > +
> > >  	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
> > >  	if (!mc)
> > >  		return -ENOMEM;
> > >  
> > > +	mc->pdata = match->data;
> > >  	mc->dev = &pdev->dev;
> > >  	platform_set_drvdata(pdev, mc);
> > >  
> > > @@ -312,12 +333,6 @@ static void meson_crypto_remove(struct platform_device *pdev)
> > >  	clk_disable_unprepare(mc->busclk);
> > >  }
> > >  
> > > -static const struct of_device_id meson_crypto_of_match_table[] = {
> > > -	{ .compatible = "amlogic,gxl-crypto", },
> > > -	{}
> > > -};
> > > -MODULE_DEVICE_TABLE(of, meson_crypto_of_match_table);
> > 
> > Hello
> > 
> > This patch breaks bisection, since it removes MODULE_DEVICE_TABLE.
> > After applying patchs 1,2,3 the driver does not load anymore on lepotato board.
> 
> Please, give more information. 
> 
> I applied the first 3 patches and the driver probes correctly.
> 

Did you tried to set the driver as module ?
The breakage is when the driver is set as module.

Regards

