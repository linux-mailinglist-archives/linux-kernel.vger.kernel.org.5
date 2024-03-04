Return-Path: <linux-kernel+bounces-90651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D888702BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EBB28AC8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC33E497;
	Mon,  4 Mar 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/OZTe3P"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E13E47B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559002; cv=none; b=S7FIZYfUhEIrsmkc3+bhm8AMcLT5s/8VANhBVqC+5ZrvIKzvdIemLRPbuQiMxXDojomalamJVTYr29nMs8dLtBLE64Eyv+boO6pInibAYBxoADAmU3gIJDIVOc2iYp+x1GHs3pL+AIB8DUNxT1RP+tmnyCb/oNYyphmcSvuruLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559002; c=relaxed/simple;
	bh=Kvq+eQLmzuwBXg3/KAnR/i8Z5XbQ5PFh19ze8XW00cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVXujVukzbDuCcKR60DaKpap+xvMjz4Kg5DdluVV9pdtBqfpjJh4+SC4VHVju27yH/h7MWWmCz939Grri3eZt/biZnjwfarRSplrzik0XTxeqZvp6AG2CXTg417S30j5Tz0u2iikh28sgxygsoIdeADYJROWEwlb5yDCtdkmpXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r/OZTe3P; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a0a19c9bb7so3608945eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709559000; x=1710163800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e7MvSyz7Z89OuXpqB0EkQOVRxLJ+Jq5zuJtp0kF1KA=;
        b=r/OZTe3PfCJ2y/Yd5bp7Hgi8sUdok2nya2byx8oDkSUPC2M1aYIHxgwx6Ps7hKP03Y
         Y9hPF1yuJ7fcw+DMfnmpauvUROQ8XoH/55D8vDOAONsqayJK2P2H1B2oBI37cVQi+LMO
         VxkhtZxB6JcpOvBPTXJUUCSZ/tWPVpmPZ6IutO30ie4Ei0sCROrQg0GSm4sRrZ5RC74w
         Nf3vHkWlVTChjOFKfjxa91XQxLkQJ7QP52qJUNF3Ko+nUo5+BP06LIEIH2GeoaxRyEsd
         7o6+kPqaTwck8sRoJ4/ny2QJMpyHW29loqyZdTVcLIcSaWRtsXulDpMWhgM/ufEqj85K
         H3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559000; x=1710163800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e7MvSyz7Z89OuXpqB0EkQOVRxLJ+Jq5zuJtp0kF1KA=;
        b=IJzYuEY1lhuqP72ADsmp47nStjyCyFy9kRSbw1v/beOhm8jMtn3oKq8tt8hzy90luP
         aRzxGLABuzkT8x5VGPI7kKohL8C83wQycMMs8qC/eRcXUlmBPJz21VMhE0R3sCfpeKyp
         t3xvPIDp/va8kdA4AWpyEqaCcnVj4jnvsddzzj2umHF/ADxA6Nkja3Iz7jCZI31uI+T1
         /bUOAi3SxipLdfLhvAva1Lje31QmG19fDW5eMA0cExLSbG1/DF9464GnC8XOPjYrzPPH
         ypAmzfWbkOAHzNH5c6RE0i1QLT08ngyDOINEkn4lK797trMsZuNkJa39R1HMK6Kjm9pJ
         o9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUDNeGh22yEb2PqwIIbDXxPfgtG1Axmw9wnp95+2xufPBIxkEoZRaItv0LStM0xpvF6J1IXroO9oF8xFhhHIOwBZ6bagLQvSK+f31Zz
X-Gm-Message-State: AOJu0Yzf1qpgNqHWqtH2Tq8Kh8fZ8TS2XFPKfhFFnYxQ5U2YQ+mXbLO0
	8g+qd9UzE+Jtv1+S2WdaD0bpGnb/0tqbt7VHyQCmAw81ipvRBDnGdFOTdn1j8sP/pJevDWTC0lr
	RYWtJcgIekkoz/dmbhj+dt8Q843/zmtvowRtzHg==
X-Google-Smtp-Source: AGHT+IFWKof4pbS0vl916ObLdAYi8NdADtcGYWdAKnMOW9r3+pOIJUpi024cyHkbmZimO/UAKryy7xGAUnICBATSPAI=
X-Received: by 2002:a05:6820:1c8d:b0:5a1:27ad:9b9d with SMTP id
 ct13-20020a0568201c8d00b005a127ad9b9dmr4368315oob.1.1709559000241; Mon, 04
 Mar 2024 05:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301143731.3494455-1-sumit.garg@linaro.org> <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
In-Reply-To: <CAFA6WYOdyPG8xNCwchSzGW+KiaXZJ8LTYuKpyEbhV=tdYz=gUg@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Mar 2024 14:29:49 +0100
Message-ID: <CAHUa44HWiWNab1TbQxHVBZOpqbp+XhNGSNoL+pXrv7xJkHShxg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, op-tee@lists.trustedfirmware.org, 
	ilias.apalodimas@linaro.org, jerome.forissier@linaro.org, 
	linux-kernel@vger.kernel.org, mikko.rapeli@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 4, 2024 at 6:45=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> + Arnd
>
> On Fri, 1 Mar 2024 at 20:07, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > The error path while failing to register devices on the TEE bus has a
> > bug leading to kernel panic as follows:
> >
> > [   15.398930] Unable to handle kernel paging request at virtual addres=
s ffff07ed00626d7c
> > [   15.406913] Mem abort info:
> > [   15.409722]   ESR =3D 0x0000000096000005
> > [   15.413490]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [   15.418814]   SET =3D 0, FnV =3D 0
> > [   15.421878]   EA =3D 0, S1PTW =3D 0
> > [   15.425031]   FSC =3D 0x05: level 1 translation fault
> > [   15.429922] Data abort info:
> > [   15.432813]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > [   15.438310]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [   15.443372]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000d9=
e3e000
> > [   15.455413] [ffff07ed00626d7c] pgd=3D1800000bffdf9003, p4d=3D1800000=
bffdf9003, pud=3D0000000000000000
> > [   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> >
> > Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumerati=
on")
> > lead to the introduction of this bug. So fix it appropriately.
> >
> > Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218542
> > Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumerati=
on")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/optee/device.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
>
> Jens, Arnd,
>
> Is there any chance for this fix to make it into v6.8 release?

I'm picking up this and have also just sent it in a pull request for
v6.8. If it makes it into v6.8 remains to be seen.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> > index 9d2afac96acc..d296c70ddfdc 100644
> > --- a/drivers/tee/optee/device.c
> > +++ b/drivers/tee/optee/device.c
> > @@ -90,13 +90,14 @@ static int optee_register_device(const uuid_t *devi=
ce_uuid, u32 func)
> >         if (rc) {
> >                 pr_err("device registration failed, err: %d\n", rc);
> >                 put_device(&optee_device->dev);
> > +               return rc;
> >         }
> >
> >         if (func =3D=3D PTA_CMD_GET_DEVICES_SUPP)
> >                 device_create_file(&optee_device->dev,
> >                                    &dev_attr_need_supplicant);
> >
> > -       return rc;
> > +       return 0;
> >  }
> >
> >  static int __optee_enumerate_devices(u32 func)
> > --
> > 2.34.1
> >

