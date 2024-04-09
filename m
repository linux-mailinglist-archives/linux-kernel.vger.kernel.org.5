Return-Path: <linux-kernel+bounces-137140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB689DD6E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04412847C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E253412FB3C;
	Tue,  9 Apr 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncQ1Bo6N"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E7D8287F;
	Tue,  9 Apr 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674765; cv=none; b=Evfrje+QYD1x/Zd4HNE/Jc7/J0+hjh8Yuxf4+2D/clApGpTMI4s8W+9AT1BlrM7AVafRCPyPkkh+bkmZgYcawvXdgJA1HAdrsfRXvjQDIVyEOQi9Ith3mBPVe1iFzTleB5AKsASJIdlNIfIvsfFO9Qvx8ESDPcEq91a/B7oPJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674765; c=relaxed/simple;
	bh=ghbt7J76GObZfOc/so0lWVDbmd77SxyNIwrf+csWJ78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akZrzTnqPKP0OMNMsmI2mMGhh9OjmrUtYhoIZRuYzDcWPv/Py18n1xq0ChJphYSi/6vf6062mb/Ky1XQQEOTFG7IJUQHuvfutB9c5hERPoP3ybPBr+x6JRAT619gpj8MWVrIKEkfdzQ8l0y50IW6RqoY87t7JRDzJrGAF9genho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncQ1Bo6N; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so2738330b3a.0;
        Tue, 09 Apr 2024 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712674763; x=1713279563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5AuUL4pSD0wMDkDcnhb6nETxJAyPjCIFWXNIkuS40i0=;
        b=ncQ1Bo6Ny64YYqOdPvVf45amgiU9QhujE+OtnOl8r86avhvx78WPM9tjg9U1SpbVtW
         TQH4odaT4ijrxUMOJ8XWV8i3tzYXbl9TeO3gOMRbp2XdFL+GMCc679VoxTIbEmAck/A5
         EIJlC9R0o+89j16j3zL6hDOe5iSM++xQtvWkZla011vU0pqoF7dkDpOpjfLPUgCWm3KJ
         f+FYczfcyP3Ep94N9QjaV9RJgscUqat+xDc38T+OhlMx2ezmSz1uaI8Tp80uzOFcYGaS
         8M5pjGwXS9o3Ft23ZqynOFrw+b+mABZ8TJz5A6HTJQJKHSo74V8oYJIl4ag3RM3hjY4d
         rd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674763; x=1713279563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AuUL4pSD0wMDkDcnhb6nETxJAyPjCIFWXNIkuS40i0=;
        b=H3VRzZHS715ESMt3pS6u+zesAcXZEKJn86+mXy1RqD31ORJGxvwIjyncQIVwgol/8m
         eRbVtqxmJYPJ3bqU0Apan2PVywaPYUPLMEqUKKqs5Bo0Yfnk2AYU/u5L6JfsOYXzedBG
         Qi4a4bxLGgwMueo3g/+cBornmw0iYv9PSNHl4Knn5zEIl8xfniKFLHC3xpTnC0ZFgKkP
         RHonFwr3guaGIKJR24pAodl/TgUEl5awDfvOTaSbdYQFoGwQsdCwpEI8tS1USQNlDKKq
         6sR5e3m00qKVFqhpQcVP/b0uLo0498K+d7LdaoqmdQ5lE1HrYI4XOsfOoQgZY5xZKxtq
         DJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPHmD3vFVYfcHDJ9BkYYtZhshqURfv0wB1+UmdCHXGzGOA0AIDHHiMRKB2dZBF4EMv1dLaAe2odkAT/QWELtfW4pQMwzKwGyxgswO+Fo+zhl3eX7D7WzqIDX4z73PU5GXqHWksbNQ3c3XJMvSM7L7gWev3JyjFhxcx3yRb7LCRqRQdVw==
X-Gm-Message-State: AOJu0Yw9cpgRhCBoHUH+K2N2g3hG3grPWmqkmjmv+ieEo85tnItfFIz7
	UzbhqzjL0aT/6HAAL3C2N9mGrTir1ew0eqrZgVg1f4I5LTAB4cSjqA1g9n5Fg5U=
X-Google-Smtp-Source: AGHT+IGJrZpOJFeEBzuIlOFbPo0g7gIRbQHqc6GAH/7O9A0MSNXReOHvckU4QL4LdqA58nAKUUHLPg==
X-Received: by 2002:a05:6a21:8805:b0:1a3:648e:dacf with SMTP id ta5-20020a056a21880500b001a3648edacfmr67261pzc.35.1712674763183;
        Tue, 09 Apr 2024 07:59:23 -0700 (PDT)
Received: from localhost ([2804:30c:1618:ed00:d152:440c:102b:144e])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001e3f1596baasm5590073plg.298.2024.04.09.07.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:59:22 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:59:59 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add support for AD4000 series
Message-ID: <ZhVX76dVt-TrC0NX@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
 <CAMknhBFoX9mC3F43GSmYZyET9oQvHEB+AAsesZv-aEgFPZPA_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBFoX9mC3F43GSmYZyET9oQvHEB+AAsesZv-aEgFPZPA_w@mail.gmail.com>

