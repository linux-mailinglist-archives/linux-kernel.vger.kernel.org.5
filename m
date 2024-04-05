Return-Path: <linux-kernel+bounces-132417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259C8994A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3507F283774
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0621379;
	Fri,  5 Apr 2024 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3LvKjr5"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAEF28E2;
	Fri,  5 Apr 2024 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712293590; cv=none; b=XbLPn+dV5AWqN/tEuILYLzHPKMG66uW2YEUbGOe0kglZAEnW8Ryk8KLbLtpy1hciebGjlIln3uc+0mp1SoZo5M8zvlWquSWvhPac/9GQ69sHz41gLym6OhxpLvEkye/RwnQMdBJhEgTFzflYiyBZgXH6Hsjk7CAz+ZwOiIiSQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712293590; c=relaxed/simple;
	bh=Sebt93aHymKxS1oWwauAtqnPitLNbEXG6RlgwpBarSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7x6I0ROkYP3QWhXobxn4aBpGpTzo+6UTf/aSh0MdUMfbM2da8cw+4bSCpdS51goJ6K2wYxhkObqucXffxON6HIgk4I/blmLKsinsduFNSd1eylFS0V3kSP8sb+91estgqgOnkIMdf0p0LS/EGzVuXMO67etW71yE7U6lV6Lk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3LvKjr5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a519eae91d1so65917966b.3;
        Thu, 04 Apr 2024 22:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712293587; x=1712898387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sebt93aHymKxS1oWwauAtqnPitLNbEXG6RlgwpBarSs=;
        b=N3LvKjr5QTlIeW6M7y51sMUzApni9GRUJ+TKTYW5AjkDogV3LXq254sr3NwoqFGcP1
         3zRzFMdr+SCSnUc0AWFZfZN4Ct4AG3kduFE4XlfJOiinCYsLmVSQoYNnZ4NPK4qzP4pi
         26pdJBeZfD4Gjm/9GPSxBnBEwXaaIfOV3vX7FfBlxuifSpi7QqnVKW9uEAOkBxmDJCOu
         D1rxUrsuF9uqWQeZkwrlXcQY5laSpPDaNZQCuy6sC9rfwGc1eVntB8bggZztel7Adyto
         h09u1UXkCm/3w47NAAlB//GqUsmYVjRjFK9WtY7yAeHJgzdyS3sdIevr6eLNsx7knyTo
         H1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712293587; x=1712898387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sebt93aHymKxS1oWwauAtqnPitLNbEXG6RlgwpBarSs=;
        b=eIibOo4bDhdzx2lfVq+ejh1zyC2CL40jQ47merRIy77e3TXQah/yKCEgKgzeS8MIE5
         Bhu2s2v/VYV1EsYUQx8PmwXHRbt8XjL/bswtTkDkzdJBz/NmTfMYtC1fagzbJLbiZpTk
         HF2ZRqZ4PtRR27VSkNyUzM6eovGC6weLyzOvewXg/hTOXGPNTKkIt9koZvExfVF3uLWQ
         SK92IXq9sjgr5RtzUHub9bROK/55L7T6lcDN1nUjUCA2zmKhV/51+XPZhGaKc15p07NU
         XEvOOWfmTs8Th0QuqpTVErvRkOt8ttfiBs2ryiNZ6YAVnrwUCR8EOkkfM/Y/svZ/Q6Nw
         xWng==
X-Forwarded-Encrypted: i=1; AJvYcCU+o53ggGdWy4nzp9rnYGVmg84PLv7Pniqvr9XhE706zukHSnAB4HMZuuDs3dsQl0T6PXrpkZ5jn4mlubsyO1evpxMI4UdahRMBwlsANhLhCyGp7xt6HDJU8cMG4aYenoXd44R+o9a/FEHg
X-Gm-Message-State: AOJu0YyO3cZeJxQC65uF7v4oQZL01CAPRfrefhRHUYfM69ZWEpmfWgCR
	Ly7/UUePKei8O1hTppTsyJOQsWfKC2wCtqz9A9Z7TSEh2gmut9f0C2ooGsB3xLMYHzsurX3SZ+k
	oJcb3R8AyW463bi25z2Q6+Uu9A2Q=
X-Google-Smtp-Source: AGHT+IH5UaoZ1lqiUtwAAZvTUwGnrAg/GCbjcl9oYf28LvmdvgmcJ9HrjMUzZXEnFiUjAjm989T6vTu1elJupyLaKig=
X-Received: by 2002:a17:906:5784:b0:a4e:6580:eec5 with SMTP id
 k4-20020a170906578400b00a4e6580eec5mr183356ejq.27.1712293587311; Thu, 04 Apr
 2024 22:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
 <Zg3YZN-QupyVaTPm@surfacebook.localdomain> <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
 <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com> <5dd285bd-b9a8-c85c-9bd9-a839c10e78fd@linux-m68k.org>
In-Reply-To: <5dd285bd-b9a8-c85c-9bd9-a839c10e78fd@linux-m68k.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Apr 2024 08:05:50 +0300
Message-ID: <CAHp75Vc75xFK_kq4AHmHqt-bC_dk+St9M-AgBa0XUEAc1fB7AQ@mail.gmail.com>
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq flood
To: Finn Thain <fthain@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:15=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> w=
rote:
> On Thu, 4 Apr 2024, Andy Shevchenko wrote:
>
> > > > > ---
> > > > (here is a good location for Cc:)
> > >
> > > Documentation/process/submitting-patches.rst indicats that it should
> > > be above the "---" separator together with Acked-by etc. Has this
> > > convention changed recently?
> >
> > I see, I will prepare a patch to discuss this aspect.
>
> If you are going to veto patches on the basis of rules yet unwritten, I
> think you risk turning the kernel development process into a lottery.

It's already a lottery, if you haven't noticed, i.e. it highly relies
on the style preferences of the maintainers and is yet undocumented (a
few years ago it was a new section introduced for closing this gap).

> How many other patches presently under review will need to be dropped jus=
t
> in case they don't conform with possible future rules?

What you are saying is pure speculation.

I rely on at least two things (besides already explained):
- the fact that Submitting Patches refers to the commit message
reduction due to the unnecessariness of some lines
- my experience and common sense (why duplicate the data?).

--=20
With Best Regards,
Andy Shevchenko

