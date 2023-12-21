Return-Path: <linux-kernel+bounces-8654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C544781BAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8794228CCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687CF55E65;
	Thu, 21 Dec 2023 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="EC5osMho"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E1539EA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e39ac39bcso1223090e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703172323; x=1703777123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTc60XXBlmPn1aI05CMP8r4opL7x1haFLl5cOZ/ZbGI=;
        b=EC5osMhowcCpdp+KcMiNXv8VAUmTkyMV5hsCdjbLXd5CgBslC/f3Tb7NaqTUJF7XgJ
         rQvUmmGOyySDgrgO2gHtn0XhlEDKP7UjZRJWKD4nHZQojaKiwpsuyDx6QyRK/aFOQYos
         23ZAKDNnEP8V4OGgcTh3qc6Lv5Fsu8d8jkAdZ1OqyrIo2fr0S1v3cEhLsFr8j1lyRWyQ
         M6Vyvlt+tUMZmfoDZyuFL1UgFomdKkxN8pO+fIeXfkGXqTau2dBaeMerqGrk2i8L68hU
         Xs6fQaG46W1vuTt0EU2RlL6RDZpkx+ZwBcNCavDdXLoEW2F078+jfupQ2fFYo4caWR60
         OKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172323; x=1703777123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTc60XXBlmPn1aI05CMP8r4opL7x1haFLl5cOZ/ZbGI=;
        b=WypoWt1QUMqw2HMp7SszwZy01Fjo1Kz+zngwTcSTsejcV6oKTSJjro9oSqtwPwaH3R
         fOxBZTeio2qmaLdITRXSZiN20C7cAI5Lo6hurAklQf/aaXTNJL2wfTuXWmxlUX8J1I6W
         bYUPZf4bdrBP09hy3VFA6mjiamAXL6tr+eB8kquDZoFW1nW+c/u/mhmQ7UnV4ee55w9D
         t5WqCaTd1XTq+kW2NizCvi3TSk+8hIC9YIN4tSy7/HkQFetZA76+oln3GMvHlk7yD2Eh
         HM7J+kWn5Ncsd5LWtFvDOVHPJHHeANpB+PRWgRRa/qTxRxH12VImrX/o2WKTDU4OcZ2R
         0axA==
X-Gm-Message-State: AOJu0YzxtRUl5H/FcFBIO7BEnFm54n/Z2L0bsNqzdBD/2H8bYan2hh6B
	Y/7QKAub6Ak9/TYw1DHJlJxAhFpnmHhNcYiQRgG6
X-Google-Smtp-Source: AGHT+IGQ7+vn5vt/vIXBM6HJC7KyuA3tzQMbqE8QVr7N88NGH5q8oaLow4llkHhF1zff1ckU+MKjT6EQFm+lvwsFzog=
X-Received: by 2002:ac2:4c43:0:b0:50e:cf8:b168 with SMTP id
 o3-20020ac24c43000000b0050e0cf8b168mr4335698lfk.208.1703172323269; Thu, 21
 Dec 2023 07:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com> <bdc86387d74ea059d04f301df414ee3d6564634d.1701993656.git.jim.cromie@gmail.com>
 <ZYB-v4Vp1mj-jVl_@alley>
In-Reply-To: <ZYB-v4Vp1mj-jVl_@alley>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date: Thu, 21 Dec 2023 16:25:11 +0100
Message-ID: <CAK8ByeK0K21qae35KoC_3bHUa4qvkFt5pMbBMEo2pnWjoxJvxA@mail.gmail.com>
Subject: Re: [re: PATCH v2 00/15 - 07/11] dyndbg: __skip_spaces
To: Petr Mladek <pmladek@suse.com>
Cc: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr, 
	daniel@ffwll.ch, dianders@chromium.org, groeck@google.com, jbaron@akamai.com, 
	john.ogness@linutronix.de, keescook@chromium.org, ppaalanen@gmail.com, 
	rostedt@goodmis.org, seanpaul@chromium.org, sergey.senozhatsky@gmail.com, 
	upstream@semihalf.com, vincent.whitchurch@axis.com, yanivt@google.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pon., 18 gru 2023 o 18:17 Petr Mladek <pmladek@suse.com> napisa=C5=82(a):
>
> On Thu 2023-12-07 17:15:10, Jim Cromie wrote:
> > This private version treats a comma like a space.
>
> Please, make it clear that this patch adds a new function.
> Also please explain why it is needed and what are the effects.
>
> > Its not known necessary ATM, but seems prudent.
>
> It might be that I am not a native speaker but I can't parse
> the above sentence at all.
>
> What is not known?
> What is prudent?
>
>
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  lib/dynamic_debug.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index a380b8151dd8..c974f6e19ca1 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -628,6 +628,14 @@ static int ddebug_change(const struct ddebug_query=
 *query,
> >       return nfound;
> >  }
> >
> > +char *__skip_spaces(const char *str)
> > +{
> > +     str =3D skip_spaces(str);
> > +     if (*str =3D=3D ',')
> > +             str =3D skip_spaces(++str);
> > +     return (char *)str;
> > +}
>
> The function should not be called "skip_spaces" when it skips also
> characters which are not typical white-space characters.
>
> Also the "__" are usually used the other way around. func()
> is usually a wrapper around __func().
>
> Please, use another name. If you can't find a good name then
> it suggests that the design is bad. The result would likely
> be hard to understand and maintain.
>

I will update the commit based on your comments.

Thanks,
Lukasz

> Best Regards,
> Petr
>
> PS: I am sorry, I do not have time for a proper review. I primary wanted
>     to check if the patchset somehow affected printk(). And I realized
>     that I do not understand what the changes are about. The commit
>     messages and the motivation might make sense only to people who
>     know the big picture. But I was not able to get the picture
>     for the changes in dot,comma,space handling.

