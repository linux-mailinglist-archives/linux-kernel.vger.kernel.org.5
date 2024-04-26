Return-Path: <linux-kernel+bounces-160730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B68B420D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5FA1C21981
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8DB37714;
	Fri, 26 Apr 2024 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiAPYb6t"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D332C6B7;
	Fri, 26 Apr 2024 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714169300; cv=none; b=V6nkYnDFpb2fcswdQR4bFqDDj4r4Roc3gTfwLBU3bTJ8WQV3LkD0/C23HyhLx7KevSJG2jS/3KSancp00bq8V5c6tbcVg85lrpoy3bby/beEFjFJQhhyOSI0TdizSvLsdNXSDcnjLmVkjSMYcl1k5TIu6sc4984lSGVpul0iQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714169300; c=relaxed/simple;
	bh=0khILg54FT/sDBrzWK5mNL6qNVmfbtcLyd+OTVQdtoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf7tT9/yTl3JuhjgZRZ6LB05H4bOgsHv2Um+yQIEmrhsZYJfGzfq7Zb++21kW8R4Nl0tWaAW6+zYQSUeoKG08zscuR1lLM7yh4KrGSwBuxrBglBMiM1IoGKsgJdJQNgqjuuBvVT6mhRMq1wIX/vOwQZrK8/u5rHKONMcvAEVaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiAPYb6t; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de596c078c2so2316503276.0;
        Fri, 26 Apr 2024 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714169298; x=1714774098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0khILg54FT/sDBrzWK5mNL6qNVmfbtcLyd+OTVQdtoU=;
        b=XiAPYb6tRt3fA84i+wAAyzsq8knS7Ik8jZxt5ebiFI9/1vc5xulY36+ie9LN+FxYfo
         9+q7sFeCgfG2mW+KWY+VsYBushZuxgQ7ChZ3jiZZniGBSruTxR+lZ8m2rBVGCvlMqx8b
         sM3UhSGyEBzKzHOqrLnkpz9wmtkhSIuHcHbgzAheY/4bVFLxuq3Q4Nc6qj1Xi6mwV7Cd
         cgobJwi7OZhaltCKcNTnt9Jt2n+Gi+5Au9z1nXv+Ya0fTq5lGZfTu+3U6XBmLyXx3wOs
         dHpASih3/Z4itkZb5h4OwSZ3Muu5a/jHLiWLZdWCAU+PDI8m879CH0oHUNtJ3dvyMGrA
         fTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714169298; x=1714774098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0khILg54FT/sDBrzWK5mNL6qNVmfbtcLyd+OTVQdtoU=;
        b=xN+cZJbRG3NuP73E8h68eEw1admeA8L8bNz5G1SM/TRMM1fDdcIs/JgN69hoj7Soka
         47Zuoy7TZ4KYMCuwC1iN/OIu842rK0xRYyAg8qZXevJjOAcaSJMBJd/7kl3sEsbg11DH
         6z4fAWOM7O9SpZPGBGNqKL10Hci311GaCI4kz6COMeBebINkVxJaTfuoThXoHjaZH+IJ
         C49vxfQiiRi2JvIRJ0Zf02CK8x8j8/kunSNHxE6fBmu5VFmPQ9o7Xd4++501w0XJZ1Wu
         EhqPnQsK4DlKjT4v8w2j3xztWEtHRrJ7H42tTE9R7TFedKxbW24PHs8rEvKJbve6xchQ
         05fg==
X-Forwarded-Encrypted: i=1; AJvYcCWnlnVZLixhnXTbubdXLWSx9Uk5id0J3UEsv0U3jGGRaJxc5F3w98HZZE53WNN95MNyDLFUej29DJbqfHjSWb3uyOCXpfmhpABh+JSVl54/LSAQLZLF3+AZTspLiNmah+wn3HQ2MDIpJa9R7yJLoyO0wh2gIDm1QRm/ykQ6thhRc0GVycEZiTY=
X-Gm-Message-State: AOJu0YyiRCzFSBZNmeUV0vkWz1Ii4VVmMcqIcXM/p5R6EyT+RI+15hE4
	8UKEdsz6ncwOWuNu3y95A7vRe1nI2jlkHyGuq/JbSsdZJtep/s+me0BRYFQfipioJDoArX1qgIr
	S9ILkLtoB5mIeUiLOUFIhZ4vo/2c=
