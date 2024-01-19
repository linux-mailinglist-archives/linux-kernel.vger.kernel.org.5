Return-Path: <linux-kernel+bounces-31333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209A832CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C64A1C2319C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4147A54F8A;
	Fri, 19 Jan 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWlaMKLe"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F054BC1;
	Fri, 19 Jan 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680139; cv=none; b=urIfqmDnPNbUQPP4uYmlc1x+SsawPoW8h5n69pSar2U4RW/tgYeFSGpaW5qTjQIwAMOElfT22x8ULHvrFkJXImQqxfGkGkbX1m2ZLwwipKJWeNBOBxgtx6Wa70HRxmi0DeEI5iF1XJ6RJil7Ma/oDjH0BebBWwRMqiXSjX4beiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680139; c=relaxed/simple;
	bh=pX77ipe+Gsy5sdRmPvMGCJoBu6eqr4SlhVjTSxXiRl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRBlKmeZk48DtcXtjZJ6CsmOGoBATAvFwMYATA+IJfqSk/FyExn8hHsPIR49XdCTLxzh/gzwBVfH492+RwUwQz7LfxMuIggeBNaf6pRYcy4So1Ci/ZqRrta92jpk10I6KBfCOFk2HlMTK+VpAx46z3TEWawDZYovnv3cOBJMzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWlaMKLe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a298accc440so95591166b.1;
        Fri, 19 Jan 2024 08:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705680136; x=1706284936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhJgD3zP9zngaSpIBMlj3gbLccR2tuQ/HQYsBEgXc04=;
        b=TWlaMKLeOmzOBPqWPZw+k3qiTNUgjANq8Rj/rP5vSPqCrrcnUVsnNi1xZfZsAy8h7/
         tABWhY0FRlCZ4tTLJPZiX8YLAdZ59IJRJzVp1QYq7cX+zy4NhjG000wUCtMjSdv41iRu
         9i85oYUAvdmZJixI65M62Yol9dJtGijBp+HxRrujilg9hxNoTVg/HFWlzuY4NADsvuQe
         fv6Az3T0sj6JJWae5kq0JNLmxFiQUXf0BPMv2eY/QLe6qPS/dITKXS4Uf7X8Cp3jkjOn
         rS0LZnjGdn6Tlr0Kse659kPh5QvUBFNGLlD8S0H6gc1+pBQpYqwjg1FxePAVRYqzLU+3
         UsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705680136; x=1706284936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhJgD3zP9zngaSpIBMlj3gbLccR2tuQ/HQYsBEgXc04=;
        b=fiac0jz6EiRA/D4QW1/LQT9AYb4YnNAayNCsTMNbUjYm4eg/p/jQkhuZ4KCjvCb2l3
         KhxPWSH28V24hTrwtKHtxk+zQRsD4lNqhnf+Sq0Te6/KmHFRVcbvOGr73NznyMsEV6up
         eV3mSODtq0gGrQqUjPWoOJEAkA0bIE/DVYo0ZBzZk1JqtblWDJmvBADAb1rwnAwTLk2r
         wUAITv7WP2EpSA2q6Nk1oqM9HNZPg1O5nsGbsXplUk7Z55NLEIpUPd0tcHdzBGQ1Z6xs
         HSBzm1u0kk90tkaHQ3m04gPk2acE6SKVYC+nGPsWMOwqoN4Hw/KA/KAUFTOOFNLv7Fhu
         hPiQ==
X-Gm-Message-State: AOJu0YwgN77hf1Z9/bPKRMR/Hhyy7zScxyoXzfHqN6wmgGDISP5NLOtj
	ZOtiyfwDHj/TmpCu64V+ebbDsSFl64RCYF4UZPwYTluahih9d8Z8hhVNIaFuIWkHU4FVWP1WIqi
	5Phsp57DNe29MVKRdtaf/w45Z8xQ=
