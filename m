Return-Path: <linux-kernel+bounces-112482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A5887A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37159B21977
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4729241232;
	Sat, 23 Mar 2024 20:44:48 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC843201
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711226687; cv=none; b=JVoZmLNUvyRH5F9C71z4Wf5dGgwKbS200brGK5kZ5CPQvF4moKrpFzs92JuBP+iye4Gg8sofiKhNkG8joz9k4O2bhn62lgAuZuiDDjX0/7jg5+iavMcXHqVWuEnD7sdUOmrL+TQHdk8kzVW1fJZZu9bPKCV3iSFNdn80PwU6LxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711226687; c=relaxed/simple;
	bh=4cn7e1ZNgP9JRFS2MR28C3me8UKkrRDxTuHIiMG8WD0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8ubAwY3AY5XBcorM6YEEIHFtc1Opyq9hVpePNWoB4lPL3BAwkXkU//JTwbjdD/CAjIKovYfMkY6KQU3w1omhPlfhtziSZlh+/iUNEiTBKUNejoP6bNUgRCLY3bAeeVvF9ho/KIny3JuJ1YnvXWAs7It9dL6EANDlEWoX0FhIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 29c2437a-e956-11ee-abf4-005056bdd08f;
	Sat, 23 Mar 2024 22:44:37 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Mar 2024 22:44:37 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: simplify adi,spi-mode property
 parsing
Message-ID: <Zf8_NZ5cNb9TVThx@surfacebook.localdomain>
References: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
 <CAHp75VeO_=r_pMBUTaQQYKDRAV-OVfTnPYPwV8f7KDzOhaBCvQ@mail.gmail.com>
 <CAMknhBETEP123=EHycGtFEJjQ+NPssLXmw9ZdDoY8CRsWiSxVQ@mail.gmail.com>
 <20240323182918.2cf624b6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240323182918.2cf624b6@jic23-huawei>

Sat, Mar 23, 2024 at 06:29:18PM +0000, Jonathan Cameron kirjoitti:
> On Tue, 19 Mar 2024 10:28:31 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> > On Tue, Mar 19, 2024 at 10:01 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Mar 19, 2024 at 4:28 PM David Lechner <dlechner@baylibre.com> wrote:  

..

> > > > +       ret = device_property_match_property_string(dev, "adi,spi-mode",
> > > > +                                                   ad7944_spi_modes,
> > > > +                                                   ARRAY_SIZE(ad7944_spi_modes));
> > > > +       if (ret < 0) {
> > > > +               if (ret != -EINVAL)
> > > > +                       return dev_err_probe(dev, ret,
> > > > +                                            "getting adi,spi-mode property failed\n");  
> > >  
> > > > -               adc->spi_mode = ret;
> > > > -       } else {  
> > >
> > > Actually we may even leave these unchanged
> > >  
> > > >                 /* absence of adi,spi-mode property means default mode */
> > > >                 adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> > > > +       } else {
> > > > +               adc->spi_mode = ret;
> > > >         }  
> > >
> > >        ret = device_property_match_property_string(dev, "adi,spi-mode",
> > >                                                    ad7944_spi_modes,
> > >
> > > ARRAY_SIZE(ad7944_spi_modes));
> > >        if (ret >= 0) {
> > >                adc->spi_mode = ret;
> > >        } else if (ret != -EINVAL) {
> > >                        return dev_err_probe(dev, ret,
> > >                                             "getting adi,spi-mode
> > > property failed\n");
> > >        } else {
> > >                /* absence of adi,spi-mode property means default mode */
> > >                adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> > >        }
> > >
> > > But I can admit this is not an often used approach.
> > >  
> > 
> > I think Jonathan prefers to have the error path first, so I would like
> > to wait and see if he has an opinion here.
> I do prefer error paths first.  Thanks.

Still the above can be refactored to have one line less

	ret = device_property_match_property_string(dev, "adi,spi-mode",
                                                    ad7944_spi_modes,
						    ARRAY_SIZE(ad7944_spi_modes));
	if (ret == -EINVAL) {
		/* absence of adi,spi-mode property means default mode */
		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
	} else if (ret < 0) {
		return dev_err_probe(dev, ret, "getting adi,spi-mode property failed\n");
	} else {
		adc->spi_mode = ret;
        }

-- 
With Best Regards,
Andy Shevchenko



