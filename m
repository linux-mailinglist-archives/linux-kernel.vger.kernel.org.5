Return-Path: <linux-kernel+bounces-53011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89537849F84
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC32E1C220E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9E3D3AE;
	Mon,  5 Feb 2024 16:31:43 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3751E3EA62;
	Mon,  5 Feb 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150703; cv=none; b=VBs40plXJb9YpxTxQnMAw99yjATa0xe2L+zSzzVziLRFAoDyrR0CZ6XBSITEnMQIM1Cb5/c8EYHGTE68+Fhl5kyEyuMPm5nOuuRqKALXj4/7XPqnP0FASRMzcPLwBQXHh9cSjPkLSBbIMou4Bf7t5vviEPeZTxK2++xAAOv173A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150703; c=relaxed/simple;
	bh=c2Xj0CWK4pM/ZbbTuzimtpxOAlDk7nzXsyyrZD7Y0WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2xGLY5Bgp4Sv9oDGyfVImIE9EZ44p5MLWIBE8i9F5rTgnOUpt4XcX5a04X7by6ABeVD9rdwekNZp6PM3PXP6c3lhQHexVOgYQ9+t7ypo1GZmvwDJkJ27FwtxpcwguIfU++0aCfylfR0ENcd4D8qTicy54UFAKQgWYhV25nthmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-604713c4ee5so3743137b3.0;
        Mon, 05 Feb 2024 08:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150699; x=1707755499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWR3pEGZO6v+mTFVY3DLgK4dPi2tH10vXkils1uXoOQ=;
        b=vmro6LkE7bsBc4ql/lCSymwIa+BvfwH+PWmxRpgbgIXx9ShRoFXgXX/cv7/NIma/bR
         AKRLewHx435MYYulxbweY35IlFLzUy0wNqvVAXwUdbQOueiBWWmXy4Dzqf2y0QWW8FNV
         N4yw73l91MzhP46uTXmUUMRUStv0brBytZAcA3OdJcmN5/L62CIzvSVBc941Gqi5750V
         mf3dg3BiO4BYLQ5Ylblfvfxpf3cuj/GKW80/Z6KmADFG/V+mAoraHS0QKlPVmpcqm/in
         wzna7dNTBeMQdV0jts31+KKlx7offTLksvUTZeYZaiLor09alzEX0iBDRY1LLXGBT+PN
         gv6w==
X-Gm-Message-State: AOJu0YxfXSh3JyLqDp1enUwoxEqaw5HkhgYPQx1Ll55OhsJIsckI9wN8
	iUJ8K6QlY4QhrOblNHYcyZhFqwWLjWI6ptLQvi+DtUNdmxZvua1r9abkUjXJXVs=
X-Google-Smtp-Source: AGHT+IEeSGJonTeidlmtPDtSSITP9K46bqw0zwBsmBOADrZr1YyUdFBHXwT9/GbhB9QF6NtVEuIHRQ==
X-Received: by 2002:a0d:cb85:0:b0:5ff:5e94:277b with SMTP id n127-20020a0dcb85000000b005ff5e94277bmr52288ywd.45.1707150699086;
        Mon, 05 Feb 2024 08:31:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnh8y63D7VD6ktXN5CwkmSN6HIOZVTqxmHZNP8LrQXmIyG1PpxhHhSH2/bl/PJhgKV40KDGZa1na/4JmFR6dWot3aHgR8COEPk2ADbAEeQm4w+f2WN+TakLo+mvRhp//TLeBttivc9j4JlrIIJ1kHEDyKJ6O0q9T82HCN61Y/K47s0OPqGbqg=
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id gu7-20020a05690c458700b0060410ee94a7sm4451ywb.143.2024.02.05.08.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 08:31:38 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6040d33380cso47295307b3.1;
        Mon, 05 Feb 2024 08:31:38 -0800 (PST)
X-Received: by 2002:a81:57d0:0:b0:603:e86b:cd81 with SMTP id
 l199-20020a8157d0000000b00603e86bcd81mr61909ywb.31.1707150698427; Mon, 05 Feb
 2024 08:31:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de>
In-Reply-To: <da6af483-5ee9-45cd-922e-d9d5364674dc@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Feb 2024 17:31:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
Message-ID: <CAMuHMdUxn4Ne7kmEfONz8Uk3Why3m9r83GdM5RzTxm_4Gj_a6g@mail.gmail.com>
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

On Mon, Feb 5, 2024 at 3:23=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Feb 2024 15:08:27 +0100
>
> A wrapper function is available since the commit 890cc39a879906b63912482d=
fc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source cod=
e.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for your patch!

> --- a/drivers/pmdomain/mediatek/mtk-scpsys.c
> +++ b/drivers/pmdomain/mediatek/mtk-scpsys.c
> @@ -441,8 +441,7 @@ static struct scp *init_scp(struct platform_device *p=
dev,
>
>         scp->dev =3D &pdev->dev;
>
> -       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       scp->base =3D devm_ioremap_resource(&pdev->dev, res);
> +       scp->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &re=
s);

Given res is further unused, please use devm_platform_ioremap_resource()
instead, and remove the local variable res.

>         if (IS_ERR(scp->base))
>                 return ERR_CAST(scp->base);
>

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

