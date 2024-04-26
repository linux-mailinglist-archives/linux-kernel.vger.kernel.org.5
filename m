Return-Path: <linux-kernel+bounces-159796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509D8B3434
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4717A1C2273D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9713F433;
	Fri, 26 Apr 2024 09:35:47 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E013DDD5;
	Fri, 26 Apr 2024 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714124147; cv=none; b=jieQGVnfHcuDX15axuZzf2eVEp/sFQMa3yTWQrpngRyXX+KMvaCXb+89MOV24SXNkj0B7iJ/yrhEUKC1AU+41Dd7vP0vU8oqoH8yDeJvyYAwMCTBCWtEFGG8QjNprRSUPN1m+JY3n3GeSavPg+1SUREk1Hw5KwYl60pAPUKOh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714124147; c=relaxed/simple;
	bh=lBnA2OQ+jqFhTDwT4ra2MmJag4tWEJrVaHZ+YlurzVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owFBcTjoArstG92VadEHUBC/hy0jWXM1ZePHqAtSDvslcDLhI7meXXHktzElw8BW549Su+ciyzDGKcQQe/q3BCUnxdbOH2QtllhGQEshydJlzFdF3j9F1o6X/RDN/Bgx75AcyQr6Ph+U3u2gUMs9V4EV7Qvkbfj7g2UniQsKGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-518a56cdc03so2203630e87.1;
        Fri, 26 Apr 2024 02:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714124143; x=1714728943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg6BhgrtGVlqx1sac+sbQ4/qS3Kek+r68BVa3EwPNFc=;
        b=ZG8tA/sRMGVQS3p3+R2lm9EU0mS3NPQY91YZ5SMaYVGVwZe+MUF+EXwDgDqccy/9pC
         eOjyH/OiwcQY6oTib3unY/UQcKYOouFe9JuxmiQzmCO3B3DWH6rGC2Jc+NktQ66aP30y
         +5wET/ttlQh+lL2G48YgRHM2Ox8cesmuBgtb27UUcqi4tmcfleeTuk1a3Bean0sw0D9d
         yAuLPyN4IuYC1hMtI2A9xayRCQjiu/s29gM4NNqc9nhF9q9SNhOYkLNEWSq4sdF+sytS
         bkXCf1TUAa8dxWxWfhSdihHCwDSNl4OxwgpxP1/F9tk9mp3da8nLLJoOFFEo5hJuYqIQ
         RhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpqo+gIpB8/LteI+iKZe32HGn7pHXaYP2I+ZNTds68JngXr9AigVuQMcS3Z7laXAFf/G5DWi36tIxmgc50se6oMzEyZgbXL99v5owz4i228cwuFsAkMSLeOIz3h3RgTXx5szNrj0w+kebTngmz
X-Gm-Message-State: AOJu0YxZB9rFMI6x+tAp/tJcSQZsgnBrI+qSK7BOHjZhuLV8PavLtb4H
	PaaGNudTZgiCOSZ8T2EFdZOCbHHO9RmYjW618uL1tBjWXj+Wx1BBCisgGgnzC1o=
X-Google-Smtp-Source: AGHT+IFWRq72IP69xrZfVjOtv6D5H4GvTGI4/jiXv60/G99F6kW6EsiIKpVEb0ZBo60DGzzvaomb6Q==
X-Received: by 2002:ac2:5dca:0:b0:516:d692:5e0b with SMTP id x10-20020ac25dca000000b00516d6925e0bmr1079878lfq.54.1714124143066;
        Fri, 26 Apr 2024 02:35:43 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e2-20020a056512090200b0051b0f4e1b0dsm1861421lft.276.2024.04.26.02.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:35:42 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5196c755e82so2457840e87.0;
        Fri, 26 Apr 2024 02:35:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0t8pcUGeqxdpfMvVudy6totLNnRZGZ/ZwKQLJw9nHZRChy4hv/dh5S/QgQW6sS+dIVPcZVgb4WAipJOEIfzFVJqiiyDp5ziDWoYpd4dNRozUB3m0t/k2avIcKOKxGwqMO7RCSstFJ/CG0kT51
X-Received: by 2002:ac2:58ca:0:b0:518:e69b:25a2 with SMTP id
 u10-20020ac258ca000000b00518e69b25a2mr1216657lfo.45.1714124142488; Fri, 26
 Apr 2024 02:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426072006.358802-1-iam@sung-woo.kim> <cff764c2-a3d1-4a12-9260-54122e7a1fef@moroto.mountain>
In-Reply-To: <cff764c2-a3d1-4a12-9260-54122e7a1fef@moroto.mountain>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 26 Apr 2024 05:35:01 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+eCq1p_gTbxAJBKouAw-oQ=j5xwyjk5o-91pf_hGdrAg@mail.gmail.com>
Message-ID: <CAJNyHp+eCq1p_gTbxAJBKouAw-oQ=j5xwyjk5o-91pf_hGdrAg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_send_cmd
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:16=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> On Fri, Apr 26, 2024 at 03:20:05AM -0400, Sungwoo Kim wrote:
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 84fc70862..a8f414ab8 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -3953,6 +3953,9 @@ static struct l2cap_chan *l2cap_connect(struct l2=
cap_conn *conn,
> >       if (!chan)
> >               goto response;
> >
> > +     l2cap_chan_hold(chan);
> > +     l2cap_chan_lock(chan);
> > +
> >       /* For certain devices (ex: HID mouse), support for authenticatio=
n,
> >        * pairing and bonding is optional. For such devices, inorder to =
avoid
> >        * the ACL alive for too long after L2CAP disconnection, reset th=
e ACL
> > @@ -4041,6 +4044,11 @@ static struct l2cap_chan *l2cap_connect(struct l=
2cap_conn *conn,
> >               chan->num_conf_req++;
> >       }
> >
> > +     if (chan) {
> > +             l2cap_chan_unlock(chan);
> > +             l2cap_chan_put(chan);
> > +     }
> > +
> >       return chan;
>         ^^^^^^^^^^^^
> This doesn't fix the bug because we're returning chan.
>
> As soon as you call l2cap_chan_put() then chan will be freed by in the
> other thread which is doing l2cap_conn_del() resulting in a use after
> free in the caller.

Thank you for pointing this out.
No caller uses the return value of l2cap_connect() if the kernel
versions >=3D v6.9.
So, l2cap_connect() can return void.

One caller uses the return value of l2cap_connect() in v4.19 <=3D the
kernel versions <=3D v6.8.
In this case, the caller should unlock and put a channel.

Question: Can different patches be applied for different versions like
the above?

Thanks,
Sungwoo Kim.

