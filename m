Return-Path: <linux-kernel+bounces-117407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250388AAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E861F64D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221B142E9E;
	Mon, 25 Mar 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Wo8KBzsZ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265C142E85
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381722; cv=none; b=NcJAX9/+oa519/iH243g/bZcxeFdOl68kPzxA6IxS9aZ4VgKVGpmaIA9KcdUWc6iL+J2hEtUfkkiFH/4Sg8p4jKxEZWDYVOn/0ewU6xbhW2xPNi8Y93oyCnPIsh2j3/KQc6Rs+xJhoVY8oHnlVhEv0WEXaFVBF1RaOgF0JYND6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381722; c=relaxed/simple;
	bh=aJbqtcT5Qk/lZjpWEh1CyTzQTjAlrrxanun/S9rh2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPee1xnMs0xa4aUXwBSDJLx0LOO7v4xHKU9a7SPmNu8YuX/it3Q7Kpf5zymBAVUDKfJuB4nJDvy7zeFWnTqv1Ei3dqCqHusgVRSHK6LSbPk/vQV0cvmBsRgp3CWET25NgAsF0xMKorD1BWcSA0xrHRKIo6Jn4Ny/+94wCkpwSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Wo8KBzsZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d6c220a377so25282621fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711381719; x=1711986519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJbqtcT5Qk/lZjpWEh1CyTzQTjAlrrxanun/S9rh2UE=;
        b=Wo8KBzsZ4Gp0pP4aIZYmkX4rjd42Ohhr7qxZqL7NfDUjHtw8M14bk2mRKntgOZo0At
         D+/JH/a1Bg22P9ZvpCUASp/LxtL1L03unlVbVr41TynAqE8zTOZJCBcSRA84ww5VTC+8
         o9IzArw06Kizh1dnK3Yx/OnWBBsG9X5DSvejO74H4NNJ9KTSu6ZMKNgZnjGNBbxM7/dd
         JVOtkgLSQzTTpFUl4xeR8hiWZZsepgktlit0i+yOVROmDtLdLbN4TPYnMDQNmqmAJKQH
         QsAF7N2j45rGbSpr0eAgEfxyh1yqI1aKudjMPs8KCQ3nV9TY5waZixZeZE1zWSha70MK
         p2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711381719; x=1711986519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJbqtcT5Qk/lZjpWEh1CyTzQTjAlrrxanun/S9rh2UE=;
        b=VOacy0GnoaEfs8nXHpmbGZfczL5+JVXCKCU9Gf/6IWy9A1NnIQ+uVLIcGBsu7+utQ4
         epuvDt/ltMY37snMHJHUVWy5B6YxiuW1evC8f/6KGWKPBVovKEgy7tj3OeqXTmXjLt/u
         AcEg4VJrCNZvBX0gytW1GGqCnj0EBdX0KjJ7mbQC2tAWMbFkPy3zdTRsNjlFJarXbLbQ
         M8E3jywC4mYCY5K9PqGfKwrQr3xZ3zULIB3eZGS6buuNze57UZaTPjCljfmI+pSxNVy4
         xSysC8g9JB5sVcX3lRfKll+iQvwNKocsSHv+ltTB+cQlntWAiJ7MfGJ4x/l91570w/qJ
         rxSA==
X-Forwarded-Encrypted: i=1; AJvYcCXSo5MCEz2apK45A4oOsQc3niPvRBOVTiw9qkHbrTN9cTVSAl7nSrm9RG+p/K85LrEetMNMu6j6Gyv2JCC4Z+0eKa618fcaeziXEqGL
X-Gm-Message-State: AOJu0Yznch3yBTGG7zPTSsS46aMeUgq2DoYCzbbhOetpTfni49XzWpL3
	2i4X1T7pUwnng3ToxItG8t46vTToSRdzaQ5jk43j1WPTx7GNNhW+788mqOueuCDEf7SvMTREL4V
	8VwhQgRIt5kJwyCPJRCNwKqesbT8hXO2HW3rl9g==
X-Google-Smtp-Source: AGHT+IGvFSA/jIJoV8X4RKk5N2K/yc7CSyNykotDctEjLqK49e3F+1X/RkOnddLAvw547/5xInAWacgzxKhNl5GWIqM=
X-Received: by 2002:a2e:b7c7:0:b0:2d4:764f:87d9 with SMTP id
 p7-20020a2eb7c7000000b002d4764f87d9mr4708167ljo.32.1711381718862; Mon, 25 Mar
 2024 08:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322073725.3338266-1-peng.fan@oss.nxp.com> <CAHp75Vds1dmjbaDa0D+Xxoyt_9CgHhoS2j0cR3EQdMp3sbwg5g@mail.gmail.com>
In-Reply-To: <CAHp75Vds1dmjbaDa0D+Xxoyt_9CgHhoS2j0cR3EQdMp3sbwg5g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Mar 2024 16:48:27 +0100
Message-ID: <CAMRc=McYbsd8t1_6PDypGBme2OSyvy8erdjR51cUzVhM-qQXZg@mail.gmail.com>
Subject: Re: [PATCH V3] gpiolib: use dev_err() when gpiod_configure_flags failed
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linus.walleij@linaro.org, andy@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 4:59=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Mar 22, 2024 at 9:29=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.=
com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When gpio-ranges property was missed to be added in the gpio node,
> > using dev_err() to show an error message will helping to locate issues
> > easier.
>
> Bart, are you aware that this will add yet another possibility of
> scary '(null)' in the error level, which is much likely visible to the
> end users?
>
> I propose to apply my fix first to avoid this happening.
> 20240320165930.1182653-1-andriy.shevchenko@linux.intel.com
>

I think you meant the v2[1]?

And sure, I will pick it up shortly.

Bart

[1] https://lore.kernel.org/lkml/20240320165930.1182653-1-andriy.shevchenko=
@linux.intel.com/T/

