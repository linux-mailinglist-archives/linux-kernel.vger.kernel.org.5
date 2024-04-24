Return-Path: <linux-kernel+bounces-156330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C98B014D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F76228469B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4692515686F;
	Wed, 24 Apr 2024 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tv7aVJ8N"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA5156675
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937730; cv=none; b=DX7q764ZmHgTclvhDVPOr2SX7oBz+/RpvTUAD3oqGr7Hfdo0UVEK6Rx1yTpSsmQueLLdN5VC9kF6kW23qu3nMBPryxLRhsGkI++H04NNon8EQbPzkTfOFpEgZ6S26nNya7t2qY2jCF4fmP8HvJub3MUgoFX0z5YxSTdl9cIdoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937730; c=relaxed/simple;
	bh=OhGB6aeiRBED6PcnORU7BJxjBdjdb8vvp3O9u1ho3eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rox5V2MxLdYKUo4wGiIE2V06S/s0ztjjTfl1DMrSBlmhC6F+5RjHKfRSfXDv0gBkVWB14IyqNa39A11g0Bj9vsFdhfvYfLolNJRRja+/ZnXR7RBdXbmtGTWdXpI7iJp3IvGLXiNzHJx1iGQ0bSzPquebj/lDAx/9pg4VvixHSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tv7aVJ8N; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-436ed871225so138351cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713937728; x=1714542528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCgt+2CHtyKZaPY3pxG44Q6DoASj67IoLOhcREfYHl0=;
        b=tv7aVJ8N0ayEsvm+ZnqeBG1p4/3G1bKUYirHXB6+VqiHO8+iGqrWYe/OHsC5LM2HbR
         +emPqxuIqC9/vgeVyrV71as4J6ECluimSGK6IiXGr/eLNCZFHIb8A+gIIM+VrMFp74QL
         NmnsYfXU6D7t8yzYkMciOj2aEPBaa3jaEvrnpUcPWkZwVXUoyJg8ybwUGZDcti2bjEiC
         hBU7mQBSiNA5nPvpuL+yZcxMsbcjnsa7VtAGew4KwWMhwPVZnxnrgOeZ7dbw6CQBsj8h
         EEhxVIwHaT4h714/yHHiV4go4MMJjbVYpcdosfPxTx8x1N3ZjOUIWpXbg4kCh1U8erWu
         WWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937728; x=1714542528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCgt+2CHtyKZaPY3pxG44Q6DoASj67IoLOhcREfYHl0=;
        b=IyP8HpoA4BWh8/esZJUviXuOxybZ4oHB8K5xiffCOefhfuuu1s6MJeSJa5CIWzAsKM
         G4k0eO1dMJG6KQlUKwBC9/kPCTVZQq3xy/zNU9+3tTyFYvu3zOy0Et9dExDJGQG9Hect
         SnLlc48bDdzEYWiuCEpsMw7ZJc6vbWQnhZmFAYVNAci2LIAejTcmNh+MHAyV3PeY/6FG
         27pue74spHygyLDcHyvgboVMsl1/KBSsVG44GRKNs61b5+1i94nlr5nkC2mlLl6egFT1
         L4fLS20BHsBi2o5MKW7rjUiUFF6gdAFiJjUE9QtUMkaycA2GjhTXZpK3TV6OWo9KfMKq
         dM8w==
X-Forwarded-Encrypted: i=1; AJvYcCU9GBIRjc8PsoSkQzS+T2mCrcfEKaJPUvKAtm5yXDhSkanTuKPZiJ6KTJboy2i1XH8ZwWmNzPqZW+CmsbOQK3Y5SnZjoXcekZwcYdfK
X-Gm-Message-State: AOJu0YyCA591uQXsNtWEEd2n3G6YAeyKRkC44Eq3CrT9n2p10hmntm89
	h72Fuzhiu5wmmTiOdMAAPfW3GKNHy8JoMJ7yjJ9LTYXIykgcj8DvNpV/bDfYRxoSet0fNDsnpIj
	i0kHx+o6VuhnSSlJ9dXPvoHUYcNeUsu97Q16E
X-Google-Smtp-Source: AGHT+IE73h/d8DsMoF+sSXT6PcKG1fQZeZZbPEgvcmLjY0siy1ogX34+yH9o0AEKJKyvzzKUVhE+PgrjJElEuSg2Uzc=
X-Received: by 2002:ac8:6606:0:b0:439:ad3:a627 with SMTP id
 c6-20020ac86606000000b004390ad3a627mr130618qtp.5.1713937727823; Tue, 23 Apr
 2024 22:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com> <20240414-feature_poe-v8-2-e4bf1e860da5@bootlin.com>
In-Reply-To: <20240414-feature_poe-v8-2-e4bf1e860da5@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 23 Apr 2024 22:48:12 -0700
Message-ID: <CAGETcx-fZ4uuYsgpWcPFsuNKAkBarwC19_Ld=WX5EhYJ3Lovig@mail.gmail.com>
Subject: Re: [PATCH net-next v8 02/17] of: property: Add fw_devlink support
 for pse parent
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>, 
	kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 7:21=E2=80=AFAM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>
> This allows fw_devlink to create device links between consumers of
> a PSE and the supplier of the PSE.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

As the fw_devlink, I'd have preferred to be CC'ed on this patch before
it got pulled in. Especially since Andrew thought this might get
fw_devlink in a knot.

-Saravana
> ---
>
> Changes in v3:
> - New patch
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index a6358ee99b74..cc064151853e 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1252,6 +1252,7 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
>  DEFINE_SIMPLE_PROP(panel, "panel", NULL)
>  DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
>  DEFINE_SIMPLE_PROP(post_init_providers, "post-init-providers", NULL)
> +DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1357,6 +1358,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_backlight, },
>         { .parse_prop =3D parse_panel, },
>         { .parse_prop =3D parse_msi_parent, },
> +       { .parse_prop =3D parse_pses, },
>         { .parse_prop =3D parse_gpio_compat, },
>         { .parse_prop =3D parse_interrupts, },
>         { .parse_prop =3D parse_regulators, },
>
> --
> 2.34.1
>
>

