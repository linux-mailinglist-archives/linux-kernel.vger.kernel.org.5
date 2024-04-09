Return-Path: <linux-kernel+bounces-137117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E3789DD32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC5F1F25B36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31812FF84;
	Tue,  9 Apr 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6Ie0Nos"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7583A06;
	Tue,  9 Apr 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674023; cv=none; b=ixi8gp68s2WZ86XYY/6Iiei2wvtgqsl1jblISXLQ1HW8b4QuRXg7LF6PTy2uH8GqfR3n7Tpp3V3h3ecEcl4qnEJVUm7pv2gJuIY9A4Y5ayFXN8AmUIAMeIVT7VWI+vS9/fpPavKrn5i8lDtT9Le+DaZMDSJx+/b0xon9siTxOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674023; c=relaxed/simple;
	bh=0mq4p2RKJcENA+l1Y9ZRi0A1ikdFR53l9IrAV6mP5J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDxuXgnf6w2Y8jxt3qhT2TAxsfD2c8l1jJ/7mdHCes7pDf3lRnm0aXnVAkqcRkviZcSsRzM70rxyxbUpN3vHG/h9L1eyvLesfPvL7hL40DcYRuc8gxvV2M/nUpv6GWGkMHOwyDqsaAQm3HqL/8HdL2XRKR5n7+LCnvSyMkPXaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6Ie0Nos; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dff837d674so48530195ad.3;
        Tue, 09 Apr 2024 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712674021; x=1713278821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4/XbwGfv5FH7OpTEgDneuRNsxKocgdNuASa9JUfGDg=;
        b=b6Ie0NosVMFZfbrJlY7nXD7BnM8ETWFBMQJhgPFPeqCeuUHqRw6F9cwdj4VowY5q0u
         38luqcoCBt26Sf1jkFdMLVnX0j7NapGSH4gpOnySIcQ2tKVI3XIBUzrwgs7KmVtmA0ee
         fmiBxxDihhqpscBK9SqZH2tUoRW9C8pqQrSk538/ETCGPFQf9vVPmXxLhki3EkH5xkPx
         PRPVC7KOhyao3DVKaWQ0qbNCaPnkAzvnJVxAieCaEADfYwRlR739FFCy8/7l+EFvNy7g
         7CHHCRrsYwX3dZ6FmSctOv4CYJD/RH/nimYx+e8WHR4+Fk+aw1gR36TSvcsBp2LXxcsL
         g21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674021; x=1713278821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4/XbwGfv5FH7OpTEgDneuRNsxKocgdNuASa9JUfGDg=;
        b=fWIUin9Tes4pWCHtnE6TbOVQEO4xeJ2E8Rbo7cdyYFD3N597FmKVcBulWntPg+TV2V
         p0W/e4ekPZ43a9b9Dlj6BB34fIR3rKELTgrQIXZX9BRcynVwjWAgNvc4AJnXUwdYzFf0
         cng/kQB7moQ4UPU0q2C4ZYPUKKEH/TiTvzqfLoFe6MuzxKKQFGwtR58TdZ3FdPKCZ0ty
         Fesm5meVcfKiFQY0PKA+MSzJV5kfmzeeqqe+XFDB7GEcPCtJGmuZRRhFBYbSd0Ijo92B
         iDXcAYNzYZjEWAcvlpi8NxBisBbSuXJCHJLC9ogxd+1+LAQyU7uR33azEnAeHSGBHSwa
         vDig==
X-Forwarded-Encrypted: i=1; AJvYcCXY2AxjYubPhF3mUdExLIxBvHaVsLHSqIx8O8ljom3XwevX57QgR8x7AkvL3MbFToLvWWhfbUonFS1hnPBT95xti/1AyYPTKp6reV0RndmH+FB8lu5Cwnh8XcNV1R3Em1x9oWyo2Gk=
X-Gm-Message-State: AOJu0YwSF+qf6Qjl2JEpwdQSgxtmV+SIDw9G/rV7D1RVxHIcEKLKmt25
	R6Hyy8htdNqHUSE/ADzFMZZlNavESyri+sVoRr03xhtZwRGXmKc75dnlgmejyoQ6etOBbG8/QcM
	12Kh7Zq4FHf+mXrc2diDXtd/Xa/8=
