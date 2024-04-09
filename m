Return-Path: <linux-kernel+bounces-136152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F24A89D087
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D982824F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9770F5467A;
	Tue,  9 Apr 2024 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lntESCoi"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF35464A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712631256; cv=none; b=H/Vkb1H1z7dJABdDO1x/fkE3vhYdlVKXmcjjmfdHW3N7372qhAK3CRcoyqlbG3Y+knHKK+8S9ld+z1QEaDFWHDSf0iVkOBAJLavfW4Zkf8xc1MmCpwWzQOVScJLbFy8tNj9g44A6uyVQbW2/7dhKPMU+XzdLGlZlAddvz0PaXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712631256; c=relaxed/simple;
	bh=pwkxEx6Cpl4S6pKfT9Tv7amm9+UnSJQSrIhPM/QX4e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERjsaTnT9BvAijDGj1spsiZdbDJw81eHjXxoo6N6Zs/FjuRfV0r1Vc5mfd/nS6niJGikyTmDRvI0u7nAxRkLbFZcmJwIp0uTHOMCsUxLuI0xpIcf5iGeoadwXdWiY6qapmeNimSMRvFc5c9pZAisy4Aim+fanhb4HRgC0RtRwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lntESCoi; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d700beb60bso83038661fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712631252; x=1713236052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+KbxJNBdJ5Qx+spF3lWWzpc0KdOklFkXilWrtlAms0=;
        b=lntESCoir1SrvmLR+x5Y8dNvkmRALsuFo+Z8wZ+NwaPYeucTCbgYeoLhXNbl0Q6wFg
         mirb9EQ/2L2xPOGfaDGGr8jum5O8Uh06EcAYtJSY4aKYlFbyQJXjV9pdK1fJn5ijaU6X
         EilpJrSJeNvcBH9297/5xYRE+uUnrteARSQAheHFFKHrvGxY/AfBk2pf4dIiXrlm+u5N
         nQZi8yJKnI3UGCqFwgCj7WZUiFMhAQ4DjMBi1rIYbzxuSEZhhOGfxJsLsn3F5TYHkNX4
         x9lGdtYWtAMdX6Y9ajNcwE6H/BctWwJAvvW/TD9G/1UiEuqLMT9OgxJwlv0VFoj2QtPS
         MRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712631252; x=1713236052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+KbxJNBdJ5Qx+spF3lWWzpc0KdOklFkXilWrtlAms0=;
        b=P+DbDFJgpX6CQazuy6IuIMt2baxNmfErsdm2c3//hMA1zZSEBZiG29PDd6e1JbiS1v
         iDZJb698Kfeap+goGy2u3xj4fAGenIfN6kneOCN+cF7yt8Zm/poxRlctUZUT+RA+Jclp
         fnKhbAzf6zOf5PUSFEKDZWo9BV26/QbrwzJ7ol3hGygjYX4uZmn39wJOHKHT1+IKqpXl
         Grn3rfyWGz6/3sCnf0KazV+lAmW0xZBcAaz+UZhx3PIDTqCNh9SscNxjvia41jluLUfB
         51svB6yqEhYJIUL8lO6FU1g7Zw9VxmUt/mudmi2CDqEKqrbkYnRCwyjQhRMFI/tLeCik
         fyvA==
X-Forwarded-Encrypted: i=1; AJvYcCUiI69w1sshWOs5kai0ZtDKJPigjX4Swf2MLFd+BkmvxFlPcB5IyEacFK+bxyoO9WD7dcIGIVF4FB9xZK8P6p4pVwBssiQFev6Cr5TE
X-Gm-Message-State: AOJu0YzAlsRNfQiMk0+2dxUQR6rtPuvqYTsInyAIMii0mYuIc+ucdPno
	yPHJH+nUKdVypw9jaryla5ECqT3IvleHKcE5Tmmcx6Ak+p093HgXiXWYs3AiVrGJGQvKUF7H281
	1rKn2EzCztlKoLzEZqyTqan1mc0/61d1rXuPevg==
X-Google-Smtp-Source: AGHT+IEj5sghCEmy0WmmzGc2UBYrG2TOAQp5CUK2H67k7mD/5JQX8nsuDutKBMYh/6xAmS89SPwJj5GMSO+9ZHnmh8w=
X-Received: by 2002:a05:651c:153:b0:2d8:3ccc:60e8 with SMTP id
 c19-20020a05651c015300b002d83ccc60e8mr9404459ljd.48.1712631251643; Mon, 08
 Apr 2024 19:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
