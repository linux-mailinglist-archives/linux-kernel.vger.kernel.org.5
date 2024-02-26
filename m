Return-Path: <linux-kernel+bounces-81127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAED867091
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE51F282BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1B753E32;
	Mon, 26 Feb 2024 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eCixZ4SY"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF1537E4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941772; cv=none; b=Bn0k04i5GJcMB29+HUXYkKoEMsEMOMguFb7v16n66LdI8nh5ewtx7xLSho+emmyqu22gfj9GCSJxlOZPsZkelvYUrPgeWAnfnQZkFTVMKtyRkZXsSoC006AU6mXVssOGICju0NneJlPVc8/xzjcM0XTJV7RSmDeSJL/pPGAK6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941772; c=relaxed/simple;
	bh=z9qluFa8eC6JxuWAEfGLN12QJfch7MVKIgg1veyKQdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBO6oZ3lzyRERL/QCgqBsh+p+ir7osZFX9oImGRUk5PE6GGQPUUiXQ6UkzEnPMF2hdi4w3yk20GMz+K+ebAiUy6VT1AqyPMAzvZ6ed7ENhBYYC7RR4I44fxQ5cbdT48USNL0SqP8rVzMjZ3U3nlSct0gq+s61wNzPKmclyT/dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eCixZ4SY; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7da728b0597so590864241.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708941769; x=1709546569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egKHCTXms3+Gj7uzoU9NwUOObz+iQsBsbBmu6x6wSpk=;
        b=eCixZ4SYxFA+rxA+XKO0Ly6pdswVQHlb3jWlNnZ9Z1eJLzUzHIUHEgLm0Y1moyB7f2
         imKgNToOIireEdLLNbIo1yUd+D8T+rK9lK7XVHqQbyJhiUjeo4604FIzF5Loz3HWcLtz
         AqTuOKFOmN8udhoRfuPflnPz5mLc2dQTMAri6GtvFA1lVgWN4F6CnW2nff60bFxYO5Cs
         u8ykaHP26kXGwuJqbl2u4OAGL6q15Zqxtw+P1q/OdcMwJ7MhWbIlD8tckYykYCK0WBQY
         FU4viGeN00vwuU+VJYStsU67IqWSKySg1mbFfSenfbEqao69AO7x/zW4POuQ/a7yWiUw
         M9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708941769; x=1709546569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egKHCTXms3+Gj7uzoU9NwUOObz+iQsBsbBmu6x6wSpk=;
        b=AxYUn3bnh6on4ffYqm8D0ULtqimICVkRm9whuINlVkYyOMmM3hRPYnUROkT72HAAxG
         LKI3+iqp5mbSoNv0Ov9PV9gu3cZn1+HTReqOC71yUMR+SkBjv2VwgBEGxlOnzWZHsBNh
         ohWHhGR4NKfeQj6osrDDw5u9GwlYoHfxhymQyZz0A3AVnkEh599e8GBn946g5VC+jzLy
         6+AY4BuxFx4LXPLenRs+mohsSC6969XxtkmuzDaWnF/VNGJD+pG0rhiVV/rmL5ORGEZw
         /8tkVVjUWaHdvJtRfJYraXZ3kPiojWxKoPBwZHTeX5pVU8e4thVLe6RMtCIV/PM2Wdhw
         6R5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd3jnZGPuIlTzl4DmlNYOtZLvphQZPNFEqlOie+IgFONdg0NdhgoggN5e1QOSP8t8jV9nEwEkf4VUnD6OeVvQM0ulwX1RYtJhxNQLg
X-Gm-Message-State: AOJu0YzuSokwoDE7ylq4fhrzX6QpkKaVZMcQ4mdwkhdvdAdE2Pr2ykSF
	h4dfl0446Qsjdm43aOiR74o8CgLret9jlB5/prjiJZaDmw3K+0srCUykDAxhAbRPGoq9s6/x7rB
	meD1o/x65cNGvIhu61uZi90Q3Two5WdslsjB6pA==
X-Google-Smtp-Source: AGHT+IEllPqSj/87WfKunHc6+bCMnlKEsFq9iV7Ej3YJerJemaazB8I5kSszVhUzvisTiryC2/gVFFa0SBHh9dmZ+Cg=
X-Received: by 2002:a05:6102:f0f:b0:470:547b:6f98 with SMTP id
 v15-20020a0561020f0f00b00470547b6f98mr5205949vss.18.1708941769713; Mon, 26
 Feb 2024 02:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226174117.722301b9@canb.auug.org.au>
In-Reply-To: <20240226174117.722301b9@canb.auug.org.au>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 26 Feb 2024 11:02:39 +0100
Message-ID: <CAMRc=MctN=PqM6O3GxvcFuk2ZT2YcqTiKZiuCiaTnXDEV+gXaw@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the gpio-brgl tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lee Jones <lee@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 7:41=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> The following commit is also in the mfd tree as A different commit
> (but the same patch):
>
>   4a7b0850fc7a ("dt-bindings: cros-ec: Add properties for GPIO controller=
")
>
> This is commit
>
>   7b79740d42e7 ("dt-bindings: mfd: cros-ec: Add properties for GPIO contr=
oller")
>
> in the mfd tree.
>
> --
> Cheers,
> Stephen Rothwell

Hi Stephen, Lee!

I picked it up because I was already queuing the patch adding the GPIO
driver. Unless there are conflicts with the MFD branch (doesn't seem
like it?), I think it should go through the GPIO branch together with
the driver.

Bart

