Return-Path: <linux-kernel+bounces-26447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C36EE82E0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4751F22D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1320018EA5;
	Mon, 15 Jan 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmlVty6C"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031318AE1;
	Mon, 15 Jan 2024 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2cea0563cbso452801766b.3;
        Mon, 15 Jan 2024 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348377; x=1705953177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiOJcOVnNa84I0LF7FtDQ1PT4mJ9d6sq/73epamT79s=;
        b=PmlVty6CzPfdnTKxPY8HgIRq4HkYv+gJhGeggEBpXbwhGNnSwWwSJj/HYUXLym/gL0
         81fFZfYaWobpO1qomvJzCZL0kArGQx8coydggjkh8X4xbNz64qQjTzV7q+8teyMT1JiM
         lwiU88PY/KjabWyWPfXgfRivvfLU19cUuvMDd3ZaZwLQtrMRtyPsoE/BLBEOWOZiQQdH
         cUwdh8dCvIgph3+iGyo4ZpSyKePKgHXGPaOGEutdV6quVNlOiSrLao3mKoTDRX1JOl0N
         UjcXUUWxViBD6Wg+xSfcb36QW9GpbF3ReTcwIB9//xHg2ToUROjadPmkgEtxXKENojc+
         pLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348377; x=1705953177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiOJcOVnNa84I0LF7FtDQ1PT4mJ9d6sq/73epamT79s=;
        b=kHCYrvi0If9sdznE/cq3htEJ4HjIEclWwqgE0NH9b7aDSRncgS38oyl2xAiqLOmWTx
         mDNyakoVGcLwo+xaaMw/t34KvS4tXg0huYOIOLLmtj2SGauc2weXuxjmz9y+vcj+GNQC
         yOkLJtM0HwAj7BjWa7a8SE35JV99EV2muo91hFWx4QsuRzhKBUWljQz7OFDzCgM2nc4f
         5i2bn9bazK3Zb7oxqpfMmKukDWE3QJlfuK60JRGmr35MaBWMHzkUDURrFqMwk634DoHa
         90X3pl6YFgqGtnih28elnwR1/tw/9dSNUGV/2KvdOV578yuwZ7tfQxAuHhFMVifTIkjB
         weAQ==
X-Gm-Message-State: AOJu0YznQD5fBGy/HrbATP5XEnr8Tcf+fB8gWILCO6eq33wI/W9ywCuR
	GUAaayqCKvWis98AXlDUfCmCIXjrquc9r8dgddk=
X-Google-Smtp-Source: AGHT+IEk0k1PWQ9K9x0DxDo2CKRbYP9mI+6PRp8A8zglB+pp2PHGeJ0oZ4ZLwgOi1fu9kntLigDyjhm9Gv/+704FHLY=
X-Received: by 2002:a17:907:10c7:b0:a2d:c839:e1e8 with SMTP id
 rv7-20020a17090710c700b00a2dc839e1e8mr1251268ejb.28.1705348377010; Mon, 15
 Jan 2024 11:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115135416.10595-1-mitrutzceclan@gmail.com> <20240115135416.10595-3-mitrutzceclan@gmail.com>
In-Reply-To: <20240115135416.10595-3-mitrutzceclan@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Jan 2024 21:52:20 +0200
Message-ID: <CAHp75VcjcgnLkQWim1AVnyeRGFwwKpaWSCvrmqdv41Lx87hMKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7173: add support for additional models
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 3:54=E2=80=AFPM Dumitru Ceclan <mitrutzceclan@gmail=
com> wrote:
>
> Add support for Analog Devices AD7172-2, AD7175-8, AD7177-2

Missing period.

..

> + * AD717X family SPI ADC driver

X --> x

..

> + * Suported devices:

Supported

..

> + *  AD7172-2 AD7172-4 AD7173-8 AD7175-2 AD7175-8 AD7176-2 AD7177-2

Too long and no good delimiter (like comma), can you reformat this list?

..

> +#define AD7172_2_ID                    0x00d0
> +#define AD7172_4_ID                    0x2050
>  #define AD7173_ID                      0x30d0
> +#define AD7175_2_ID                    0x0cd0
> +#define AD7175_8_ID                    0x3cd0
>  #define AD7176_ID                      0x0c90
> +#define AD7177_ID                      0x4fd0

Why not order by the ID value?

..

> +               //AD7177-2 has the filter values [0-6] marked as reserved
> +               // datasheet page 58

Be consistent with the type of comments. Either all C++ style or C.
Also missing space in the first line.

..

> +               if (ref_sel =3D=3D AD7173_SETUP_REF_SEL_INT_REF &&
> +                   st->info->id =3D=3D AD7172_2_ID){

Missing space.

> +                       fwnode_handle_put(child);
> +                       return dev_err_probe(dev, -EINVAL, "Internal refe=
rence is not available on ad7172-2\n");
> +               }

Not sure if Jonathan makes his series in for fwnode handle RAII.

--=20
With Best Regards,
Andy Shevchenko

