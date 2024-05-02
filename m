Return-Path: <linux-kernel+bounces-166003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC88B949E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBCF1C21472
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16407219F6;
	Thu,  2 May 2024 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqTVVEol"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE646200C1;
	Thu,  2 May 2024 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714630808; cv=none; b=uzq1uY47CbC6uLvwJdEM23KvLvqMNZDkA1YT5fcn6yqhK9EvY5FiOaXpdDA/nXaSTmjBz9r9vyGOuZGgKVCR3sVS7tbB3K/EOMxcBUKcl5qBNfA5eDKG9nMMCquIXO9AlinDQsKn9QaZJNP8QkOXz/U6XQZGSqol1X9eLrDn78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714630808; c=relaxed/simple;
	bh=VyEoVuiaYCnu0a/sKyNsC18VH2c5Qw5Z3+UdTP90Fug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N93pCgH+jB1PNkl5krLSbN2d/nEes3dYtd0115xLnPLz1oDDCh/lauGRgjKsRq0/rd/cy6hm2dp3Zx3w9feiRb1vv9Q/FmTWzBs6aRCB6gcEo/4rDt5/6AN0F//VEGxKfS7guNnpd9XVEC+cptBMA3y+zgJT6mUV7MH+G4/EYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqTVVEol; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so6554148b3a.0;
        Wed, 01 May 2024 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714630806; x=1715235606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgakmapef0h80N+jtF51dv68wB35uuo/PTTHrmoZruM=;
        b=BqTVVEolUJyh/CheLOOPtRpcxVOz9v4F/x4ahStM3onwr9515GZigWIGOedg46Nr7z
         /CWCbSn58xmjgTiGRnayFpXEdr0zDCnEjAqzfEYhc16UwQX7HOv+wq0xnqxTJoAQE0d+
         9I9ngQodH6sxLpi6gQU1U9pE8Ha+2xW+2w67DfxXTjFzxwuY8z1WE+Q07INSEkJ7Jpb9
         kCfKuBdSn8IarYGXAxu7qmqZJfiDCUZOYTgI2YBhp/YWA36UiAHJjbFTpBAwFORcaOGY
         /jnW9yL6pD4kj01Pmbw8xi4WPgrMtZ/8EjZsHRtf/k2DCG689QohuZQ6PNl0qG9kj9Ia
         eEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714630806; x=1715235606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgakmapef0h80N+jtF51dv68wB35uuo/PTTHrmoZruM=;
        b=fAGId7FQR6CYotcwNgRa63PJv7AiQmBKNWqNfqB/C9EQVzkm9vfYDMd45xSyFTTlG9
         zRvZUfpNoywzX/9oRMvJZrGhci5tyK4Hm2rBF4i4K4P0MQzVftb+1amhfsrO92UBZ9/k
         LtRRvmtSO6PxOXnGYQ1tY8v/Hq9/AgUq3aMREWKzW74pmN/r0A6rU9VY9p4yBJLrDF0V
         jkynA5O8xHPhra31Nm0ORhjD4r4+bfrds88mooJ92itQh3nHACcggd0Fx32xpADkh3Ja
         VrfFwBBzxyVnuSUBpsLIiOWkoxGKdYCgGY4a8AGqTrV1VcnxtxEnaN0yEv+KXEX94r7f
         xa9A==
X-Forwarded-Encrypted: i=1; AJvYcCWr+AOYa9glw7JPZX1j7VriXbqkYERYM2lsOv0pFHJNmoFglT1zOjlKb9Qhkb5fPZlJeM2x6F7v8w/AQVmxmwDAzYl64G68lozC/iUhxHvW6rwM8Y+TRPibSirkHUt0GVQaRsp+ViI1wKk=
X-Gm-Message-State: AOJu0YxhdY2rasp0pnEYzA7hODiJ0wOa0tJvpXVDi7eKhmhZP6j2tpRR
	MGOE6U7tLj2+0dGBQCnUiJYviOavGu95iMFGBX4P7erW03ddBWzyDKYGMOIB3xzWf9DcvJ1E4WV
	r/m4w4E02K9Z0wUBSvSa225PcAq4=
X-Google-Smtp-Source: AGHT+IGw7RzP7UzHjMbV/OepNR4EpONmEDOtas5IFiGjBTRnwEvzrxz/pCfwVHCFI9ryiW74MuQPtzxxUTUbsrc7WiM=
X-Received: by 2002:a05:6a21:6d8b:b0:1a3:ae75:d6f5 with SMTP id
 wl11-20020a056a216d8b00b001a3ae75d6f5mr6426998pzb.20.1714630806165; Wed, 01
 May 2024 23:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501125146.33648-1-prosunofficial@gmail.com>
 <20240501140144.GA10180@aspen.lan> <alpine.DEB.2.22.394.2405011618351.3278@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2405011618351.3278@hadrien>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Thu, 2 May 2024 11:49:54 +0530
Message-ID: <CAE8VWiLZvmeMdR5rsJ7vugXPyW6ABMZZwPRhJ=iU-KXqOJZ77w@mail.gmail.com>
Subject: Re: [PATCH] backlight: sky81452-backlight: replace of_node_put with __free
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, R Sundar <prosunofficial@gmail.com>, 
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll remove the unnecessary braces and resend the patch.

Regards,
Shresth

On Wed, May 1, 2024 at 7:49=E2=80=AFPM Julia Lawall <julia.lawall@inria.fr>=
 wrote:
>
>
>
> On Wed, 1 May 2024, Daniel Thompson wrote:
>
> > On Wed, May 01, 2024 at 06:21:46PM +0530, R Sundar wrote:
> > > Use the new cleanup magic to replace of_node_put() with
> > > __free(device_node) marking to auto release when they get out of scop=
e.
> > >
> > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > Signed-off-by: R Sundar <prosunofficial@gmail.com>
> >
> > Thanks for the patch but I think this one is a more appropriate
> > solution to this issue:
> > https://lore.kernel.org/all/20240421104916.312588-2-shresthprasad7@gmai=
l.com/
>
> Maybe neither one is perfect?  The one I see at that link has:
>
>         if (!pdata) {
> -               of_node_put(np);
>                 return ERR_PTR(-ENOMEM);
>         }
>
> which has unneeded {}
>
> julia
>
>
> >
> >
> > Daniel.
> >

