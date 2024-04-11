Return-Path: <linux-kernel+bounces-141476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C38A1EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718CF1F283EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C4D57876;
	Thu, 11 Apr 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npyoLuEE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E3EEB5;
	Thu, 11 Apr 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860113; cv=none; b=QF4glaz7q0rAK5AGhydzOZl6qKABw66QwpMHTiDFl7WITcVQJ4ARAl7oKuRoNx21KoGBDYUjgTJhee/+9LlSB+Fiq2Siadjr0tWOnAfI1v+8tD9ucN2CWB3LwhsFZOaQsKsSXPPOgjTFTD8Yck/Rrz6BaK7rMOzEBcgscGVDmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860113; c=relaxed/simple;
	bh=/IZd0f4cIcjgfp9GR5gM6efCnTJM6E7JI02RS17qHZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5A1Yp0OR83C2+qt5qlsIuLO5y/+rwm+SEkPC6EvjORpEeg269nsNYAkcnOOzXqM1WZf5ILh8HrD/p6zvINZdpvcrwpcGWhaAt+ZXsktJcKMD17r6OM2dGrurXhGmnUpkd5l5027rfDhqK5bF0eAN9JCtWixaMa5lY2/qvsV0aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npyoLuEE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51b5633c9cso12426766b.2;
        Thu, 11 Apr 2024 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712860109; x=1713464909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfYS4z2KDaTtE49E3yMI2bPMpa8b6hlOl6nP1EoGnf8=;
        b=npyoLuEEobzvUADNG1DYidVWDJUmPAEi/3Z+kJVOx8k88neHd2G8A4OJu3tc4EGe4D
         GJbclTOaBRc8HiQW0b/8NI4lecW44xd83e3A9SHVf2NmvHQ5WetZKtdZG8xhvILNvyVw
         Ir66+QFqpbtXOnHK4kID8yYBK7hU3/nXznhwHR7sv7F7INMS+KW5GT0DhNJJVHguiHoO
         7NhnQSm+c7S7mprJTdpDwkRq1VdgQBl/lGY6q9pQEwseDKaQkCWrKV9eur7SWDiat8GC
         iNd1BuR/KzM8QtraY9eCMOA8rLnOgzqnpIaHqwYLP+/h6jHy6gQtlZICuv1WqdyoD+2P
         BkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712860109; x=1713464909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfYS4z2KDaTtE49E3yMI2bPMpa8b6hlOl6nP1EoGnf8=;
        b=jAChzwDBORLc6gDHmD7EiWClYd0vrtwZ7YoP2/PQjr2V8VTKFEevIgmSVFHa6/v2U9
         7A0a5lzoCV7kblyawOO2irsVVErIntxODe7MQPHFC5IqhnK7I7oFAf5nYNd7mNLHDXLU
         YghhPuUdUMy3Ek3WiDDUe46hvboQF3v+RFORxWOCEQog+3H81QmtKYYqkAT0LBwiLOE4
         4bR+qsFyh4Y6+uoLrzhLJL0U8LX5yVRXycqFn58KppeFh5vb957oF5ejV8FjF1yEvHpy
         Qia9l3oPco52Zr6fmjOSJ7WCNQhE0pzDYbdUsBaJLQIbeLbUsGVZWD9n8DYmMRAS7ZmG
         ZRig==
X-Forwarded-Encrypted: i=1; AJvYcCVd5egDU1neDtIvGKI5nnAfNlKT5JZff7QkG16+KC0FxkdB+RVVe2GoyZ10EuapSuQmi5wQI2B4MML+74lDmYvC5QrKhmzaqhH3LzV+0kigKRSmPr9L7zbXHpZMZ5Hb+Wx26iaNHWDRkeMo
X-Gm-Message-State: AOJu0Ywx4zN5Hk7wTjDdeXypBEfPqjVeOCaj35ezZ86uqeSDdXVvFFMp
	cUaBju+E1/Xls3XEfwcySGYM3Ky/SInivLej8Qi2jEdjXHQpC/rWGgH969lHxmE4R1yedhaYicJ
	IcVMoN2RSIxCCzLBff1Wyl8UW1xI=
X-Google-Smtp-Source: AGHT+IEpR2+ufKSL8nCzoM4mYYYjcq9n7+ZhdL0gxUKBaMzKtnSkrOogaPwAcRouRJWFfsEs0O78dQXcjAc0ZRCO/10=
X-Received: by 2002:a17:906:1b14:b0:a47:2087:c26f with SMTP id
 o20-20020a1709061b1400b00a472087c26fmr306124ejg.73.1712860108853; Thu, 11 Apr
 2024 11:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411180256.61001-1-romeusmeister@gmail.com> <2024041111-tummy-boil-a6aa@gregkh>
In-Reply-To: <2024041111-tummy-boil-a6aa@gregkh>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Thu, 11 Apr 2024 20:28:17 +0200
Message-ID: <CALsPMBOx2LeNSL+i+7K3UZ2mvpDDRz0UVoAEuB0ouiEjk73pqw@mail.gmail.com>
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, Julia.Lawall@inria.fr, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This change allows us to put this pointer under automatic scope
management and get rid of node_put.  Besides, if a new code path is
introduced we won't need to add a new of_node_put.

Thanks,
Roman

On Thu, Apr 11, 2024 at 8:11=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Apr 11, 2024 at 08:02:56PM +0200, Roman Storozhenko wrote:
> > Add a cleanup function attribute '__free(device_node)' to the device no=
de
> > pointer initialization statement and remove the pairing cleanup functio=
n
> > call of 'of_node_put' at the end of the function.
> > The '_free()' attrubute is introduced by scope-based resource managemen=
t
> > in-kernel framework implemented in 'cleanup.h'. A pointer marked with
> > '__free()' attribute makes a compiler insert a cleanup function call
> > to the places where the pointer goes out of the scope. This feature
> > allows to get rid of manual cleanup function calls.
> >
> > Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
> > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > ---
> > This patch targets the next tree:
> > tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > tag: next-20240411
> > ---
> >  drivers/tty/sysrq.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index 02217e3c916b..1d1261f618c0 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sy=
srq_state *state,
> >  static void sysrq_of_get_keyreset_config(void)
> >  {
> >       u32 key;
> > -     struct device_node *np;
> >       struct property *prop;
> >       const __be32 *p;
> >
> > -     np =3D of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > +     struct device_node *np __free(device_node) =3D
> > +             of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > +
> >       if (!np) {
> >               pr_debug("No sysrq node found");
> >               return;
> > @@ -781,8 +782,6 @@ static void sysrq_of_get_keyreset_config(void)
> >
> >       /* Get reset timeout if any. */
> >       of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> > -
> > -     of_node_put(np);
> >  }
> >  #else
> >  static void sysrq_of_get_keyreset_config(void)
>
> Also, this change really makes no sense at all, the pointer never goes
> out of scope except when the function is over, at the bottom.  So why
> make this complex change at all for no benefit?
>
> In other words, properly understand the change you are making and only
> make it if it actually makes sense.  It does not make any sense here,
> right?
>
> thanks,
>
> greg k-h



--=20
Kind regards,
Roman Storozhenko

