Return-Path: <linux-kernel+bounces-57850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727A784DE2F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117591F22BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5682F71B25;
	Thu,  8 Feb 2024 10:22:48 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15396F532;
	Thu,  8 Feb 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387767; cv=none; b=EIR0ZpqGw/sk6JAD5Vf3BGBRbTlcWck/gdthtrVekusKIdiFooNyfLJ3+waU9gdWGLTmB7yScZFtK7WqCkDohRQeDyVbf/GUHaa1BRFJ5twF99xKnsma6Z3/yBg1uIhs0K59D2RfXehKmpMgD9sI1hulGBgKDL/jX2TlVPo6afA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387767; c=relaxed/simple;
	bh=1UH2o59ts+vAt0TTrrMt0M5kj3HFA0zfmOKue6ZirfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+PL/QxT0g36ulm/V6s1t7MufKfHzMRpkWtduuoWGSqTF9lNoWT1+tQfPU9a7F4BFjUm3GOKpfhGLwHtoeS2o/0GZK23SLX2ZVDRQOsw1M+e0OD/YH5ZwtJns8Wp/dDCbVzLbVdU0vM2Mmwa5BweO6UgiUrI3UTJh9LED/hVilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604a05a36d2so10792957b3.0;
        Thu, 08 Feb 2024 02:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387763; x=1707992563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P719nC8BiBLtYPLKz3vIEqLB5ifdhnjRlwd0//T3ZAg=;
        b=IlNbiyjcf8dG395iD7doxlwGKcVSxJrsmz7ukCB2yG1h0+INJsjSEGm5YsAN9ldXwx
         IaSQZUuSOAtxk57BRtM0ee5LqXHSo+f7Ozs2wtEaKgN2cmTei7LOL2NYpaFL8ReEq3h/
         SGoXfqdzxw10DHvFNfQiz0ThobMS7tz4EvcfovTvYopfjm+pzo+MkGoP9X4zH+2ujo3w
         4AV7FOcBdtVTfvp9AxY1/NxvfPxoE+MyVcd9H8so7HkL81sQxLfdD9FPOKegI1/Mf/7j
         93ae6LkAXqgyC+5dKbMn+klMsGzU5NRDdAwK2JBkiRs3CzeYvCXixTY2iH6RSEGshB5B
         gVYg==
X-Gm-Message-State: AOJu0YxcYFcFOSsw798rDZMF4R6xZrmkQ4b9VoOnUynoJxXYneQMCRPY
	ho83Yf7g2CV8SyJDFFscVgZ3BFTbYXuYX+KytjeUGugH88PUwGnbbb3NC8KF/LM=
X-Google-Smtp-Source: AGHT+IETwm/JSu9xMfCeplIXYMQedn3Yy9M2WyehpPNbsLU7pfOCtOxdQB1ocMO4lW1vZOO/TvR8qQ==
X-Received: by 2002:a0d:e893:0:b0:604:a3c1:1b1a with SMTP id r141-20020a0de893000000b00604a3c11b1amr2083104ywe.38.1707387762952;
        Thu, 08 Feb 2024 02:22:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2GTO5HIpxHYuILbyGC52lkCMrktua947fzUF70hkuzfGlfeqKANIoI6UqlWH6J74uReyU0kxUFFt+Xena97U1zPIvnH8bdYR/k6NkCOrGZN3KV6tN2BYKpHbCv2Qsu8ph+0jLbUHS8M1quQ==
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id b141-20020a0dd993000000b00604941e2f1fsm553131ywe.130.2024.02.08.02.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 02:22:42 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-604a05a36d2so10792397b3.0;
        Thu, 08 Feb 2024 02:22:42 -0800 (PST)
X-Received: by 2002:a81:e809:0:b0:5ff:b07b:fb0b with SMTP id
 a9-20020a81e809000000b005ffb07bfb0bmr7260196ywm.49.1707387761877; Thu, 08 Feb
 2024 02:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208084512.3803250-1-lee@kernel.org> <20240208084512.3803250-4-lee@kernel.org>
In-Reply-To: <20240208084512.3803250-4-lee@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Feb 2024 11:22:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
Message-ID: <CAMuHMdX72mpGgb3Wp0WRX3V78nn+bWUqiYz25CjeMNPpWaPmxg@mail.gmail.com>
Subject: Re: [PATCH 03/10] scsi: NCR5380: Replace snprintf() with the safer
 scnprintf() variant
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Finn Thain <fthain@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, drew@colorado.edu, 
	Tnx to <Thomas_Roesch@m2.maus.de>, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

Thanks for your patch!

On Thu, Feb 8, 2024 at 9:48=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).  So let's
> do that.

Confused... The return value is not used at all?

> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -421,14 +421,14 @@ static int NCR5380_init(struct Scsi_Host *instance,=
 int flags)
>         if (!hostdata->work_q)
>                 return -ENOMEM;
>
> -       snprintf(hostdata->info, sizeof(hostdata->info),
> -               "%s, irq %d, io_port 0x%lx, base 0x%lx, can_queue %d, cmd=
_per_lun %d, sg_tablesize %d, this_id %d, flags { %s%s%s}",
> -               instance->hostt->name, instance->irq, hostdata->io_port,
> -               hostdata->base, instance->can_queue, instance->cmd_per_lu=
n,
> -               instance->sg_tablesize, instance->this_id,
> -               hostdata->flags & FLAG_DMA_FIXUP     ? "DMA_FIXUP "     :=
 "",
> -               hostdata->flags & FLAG_NO_PSEUDO_DMA ? "NO_PSEUDO_DMA " :=
 "",
> -               hostdata->flags & FLAG_TOSHIBA_DELAY ? "TOSHIBA_DELAY " :=
 "");
> +       scnprintf(hostdata->info, sizeof(hostdata->info),
> +                "%s, irq %d, io_port 0x%lx, base 0x%lx, can_queue %d, cm=
d_per_lun %d, sg_tablesize %d, this_id %d, flags { %s%s%s}",
> +                instance->hostt->name, instance->irq, hostdata->io_port,
> +                hostdata->base, instance->can_queue, instance->cmd_per_l=
un,
> +                instance->sg_tablesize, instance->this_id,
> +                hostdata->flags & FLAG_DMA_FIXUP     ? "DMA_FIXUP "     =
: "",
> +                hostdata->flags & FLAG_NO_PSEUDO_DMA ? "NO_PSEUDO_DMA " =
: "",
> +                hostdata->flags & FLAG_TOSHIBA_DELAY ? "TOSHIBA_DELAY " =
: "");
>
>         NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
>         NCR5380_write(MODE_REG, MR_BASE);

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

