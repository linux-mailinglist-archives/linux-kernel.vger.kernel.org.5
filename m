Return-Path: <linux-kernel+bounces-1319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE91814D60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE69EB20EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217883EA84;
	Fri, 15 Dec 2023 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOF4R7Ew"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC783EA81;
	Fri, 15 Dec 2023 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-551e6b99490so965681a12.0;
        Fri, 15 Dec 2023 08:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702658622; x=1703263422; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOzvwi19OPlgKFIB3mLEXQoYMykkFmAS0SbNNcFti/o=;
        b=mOF4R7Ewx6jaGkKXCD0LpFxwv1MXX/vQNTIoUB8UpgQtoqANcjRE1fZCKP1yI3p4b7
         dcvvRbpznfIhJiXBD81IzlEv/ow8xgg/M0YO2k5adi9uGCMaJFg8sH1EnB1cvrbqlNC0
         ZPmYTbgE6EQnuKzLHcvogZJWADHZ6YSMZAwFUKjvxQbtxpEsVybvc2G20tm5qrbiXeKK
         DvclI6/Qi3md68rXEZmiAs6leStMYu3XR4I2My05Jwqp+uLj3vaHS+upmD4iXQRo7KRP
         69/Hbp56edLqArVH10eufm65wlffjQKX9JBNyrEIKrsdILsVMmouQzMcLRqXAUmYSPXk
         D2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702658622; x=1703263422;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOzvwi19OPlgKFIB3mLEXQoYMykkFmAS0SbNNcFti/o=;
        b=TpGXwVVvuct8cy5h4UloWCyyoEJmoJtZq/orKgcJzgqFFawyGG3eswFedAZ0eusRWE
         XgetMMkk+UkQAqiVD874ozKrDLZmgpG7+yhAeRApqgkzWPqNG7F2rxMygtBIauZqBgXP
         kkxjrAT/uBD/BH399WyNf8KVtiVdrP50OFH2SHOOO6Fk8Iw0Ywmvlt/D8e2H4ca6N/Jm
         A07OLTduCUQ06i3LXVJFU1CKchAZltamgaGpZvU0n8k3mtsJiEeNKY4t/PNyDvcnIrDY
         Ch1Fd/4w8/28P5OKLM9VyaS4PbIAxo5XgALzQEpqSfcUV9XRipZIkviIq0/FyAw9UR8M
         HNJQ==
X-Gm-Message-State: AOJu0YxBAGl3MAbZVqBoyObBp+lZ/teMV40aWHDERTGWXemvIqUA9/J6
	pk7hptDC2uf/QlmOxLKx16I=
X-Google-Smtp-Source: AGHT+IFGNHmiZgDx3Ro8+s7DTnlQDfs6+UIJmQaxqG0BiVfr6mKkxbGgZPORQ/8y75GUd+SiLWSThw==
X-Received: by 2002:a50:a446:0:b0:552:df01:d77d with SMTP id v6-20020a50a446000000b00552df01d77dmr212059edb.167.1702658621966;
        Fri, 15 Dec 2023 08:43:41 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u30-20020a50951e000000b0054ca7afdf35sm8257006eda.86.2023.12.15.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:43:41 -0800 (PST)
Date: Fri, 15 Dec 2023 17:43:39 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Kartik <kkartik@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Jon Hunter <jonathanh@nvidia.com>, Kees Cook <keescook@chromium.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>, pshete@nvidia.com,
	petlozup@nvidia.com, Yangtao Li <frank.li@vivo.com>,
	Rob Herring <robh@kernel.org>, stefank@nvidia.com,
	pdeschrijver@nvidia.com,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/8] soc/tegra: fuse: Add ACPI support
Message-ID: <ZXyCOydl9VOfwKp-@orome.fritz.box>
References: <20231017052322.2636-1-kkartik@nvidia.com>
 <ZXs2jVeQtzU7668I@orome.fritz.box>
 <d84156ff-897c-440a-bafa-75933203a3f1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w4dYamGUEkjnuhl6"
Content-Disposition: inline
In-Reply-To: <d84156ff-897c-440a-bafa-75933203a3f1@app.fastmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--w4dYamGUEkjnuhl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 06:43:47PM +0000, Arnd Bergmann wrote:
> On Thu, Dec 14, 2023, at 17:08, Thierry Reding wrote:
> > On Tue, Oct 17, 2023 at 10:53:14AM +0530, Kartik wrote:
> >> This series of patches add ACPI support for Tegra194 and Tegra234 in
> >> Tegra fuse and apbmisc drivers. It also adds support for Tegra241
> >> which uses ACPI boot.
> >
> > Applied, thanks.
>=20
> I'm still a bit puzzled by this series, can you provide some more backgro=
und?
>=20
> Why does an ACPI based system require access to SoC drivers? Shouldn't
> this all be abstracted by the BIOS in some form so the device drivers
> can work standalone rather than calling into this driver?

This driver exposes a couple of things such as SoC family and SKU
information that is not otherwise available. It also exposes FUSE
data which can be used to calibrate certain devices. Most of the
region that contains the fuses is in the keep-out, so perhaps they
aren't needed on Tegra241.

I suppose things like SoC family and such could be exposed differently.
Not sure if ACPI has other ways to expose that.

Let's see if Kartik can shed some light on this.

Thierry

--w4dYamGUEkjnuhl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmV8gjkACgkQ3SOs138+
s6HWuw//XpwqBNokaMNgLTXzrHKgWSJTWUiR5GzPLuvLX5qT3CCkXWrrM904L5oL
2cHLpDkp4byRIjqqTa13vpa3vWP71GCCkTCioS5jn+Wob58ibyRbwzKpkNVKh4ET
iXnf7hhsCp314XwpsJaR37m8FcO8LNjgPmBpaEOLZv+ua3G3ItzJjWM7HXQp+LE+
OJ9G3lWDAA9HNag6t6qAdb5piiEDbAEnab+HJJru0T7JsN5T8TCcmLXbrhjh2yfP
V4XXXUpehfcgqKddk/RBYgM176MmutUnJ45P6hv5/5fUyNc0cpWbSVxJbq8KQIBe
ExvhgiM5QSjXXD0Rpv1pJ/buTw5/CuCNuC/Ae6Gg0cK3lqsDui/jXC5/yMi+xOed
gZw1VIIHnKhUqt47Ra63iARhk3w6VAEfuH+bG729GFZzO50tQDalbxtuIWIVqRcd
n7KjMV0hZZkVXrEeBunPczD/P0ResTyq9cbgUa4Ormgy6HS7IbSKTYp3I2lsr6Xj
TQZ2juWe9zO0zQMUPMSRdYh62rca0Y6BV0fhL5mNgPcaGRfcQ042iH+NmLHWHdq5
/cVLlFsCG5gGYo8u2G1oPGID6cE9byGoxTOnZJHrkyOGVowSQezNa9a82hAcgFEV
1e7u2tYC3+b6FwQAvTpoPDC0aERZdN6l0Zz8vseDnov+q5iPPP4=
=d3DY
-----END PGP SIGNATURE-----

--w4dYamGUEkjnuhl6--

