Return-Path: <linux-kernel+bounces-89688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05A586F434
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9821F21C35
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D32B653;
	Sun,  3 Mar 2024 09:48:53 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB09AD4C;
	Sun,  3 Mar 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459333; cv=none; b=U8RMRZ7QLORiT2QbPV5Y/Zz4yYJ7Yh7N9AD8dR9KsgUfs2nqUjM/dEXnPMQtmzDVnGyV9k/PJnmeKDITsG113KWFPdAS15fBvnKmcB4hKSByKXf+kFYk0M67zpFUDbnlBi6/Xg+3KF5YPcySU+ALddi03VmWiwlAQWEw/32PLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459333; c=relaxed/simple;
	bh=bjK/QpzZZjmi5O8zqPA7HxcV0JNdTcW4PUAupyqpja0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqhVLtbXtlrCDBogEBwp3XMVd6NlMEAyUz/7t+IB8bo/V7vnmd621F3yfAzDUGzm1jAr5OuVcw6PijDts4dVSr5Pd3ckX+a9Pwa5ahmjwWEnMuH+zbHmR/euodXj7ObWAVJHBMB9+aQItQzo7zO/bTow3Bf4kjTmOLXuMaHmbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6098bf69909so13179067b3.1;
        Sun, 03 Mar 2024 01:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709459329; x=1710064129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDfgszw4BmF3vxq2jfZyuRkGTM2CQmFgMgyb+UG5yqk=;
        b=Or7dz3PbbmePczUFECf5hPYpgt89fJmRA5ugWhCcIndHyh/xbk/hvdy2f3Px4/3jVd
         HX6XsmgvycNHV0wpa42Bf5GE+rUaWMfrbJ6ChLHM5pdqiuB6jshzxf1uXPBT2qjjlvUy
         zz8P/9dYchNJc/bTaW1kBdC3DWTBDrfbAIGv83B/5NvgLh744CP0NMyLjy6s6aqKsQGo
         REmFDeINZoz5vaqnCkPi3SOCMUsc1I2LfkHxm2vpPYD5SpU6ECBkwE8fAR9NKCDpo+vO
         DQKoLEdauPLU1REcrApJTug8OtTYi+6MsGBgIR7XAGmANxJ8H8EPFMAt2sIdp2BeOE/h
         p6dg==
X-Forwarded-Encrypted: i=1; AJvYcCV/Coc3EryfPPaBH0fWI1bMap3bUfgatlj1Gt6df24T1iTVjjVREhmJBhq2NHB8hUVBXIKg7xJDb5LJiYUOm76nzrAOM0vCkzVOnWQ78TNr4N38twhem/EhfxnLu3edFSvXu/IHItUNNiWSz653eWeDTTgIm31/D+gio6F7dgX5Oc1KZ54=
X-Gm-Message-State: AOJu0Yy2eVfoinZvp0fHjcgaNujYOswZJTdB80Wv3u0gE2TAuVeoHjpI
	1UrqTbHVZE138DYXqV9LkU2x0PJ3QWyLoDW+YV7QCHGoBIqcCESxhwPX2NEk/sI=
X-Google-Smtp-Source: AGHT+IG8V5hUPDxaLY0W7edk8QCeOsetzRPwBli4qomB6GBeOBqnFE7vQ0HwriFQwxsF96zDuSFNbg==
X-Received: by 2002:a0d:d746:0:b0:608:cc10:f4f4 with SMTP id z67-20020a0dd746000000b00608cc10f4f4mr4225764ywd.16.1709459329501;
        Sun, 03 Mar 2024 01:48:49 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id t19-20020a81b513000000b0060894d466ffsm1973001ywh.121.2024.03.03.01.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 01:48:49 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3189625276.1;
        Sun, 03 Mar 2024 01:48:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC8fVvFQ00B6Owx/lxfZbA8iZLQBjzMgMEjF62IzjpBLoMJalqKCwku842dMhRZAmSE19QhEz3b/A9erg0tZyIWRdFQ3gfjXK0xC4QIopIzJ0qiUeyCYFbK2L0VzQq3wH2vkuD3zjxCQ2NhQWq0GR95Zgknyl/qBxoJKedxW5KQSsgAJo=
X-Received: by 2002:a25:8301:0:b0:dc6:ab85:ba89 with SMTP id
 s1-20020a258301000000b00dc6ab85ba89mr3783078ybk.25.1709459328258; Sun, 03 Mar
 2024 01:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz> <ZeIdXIx5zYjKQiSO@smile.fi.intel.com>
In-Reply-To: <ZeIdXIx5zYjKQiSO@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 3 Mar 2024 10:48:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
Message-ID: <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
To: Andy Shevchenko <andy@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, pavel@ucw.cz, 
	lee@kernel.org, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Mar 1, 2024 at 7:24=E2=80=AFPM Andy Shevchenko <andy@kernel.org> wr=
ote:
> On Fri, Mar 01, 2024 at 02:42:03PM +1300, Chris Packham wrote:
> > Use the dot on the 7-segment LED block to indicate USB access on the
> > x530.
>
> As I said, I'm not going to apply this even with Acks.

I guess you should not apply any of the dts patches to the
auxdisplay tree anyway?

> The problem here as I see it is the future decision on how DP should
> behave like.  If you put this into DT, we will to support this to the end
> of the platform.

As there exist 7-seg displays (and wirings) with and without DP,
the 7-seg driver and DT bindings should handle both cases.  How to
wire/use the DP LED is up to the hardware designer / DTS writer.

I agree it's a thin boundary between hardware description and software
policy, though.  Is that your main concern?

> So, drop this from the next version. You may try afterwards to apply it v=
ia
> different routes (will be not my problem :-).

Exactly ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

