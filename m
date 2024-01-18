Return-Path: <linux-kernel+bounces-30564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8CF832094
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C0E289DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A1D2E855;
	Thu, 18 Jan 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljmF7SWf"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873012E64E;
	Thu, 18 Jan 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610829; cv=none; b=CifImOqLnaEAJ9iXe2OQmgnsomkgubJmsgNwJqmKrJjlindZ4gSmKPRzQ3ifr5wEU917JvSDvuUFuP3hhJUSktZDi/M1aoXoCgxYAVntXsN5gpOzMUx9zO3dN00CP4reoQEnzE4npV4Qt3tmwZMrRk5ticIkSRotGU0b79zJ0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610829; c=relaxed/simple;
	bh=YkNMcyCL6Mh/JYKmRd3zfblygFLMWofKD5+zOtT5Eos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0DjerWTTLoVsQmbEOrAk5tdgbvxaN4iJrXt3q6uGFjEn/PJq+4Wz+fo/09gQDq9bmx7x2IyuTdbH78+OJrV8RBY8ZFI7mlD3o63T18uHwOyUEoqLqQmKzwLI84F65IPmVSLN1mEDrfrN0m4HxN0LIGIJdT/SOqGNBMjaxdTQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljmF7SWf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so18502a12.2;
        Thu, 18 Jan 2024 12:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610826; x=1706215626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HypTLSotTTqKwVsOm+4b1Ez49+TpS5E1yzIiV5X+xQ=;
        b=ljmF7SWfGms1CQQbwwesMgiSPXjuOmQ4TZUYK5/eUEX6nMErhfQHOpXfERZwp4am0m
         66UF7B6+wBYXFd7frgSCIErhvP+K9gbOAkxQe2jKOUVSOc/pMwOGim5XwcKNcRrT8xu5
         4TTci7oGkEx+WRZL5y2gknOkp79n0vJrqnh8RmbStmAfbeI9ZEdYp25064cSCoBtvNVg
         DDEv+MNkcXtrDmrhuXhvdPRxltO8jVSdU8p/qwKCZpprBKDUQ3M1LxqgabXkU8ye/rHN
         td00iQFiL8UfsXneXHaaN+KwchIC+4cx5Q11nJh1ajtDELh42YfLI0a9QeBYjuFnRJeq
         KRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610826; x=1706215626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HypTLSotTTqKwVsOm+4b1Ez49+TpS5E1yzIiV5X+xQ=;
        b=uzhB/c8UGC7BzxciNMZEN6LZcPqXkdsvestn8T6ntloFLW9Sym0Q5sXz9Ah1F1dTb9
         ab1W8uYY/XFmpT09D4EKhRt/g/ZX4BrrtCFLFWC91PFaz7LZp6LHaxvWJH73XybRiTUl
         rH2qpav4+1tOG4cn8mhuEG0u2gNbfU/RFE3rONry10jKtVhQsWvvWUINCVSHAFgdLg8B
         X1mhc044zi5KSUH286Xx3IkcrzDSHT+h9R7Ag/VXyG+MfuSRoNNuKlMfbupvfiq9bF4m
         BvhMLtZbVXB3pJH7wSB9mSkxY++HgX63cr2HauUTz9QHRWV5zjy2DQ3+VuO6Q9B/8gsQ
         2xcg==
X-Gm-Message-State: AOJu0Yw2xxaaDuqg+xU8Nuuzdi1xf6C1XSly4BzoGs3S4glLvfL/Awsb
	nG6LuDXxmscJRBs064Y1btP8E2GMO4Jfe+mSg3FpFm9LmEmRVh8rOFwcJKMNmulghQcvTT8E6l3
	Tlbqv0Fpt7jVV+SSvShFVbJWSAgM=
X-Google-Smtp-Source: AGHT+IFPg1KQKOiytDCPjzr2bAiXNTOihCNCwnx04ccb1HQOAhoThFdVl8FEgsgHhgV36eaqZcfXVS1cbdKI//lMd9o=
X-Received: by 2002:a17:906:471a:b0:a2c:7293:af58 with SMTP id
 y26-20020a170906471a00b00a2c7293af58mr906907ejq.79.1705610825460; Thu, 18 Jan
 2024 12:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-7-ckeepax@opensource.cirrus.com> <Zali4qxdegY7H6eY@surfacebook.localdomain>
 <aec96f5a-b759-48c7-a5ec-bafe3bfa5357@sirena.org.uk>
In-Reply-To: <aec96f5a-b759-48c7-a5ec-bafe3bfa5357@sirena.org.uk>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jan 2024 22:46:28 +0200
Message-ID: <CAHp75Vd6JtW4ddbSPXUp6WgEdBJizjwnS-XZzwLcXWWLxFWp-w@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] ASoC: cs42l43: Add support for the cs42l43
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com, 
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com, 
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 8:11=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
> On Thu, Jan 18, 2024 at 07:41:54PM +0200, andy.shevchenko@gmail.com wrote=
:
> > Fri, Aug 04, 2023 at 11:46:02AM +0100, Charles Keepax kirjoitti:
>
> > > +   unsigned int hs2 =3D 0x2 << CS42L43_HSDET_MODE_SHIFT;
>
> > BIT(1) ?
>
> Given that this is writing a value into a register field called "MODE"
> it seems very likely that it's an enumeration value rather than a
> bitmask (and similarly for all the other places where you're making
> similar comments).  Please think a bit more about the code being
> commented on when making these minor stylistic comments.

I read a bit further and have given a comment about this as you put it
above that they are plain values.
Please, read my comments in full.

..

> > > +static const char * const cs42l43_jack_text[] =3D {
> > > +   "None", "CTIA", "OMTP", "Headphone", "Line-Out",
> > > +   "Line-In", "Microphone", "Optical",
>
> > Better to have this by power of 2 blocks (seems it's related to the pos=
sible
> > values ranges in the HW).
> > If it's just a coincidence that there are 8 of them, perhaps other (log=
ical)
> > grouping is better?
>
> This is probably well within the realm of driver author taste...

No objection, just a question.

..

> > > +   // Don't use devm as we need to get against the MFD device
>
> > This is weird...
>
> This is normal, the splitting into subdevices is often a purely Linux
> internal thing and not represented in the firmware description so
> external resources are linked to the top level.

I meant the weirdness of mixing devm_ with non-devm_ in a way that
->remove() can be broken to the extent of oopses or crashes.

--=20
With Best Regards,
Andy Shevchenko

