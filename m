Return-Path: <linux-kernel+bounces-43484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4D8414A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA1C1F2554E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B56F1552F2;
	Mon, 29 Jan 2024 20:45:26 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E37602C;
	Mon, 29 Jan 2024 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561125; cv=none; b=bXAsDBSWKYh0wPnnRWKbX9pQYR8N500GA5QMzkGtq70AD59Qxo0gzrL5v4xswFW8bZDMPENV3WoiDV+ZNyr7pSTH45CZyrTX3RiIupyKQmJHPhVmmM1/c7//uKwkrK8FiYtW1r8PP7hzwfZuq5ChRX9koTrntpDn/COiUZmEd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561125; c=relaxed/simple;
	bh=wH59XtXAzJJua0WPMURILT065bEyBsmYhcbPLahSQXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ54WTWYPAxk9qmmERjv7HMOKewj9A8r2+2ssKmywzXvZ7w/2bgYYOfAgvrf8Vr7pUEs5Q1ExZrlqLHGdL908URbLRW2HtbnA9adygdb0ondKdGLwjmVeTDBN1e9/gOuzHHfXjqOVqw3GrmGRY7vqc8a4M0VNl/6Lrzogqp/PmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a1e21b0ebso556783eaf.1;
        Mon, 29 Jan 2024 12:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706561122; x=1707165922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvTbQy9VMHt6fnQCY3TVYNEIJh4tIcaNRd3FXe7uHFs=;
        b=uccwupb73DTrI1WK5X/i8gspTnpHYmHAc5ljB68qc4sxDKZZDMRQs1ahvD01Qnx78E
         fOwxfLDrSLnVR5U6DYmLcVFS9a8kgYO3IhS0UANkVIuiF4DysA1YBxhx5EEsidz3QWP5
         kLzH30NGMpoYMgJrbGKT5jCnbE3RFANaw7hO0NywF5jZnM8OyGBwhoxHnbAdnBhFhRaj
         ggfN71qBXZYWviRezGZvc/IVYVl+7OTVFgkYySicDOXTYWONNNahi1+LkgScDqfXAa0i
         Mo4uOf7MbIQlibysHPV0gZMp3+PAXvsFhYmTkCKU+NOFa5nGhE3NHZoyDW566jSfls7H
         w9Uw==
X-Gm-Message-State: AOJu0YzyRjFcwC4IcvUMmZhSJk2FmZ8X/TXHdiTsPg1S4yxwl2gIRU8Y
	+Wyc4aiFScFIj0qzTSvscRPgfTSAv0f/OCY9DKyqwQTF22F7Fc+cN8pI1k5oSJgPuIwtrW08nFN
	Zqrt4I/KeMAVXzBJVyH9dEzZM5WM=
X-Google-Smtp-Source: AGHT+IGXEdGhYxv86UV6LeFhYgPGovISemJErd0WIwGSlX5M1LIIFf32vuVoDsdxj7oCEiNyT9WxPgWzloe1o7AM1MM=
X-Received: by 2002:a05:6870:a2c9:b0:210:9749:d377 with SMTP id
 w9-20020a056870a2c900b002109749d377mr8058390oak.2.1706561122709; Mon, 29 Jan
 2024 12:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
 <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com> <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
 <921c2f90-fb8b-4e70-9e3d-6e185fec03b6@linaro.org> <CAJZ5v0h+93YBsYsA5rOvzp+b3JMGyjUStHA=J8P7ynv+-ym-4g@mail.gmail.com>
 <41b284d7-e31f-48b5-8b21-0dca3e23cb1c@linaro.org> <CAJZ5v0ina=7R6x6Ff=8_rRR9Kkmz2tkojbs_WWCN=JPmzhg+HQ@mail.gmail.com>
 <CAJZ5v0hM9Y+cV7WrEHe6WjzQ0ATnBce4NO1wxvZh=fcLWPkqKA@mail.gmail.com> <a522d8de-c871-4a2e-8b07-d5693abb4a7b@linaro.org>
In-Reply-To: <a522d8de-c871-4a2e-8b07-d5693abb4a7b@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 21:45:11 +0100
Message-ID: <CAJZ5v0g=bT4FcVHEOpU1H8EC8648EtDGEEyPL1DuwrU9_W87Zg@mail.gmail.com>
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Jan 29, 2024 at 6:54=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> On 29/01/2024 18:07, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> >> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> >> @@ -474,7 +474,8 @@ static int create_trip_attrs(struct ther
> >>                       tz->trip_hyst_attrs[indx].name;
> >>           tz->trip_hyst_attrs[indx].attr.attr.mode =3D S_IRUGO;
> >>           tz->trip_hyst_attrs[indx].attr.show =3D trip_point_hyst_show=
;
> >> -        if (tz->ops->set_trip_hyst) {
> >> +        if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
> >> +            mask & (1 << indx)) {
> >>               tz->trip_hyst_attrs[indx].attr.attr.mode |=3D S_IWUSR;
> >>               tz->trip_hyst_attrs[indx].attr.store =3D
> >>                       trip_point_hyst_store;
> >
> > So it looks like I need to submit this, even though I'm not sure if
> > anyone cares.
> >
> > In any case, I care about consistency.
>
> Yeah, sorry for the delay. I'll have a look at it tomorrow

Thanks!

Posted here with some additional remarks:

https://lore.kernel.org/linux-pm/4565526.LvFx2qVVIh@kreacher/

Let's continue the discussion there.

