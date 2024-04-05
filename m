Return-Path: <linux-kernel+bounces-133417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3770489A371
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8F8288964
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3380171678;
	Fri,  5 Apr 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGRD+ag2"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C819200CB;
	Fri,  5 Apr 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337720; cv=none; b=jkBCCCERwzKDmXKj24e+l7bT0Bw4yH+BPwDmyc+ppXMYtWPEhiRcjTKnpQdKzM7tzKxl4ExzN9rXtK2ZU8FBIElWZ1W1PUXc8ZlayaYUWKh8m+V6z5cFcomDAdJP/u+e+W+9oyDm+4dSp4TRwtiL24l9YjrFCx/XcLVyfVVwACY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337720; c=relaxed/simple;
	bh=AG++jet0Ju0MNLOi4sGysJ+XJ0j7+TCv1jTw1EYZCP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPLDZfB6f1PEBzQ092631kHytbvC+sP5v5Zg1NVeOehiUREXSg38wZ1GFTi8mSODTYc5Dg4uJSZB9Bxmc1Uj2VwqauOYUuFpKle6K2zWq73MygxRayBHwwwwPQCSRw34+pflUdu/KSs5BfBGwURO7NblsKPg0XlYpBrWUbRUd+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGRD+ag2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4715991c32so360248966b.1;
        Fri, 05 Apr 2024 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712337716; x=1712942516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0Yb4LJqqMLdtzqM+ApTC2MgN2Bfk3iYcGWwBxFXQRk=;
        b=DGRD+ag2Q8ApxdruPTyg8UqUrE+13n7pNG+HN/20fLQLTGhYxKN+DWSMRKVQw1CHEl
         Mt8ISOQdR3iLgAW7pf+9UC0uwxrYJ8JfWZM6Oh8xup5WuE6clvU+kXxQ6toBv/Ov/dyP
         nmpehCCkJh3sGhf0Wxi7s0ure7C17Rq1vU1HIf9nxKaIH2Xl3NTASiAfwOraLTwR6Gwo
         ZBoYbBD1FN3lYFLTza/4e1JfAVlV7oTCcCZc/WoMdC6covH6E0+dyhfBRqWeP3oZ7TBA
         NhAGnwUlU6/uRfEA1XPTznmO9PvsuAxcJ9QDfmAEuzyuiTnIYfbud0v8fYnXrjauytGj
         sIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712337716; x=1712942516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0Yb4LJqqMLdtzqM+ApTC2MgN2Bfk3iYcGWwBxFXQRk=;
        b=vMih1zl3e9JvjFyU7Qxf2jNZddyRdIlCgPzk6vX6q9Vl40lqPlsbvhlJz7qxXTeMSs
         L319PjRD3bbyhLQmKKJxKFsTK51klyVHz6q3U5ONKaFw0VP0Izp+aFdXSVt7FErt5HlE
         5q+DiTTwNAGPQboxRBPgCAQj6wL0rCxKb82K5fwhksYAgoi0w3ZESRJ+6Iskz4AQ/8F1
         hbTkqxGHcWYxRhydld/N00+vIIiZ1RZE6294iF8R3+bRmJCl4AEZX3bJFSM8CqiZDKD9
         KoUOaTxeq9ataNuA/wX75tU1GbDboI3abycIp+0Yx+rkF+cc8Z2S5Rv7+gQAs8rlS+Si
         gGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV++9joXCvO331639ax+mUYw/5GzciLGrJ9cytut/8SROm0PeThXzWNj1XkefFtdq6+038s3H1mS7MV5UdLcqwUp6tR6LaaSWws3+02ZqzHi6Q+VS1+JWdzkEbGdS5wZP8X1U+6XpT3wkGH+o0fSwCnN1TeiOJ2vgVxBFMao2DKz23Iqr7w
X-Gm-Message-State: AOJu0Yw/P0701HvAvAImztuHaQLcyDFeOO8boz6sBrod5Y84yCPBgSro
	My0h4HoOsioqZwZm/DGLUfcNxPGDzsa2MarwzL1PtERjc2ptCtHL6zqZBeiej7Ktpg92DNAd63u
	2bsqiVxxda0jgx+JtdY1pztTk788=
X-Google-Smtp-Source: AGHT+IH9eqCGLMewQsBd25x4ugQJjxugZHkB5hLHdxUnO16fY7EHHOUW0s1GO8tpYkQAtHkTXH8KkppOe04i9yO1gdI=
X-Received: by 2002:a17:907:7ea5:b0:a51:8540:c671 with SMTP id
 qb37-20020a1709077ea500b00a518540c671mr1681972ejc.50.1712337716323; Fri, 05
 Apr 2024 10:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404222009.670685-1-andreas@kemnade.info> <20240404222009.670685-3-andreas@kemnade.info>
 <CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com> <20240405182832.4e457695@aktux>
In-Reply-To: <20240405182832.4e457695@aktux>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Apr 2024 20:21:19 +0300
Message-ID: <CAHp75VckoDheCN-KQ0KcSk9rE_-cXFUujurtA4sK6KAixDttQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de, hdegoede@redhat.com, 
	ye.xingchen@zte.com.cn, p.puschmann@pironex.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	caleb.connolly@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 7:28=E2=80=AFPM Andreas Kemnade <andreas@kemnade.inf=
o> wrote:
> On Fri, 5 Apr 2024 18:13:45 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Apr 5, 2024 at 1:20=E2=80=AFAM Andreas Kemnade <andreas@kemnade=
info> wrote:

..

> > > @@ -1484,6 +1484,7 @@ static const struct of_device_id edt_ft5x06_of_=
match[] =3D {
> > >         { .compatible =3D "edt,edt-ft5206", .data =3D &edt_ft5x06_dat=
a },
> > >         { .compatible =3D "edt,edt-ft5306", .data =3D &edt_ft5x06_dat=
a },
> > >         { .compatible =3D "edt,edt-ft5406", .data =3D &edt_ft5x06_dat=
a },
> > > +       { .compatible =3D "focaltech,ft5426", .data =3D &edt_ft5506_d=
ata },
> >
> > Why a different vendor prefix?
> > In case you need to use this one, keep the list sorted, currently this
> > splits the edt,* ones.
> >
> How do I know whether to use evervision or edt instead?

Ask DT people, the vendor-prefixes lists both...

> I sorted by the numbers. Looking at datasheets for other controllers I se=
e
> https://www.displayfuture.com/Display/datasheet/controller/FT5x06.pdf
> it only mentions FocalTech Systems Co., Ltd.

But does the driver use that? AFAICS it uses edt. Perhaps it's due to
a business split, not to my knowledge anyway.

> So how the vendor prefixes are derived?

Rob, Krzysztof?

--=20
With Best Regards,
Andy Shevchenko

