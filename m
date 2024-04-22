Return-Path: <linux-kernel+bounces-153345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F48ACCE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF53F1C20F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829A14F107;
	Mon, 22 Apr 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJzqxMnA"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E6B14EC5F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713789586; cv=none; b=tvqd+8F1RqpDoVZ/5hbIcpTDEeG0Iic0HX6Hd/WIF21sXfG7l3ZFkAm3mbW9w4UlRZOEfwQT783+WJ3mkfLHTsaEaOQNVZVAHIb1UHM4BJCwZPJ3i2pIejhOjiArDC5YKH+1cOGN6wCbZgpBi8HM78MTo9KujwQCHTwgdpKmDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713789586; c=relaxed/simple;
	bh=iyTsIMR6AeJPVBmq77RzZGnEgc860sS11RT6shdDDRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYGxJagttyEx7+c1AcVeZ4GEXUzS3TIgQj39FUGq49WYjy/Vzgb3otGEAcWxJgspdXB8GUq2a6EudKtYPhD35IKSEqPoRuwSvB8r0BaoO35nv3PaZqPI1o88oiDWwm7SuJrKBWwZ5TyiRG7hEcca5TEmpz1YiZmnOkds53uxuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GJzqxMnA; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c74b643aebso1733000b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713789580; x=1714394380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S4ySNq3QesUCzbAIR2RY0fipn3yuib781ddLRiaF6bc=;
        b=GJzqxMnAZlXFvpw/W7OFie1lW1lGs+B0rbRo4x7hIvcbGkrjUln9INDuLK9g+IphIX
         aDaGsgDTGZz8E3msvjjzd9yYcp099GvrB/UGkBdmNOtH7gKA2ZPil83GTGt565zZZM2g
         gOdHABj3iBLS2Zi1E4ke2ksQnniHGN7OpVehFs4ENiDNGsCQyhJG98hpaWt7zLe1cT/R
         8E/TB78cAXPp5kS/2DjzOxhcJSfXIvwTLvDJ4wHaonghCQYUDNlQdR3pS2jANq2moE4z
         0NM04olMYW4649SS9KYm7iKnSAyZCXe3IwIH9ma6AwZadKy30icRDpGmaarKoPIy5DIr
         JilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713789580; x=1714394380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4ySNq3QesUCzbAIR2RY0fipn3yuib781ddLRiaF6bc=;
        b=dGtscdIvyCVWi7Au1H41DUjGuZwEM6nH5eQndzDgs8EQd27wTy4J6WdUzpkf+E4g9D
         r8EzFvGEHaYejaDEo+SaILNzhmGgkLrIusKd9yZEAbBjy3LdRlQxtpPZ4m3r68qn2dkQ
         C2b/X4d6QEAIi48Q/yh4ieXD5y/iFedjS1z0sRGIhHslQcA8DePPaPnjZk+qUjWbHJUN
         YBb8aUYnBG1/og2p8UiCQK87zUES380PtmkFzkpIuf5IeEW2zm3TKJOdRKe3IivxeG7z
         LeHpORM9WU24FwUY5SfQyogSJP5lLqLkJHLpz58Ia0zW4yazAh4GqhUfnl7Zq0Eq/xK6
         zk0A==
X-Forwarded-Encrypted: i=1; AJvYcCXjtCOeXD4+P0MEd+N0Z9BZ2yVz1/wl6knrRXpA9Rlm+VPqzW/8fqmfiDsIOR2ZapYXyTwzbGXHduaPvGhBvXMle8mfmfvs3hV78XHJ
X-Gm-Message-State: AOJu0YxGGQZFiZQuqebco4bmLTHCXNPDUNAsaBBGm2fv3UMBWikVLT2S
	umMOnp4vNKnpjc+rdvJ0hdGr6VCO+UuKOTtEn7yNZejYK6eEUvznxJLM685oeSu/OPZCQMArPnV
	BDyCSkF3DWjZqdKj9bIcX+2mUWhVYc5dTBbW6vw==
X-Google-Smtp-Source: AGHT+IFRVyCeWFThbOBOiFgmqUhy26Z9HP2Lw9XMRIZylBypB7g6tOUorMkXN+WcL7sQuHVha6TScv+q+Y0CqpP+4uw=
X-Received: by 2002:a05:6870:c1cf:b0:21f:d2a2:7ff4 with SMTP id
 i15-20020a056870c1cf00b0021fd2a27ff4mr14344315oad.17.1713789580152; Mon, 22
 Apr 2024 05:39:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122559.898930-1-peter.griffin@linaro.org>
 <20240404122559.898930-11-peter.griffin@linaro.org> <75b1b063-e8d4-417d-99a8-4320d72297cf@moroto.mountain>
In-Reply-To: <75b1b063-e8d4-417d-99a8-4320d72297cf@moroto.mountain>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 22 Apr 2024 13:39:28 +0100
Message-ID: <CADrjBPputDQWpQZgPiuUDLTWZA83KJEMp-X8ZtXAwt6ivTOG9g@mail.gmail.com>
Subject: Re: [PATCH 10/17] phy: samsung-ufs: ufs: Add SoC callbacks for
 calibration and clk data recovery
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, chanho61.park@samsung.com, ebiggers@kernel.org, 
	linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

Thanks for the review.

On Wed, 17 Apr 2024 at 10:52, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Thu, Apr 04, 2024 at 01:25:52PM +0100, Peter Griffin wrote:
> > diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
> > index c567efafc30f..f57a2f2a415d 100644
> > --- a/drivers/phy/samsung/phy-samsung-ufs.c
> > +++ b/drivers/phy/samsung/phy-samsung-ufs.c
> > @@ -46,7 +46,7 @@ static void samsung_ufs_phy_config(struct samsung_ufs_phy *phy,
> >       }
> >  }
> >
> > -static int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy)
> > +int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy, u8 lane)
> >  {
> >       struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
> >       const unsigned int timeout_us = 100000;
> > @@ -98,8 +98,15 @@ static int samsung_ufs_phy_calibrate(struct phy *phy)
> >               }
> >       }
> >
> > -     if (ufs_phy->ufs_phy_state == CFG_POST_PWR_HS)
> > -             err = samsung_ufs_phy_wait_for_lock_acq(phy);
> > +     for_each_phy_lane(ufs_phy, i) {
> > +             if (ufs_phy->ufs_phy_state == CFG_PRE_INIT &&
> > +                 ufs_phy->drvdata->wait_for_cal)
> > +                     err = ufs_phy->drvdata->wait_for_cal(phy, i);
> > +
> > +             if (ufs_phy->ufs_phy_state == CFG_POST_PWR_HS &&
> > +                 ufs_phy->drvdata->wait_for_cdr)
> > +                     err = ufs_phy->drvdata->wait_for_cdr(phy, i);
>
> The "err" value is only preserved from the last iteration in this loop.

I'll send a follow up patch for this as it's already applied.

Thanks,

Peter

