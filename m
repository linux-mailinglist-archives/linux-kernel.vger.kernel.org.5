Return-Path: <linux-kernel+bounces-106150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19F87E9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D776EB21523
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC838DEF;
	Mon, 18 Mar 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBG2Zh7c"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040C33CF1;
	Mon, 18 Mar 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767412; cv=none; b=kbU0HsvHrEmFEUiGJUHK0kL8oaRgHh6Tz3EYgbQUAgcoLwBNxOPWhPEK5XlXHTUcNfulsLTHnqLa6ZUzn1LZS1D0iijZCc72N4O3kTsdXF8tVyDbUPfc7DebeFQiXFuv31I6cTiWDkWZcGod05q8LZctUBGArK5vwQi7MgatLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767412; c=relaxed/simple;
	bh=mE7jqQ5jElAIH2bMnT6FZSF2mEu0TvZtFmmRGoCQkIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYRFW7k8iY7NBrUAFy4PbJMWELVg1RgdIZ3VZOCV1kbG3ExGb0yCPfg0apRNLrOgTrYIResBGAs0WB0jEn0gnuWnuIxXZJOLtcrs4f3AbImKZo0CAf/7nE2D6sTbqlk2BReBV5zwpSVJxujfepTV6Lar2ert4TYmunwMz64THfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBG2Zh7c; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso7382559e87.1;
        Mon, 18 Mar 2024 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710767409; x=1711372209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBZLCMh0SA3DZ15OEaT+twgEPYQm8UQNknXIM0mZma4=;
        b=YBG2Zh7cY4mWWeDrAxplk7Z5+X8KpgJsLEbwyv4xuNYUhl81b1Uk9kA58IsZGQrmd9
         /JTJ1hJYML+4Yj23I62Xrt+IBWP+r7nQUX4Pwi+tXSkX8Bhwj7dax3bwcFo/awsyVnZu
         lbPrsPs2N/CO/qHQRNgL46uR8O5h9e827WeTavw5Y3lZjkENnNzH7TM+HQ7wmu1MvGfF
         flznr7EZLHdZoPB0ZgqD+VdQ56WnqOgYj7gQd+NKUSbxxQ/z9WvJ6klk+U/Apz+Ehm75
         cCspk3fcNzdn5LcbdVdOeBdnKJtZlDBZIn5+/fkJcxnEnfVB+FwYmP6XGrOH0AV8ZHQb
         OhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710767409; x=1711372209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBZLCMh0SA3DZ15OEaT+twgEPYQm8UQNknXIM0mZma4=;
        b=kX30hqWaDojMXPKePIl8I0IFlg+zGVeLg1Qx8zNciAjf7sTUsioh5dbq39v+1IwXTC
         UTawTTY8eIyYOgemvxo9ESRZk9L+p8InRWzXAXPSHAkaEZ7JwV/S2hqtEKIASzFmF1NC
         EoiChpcc6RsY/jMLlgBpUUjelGLzlLO7wbsGVvim06vF2MO/u8n7ZVV65bllemkyVt8m
         shIE45CWugIl/pJ3pHS0hHW9CjHi4ISkpwxiWMx2RzNMiDGBAFYPQTdpbEDfa7waW9YK
         D1hqiS7oG0v5XASRSEfdaYqnOybpd5N/RGZE0RWHrAGfA3zQgIa6gePHN0c7YElakMr0
         +ZEA==
X-Forwarded-Encrypted: i=1; AJvYcCW2//QYT16ab5PpQ3SzXSagT3Q/dMZbkFfei6BaqS9/Ebx3sA4iXAOzdPyzgrhLxHu6hCvy0+IUZptPOATtAkvAMbLU5BCuEGZ3kEkvWSMP8ASYyq+y9DYplXqanWws8MoCby7mEoMN
X-Gm-Message-State: AOJu0Yz+7LK1t/+3CsEv0DoCSM1+b++M99lZkszJdca6ee7blr78v+0r
	BXtyAqAyejnaTk5AKpCJ74CiUyMjE5n4Yly++dlGPuoWS8W+9jwTXQJ4Fysl8pr4u9untGF5z6e
	3NXx5hqoi/5iIWbR78vyTyLppZO8=
X-Google-Smtp-Source: AGHT+IGLMWALI01ckCqs4+f3ML0k0Gp83dbLOhxzM6RvJU2rs4Ord/rFMnwPmqWS9EGUNEOIM2sADJZaDFAzykB43hY=
X-Received: by 2002:a05:6512:2394:b0:513:e348:fbc0 with SMTP id
 c20-20020a056512239400b00513e348fbc0mr5826916lfv.20.1710767409038; Mon, 18
 Mar 2024 06:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
 <ZfX5jynjW4M9pvw1@surfacebook.localdomain> <20240318124041.0000032d@Huawei.com>
In-Reply-To: <20240318124041.0000032d@Huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Mar 2024 15:09:32 +0200
Message-ID: <CAHp75VeQcvuEy4V6-+3PeWTZJ9=Qae0AiiNB93OOw3wuc-uh3A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:41=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> > >  struct ad7944_adc {
> > >     struct spi_device *spi;
> > > +   enum ad7944_spi_mode spi_mode;
> > >     /* Chip-specific timing specifications. */
> > >     const struct ad7944_timing_spec *timing_spec;
> > >     /* GPIO connected to CNV pin. */
> > > @@ -58,6 +75,9 @@ struct ad7944_adc {
> > >      } sample __aligned(IIO_DMA_MINALIGN);
> > >  };
> >
> > Have you run `pahole` to see if there is a better place for a new membe=
r?
>
> I know this matters for structures where we see lots of them, but do we a=
ctually
> care for one offs?  Whilst it doesn't matter here I'd focus much more
> on readability and like parameter grouping for cases like this than wasti=
ng
> a few bytes.

This is _also_ true, but think more about cache line contamination.
Even not-so-important bytes may decrease the performance. In some
cases it's tolerable, in some it is not (high-speed ADC). In general I
assume that the developer has to understand many aspects of the
software and cache line contamination may be last but definitely not
least.

--=20
With Best Regards,
Andy Shevchenko

