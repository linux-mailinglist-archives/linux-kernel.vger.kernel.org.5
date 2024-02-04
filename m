Return-Path: <linux-kernel+bounces-51730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E2848EA8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A196A1F21D88
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E75422F07;
	Sun,  4 Feb 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmVfEgyL"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2EC22F00;
	Sun,  4 Feb 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058247; cv=none; b=a6iTtDHQ/JUkOy57A0n+ovZ6ZB+nApCB6G0p+Kb3KWx5Bw1ZZpF/bKNzZvnBIs7owu4jg4oe8nBafgnOzrqDzH0zOBDWLN8RRoPgnVwMQl8g1QUPm/NjFhVLPL8j8nguDZtLkhLdjhn92ljLxictiFX+wHGeROosZH06bgeFO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058247; c=relaxed/simple;
	bh=ggkn1nSdlfUbbzcKp+oXfOr8UTM7M88HiCnkeHGMl50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iskDRimNOrxvg4vGf+UjFLlSHfTbC2RhvnnPCHcUL0p+ghlk/jKItB/MkaH6YwI2x4/U7N7VHQUpGIQhGMkBjVk2Lo8s5FoPzPoLP+HfpW0xLkbqHSOVjqxIbsv4bv1ZanyHd4PM5pa2qY8Q8HtyrtHWO8jxnLtItFIk5FpBHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmVfEgyL; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso3490536276.0;
        Sun, 04 Feb 2024 06:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058245; x=1707663045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leJJ6Axw7wD2gO6odqX9o323K4rTJGwX8umGVdANTFE=;
        b=lmVfEgyLQ7IR++SfnXB/qXnDxyFaBzku1dfYmSwGoBM24WZ5ekZbw9kAGS7PjzvKOQ
         aTLHu7YhTRofP8oQI91wPyHorOuWPo/BVoHFyJRkyT4lpjasVa6OPreU/BA63eUt1304
         +wyuCTlfE0TZ/Woiw0Rwhe/zVkLjYg2lG+MEYZYdn2SopZ2XM8m6xfD4blSyFatoKVH8
         tuluDbug9OUFHC1xoqoshStYDqZacHFNhREvfi15bv1+kJxSqKctNUo5Bc5NOSNQj4NA
         Lxo1E+lxTiCoqXjaaDj6+TXiW4Fz6kPgXCbvIMC1u2k4tJGUnKauJzXEBXzZ4WuzsQpl
         NCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058245; x=1707663045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leJJ6Axw7wD2gO6odqX9o323K4rTJGwX8umGVdANTFE=;
        b=ah/ZE+4t7sljtceLTonZW3WqMjnyXSGkG9CldgZTERX/aexueq0Fkz89wCabWNIzW5
         N5S3LrpvOYxk/t3PrG/98OT07DB37IeCbENWBij+1KhYJH1NWH5JuCgsOWP80wg+GMEa
         wH7Q79LtZsvAL1qQ+exT9JPicSLmvvsjU+fmL3MuwE52XWHoUxRn/DWOJGqqiupKf8XS
         qlB8J4dUOqYacCz8WtjeTxYNO1sC2YbcMhIi3Aqtpj6TfXzQdpdx2rt0dQSuuOZiJ5wW
         DuO9PLJEuNG3jix8uOnxigB5UMsE4OOuQhj4JRnA86PKzw2cfJs4chOaycaOG9cG8z2O
         s82A==
X-Gm-Message-State: AOJu0Yzy+DqCo1c28odVsABlg3sGw5M4b+nFKRnavPwrWX3j33P3rySs
	tT9nYk2XXn5NUunz0PntWGi/gt/yr7/QuNApteGlh4cAt9OvMfsv4NvMaVm96dm+0QDuj33iHrv
	kv5Vm7M49Vj5f4yotbf+csUU3CDE=
X-Google-Smtp-Source: AGHT+IFj7hjRRLAQ6AzJQma1t1x1M8VOOQGdvFKnXCXHNHYe8sclWRCc3725gak4HHdHs1ml4+oKQ+biaTSr1QZP24Q=
X-Received: by 2002:a25:b212:0:b0:dc2:41eb:d8b6 with SMTP id
 i18-20020a25b212000000b00dc241ebd8b6mr12404839ybj.23.1707058244745; Sun, 04
 Feb 2024 06:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117114350.3105-1-maimon.sagi@gmail.com> <8a6c5297-6e86-4f0d-a85e-1a93b2215d68@linux.dev>
 <CAMuE1bFEbrY2PiDB6OdZGzDNijPAhoGBircTpqiyVs0Qq6bOig@mail.gmail.com> <6b88bdc3-37da-423f-a665-308ac519a256@linux.dev>
