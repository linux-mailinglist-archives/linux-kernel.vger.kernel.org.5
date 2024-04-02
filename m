Return-Path: <linux-kernel+bounces-128090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED08955FE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D121C1C22568
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A585277;
	Tue,  2 Apr 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RpaHx4tC"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5982893
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066425; cv=none; b=SXEaslHtrYl+Q6YEo83H6WNURD7TOt6/6ODojegdTcolvWTbK5as2GxtcoPP0Gfsy4CeKuYlDzN+0iYRRLQDqNTHbQBx+tT2MYW/DYw7eDwW+MS6V/y/lzLGgeQTCMrIKFCISZGda69DZOF/gcaEumbkxlMGobJ0s5p4owONxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066425; c=relaxed/simple;
	bh=zQsUVohe62XDCv8RPmVhbR0HOvcb2ANjyDfd2BTRSTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQMGQ3rle+rRgw9JmYXuOu45s7b+oQIWroB/3rUIqLFGJS4P7u+IlxzqIdR98WdQztEjaDy0eSmGpC4DtzuoNQjIQdbBPNFe4pqLjRtE/O+HwrYqdSFw0PTH+dBbetlpU443gqUje1mKJOEBOo5cPXwLXGlon4BLHazomUUQxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RpaHx4tC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d82713f473so17418421fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712066421; x=1712671221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rDbZVm/05+TD8i00zno4F1FPbK9cGt0EA7D+/0NFvM=;
        b=RpaHx4tCJ3BDi1LLkthbtY6JG/Zklfc19v14leIe4bGroL1Y29/a9k9R3ZdmD7pZ0n
         U6Nnp5IqS6lJ6H93XpfLsjwovzdOG1INNTRZu5tXeyg7oRqAeDQxOqrqzXDrDFZMGXBy
         bZsytrh2FxMjzozGNVEgEUQskkDZ94Mj4oH01DybFJVEk1eSJe8GOwSTFN7JpL9UoI0d
         ZviYNMcovL0sRChW5cDxNzEsEgwTCAmIXqpDYldWUC/OkDYNEPcmZID9V62HLvAKHmVR
         X6V7S0brqQS+Q9gDrsR6MCSxuO37S0fbquuAsNnfw39Jgpu+okcAt8VQwdK6VmFEHfr9
         h27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066421; x=1712671221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rDbZVm/05+TD8i00zno4F1FPbK9cGt0EA7D+/0NFvM=;
        b=TSSE3sJvkfeKEss4XKzfxZrm7r4Y6pgTW3GeBk8jubaBpBT3RkVAaWGCXXpcDzUxYL
         t6FmcdkNTWYCawG/uulNYJtqi5K6/SvCtLX9j4FtYU1H2UgeTA5LKqfhECxjCUfYw/Bz
         sm50lZm5se/da99o6W8IEcMe3nl7hbFjkv+dSvpGRH2rwlEFR/cbjxsRsukOWrLpCHRZ
         9HrBIMJLwENdkrTES3yB8CCIxPSgJSjbwWMg+hK8hWMwhhN0NqnF9KZNnXz9e/ViDckY
         K4PllDIMzm3pQOvtAof7qLbv0QD3zOkHkL6FhVJfB9LV+QbZoy+tPmhSq6ecYrwBrYWq
         LNoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKQohbD35h/1CDYHoTXTrVaXGQwViSvW3Xr2LFIqe/H2VZmJkg5Wd9fBXIWi4qv+ms2+dYgEYGSVm0W3m+5Y+BM2RxdstOodZGEzqL
X-Gm-Message-State: AOJu0Ywxl79Tpz64zaJ8Hz6u/rRZTYUvQboI6KQ/g9x7uFIepPMoiwV2
	98uZuBIO4lik30eSujwnKNu9VtLoViwluRCNcbv6F8WgGGKZbTmB1RwfefBwidUPsRLASW5dsbx
	QN088a/Yl67IUKlLuwFwEj2sMm5MtB8V4sjQKGg==
X-Google-Smtp-Source: AGHT+IHCFlw3ou3Ij39/rVMdq0w422umliw3LKcflbCanJZ8AoG55GlMVztIqNJgFjjdkFnQ5BoSu74kXlmLHaTCgpw=
X-Received: by 2002:a2e:8049:0:b0:2d6:8868:f1a6 with SMTP id
 p9-20020a2e8049000000b002d68868f1a6mr1601468ljg.43.1712066421456; Tue, 02 Apr
 2024 07:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-6-34618a9cc502@analog.com>
 <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
In-Reply-To: <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 2 Apr 2024 09:00:10 -0500
Message-ID: <CAMknhBHf_9kFfLySJmRyoUS6UFfTeLW3bfEi1-3ApEDHyyVhCw@mail.gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:45=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >
> > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >
> > Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
> >

..

> > @@ -1028,15 +1204,22 @@ static int ad7173_fw_parse_channel_config(struc=
t iio_dev *indio_dev)
> >                 *chan =3D ad7173_channel_template;
> >                 chan->address =3D chan_index;
> >                 chan->scan_index =3D chan_index;
> > -               chan->channel =3D ain[0];
> > -               chan->channel2 =3D ain[1];
> > -               chan->differential =3D true;
> >
> > -               chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0], ain[1])=
;
> > +               if (reg >=3D AD4111_CURRENT_CHAN_CUTOFF) {
> > +                       chan->type =3D IIO_CURRENT;
> > +                       chan->channel =3D ain[0];
> > +                       chan_st_priv->ain =3D ad4111_current_channel_co=
nfig[ain[0]];
> > +               } else {
> > +                       chan->channel =3D ain[0];
> > +                       chan->channel2 =3D ain[1];
> > +                       chan->differential =3D true;
>
> Expecting chan->differential =3D false when ADCIN15 is configured for
> pseudo-differential inputs.
>
> Also, perhaps missed in previous reviews, I would expect
> chan->differential =3D false when channels are used as single-ended.
>

After sleeping on it, I came to the concision that these parts are
probably too complex to try to worry about differential vs.
pseudo-differential/single-ended (what the datasheet calls
single-ended is really pseudo-differential).

So I take back my comments about expecting differential =3D false in those =
cases.

