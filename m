Return-Path: <linux-kernel+bounces-153585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D98ACFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD8328549B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AAB152190;
	Mon, 22 Apr 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWAt1XMc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619931E49F;
	Mon, 22 Apr 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797726; cv=none; b=RCgRTQYEMJpxlQod8MUz8vAJfvyh1EjIgRAttTgYj4nhaEWw0OC/tr8zOIzl8Ptlal8V6YrR1JqU8Wn7KKRvc/ko8qjsC1XfoaLXfkPKpk0m3HptuLfzFRFemT2Bne22R4gYi98Uif7eTZzII5zcS4OfmAsjRCNXa6QvrKqO0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797726; c=relaxed/simple;
	bh=LJ4OGj/G3ocPwE6LJjXahrtiiWDhc9Z7GXZHiYK1IZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX3mMZp0eCNEAvavilTbKkZQZqV306lhYbZ32VuZ0G7Dz2VOmIi/Lu0xQrti3Lop41pPbMqgwOgHHVFE7nX40vUsV4QxhVQffVE2sdj+1snlhW/YiIGoDCJoVjKRjt5x1WcIV2N/iuYSkhQSptvTbr93NIfUG3u5KDz/fkLxcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWAt1XMc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572146dd1c8so663146a12.3;
        Mon, 22 Apr 2024 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713797722; x=1714402522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ4OGj/G3ocPwE6LJjXahrtiiWDhc9Z7GXZHiYK1IZ0=;
        b=RWAt1XMcvURv1LC8ZP4yeM0zrTR3a89J0uainZzA8sQnVwRxoisVlvl18OxDGgR3pN
         7B60nwVLbDR2jToGdiMUJDnwsr7XdymyVwGfdLsnjjwgdrXZFvjisuzQDBnospbEVPKQ
         qmoYewgFoMU8uGqqT/vCVZfCwbMJ0erJhIYxklYA11pUWirEBil1lfeaUpfMIVFqOTz1
         Urtl6zoG44y9FaqRo+3SNoS6Om1jYkieqbQDHoao8jDjdO/27cDrtAm1xfOXgdL8Usji
         WKuVrclkr9CJsztDddPXmaV65hqMyIQCLAQsMlQ1rYf7J53iywPDJh3AoFKC1Oz0r9du
         UIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713797722; x=1714402522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ4OGj/G3ocPwE6LJjXahrtiiWDhc9Z7GXZHiYK1IZ0=;
        b=Yb2OqVJ+TbgYLUq3B3U7dC9YMfHBAXbEZG3tiaOPJuMV3Fgj6uMi1T1/aIDuk6ACFQ
         +sLB19ZbPZ8T/HmbCdIp5fJndbiiGKi8dNVUm5rWd1v0u2R38me0BqoAj1uB663xza70
         kZdYticIhWcXlmgLVt6UaUKZWo84y92iN9wDE1Ocsx6AQ73ajLCl1IjNGO26faV9HgDr
         PVYg59aJEHzT2+CVLS0AFSbDlmIRaofKMi6bcTRwIiXYR5ICuYwd1qJkeuqqedyTTQpa
         FIGvWk/h92xA6tGH+lMZOpaKwsenoRt2U7EVtK5jCAUMA91IY3AuY4oGVuM9eQxMT1u0
         wGiA==
X-Forwarded-Encrypted: i=1; AJvYcCWnLLlNP6pQxur7dAC0Crx2PbVP1hawVm3Kf8/Ind9J34lCejVkIIyye5enGXlaZIdfROUj9hMzZTFcgfdzyWAUo2qKzRVg+M9z2A3pR5D3uGXOjRXq3Rnksp4iaLu7fbGievJ0EVjkUOQR
X-Gm-Message-State: AOJu0YzvqUr932Iv2DCqno/XLlnLiv7aNw7xu7+shT/Fcq+qjQm+pcyh
	RUVtC4li5zuWwX9Q6CEB7+JAar1TUWsAuxfotHWFO8Q9ZTyNM73Zh3ocQz1oal40m9oHMno3V9F
	a0TknDOCmz9BcqoHkSn1SJprADks=
