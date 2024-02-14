Return-Path: <linux-kernel+bounces-65599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12140854F49
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CB428366B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F96087F;
	Wed, 14 Feb 2024 16:59:12 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD2535D7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929951; cv=none; b=KFV5GUUFz2HU5AwfiY2dwrwnaugNLjlZBUCq0PnP+EotMGi/qw5S+KJnHeLEI0EpkTZNTE6JzmBhRwRoVbkptuYoo0j58dLd2vBQjSoLZffLKbM144nxdbJltvqwrZVnuY6uO3PMCAEwEBNR/dwhb42B+h47fqa5SbJot2Y5ipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929951; c=relaxed/simple;
	bh=5tWoKBdQqT8HK8sTCtsFMhd1e4ogKUSZ+tSPPlaHtgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYH+pVpm+Lg4dOOBRiNrqBbuoypnXU9ZgbAjjp56PeJPcinUzUfMEnOxOchobr3VCGL/DEQw4sagKw1GtEK+U5UXb64ho0MmwE/jLF9BexydMdcOi3a0VRJqMvgPX/O+/TXZykCwADlC2oZMSaJok47r1kTt7nrxW4bYY/Zsmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6078c21505bso17744697b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929949; x=1708534749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPNzdTolT9Gzq/TNAZXeWwVedUOutk8BUYaegzXpEEk=;
        b=kEM6BMgoSnnB345qynQZ0WZvH5mkB7WETOxX0/tSKRiAM4gtc0fd4P43BWb05g6Y7Y
         JdTR++j7TQRx6/OLUPodCRSg2TrN22Wf9UHt68IpSHpMf1w+yPgJdFdY+0km2/Wuc7eu
         imZjmDpNR7op3JQOZxT3K1ZGUeRARVEHYDdZd7x3TMKfjiTsppkeilq48PWccMLmfQNM
         g5oO7i5DPSJgJLzHbpQqsMjPC2aS0ZN/yp72PmBe+TxmopTuqB1xW2KkivmMU2ZvjIKh
         5Z3o/ao7JsCblJA3psZUBuNxF51yRac8XZo4woYidXVg9c5BHJLi9hTBC6Y7w1YZKy6f
         8Upw==
X-Forwarded-Encrypted: i=1; AJvYcCW9B44/FtXBfpH2BY64DafsNPfeUIHFbYyJCrXwVI/pnSVDoge4kFElBGbXIO0Gp6yamu2b5HeGj+xJ8+rBorZ8Kd+vBqAGBurFOrPG
X-Gm-Message-State: AOJu0Yx+lBnv8bD+EWqp4lvwW4ylSJZ7V4qL/asI9qhVUiAVDebbv5o3
	djcY50ncwbjjA1hej659ce3UbE3frjoCD8J+5Rb+tSUozVWp7EDOUQAnHBQ36D0=
X-Google-Smtp-Source: AGHT+IH4/hXOfACtxSVuuBvrhIGcPR0F3ha0on4/0XpzPSf9ZsYVlam2Jgy6xsmCwRT/4iSIGTgQWA==
X-Received: by 2002:a0d:d40b:0:b0:607:96d8:cc50 with SMTP id w11-20020a0dd40b000000b0060796d8cc50mr3033975ywd.23.1707929948905;
        Wed, 14 Feb 2024 08:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUV0ALS3L9AMCyLXOXGh3EYDci8qQLYCYTlIt3kqL6xOrHQv7NsqZqj2X8JIds7sUZsIuMFkEcF11Jls05ZZzFw1KSE5mfCS3DN6BKT
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id m124-20020a0dca82000000b006077cd5fc5csm1074051ywd.11.2024.02.14.08.59.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:59:08 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc73148611so2349598276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRHJsQchJnFrPE0kwrgpb7EKNMvpXAQ00uIuLqPYbYWQkyAvGyfv1teztTLxobj7Fmndk7I8kxj6Hfll7MAVlWGgDRL//94i4iec5B
X-Received: by 2002:a05:6902:2748:b0:dc2:48af:bf17 with SMTP id
 ea8-20020a056902274800b00dc248afbf17mr3052804ybb.62.1707929948278; Wed, 14
 Feb 2024 08:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com> <Zcoe9axtLXxB7Jeo@smile.fi.intel.com>
In-Reply-To: <Zcoe9axtLXxB7Jeo@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Feb 2024 17:58:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
Message-ID: <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem folder
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 12, 2024 at 2:37=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 12, 2024 at 03:23:54PM +0200, Andy Shevchenko wrote:
> > There is no users outside of auxdisplay subsystem for the cfag12864b.h.
> > Move include/linux/cfag12864b.h to drivers/auxdisplay.
>
> ...
>
> >  F:   drivers/auxdisplay/cfag12864b.c
> > -F:   include/linux/cfag12864b.h
> >
> >  CFAG12864BFB LCD FRAMEBUFFER DRIVER
> >  M:   Miguel Ojeda <ojeda@kernel.org>
> >  S:   Maintained
> >  F:   drivers/auxdisplay/cfag12864bfb.c
> > -F:   include/linux/cfag12864b.h
>
> Should be replaced. Done locally.

/me looked at your branch

Just use a pattern? drivers/auxdisplay/cfag12864b*

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

