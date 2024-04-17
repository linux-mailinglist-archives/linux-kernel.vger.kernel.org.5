Return-Path: <linux-kernel+bounces-148398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5618A81F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D31E1F22048
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748813C918;
	Wed, 17 Apr 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="kyamuJ58"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731713C832
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352934; cv=none; b=O0UoJ/Xo/C1rEXF75l39bFz+fFa0VoQqOlc1k+cf+RHdutoN5ztWYfKM5qGk1ZWMD7FujdZsbrzBkPLEFOj6uPw3kWBaVFCq+/l7zNg1WBSSkHNeTK9Gqr0jbg4x7ZMwvfT3NWW9OuPUYX76c+VmnumJHHH10AAgMQ/c+jFhbzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352934; c=relaxed/simple;
	bh=06o5/l/QXwWPIe3LhcnajPdJhJHNgNguhpsLpwTjyuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZwkPBAOfxreX2OA3xCsbPQHNhqpeP3LmDKJyao/ZZbScGBCOFYvAixbzQzjcsFhaC4sIAt4Om2GDvwQjHmBMZquEs80A/z00+7tt41EKDfVG27MOK1tfLSShIIXjmxpc9IBU8uy+R9bPd+3YAV53NVtNdA5KueisrXNH1p/m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=kyamuJ58; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a38c13550so26818745ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713352932; x=1713957732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gw+dhEAFwTaGUd2mP5T7qSr6jOumAbjePO8A/liTFo=;
        b=kyamuJ585sHm5ruWPfOO+SBoAjeRBAnb7h463cDRoYQ2WFNvadqjAG6EVszUk3V+aa
         KXHavhch5XIvlENh1MzX779zWSl0dQgxhBq+Ghj8CUG8yhiXGfC2KpJjA5KNouT3Owfz
         KEBsclQAoeoO0SZZ7VDpAnzG8vuD7eTDKlQ/08Ve+DgUrNavzNHWvEJh97KCCDa/uXZh
         ES46CnHl0LxmQKW1fsS7T/Tq0eevGuBBGlo93wH2wVlcpTONckZaErS0SEzO2MZ/9KgK
         kaJPhXBIBattZDMOzXrasW5UMHBETDgutnCGSANYzodi25fTXpDR1YNkmSSOR/1g8m0k
         LB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713352932; x=1713957732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gw+dhEAFwTaGUd2mP5T7qSr6jOumAbjePO8A/liTFo=;
        b=vzl/oaFqk85n1kgOZL8zonU3Pj9FdDQ8LjDdLAQQ55EbYo4OZeGIlA0zdr9AdqX8C8
         B0R74uPbcmqHLx/GN3BT20xPWu02w5GK1GkqBvXAYAkZzkMPwlR5bmoMoKIJf9F8peB6
         V3sG2qlDoVxBt5GYjYK5bSBwHnGRoVhSqnza5Hco9Otz2jc+rG28AywRF1ADssXj3ag3
         VfAwtOKyYddSQwLkQDn+TvYdHF/3V8HvpCb8sNR64LmXfqChDvGyLz7v04YBRVDt6E15
         aaiSlzt8gtGkX1rpETS9zquqkoaQHnHU7skIRl9EyxrsXSUow4+pVv0ChdFcoYLG7MLA
         Q40g==
X-Forwarded-Encrypted: i=1; AJvYcCVdwgEH7s1DVj3u+90WHSzRZkTG6yF06rQcF7iY23/YWf0zyZbhyu3MU4HFR4lXqwkbSO8L3iR8s4Rgh1OvhUBm7WV17/mqRk3gY6Ls
X-Gm-Message-State: AOJu0YyrG0nK/0HGUIYBpBzku/1K/Shqh2Tju3tZom52l1QZcZTlfcYW
	SSnwba9rTYGGjZhe3/mEVhwlz82La+JRLSmvY6LwxZFdprX4rroYjCkSX+h5Uw1JlL9DUMxujG4
	YWUB68fIZ8urW4xScDtlhQWYsXtrwjACGk357DzvpSRdcTValAGU=
X-Google-Smtp-Source: AGHT+IEaVs/nciJImef1H0ObjQRxm2MGFcPJl8l7BH/EoLnFn02B56zC3NNAMvjK0N02rL+wJYpGC7u2tpCGimCapjM=
X-Received: by 2002:a05:6e02:16c8:b0:36a:27a4:da76 with SMTP id
 8-20020a056e0216c800b0036a27a4da76mr20016795ilx.9.1713352932605; Wed, 17 Apr
 2024 04:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416085454.3547175-1-dawei.li@shingroup.cn> <20240416085454.3547175-6-dawei.li@shingroup.cn>
In-Reply-To: <20240416085454.3547175-6-dawei.li@shingroup.cn>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 17 Apr 2024 16:52:00 +0530
Message-ID: <CAAhSdy0b8xV9a4=W5TGWM+piizJVWHDFKgLjnxH1UvkjFTbNbw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] irqchip/riscv-aplic-direct: Avoid explicit cpumask
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
>  drivers/irqchip/irq-riscv-aplic-direct.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/i=
rq-riscv-aplic-direct.c
> index 06bace9b7497..4a3ffe856d6c 100644
> --- a/drivers/irqchip/irq-riscv-aplic-direct.c
> +++ b/drivers/irqchip/irq-riscv-aplic-direct.c
> @@ -54,15 +54,12 @@ static int aplic_direct_set_affinity(struct irq_data =
*d, const struct cpumask *m
>         struct aplic_direct *direct =3D container_of(priv, struct aplic_d=
irect, priv);
>         struct aplic_idc *idc;
>         unsigned int cpu, val;
> -       struct cpumask amask;
>         void __iomem *target;
>
> -       cpumask_and(&amask, &direct->lmask, mask_val);
> -
>         if (force)
> -               cpu =3D cpumask_first(&amask);
> +               cpu =3D cpumask_first_and(&direct->lmask, mask_val);
>         else
> -               cpu =3D cpumask_any_and(&amask, cpu_online_mask);
> +               cpu =3D cpumask_first_and_and(&direct->lmask, mask_val, c=
pu_online_mask);
>
>         if (cpu >=3D nr_cpu_ids)
>                 return -EINVAL;
> --
> 2.27.0
>

