Return-Path: <linux-kernel+bounces-78300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0886118F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D02B24E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4537C6C9;
	Fri, 23 Feb 2024 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHp4cH4u"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471907C092;
	Fri, 23 Feb 2024 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691787; cv=none; b=m8LUkiwOm9PlFZdJha3Ma3EsJhz3cFmT9mHJA4nuwBmx2OEqSStnPxxF51V1exiJW7NCLwCL6f+dGYDmOvDBJ5Q32SnJGYmIj/wx8uR9OZ5Y5pjq0cyPtS3XEh2QLw5iIwdl0RmPAwFC9JYiISKlwCmmmId8B5wbe76IJ3bGz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691787; c=relaxed/simple;
	bh=C7jnAzTVxTE/iVIV2VlGceKWS5qcQl/Sbcc2xKfMCXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay6FScutYg0TSQYuJQLogv0jN2WJUCwJ/E+46aG+f6AnXa5FKBysnmc54E5YjW0M2oGNAEhuA+zlhFghJOdR+AScfhGmcrR9Uox9IMGCRZXjo7i0UbymRLSD1g6SzMyXD6CTzEyba0PQOUICkbk7O/qzq3qHnoJ1gH9wyaXaWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHp4cH4u; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso101499466b.2;
        Fri, 23 Feb 2024 04:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708691783; x=1709296583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzFcJBd1zxPkvjOBSaAjY1+f/WJdvf98/2gt/XuRmCI=;
        b=dHp4cH4uwbNjVjyIKSxl5egHYDhrx5FBpA0kBD08aGC17G7RE6tqo/mXYYquG58Gfy
         blnTiGUjVCtHlxJWn0l/0vX6xUvH6EVsCj2HOfZOJv6i535QsuTWF9HYK+gZmU25djZO
         BwloRWMnmEe/sHkeW0oHR4X1sYytD3IFC6VWka2UilC2WpJdpK4uGYmp7i26Ixt9DZX4
         8q6So6Lc1kQciSO5NnlcCzUx2fTuIFbsPM/vn/T8xpGt9cesudfpoANH8KQNQxdmPM40
         uzC+xvcl3cDBzCl0Y/xBTmv4suysPDjFx6GJDqVdhzsfF4S33+yqkMyMGqVrn7JWD+3v
         QxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691783; x=1709296583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzFcJBd1zxPkvjOBSaAjY1+f/WJdvf98/2gt/XuRmCI=;
        b=lpyeiZMu1npxhmEfZX1SxE1HcmSkrtZDpD8fVPZzNXwl8Pb+iMCoJdPLvYXf8rKotQ
         2kTcg7EtCs3WZMnG+OPLueapVE4axzxUoR+hCwWwN7mLUM4Fv6t+j1w5iGPIeiTAt7Zt
         QLYUwKupnx1zbkqat9FQHswVrFlUHpqT6cNOgRiq4N10qMPHF8bhupjeMoQ2b7S7c8KB
         tDqlZ7k78bZGPJplq7M5D7XjQopr+xPQRck13AIAuqnSLlhRdWSzhrK+YaocrecNerBi
         Viw7zITeMSElpXHTvL4mAmZ8qtuC9qjBrSFW8S/VBVo6Dn6xwUQKWHZCsU93uOmjRiLG
         Qhdg==
X-Forwarded-Encrypted: i=1; AJvYcCW3IvOwMDTj2xRrBUowX2Rv9ICh1IdlcuZVzHlDhfC9kaDod305UXDA8hOjKL8Y0zhL2TVoyq50TN9pw/zlAqIL+vcaTT3mxTizPBCjsudsnnJoJ13ZKd5cL7CVPg73Ji/yIaIYTvB0VA==
X-Gm-Message-State: AOJu0YxYiJREYA6BSsKrowOzCYPq4dqMN351qo3aLPQE+ZyhGQu5BVoA
	fv7b6N2b/xagJQm+OGUwmlihVMEsVCf/wF1FvbYZpGPbbj+QaVsw1PlKe9QjdfR4wLG2wSy8EKG
	ej1KsSHOOdJzGCW6aNHjCogYyux8=
