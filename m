Return-Path: <linux-kernel+bounces-148397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109EB8A81F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04F1282732
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77113C9A7;
	Wed, 17 Apr 2024 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="AJlFcAV6"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C613C688
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352875; cv=none; b=onparPtDc93y8mmSM/ajrHLewxoaCwEtkd9hDkuCxpsRd1dZMmFQVnkUKJcYyk6Pa7PBo3tlUcfkgFMigoh2Sy1UgkWOX6mskIlz/vIfsbLQbT3DmIHOOKIOS4DJO9EzkkXm9vnPILMTmj8cIrvWWRgD+5CRLtF5ML13imDeC50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352875; c=relaxed/simple;
	bh=r38whn7e6hZpUydVgOSRQQREjjfoslT3sTH/8PXQhQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2X8aUGLXSRDWaId/4OdBpQ3bUWuhac2n88vTp3Tr4fZL5InvPPNzYx2EhUOdvLYz8UTBPUUY5asDvTwET/K3kWStSVxr/NxxxojPkQx3YckgqLZ+ItVS8LK4YDTDHvUrxIWAwDwfj2X0EI6gU7tlo3YROszMEXs21SghbJsebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=AJlFcAV6; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36b2ecd7b76so2152905ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713352873; x=1713957673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wo3tJl+r0Q5L6IhFgltTmeaHNPh96s/DvAlUqUboY2I=;
        b=AJlFcAV6+pWrRTVk1omi09HMlK2HJrT6eCpEW49MvliBx4VIGy0QHdLobPbxQ6foSg
         0xq1kMQx2gopYjKAIrMa97AkOS4xTiph08y5AMgpB0m8oNdSC6wU2uC7WnQ/lq/zhMAo
         JpsfQDxxWFZQp+PoLLxHwQGmBwVmztwWc6sSAIkYJHtdiBDAkcJVjis0CCXm4L5WKVDE
         8ZXxsC/2VgzpZyj0fTMhSUtT7pvrIJOG9wGGNbLbQQYbYC0xez/hCWQFYfCo0WmLRwSx
         dkh8nOE16Nl6QKPcX862bh3v9VdgbKXVayptJlxn7NxGSm1jrxB3Cx8OO6RJKvYYnsPI
         Rzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713352873; x=1713957673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo3tJl+r0Q5L6IhFgltTmeaHNPh96s/DvAlUqUboY2I=;
        b=lfJAiEmSagu8mxQ/A+UPMJQ+c6BrrXKMv7bO6F3eyaVojAzG3l/BdpRN+THLWHz6w0
         RPfRtWZcghX73KqLdYNrore7uZHd5fhSuL0rNnpRP7VYbs6KImzhi8M/eyNnRV+OTPc1
         RvtMkuAbD63FhDHTruc98CeSA3vSiQpXv2g2mBuwouDm8gAvHRyXGFqdcbu2nfeJvwcY
         VGr61TtNqG2h4HeypYteDvlf1Uo+3a6yzlMAocFRB3eWyo/qHXXtQ8CWQ8gsnlk+uqjX
         I4w7cd+Owk4zPaS6G6qDE5AfjgOGF/aCRzSEVX4SCVdFhYuNpeggX7hXJ83wZYOGtuP1
         udSg==
X-Forwarded-Encrypted: i=1; AJvYcCVy3mrISfDGtVpU4wuQeDWkeAgRywpLFhaHzmgv6XYbnFgIAQK08RkP6q8bAEYzR+wB0sJzyzN5RJ5aWrFiSHDAxMW1tPsxUSLZjvkR
X-Gm-Message-State: AOJu0YzhgQr5bgvsDw3cCJAoe16ckKtTje9XCyMMXY4AQKTtAgWbwPVN
	XI9iPj4XPC7vJYInQmAf0Nid0fSdeoTqlPRHdF7hcguULknKSSk0FwNTL6ppcBzTEdKUXbdlr49
	e9vC7GB/2WhOQ5r3LSimZmuqYcsoY4zvi5rnVHg==
X-Google-Smtp-Source: AGHT+IEyzUb/wahpxoydcXV5uCW+8dGCT+DB9VmB7o8yYrbEp55n9+Dn3vQjI636gqBgd40XA+7xmozcCLMqNTBQ1xY=
X-Received: by 2002:a92:c269:0:b0:368:920b:e211 with SMTP id
 h9-20020a92c269000000b00368920be211mr3668709ild.5.1713352872486; Wed, 17 Apr
 2024 04:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416085454.3547175-1-dawei.li@shingroup.cn> <20240416085454.3547175-7-dawei.li@shingroup.cn>
In-Reply-To: <20240416085454.3547175-7-dawei.li@shingroup.cn>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 17 Apr 2024 16:51:00 +0530
Message-ID: <CAAhSdy13UZ_iXp6_Q2RV1qHgbYc7S6VzENmz=vTezmc34uEwNg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] irqchip/sifive-plic: Avoid explicit cpumask
 allocation on stack
To: Dawei Li <dawei.li@shingroup.cn>
Cc: tglx@linutronix.de, yury.norov@gmail.com, rafael@kernel.org, 
	akpm@linux-foundation.org, maz@kernel.org, florian.fainelli@broadcom.com, 
	chenhuacai@kernel.org, jiaxun.yang@flygoat.com, palmer@dabbelt.com, 
	samuel.holland@sifive.com, linux@rasmusvillemoes.dk, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:26=E2=80=AFPM Dawei Li <dawei.li@shingroup.cn> wr=
ote:
>
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
>
> Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
> the stack.
>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-sifive-plic.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index f3d4cb9e34f7..8fb183ced1e7 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -164,15 +164,12 @@ static int plic_set_affinity(struct irq_data *d,
>                              const struct cpumask *mask_val, bool force)
>  {
>         unsigned int cpu;
> -       struct cpumask amask;
>         struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
>
> -       cpumask_and(&amask, &priv->lmask, mask_val);
> -
>         if (force)
> -               cpu =3D cpumask_first(&amask);
> +               cpu =3D cpumask_first_and(&priv->lmask, mask_val);
>         else
> -               cpu =3D cpumask_any_and(&amask, cpu_online_mask);
> +               cpu =3D cpumask_first_and_and(&priv->lmask, mask_val, cpu=
_online_mask);
>
>         if (cpu >=3D nr_cpu_ids)
>                 return -EINVAL;
> --
> 2.27.0
>