In-Reply-To: <cover.1712585500.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 8 Apr 2024 21:54:00 -0500
Message-ID: <CAMknhBFoX9mC3F43GSmYZyET9oQvHEB+AAsesZv-aEgFPZPA_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for AD4000 series
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:31=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> This is more like an RFC patch set since configuration read/write is curr=
ently
> buggy.
>
> Change log v1 -> v2:
> - Took device tree provided by David.
> - Dropped ABI additions in favor of device tree properties.
> - Set differential IIO channel subtype for differential ADCs.
> - Set scan_type shift bits to mask out correct real bits from buffer.
> - Added __aligned(8) to buffer timestamp.
> - Used union to reduce buffer memory usage for 16-bit devices.
> - Used SPI transfer functions rather than SPI message.
> - Used c99 style structure initialization.
> - Used iio_device_claim_direct_scoped().
> - Removed unneeded pointer casts.
> - Added other power supplies (VDD and VIO).
>
> Link to v1: https://lore.kernel.org/linux-iio/cover.1711131830.git.marcel=
o.schmitt@analog.com/
>
> Additional topics:
>
> - Why there is no different handling for the different SPI wiring modes?
> It looks like there is no need for different handling of "4-wire" and "3-=
wire"
> modes.
> If in "4-wire" (dt default mode), SDI is connected to SPI controller CS a=
nd
> CNV is active high. We can activate the CNV GPIO then let the SPI control=
ler
> bring CS (connected to SDI) down when starting the transfer.
> If in "3-wire" (dt single mode), if we have a CNV (active low) GPIO we ac=
tivate
> it and then proceed with with the transfer. If controller CS is connected=
 to
> CNV it works the same way.
> I'm thinking it's better if we can support these devices in similar way
> other SPI ADCs are supported. Does that make sense?

In the AD7944 driver, I handled the "3-wire" mode separately because
the sample conversion is triggered on the rising edge of the CNV line.
In "4-wire" mode, since we have a GPIO connected to CNV, we can just
toggle the GPIO from low to high, wait for the conversion time
(t_CONV) and then read the sample (SPI xfer) then toggle the CNV line
low again. In 3-wire mode, the CS line is connected to the CNV pin, so
in order to get an up-to-date sample, we need to to toggle the CS line
from low to high to trigger a conversion (spi xfer with no data, only
delay), then wait for the conversion time, then read the sample (2nd
spi xfer). So in "4-wire" mode, the CS line is getting toggled once
per sample, but in "3-wire" mode, it is getting toggled twice per
sample. I didn't add support for "3-wire" mode where CNV is connected
to GPIO because we can't get max sample rate that way and it is
unusual to not have CS connected to something. But if we do that here,
the timing has to be different from 4-wire mode in order to not get
stale data.

> To me, the "3-wire" mode with controller CS to ADC CNV is what most resem=
bles
> conventional SPI. The only important distinction is that the
> controller must be able to keep ADC SDI line high during conversions.
> Although, while the spi-engine implementation provided to me can keep SDI=
 up
> during conversions, I'm not sure its a thing all SPI controllers can do.
> I tried a raspberry pi 4 some time ago and it was leaving the SDI line lo=
w if
> no tx buffer was provided. Even with a tx full of 1s the controller would
> bring SDI down between each 8 bits of transfer.

This is a good point. It sounds like additional bindings are needed to
describe the various wiring cases of the SDI line.

It sounds like possibilities are:

1. SDI is hard-wired high -> can't write to registers, CNV is
connected to SPI controller CS, chip is in "3-wire" mode. Currently
adi,spi-mode=3D"single"
2. SDI is connected to SDO of another chip, SDI of last chip is
hard-wired low -> can't write to registers, CNV is connected to SPI
controller CS, chips are in daisy chain mode. Currently
adi,spi-mode=3D"chain"
3. SDI is connected to SPI controller CS -> can't write registers,
chip can operate in 4-wire mode with CNV connected to GPIO, Currently
adi,spi-mode omitted.
4. SDI is connected to SPI controller SDO -> can write registers, and
support all writing modes (3-wire, 4-wire, daisy chain) as long as SPI
controller SDO line can be kept high or low at the appropriate time.
Currently not handled.
5. There could be a pin mux that switches between the one of the first
three and the 4th option (needed to avoid the issue with SPI
controller not being able to place the SDI pin in the correct state
during conversion trigger as described above).

