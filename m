Return-Path: <linux-kernel+bounces-58896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A963084EE3D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4ACC1C22546
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B14394;
	Fri,  9 Feb 2024 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsLJOiln"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D6364;
	Fri,  9 Feb 2024 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437743; cv=none; b=ePk94tYU8G0Cj+LdD+SfU0EWm/0PtEQpnpcxmKBn+MMfxDLs92vG+iUw7bhWXWzjUCT/lpIuXpPqQmojWQ6JGx4mzTIDd6x/hHF1+5jQka1GpfdeK3XJvdplknUhbn/mb3He+Raeno106MHtiWisO8VPdRAZxRcOHTmUkAaJ/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437743; c=relaxed/simple;
	bh=titIt4CCbtZUUe3Y7OhLRHUvv2FiGFT9GfkeXAoPx+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqgJtHC+XMpXb2UuWhGn+tHAIGZyDJma5adW76en0dyajQreHr6ZEY7foHxjkn3BZDoQm5InDu7pwWcVHMd1gKp/Yc9AZXGf9xtgX/wXKP5tem8PRtDLYT6iENV3T1WuGd8TDRzVqmRiULtk4AvrlSFO3U1KGbmKnY6mTsl8Gr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsLJOiln; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-290fb65531eso316086a91.2;
        Thu, 08 Feb 2024 16:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707437742; x=1708042542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I8E7dlbCyWRIqFRdrdMKsIVLgbabkuiMYmBMR3beWM=;
        b=DsLJOilnjvUqulcbAXT4wSmyMSphjrTPlsOQyLM5PoHpdYu7BW1pegqwe2h3EhxNmf
         joH6sr2WztLvuPFNXrynXpZ3p03mqluEs6dOdGY7pD+O/Uu+liooRMHNLfhSFKS5Blir
         JwLtvRcpnMVhxNoOk/UlD6cnjxMCucPbN/dapAYcn12JhcVvFviMV35B3BlQVsYFyjYN
         PkwSOvc77I8xAtV75kKAmCZHgKUm370O/mwaR0QbEWH88xgl+5RaHTO+dWXTiS7CtcQt
         88eTqlpHiNIXDXYf1gg3SEFDR72C+8FjaKB/obPGDfRxPCg5tG/0Qwvb72BkIR2tzBAb
         ak2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707437742; x=1708042542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6I8E7dlbCyWRIqFRdrdMKsIVLgbabkuiMYmBMR3beWM=;
        b=bGa5RiJNIXY0i4BnkV+/szS2lKxMx/xa5mv4zjSUwDEhoMHlmvbzl5estzCzVWPtTe
         6Rl5H32enPVNPHl249uTCmkyFjfACBwTKEVQ72SyNX6v5wg1+0iHAYCTZgUwdB7pBTtr
         7Z04603x/+O2Ep//W0zWUMorurh9w29E3IUjQ7lbZdqj+Xt95WUPLXo/6UUEJO/c7lhs
         9TOsA3QyEX5AAlPD4Wf6fidANWsiPTJhkfrytcjHY0SMWxUTrVvo998YDr+QqCAxj4pL
         HRmjArfMpmQfrF1iDcmeleKX4dKEG7YqoAAMkg6X+w3KP7Qyl5fAsJpwj8wToJckqcFG
         N69g==
X-Gm-Message-State: AOJu0YxkEZkjzmKYZeeZcEwcPJpDtE93lVhLW2LYqsM52CTwY750a6V+
	SbyyOH1vpMOXyosYdFxdQGyDYEDTE602ZujHzlcGEvtqREAYX/rZ/CPAog62BeGffSzhaIbQLnM
	PDCLi+fu+ErfEn5xia8QIQJ/6rBk=
X-Google-Smtp-Source: AGHT+IFOY68uCe5Z/o2YBXMA2IqJLAfdcoQyOxtJlD7klugUXQbLIjKj8r7gwL8n3RgQqSwdBYIOWh57OpHVqyF2Dmc=
X-Received: by 2002:a17:90a:db02:b0:295:f024:60d4 with SMTP id
 g2-20020a17090adb0200b00295f02460d4mr13306pjv.4.1707437741682; Thu, 08 Feb
 2024 16:15:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131180757.35044-1-vishnuocv@gmail.com> <901e1fb0-1e42-7bf7-113d-3d0bbb62f4da@linux.intel.com>
 <CABxCQKvtgwxS_DU2U-LNrPiqHF4+y2YPkMgP4-nS6U3ccp8M7w@mail.gmail.com> <2f280707-7250-4bb2-460c-5f8a02208179@linux.intel.com>
In-Reply-To: <2f280707-7250-4bb2-460c-5f8a02208179@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Fri, 9 Feb 2024 09:15:04 +0900
Message-ID: <CABxCQKthnVk4GOMu5M8Q8PbioO72AaiHSfbu-SB2KjuOz4ZU5A@mail.gmail.com>
Subject: Re: [PATCH] Fix to correct wrong temp reporting on some ThinkPads
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, vsankar@lenovo.com, 
	Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:11=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 8 Feb 2024, Vishnu Sankar wrote:
>
> > Thanks a lot for the review.
> > And sorry for the delay in response.
>
> Small improvements to my earlier version below now that I reread it.
>
> > On Tue, Feb 6, 2024 at 8:03=E2=80=AFPM Ilpo J=C3=A4rvinen <ilpo.jarvine=
n@linux.intel.com> wrote:
> >
> > > @@ -6174,6 +6191,21 @@ static int thermal_get_sensor(int idx, s32 *va=
lue)
> ...
> >       A code reader would be served much better if this convoluted logi=
c is
> >       simplied to:
> >
> >               case TPACPI_THERMAL_TPEC_12:
> >                       if (idx >=3D 12)
> >                               return -EINVAL;
> >
> >                       if (idx <=3D 7)
>
> if (idx < 8)    <- to match idx - 8
Acked
>
> >                               ec_offset =3D TP_EC_THERMAL_TMP0_NS + idx=
;
> >                       else
> >                               ec_offset =3D TP_EC_THERMAL_TMP8_NS + (id=
x - 8);
> >
> >                       if (!acpi_ec_read(ec_offset, &tmp))
> >                               return -EIO;
> >
> >                       *value =3D tmp * 1000;
>
> 1000 should likely be something from linux/units.h.
Got it.
Will use KILO.
>
>
> --
>  i.



--=20

Regards,

      Vishnu Sankar
     +817015150407 (Japan)

