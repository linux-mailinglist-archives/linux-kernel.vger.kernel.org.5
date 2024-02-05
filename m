Return-Path: <linux-kernel+bounces-53272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF084A2FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C803EB26635
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279B848782;
	Mon,  5 Feb 2024 19:01:34 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CDA482D1;
	Mon,  5 Feb 2024 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159693; cv=none; b=mI0fv6mqv5dMK3WauNYev72mUBqgRUOJBh3JFT/TN6dZxS7m9sESL16OjY6DgKw5uGhrepVH+4NYH/yOcT6ZkxnLYx+7CIma5ud05HsSURxk6Kui1pwdRoQjOoxxLBOMeI6Rp20iS2mI76ti2GYr8o6XVJHAIYLUyHqHF3TjGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159693; c=relaxed/simple;
	bh=JEt6XbTrmvG2A0mB2qlMp8TsvpF1cCNngcSPF10KDRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFg7rfFZr862OeTALtV53fiTQHGKSWrRXTOgVqlmmiI0cbzQwweq4HMFTYXlsT2T1LTWhMPqjhswyS6Pn9//bglnTeBT+Fd6Av07sGgmB5Wds+fvyqK8y3GcFkEFifi5OTAwVRygN/6EKYzeCq4ToYsg5A0iNA3NzDG98/RDX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-363c503de95so5916155ab.2;
        Mon, 05 Feb 2024 11:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159688; x=1707764488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeMl68ENlhZta5JKP4MegR68EKrrxCv2fGrCfnFczms=;
        b=TkGXElW02g1jThTfrV2OKJ1Onpk8lVHstxAYX5yPCP+YyrYxI0Vj8gbQPWEdPZ4KTJ
         Mm6H6oq/0CW4k6SXRMxVPr42ZN4IipxdJG8PHf/pPqAi1adMlt2Vu6zlFh+Nw2lHLw4l
         wMeVQoZsMFvomk2VrtMLzA4KRrVUKlHiL1EHaZ4IMUqxqc/fo2N1IrsI+tYjKVMPe0rc
         1yNgS8Q3Ef1LssBhStbQsMrd7K11FFaNg/f1nCfs1t6ZeH0I3lr+kwgQQvHjxsihTI9K
         3Il7fxhzmQjLJrVJgBSW+hY/RSQO65E+O9AXP447IlyNf2Y/tUCQfN8cUNgzoeXNI5uY
         1GJg==
X-Gm-Message-State: AOJu0YzHg4e/I+fN9F4R3cNhaYSxXO7osXbdHViSJubhlE9KoNdtM2QM
	1hN5SGqdOg1RLz9bD18YitntpTcwEY6nD3GnsjiIX59YmMT0bQXFiDNetQJ6B0A=
X-Google-Smtp-Source: AGHT+IGCSsROlSPtHzOpI86hYanv64KOK2bo5Q5Dm3PpFBE7zh7fPUM8mo3lT1twvESxHjj0Ri0I+w==
X-Received: by 2002:a05:6e02:5b0:b0:363:74dc:8f5e with SMTP id k16-20020a056e0205b000b0036374dc8f5emr733688ils.0.1707159688577;
        Mon, 05 Feb 2024 11:01:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzucqZW6b+sCROzIo++3iRO6pl84UBCvPfJsEO4mxxgeZM88CxLvgOZUheCUJI9tiaRyePyDQ/1Hmy5BAVo2gR/qxqR9fjtHcVekPAJMDLT4PxYQMS7Swp37zkIfWR0S9uD7mY/aAHwBQbxuuedy/fkaDW61tKSxnm/XvVS/zZv8Yn/YLzgwo=
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id p193-20020a2574ca000000b00dc701e0bdbcsm95980ybc.44.2024.02.05.11.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 11:01:28 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6040d33380cso49188897b3.1;
        Mon, 05 Feb 2024 11:01:27 -0800 (PST)
X-Received: by 2002:a0d:e289:0:b0:604:66f1:35d2 with SMTP id
 l131-20020a0de289000000b0060466f135d2mr475419ywe.49.1707159687571; Mon, 05
 Feb 2024 11:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de> <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
 <8f011126-c95a-4c71-8bc9-a6b0a5823c96@web.de>
In-Reply-To: <8f011126-c95a-4c71-8bc9-a6b0a5823c96@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 20:01:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQLWBQemtgnCHj64wCYAET8J2-MgbisyMChSbh0k0L7w@mail.gmail.com>
Message-ID: <CAMuHMdUQLWBQemtgnCHj64wCYAET8J2-MgbisyMChSbh0k0L7w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: Use devm_platform_get_and_ioremap_resource()
 in init_scp()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Mon, Feb 5, 2024 at 6:28=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
> >> +++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
> >> @@ -441,8 +441,7 @@ static struct scp *init_scp(struct platform_device=
 *pdev,
> >>
> >>         scp->dev =3D &pdev->dev;
> >>
> >> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> -       scp->base =3D devm_ioremap_resource(&pdev->dev, res);
> >> +       scp->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, =
&res);
> >
> > Given res is further unused, please use devm_platform_ioremap_resource(=
)
> > instead, and remove the local variable res.
>
> I got another idea after looking at the implementation of the function
> =E2=80=9Cdevm_platform_get_and_ioremap_resource=E2=80=9D once more.
> https://elixir.bootlin.com/linux/v6.8-rc3/source/drivers/base/platform.c#=
L87
>
> It seems that it is supported to pass a null pointer for the last paramet=
er
> (while this possibility is not mentioned in the interface description so =
far).
> How do you think about to benefit from such a design option any more
> (instead of the determination of a corresponding platform device)?

Yes, you can pass a NULL pointer as the last parameter.
And as this is very common, the wrapper devm_platform_ioremap_resource()
exists.

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