On 04/08, David Lechner wrote:
> On Mon, Apr 8, 2024 at 9:31 AM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > This is more like an RFC patch set since configuration read/write is currently
> > buggy.
> >
> > Change log v1 -> v2:
> > - Took device tree provided by David.
> > - Dropped ABI additions in favor of device tree properties.
> > - Set differential IIO channel subtype for differential ADCs.
> > - Set scan_type shift bits to mask out correct real bits from buffer.
> > - Added __aligned(8) to buffer timestamp.
> > - Used union to reduce buffer memory usage for 16-bit devices.
> > - Used SPI transfer functions rather than SPI message.
> > - Used c99 style structure initialization.
> > - Used iio_device_claim_direct_scoped().
> > - Removed unneeded pointer casts.
> > - Added other power supplies (VDD and VIO).
> >
> > Link to v1: https://lore.kernel.org/linux-iio/cover.1711131830.git.marcelo.schmitt@analog.com/
> >
> > Additional topics:
> >
> > - Why there is no different handling for the different SPI wiring modes?
> > It looks like there is no need for different handling of "4-wire" and "3-wire"
> > modes.
> > If in "4-wire" (dt default mode), SDI is connected to SPI controller CS and
> > CNV is active high. We can activate the CNV GPIO then let the SPI controller
> > bring CS (connected to SDI) down when starting the transfer.
> > If in "3-wire" (dt single mode), if we have a CNV (active low) GPIO we activate
> > it and then proceed with with the transfer. If controller CS is connected to
> > CNV it works the same way.
> > I'm thinking it's better if we can support these devices in similar way
> > other SPI ADCs are supported. Does that make sense?
> 
> In the AD7944 driver, I handled the "3-wire" mode separately because
> the sample conversion is triggered on the rising edge of the CNV line.
> In "4-wire" mode, since we have a GPIO connected to CNV, we can just
> toggle the GPIO from low to high, wait for the conversion time
> (t_CONV) and then read the sample (SPI xfer) then toggle the CNV line
> low again. In 3-wire mode, the CS line is connected to the CNV pin, so
> in order to get an up-to-date sample, we need to to toggle the CS line
> from low to high to trigger a conversion (spi xfer with no data, only
> delay), then wait for the conversion time, then read the sample (2nd
> spi xfer). So in "4-wire" mode, the CS line is getting toggled once
> per sample, but in "3-wire" mode, it is getting toggled twice per
> sample. I didn't add support for "3-wire" mode where CNV is connected
> to GPIO because we can't get max sample rate that way and it is
> unusual to not have CS connected to something. But if we do that here,
> the timing has to be different from 4-wire mode in order to not get
> stale data.

Yes, that's also the case for ad4000 series. The rising edge of CNV triggers
the conversion which causes a latency/delay of one read if CNV is connected
to a chip select.
I thought it was okay to just accept the latency since it's intrinsic to the
ADC start conversion on CNV rising edge and latency would be less noticeable
when doing continuous sampling.
Although, this indeed causes the timestamps to be disarranged, which is making me
rethink the implementation.
Yet, if we choose to have extra pulse of CNV for the sake of getting correct
timesamps, that might also impact performance for high sample rates (unless
split sample handling into different cases for single-shot and buffered readings).
I'll give it try and do it like ad7944.

