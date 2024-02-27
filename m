Return-Path: <linux-kernel+bounces-82496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C392C86855D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CEC1F225FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39DB4A1E;
	Tue, 27 Feb 2024 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6iYQapj"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9D1847;
	Tue, 27 Feb 2024 00:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995544; cv=none; b=GAy7TUk688FxO6d8DWPRiKNsRAU5hbsB7SnMMcAQ0qsZnREtla5QjbB2BAjygwyFlqo/bD4BC0jYdcUusUxwJW7TOBuZ8jOAB++SjCboJ8ZCNHk2Y0qa/9rfm9sb0l1S1tWroiMaoCh4hJWuN4BN6cXgbbDQqZVtv1T6EeIs4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995544; c=relaxed/simple;
	bh=iNi7oNCxJajUUM96pw0C24QuzhG1/xkoRAzNVqrY0oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjF9FSpNDIEixmTqRfGs4t32tN2N+Y7Y6HXyrPY8i7MC08IHBIRRJlrAAcCwV3mULWuodbOPYfpgL3/gxS2XEtDqjQASqIKjrU61jF031v2MfM19SYSnYOooJK4De9m0eC/QEH6PG84v0J/RamuMb5QnmeFFYoBDFzzQ1JDkaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6iYQapj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a431324e84cso216022566b.1;
        Mon, 26 Feb 2024 16:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995541; x=1709600341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOwaET2RQuuUT4UyNMk06oCZiWMp4ZIYJaKx0CPKHVI=;
        b=L6iYQapjj8hvRVromqQ0dtStNswo4/Wd0Ib5jxBAdEEdCkqbZ5ANOlc/eplEMg267F
         R5KcmCz7I+vzcc1ZdBpvskrPo+YAM+kPZYTn0xj680BCoEjmt0VNGlnuEPNsafx4iAaj
         quoJdDGyCc9ci9CIjGut+gkfJ/tUbNmTMmyTiJsS3FapUr5uU066VUCo3r/g9+KLZJF5
         FkzrxfBdkKkliUa7faESvmTKkGrvEDx4+v8F6YLuW0aUfY2jaS+F5Ojwz/kqfLvsOKFm
         3atfD6IUzdC6VzCoe2ADPPlGGpPd8uaRTIXsvQblyWs7kWTApksIfolW2ZUYL5W0zu5+
         HVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995541; x=1709600341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOwaET2RQuuUT4UyNMk06oCZiWMp4ZIYJaKx0CPKHVI=;
        b=XjI7rfFyZkObNXGbdVdaDv54tyPPXZ3OScVt54xuy/PHZ8XF35dKZJucEvIOI0ppKo
         4EG8u8j3GsMCzfngqaffyJnz0PWua433BS8UnJrXxZmFtB90VJ7isftE7l4fs/2gppOj
         LkaecwNdwmkHWnYdKY0jRykNARwfzxdkb1QbczTFcovhRq5i9QTMdh2UU1ulUPXgZcmO
         A7Ix5mAUPwnL6uaEO11VNvdWAzB8QXyXrGy7fOlpSFunYAGzPNtEOpbqVkF8+oy3nfVv
         l0Qa3V/+e0+YDh+jh6Nmh/nOIsbaR+1XWGHg2JKQq6XrEcELFT1NSXEgWKDGheSVVO6K
         c2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqzvg/tTLi4o1sfTAiVdsTLeakKyMvnpOIb+Aq6h0h2TnpZdOufXdbXp02L00hPxWkT2YvBs8JphJpm82hjDn0hFK034D5CPBAA9ZkxC9sjx3P5QTtwe1WKi52MMJg5YZLMiLJ8kBvXcH7hmVbvSGn4UlwLB24DhcKsBlR9MG5jbPw1iY=
X-Gm-Message-State: AOJu0YyoF8x3KZcFu7VpBiVIJ2Q4mnIxfAUR+IVhK4p2i4wfh9WF1cnt
	y+xeb3R3yamOzmouP+39+EW3r9maEXc87aGRvjjMWWBZmTL8ASHF4QmkqjcUlcswiT0PlpUYV9C
	wka/m0iU2jyGIFHwQmavij6w+d+o=
X-Google-Smtp-Source: AGHT+IGRjjrKCdZCbkwC5KtHDkM2hhrCRhK8651/GdZ7OeoHO23Wi6OTpPZlDDxREygrGBNdzN1mdNi0B5m7uEp6Dro=
X-Received: by 2002:a17:906:f1ce:b0:a43:a221:81ec with SMTP id
 gx14-20020a170906f1ce00b00a43a22181ecmr376996ejb.3.1708995540581; Mon, 26 Feb
 2024 16:59:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc9OBtxdKSmk9Uu9G3j+mfN8+9prTEVx3LyUcdBYFEqwg@mail.gmail.com> <584172eb-4eda-40d1-9ee5-99d0ef944481@alliedtelesis.co.nz>
In-Reply-To: <584172eb-4eda-40d1-9ee5-99d0ef944481@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2024 02:58:23 +0200
Message-ID: <CAHp75Vc3NFULXByhAv=1bq0aPsbH+_zVypQwaDGNrtafj+xGaw@mail.gmail.com>
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "ojeda@kernel.org" <ojeda@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>, 
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, 
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:52=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 26/02/24 15:23, Andy Shevchenko wrote:
> > On Sun, Feb 25, 2024 at 11:34=E2=80=AFPM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> >> This series adds a driver for a 7 segment LED display.
> >>
> >> I'd like to get some feedback on how this could be extended to support=
 >1
> >> character. The driver as presented is sufficient for my hardware which=
 only has
> >> a single character display but I can see that for this to be generical=
ly useful
> >> supporting more characters would be desireable.
> >>
> >> Earlier I posted an idea that the characters could be represended by
> >> sub-nodes[1] but there doesn't seem to be a way of having that and kee=
ping the
> >> convenience of using devm_gpiod_get_array() (unless I've missed someth=
ing).
> > It seems you didn't know that the tree for auxdisplay has been changed.
> > Can you rebase your stuff on top of
> > https://scanmail.trustwave.com/?c=3D20988&d=3Dvfbb5fnU59kvIREfdD-21Pab3=
0bpMpuTM2Ipv28now&u=3Dhttps%3a%2f%2fgit%2ekernel%2eorg%2fpub%2fscm%2flinux%=
2fkernel%2fgit%2fandy%2flinux-auxdisplay%2egit%2flog%2f%3fh%3dfor-next%3f
> > It will reduce your code base by ~50%.
> >
> > WRT subnodes, you can go with device_for_each_child_node() and
> > retrieve gpio array per digit. It means you will have an array of
> > arrays of GPIOs.
>
> So would the following work?
>
>      count =3D device_get_child_node_count(dev);
>      struct gpio_descs **chars  =3D devm_kzalloc(dev, sizeof(*chars) *
> count, GFP_KERNEL);
>
>      i =3D 0;
>      device_for_each_child_node(dev, child) {
>          chars[i] =3D devm_gpiod_get_array(dev, "segment", GPIOD_OUT_LOW)=
;

I see what you meant earlier.
This should be devm_fwnode_gpiod_get_index(), but we lack the _array
variant of it...

Dunno what to do, maybe adding the _array variant is the good move,
maybe something else.

>      }
>
> I haven't used the child. The devm_gpiod_get_array() will be looking at
> the fwnode of the parent.


--=20
With Best Regards,
Andy Shevchenko