X-Google-Smtp-Source: AGHT+IGbOJZ2saPJ/LSOlmmJ3E8u4VFHulqKmCc4eZ7feJMppQFaOTi3Ye8uxUNK0NSKZxfWOZUrvie/mCnhWTCtcFo=
X-Received: by 2002:a17:906:164a:b0:a3f:4d95:ff69 with SMTP id
 n10-20020a170906164a00b00a3f4d95ff69mr1254963ejd.38.1708691783395; Fri, 23
 Feb 2024 04:36:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain> <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
 <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
 <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
 <CAHp75VdnXtVwrLrcGjnYMfNx7roBvQm9DMr6_ndjZeAbRDbs_Q@mail.gmail.com>
 <2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz> <CAMuHMdUFW7iTdhQtW4eDnU50zRqsdWsLnTD74UQo8tBU66-dCA@mail.gmail.com>
In-Reply-To: <CAMuHMdUFW7iTdhQtW4eDnU50zRqsdWsLnTD74UQo8tBU66-dCA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2024 14:35:46 +0200
Message-ID: <CAHp75Veyvw75jc4LFpW2EQQ=wSYmn_VdsPBWVG03b+P0QvyGaQ@mail.gmail.com>
Subject: Re: Linux support for a 7 segment LED display
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
	"lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:52=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Fri, Feb 23, 2024 at 4:46=E2=80=AFAM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> > On 23/02/24 11:13, Andy Shevchenko wrote:

..

> > I've been playing about with this. I've got an auxdisplay driver that's
> > basically working (I won't bother spamming list with it yet). But I'm
> > wondering how I'd represent multiple characters. I kind of feel the
> > natural representation would be something like.
> >
> >          led-7seg {
> >                  compatible =3D "generic,7-segment-on-gpio";
>
> gpio-7seg?
>
> >                  char-0 {
> >                      segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW
> >                                       &gpio 1 GPIO_ACTIVE_LOW
> >                                       &gpio 2 GPIO_ACTIVE_LOW
> >                                       &gpio 3 GPIO_ACTIVE_LOW
> >                                       &gpio 4 GPIO_ACTIVE_LOW
> >                                       &gpio 5 GPIO_ACTIVE_LOW
> >                                       &gpio 6 GPIO_ACTIVE_LOW>;
> >                  };
> >                  char-1 {
> >                      segment-gpios =3D <&gpio 8 GPIO_ACTIVE_LOW
> >                                       &gpio 9 GPIO_ACTIVE_LOW
> >                                       &gpio 10 GPIO_ACTIVE_LOW
> >                                       &gpio 11 GPIO_ACTIVE_LOW
> >                                       &gpio 12 GPIO_ACTIVE_LOW
> >                                       &gpio 13 GPIO_ACTIVE_LOW
> >                                       &gpio 14 GPIO_ACTIVE_LOW>;
> >                  };
> >          };
> >
> > But having those sub-nodes means I can't just use devm_gpiod_get_array(=
)
> > instead I'd have to use device_for_each_child_node() and
> > devm_fwnode_gpiod_get_index(). Am I missing something? I could do away
> > with the sub-nodes and have properties like "segment-0-gpios",
> > "segment-1-gpios" but that feels awkward.
>
> Just use a single segment-gpios property?
> The dot is optional, and can be zero.
> The number of characters is (the number of elements + 1) / 8.
> The "+ 1" serves to accommodate the optional dot for the last character,
> but if people find that too complicated, you can enforce a multiple
> of 8 instead.
>
> The colon found on many 4-digit displays can be a separate gpios
> property.
>
> I do agree subnodes could be more appropriate for more complex
> displays, but ideally you need some way to describe relative positions
> for such displays, too.

For line display the sequence is the same as in DT, so I'm supporting
the idea of separate subnodes per digit. Note, that we can
theoretically have different displays to form the line, but it makes
things more complex if we ever want to support that combination.

> Note that most larger displays are not individual LEDs, but matrices
> of LEDs. Do we want to drive/scan them from software, using a
> gpio-7seg-matrix driver?

LED matrices are the displays (like tinyDRM is for).


--=20
With Best Regards,
Andy Shevchenko

