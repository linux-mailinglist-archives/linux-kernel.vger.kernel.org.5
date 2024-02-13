Return-Path: <linux-kernel+bounces-64162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB3E853AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1A6B22FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4726560893;
	Tue, 13 Feb 2024 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B9p/ZIkO"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD306086A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852377; cv=none; b=uOE+xf130YBXKsLoOOweYY4+8waXQ/Tc7vI35TAwFLYJzShXw6bmvjaPCS8fqFvxr79gDcMWtDj6SjIr9quQJLFaFZfKJiV+V5JWWyGLumeXtpe79lo86tihWvG/MUOgJW514frWFzHCpY5Q4z0XfjNkR5Q/5QJbJBr8mhPGstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852377; c=relaxed/simple;
	bh=FcIUCjZjJtIJsey1BGn6tsDk+4jnwfVq1Ekp8PG/kYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoL7Wnpp8Hv+wmIVAbipRZnTWnkfxNaGFuArikkeFCoxTF8c4TDMvhRjqTbw0Tm4DQxgcHety9cL3YgvUin/qLq7dgXhIwW7pj9mB05Alk61qJY0PhZZ3kg3FHRo+vm6ASqgh97DP8Se7DqTi9fA2SNTzoO2XTzuuvM7hGHC3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B9p/ZIkO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d073b54359so69628251fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707852374; x=1708457174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeIn4TTu9vCR66Yqi85vfwq7rwhNbFFNwfgKW6lLC1s=;
        b=B9p/ZIkO/Fqg3nbHDnYPQj9DG3QixoGNL3wzmywUEp4S08vcYr6bq3IMapLcPGCPPE
         lVdnRmIxu0eLVKGTJ1aqxx61SV8AgS3w/m1mOMwjtiNKgOuO9wCdcn6VIi6Yyg8GI9Qk
         +nrfQvfRBnl9dzbEU2tXKl73GgX/SOxyIt4Eh9kMtoLO+4UOhauVgYiaQyF0KIyZamIh
         ARgcTgEvtCFQE2fQ86MdwBYARZgV0HB9xPOAlFf9rYt439mYwOCR8buuYgUewWHMaHba
         smMGH2mU32b37EhGyWdJgFlBeoTyEkvh/RsMK1V3YWiRSS5aU7u63TSCnkIXq6leJrMh
         4dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852374; x=1708457174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeIn4TTu9vCR66Yqi85vfwq7rwhNbFFNwfgKW6lLC1s=;
        b=MLVMb8NLtUpDPCHxFDuNXvjtnP5wXIL/q71mSLcsEFSCTpPllstNxtnGBWpHWdzjFN
         YOyG/bOQQFyCkLBxlApYohkzlapLA7pniDbGME79B0MnBzRP5fNse2fy4OXQPeN8FJqj
         yoMLS+3mq+gRaifQbb2wlEu6vFxLOuXWt34l98FuORT0fZlFmmLpL0wRjnWeFTVcFmmn
         s/Wf1ddhY8AUiOy5l6ASAmtzcwjS/3Qgff0NAhDnD27MqwyQNGDi0Vo8BrQ+pLWc0xGZ
         RyJ+M9YE7ID51ZItFOrvyfIf8Iiwt8Pp+ssheHGush+WdkW9HGXA4xKoLQXnlOP78hBm
         6t5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbRpav9o9hA4X9evu8NwyeH1GbWTzuePfGdQjFPU+ZN1glnh5zwWIYS4YYGAtWfZoPCV8buPq4Ja4KPO3LlpGUdVxH5lGBDCzBbvPD
X-Gm-Message-State: AOJu0YxdMDOkcvWXOWzvvS6O/NwH4p6ggXwKQID7Dv9MI/OZFO1K5EeY
	96A0oG4Tzxi0WWv0VDZP8e04Nlp3qgoZNsdKnBgqKl9Xxj41QDXYJin+rBrTYCHMS7nWstOhFoY
	0B20xVzsiijSEW6vmv0Ll+lsminocrZVctWVsxA==
X-Google-Smtp-Source: AGHT+IE+m+Xi/dgb97e63/2F5Xl8+lxhih+9in0RcqGziZ5Ue+ulbC6JY4e+xfOXYEfnyTe7a0nKHshr37VCCQ3ysW4=
X-Received: by 2002:a2e:88cf:0:b0:2d0:cfe6:4364 with SMTP id
 a15-20020a2e88cf000000b002d0cfe64364mr500467ljk.36.1707852373843; Tue, 13 Feb
 2024 11:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com> <54623b74-872a-41dc-992f-71a586d145ec@sirena.org.uk>
In-Reply-To: <54623b74-872a-41dc-992f-71a586d145ec@sirena.org.uk>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 13 Feb 2024 13:26:02 -0600
Message-ID: <CAMknhBGt0EyA_FcpXbmT-PStZqmZ_PUENHbVfgDFOwWcv5gTAw@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: add spi_optimize_message() APIs
To: Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>, David Jander <david@protonic.nl>, 
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:55=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Mon, Feb 12, 2024 at 05:26:41PM -0600, David Lechner wrote:
>
> > +static int __spi_optimize_message(struct spi_device *spi,
> > +                               struct spi_message *msg,
> > +                               bool pre_optimized)
> > +{
> > +     struct spi_controller *ctlr =3D spi->controller;
> > +     int ret;
> > +
> > +     ret =3D __spi_validate(spi, msg);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (ctlr->optimize_message) {
> > +             ret =3D ctlr->optimize_message(msg);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     msg->pre_optimized =3D pre_optimized;
>
> It would probably be clearer to name the parameter pre_optimising rather
> than pre_optimized, as it is the logic is a bit confusing.  Either that
> or some comments.  A similar issue applies on the cleanup path.

Per Jonathan's suggestion, I plan to remove the parameter from this
function and handle this flag at the call site instead.

