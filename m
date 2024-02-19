Return-Path: <linux-kernel+bounces-71656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13085A888
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67571F24C04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120F3CF53;
	Mon, 19 Feb 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtsFcuHH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1EE37704;
	Mon, 19 Feb 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359452; cv=none; b=TRVVyBWNLHHvEnlaEasE4BBoXs96JgHzPed6eqfiDDc8qHovGLaYcSTXR1ctLL2NQqHBVOMUs4gIjHnkQEDHCv0yOIN2KH+GC7aEWGRd8ZxDPFCVr5FGH+Qs3kglZTO3qNYPxYk7Hp3q/e1M6qWKtKavBBBQ+J9kr6u4PyeWGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359452; c=relaxed/simple;
	bh=7FpHqGM9NSQ9oJ8wCMEWcQwBYs8k2HS8Pk/KO1rddLg=;
	h=Content-Type:Mime-Version:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=me8mWxzfu6HYr3GnkcuzMe/XA7IeUATEVdDIudtFTPMvDUHPbVbFNgeJlVaCRKCBE4Hwicl4xxng8hsP7nE4vifdQXZLXnxIYUpCYBtzFcWf2Fr4GP57L2VX279ZMeDkcGYySfgRSiXE8++kaVopIsm+6usVMsvc0sBV3uu4K98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtsFcuHH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3e4765c86eso217710366b.0;
        Mon, 19 Feb 2024 08:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708359447; x=1708964247; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LQx0b5ToM23dL9e3ut59o6I7ORybJM20K6cqxVU6TEY=;
        b=MtsFcuHHWNabD1DlsDqdsA9GaOXlMRas5/qqxjnzTVbadpD7HWVeq4C3NyGgZ6oWk6
         D36uMiQPnX0Lqm7K1+W2prJB1CujJC1Tp2t5yPOPZ5TmwS0cZHCOGxOiFEfiem0b9tcx
         hqMpPXgCqY3bbJo0YopJseXsS1ojtN5mApG9fs8UVHWfgXiQDm/pzmKpHOC4qesPhEiv
         D6kz55xjruvCNbPLkD6xk2vUbNnrCtL4z3JbUav3j02nuWyL8PVs9pI4B1Alrq0DNmQF
         v4yjEHFYrPRMdiuOlHNrGkSfA71WMSmZ4NXEY8bBm4qiD/pQwXjF0EO3lP/b+CYCy43k
         puTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359447; x=1708964247;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQx0b5ToM23dL9e3ut59o6I7ORybJM20K6cqxVU6TEY=;
        b=gGUTx5O0CY/bQbMqB+tV+5p3PXWy6F0up1AcU+DSADN2UuwTY+uJaYiXcat+kZ4E8m
         E6xpmYBog79CHEBLuOapETaLWT6nQKnyGsMxoDQZsAMBnLsV+ifg8dQOFjx8e5amUCRe
         I6AaTOhALoWad2aW6JWI+tZSO4YM8SjwCN+Sx/AY5O8JfJa9GFyrT2DvFS4uoGxW9nK+
         pngk4qSU9D28S+0AAlRr3mnm3TWX9uO0Q58IBME8LT67QxEnphXftwIe5Bar5TPEk1hi
         U9TBjgYW0KHumeUxeIde3hiKrW0b0cKh3kTYrRG2VsYN5p0+xA4Dl88T6Cmfk67C7H+V
         mXWw==
X-Forwarded-Encrypted: i=1; AJvYcCVysxteD5x52+h3NAmY1lMIjR66bHG1CFc3Np32+5JHKG7OOYmmAUf4wgHbeDnWNOdKUeNHOL3avbuPAa27mZlHlfCyu94jN4/C23CAgwL3gUtkfI3BuoFI7unblr2YHTE11hGOj/EVb6w=
X-Gm-Message-State: AOJu0YzRT1FRpp9DqgA6hHjaGUxakSq6Lk55rITGEvyp8kGw22b9EWN1
	g5ymTRZZPMDa7XR9UokZlJdyLa3YrBDmwsselChQ8wevH1awKUsd
X-Google-Smtp-Source: AGHT+IHz30EtXbUsDHHybZPNs80s80ImweIjNew1u/fXIGZ82mBpPBeMfLVVk7cu9MbgmkwQgY+KIQ==
X-Received: by 2002:a17:906:a19a:b0:a3d:2a52:380f with SMTP id s26-20020a170906a19a00b00a3d2a52380fmr8275021ejy.72.1708359446972;
        Mon, 19 Feb 2024 08:17:26 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id lu16-20020a170906fad000b00a3d5efc65e0sm1770838ejb.91.2024.02.19.08.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 08:17:26 -0800 (PST)