X-Google-Smtp-Source: AGHT+IGKeGoNS13fdl+AITowdhp/mZEru+IxeqNOh0ZgzxIisIX8SfoKgQ9i/2+abfEEERa+T9URmJOHPpnXkcl4lZ4=
X-Received: by 2002:a17:907:9447:b0:a55:c021:e3b6 with SMTP id
 dl7-20020a170907944700b00a55c021e3b6mr1894841ejc.11.1713797722551; Mon, 22
 Apr 2024 07:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
 <e2989aa1-7f2b-4ac3-8fd8-822c87d61a1e@kernel.org> <CAF1WSuzqLxpxwYuNYfHyvXLDMBE-ZU69YLXwBdQokZzhs49xzw@mail.gmail.com>
 <c5fdfc26-b8c7-4e0e-bd15-1299ec052833@kernel.org> <CAF1WSuzzzG_vm5b55zb_ha-Vj7H+i3ZbmPyN1F-EQxS3GLaurg@mail.gmail.com>
 <ZiZ3p8XVjolnzR4U@smile.fi.intel.com>
In-Reply-To: <ZiZ3p8XVjolnzR4U@smile.fi.intel.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Mon, 22 Apr 2024 17:57:31 +0300
Message-ID: <CAF1WSuyfsjgwnum0SLsCeYVv44w_02JmRYxpe9THgtgff3VXMg@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] add support for EXAR XR20M1172 UART
To: Andy Shevchenko <andy@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>, lkp@intel.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Rob Herring <robh@kernel.org>, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:45=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Mon, Apr 22, 2024 at 05:30:13PM +0300, Konstantin P. wrote:
> > I do not skip it, it added to patch 2, as you requested.
>
> You still continue top-posting!
> It's not good.
>
> You missed _my_ tag.
>
> But please, please, wait a bit, you really need to slow down.
>
> > On Mon, Apr 22, 2024, 16:51 Krzysztof Kozlowski <krzk@kernel.org> wrote=
:
> > > On 22/04/2024 15:50, Konstantin P. wrote:
> > > > On Mon, Apr 22, 2024 at 4:45=E2=80=AFPM Krzysztof Kozlowski <krzk@k=
ernel.org>
> > > wrote:
> > > >> On 22/04/2024 15:32, Konstantin Pugin wrote:
>
> > > >>> EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> > > >>> it has additional register which can change UART multiplier
> > > >>> to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used th=
is
> > > >>> flag to guard access to its specific DLD register. It seems than
> > > >>> other EXAR SPI UART modules also have this register, but I tested
> > > >>> only XR20M1172.
> > > >>> Yes, in datasheet this register is called "DLD - Divisor Fraction=
al"
> > > >>> or "DLD - Divisor Fractional Register", calling depends on datash=
eet
> > > >>> version.
> > > >>>
> > > >>> I am sorry about too many submissions and top post reply. About s=
econd
> > > -
> > > >>> I do not know how to reply properly to this ML from GMail phone a=
pp.
> > > About first - I just
> > > >>> get very good feedback from Andy Shevchenko, and want to fix his
> > > review picks ASAP.
> > > >>>
> > > >>
> > > >> One patchset per 24h.
> > > >>
> > > >> Plus, you already got such review comment:
> > > >>
> > > >> This is a friendly reminder during the review process.
> > > >>
> > > >> It looks like you received a tag and forgot to add it.
> > > >>
> > > >> If you do not know the process, here is a short explanation:
> > > >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> > > >> versions, under or above your Signed-off-by tag. Tag is "received"=
, when
> > > >> provided in a message replied to you on the mailing list. Tools li=
ke b4
> > > >> can help here. However, there's no need to repost patches *only* t=
o add
> > > >> the tags. The upstream maintainer will do that for tags received o=
n the
> > > >> version they apply.
> > > >>
> > > >>
> > > https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/proces=
s/submitting-patches.rst#L577
> > > >>
> > > >> If a tag was not added on purpose, please state why and what chang=
ed.
> > > >>
> > > >> Just start using b4.
> > > >
> > > > There is not only for tag. I submit fixes for version 4 by mistake,
> > > > so, repost to 7 was necessary, because v6 was not work (as v4). But=
 v7
> > > > should be based on v5, and v5 is tested better around tty-next.
> > >
> > > ???
> > >
> > > You got tag, didn't you? Then explain why you decided to skip it. In =
the
> > > changelog of patchset which ignores/skips the tag.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I am sorry about your tag, I did not notice it, if I do new version, I
will for sure add it. About top-posting - I do not know, how not to
top-post from GMail phone app(

Also, I added a linux-serial mailing list into all my mail, I do not
know why my emails are missing.