X-Google-Smtp-Source: AGHT+IFY9j+qoSmaEYW4Akp1KOi4FfGEeSnCSb7sIzO3txX/tFn7nbOlqb5dbAR83wpPTMIXAlFbk//FTGHP13D9Ggg=
X-Received: by 2002:a17:902:f30c:b0:1e2:7fb2:b0b with SMTP id
 c12-20020a170902f30c00b001e27fb20b0bmr9825211ple.68.1712674021492; Tue, 09
 Apr 2024 07:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-gpa-no-cooling-devs-v2-0-79bdd8439449@trvn.ru> <594fdc5a-3b09-40df-98a0-43671665e55f@lausen.nl>
In-Reply-To: <594fdc5a-3b09-40df-98a0-43671665e55f@lausen.nl>
From: Nikita Travkin <nikitos.tr@gmail.com>
Date: Tue, 9 Apr 2024 19:46:50 +0500
Message-ID: <CAN_S-bXxKBjB5knjcUXW=rVwhCx0f1-pDMjmf9V9+ZLYSGZxvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gov_power_allocator: Allow binding before cooling devices
To: Leonard Lausen <leonard@lausen.nl>
Cc: nikita@trvn.ru, Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D0=B0=D0=BF=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 19:42, Leon=
ard Lausen <leonard@lausen.nl>:
>
> Hi Nikita, Hi =C5=81ukasz,
>
> thank you for fixing the e83747c2f8e3 ("thermal: gov_power_allocator: Set=
 up trip points earlier") and 912e97c67cc3 ("thermal: gov_power_allocator: =
Move memory allocation out of throttle()") regressions as part of v6.9-rc3.=
 As the regression was introduced in v6.8, would it be possible to include =
the fix in a v6.8 patch release?
>

Hi! I think these both have already been picked for stable:

https://lore.kernel.org/r/20240408125314.939341866@linuxfoundation.org
https://lore.kernel.org/r/20240408125314.969670696@linuxfoundation.org/

Nikita

> Thank you
> Leonard
>
> (Resending with regressions@lists.linux.dev in CC)
>
> #regzbot introduced: 912e97c67cc3f333c4c5df8f51498c651792e658
> #regzbot fixed-by: 1057c4c36ef8b236a2e28edef301da0801338c5f
>
>
> #regzbot introduced: e83747c2f8e3cc5e284e37a8921099f1901d79d8
> #regzbot fixed-by: da781936e7c301e6197eb6513775748e79fb2575
>
> On 4/3/24 07:31, Nikita Travkin via B4 Relay wrote:
> > Recent changes in IPA made it fail probing if the TZ has no cooling
> > devices attached on probe or no trip points defined.
> >
> > This series restores prior behavior to:
> >
> > - allow IPA to probe before cooling devices have attached;
> > - allow IPA to probe when the TZ has no passive/active trip points.
> >
> > I've noticed that all thermal zones fail probing with -EINVAL on my
> > sc7180 based Acer Aspire 1 since 6.8. This series allows me to bring
> > them back.
> >
> > Additionally there is a commit that supresses the "sustainable_power
> > will be estimated" warning on TZ that have no trip points (and thus IPA
> > will not be able to do anything for them anyway). This allowed me to
> > notice that some of the TZ with cooling_devices on my platform actually
> > lack the sustainable_power value.
> >
> > Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> > ---
> > Changes in v2:
> > - Split to two changes (Lukasz)
> > - Return 0 in allocate_actors_buffer() instead of suppressing -EINVAL
> >   (Lukasz)
> > - Add a change to supress "sustainable_power will be estimated" warning
> >   on "empty" TZ
> > - Link to v1: https://lore.kernel.org/r/20240321-gpa-no-cooling-devs-v1=
-1-5c9e0ef2062e@trvn.ru
> >
> > ---
> > Nikita Travkin (3):
> >       thermal: gov_power_allocator: Allow binding without cooling devic=
es
> >       thermal: gov_power_allocator: Allow binding without trip points
> >       thermal: gov_power_allocator: Suppress sustainable_power warning =
without trip_points
> >
> >  drivers/thermal/gov_power_allocator.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > ---
> > base-commit: 727900b675b749c40ba1f6669c7ae5eb7eb8e837
> > change-id: 20240321-gpa-no-cooling-devs-c79ee3288325
> >
> > Best regards,

