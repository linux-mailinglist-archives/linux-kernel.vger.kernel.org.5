Return-Path: <linux-kernel+bounces-132418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A208994A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C4286598
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507E321350;
	Fri,  5 Apr 2024 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5I+GnnK"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22F20DE8;
	Fri,  5 Apr 2024 05:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712293812; cv=none; b=RnXAO5X7+KgHDYCDsLCy/JMVyHYmpy2SxUOnyWNUqiBzADcYhxiHxNk0O16Eqy7MmUmjkkJ+wfj5HPrA78g9OZoVUJCVYYqk6I1MfEHJ4UnIQDHUUd0SptGsQyopY+dt2s5hO5m6UDA3dP4+EpgC62XyR9KR6ohaEbzXd9U4vFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712293812; c=relaxed/simple;
	bh=NlMY98BD79lBdspG+ouG7M9punegC0XfPjsulWCNnW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSCbSQ3wXRrGZTv4joPxDrARuQVxrc6bNQQkhbXob/U/RVTXNBBdB4PTG68Awsu7+eNoWHlO33IWiJAuGVEDlN6xX8Su0jXmqPaO8NlNJMeR2D4mxtJa9L561zM9VUbOZS+7BRMz4tUYdexhYm4WLVfQ0ARdVjH+Mal4QZj4SX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5I+GnnK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51a742c273so15674266b.1;
        Thu, 04 Apr 2024 22:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712293808; x=1712898608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlMY98BD79lBdspG+ouG7M9punegC0XfPjsulWCNnW4=;
        b=c5I+GnnKtg0KgWO/Gz2NMPPSiIjtx5bWW+fueq+/RbKBAzBoH7ah+Ytwqv/h7Fh8wf
         JdNEOfDfBb7QEf8Xe0nDCisD50h+7JpIEVg4YjoIdJ27Qd/HWeR5ngLgurPsgOI7Kli2
         jJxwzPvxfBqRz+68ogupJ8kkUiUNFXZHZH9pdycHZqnq1/UHvNOsB9q7yYJWrH0sptxj
         9TMFzbkyR8L3dcw5gCzEmC4Y7GFZfglRaK3DsXH1/nWtQov1iJxMcE/ajBei7M3QyNmG
         ZuKP8PL227rCbAOfVBAyaSruN/ovDsXPHF3ScsZqQV78Wq6atIo9Jg9lVQAIrMWsB8wW
         rkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712293808; x=1712898608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlMY98BD79lBdspG+ouG7M9punegC0XfPjsulWCNnW4=;
        b=s6h9kZh7dED+aUXvr/mQVkdXDJ9TKKK1hR0de/mSunH0eLa0uLzeIpgc87EtZnVjkW
         9xpMCvSXbrGFUfeTd0EoECLAmXUbNARj6l7Xkmix7Kan5/ohriBimbsAWHnkBfzq2qgG
         zjwPgEPz/FAV72mruGniwEex4zSiXIlgoDh7xNYl3fHmyvLENi14GuiRjgVrv+hSZtqo
         VVP+hxlgqvovXT5lj/mdIRYcssnX2sbaJIxy73mEVlm0sKdu29XFUNukcvDQq7GVXDzG
         c+RuowuXAbr8hk/RLZJXO14t4z8chW5tF5uKyl78soqJjRmyowUw5gvJ4UoPvt+wZXXc
         VAjg==
X-Forwarded-Encrypted: i=1; AJvYcCVFt2KJuDw/7gnqeGgoME4i2z4VlTy4mN4AlTIsO5UqP1GoeWdqbYAFe2XcnHvdQPjr0KIm6dDfwdub729275hYfUDk60BUcCEFoI9IrQpWI02hmb6sXrUEIqeiD1rg9VKPV/myyQPH3EUI
X-Gm-Message-State: AOJu0YxCrbqrX5+3hpBt+x5O7HOY5wgqY3Mg3uQ7xXMoPcdLOnEQKpv4
	51PmrbHe4nfxLE5xkPuO9jtHmBlgwWUdTJ+QFowLA0/vgJmx+OAGAY7mYPedwhUJy4TRhzovqgy
	DSPfI5s1WehGIrHdHXl2Z0gEtJNg=
