Return-Path: <linux-kernel+bounces-2887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 550B68163B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398CF1C21DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252677FB;
	Mon, 18 Dec 2023 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ikvwBDZU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4E369
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc6eecd319so5955741fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702858245; x=1703463045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCr0Y7VbGfJGw5U5BlcbXbCntBUQs/Yx4Y2eOI9HhnY=;
        b=ikvwBDZU9BNUVYlGYzozmS+xfcfOB7Idoa34m2i8DxP6nkPqznEA1eLFaOhfet2QQz
         uqwQasocBUxwi/jMzA5alJ2gdfVY3RIKmxRZre6zZqB8FDxqlrITY4UshxTBxPeRY+WQ
         5iAcqf2+L2jw7Sq17WmGqh+BCIiSBEVDUueXHu0fmOLXX2w+VdWTUuDghV/WlyR0cpsc
         DdK9pYbTAHZG33P+T3j8kHoqJSiqNocQcBIxMX0wmKZO7qnkhQCK7qHgSsZi9QzG8e2i
         4P0jPV3Mp1hxFTiFITo+QpaRcsd4WFD/XJdICFZ1YD4kIz6GrdEUD0mMiuHXHIZzNgFi
         LeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702858245; x=1703463045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCr0Y7VbGfJGw5U5BlcbXbCntBUQs/Yx4Y2eOI9HhnY=;
        b=B0TuZg4xdpvnNOXLSNLGX8bwynwi+RZv8kaFGSQRSLjWNp9zsqdyrdeXqU/8OcQ4+L
         oEdylNRnhQxqjtbpmv8UQJtsclRakfJJBhOGX98v6n7A6tPMstCK5nvMjrWiqMLx9mtB
         WXOgThSfvxGrZ1DU878vgnyEJt8DGN2puu2ihh/rvgRzbxbXeVP/5Z4yjgsKYlYPN3hV
         GYlrct+PXaTtjp9tJO9zK1M26v1mxRs9OeijIMu8SaX/30ozjPE9vmKhDETxSS8fKsOA
         kc3KSI8KNq7Yxvxo1Z0vOMXIK+fvTX6JbxW4eQHUniKY4PTTEr4eGEuUTt23GAwgv+ZE
         1tAg==
X-Gm-Message-State: AOJu0YwKkO/fjeoLsSNDJ/g30hOi09PPFyOOnKXz1lsT1v6ydmMTjmNN
	CNKW/b6NYnmJIG7lEfq0cew1jSt0Kpx9pvB+GrwFbg==
X-Google-Smtp-Source: AGHT+IHpVBWLFSjtRVR52hFowPda7Jm/LMpVEhB13//jIATDmpERvlCsW3LtP9Nipj8n/Rh12fU83uu/WiHYxY9UBkM=
X-Received: by 2002:a2e:99d4:0:b0:2cc:6dde:b9bc with SMTP id
 l20-20020a2e99d4000000b002cc6ddeb9bcmr538149ljj.0.1702858245114; Sun, 17 Dec
 2023 16:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
 <24a9f1bb721e66df65e36797b0c3fd2ca1f95227.1702746240.git.marcelo.schmitt1@gmail.com>
 <CAMknhBFQ9APUAMA8nEwTJ0nhARwcD=hCcAB9HKrQ8g9qANqveA@mail.gmail.com>
In-Reply-To: <CAMknhBFQ9APUAMA8nEwTJ0nhARwcD=hCcAB9HKrQ8g9qANqveA@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 Dec 2023 18:10:34 -0600
Message-ID: <CAMknhBF92vcoHakYYP-7JeYhQtz2-5008XJUBFO11vXZPjsdJw@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] iio: adc: ad7091r: Allow users to configure
 device events
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com, 
	lukas.bulwahn@gmail.com, paul.cercueil@analog.com, 
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dan.carpenter@linaro.org, marcelo.schmitt1@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 5:58=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Sat, Dec 16, 2023 at 11:52=E2=80=AFAM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > Implement event configuration callbacks allowing users to read/write
> > event thresholds and enable/disable event generation.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > This is from a review suggestion David made on v3 [1].
> >
> > Is this the case for a Suggested-by tag?
> >
> > [1]: https://lore.kernel.org/linux-iio/CAMknhBFPbAqp4-AQdmbp+VRW-Ksk1Px=
aLCG+3n=3DZk4gyStqhgw@mail.gmail.com/#t
> >
>
> I suppose it fits the definition of Suggested-by well enough and would
> be appreciated. Even more so on [PATCH v4 02/15] "iio: adc: ad7091r:
> Pass iio_dev to event handler".

And it seems like this should have the Fixes tag since this is fixing
a null pointer dereference. And the commit message should describe the
problem and that this as a fix, otherwise it sounds like we are just
adding a new feature here.

