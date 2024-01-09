Return-Path: <linux-kernel+bounces-20841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA08285FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C499CB216AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C181381CC;
	Tue,  9 Jan 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo1PTc2I"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B33381B5;
	Tue,  9 Jan 2024 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e54d40cca2so20951917b3.3;
        Tue, 09 Jan 2024 04:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704803217; x=1705408017; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHExOBZeQzLMe10P1MtL1lm7ZcxLLhDQdL774OYObu4=;
        b=Fo1PTc2IDhdsq4esXI++VM0aTCipJBcKGofB7dmxq8v29qBwiyIhQT3cxhLAks8GCa
         fzRoGu63b3RVM0G0LA905/q8rvjJkC9uwMPuhQvTkXxujE1u6th9CvC+4m6xXxOULq/0
         kBbFaEomRaRjVhRWqdrOtGdsHaP88jZws2AiwOQVHAT1ZxPSveFEeMOC9akZwZJhweil
         KezeXAwXko96zNNjiPrKC/aSbYRFl1r+3TE8/VmuHdStxSR2SQGtgqTZHfYNg2lmAUuA
         9NNfY7IunApyqjufXM4/Ur/P9/SEVzHovRcdJ39C7H2YWy2jE0FLUgl9Ljz6ABlKkwmr
         SvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704803217; x=1705408017;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHExOBZeQzLMe10P1MtL1lm7ZcxLLhDQdL774OYObu4=;
        b=CXiMK+5SgOm8c6bYdw1Sjny37KUPoyD+fmfy6O53vFtHn8bIcE9abgXzNcV59VB1kZ
         S2GvJv0C9GlqHowdI50ldpioRjoRX/BYQ3mr1uy7x9LEDDqddO0amp6pnXqnELlTrOCH
         pifk/ZFR4CTwlZBAlwshcSnv0UsZG8x+nX5za6k9VwqOeP1lsf/MIc3SJmNryFa3UsV5
         XRuHpz/tT6U65vjZshnx3tLBsXn5P8gzK/yS4kcKtYvJb3EmRwHq2Vua4aAIPANcHbCH
         8EKj5nATXHeh6o7pwPK3+092lY/aYMWUs4Z/8UAJjvFw6YJSI9V7eaGKJylcamqSZEMz
         ibWg==
X-Gm-Message-State: AOJu0Ywv3I25NMwUNOD6vgLtNJLfemAV9zn9Osf6hDAepJUNQeTPgkaO
	5kxxMmx/mXfLTBNLn+4kEw1uzz0XuU9+zANwWgw=
X-Google-Smtp-Source: AGHT+IGbWLxD44dwNrHqztkSHd5S1WqM2KPhQ8rhb1YT/zYOkT+qh2Q8HRhGUjUsnBcEzmR1Y4jEEb+ZwU0YXb6+jOw=
X-Received: by 2002:a81:bc0f:0:b0:5f6:f789:e044 with SMTP id
 a15-20020a81bc0f000000b005f6f789e044mr1918585ywi.30.1704803217158; Tue, 09
 Jan 2024 04:26:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231073352.1929-1-yongsuyoo0215@gmail.com>
In-Reply-To: <20231231073352.1929-1-yongsuyoo0215@gmail.com>
From: YongSu Yoo <yongsuyoo0215@gmail.com>
Date: Tue, 9 Jan 2024 21:26:45 +0900
Message-ID: <CANXPkT4yURQ4YYxU+rAnvULNWBOhEe2KVLUBPmbQ-tKdtA=O-Q@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] media: dvb_ca_en50221: Fix a bug for detecting CI MODULE
To: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yongsu.yoo@lge.com, v4bel@theori.io, 
	0215yys@hanmail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear All

Do you know how can I change
from [PATCH] [PATCH] media: dvb_ca_en50221: Fix a bug for dete...
to [PATCH] media: dvb_ca_en50221: Fix a bug for dete... ?

2023=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 4:33, =
<yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Yongsu yoo <yongsuyoo0215@gmail.com>
>
> Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
>
> In source/drivers/media/dvb-core/dvb_ca_en50221.c, if the CA_RESET
> ioctl is called, the dvb_ca_en50221_slot_shutdown will also be called.
> Inside of the dvb_ca_en50221_slot_shutdown,
> the ca->slot_info[slot].slot_state will become DVB_CA_SLOTSTATE_NONE.
> In the most of cases, the ca->slot_info[slot].slot_state will quickly
> becomes restored to other states by the subsequent operations of the
> thread dvb_ca_en50221_thread_state_machine.
> But in some rare cases, when the CA_GET_SLOT_INFO ioctl is immediately
> called after the CA_RESET ioctl is called, the
> the ca->slot_info[slot].slot_state can still remains at
> DVB_CA_SLOTSTATE_NONE, and this causes CA_GET_SLOT_INFO ioctl not to
> return CA_CI_MODULE_PRESENT as info->flags even if CA_CI_MODULE is
> really connected on TV. This means that the CA_GET_SLOT_INFO ioctl
> does not return right informtion. This is a Bug. We fix this bug.
> ---
>  drivers/media/dvb-core/dvb_ca_en50221.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-=
core/dvb_ca_en50221.c
> index baf64540dc00..8d37c3c13227 100644
> --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> @@ -1403,6 +1403,10 @@ static int dvb_ca_en50221_io_do_ioctl(struct file =
*file,
>                     (sl->slot_state !=3D DVB_CA_SLOTSTATE_INVALID)) {
>                         info->flags =3D CA_CI_MODULE_PRESENT;
>                 }
> +               if ((sl->slot_state =3D=3D DVB_CA_SLOTSTATE_NONE) &&
> +                   (sl->camchange_type =3D=3D DVB_CA_EN50221_CAMCHANGE_I=
NSERTED)) {
> +                       info->flags =3D CA_CI_MODULE_PRESENT;
> +               }
>                 if (sl->slot_state =3D=3D DVB_CA_SLOTSTATE_RUNNING)
>                         info->flags |=3D CA_CI_MODULE_READY;
>                 break;
> --
> 2.17.1
>