X-Google-Smtp-Source: AGHT+IFNALLC+cLIfNSKBkrLOWuswiELcg0iglPLHWgzh4Faj3pLvLFzDEWHz9/0AFOMJnrf3rlzgjtzvgyHYx2EFkg=
X-Received: by 2002:a17:906:cce6:b0:a4d:ffcb:1f4e with SMTP id
 ot38-20020a170906cce600b00a4dffcb1f4emr161016ejb.75.1712293807779; Thu, 04
 Apr 2024 22:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dda2187e128bfaaf092351812e4538e2e41c17f6.1711599093.git.fthain@linux-m68k.org>
 <Zg3YZN-QupyVaTPm@surfacebook.localdomain> <8f234f26-d5e3-66ed-ab0c-86d3c9852b4a@linux-m68k.org>
 <CAHp75VcxLez_Nm0N8=gpWd7SKGd9JF2QXEOOB_gvX3ZtTzj6HQ@mail.gmail.com> <87y19s7bk6.fsf@mail.lhotse>
In-Reply-To: <87y19s7bk6.fsf@mail.lhotse>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Apr 2024 08:09:31 +0300
Message-ID: <CAHp75VdM8HgvBJrN_GRXH8XGGdv3Npxg6GR13AW-70jpuU=QOw@mail.gmail.com>
Subject: Re: [PATCH] serial/pmac_zilog: Remove flawed mitigation for rx irq flood
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Finn Thain <fthain@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 6:06=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.au=
> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Thu, Apr 4, 2024 at 2:57=E2=80=AFAM Finn Thain <fthain@linux-m68k.or=
g> wrote:
> >> On Thu, 4 Apr 2024, Andy Shevchenko wrote:
> >
> >> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> >> > > Cc: Nicholas Piggin <npiggin@gmail.com>
> >> > > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> >> > > Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> >> > > Cc: linux-m68k@lists.linux-m68k.org
> >> >
> >> > Second, please move these Cc to be after the '---' line
> >>
> >> I thought they were placed above the line for audit (and signing)
> >> purposes.
> >
> > I didn't get this, sorry.
> >
> >> There are thousands of Cc lines in the mainline commit messages
> >> since v6.8.
> >
> > Having thousands of mistaken cases does not prove it's a good thing to
> > follow. I answered Jiri why it's better the way I suggested.
> >
> >> > > Link: https://github.com/vivier/qemu-m68k/issues/44
> >> > > Link: https://lore.kernel.org/all/1078874617.9746.36.camel@gaston/
> >> >
> >> > Missed Fixes tag?
> >>
> >> Would this be ok: Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> I have to ask because some reviewers do not like to see a Fixes tag ci=
te
> >> that commit.
> >
> > Yes, or you even may dig into the history.git from history group (see
> > git.kernel.org) for the real first patch that brought it.
> >
> >> > > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> >> > > ---
> >> > (here is a good location for Cc:)
> >>
> >> Documentation/process/submitting-patches.rst indicats that it should b=
e
> >> above the "---" separator together with Acked-by etc. Has this convent=
ion
> >> changed recently?
>
> The docs don't really say where to put the Cc: tags, although they are
> mentioned along with other tags which clearly are intended to go above
> the separator.

He-h... Documentation needs constant updates too, for one reason or another=
.
This is normal process and in particular Cc (rather long) lists needs to be
reconsidered.

> > I see, I will prepare a patch to discuss this aspect.
>
> FYI there was a discussion about this several years ago, where at least
> some maintainers agreed that Cc: tags don't add much value and are
> better placed below the --- separator.

Thanks, I'll definitely read this.
But I'm 100% sure the environment aspect and mobile device screen
sizes were not discussed there.

> Thread starts here: https://lore.kernel.org/all/87y31eov1l.fsf@concordia.=
ellerman.id.au/


--=20
With Best Regards,
Andy Shevchenko

