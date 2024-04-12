Return-Path: <linux-kernel+bounces-142524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2748A2CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF3AB23581
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBFD43AD5;
	Fri, 12 Apr 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyYWXuPo"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA52D41231
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918688; cv=none; b=S2khwhLy0TEWYaaaRfPrm/JT9NW+7dqaGVu0OM5KxSXCyy+EmLzKxuQOqUCgTo/fFCOA4qoD5cBGdv4IBAW/yC69Qe+JztWceTCaIxWgUDnHaAJYFx0jgTd0sN5tgK0r780Ul7cGAU+t9oZy37Y2tH8hd12uin47lsvddTZvDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918688; c=relaxed/simple;
	bh=v7mlEGcz7mNkeBpLcHL3FGgewkD7pRBBLfHoly2Kz5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uVXTx+rMq1Zli7jdt3ome3JBp8enKBJWs7AXLhbigod6aLgLjELQgJHa+0XDaUKRP6DU15hIDxca++l+pPzlYrN/rhF9Rysa4Hh8jBPd0sJv1oegeTU3H8NSE6SA4KQq0z+JQvSe6ei5o2alkEnhqAVrdC9oloAS7UXMQobJOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wyYWXuPo; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ddaad2aeab1so672303276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712918685; x=1713523485; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqlenMfbXI7u4QjaxfgU8oCjAPQSIsIN53pM+qheFN8=;
        b=wyYWXuPo0dfDLuWrrgtKfwn0Fay1fwGgWeFjRyy4PXTqq653H7hxFiwZWFlcz2DXGj
         1XdM53Gf2fZMDSWWvigysSpsCNcWgBuQ+0UMu8y0UUA3DLVbq8qK+h14YnZQR5UfgB/A
         aVTBMz7U6c+E0wpQY2CZlOeSZNMLfYhTpVgElP2NT+i+H+s9kBMq7HWFa62i05JWMG3K
         r/Lbp7qLBgJfo3TayokWWZM6V6USvBpDzHigpoB8uhT9JWdhX1V07PjOHr0ORK1ww8Mj
         Fw/cw/2X8J+3namHbLEz6ppXVietKBxAhFdunwsmrA4kC/8QcCQJFF2tRAPUtK5XRGzE
         QdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712918685; x=1713523485;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqlenMfbXI7u4QjaxfgU8oCjAPQSIsIN53pM+qheFN8=;
        b=iUjL7VQ+GguFKpE+R3NEC4QesVVF30EFFBZo0jM02XQ3HXCHCwIAdkLHEcP35eQXle
         rHdqhrYrcSRQTqj6xXUIdzJvCDgPJyMMLdqvyj33YH66D8N6L/NaxmlIjj9+wGaAucFV
         4fR8HUwFvZ7M3DFsD9oy1bMQCuf8itRbACtl9MD1JaDaFzScIdKL2OgKeT8dfZ2Vrt3F
         sGz7C1HxKqw7NAIIIFv8/s55BXHF35Y6Od+r28wnQmgTvKHzPvwj2lUE5HX49EO2HAv/
         uxiBAjfxOGYRo/iHVi7Jz8WunQCvxwfILxe8OizmWc+v0OC7jf+ZBXBzgztYg1xV6Zf3
         EjJg==
X-Forwarded-Encrypted: i=1; AJvYcCWPAyybAUmLx5Fj/12hMaqty1uXBvKXB6KRQ9drq8GRO2V+TYw9mgls+uUB61BAqdjcYAwHTnmmAmgvhlhD1Ic5QEuEZJrO5c1pe6Q3
X-Gm-Message-State: AOJu0YwQCu1A2Mz2A4slRA/MFRBiYqr75BxG9hjyIuM+H8QPx4HwSQ7K
	PH9LDRz9cVIlDzY1HAEBtqorXTyAv7Yp2PQQyAvTqvk1JO3QMUgmDiI2GgOtuKwPsdViv9G4RQl
	4MTo6tkmFRqG2U7SaeH3nvITdvzpnq79r/zUZqcjOYx5IkbZ7lEY=
X-Google-Smtp-Source: AGHT+IED3ayl6UkAQC2P0B49UvTOP1CgyGKxhqTmGgKhH3s9wFkmjW9bev85ClbkNc6qjO3C+ZIZtAit7NY75/+rT74=
X-Received: by 2002:a05:6902:252:b0:dc7:4b0a:589 with SMTP id
 k18-20020a056902025200b00dc74b0a0589mr2026248ybs.55.1712918685648; Fri, 12
 Apr 2024 03:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhgDCKhcHdwGoJ4Y@Z926fQmE5jqhFMgp6>
In-Reply-To: <ZhgDCKhcHdwGoJ4Y@Z926fQmE5jqhFMgp6>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Apr 2024 12:44:34 +0200
Message-ID: <CACRpkdbTdGajQLSGDkD0cWRG+79tpojYkdyF3t0jD7_WEDtQLw@mail.gmail.com>
Subject: Re: [PATCH][RFC][resend after bogus] gpio-syscon: do not report bogus error
To: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

thanks for your patch!

On Thu, Apr 11, 2024 at 5:35=E2=80=AFPM Etienne Buira <etienne.buira@free.f=
r> wrote:

> Do not call dev_err when gpio,syscon-dev is not set albeit unneeded.
> gpio-syscon is used with rk3328 chip, but this iomem region is
> documented in
> Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml and
> does not look like to require gpio,syscon-dev setting.
>
> Signed-off-by: Etienne Buira <etienne.buira@free.fr>
> X-Prefers: kind explanations over rotten tomatoes

If you look in drivers/gpio/gpio-syscon.c you see this:

        priv->syscon =3D syscon_regmap_lookup_by_phandle(np, "gpio,syscon-d=
ev");
        if (IS_ERR(priv->syscon) && np->parent)
                priv->syscon =3D syscon_node_to_regmap(np->parent);

So the driver will attempt to grab the syscon from the parent if
it can't be located from a gpio,syscon-dev node.

But it's not optional, look in arch/arm64/boot/dts/rockchip/rk3328.dtsi:

        grf: syscon@ff100000 {
                compatible =3D "rockchip,rk3328-grf", "syscon", "simple-mfd=
";
                reg =3D <0x0 0xff100000 0x0 0x1000>;
(...)
                grf_gpio: gpio {
                        compatible =3D "rockchip,rk3328-grf-gpio";
                        gpio-controller;
                        #gpio-cells =3D <2>;
                };

So indeed the parent is a sycon, and syscon_node_to_regmap(np->parent) will
be used to populate priv->syscon on RK3328.

So what you could do insteaf of the kludge is something like:

bool has_parent_syscon =3D false;

priv->syscon =3D syscon_regmap_lookup_by_phandle(np, "gpio,syscon-dev");
if (IS_ERR(priv->syscon) && np->parent) {
        priv->syscon =3D syscon_regmap_lookup_by_phandle(np, "gpio,syscon-d=
ev");
        has_parent_syscon =3D true;
}
if (IS_ERR(priv->syscon))
        return PTR_ERR(priv->syscon);

Then when you get to the code you disable for the flag instead of:

if (!(priv->data->flags & GPIO_SYSCON_FEAT_NODEV)) {
(...)

instead do:

if (!has_parent_syscon) {
(...)

What do you think about this?

Yours,
Linus Walleij

