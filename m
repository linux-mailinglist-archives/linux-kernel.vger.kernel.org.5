Return-Path: <linux-kernel+bounces-165202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044C8B896C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B3CB229ED
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E568682488;
	Wed,  1 May 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRk8qU5n"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5C60253;
	Wed,  1 May 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714564118; cv=none; b=Da4gNOm04vzDkHQsq+s9o6Q+24A0JYEk9pcA/403UUgk6qlg0LMCE0sd+rxUvt1gnSLeFidiJx6wtN3hHNMGGijgxNPBw079MlS4Z2em5piyfu5EcXK7AJWPQq/KbF/jMTOGRs0MJH8IChEEYzREAux+1Pt67B0loJLqeQycKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714564118; c=relaxed/simple;
	bh=6Ya7Rv8BuzUkqblZ4uH5Cr8VfDH163fZl6KXp5OnzUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEPPqtHFI8aQKnYoLUzYFCz8PsEo6Cb0kElDMG+aKyv32oLsJDx+6wU+ddoWIl4IGLTTwdTbORB5nWowB8Gv5/hm2R78Pi84L5ULx13l3iTCe/kljxid3WImTbJiVSgd0aNfQzVPizQht1Ls5Ft5pZ7xfea9XBbz+9J46CEprrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRk8qU5n; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-34db9a38755so738026f8f.1;
        Wed, 01 May 2024 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714564115; x=1715168915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPNlg3N+tpItgmZ3Kd/LLiIPFyrNbnMxBWM/z7K+b0A=;
        b=gRk8qU5nzoutb7V4npkDTmWTpne7L7K7dM7dl16CRvESWzWdQPsLgLAWdVUD+hJzdi
         VDoismkocjrnWcHZXZktduHyvybb7OlPOTztgaCaUyehR+qcdteShAxWV74/pZGu5pMp
         I/gwidQt1mVunuWoss6G0huNDzbONVywfOyQY70RHM0GCeNgOrE/IuthgmlnpOgl+bdj
         +iIjQhf6g7drPwpOoBB+AVRuU9zKEqWhQ7kt3jHHhGtIFe6Dcpxny+A8sAwO2KIVQXmI
         /Fw0T3QSadvAbc/Bi+DBmNR10yduy2vGCt0tMrBgCqUSIQ5y0qU2Sjy+snbpg4eYoPef
         In/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714564115; x=1715168915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPNlg3N+tpItgmZ3Kd/LLiIPFyrNbnMxBWM/z7K+b0A=;
        b=IN2oYjyevL5lQwRH5u7/OyukAQEBWeHAHHVxn4Jdi/HjGxrGj4OvvMwsyzPH3QUscI
         LfP6YYMpUAORf8D2eUsPOXbHP0OPUSRbMMJdOd3pABRvmOqNRWmtPLrTolVrWqLCdhaN
         ar+yvD/G34mtLyKKeJpm/a4eeFg78yhPwc5fxWsfmBjmvua/OXghKKxFOtMh2/Hijz3e
         1S+LNK+YLGKy+9j2Dez8476fIdfukKVQzeyjzzQmRnVAO3+N+P0kg8X2UmVsuMkryVcs
         KS0f/FH5qDXi9LqsQaxRS1klKtXlwjMIAFh6DdAlrduqZiqPzMJv5sxEU3+dZkFYP8+s
         6j4A==
X-Forwarded-Encrypted: i=1; AJvYcCW1DUOOgHa0oZiRXPo6Xa4G+HVqF6p+S6m4N9sLhyxFvyMbQhSTeN/dsoRqfoQmQAtGQni+Q5yezMgWidKWvfRUwayaij9Ogno0NKsw9CSg8Bk4QFZVsdAFpd2llDX+9wYGFfuaBGzOQQ==
X-Gm-Message-State: AOJu0YxLH5XgB9Fnxtlw07LwbtAeNBuxQw+AuDbb8irTEU0c5ZBfzpXL
	DEaMDIF4DdWqsfAySbecpblpVhr2ncO64XmgEbsvhishuJkWR1os16lvv3MscYJ7imE4sj5O3PN
	71+0TZyDmUfepaWzm3HFz2A344wo=
X-Google-Smtp-Source: AGHT+IFPhHJ8nW/Vce7eH7J1N/gsX5h6zfNOTtqvMU6c6oVQ1taBqOxhbd4Nk7sjoEMPR+PH7bglvxSMSHbgmw6dtUE=
X-Received: by 2002:adf:e687:0:b0:33e:c528:c900 with SMTP id
 r7-20020adfe687000000b0033ec528c900mr2079683wrm.55.1714564114889; Wed, 01 May
 2024 04:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
 <ZjEQ8LBxftcr0Z0t@smile.fi.intel.com>
In-Reply-To: <ZjEQ8LBxftcr0Z0t@smile.fi.intel.com>
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Wed, 1 May 2024 13:48:24 +0200
Message-ID: <CADFWO8HL_pwEQwYn0K9AkPV=HZyWN3NSOs8k4dRrB40w_1KdCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: Add driver for Sensirion SDP500
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Angel Iglesias <ang.iglesiasg@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 5:40=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 30, 2024 at 05:27:24PM +0200, Petar Stoykov wrote:
> > From 6ae7537517f551540121ca6fb3b99080b7580410 Mon Sep 17 00:00:00 2001
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > Date: Mon, 15 Jan 2024 12:21:26 +0100
> > Subject: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
> >
> > Sensirion SDP500 is a digital differential pressure sensor. The sensor =
is
> > accessed over I2C.
>
> Any Datasheet: tag can be added?
>

Ok. I see some drivers also include the pdf link in the driver's code.
I can do that as well.

> ...
>
> > +config SDP500
> > +    tristate "Sensirion SDP500 differential pressure sensor I2C driver=
"
> > +    depends on I2C
> > +    help
> > +      Say Y here to build support for Sensirion SDP500 differential pr=
essure
> > +      sensor I2C driver.
> > +      To compile this driver as a module, choose M here: the core modu=
le
> > +      will be called sdp500.
>
> You patch is broken. Fix the way how you send patches.
>
> ...
>
> > +static int sdp500_start_measurement(struct sdp500_data *data, const
> > struct iio_dev *indio_dev)
>
> Here is more visible.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I finally figured it out. Gmail has a hard word-wrap at 80 characters per l=
ine.
At first I thought it was word-wrap on the receiving side but I was wrong.
I will try to convince IT to change things so I can use b4 or git send e-ma=
il.
If that doesn't work then I guess my code will have shorter lines in next p=
atch.

