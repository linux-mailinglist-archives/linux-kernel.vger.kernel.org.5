Return-Path: <linux-kernel+bounces-76625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709C385FA24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264DB1F2761F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A111353EA;
	Thu, 22 Feb 2024 13:45:21 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9D612FB02;
	Thu, 22 Feb 2024 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609520; cv=none; b=WFi+XRVLI26mPCRdaqYbgyKfbVNQrdvlv1ag7E9TyVgmJpSCayE1VdoS80aansaXMBNWUbr/3zU9655+VmSq8evNey6JSKLLQmMBNPbLk0JTJcgcvx6bb7+9KcrrD7Ih/K1DqBbLZZAKuhQLCxQ0iWzpdWcwilWLGdrf2E0Ugb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609520; c=relaxed/simple;
	bh=kV0tu1HedNIlrPb6/HcM7m3+vdVqXjTbmqQe2+X7d00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQE0aLJy1I4ghxUIkkdmYL26D3MgAjVPI+LNbx3sn5kOtoMs44v+jkZrVsopEeVa+LGAxGi13rqv1hEOhGttaczOyCc7UDKxA/xyMHCeSKKBpcb564b0I93NaQPLKQYuSeaAb4LWe5ljCmatMQ9W6m0pKM8T0p+leT6/39iYvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59cbf204d52so931605eaf.1;
        Thu, 22 Feb 2024 05:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609518; x=1709214318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCg/mOzfHBZwBhRSld4o9+a+p1U2xHvqG++Y85BtrUc=;
        b=kcV0b6EP6UhvL0M4Gkd8SuOcmKB1gANRZhjANNvI0O4xqWOWvFpSHsRzTShVB7XI+O
         BG9W4ELQN/qZTH/vHYUTJIy6qbP1TWuJT8JE/CKck8nQ2WuWGBitHg4cHM2S0OQTvvEd
         7eb0R/22rqWl1zSVkIW00lZFM+ZEhtLTBPTSdHz/zkwRTbMLvZ8ZQwaeFtNTzbr3LdWp
         vJuFSKsmW8Fr/TZSWdFDl6Xd2zPdBxG2Oj5XIQChR2/3iThHoJOAARHRuopWLlyTF7B9
         jicWh5kD2wMahAs1+FvwoVaDtGwPBlhigHrlK2dsO/nJJw00IMywIP4rTZuGNxG5bals
         X3ag==
X-Forwarded-Encrypted: i=1; AJvYcCU2R4APu/XUnXq8DSuLLS+fm7EiWYwmzdrYYVW1t/ghH0aHjUbPcgfGURS3B1NFUV34F9JBLzXqu4GmJdWnxRqtpWka9zT6/548IT8R9DbvIkLbs5UFuWGcyl+5dDHZXgie5TjAimjpzu7GiWmI4h6t8w2tnKyGxH+zkd62FWDuGcZx
X-Gm-Message-State: AOJu0Yw1KsvL0fgoQh6CC8iQ8bElo/18g0JbxsysRyepzmn8tI4Cciql
	SQAOG1drrGNvceXvCW25e3/OBFzWE/pV6iPnsAKsijqMakx2xunSxaDg1Xe5O2geDz/MFSx1DT8
	y0F33KhF275Zc9Vwb5L7fZcoEgcg=
X-Google-Smtp-Source: AGHT+IF1tiO6R+3J/Rc8R0orTi9A6faMGXCDobkhMf5GMBdEawhQXaDwHD4y0u5bMDH5XqKznPPV9K5TR6Pkn3PiFGQ=
X-Received: by 2002:a4a:e713:0:b0:5a0:2cbe:43dd with SMTP id
 y19-20020a4ae713000000b005a02cbe43ddmr1438903oou.1.1708609518445; Thu, 22 Feb
 2024 05:45:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4551531.LvFx2qVVIh@kreacher> <1883976.tdWV9SEqCh@kreacher>
 <12405371.O9o76ZdvQC@kreacher> <0de4fb24-8e33-4c2b-b6a6-d9e8a7b358bd@linaro.org>
In-Reply-To: <0de4fb24-8e33-4c2b-b6a6-d9e8a7b358bd@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 14:45:06 +0100
Message-ID: <CAJZ5v0hJtsR+nvd1UdvczM37x_AOvpRrY3+txv_kuzsmxidXeQ@mail.gmail.com>
Subject: Re: [PATCH v2.1 1/6] thermal: core: Store zone trips table in struct thermal_zone_device
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 2:38=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/02/2024 14:10, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> > Index: linux-pm/drivers/thermal/thermal_of.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_of.c
> > +++ linux-pm/drivers/thermal/thermal_of.c
> > @@ -440,12 +440,10 @@ static int thermal_of_unbind(struct ther
> >    */
> >   static void thermal_of_zone_unregister(struct thermal_zone_device *tz=
)
> >   {
> > -     struct thermal_trip *trips =3D tz->trips;
> >       struct thermal_zone_device_ops *ops =3D tz->ops;
> >
> >       thermal_zone_device_disable(tz);
> >       thermal_zone_device_unregister(tz);
> > -     kfree(trips);
>
> thermal_of_zone_register() must free the allocated trip points after
> registering the thermal zone.
>
> >       kfree(ops);
> >   }

Good point.

Let me send another update, then.

