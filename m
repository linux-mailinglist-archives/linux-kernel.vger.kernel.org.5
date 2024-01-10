Return-Path: <linux-kernel+bounces-22358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DA4829C97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B69288CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C44B5C3;
	Wed, 10 Jan 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmCPG5Pa"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51813ECF;
	Wed, 10 Jan 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-466fb253b19so3017447137.1;
        Wed, 10 Jan 2024 06:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704897053; x=1705501853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i89h27D5x8fo1WpuYhfPb+vKKL6dKMeRr0vXj33KjsU=;
        b=RmCPG5Pa2OFCUB2QAh+kE3i/P5stPU0pz/SEN5oRXYx0S2FLdY+EOpSHGDRvHPKtay
         QFHV3Y7hz0SX3qywyGx1GzcH2owNXJrzCUrE8W+CK6RTWD2qA35M+pty6+21ZzQ1y496
         vDQMXSkl4R2vKkXr8MKX+0/DBRqFeFn5UwgYnMTBRgTjn4OsgOLpLuM15+mKkd73kyGa
         a0G8xjUhSZ7TIkMIo6qvjctYSHxKDqtSwqx3PYhpAQjzjiz+HTuEHan8yGBGU9Pt9pH8
         CIeL5+fUr/v4U1KjjE0cd8hJhUy+fCpEL78a3kT0Nj4OEsFowtQ4dllNdfJEat6u+2kS
         68UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704897053; x=1705501853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i89h27D5x8fo1WpuYhfPb+vKKL6dKMeRr0vXj33KjsU=;
        b=g2R4S6ltLqki7XQgL39nVA3UoKa2r5Ex/2eB752Fe+c8wJEQ0BqQPWp6NVqQJsnFi4
         gbmI8IKFp0IgyILT7Wy4bYCpPkQcTXmaDMiv/z6pXQYhQ9NQcvTEkiiLbxu8eFId6Pu7
         9zlhxzE6BNWbezOafP0NQ/MQPl3s4dRi7rM72zSWOqfmiMtXPoIRuyR1m3SvkwOlWhdO
         VjxcCKc+o36fk9zz8S214I9TYEh32NxZduSAyT156n0jviwx6Y+2X8E97bjt9Xy41IVP
         UZgR6ft1wikKgXTImzocrnaZW6uQHSsrCQTTPQ18vQxvaDv0sRnt1zVnl3WGHd/IWz2V
         +jDQ==
X-Gm-Message-State: AOJu0YyJM6vDwDxkqcHbZuejumfX6hl9At1GEdRuumc/IgNV+uQ/NRkS
	BeZVKAxFwTs9Kg3jSSotP18mcfwUnAfQaSyIe+s=
X-Google-Smtp-Source: AGHT+IH6Wsgj/n6dG2gx6+FaBubAUOkNia/93mSaLY5eA+PCcfE6Qb9qS3S6iCa9M0HbrGhuKONOAxOweRHz6F0oF4Y=
X-Received: by 2002:a05:6102:508e:b0:467:dd85:4304 with SMTP id
 bl14-20020a056102508e00b00467dd854304mr203081vsb.27.1704897053071; Wed, 10
 Jan 2024 06:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109175844.448006-1-e.velu@criteo.com> <CAJZ5v0ipYQURmFGGwmS5oyOuAOFDbG7TaaaWg4Ze-7PpBnSwkQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0ipYQURmFGGwmS5oyOuAOFDbG7TaaaWg4Ze-7PpBnSwkQ@mail.gmail.com>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Wed, 10 Jan 2024 15:30:41 +0100
Message-ID: <CAL2Jzuz5OMiU6g+dYu+SU0E=ydBmpZzbQ5XpEfRtheWYkfB6=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq/amd-pstate: Adding Zen4 support in introduction
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Erwan Velu <e.velu@criteo.com>, Huang Rui <ray.huang@amd.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So it's probably better to let AMD people fixing this part.
Thx for the feedback.

Le mer. 10 janv. 2024 =C3=A0 15:21, Rafael J. Wysocki <rafael@kernel.org> a=
 =C3=A9crit :
>
> On Tue, Jan 9, 2024 at 6:58=E2=80=AFPM Erwan Velu <erwanaliasr1@gmail.com=
> wrote:
> >
> > amd-pstate is implemented on Zen4, adding this architecture in the
> > introduction.
> >
> > Signed-off-by: Erwan Velu <e.velu@criteo.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 1f6186475715..9a8d083f6ba5 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -14,7 +14,7 @@
> >   * communicate the performance hints to hardware.
> >   *
> >   * AMD P-State is supported on recent AMD Zen base CPU series include =
some of
> > - * Zen2 and Zen3 processors. _CPC needs to be present in the ACPI tabl=
es of AMD
> > + * Zen2, Zen3 and Zen4 processors. _CPC needs to be present in the ACP=
I tables of AMD
>
> IMO, it would be really nice to avoid extending this line so much, but
> this is up to the AMD people.
>
> Also, while you are at it, "include" in the first sentence should be
> "including" and a new paragraph after "processors." would make this
> comment easier to follow from the logical standpoint, because the
> first sentence is about the supported platforms and the second one is
> about additional requirements (ie. something else).
>
> >   * P-State supported system. And there are two types of hardware imple=
mentations
> >   * for AMD P-State: 1) Full MSR Solution and 2) Shared Memory Solution=
.
> >   * X86_FEATURE_CPPC CPU feature flag is used to distinguish the differ=
ent types.
> > --

