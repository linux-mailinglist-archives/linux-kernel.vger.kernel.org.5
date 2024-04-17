Return-Path: <linux-kernel+bounces-148971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFC8A89DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18023285B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1207817106A;
	Wed, 17 Apr 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L80dOehs"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAC16FF52;
	Wed, 17 Apr 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373599; cv=none; b=A9cQGd2B1NZuIOBTDhX5Y501JbbjmKGLFJkoiVxyBjzCqT08ul7kU4fnv74RyeFMuxPJrc4aPN/6ZVpAMZQA1kwcaapcsNbw6TqucjRB+H4HbTzrm12uPGtsYrr7I25r0JTFZQ3LbjPHDFq84+RQg58dbBF0sG220GbG64WKd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373599; c=relaxed/simple;
	bh=dns+vSKoSLKSTob5Tu8UUcrPG8o7fEs+PylzWVblz80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCqBQ/gYjEDDxY9CvJO3JNkHQhK0MvQE+vwmUAaDCNCYt4BnO3iK6i/9OYJf9ETTw0vxj4w1TrmHgepTkWuCsQJn+Vd/auYxPdoHb59qgGuq/FFqbOHBJ36Gyi9Ci4Gv69LAR/IccFxCUCmrJ6+tCU6eqy6ftS3pMev2G/w464M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L80dOehs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55323f2ef9so398133866b.1;
        Wed, 17 Apr 2024 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373596; x=1713978396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vlt51KY3Co0I05VahTWqeeW3mrV92S7Q+/DdjLd+Ow=;
        b=L80dOehsiKh0EY2I2cCxs7SoOyKRlveFsBheD4wgYgk3D7Pq8LA/Wn3WTgAgVCYPZF
         9iIcy6p27MO19lRc5nwzJo6JNgJS3lut3C1lEcUibfI6Opb+Kv0GeiMbmmnlDY/o7gWi
         mZkiz+AIZaCI8/cKw3aw86hD/zR83RpssA2QfWVD1Y1fKwwcuF98PcppQ3xPjbiqj2FJ
         O0kZtuvP5dKAeWY6fxHr3fkWUblbi7kLtCwnun3O29C1xgagq94uE7Tt5s12W2uGrslH
         OVumtStatjr9mF29BgzUcE8O+gr9rFQU0a2JtoF8YAtRabwIAzILG9bQd6IcdFx8IwUJ
         lsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373596; x=1713978396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vlt51KY3Co0I05VahTWqeeW3mrV92S7Q+/DdjLd+Ow=;
        b=KoO6ujVonxS5/QUCCFrReKtDHiH/nsqQlypX6WsgDuOYb+LMYuXPxmZeUb9yguZEzm
         ydMfl6FnoT1WABpXPTXD2vY44nQV8jH71d+hKOJtq22H8z0zhjcuu3AKWSgKBV8abh4a
         lEhP/VcrP8KptQowIa2IXDI+lD4bPY91EW4vo49JGzjc3s0Nt2btnKl/yJg/hAwev5KJ
         v+2ng5NSkCjSEr84zvs1XvU67icQMzfsnE3Uzq4JC42n5f7A2utbby8pUndrlSiRmLbO
         q3w6A+YjaMCpouynytpPKzu01yBFR+/8cPo6yXzSiYj4tewiXU1nkCoM+Kb9ylKWLK7T
         mw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpyvAjMZdzcfEAeSUqhmcGW9OwT1jB2mae4Bi7DRRziwCy5VCXLuzbQq6NV16BfIvsH1OqXbAmV5Iq9U20R0bhvPhtNNuAlcWpyRsyPktHCQ2NlSxStrtpy1FmYXfqyZy22Ge4QmdJm20RapQz4rv93q1M0/fMjCrYTt8TpDxELT1Spw==
X-Gm-Message-State: AOJu0YwFWBLba2UN0/DJq9H9wKNGUvgnZB+moZwjpr1LmmiTgAjGn1z7
	Gk2ivRTIgVHtu/shgEsACjN4tsSV5IRdXiJPjhCxj84/Vbz9ZDwh6EflqaE1vW4pac7DXt88qx0
	Fbvy6DEXca1b8qIsX2SD9zRdrBk0=
X-Google-Smtp-Source: AGHT+IFXqbd9nd+mgNTMiEOcCSaD71sKWKwyJmPjZgcqgstbPq/iT6i3DtqbYYavNNMnWmgADM/2EH+cPswJJIL0EJE=
X-Received: by 2002:a17:907:e94:b0:a51:d0e6:57ff with SMTP id
 ho20-20020a1709070e9400b00a51d0e657ffmr86059ejc.45.1713373595977; Wed, 17 Apr
 2024 10:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417170054.140587-1-alisa.roman@analog.com> <20240417170054.140587-6-alisa.roman@analog.com>
In-Reply-To: <20240417170054.140587-6-alisa.roman@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Apr 2024 20:06:00 +0300
Message-ID: <CAHp75VctFbys8ARoE9ZqsCSCOYWjsZnR80g+YXstbyzo5r6TYw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	marcelo.schmitt@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com, 
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:01=E2=80=AFPM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The user can dynamically configure them in the devicetree.
>
> Also modify config AD7192 description for better scaling.

..

> +       device_for_each_child_node(dev, child) {

You can use scoped variant AFAIU that's available in Jonathan's tree.

> +               *ad7194_channels =3D ad7194_chan_diff;
> +               ad7194_channels->scan_index =3D index++;
> +               ret =3D ad7194_parse_channel(child, ad7194_channels);
> +               if (ret) {

> +                       fwnode_handle_put(child);

With the above this wouldn't be needed.

> +                       return ret;
> +               }
> +               ad7194_channels++;
> +       }

--=20
With Best Regards,
Andy Shevchenko