Content-Type: multipart/signed;
 boundary=e43bc9b7547ba2fb2d75f0caf653f23939e188d8e14bbe063075b337bdb3;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 19 Feb 2024 17:17:26 +0100
Message-Id: <CZ96VR54894Z.TIAQI1OXCH2Z@gmail.com>
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Pohsun Su" <pohsuns@nvidia.com>, <daniel.lezcano@linaro.org>,
 <tglx@linutronix.de>, <jonathanh@nvidia.com>
Cc: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-tegra186: fix watchdog
 self-pinging.
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240216210258.24855-1-pohsuns@nvidia.com>
 <20240216210258.24855-3-pohsuns@nvidia.com>
In-Reply-To: <20240216210258.24855-3-pohsuns@nvidia.com>

--e43bc9b7547ba2fb2d75f0caf653f23939e188d8e14bbe063075b337bdb3
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 16, 2024 at 10:02 PM CET, Pohsun Su wrote:
> This change removes watchdog self-pinging behavior.
>
> The timer irq handler is triggered due to the 1st expiration,
> the handler disables and enables watchdog but also implicitly
> clears the expiration count so the count can only be 0 or 1.
>
> Since this watchdog supports opened, configured, or pinged by
> systemd, We remove this behavior or the watchdog may not bark
> when systemd crashes since the 5th expiration never comes.
>
> Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
> ---
>  drivers/clocksource/timer-tegra186.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/t=
imer-tegra186.c
> index 8f516366da86..acff97da138a 100644
> --- a/drivers/clocksource/timer-tegra186.c
> +++ b/drivers/clocksource/timer-tegra186.c
> @@ -175,7 +175,8 @@ static void tegra186_wdt_enable(struct tegra186_wdt *=
wdt)
>  		value |=3D WDTCR_PERIOD(1);
> =20
>  		/* enable local interrupt for WDT petting */
> -		value |=3D WDTCR_LOCAL_INT_ENABLE;
> +		if (0)
> +			value |=3D WDTCR_LOCAL_INT_ENABLE;

We probably shouldn't proliferate this scheme. In retrospect I should've
removed the two other similar blocks back when I submitted the driver at
the time since they don't really serve a purpose. The intention at the
time was to keep them there and eventually replace the condition with
something that could actually be toggled, but it's been almost four
years and this hasn't happened, so I suspect that we just don't need it
at all. So perhaps you could remove this line along with the comment in
this patch and then add another patch that removes the other unused bits
so that we don't carry around stuff that we just never use.

Thierry

--e43bc9b7547ba2fb2d75f0caf653f23939e188d8e14bbe063075b337bdb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXTfxYACgkQ3SOs138+
s6FFEg/7BXMzLKa4WV2MSGtBdio1idtwClBrHumI9gexB9N8RX7Cfcjq/SS7KAge
X9q5BpU9wfis60LnMFmfYZGXa2ml5CsjzNY0qf8t8z++eTfvFcfICMpL0ObW0kIA
ZXDpyFCGlOXEA/KD+OJT2p9HokwwfJYm1yTfvQYvDom3S45RYYP+E1nF8ouH6DCm
V08ynrpLmm3dnI5YTBP+M4PvwsRFKCNyV3dgio6t0SaVj60vGnMNISq/kn/2T5bi
01+H/usbwsWNkOM3BnXjlPqMkjugN/LfktB8a/YCeR6bLrQAi1bgBojmEOwbkueJ
FKxVmwpPZ9ZUboa1+3xMPuGJ+uH45yCCHj4F8PrL8VMhhIrOcjIIsSwhjT54PVED
k0Ge1PhY22oAFWXuMytB/CM9sXIhvp5ZBwaH4KeFll8rIJmdB/15HrPVaowYojT5
hehtorUpcYwF315sTzZ9pxaGEsMGaDWkO06YGxp5/DskgUAyhdi8wI1XwV1jCcHO
Q0VJbKooCrrzCPOa41k8BBOH9YRv3QTw9JpfCL09/fFtejJAeEm+EJWwPw05NVjr
9Vac+0EQ/FeNVo8d8/QSMoAaEYwES4PN/U2Ye92qB6/4zzny7Ao6JLutSJfx6bwD
S7/VWP11vM4eCheAy4vBhrbxBsFFSMJpKfA+FA3RpK4VfGXj4Mk=
=18jf
-----END PGP SIGNATURE-----

--e43bc9b7547ba2fb2d75f0caf653f23939e188d8e14bbe063075b337bdb3--

