Return-Path: <linux-kernel+bounces-166402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E68B9A1C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35F91F218A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FCD64CE9;
	Thu,  2 May 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/gfilYL"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123F5F874;
	Thu,  2 May 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649623; cv=none; b=LYYYOXvY6DcfmICjHkPfHrzxzw8qIkica6AaGnwK9yGzkNKNA+ufLaFkwiB0/QzmCzlPvvCXiJ2E/OaEc1f1D+2h/+Xcg9OKsT15ULf9yOOpbwP1uxQ1toijb69RRV7MDUH4DlN2SjykeFu6OW3WHQVceQbw/CCElla+QbrktoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649623; c=relaxed/simple;
	bh=828C0WgyTbwNe0djKFBFV2Y7mx8cfkSdpIPbRqgYMzc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KFOd6vN0dRG+JraL/yK6A3yZ/fvgy63mRU6I3+VXjakslTzgASYanmWxlkkoMWJkAJchXPXfFzpijGQGFZeBUwB9kb+ilGZwtQZHnvorOp8pRUbPzHoCcvEkFVdEjc6CM4RDquRs5Rpxy9hT0xuqD1MLK5yrEq4weVxr497l0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/gfilYL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a524ecaf215so993193466b.2;
        Thu, 02 May 2024 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714649619; x=1715254419; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4XkbyZH9AEVFqOZKD+ooyH80AZOW0j0s5dhJR3kkQGw=;
        b=l/gfilYLh6NTi4blYHxtFebo3X3xQq//C1/u1tZLON1yTEJ9ci6DOSB7eSlOFROBlm
         2wakCT9Br8+R0yvWODeMPiDIIYscAmtSynV2hfcyoBhVxQUN/pp0AhPaxtSDMivPoiF6
         Iqrz4YywjdO2wcPAsx4I8r6EIG7Q5HaYlrx7TRFNdFv80+GSfSyH/oIouc9/TWjgpJEc
         +W8vsWoS5bfqG7kb8Nbj9tOouPZcd8N4vd1qcLw4jHMfW0b8gf1Pnm+avUS4d8wMe+5s
         VuxI81Nm3jXvYsxyoC+g4yqefCRe2Q4E4X985iPaZ//KAuc3sYGYpowF4EyD180gSXCq
         09Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649619; x=1715254419;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XkbyZH9AEVFqOZKD+ooyH80AZOW0j0s5dhJR3kkQGw=;
        b=dKsA+Zzgw5CI2lL3tFS+v4kADwFWD8T+yxdL6MdN3MnK9xZ2FjRCAAYmjxkJpsWgkn
         oAJREBbR/NYC4i4p5bHpdGOMTvwI8vf9fCa1sH3TyLNjq+4e2mwwGanPTH+IjrCPzYKa
         V/DC7jWmaJW3XlyieOYRWYSvvLA7RJ9il+PyHhMz80p06XaE4sKqWoai5cVyCMGdbUQk
         S/jP/rzwaqWqaYL672AlSRo6+r6gvYh1ojjwYdaJJ3PmsLl4LNGvLq0+feadgehwwugn
         QuWE0tHtPoUyI0TV39zZjdcHk9WzgkTpJl1sDfGu0/eYhWSQjDEd4nF31WOpZXlHofg5
         y88w==
X-Forwarded-Encrypted: i=1; AJvYcCUputRXjuqjToQOUcWEHyq/RaqLvpIUr3fopIoZvzEa+dlL5slovS7ll8gkHCSHimKL1CTdPo6Ml0MA+X9Bs2KP6S/CPfWB0UfDngm5kARC0c8L/A03IseQCEXzg9GClOG57eejLQ1i
X-Gm-Message-State: AOJu0YzYLx9qhSXofZOwXlIeuuq+vVNllJ41h7tzKwhpWv7oaHF3rnqi
	DRqwn3Kj9Pu4NkOj/c3ZaxRaUBLIh8z6OWDKbRwZDGNhrYfse8zc
X-Google-Smtp-Source: AGHT+IHXZMuWESRYKuQOdp4YI2fvGLW/YunaIwJSOXHSxwQwt9/S1YrsQMuyCvSlN5ba//dAQKKz9g==
X-Received: by 2002:a17:906:c41a:b0:a59:8d7:21e6 with SMTP id u26-20020a170906c41a00b00a5908d721e6mr1115651ejz.70.1714649619221;
        Thu, 02 May 2024 04:33:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a17-20020a1709065f9100b00a58ca98bbfbsm460052eju.30.2024.05.02.04.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:33:38 -0700 (PDT)
Message-ID: <a17206389b075a30fc0b8536f982aae80ee62da5.camel@gmail.com>
Subject: Re: [PATCH v2 4/4] iio: common: scmi_iio: convert to dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, nuno.sa@analog.com
Cc: Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>, John
 Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Andi Shyti <andi.shyti@kernel.org>, Jyoti
 Bhayana <jbhayana@google.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Thu, 02 May 2024 13:33:38 +0200
In-Reply-To: <ZifYwxjNxfM1LwW7@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
	 <20240423-dev-add_dev_errp_probe-v2-4-12f43c5d8b0d@analog.com>
	 <ZifYwxjNxfM1LwW7@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-23 at 18:50 +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 05:20:33PM +0200, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Make use of dev_err_probe() and dev_err_ptr_probe() to simplify error p=
aths
> > during probe.
>=20
> ...
>=20
> > +		return dev_err_ptr_probe(&iiodev->dev, ret,
> > +					 "Error in registering sensor update
> > notifier for sensor %s err %d",
>=20
> \n

sure...

>=20
> > +					 sensor->sensor_info->name, ret);
>=20
> ...
>=20
> > +			return dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "SCMI sensor %d has missing
> > info\n", i);
>=20
> One line? (It's 99 if you use relaxed limit).

Being this IIO, Jonathan prefers to stick the old limit unless readability =
is hurt...
>=20
> ...
>=20
> > +			return dev_err_probe(dev, PTR_ERR(scmi_iio_dev),
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to allocate IIO device for
> > sensor %s: %ld\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 sensor_info->name,
> > PTR_ERR(scmi_iio_dev));
>=20
> Please, be sure you remove double error code printing, dev_err_probe() do=
es it
> for you already. (This applies to all places like this, if any, in the en=
tire
> series.)

Up... blind conversion. Thanks!

- Nuno S=C3=A1


