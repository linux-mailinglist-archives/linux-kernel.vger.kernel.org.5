Return-Path: <linux-kernel+bounces-112834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B986887ED3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC1F1F2122E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B9B10949;
	Sun, 24 Mar 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj+s5LNJ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B93F9EB;
	Sun, 24 Mar 2024 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711311083; cv=none; b=LnamYA1GLeVHAafRnKaK3bhtCe8DHAorAgS14/5v37taRmWHuhwdOILJkLBRojTJK7NNRa8qq1c5GfgPg8Q0GtQiJVZFAyQBDpMRcV5oLfIVeQg45+NnVE7luO8+jhw7oXSjoXIPg2DpMpjaybAlPWK+Yii4ySHHor2HJu/2l04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711311083; c=relaxed/simple;
	bh=YfShyLlMU4oc5HThsKpL/da4VjS/5TBjcBDjAl1yFYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmWWIF7BfDF8pPAxwtKs81Lx7itChHZrBjeUaUd1vxENY1iYNoaKgTatGciJsSM1O2ZtSpbPAC5FmKhcKS5t2FOHLekTiGkKZlqCghK/OMQrNgZQkxVwPgy7zJrIB3uEdw+WmAv/7iJ/pReRuZm4xtz4cPK6KBuSKBTOgRc3B3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj+s5LNJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d485886545so65620901fa.2;
        Sun, 24 Mar 2024 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711311080; x=1711915880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdRDKLqI7DjUpUVxY41B4kNIhxfYBVE7snw01hwzEWw=;
        b=Qj+s5LNJNq4V9eLOWlCYdL2AstOLBYhgrzTmbh9X4awtwCdslVurEKF2djQXbH/zsH
         Vcw5tLzytmZhya7DLwvQQjwybIFXFgcsahLxAfdO/vcs97Q/oA6kSShIjf+FTV2Cn+or
         soVtKa/g8hJxjfN5nm06yk4fDUhxSakAhCB9kYYQGWseYaz8Z4+fwwNcVgv3aCPBJlT+
         kbkDg5VHpt29eCv1jWyKydu6oGX0aMpvGtl2fUFZGP7A4E/2Ah58/UFsp4FNtcvXGKUW
         gO05xhvx6Tk52neBB8MEuxCz3dBA1V3UENEJiZM4GN0P4EIoDiOmHrw/ugs2PI0R1zgf
         puaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711311080; x=1711915880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdRDKLqI7DjUpUVxY41B4kNIhxfYBVE7snw01hwzEWw=;
        b=OQ2mviJ6uTqPApIrBwXAIeXrGzB/KLTcsNxY3I0MhbK6273DGvuVJEQSefE055MZkZ
         UuQR2egd9zrZDDB2UufjylP5JHMBzVWvxyvOM1D4xBw+KrlzxvH0SrXHGJKdTNdqtGfq
         28kFLsfj+wLH9cT7FK34/f/LjyKV66LwbzMF0xmBDRYbKt0FeaH3e77Fxh04tXQbkqDs
         Unnl0U1onQbyhJDCZ7m833WW2bqHDXg9s/jGzEr0NHcBBSc+PQh1tKANLRdmHxXN0itr
         6KIbPUzHx21HuiGd8uGuZujbyneOtzxzjin3gkUin6BwMQNmTr8Pum9DZg9sWYscrtHC
         ICjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH2BZDJQgynQQacac7j1OYCho8gd++O3DKb3rg+IqpSF4l1EDrTNM7zuvOVUfOJxhf9eANFfCWkVMZaf0R3X/urwkOBt3WV9mA3AG63sVNVMYW3Ex2oiq4KxW1pnEUYD+O5QNd44xxaJmm6ZQPS75DcmSvUy+6bswYsT03bABlpUzxLLeSj4Vf2JqDRVHp3cyGCH3kbHNumW7DzETeBbq7KbEHxU4oLQ==
X-Gm-Message-State: AOJu0Yx3X3wQF9MvA5ozLozhjplLmJMVBnSYMzJjaLCr+t1RDfAXMoiH
	VZpR/I4FLRirneQDSBU9Hx9FwUI0p4YchkVeK/pnhftSGWVJ8lPAwQX/CABCgft2XdlV2Nq2FOY
	X3xTSiaGajBpB/fvY7wTvFvi5acM=
X-Google-Smtp-Source: AGHT+IE9S7GsrcuYSQ6UjCF21DOHCzkHnAa+0LFD989vbFcSCjq0DO3UrxnZWo7r0yFZ40OrDic1sGRcNWa1klIwAFw=
X-Received: by 2002:ac2:446b:0:b0:515:8dd3:e94d with SMTP id
 y11-20020ac2446b000000b005158dd3e94dmr3311694lfl.68.1711311080226; Sun, 24
 Mar 2024 13:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324150107.976025-1-hpa@redhat.com> <20240324150107.976025-6-hpa@redhat.com>
In-Reply-To: <20240324150107.976025-6-hpa@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 24 Mar 2024 22:10:44 +0200
Message-ID: <CAHp75Vdo5TMqm8H0OCGw5=_dwY1M0N4DOYUZy5NEbfJ1=KxXXQ@mail.gmail.com>
Subject: Re: [PATCH v5 RESEND 5/6] power: supply: power-supply-leds: Add
 charging_red_full_green trigger for RGB LED
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 5:02=E2=80=AFPM Kate Hsuan <hpa@redhat.com> wrote:
>
> Add a charging_red_full_green LED trigger and the trigger is based on
> led_mc_trigger_event() which can set an RGB LED when the trigger is
> triggered. The LED will show red when the battery status is charging.
> The LED will show green when the battery status is full.
>
> Link: https://lore.kernel.org/linux-leds/f40a0b1a-ceac-e269-c2dd-0158c5b4=
a1ad@gmail.com/T/#t

You can drop the 'T/#t' part.

..

> +               led_mc_trigger_event(psy->charging_red_full_green_trig,
> +                                    intensity_green,
> +                                    3,

ARRAY_SIZE()

> +                                    LED_FULL);

..

> +               led_mc_trigger_event(psy->charging_red_full_green_trig,
> +                                    intensity_red,
> +                                    3,

Ditto.

> +                                    LED_FULL);

..

> +               led_mc_trigger_event(psy->charging_red_full_green_trig,
> +                                    intensity_red,
> +                                    3,

Ditto.

> +                                    LED_OFF);

--=20
With Best Regards,
Andy Shevchenko