On AD7944, the proposed adi,spi-mode property was sufficient to
describe what was wired to the SDI pin because we only had the first 3
options (the AD7944 doesn't have SPI registers to write to).

Also see related comments in my reply to the DT bindings patch.

(From the complete bindings point of view, we should probably also
consider the possibility of variations of 1. and 2. where CS of the
SPI controller is not wired and CNV is connected to a GPIO - this can
be determined by the combination of the adi,spi-mode property and the
presence or absence of the cnv-gpios property.)

> Anyway, single-shot and buffered reads work with the spi-engine controlle=
r
> with ADC in "3-wire"/single mode with controller CS line connected to ADC=
 CNV
> pin which is how I've been testing it.

Technically, yes data can be captured in "3-wire" mode with a single
CS toggle, but then the data is stale and doesn't correspond to the
soft timestamp because it is reading the data from the previous
conversion triggered by the last SPI xfer, whenever that was. Since it
is trivial to avoid this by adding the extra CS/CNV toggle I describe
above, I don't see any reason not to.

But the way the driver is written now, it is actually only supporting
the unnamed wiring option 4 from above, so now I understand the
confusion about 3-wire vs. 4-wire mode in that context.

>
> - Why did not make vref regulator optional?
> Other SAR ADCs I've seen needed a voltage reference otherwise they simply
> could not provide any reasonable readings. Isn't it preferable to fail ra=
ther
> than having a device that can't provide reliable data?

In the device tree bindings, making vref-supply required makes sense
since there is no internal reference.  In the driver, as discussed in
V1, it will fail if vref-supply in regulator_get_voltage() if
vref-supply is missing and we use devm_regulator_get() instead of
devm_regulator_get_optional(). So leaving it as-is is fine. We have a
plan to clean this up later anyway.

>
> - Why did not split into AD and ADAQ patches?
> The main difference between AD and ADAQ is the amplifier in front of the =
ADC.
> If only supporting AD, we could probably avoid the scale table since it w=
ould
> only have two possible values per ADC. But then the handling of span comp=
ression
> scale would need refactoring to be in the scale table when adding ADAQ.
> I'm not excited to implement something knowing it will need rework in the
> following patch. Will do if required.

If it isn't that much work, it seems worth it to me. If the driver
work is too much, maybe just split the DT patch?

>
> - Span compression and offset.
> For non-differential ADCs, enabling the span compression requires an inpu=
t offset.
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets=
/AD4000-4004-4008.pdf
> page 18
> and
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets=
/ad4002-4006-4010.pdf
> page 19
> I updated the _offset attribute for those ADCs according to span compress=
ion
> being enabled or not. Is it okay to have an attribute update cause an upd=
ate to
> another one?
> Maybe also make the span compression a dt property and have it fixed afte=
r probe?

This doesn't sound like something that belongs in DT since it doesn't
depend on the physical properties of what is wired to the input.

But the fact that offset should not be read until after scale is set
sounds like a quirk that would be worth documenting in some
chip-specific docs.

>
> - Configuration register
> Despite it doing single-shot and buffered captures, read and writes to th=
e
> configuration register are currently buggy. It is as if the register was
> "floating". I tried setting up buffers like ad7768-1, adxl355_core, bma22=
0_spi,
> bma400_core, and mcp3911.

If the ADC CNV pin is connected to a GPIO and the ADC SDI pin is
connected to SDO of the SPI controller, then nothing is connected to
CS of the SPI controller, so that might be the problem.

>
>
> Thanks,
> Marcelo
>
> Marcelo Schmitt (2):
>   dt-bindings: iio: adc: Add AD4000
>   iio: adc: Add support for AD4000
>
>  .../bindings/iio/adc/adi,ad4000.yaml          | 201 ++++++
>  MAINTAINERS                                   |   8 +
>  drivers/iio/adc/Kconfig                       |  12 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ad4000.c                      | 649 ++++++++++++++++++
>  5 files changed, 871 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.=
yaml
>  create mode 100644 drivers/iio/adc/ad4000.c
>
> --
> 2.43.0
>
>