> 
> > To me, the "3-wire" mode with controller CS to ADC CNV is what most resembles
> > conventional SPI. The only important distinction is that the
> > controller must be able to keep ADC SDI line high during conversions.
> > Although, while the spi-engine implementation provided to me can keep SDI up
> > during conversions, I'm not sure its a thing all SPI controllers can do.
> > I tried a raspberry pi 4 some time ago and it was leaving the SDI line low if
> > no tx buffer was provided. Even with a tx full of 1s the controller would
> > bring SDI down between each 8 bits of transfer.
> 
> This is a good point. It sounds like additional bindings are needed to
> describe the various wiring cases of the SDI line.
> 
> It sounds like possibilities are:
> 
> 1. SDI is hard-wired high -> can't write to registers, CNV is
> connected to SPI controller CS, chip is in "3-wire" mode. Currently
> adi,spi-mode="single"
> 2. SDI is connected to SDO of another chip, SDI of last chip is
> hard-wired low -> can't write to registers, CNV is connected to SPI
> controller CS, chips are in daisy chain mode. Currently
> adi,spi-mode="chain"
> 3. SDI is connected to SPI controller CS -> can't write registers,
> chip can operate in 4-wire mode with CNV connected to GPIO, Currently
> adi,spi-mode omitted.
> 4. SDI is connected to SPI controller SDO -> can write registers, and
> support all writing modes (3-wire, 4-wire, daisy chain) as long as SPI
> controller SDO line can be kept high or low at the appropriate time.
> Currently not handled.
> 5. There could be a pin mux that switches between the one of the first
> three and the 4th option (needed to avoid the issue with SPI
> controller not being able to place the SDI pin in the correct state
> during conversion trigger as described above).
> 
> On AD7944, the proposed adi,spi-mode property was sufficient to
> describe what was wired to the SDI pin because we only had the first 3
> options (the AD7944 doesn't have SPI registers to write to).
> 
> Also see related comments in my reply to the DT bindings patch.
> 
> (From the complete bindings point of view, we should probably also
> consider the possibility of variations of 1. and 2. where CS of the
> SPI controller is not wired and CNV is connected to a GPIO - this can
> be determined by the combination of the adi,spi-mode property and the
> presence or absence of the cnv-gpios property.)

This sounds reasonable to me. I also think the comments on DT patch are good.
Will comment there too.

> 
> > Anyway, single-shot and buffered reads work with the spi-engine controller
> > with ADC in "3-wire"/single mode with controller CS line connected to ADC CNV
> > pin which is how I've been testing it.
> 
> Technically, yes data can be captured in "3-wire" mode with a single
> CS toggle, but then the data is stale and doesn't correspond to the
> soft timestamp because it is reading the data from the previous
> conversion triggered by the last SPI xfer, whenever that was. Since it
> is trivial to avoid this by adding the extra CS/CNV toggle I describe
> above, I don't see any reason not to.

Okay, will make it do the extra pulse to CNV for "3-wire" mode.

> 
> But the way the driver is written now, it is actually only supporting
> the unnamed wiring option 4 from above, so now I understand the
> confusion about 3-wire vs. 4-wire mode in that context.
> 
> >
> > - Why did not make vref regulator optional?
> > Other SAR ADCs I've seen needed a voltage reference otherwise they simply
> > could not provide any reasonable readings. Isn't it preferable to fail rather
> > than having a device that can't provide reliable data?
> 
> In the device tree bindings, making vref-supply required makes sense
> since there is no internal reference.  In the driver, as discussed in
> V1, it will fail if vref-supply in regulator_get_voltage() if
> vref-supply is missing and we use devm_regulator_get() instead of
> devm_regulator_get_optional(). So leaving it as-is is fine. We have a
> plan to clean this up later anyway.
> 

Not sure I understand the idea here. Should the driver use
devm_regulator_get_optional() instead of devm_regulator_get() because
the optional call would fail immediately if no vref-supply while the regular
call would only fail at regulator_get_voltage()? Why? This looks very counter
intuitive to me.

> >
> > - Why did not split into AD and ADAQ patches?
> > The main difference between AD and ADAQ is the amplifier in front of the ADC.
> > If only supporting AD, we could probably avoid the scale table since it would
> > only have two possible values per ADC. But then the handling of span compression
> > scale would need refactoring to be in the scale table when adding ADAQ.
> > I'm not excited to implement something knowing it will need rework in the
> > following patch. Will do if required.
> 
> If it isn't that much work, it seems worth it to me. If the driver
> work is too much, maybe just split the DT patch?
> 
> >
> > - Span compression and offset.
> > For non-differential ADCs, enabling the span compression requires an input offset.
> > Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD4000-4004-4008.pdf
> > page 18
> > and
> > Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> > page 19
> > I updated the _offset attribute for those ADCs according to span compression
> > being enabled or not. Is it okay to have an attribute update cause an update to
> > another one?
> > Maybe also make the span compression a dt property and have it fixed after probe?
> 
> This doesn't sound like something that belongs in DT since it doesn't
> depend on the physical properties of what is wired to the input.
> 
> But the fact that offset should not be read until after scale is set
> sounds like a quirk that would be worth documenting in some
> chip-specific docs.
> 
> >
> > - Configuration register
> > Despite it doing single-shot and buffered captures, read and writes to the
> > configuration register are currently buggy. It is as if the register was
> > "floating". I tried setting up buffers like ad7768-1, adxl355_core, bma220_spi,
> > bma400_core, and mcp3911.
> 
> If the ADC CNV pin is connected to a GPIO and the ADC SDI pin is
> connected to SDO of the SPI controller, then nothing is connected to
> CS of the SPI controller, so that might be the problem.

ADC CNV is connected to controller CS and ADC SDI to controller SDO.
Think it's something to do with buffer alignment.
Will try the changes suggested in reply to driver patch.

> 
> >
> >
> > Thanks,
> > Marcelo
> >
> > Marcelo Schmitt (2):
> >   dt-bindings: iio: adc: Add AD4000
> >   iio: adc: Add support for AD4000
> >
> >  .../bindings/iio/adc/adi,ad4000.yaml          | 201 ++++++
> >  MAINTAINERS                                   |   8 +
> >  drivers/iio/adc/Kconfig                       |  12 +
> >  drivers/iio/adc/Makefile                      |   1 +
> >  drivers/iio/adc/ad4000.c                      | 649 ++++++++++++++++++
> >  5 files changed, 871 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> >  create mode 100644 drivers/iio/adc/ad4000.c
> >
> > --
> > 2.43.0
> >
> >

