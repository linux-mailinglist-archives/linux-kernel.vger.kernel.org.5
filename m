Return-Path: <linux-kernel+bounces-135723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655389CA51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C09B29BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A13143867;
	Mon,  8 Apr 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioHiPICM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BA142E79;
	Mon,  8 Apr 2024 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595910; cv=none; b=MzP2A+KVuIZn1ipZxcsO/Vv3tCOaRzH5aAO9/Jle/lK6A31R+vQzhZ1KDj2QgRKoDuaYsdp63LUWRK8EpYPIhBauRwfXGkbJlWFhW1Rtt7yZrR94jxuzg/kU/4KzhDlE/cLRrEc3OKQ/4+FJsWGDVwjWY5TClDzwdvH0jjazIWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595910; c=relaxed/simple;
	bh=q3aHEkDIaUg/6DDpl2Hw0IWOkW0evQ42aHBcgH6sLDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQsW7Im/7vamuj7ccQLaw8PNV0IuxCUmnT3W1UN0gvwAFFqP/8Yyl5l9UtBDZQ4jz0OdUm7j5U5ZJVJUat9SknsZj+1N5Lb5frmjj8leDNrhuJpYK41vg+Hzhm72S7Ft5+LY4eE/0VfFokrgxS5bMiCt/SbZfSPyXlDUiJQZ9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioHiPICM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFABC433C7;
	Mon,  8 Apr 2024 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712595910;
	bh=q3aHEkDIaUg/6DDpl2Hw0IWOkW0evQ42aHBcgH6sLDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ioHiPICMdv/jEMGntcCv9aUV/MVpOZZDfda4pKRK3afqjK/qbxUA2oECXtWD0joET
	 iiQWyqwAtSU5cFOmNQ5OUxdWsYd0oydyfmaYzmJ6lzb6tM0KGe2HVLp3qL+xqL5VnG
	 69qN5d0DGlpowOhzRz6uwZJyNGoxEL6zBe6m90BJe7akUXvG0MPOoitCpLPOgYVhrL
	 f2IYzUS3hGGp2tUMYXdhdhC8nZijZqDUYSr6X8C8wCkZ6XdbZjpueNtSry8p1pRanD
	 rz7wAP0uBP0nCal1oa5/RCw3N0R8cZOBZhPjDxxC+pgi1dART1qBuAO0QC3g5MDmPj
	 845tkPFRYlLyg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5aa17bf8cf0so256422eaf.1;
        Mon, 08 Apr 2024 10:05:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaD95n6HDAKNVjJt6LrAxzzAei/4GhTiODObAwKZLVEkNZGaO5zFpNV5sv4oUZrBoGH5g6CcW2HgSazgsaqVwrwJwWDb8TSTQc+RMPwV3/IP/ivKS9Dk7KIial6SRAwEBqulooT6QNiS7Hn6LXkq2KqNaz7qXfIoMvClvYhop6Zzout1PO0UYwi3rlDLQ=
X-Gm-Message-State: AOJu0YwK7h6vf+we6QCuIok5a7KC/vPeJ++BOHD+qbh0d3S48E6uGQ9O
	mdt3TA3tMl4DlNM8XZKK8Jxi3ZOurv8e8r9QYq8HlV0GgmZnDH4LVRqFHOlvQX+y4sjh5J018ni
	V/gLu+yynRWgpPSA7o6bIgdUFvEM=
X-Google-Smtp-Source: AGHT+IEzjnPGX0iQ8amIZ3HV8gdrikLJRs4fdK6C3/HmSvcFMJx6nS6t2DWmTLeaL50L22e7Wnf/dcbFETWvuhpbUZc=
X-Received: by 2002:a4a:d0af:0:b0:5aa:241a:7f4b with SMTP id
 t15-20020a4ad0af000000b005aa241a7f4bmr5545431oor.1.1712595909295; Mon, 08 Apr
 2024 10:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712360639.git.soyer@irl.hu> <afd975d98708921f67a269aaf031a1dd1be1220d.1712360639.git.soyer@irl.hu>
 <4e37511c-7570-4ea5-bdf9-6bdd62c63575@redhat.com>
