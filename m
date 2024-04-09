Return-Path: <linux-kernel+bounces-137243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC1E89DF64
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1BA1C22DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02F113D89C;
	Tue,  9 Apr 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ifzo3XZ0"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C913D626
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676957; cv=none; b=se8435RqteqvIAeECeeYrIQV19H+az4bxppmrP4Ur380jX1Eq3C7o2D6N8oNsURQD/CDe5BoiSnS5pli3KVBXeJWKG30w+yYZajQaICqPdDFImRqr/t8SmtkD3/uenP/IvORbHwnoynsybEP/cKNtl7M+brNXoPYqmniQowBUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676957; c=relaxed/simple;
	bh=P04LBfkaeW2XuO46xw0RoQrDoyCOfrzCkGumelNfjDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLDItj8j90DL+JSizeHuewlix49n8oblnCIZ8aVtuP5InVgdil+NQsA6tskNiUAy7UXYbY/MN7sAQXIVE7NXce/9dX5PR2Qj+EtDy6ZqBwIaKPC3rHjAj4S0j1gJem5Ii6W7FBYUd+RnnLOoX53BRSe0hBnmZH22uwIcMW5USL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ifzo3XZ0; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d886f17740so26628941fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676953; x=1713281753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRsd3hpzzr4WHD3K4LXpLnFX04nl95mWHv7i9FXsiIo=;
        b=Ifzo3XZ0knqheuQUy5YJ25SbTbC+2x+t6hBB9lkdL0R/ZGHelTE41TUNcl/2VBLLJv
         ZqFqWGbhrUW8g/QchdBkBBeSZJ+/OirjmC+EyL1RR5IwfPq+L2bVDHXgaLIqBvhAJmZ/
         SL4fKCGd7XVJBo3oNR3W6MjIXdzCjzeJeziR+Y9+hYdtfSHtVw2iT9CRLr5lYUTPd6Rk
         I8+l0aUfqC6hMxogPlb9itjA7REQBUY+fH121jd/r/GRWYV86JQzhUGij5LX387nytbb
         NgyI5PyUrXDbwDx5mD0ix9MK+KIpYOsgdZYR7I6uRUyeW7h6DCBLeyF2ykzpZPXjNqUT
         1cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676953; x=1713281753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRsd3hpzzr4WHD3K4LXpLnFX04nl95mWHv7i9FXsiIo=;
        b=eVxg4tmDvTA4ayXARmEhs2Xv2g6SpYcnk1gysZZ8qwvofUeepsVoeRIfQZZ4ZBcYU3
         Cxknv7v/OlC1fOOhaBU30IjIqShPFynBwNRUtGskXfhU/V7EXM8eIDcp1tOpLorzSNuq
         pAHiUUo/ZTo4ULGbTEy1smcK6OF+8M/SDAXAE7n/MSkCQE3uowDECV4uI4YFNQI9WmZE
         wBVMKUuOTPtMMmxBwtDVoC2NCRhLUnljoTLoz8myMCTJQcZQ/aTLetfzKa+0jutLuOA1
         BOSwd0QkY5FgX9LZl8RDi2lHYY70z16s5ZhSYiws8erqM1zY9wjSN4pP2gjh4JprkWvW
         n1tg==
X-Forwarded-Encrypted: i=1; AJvYcCXRThJ2TC9a8T+CmlJMJ1lTpLHyhnPDJL/+4JoWd4NHIAf/yhvljeA/oUJfCnakEUmACRWAu4IwO8lNoP5bZslQpLjZNOmfVRxfMZtM
X-Gm-Message-State: AOJu0YxaGVCsvB9F92Q1L+EUnv9+f9n4rhXQOznqxSiaYi8W7kXmJ442
	4Z34vag1uQB6n5wyFFo8FFwT1VFRxEs00PJFCwZXkz1KDQPPC92HrII2hgZrU0XZvuaugtgbBnr
	b
X-Google-Smtp-Source: AGHT+IHJYOHXxN+KPaWlA8Ai6GNsv61R44Zkfg2lEX23bMYFoBeClEaCKCd8pkT/YOsSHwvrrH2xYQ==
X-Received: by 2002:a2e:9259:0:b0:2d8:a1b3:d4ba with SMTP id v25-20020a2e9259000000b002d8a1b3d4bamr4385ljg.11.1712676952665;
        Tue, 09 Apr 2024 08:35:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id m15-20020a2e910f000000b002d808b86073sm1571238ljg.78.2024.04.09.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:35:52 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:35:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de, 
	martijn@brixit.nl, samuel@sholland.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCHv3 2/2] usb: typec: anx7688: Add driver for ANX7688 USB-C
 HDMI bridge
Message-ID: <4q7o5vb26ibkbvqal5nn4kdnc32rrajhtszrf4fnuisnlfcsg5@6322saeu7qoe>
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
 <ZhPM4XU8ttsFftBd@duo.ucw.cz>
 <ZhUQ6kzV5ARlkfPC@kuha.fi.intel.com>
 <ZhUgrNwRYoaV1AIJ@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhUgrNwRYoaV1AIJ@duo.ucw.cz>

On Tue, Apr 09, 2024 at 01:04:12PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > This is driver for ANX7688 USB-C HDMI, with flashing and debugging
> > > features removed. ANX7688 is rather criticial piece on PinePhone,
> > > there's no display and no battery charging without it.
> > > 
> > > There's likely more work to be done here, but having basic support
> > > in mainline is needed to be able to work on the other stuff
> > > (networking, cameras, power management).
> > > 
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > Co-developed-by: Martijn Braam <martijn@brixit.nl>
> > > Co-developed-by: Samuel Holland <samuel@sholland.org>
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > 
> > Just couple of quick comments below - I did not have time to go over
> > this very thoroughly, but I think you need to make a new version in
> > any case because of comments in 1/2.
> 

[skipped]

> 
> > > +static int anx7688_connect(struct anx7688 *anx7688)
> > > +{
> > > +	struct typec_partner_desc desc = {};
> > > +	int ret, i;
> > > +	u8 fw[2];
> > > +	const u8 dp_snk_identity[16] = {
> > > +		0x00, 0x00, 0x00, 0xec,	/* id header */
> > > +		0x00, 0x00, 0x00, 0x00,	/* cert stat */
> > > +		0x00, 0x00, 0x00, 0x00,	/* product type */
> > > +		0x39, 0x00, 0x00, 0x51	/* alt mode adapter */
> > > +	};
> > > +	const u8 svid[4] = {
> > > +		0x00, 0x00, 0x01, 0xff,
> > > +	};
> > 
> > Why not get those from DT?
> 
> Are you sure it belongs to the DT (and that DT people will agree)?

From Documentation/devicetree/bindings/connector/usb-connector.yaml:

            altmodes {
                displayport {
                    svid = /bits/ 16 <0xff01>;
                    vdo = <0x00001c46>;
                };
            };

BTW, I don't see the VDO for the DP altmode in your code. Maybe I missed
it at a quick glance.

> 
> > > +	u32 caps[8];
> > > +


-- 
With best wishes
Dmitry

