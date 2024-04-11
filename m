Return-Path: <linux-kernel+bounces-140399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B18A13E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C2C1F214BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C2314B08A;
	Thu, 11 Apr 2024 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8YWoFer"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052C2143898;
	Thu, 11 Apr 2024 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837013; cv=none; b=QnKXKxbPxxs0zISQxgxutLl+KdduUUjttZqTRJDKYccsPmhl7fnOL9BfSzUxDO8Icb9ulpKDQECyj8HGVkFbEDSepifiyS73HpDXCR956Y0kWBKDos0U2qcjfd/mgoFh8bkYu5EZ1u8lSBzSO6Ncl8dDTPI6BP7kA1t8s2gsTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837013; c=relaxed/simple;
	bh=b7k5sCvXgr5cKU8jGKYUf0FBvVisLtLitgRXFAw9OhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AFGljxZmtWkE6mNYXXwWOzOz/2Wh7LYtBR0T6mVMmWdkLSB+ECc67tYj/17dx7uUOLijJYrJylzpgcm0lfvrE5X1VWpBAnjfPCoJ0OxAzq6ViVARSvXW7MF+7w1zzJOAFr0gdybR2+h73uSibu1pGBEUxwLbmCMq1PDrdLYzrL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8YWoFer; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso5946915a12.0;
        Thu, 11 Apr 2024 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712837010; x=1713441810; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC3dxQYcnHC/jIqeccSVEMvUjj7u07W27lVj2MYVHOE=;
        b=D8YWoFerP5c7ijo+t4moFPxZGplc0G0egKk80lSSTqPXsBBUjz+TzbxA3ACy0fh7Bp
         baLbSfYq4gKBeakk5Uv9HINYHqPoZkpRtTaLxw14+rEdpbKyoHfm9inNaqm9PAkg9fAC
         5T/JbjLJUz/Lmy6ioPOzINiaGCK3ZgHXUp67W2OKEhRxdxpIEwZwlcgCq6TI5fbFsMyv
         78BYp0iaRiBPH5EaZKuCLOWnBLraCYe/vUPmXjXNfhQ37RJBDiTf8ihtmXVuKC9wrY7a
         9RJVwYo28DYYNNniKzLhzMicNRo6YRAltNQ0kP2zPuL+2bIdTrRFFPSEVT1uVRwPjIqD
         tjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712837010; x=1713441810;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC3dxQYcnHC/jIqeccSVEMvUjj7u07W27lVj2MYVHOE=;
        b=XKJWI/PZTAGIuUDIj3L6Jg/VriQVgBE/s4Y1Wg/D/b4lB1NX+VM2uKh77DlWhyVATM
         nHRYonsTY8QT13+3kC0yhkIfQhnD/PaOf8pLeJNT57B+CTd8Q/JU9zUqltDy175aD7jm
         M9+Zo6iEzDOR+U/j1SVIF5qPK3C0WmY1IbzH4o+nDAnz9Tja7Ge/MjBPl41BCzs3Kwb8
         hDxVB/HlQwUiGCwOefUTYFouvnkwnCRxl7EmxJ3/kgsYTJCKdcom9GBZ+LqsrcJsrMru
         htbePsMI9lK7R9SEY9g/MkS+gQ/12oHKFZG0VAxNBEmqTiofD151+IGsgdoyJcdCIIrx
         gBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgcpF9LsB7KjJGc61/T+grrXLZe83XrNwcheCPiF0WXOt4GJxGp5vpXeQ5MJlWvxX2plO2EZ89v1axN7SsuAdy5UxZD0A7lFftNXuC4bTgPkOP0C75J1qkyhKLNpe8m1x/qJx9S8v4Q+c=
X-Gm-Message-State: AOJu0YwkV1OSk+7eolUao7umDpGIYcwYUaSu7jCa52vp2kgVx9KsM+hC
	xvHHC0RFtgQusNOU7WB55Eo2g+pdg6Xkjkye70lnqT0Hqh2p0eRrs0kPDvm2QkBbn9zHFo6tosr
	XTavHVCA49tMYAOOWraNOpLsHXRc=
X-Google-Smtp-Source: AGHT+IHaXa6zLXrIwwxw35tFKWAztkCw6auyKXq4dF0laNUaTtwNedm5O0YIEsrrveWo+TKIRfTw/JFSdSEOsSnEoCA=
X-Received: by 2002:a17:90a:4cc7:b0:2a4:a87c:b907 with SMTP id
 k65-20020a17090a4cc700b002a4a87cb907mr4848297pjh.4.1712837010194; Thu, 11 Apr
 2024 05:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308121021.1732-1-yongsuyoo0215@gmail.com>
In-Reply-To: <20240308121021.1732-1-yongsuyoo0215@gmail.com>
From: YongSu Yoo <yongsuyoo0215@gmail.com>
Date: Thu, 11 Apr 2024 21:03:18 +0900
Message-ID: <CANXPkT4_9dkLVe8VUBaOceFRTBMqZOD=u9a1=X54TqvcOjv67A@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ca_en50221: Fix a bug for detecting CI MODULE
To: mchehab@kernel.org, yongsuyoo0215@gmail.com, v4bel@theori.io, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear All

Can you review this patch ?
Can you share how this modification is going ?

2024=EB=85=84 3=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:10, <y=
ongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
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

