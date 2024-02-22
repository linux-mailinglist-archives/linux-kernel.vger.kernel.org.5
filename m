Return-Path: <linux-kernel+bounces-77425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDBA860525
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18C0B21C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6512D21E;
	Thu, 22 Feb 2024 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBWFPxqU"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C711B5B7;
	Thu, 22 Feb 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638652; cv=none; b=U9H69Sk6ydf62ilRd73FGojsx8Kbm9klO/8km1nhAwuVywGxTGlO5UtTybYrWkGF4QvW8jcCzocN1gIJFcuGSBdeCCIAfk6svs/aMlcm2JTbBneIwAgsj8g4uOnkAd7M0F3OXaQq8BqYIrEghFttRFChg+SKkjyh2UYq05TGlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638652; c=relaxed/simple;
	bh=dGBN9a0Yzjh5p3hNPbycVeDbYgbRSgSZY+zTThjTCG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej5Y04ZBLHtyY3Jt4V4cFmKwqI67r2m/ux35SmjIV8WmC//LJC3o88Dvw+in+hVQurcdINojV2zP0o3DligIIEVmAW/xSZ0iJDVSB1H2NHDP7aKWU5hvtpcIZpKIJbMR1kKkpJUXu+pCsKAXN3/wzKSFoPG1f9ZeB0rH7EVJ3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBWFPxqU; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so227457276.1;
        Thu, 22 Feb 2024 13:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708638650; x=1709243450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbRtgjzmc+Ky8Y7MGw/x7vZn3ys1w90kiZLMg7mLUbQ=;
        b=hBWFPxqUC6km/QcxqhPAsxQzdnduPlnxb4cM36IYdj6T5m2xPFk0wgUfyH1KX/yaa2
         l2uo0Crjz3J9EEcDfCh5tlVKOer0HZWRn0IgcoJynV2sYKiw3SGEwLhYxz8RzUwq080L
         SgiOJGV7nlL8hTSRsJk8qfe8f4VvJBM/3UcOzzoAhxSRtqgVCP+YUhiiCd1s0RYMCe6S
         53KE/jU8zEOPBVB7LfT9b/brZNsy5qoR/NuilhAKNOYlOHAUtwUP1i9CFrJtc0Iju8n5
         ziuMTIc81QbSZdN23dhHyaXvX+OTdBgtsXjLiUBl2V/DSoNQwVEGrJ68ycR7jQrSQvOM
         AD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708638650; x=1709243450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbRtgjzmc+Ky8Y7MGw/x7vZn3ys1w90kiZLMg7mLUbQ=;
        b=aytIeUxck2yXGmnVDNRo7vxCGlHpiJ5OPsgkL9NWRD5vu9yZ4b6zjt1U1cBp2YME7D
         waM/B+G5u0LA71Vmsw1QXRvGIaufvmYuRgW7OaajPxqrre+3JpZ4S5DDBh5CQHQpn6Om
         zynFQg5d6kOpGslnjfz8YYWXVtgW60kJqnSkWNckYrp50CdF98h72E4x6eg6/ABxFIE6
         kCOCn6tH6oGizDZepbfuTXYP+wc+rOOFrG+QrgTHzihnRGSdU+2NsOb8hgL2q6LxEHpM
         d8HM9DvLDuLqewqDZAJ/IP03u5W0z/CMHkI0yxez92UKfF+xM0MFtVRGlkoK+A7i06xh
         8oig==
X-Forwarded-Encrypted: i=1; AJvYcCXk8JgSoUDTKIpz65pVptpm0YQtX2HplyQh0AT9Z/zTTBniSwIDXONAHOMZpRCjmnZPX2bR+JoAdbOYzUvXjf5tTwAJ5+N8F0+fn7UMewK0m7AY8Q7fySv3U9Aqj3/s5cTgHtNm
X-Gm-Message-State: AOJu0YwBAlfoTKGX8mLXStbxhKkroUF5694E7mQ71ecW91l+pIaxiL4M
	WuR+hvaC05RpP3kb5j1Jsap5GygS9yVAsPcxB9Mv/DM4gFS8kuBq
X-Google-Smtp-Source: AGHT+IEOh/Eyrxx3el8K1WT+YisZ+iESYEunMTfd0wrXySo4XFeTPixQN4F9T1qBJSrkKfSjcPdP4Q==
X-Received: by 2002:a05:6902:543:b0:dcf:3f11:633a with SMTP id z3-20020a056902054300b00dcf3f11633amr152678ybs.35.1708638649689;
        Thu, 22 Feb 2024 13:50:49 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:6d56:5106:b1c5:46d5])
        by smtp.gmail.com with ESMTPSA id e2-20020a256902000000b00dc6e5ea9152sm3072361ybc.29.2024.02.22.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:50:49 -0800 (PST)
Date: Thu, 22 Feb 2024 13:50:48 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <ZdfBuFZ7tf4b+3n8@yury-ThinkPad>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
 <20240222142219.441767-4-herve.codina@bootlin.com>
 <Zddqr3aN4rU-upai@smile.fi.intel.com>
 <20240222174959.7097c29b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222174959.7097c29b@bootlin.com>

On Thu, Feb 22, 2024 at 05:49:59PM +0100, Herve Codina wrote:
> Hi Andy, Yury,
> 
> On Thu, 22 Feb 2024 17:39:27 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> ...
> > > + * bitmap_scatter() for the bitmap scatter detailed operations).  
> > 
> > > + * Suppose scattered computed using bitmap_scatter(scattered, src, mask, n).
> > > + * The operation bitmap_gather(result, scattered, mask, n) leads to a result
> > > + * equal or equivalent to src.  
> > 
> > This paragraph...
> > 
> > > + * The result can be 'equivalent' because bitmap_scatter() and bitmap_gather()
> > > + * are not bijective.  
> > 
> > 
> > > + * The result and src values are equivalent in that sense that a call to
> > > + * bitmap_scatter(res, src, mask, n) and a call to bitmap_scatter(res, result,
> > > + * mask, n) will lead to the same res value.  
> > 
> > ...seems duplicating this one.
> > 
> > I would drop the latter one.
> 
> I would like to give details about the 'equivalent' in this scatter/gather case.

If you would like - please do! :)
 
> If Yury is ok, I can drop this last paragraph.

The original bitmap_onto() description is 3 times longer, and barely
that descriptive. I'm OK with your working and especially pictures.

Thanks,
Yury

