Return-Path: <linux-kernel+bounces-20842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9075A828601
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B882873BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5516A381CD;
	Tue,  9 Jan 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaTUz7xG"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD9381B5;
	Tue,  9 Jan 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b79c5d035fso520978e0c.0;
        Tue, 09 Jan 2024 04:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704803315; x=1705408115; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMieFkaeG1CJtNxgRjfc0/kcLvoYVNibgc4cmNBWXG8=;
        b=WaTUz7xGciX4QB5n7a2cNbkYjyh+7M2ygpOCMUTzknpsIgDM5kT6RyDk6hyN14GdDy
         jkc8Wcz74ErG9gpCoeDf+MFZshwEv+vR0NzLu6d+1FBLZHZxbq6j/RpcKw6DPHc6Ih6e
         RbVF4wEPf8n1UnkdJz7lDik67uQA8mxHwsCxBy4Nf7MQbZwuQ30/t/vGo1VVXD2dVafL
         6TbZMH896S8LK1EbkEIvtPejNpRzL9A3oTqvh3Us1U8DtNYiqXbJ6/+NHZmoxgXYPnWs
         dRkfCxOcVJpdIc+swnQNNGDed+bpAeJnPz7bFoBZDU0UzUc7zIG5Dntg8FH8UGRpaR6t
         x3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704803315; x=1705408115;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMieFkaeG1CJtNxgRjfc0/kcLvoYVNibgc4cmNBWXG8=;
        b=btwysFV81CWoDLkhkmAIrjmEB0M4h1WtFmCWO8pj/y2ESjiC6RD6EUBlLMOvH35mwk
         7uiEx6YYRcDtG10YayMKvPh57ydf7raXFWUvxTh/wiHXaDE7DuvsAXqT9JWpeuIPxDRk
         GxT5osoUS8vl72YJtyXrR7+eFWUbEcWBr6HTZ0A68dImXIYE7ee+SLf6kuqjWHhhq+QA
         GC4K7F3nYLKl2B7MnC8nW5cPC+1q7s79c7X5Ej5Fp9j3m5Xxbpr9fAlA3PgAiZD5Dnkd
         EdP8zwXkEyGEd6JKoWy8J2V1IbWKlQWnid6FkVb39/b+1lWpyvd4C7roKdIDTlGseVnq
         iP5g==
X-Gm-Message-State: AOJu0Yy/0UgNfAfEarGt8EMZ0iJTDoPvchO9qxZYVDQiBYRbaQrUC/AE
	hfSz9ATObkZXKOU6n2CFN+1w4BGNFVtsufoKGMI=
X-Google-Smtp-Source: AGHT+IGZgHi0TSKPHcwYxAnBYjnyLzgjpyXqQgUKp/ldWNYTgZhEGH16ZF2iIx+BIl7EepnFhQbmqpV7k1011V1Ghrw=
X-Received: by 2002:a05:6122:3683:b0:4b6:bc91:92d with SMTP id
 ec3-20020a056122368300b004b6bc91092dmr2671352vkb.15.1704803315093; Tue, 09
 Jan 2024 04:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231131705.2010-1-yongsuyoo0215@gmail.com>
In-Reply-To: <20231231131705.2010-1-yongsuyoo0215@gmail.com>
From: YongSu Yoo <yongsuyoo0215@gmail.com>
Date: Tue, 9 Jan 2024 21:28:23 +0900
Message-ID: <CANXPkT4CRXzKNR2tjsWV4jkPo5iWFjSPqLO5vCc2WqF-a7884Q@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] media: dvb_ca_en50221: Add a returing EBUSY logic
 into CA_RESET
To: mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yongsu.yoo@lge.com, v4bel@theori.io, 
	0215yys@hanmail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear All

Do you know how to change
from [PATCH] [PATCH] media: dvb_ca_en50221: Add a returing EBUSY logic in..=
.
to     [PATCH] media: dvb_ca_en50221: Add a returing EBUSY logic in... ?

2023=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 10:17,=
 <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Yongsu yoo <yongsuyoo0215@gmail.com>
>
> Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
>
> In source/drivers/media/dvb-core/dvb_ca_en50221.c, if the CA_RESET ioctl
> is called, in a normal case, the state of the thread of the
> dvb_ca_en50221_thread_state_machine will transit like below order.
> DVB_CA_SLOTSTATE_NONE -> DVB_CA_SLOTSTATE_UNINITIALISED ->
> DVB_CA_SLOTSTATE_WAITREADY -> DVB_CA_SLOTSTATE_VALIDATE ->
> DVB_CA_SLOTSTATE_WAITFR -> DVB_CA_SLOTSTATE_LINKINIT ->
> DVB_CA_SLOTSTATE_RUNNING
> But in some problem cases, the state will become DVB_CA_SLOTSTATE_INVALID=
.
> Among the above mentioned states, the DVB_CA_SLOTSTATE_NONE and
> the DVB_CA_SLOTSTATE_INVALID are "already stablized" states,
> whereas other states are "transiting" states.
> The "already stablized" states mean no matter how long time we wait,
> the state will not be changed.
> The "transiting" states mean the states whose final state is not yet
> determined. The state keeps to be changed. Only after some time passes,
> we get to know whether the final state will be DVB_CA_SLOTSTATE_RUNNING
> or DVB_CA_SLOTSTATE_INVALID.
> During the "transiting" states, we do not yet know whether the
> CA_RESET operation, which triggered the "transiting" states, will
> succeed or fail. For this reason, during the "transiting" states, if
> another CA_RESET ioctl is called and if this new CA_RESET ioctl
> operation begins again, it will be meaningless and waste time.
> For preventing this problem from happening, we make CA_RESET ioctl do
> nothing and only return EBUSY if the ioctl is called during the
> "transiting" states.
> ---
>  drivers/media/dvb-core/dvb_ca_en50221.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-=
core/dvb_ca_en50221.c
> index baf64540dc00..2e8aec354b7c 100644
> --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> @@ -1362,13 +1362,19 @@ static int dvb_ca_en50221_io_do_ioctl(struct file=
 *file,
>                         struct dvb_ca_slot *sl =3D &ca->slot_info[slot];
>
>                         mutex_lock(&sl->slot_lock);
> -                       if (sl->slot_state !=3D DVB_CA_SLOTSTATE_NONE) {
> +                       if ((sl->slot_state =3D=3D DVB_CA_SLOTSTATE_RUNNI=
NG) ||
> +                           (sl->slot_state =3D=3D DVB_CA_SLOTSTATE_INVAL=
ID)) {
>                                 dvb_ca_en50221_slot_shutdown(ca, slot);
>                                 if (ca->flags & DVB_CA_EN50221_FLAG_IRQ_C=
AMCHANGE)
>                                         dvb_ca_en50221_camchange_irq(ca->=
pub,
>                                                                      slot=
,
>                                                                      DVB_=
CA_EN50221_CAMCHANGE_INSERTED);
>                         }
> +                       else {
> +                               if (sl->slot_state !=3D DVB_CA_SLOTSTATE_=
NONE) {
> +                                       err =3D -EBUSY;
> +                               }
> +                       }
>                         mutex_unlock(&sl->slot_lock);
>                 }
>                 ca->next_read_slot =3D 0;
> --
> 2.17.1
>

