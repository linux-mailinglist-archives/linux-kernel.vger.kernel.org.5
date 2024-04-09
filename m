Return-Path: <linux-kernel+bounces-136290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5779789D248
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D533B1F24325
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37374438;
	Tue,  9 Apr 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVAg4r6F"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665CB762C1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643743; cv=none; b=OH0qDmAeLox1ovC+su7HAgZJJOgi22ibwy8YGFbz+jV2veh6ZOX3BIS6tU5w1fP6/Z9Cj4t4ZGpWA8GKPi/pAXM2tMro2h/sKdUqRSGiesgvay83JDYKUILFdeYe36nVN5rTHNLLBYLSPCdLgRPSAUCXin3kyWuzKdDlp8JkkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643743; c=relaxed/simple;
	bh=y/N4w4ACVX8+rwzurXt0wPOGs6PInCUVXqIgWDsm+HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzrFHS99t61LgOK59ahmL4deMjTTLZHq6rf4GMbgtVRC0guKEFHGIcyojtB91akg2fN0TmNRf1t9pAj7AlVNonBsA4MMkOvtW3zUIekHxj7mq0Xw8BgSZWl5RtCZq7kxxJmmtLL09itz93HcPq6+n0MafnEqab+JRMJqOsp+R4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sVAg4r6F; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51d0dda061so266179966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712643739; x=1713248539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UMDYO2c6oxyg4uLYpkx2s2QjYRlbgcgKpJOA25y7Xcg=;
        b=sVAg4r6FL9E4SZ+4X2QmfJEMURmaH5I/b6xZtgQLypadhicxgXhJptvwowhyXSu9rP
         8gxJ0rLdWMeGpEQFu3vA3sZJwkLVGrukNEGpxmde+odqx7ZYWHoZnPlb6HeHQeFIWXex
         2MSlIMY4ulEqu2gkIsIN2c+OEn8uYmjev+yq3GqpgslcxrE+RynWrfRqmkiZWmbKuT8d
         mnAVByivy8CzoKz2RsF8TnE5kIXieaRLuEHY2Yl45sX5IS8LsHlkBmzDjoBKRQsSpHyT
         j79VcNKbbHm3DtZD0LfZxgcOJf0+EpKw+yxOsRPO6F9G2Ru61HVzmfYUb+w8rGfl/ICQ
         cJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643739; x=1713248539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMDYO2c6oxyg4uLYpkx2s2QjYRlbgcgKpJOA25y7Xcg=;
        b=Vus2SI/8DBKKbT3/6nC0ZOUDI0Fnoy0oFdi56skhC24ZXh1hCqLlu2wAm5+DhTrnyO
         /BoNFbAGkbiMrCELgKc3q7Lwf7LWrulMEc14iUa9S78r0lWYzuhwC0qCo1sLVdbTcJML
         jd14OgiPCQlvsJIad1xRBrvY73mOUUi3DAFo7RMvp1i1tIZC8hKfMbpo62n9KFqeWwNS
         +ruulJRcirGCwuYypIvqfBvrUrG7l5hMPwO7BA/XZWJBisiwBxRgfF3UzXZcQo87bj8G
         cnfBnU6TeFhHx3fI3Ht+LrpnZwGr9jGxngXBuzvL425tSDb5XTbrcRYZXauWacLf0ujn
         o13Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmPgqp4Fw3T+ofKhw1tT8C8HH5GLfcJB8vbTXOg2u1p8pv9SiA7/ll1uIfuQ1swxeppwhQgLb7fJU4MrJlkx3UggBBVvfkxIzL80OL
X-Gm-Message-State: AOJu0YywCR4r224wt3l5wFCBmcwZXcvFr3CHT5ABkOXtZTHuPg30641G
	Dknz9mAV7Toej90rjPM1zBuhNNl6TBG8W2QwZvpsBlZ0zc6S2C4bj/UEY0rL+mE=
X-Google-Smtp-Source: AGHT+IFezcxylFThCkZ5dq6o+jnfozGQsIp94NHvIm6eTu25O92P3DhT+nJlYrPygKuAeOBrFXddww==
X-Received: by 2002:a17:907:7203:b0:a51:d48e:52a0 with SMTP id dr3-20020a170907720300b00a51d48e52a0mr1969227ejc.27.1712643739522;
        Mon, 08 Apr 2024 23:22:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qx25-20020a170907b59900b00a46caa13e67sm5252758ejc.105.2024.04.08.23.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:22:18 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:22:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Improve some
 memory allocation
Message-ID: <483b8e9a-26db-45c8-ada6-e39575760c51@moroto.mountain>
References: <42a87fb9837f1760d1ad4eb7162a7536785dc6f5.1712520052.git.christophe.jaillet@wanadoo.fr>
 <8cb69f245311a348164b0b5ca3dbc59386746035.1712520052.git.christophe.jaillet@wanadoo.fr>
 <d97f2a57-d318-455b-a860-8bd7972c8aaf@moroto.mountain>
 <4ebbe227-38b1-4a1c-af34-9ba7bdfecad5@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ebbe227-38b1-4a1c-af34-9ba7bdfecad5@wanadoo.fr>

On Mon, Apr 08, 2024 at 08:41:26PM +0200, Christophe JAILLET wrote:
> Le 08/04/2024 à 10:09, Dan Carpenter a écrit :
> > On Sun, Apr 07, 2024 at 10:01:49PM +0200, Christophe JAILLET wrote:
> > > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> > > index 3003dc350766..b133f731c5ba 100644
> > > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > > @@ -204,7 +204,7 @@ static const struct debugfs_reg32 lvts_regs[] = {
> > >   static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
> > >   {
> > > -	struct debugfs_regset32 *regset;
> > > +	struct debugfs_regset32 *regsets;
> > >   	struct lvts_ctrl *lvts_ctrl;
> > >   	struct dentry *dentry;
> > >   	char name[64];
> > > @@ -214,8 +214,14 @@ static int lvts_debugfs_init(struct device *dev, struct lvts_domain *lvts_td)
> > >   	if (IS_ERR(lvts_td->dom_dentry))
> > >   		return 0;
> > > +	regsets = devm_kcalloc(dev, lvts_td->num_lvts_ctrl,
> > > +			       sizeof(*regsets), GFP_KERNEL);
> > > +	if (!regsets)
> > > +		return 0;
> > 
> > I understand that this preserved the behavior from the original code,
> > but the original code was wrong.  This should return -ENOMEM.
> 
> Hi Dan,
> I don't agree.
> 
> For me, this memory allocation is of the same type as all debugfs functions
> that we ignore the error code.
> 
> If it fails, it is not a reason good enough to have the probe fail. (anyway,
> if we are short on memory at this point other errors will likely occur)
> 

Huh.  It's an interesting point.  Fair enough.

> > 
> > > +
> > >   	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
> > > +		struct debugfs_regset32 *regset = &regsets[i];
> > >   		lvts_ctrl = &lvts_td->lvts_ctrl[i];
> > 
> > The blank line should come after the declaration.
> 
> The blank line was already there, and in this file, it looks like the
> preferred style (even if not completely consistent)
> 
> Let see if there is some comment about 0 or -ENOMEM in case of memory
> allocation error, and if needed, I'll repost without the blank line.
> 

There is supposed to be a blank line after declarations though so I
think if you re-run checkpatch.pl -f on the file there is a checkpatch
warning now.

regards,
dan carpenter