X-Google-Smtp-Source: AGHT+IF3+Nq/o91kf1Qzz3pAJkg83GJHPQk614/748N9uRatEUTFGG26s9DzXUBqtocFl8OSIsh8IeChhwKnrMDv1NY=
X-Received: by 2002:a17:906:280c:b0:a2c:e148:e2d7 with SMTP id
 r12-20020a170906280c00b00a2ce148e2d7mr6539ejc.2.1705680135691; Fri, 19 Jan
 2024 08:02:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804104602.395892-1-ckeepax@opensource.cirrus.com>
 <20230804104602.395892-4-ckeepax@opensource.cirrus.com> <ZalU8r1OvqKOLHrf@surfacebook.localdomain>
 <20240119113203.GA16899@ediswmail.ad.cirrus.com>
In-Reply-To: <20240119113203.GA16899@ediswmail.ad.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 Jan 2024 18:01:38 +0200
Message-ID: <CAHp75Vco3+B_mcLRr7dcLx79601poLJtLt3Av6d-hAJQLYbe6Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] mfd: cs42l43: Add support for cs42l43 core driver
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linus.walleij@linaro.org, vkoul@kernel.org, lgirdwood@gmail.com, 
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com, 
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:32=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Jan 18, 2024 at 06:42:26PM +0200, andy.shevchenko@gmail.com wrote=
:
> > Fri, Aug 04, 2023 at 11:45:59AM +0100, Charles Keepax kirjoitti:

..

> > > +#if IS_ENABLED(CONFIG_OF)
> >
> > We are trying hard to get rid of this ugly ifdefferies (ACPI as well) a=
long
> > with respective macros that are often the PITA for CIs.
>
> Fair enough, but what is the expected alternative here? Is it now
> preferred to just always include both in the driver? That does
> come at a small cost in driver size, but it doesn't really bother
> me.

Yes. You may have noticed the pile of the "remove of_match_ptr()"
patches in the past cycles...

> > > +#endif

..

> > > +#define CS42L43_RESET_DELAY                        20
> > > +
> > > +#define CS42L43_SDW_ATTACH_TIMEOUT         500
> > > +#define CS42L43_SDW_DETACH_TIMEOUT         100
> > > +
> > > +#define CS42L43_MCU_POLL                   5000
> > > +#define CS42L43_MCU_CMD_TIMEOUT                    20000
> >
> > > +#define CS42L43_MCU_UPDATE_TIMEOUT         500000
> >
> > > +#define CS42L43_VDDP_DELAY                 50
> > > +#define CS42L43_VDDD_DELAY                 1000
> > > +
> > > +#define CS42L43_AUTOSUSPEND_TIME           250
> >
> > Usually we use units for the macro names as suffixes...
> > E.g., _US (for microseconds).
>
> Can add those, does make it clearer.

This is a nit-pick, but just to let you know the standard de facto in
several subsystems (which hold drivers of different devices). Not sure
if MFD or others related to this driver are really bothered with this
nuance.

..

> > > +   irq_flags =3D irqd_get_trigger_type(irq_data);
> > > +   switch (irq_flags) {
> > > +   case IRQF_TRIGGER_LOW:
> > > +   case IRQF_TRIGGER_HIGH:
> > > +   case IRQF_TRIGGER_RISING:
> > > +   case IRQF_TRIGGER_FALLING:
> > > +           break;
> > > +   case IRQ_TYPE_NONE:
> >
> > Are you sure it's a right place to interpret no type flags as a default=
?
>
> I mean... no... but I might need more to go on. The chip
> generates an active low IRQ by default so it seems reasonable if
> nothing is specified to assume the chip is doing what it normally
> would.

The problem is that if NONE comes here it might point to a mistake in
the initialisation / probe code somewhere else. Please, double check
that it's a valid case to have NONE here.

> > > +   default:
> > > +           irq_flags =3D IRQF_TRIGGER_LOW;
> > > +           break;
> > > +   }

--=20
With Best Regards,
Andy Shevchenko

