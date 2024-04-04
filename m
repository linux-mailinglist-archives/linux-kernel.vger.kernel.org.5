Return-Path: <linux-kernel+bounces-131273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84129898592
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFBFB265E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BDB80C15;
	Thu,  4 Apr 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8EU9aDi"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DEC7FBD1;
	Thu,  4 Apr 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228359; cv=none; b=ieg6hkNxZWpe9cFe1Vod9W1pSupIcbNxORP/TPFpBSwsQxk1CiZdnMAYTX1NsO/EseQp1mFQ1dZ2rRaGTDnz6khfn9oRj4VwQqJS+w27o+xU2AT82/5Wu1XYudjSxUI5NaT49zRjLCXv+2Kuk9RToCSSDoFK95QHCuxIFhGIrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228359; c=relaxed/simple;
	bh=C/95RBc7hJ318ahH11gn81a5f+QxJ7u/QFH9rXe+Q5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgYgzk9A7w6TfWX6epsl+mSxNaJZPlfGbGe1SEUBnYUek4WWCmFT/IZisvT0zXDbVSoTGa+MCJci+fzX+8G+t2kb3halEoloSlAkw612vl368OppgDgV/ijleUBMOfE2vg+2u38DeXkyvFDP+xPHqL5Vo2f92P4a+joJIMi2Cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8EU9aDi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so1328744b3a.1;
        Thu, 04 Apr 2024 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712228358; x=1712833158; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Ghu5jAvxJOZKEhQM6ZvukRe4OySknJN8UXfj0OErgk=;
        b=T8EU9aDiON4jC/ip+dX+lE4bZek/LUn/8qu7UqjreZ8t7MM5ADietLqA5YERw4SXdT
         0LozjKvvz9U5chY4LDs10IdTz20JO7BhdTeLknYb0W/6C62PZw6zlJGGSGWJZ6TnodYt
         k86DpLBjglUkpl0JpLwsHgNca2Ml/gmq5PBlhyzrW9oa2TFh351SSu+UlJ2xESqKHTJ1
         EB9uP/8bgZDGeu/yULQrJIKdGgVaf1atx2GL5Oj74MI5c+LZ70yvs6onFkKQOElViEgb
         LFfZPdOH1lTzu3NG41Ig+Yme0MuGNd4K9P9Iam8u8FD+dYjnwHb09TQNVBZMqVKZWPOb
         YARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228358; x=1712833158;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ghu5jAvxJOZKEhQM6ZvukRe4OySknJN8UXfj0OErgk=;
        b=ebvZ/DCllIX7+2NagED0C0FIbx/x5f9p15B/XTVirwPVAx4NeJOKHNtAzNxuOcYX4G
         dXVa7+j/DO7BaapZ0/STe/PV3YBN0BbxIak4GtQulrx2lp+eL45gSodPOY3OTUhR2k5O
         lORjEkqEYe03ulF3CQdRWm7zv0Q3dzRj+6Isoog2TxNQn8GN2ML7D0U3e+4jrUWFIki/
         p051t/T80VLPkF2YPs9Z8wOIHscKbDiCElArm7T2U3iIjhFr7oktbNDFGUyUD+7goJls
         e4FzTznvKEx3dDHfLFIo/y9v2iNqHq1jiWQvnjrP9/alx+U4rnMJJgrjrv5RyUhWI9lk
         /kdw==
X-Forwarded-Encrypted: i=1; AJvYcCWwb6N5reCjF60iQkLDVv/8AcVFv/MNLKQCTxMC0+jPtqbHhd0KqWQrVsJBL9LExKNQQoWSAZ2JhMzYnKSsFpSwEjLIXZaRTDNehYWbeVUtFMRrCzD4VphZK3vAzS3Jc0K0fA==
X-Gm-Message-State: AOJu0YyaJd/1dn2Gp4e+xfiFnhSmybGpOMVEhlv4unU4woz5mxqkWwxq
	927r2cmdxzx71ArACRDt2Ud+mD5J+o+yquTh3Lui7Pz/N8rXwaxs
X-Google-Smtp-Source: AGHT+IHhPjZqxSM8T8GrwEDTzPV8yooF7Ihnxgc4OJrqo4y5CVKVUXIyq3C1ohgDCItd4N4zL57u5Q==
X-Received: by 2002:a05:6a20:7f83:b0:1a3:ae53:fa6b with SMTP id d3-20020a056a207f8300b001a3ae53fa6bmr3288443pzj.6.1712228357504;
        Thu, 04 Apr 2024 03:59:17 -0700 (PDT)
Received: from rigel (194-223-186-215.tpgi.com.au. [194.223.186.215])
        by smtp.gmail.com with ESMTPSA id r5-20020a056a00216500b006e4432027d1sm13767786pff.142.2024.04.04.03.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:59:17 -0700 (PDT)
Date: Thu, 4 Apr 2024 18:59:12 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linus.walleij@linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: cdev: fix missed label sanitizing in
 debounce_setup()
Message-ID: <20240404105912.GA94230@rigel>
References: <20240403131518.61392-1-warthog618@gmail.com>
 <20240403131518.61392-2-warthog618@gmail.com>
 <CAMRc=Mf0DPN1-npNPQA=3ivQd-PMhf_ZAa6eSFjmQ26Y8_Gv=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf0DPN1-npNPQA=3ivQd-PMhf_ZAa6eSFjmQ26Y8_Gv=g@mail.gmail.com>

On Thu, Apr 04, 2024 at 10:20:29AM +0200, Bartosz Golaszewski wrote:
> On Wed, Apr 3, 2024 at 3:15 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > When adding sanitization of the label, the path through
> > edge_detector_setup() that leads to debounce_setup() was overlooked.
> > A request taking this path does not allocate a new label and the
> > request label is freed twice when the request is released, resulting
> > in memory corruption.
> >
> > Add label sanitization to debounce_setup().
> >
> > Cc: stable@vger.kernel.org
> > Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting the interrupt")
> > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 31 +++++++++++++++++++------------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index fa9635610251..f4c2da2041e5 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -728,6 +728,16 @@ static u32 line_event_id(int level)
> >                        GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >  }
> >
> > +static inline char *make_irq_label(const char *orig)
> > +{
> > +       return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> > +}
> > +
> > +static inline void free_irq_label(const char *label)
> > +{
> > +       kfree(label);
> > +}
> > +
> >  #ifdef CONFIG_HTE
> >
> >  static enum hte_return process_hw_ts_thread(void *p)
> > @@ -1015,6 +1025,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
> >  {
> >         unsigned long irqflags;
> >         int ret, level, irq;
> > +       char *label;
> >
> >         /* try hardware */
> >         ret = gpiod_set_debounce(line->desc, debounce_period_us);
> > @@ -1037,11 +1048,17 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
> >                         if (irq < 0)
> >                                 return -ENXIO;
> >
> > +                       label = make_irq_label(line->req->label);
>
> Now that I look at the actual patch, I don't really like it. We
> introduce a bug just to fix it a commit later. Such things have been
> frowned upon in the past.
>
> Let me shuffle the code a bit, I'll try to make it a bit more correct.
>

The debounce_setup() oversight bug is the more severe, so it makes more
sense to me to fix it first.  But then I my preferred solution would be
to pull the original patch and submit a corrected patch that merges all
three, so no bugs, but I assume that isn't an option.

Cheers,
Kent.