In-Reply-To: <6b88bdc3-37da-423f-a665-308ac519a256@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 4 Feb 2024 16:50:03 +0200
Message-ID: <CAMuE1bFc6aduG8+26t157ZcaeUt1UeVk1RP47+Hu32G68AmwZg@mail.gmail.com>
Subject: Re: [PATCH v5] ptp: ocp: add Adva timecard support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com, vadfed@fb.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks'
patch v6 is on the way

On Sun, Feb 4, 2024 at 4:39=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 04/02/2024 11:31, Sagi Maimon wrote:
> > Hi Vadim,
> > Sorry but I was on vacation for the last two weeks.
> > So What should I do now:
> > 1) Do you want me to set my changes into the main linux git tree:
> >      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >      and use  use '[PATCH v6] ...' prefix
> > 2) Or
> >      set my changes into the net-next git tree:
> >      git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> >      and use  use '[PATCH net-next v6] ...' prefix
>
> Hi Sagi!
>
> Option 2 is the way to go.
>
> Thanks,
> Vadim
>
> >
> > BR,
> > Sagi
> >
> > On Wed, Jan 17, 2024 at 11:23=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 17/01/2024 11:43, Sagi Maimon wrote:
> >>> Adding support for the Adva timecard.
> >>> The card uses different drivers to provide access to the
> >>> firmware SPI flash (Altera based).
> >>> Other parts of the code are the same and could be reused.
> >>>
> >>
> >> Hi Sagi,
> >>
> >> Thanks for adjusting the code. One signle still have to be
> >> adjusted, see comments below. And this is treated as net-next
> >> material, but net-next is closed now until merge window ends,
> >> you will have to submit new version next week.
> >>
> >> Please, also use '[PATCH net-next v6] ...' prefix for it.
> >>
> >>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> >>> ---
> >>>    Changes since version 4:
> >>>    - alignment fix.
> >>>
> >>
> >> Please, preserve changes from all previous versions for next submissio=
ns.
> >>
> >>>    drivers/ptp/ptp_ocp.c | 302 ++++++++++++++++++++++++++++++++++++++=
++--
> >>>    1 file changed, 293 insertions(+), 9 deletions(-)
> >>>
> >>
> >> [ ..skip.. ]
> >>
> >>> @@ -2603,7 +2819,44 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, str=
uct ocp_resource *r)
> >>>        if (err)
> >>>                return err;
> >>>
> >>> -     return ptp_ocp_init_clock(bp);
> >>> +     return ptp_ocp_init_clock(bp, r->extra);
> >>> +}
> >>> +
> >>> +/* ADVA specific board initializers; last "resource" registered. */
> >>> +static int
> >>> +ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> >>> +{
> >>> +     int err;
> >>> +     u32 version;
> >>> +
> >>> +     bp->flash_start =3D 0xA00000;
> >>> +     bp->eeprom_map =3D fb_eeprom_map;
> >>> +     bp->sma_op =3D &ocp_adva_sma_op;
> >>> +
> >>> +     version =3D ioread32(&bp->image->version);
> >>> +     /* if lower 16 bits are empty, this is the fw loader. */
> >>> +     if ((version & 0xffff) =3D=3D 0) {
> >>> +             version =3D version >> 16;
> >>> +             bp->fw_loader =3D true;
> >>> +     }
> >>> +     bp->fw_tag =3D 1;
> >>
> >> Please, use fw_tag =3D 3 here, other tags are for other vendors.
> >>
> >> Thanks,
> >> Vadim
> >>
> >>> +     bp->fw_version =3D version & 0xffff;
> >>> +     bp->fw_cap =3D OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
> >>> +
> >>> +     ptp_ocp_tod_init(bp);
> >>> +     ptp_ocp_nmea_out_init(bp);
> >>> +     ptp_ocp_signal_init(bp);
> >>> +
> >>
>

