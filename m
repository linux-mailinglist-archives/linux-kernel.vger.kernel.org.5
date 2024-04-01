Return-Path: <linux-kernel+bounces-127074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E3894671
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B8D282720
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFACC54FB8;
	Mon,  1 Apr 2024 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qRIqM2kW"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716954F87
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006217; cv=none; b=PSHkBcOzm6AdO34aUjejEoxNCWXyO/BrqU6Wy3h6yvHEzY85IufNheLzNLN+xZ4JiQUAMX4giDUh6/SD/A4o9MnE+vBcj6y+WBwcc/V+JUPxqRzyzgc0vqpkUfEWghjQV+gjGcsk3L2O4q3jYULnSx97xJ9ke5tm628/ei4WVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006217; c=relaxed/simple;
	bh=LRIB+IlQyiZJucvH3luhNQ5xpEz7qQsLM5a02CjHDSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrsNyPj7mhWBvues8Og1Amogbs/OzVhPA1FBFCzTczLvLktwpw0UacdNKASOriZyardnTEAybIcEAza/4QjuvAY7h4wnIFuvHaZfM1S5808FqnSJdZjZQ1dIRTBpKXRoKGy00sKOnyzhyKNUqNzwYAzwZO3xPu8L6d4bWj/mw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qRIqM2kW; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515a81928a1so7235071e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712006212; x=1712611012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7IJ6bTDAFU3LIbdvbyl4a/Q/nTpdUPDNMP+Qrjtk6c=;
        b=qRIqM2kWsIsHCQTrQAlqZciEm1PI2SYvSsGqXDSOt+aF0fzKjxFR2mIsnWz9PwQL3w
         bTCKMA/RoOmuTe04CoAZXe8cYwqHmw20x1nNjoRFlurq4kB0TwYahdCeBFPFygSchyKa
         NZxndGGwV+ATMoEBWwCuZkGPMkscb/LKBbtmLyycTwFNKiIqdtXULUW+I+XFuhRXLcnF
         6ZnEtt8O5cQTZOz0E2yJGPhDivZY3v0TaLbfih6oCYlCToivbU+UiFOWo/Peebert6at
         k0T6O8ywLHqL8bCCWiDwY8V6n9b6HHwelGVKtoAMJ9FzK4DPcgd3XpbSPktE7cjmVpCf
         hBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006212; x=1712611012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7IJ6bTDAFU3LIbdvbyl4a/Q/nTpdUPDNMP+Qrjtk6c=;
        b=ebLmATsnfEXSS/huac4RsQiF4QLZx2cXjvcY5OGjye4LZgP/Jx52+MJ2CHji3WZJQY
         d9uQwS2ku/4OyI12LjVI3rejDu2v0eKb2nfOKqe/507Oks3LopJJnWfdvASYkuN/I1Gk
         6iaZBi8/Vt6EA/8GYwlt96G+n30+G4VQurcC545MW6h0qepra3KlMROgfxSDjUeKVMEo
         aZAG0QKJxGrnu5+Am5GsWvBwraJCB81DCEXqSbjQ48z4FLlYNHJeLSp8w4DpI1YtN7lh
         wMV7DDMgOo1eQ/35tV7RvOBHL7RyfC/1odUnZpf1wDtdQqD0kF7uv0KyOd78fgDpzwX1
         f3iA==
X-Forwarded-Encrypted: i=1; AJvYcCUYXtV5B7d1qHmk3WAnPjz0uwvWU9f/3SiYRxS6TXJ9bSeDGPF+WOFYkRpglxGvPTgMhok3/WnkxUxQpOEwVEH/lwu9DUXf4cxlDCi6
X-Gm-Message-State: AOJu0YwAzvbncqdMYjeFj7qjIxPhDZtJWc7DSw5YLGfgBfsBEkxL7crg
	oA3nTfGotpUsDRx8nY0FVRhvw3PzubkDTE/qaDIdordqBlWtbRRfmO+etowhxtjzNASCLnGKsnO
	LzVyMQyX42Hm6OpnycutSFDNthnF5nnA1GfsOlQ==
X-Google-Smtp-Source: AGHT+IF+zrcKfWk2kOPKYiAPiiHaME+SrZnrnzl8M8MqT2GbO3PJ/dSLjODI5cHAlocFRGgyaRTtIScCdWLP55GgbLg=
X-Received: by 2002:a2e:9157:0:b0:2d6:a73f:234e with SMTP id
 q23-20020a2e9157000000b002d6a73f234emr8122196ljg.11.1712006212189; Mon, 01
 Apr 2024 14:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
In-Reply-To: <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 16:16:40 -0500
Message-ID: <CAMknhBGVuMSg+OpS5QTLWi9vA=Xa33AJ+cVS8ZCDyKsAVEe-ww@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:37=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >
> > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >
> > Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
> >
> > AD411x family ADCs support a VCOM pin, dedicated for single-ended usage=
.
> > AD4111/AD4112 support current channels, usage is implemented by
> >  specifying channel reg values bigger than 15.
> >
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > ---

..

> > @@ -125,10 +141,19 @@ patternProperties:
> >
> >      properties:
> >        reg:
> > +        description:
> > +          Reg values 16-19 are only permitted for ad4111/ad4112 curren=
t channels.
> >          minimum: 0
> > -        maximum: 15
> > +        maximum: 19
>
> This looks wrong. Isn't reg describing the number of logical channels
> (# of channel config registers)?
>
> After reviewing the driver, I see that > 16 is used as a way of
> flagging current inputs, but still seems like the wrong way to do it.
> See suggestion below.
>
> >
> >        diff-channels:
> > +        description:
> > +          For using current channels specify only the positive channel=
.
> > +            (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <2 0>
>
> I find this a bit confusing since 2 is already VIN2 and 0 is already
> VIN0. I think it would make more sense to assign unique channel
> numbers individually to the negative and positive current inputs.
> Also, I think it makes sense to use the same numbers that the
> registers in the datasheet use (8 - 11 for negative and 12 to 15 for
> positive).
>
> So: (IIN2+, IIN2=E2=88=92) -> diff-channels =3D <13 10>

Thinking about this a bit more...

Since the current inputs have dedicated pins and aren't mix-and-match
with multiple valid wiring configurations like the voltage inputs, do
we even need to describe them in the devicetree?

In the driver, the current channels would just be hard-coded like the
temperature channel since there isn't any application-specific
variation.

