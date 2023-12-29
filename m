Return-Path: <linux-kernel+bounces-12943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B2581FD02
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 05:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E828523C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B8220E1;
	Fri, 29 Dec 2023 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOutGeEu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF6612A;
	Fri, 29 Dec 2023 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f911e9ac4so52092886d6.3;
        Thu, 28 Dec 2023 20:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703824222; x=1704429022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siCP+01Rw8sv/FO7/j37qD22Hyz6Ky5dYCZkzYaFy1A=;
        b=ZOutGeEu/ET9I/Xj7NX/Bq4uu9+rlJqjwRE3ibopi5K3KrQ6yl7saBTKnHtoSDSeJ7
         tvMAxVac2l5j0ZFeljLOxCJHkDr2c3T/uzjWXBUUVd+2ypggSVKinVfRO7wMJb/Xj4pq
         Wo0o7b3sMIYl77b+Wql7fx9uPOBgnKnVZKJwEip33l1/5SeIck0py9n/dmkDG0JVibrz
         TbyDru68l7VWdJsDmJb1xhV6tJey7BmRZDib0VhtsWsZTrZbr8EPWyuQa6NQMB2GUV+W
         UEQzm+aMz+OI2ZAJkMwhaH2uEsHV6hTPJuCQOsGb4atf2xoRJghVP686jOHOCzI5sEgB
         d2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703824222; x=1704429022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siCP+01Rw8sv/FO7/j37qD22Hyz6Ky5dYCZkzYaFy1A=;
        b=XtqyedDunN2NF6ma/hD3iIxN8lLW6lfY9adQ0g/KuVL/Wyt2HidQd2dPDld6dep0D1
         /rLGLBJGvkUzcRRtQpGEMruRAm8XRx+WwdRbbx61EkJ7jVtkBq8Ux7bQ7pEb7cHUOHoi
         bleeq4rUWOUNrdSAnNF66CL/fXgmtxkvdODFPd8ZfNK1nptq3erwypQ0l6uwOjsOzQeD
         wrCbeigDky1qa9+TaYOOFWsrFEx0qd9pb7ZG4OtIzFPcWqXcM7fjWD13pyljiiY/SX4i
         Su6Uc8J5ODbghIja+yRFjtT+N7sz2cgsIbMb3BSvZlRE2WzqSA43w7b9mjqzKKj9BBqn
         LlkA==
X-Gm-Message-State: AOJu0Yxt1Gt/kW/GqAsMxDqvvpnjYAkswOas4l+m8gBsPQb6KxsOaRpb
	ZDfFDQ8+353KnCFn0VtMYMpgOR0dGJqKV5mxw7A=
X-Google-Smtp-Source: AGHT+IFLFR3I5Dh5jwn9n1wg7C45v+vP5k/zr57xOfGbcX2de+sdM9KRc5F7XePdRKzEt+cWvvhK4tkefp5TJfXXbZ8=
X-Received: by 2002:a05:6214:90b:b0:67f:fc06:5ae3 with SMTP id
 dj11-20020a056214090b00b0067ffc065ae3mr7080443qvb.81.1703824222067; Thu, 28
 Dec 2023 20:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228103921.23839-1-di.shen@unisoc.com> <CAJZ5v0jYX8QJjFzOTSWFf7PnBP+twm3Ww+9MVqwAsJrPx1fycQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jYX8QJjFzOTSWFf7PnBP+twm3Ww+9MVqwAsJrPx1fycQ@mail.gmail.com>
From: Di Shen <cindygm567@gmail.com>
Date: Fri, 29 Dec 2023 12:30:10 +0800
Message-ID: <CAHYJL4p9ocr1FsM_Oc-p-H=NzfVuU3=8NYBwSV8oi+_vNuVUPg@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: export the governor register related API
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Di Shen <di.shen@unisoc.com>, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuewen.yan@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Fri, Dec 29, 2023 at 4:24=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Dec 28, 2023 at 11:39=E2=80=AFAM Di Shen <di.shen@unisoc.com> wro=
te:
> >
> > To enable users to register their own thermal governor,
>
> Why would anyone want to do that?
>

On Android systems, due to GKI restrictions, vendors cannot modify the
kernel, and
vendor-specific changes must be loaded as modules, so export this symbol so=
 that
vendors can load their own specific governor.

> > this patch
> > exports thermal_register_governor() and thermal_unregister_governor().
> > This change would not affect the registration of the default governor.
> >
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >  drivers/thermal/thermal_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 9c17d35ccbbd..56695988e20f 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -167,6 +167,7 @@ int thermal_register_governor(struct thermal_govern=
or *governor)
> >
> >         return err;
> >  }
> > +EXPORT_SYMBOL_GPL(thermal_register_governor);
> >
> >  void thermal_unregister_governor(struct thermal_governor *governor)
> >  {
> > @@ -193,6 +194,7 @@ void thermal_unregister_governor(struct thermal_gov=
ernor *governor)
> >  exit:
> >         mutex_unlock(&thermal_governor_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(thermal_unregister_governor);
> >
> >  int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
> >                                    char *policy)
> > --
> > 2.17.1
> >
>

Best regards,
Di

