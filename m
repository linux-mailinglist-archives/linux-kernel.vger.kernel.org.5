Return-Path: <linux-kernel+bounces-164706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FEB8B8163
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2654C1F220F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB531A0AEA;
	Tue, 30 Apr 2024 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnKkWiXe"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB71F176;
	Tue, 30 Apr 2024 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508929; cv=none; b=AaPGKUwp6wBm5nFiIMvZQvXbwZXVUV8Vg4/eDgmPcLGf1qJJ8Vz7yrMiDS4ik9YBOS8wmVtpasehKZzXl70OEB8B1TqA/LHi85fobHiL8gtGmUhI0l2fJoSlfsK6iEBQTCYiW/InQa/UlCIES3jPgwMFD5OR0EqipSAH7+mTrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508929; c=relaxed/simple;
	bh=X4XRyOqZhoouAcC1Q84O7GKsyRYLL98VlCeL84nXFPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRyPi4pI8Yy8tCtL+f/4D6MmRUg1T7vHXmVB0L7MZ+wfPkZItn46DcPQSLTCPQdl1NgyOelnRbXjCpZn7+w/gwNxhXgJt+eFYpbpQKrGX07gN/IRL0FqGFG3l3xPaRqfbjEBbPPbZ+ukaxa5bxhDcEr4rJzZha5pgQfuorqW7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnKkWiXe; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so7803713a12.0;
        Tue, 30 Apr 2024 13:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714508926; x=1715113726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmrpHLX46flU70H17+DNbupiS1vXQOS2XUzjHPnNgH8=;
        b=KnKkWiXe4CPk4yfdPNxfd5sp1/ipaIbM/ILtvKD+pB7x75pFN6zdnp6ZVKApvRyVme
         j/wbd0K8686t2+b5D3ZSwppRX62u8m4fj4xtGwefSwAARubsjg2cxoPWqVuR+rCMpM01
         RobSXQW9dv4+W7y/NiC8oIeAScmS4P0jbhU+hGsy7G5xAW9XwxVdzd2Qq6cvPQikUXR4
         i7tm0fl4lrcbAzqSHtSr4q447tU90gQKbQk/uLfLsN7yn407aNLr64FfmtAYi+S7hPbH
         fnFWNECgkWahvf1TYhI0eGuFEIHKnAouRlxFmRSNBnVEaa6hVG9YEbFnX9VnJaAQ/BMb
         fhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714508926; x=1715113726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmrpHLX46flU70H17+DNbupiS1vXQOS2XUzjHPnNgH8=;
        b=Sj1uEJqQOaK6DAI9xe+eeYbwkvkQMccivj0ySjLOZ1shykURdZOZx0AJGnJij9McLj
         iYZRPHIbg9sDZw1xxCPcGyGXGbMPw4LewZGhqALs7Cn6aqS/y7g2gVKErLH4nf1FmrN7
         46S8JF8UPt4Rt1meNwRQHkbyLfawSGXxwH5TKK6PhaBIhUxsaoYdNZqpjZj3NAOr6gkN
         pUXdVsNq7QPIArYjBpmvvryZNpp5baVxyIlscGsVNAXdERBUd4EH6JcdoLlV0VQIYGfE
         OUXXmf5lrvCD8W5kJhBy0fnz2aFmtMji2gYgbVBaKRFlIaGlrk0ldAX9gliLzlZfzPLW
         0YTA==
X-Forwarded-Encrypted: i=1; AJvYcCVZbTEAZjA5hJmSfBgbuVTbLdEvCiAJl1FcwKDIe0Z6gXXuEkS9rLZmFLmmGMhQEwUVx83el+qdYrk4NblsWmJJ9T/iEDQywi7AkzsjxwY+Zj7aJRiJMk6oc2MOBxgMTt3ssNTcUcbMAo8XXL/nMsQdLhkofVdcRfE+Lst5vzWsIUOUgg==
X-Gm-Message-State: AOJu0Yxqk/hOhh3d1L/SqNs9YKIhplCygfCdHz17NI3VTJwkfsARvW1s
	eRI20mUwCDREAbAfV/JwEA3uY5G41iaxBQZzJ9ZIci5ii7zlbnt9yxKpaH4ZE+zSNp/JnORZ3WD
	LuhkuU0vrsikXjh3xufYqqYs19ss=
X-Google-Smtp-Source: AGHT+IHbwX88oiFyDn0d3AB7Q1SVGsCIqNerQ7gq2MrtrAzNfHBrnRujxPcKOfKH5sabH7DDp4y1YvxhnW5dr8pysjA=
X-Received: by 2002:a17:906:c419:b0:a58:e3d5:87ba with SMTP id
 u25-20020a170906c41900b00a58e3d587bamr698030ejz.75.1714508925684; Tue, 30 Apr
 2024 13:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430162946.589423-1-alisa.roman@analog.com> <20240430162946.589423-4-alisa.roman@analog.com>
In-Reply-To: <20240430162946.589423-4-alisa.roman@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Apr 2024 23:28:08 +0300
Message-ID: <CAHp75Vc+C8g0PFgKLmjyspv_39wXNba58eLgJkNRqWgRyjujbw@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] iio: adc: ad7192: Add aincom supply
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

On Tue, Apr 30, 2024 at 7:30=E2=80=AFPM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
> in pseudo-differential operation mode. AINCOM voltage represents the
> offset of corresponding channels.

..

> +               ret =3D regulator_enable(aincom);
> +               if (ret)
> +                       return dev_err_probe(&spi->dev, ret,
> +                                            "Failed to enable specified =
AINCOM supply\n");
> +
> +               ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_di=
sable, aincom);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D regulator_get_voltage(aincom);
> +               if (ret < 0)
> +                       return dev_err_probe(&spi->dev, ret,
> +                                            "Device tree error, AINCOM v=
oltage undefined\n");
> +               st->aincom_mv =3D ret / 1000;

MILLI ?

--=20
With Best Regards,
Andy Shevchenko

