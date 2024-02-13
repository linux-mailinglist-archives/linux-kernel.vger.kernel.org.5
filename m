Return-Path: <linux-kernel+bounces-63616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737AF853254
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290E51F23794
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992EF56749;
	Tue, 13 Feb 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2l1TEuX"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8253814;
	Tue, 13 Feb 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832363; cv=none; b=bw80jy2IJlXn3B6q4+TZWe4Qc2nmOIeqYE6fT4MsQkLy76ke4quThQ55z+dI5k2qFkrAj2N+jFIhDnLBOXspxn9HJ/5bai5s3c7PO79s2Obr324uMKrOMeBlE8qNeRN9xhiXuwd6UGDBY3V7y3OrC5RH5Zu+wew0cTRX6dGpGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832363; c=relaxed/simple;
	bh=gZHJaV0n/bY1ZeOAShu+ZH8f8JsMNVFp3tEUsMb8Osk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLrv0it5P+6WobCUxAI/50pqRsLpGhbgrXHTFiT6GHMQWhn9tvV+frlbQHaoqfv36SQYs+v4dGrbyWpQw+2UTkK6NOBpu83Eia8eYxUsUFg/mXmYDkoRcVumjKKArI/asQpwh9S+HGSt+7iMvSxLzE/nqRZszThs/s439GIyhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2l1TEuX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e10614c276so19259b3a.3;
        Tue, 13 Feb 2024 05:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707832362; x=1708437162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lrAqqYQAE/5azD8jUmo4B37QDeKUelyT/u/vST2pSs=;
        b=R2l1TEuXUzgz77somDqoHL+NyliaxqwBUeMUUUtZdw2yNp9egvXIpVAc8VdWRz828S
         OzeDUuvHvjHNdHGBSqT60NU2CBSxze00RHcTsdXNM0udDZJ5kn8OIlgp1BDpQDcSNSW1
         PouQgdRk/ciIBh56PLzCZ+O4xmyFOqNDIiN7g/BDm7RN7aWEnp3+MUuOTyXgJ8ruyKfY
         1DyhsWgre29McKTtjE4K+JPDflt+5By0mZuFt1+QIsZ0Qynh9vYYPQDch2pupGO3oJzr
         xtG4t7PCA60OVTPIUtmL1A6pjtxmaD0IcOvTH+bQ03QpUgftxdFI/v5kXOQuxLcF/d+t
         H3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832362; x=1708437162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lrAqqYQAE/5azD8jUmo4B37QDeKUelyT/u/vST2pSs=;
        b=PFNXkyIjMpqCWoJ64XjLt66jz+wcuq5rWDA59AL3hegP+c5yhctvqKl7F7+W2pO/pk
         s7EE3fNJBRaq+Vkhx855GtutFlFcns6ydPZ+Oy1O0TQGMj+0YQF7JCBGp1AB87YJAW3l
         W6rIssEpdZC0pLoA0Une+FGtLzElasnYIGop24aUMChcSDWFiJPmCFsGD6Y8RfeR+Uv0
         68HDJ90xIbhRIEvUoLsvb2YxiZC/qPa62DIirzwqVB4v2jDrt7VdAhAyAlmiLsttLLRK
         Cbvo1so5hg/TpHnvkQOQp8W1ufIaQ60XN+I2ZCKPWsXfxhWVKggEuW8Ijkk8TbwdLdzV
         0QWw==
X-Forwarded-Encrypted: i=1; AJvYcCXwzlb6xsAqisvbkAXVAZD5TRs+Mkg2Zd2yMqlr+ksHpXoIow2KCbIB9Nzq7vZmTLMwH4znB8dKDxOIA2A0N+zaEwdc06Ss3d7/sDMGIyvDn/kjApmW0eRIOZjUmVo1U5Qdl8PCVaLlFg==
X-Gm-Message-State: AOJu0YxID5OXflQvWN0DRzBv4lE1ZmETWJLAc0HsSWTwbeW1YeT3NnJq
	i9H5XLCzNccWQXYVlmqI8UeALD0waMcJtuoKeGA9K9gcZHPh6134zKySBv8ku8CTt5czOnfrvqr
	qAltJ1ms2TmyRTgNwTMK/obslsFtgQUPe
X-Google-Smtp-Source: AGHT+IGO7vUaCrxPrStR6/UVK+qGCt1f71Bb3woNmrr0dc2/pWgTowRBUjm/B5cQhZfOZS47d4luy9Aa97+7AxGNl8U=
X-Received: by 2002:a05:6a21:3a42:b0:19e:b15c:be06 with SMTP id
 zu2-20020a056a213a4200b0019eb15cbe06mr8795657pzb.16.1707832361709; Tue, 13
 Feb 2024 05:52:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124146.202391-1-aford173@gmail.com> <20240213125618.GG52537@atomide.com>
 <20240213130208.GI52537@atomide.com> <CAHCN7xLmTEk0439XTuRPG7SSdH=4YiMTmrSXmfTkpC2bo_kNGw@mail.gmail.com>
 <20240213133622.GJ52537@atomide.com>
In-Reply-To: <20240213133622.GJ52537@atomide.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 13 Feb 2024 07:52:30 -0600
Message-ID: <CAHCN7x+C5KOQK1muXkpW95-kGrtkRNH_=Jy4m6igbxGBVZfTyQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: omap3: Migrate hsmmc driver to sdhci driver
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, aford@beaconembedded.com, 
	=?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:36=E2=80=AFAM Tony Lindgren <tony@atomide.com> wr=
ote:
>
> * Adam Ford <aford173@gmail.com> [240213 13:29]:
> > On Tue, Feb 13, 2024 at 7:02=E2=80=AFAM Tony Lindgren <tony@atomide.com=
> wrote:
> > >
> > > * Tony Lindgren <tony@atomide.com> [240213 12:56]:
> > > > * Adam Ford <aford173@gmail.com> [240213 12:41]:
> > > > > The sdhci driver has been around for several years, and it suppor=
ts
> > > > > the OMAP3 family.  Instead of using the older driver, let's final=
ly
> > > > > migrate to the newer one.
> > > >
> > > > I think we also should do these to avoid incomplete conversion:
> > > >
> > > > - ti,dual-volt property can be dropped
> > > >
> > > > - ti,non-removable should become non-removable
> >
> > I'll do a more comprehensive search for these flags.  When I did my
> > testing on the AM3517, I didn't notice these, but I see now that
> > others might.  I'll do a multi-patch series to first address the
> > multi-block, then  omap3-ldp.dts, then migrate the omap3.dtsi to the
> > new driver while dropping the flags, and lastly update the individual
> > boards accordingly.  I just have one question below.
>
> OK sounds good to me :)
>
> > > > - ti,omap3-pre-es3-hsmmc probably should not be needed with sdhci
> > >
> > > Hmm actually we may need to set SDHCI_QUIRK_NO_MULTIBLOCK for
> > > compatible ti,omap3-pre-es3-hsmmc.
> >
> > Should I update the driver and binding to add  ti,omap3-pre-es3-sdhci
> > to set that flag, or should we create a boolean (maybe
> > 'ti,sdhci-no-multiblock') to the device tree options for that driver?
>
> Probably best to set up some sdhci generic property for it that then
> sets SDHCI_QUIRK_NO_MULTIBLOCK.

Sounds good.  I'll try to work on this tonight, but it might be a day
or two before I get the more comprehensive update out.  Hopefully in
the meantime, people may respond with other comments too.  I also want
to retest my OMAP35 and DM37 boards.  It's been since kernel 6.1 since
I tested them all.

adam
>
> Regards,
>
> Tony