In-Reply-To: <4e37511c-7570-4ea5-bdf9-6bdd62c63575@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 19:04:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jD=xECU=et=YHYbykyDjz4cBi6RvjmUrf4shzV2dJzRg@mail.gmail.com>
Message-ID: <CAJZ5v0jD=xECU=et=YHYbykyDjz4cBi6RvjmUrf4shzV2dJzRg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ACPI: platform-profile: add platform_profile_cycle()
To: Hans de Goede <hdegoede@redhat.com>
Cc: Gergo Koteles <soyer@irl.hu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Ike Panhc <ike.pan@canonical.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	=?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:41=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi Gergo,
>
> On 4/6/24 2:01 AM, Gergo Koteles wrote:
> > Some laptops have a key to switch platform profiles.
> >
> > Add a platform_profile_cycle() function to cycle between the enabled
> > profiles.
> >
> > Signed-off-by: Gergo Koteles <soyer@irl.hu>
>
> Thank you for your patch, 1 small remark below,
> otherwise this looks good to me.
>
> Rafael, may I have your Ack for merging this through the pdx86 tree
> together with the rest of the series once my remark has been addressed ?

Sure, please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to this patch.  Thanks!

> > ---
> >  drivers/acpi/platform_profile.c  | 39 ++++++++++++++++++++++++++++++++
> >  include/linux/platform_profile.h |  1 +
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pr=
ofile.c
> > index d418462ab791..acc606af812a 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -136,6 +136,45 @@ void platform_profile_notify(void)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_profile_notify);
> >
> > +int platform_profile_cycle(void)
> > +{
> > +     enum platform_profile_option profile;
> > +     enum platform_profile_option next;
> > +     int err;
> > +
> > +     err =3D mutex_lock_interruptible(&profile_lock);
> > +     if (err)
> > +             return err;
> > +
> > +     if (!cur_profile) {
> > +             mutex_unlock(&profile_lock);
> > +             return -ENODEV;
> > +     }
> > +
> > +     err =3D cur_profile->profile_get(cur_profile, &profile);
> > +     if (err) {
> > +             mutex_unlock(&profile_lock);
> > +             return err;
> > +     }
> > +
> > +     next =3D find_next_bit_wrap(cur_profile->choices,
> > +                               ARRAY_SIZE(profile_names), profile + 1)=
;
> > +
> > +     if (WARN_ON(next =3D=3D ARRAY_SIZE(profile_names))) {
>
> Other code in drivers/acpi/platform_profile.c uses PLATFORM_PROFILE_LAST
> instead of ARRAY_SIZE(profile_names) (these are guaranteed to be equal)
> please switch to using PLATFORM_PROFILE_LAST for consistency.
>
> Regards,
>
> Hans
>
>
>
>
>
> > +             mutex_unlock(&profile_lock);
> > +             return -EINVAL;
> > +     }
> > +
> > +     err =3D cur_profile->profile_set(cur_profile, next);
> > +     mutex_unlock(&profile_lock);
> > +
> > +     if (!err)
> > +             sysfs_notify(acpi_kobj, NULL, "platform_profile");
> > +
> > +     return err;
> > +}
> > +EXPORT_SYMBOL_GPL(platform_profile_cycle);
> > +
> >  int platform_profile_register(struct platform_profile_handler *pprof)
> >  {
> >       int err;
> > diff --git a/include/linux/platform_profile.h b/include/linux/platform_=
profile.h
> > index e5cbb6841f3a..f5492ed413f3 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -36,6 +36,7 @@ struct platform_profile_handler {
> >
> >  int platform_profile_register(struct platform_profile_handler *pprof);
> >  int platform_profile_remove(void);
> > +int platform_profile_cycle(void);
> >  void platform_profile_notify(void);
> >
> >  #endif  /*_PLATFORM_PROFILE_H_*/
>