X-Google-Smtp-Source: AGHT+IGATzNR3kaBbDpb0EkDU4wV4HvJlDtd4NArx1rLPtzu8SyJ9NkwXfooBm54KAjIyFV9MaKB/H1WtIXS9Q4VarU=
X-Received: by 2002:a25:d845:0:b0:de5:a15a:7118 with SMTP id
 p66-20020a25d845000000b00de5a15a7118mr4144739ybg.42.1714169298049; Fri, 26
 Apr 2024 15:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424-tlmm-open-drain-v1-1-9dd2041f0532@quicinc.com> <ZipGRl_QC_x83MFt@hovoldconsulting.com>
In-Reply-To: <ZipGRl_QC_x83MFt@hovoldconsulting.com>
From: Brian Norris <computersforpeace@gmail.com>
Date: Fri, 26 Apr 2024 15:08:06 -0700
Message-ID: <CAN8TOE_Vd9c2eYgomhu_ukofTeO9eK8Yhrtt-8BQckmJnGfj6w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Fix behavior in abscense of open-drain support
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jaiganesh Narayanan <njaigane@codeaurora.org>, 
	Doug Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan, Bjorn,

On Thu, Apr 25, 2024 at 5:02=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Wed, Apr 24, 2024 at 08:45:31PM -0700, Bjorn Andersson wrote:
> > When a GPIO is configured as OPEN_DRAIN gpiolib will in
> > gpiod_direction_output() attempt to configure the open-drain property o=
f
> > the hardware and if this fails fall back to software emulation of this
> > state.
> >
> > The TLMM block in most Qualcomm platform does not implement such
> > functionality, so this call would be expected to fail. But due to lack
> > of checks for this condition, the zero-initialized od_bit will cause
> > this request to silently corrupt the lowest bit in the config register
> > (which typically is part of the bias configuration) and happily continu=
e
> > on.

Apologies if I broke something here. Both the pinctrl subsystem and
the wide world of diverse QCOM chips can be complicated beasts. I
definitely could have missed things along the way. (And on first
glance, it seems like you may have found one. I definitely did not
consider the gpiod_direction_output() "emulation" behavior here when
submitting this.)

But I can't tell based on subsequent conversation: are you observing a
real problem, or is this a theoretical one that only exists if the
gpiochip driver adds set_config() support?

> > Fix this by checking if the od_bit value is unspecified and if so fail
> > the request to avoid the unexpected state, and to make sure the softwar=
e
> > fallback actually kicks in.
>
> Fortunately, this is currently not a problem as the gpiochip driver does
> not implement the set_config() callback, which means that the attempt to
> change the pin configuration currently always fails with -ENOTSUP (see
> gpio_do_set_config()).
>
> Specifically, this means that the software fallback kicks in, which I
> had already verified.
>
> Now, perhaps there is some other path which can allow you to end up
> here, but it's at least not via gpiod_direction_output().
>
> The msm pinctrl binding does not allow 'drive-open-drain' so that path
> should also be ok unless you have a non-conformant devicetree.

The ipq4019 binding does:
https://git.kernel.org/linus/99d19f5a48ee6fbc647935de458505e9308078e3

This is used in OpenWrt device trees.

> > It is assumed for now that no implementation will come into existence
> > with BIT(0) being the open-drain bit, simply for convenience sake.
> >
> > Fixes: 13355ca35cd1 ("pinctrl: qcom: ipq4019: add open drain support")
>
> I guess hardware open-drain mode has never been properly tested on
> ipq4019.

It was quite some time ago that I wrote and tested this, and per the
above, I easily could have missed things. (Plus, the open drain
configuration may not have much practical effect on the systems in
question, so certain errors may not even be observable.)

But I do recall seeing the code in question activate. And inspection
shows that the pinconf_apply_setting() -> ... msm_config_group_set()
path is non-dead code here, for appropriate device trees.

I can try to fire up my development devices again and see what's up if
that helps, but I won't have time to do that in the next few days.

Brian

