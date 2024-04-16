Return-Path: <linux-kernel+bounces-146538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05018A66B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0871C22F06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6C84D3D;
	Tue, 16 Apr 2024 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dslWp0Aj"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B60205E10;
	Tue, 16 Apr 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258374; cv=none; b=s2GwejdtDfWQ3zpvjxuKkRXaOQszc1l7cVRMR5hJXvadLQ1RuGYtLlD4ziidOoqyeUdDNYZn0ixWGjxC+NnAHV1gH4l0VVFIE0rA3Kofs+w6zs3yMKWaU/gKRC075GciIz0RFK5DzbnZDXnC/2Q/FHI1B72fI/IPL9wUB3/Pl7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258374; c=relaxed/simple;
	bh=XBbzNo5/5Z3yM0go7bFjuBxtLB4MwbHs7CZA3mqNkg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/iglNbmSv2UmzuE7YxAWj2WvfUo2/XVp/qlfi8khK0lgEYWHVm0mEg9dJ2dUocscZ/k3wBl0dPtIO1utFSL9uKyXhe3OF7yMcbc+ZYNl7dMfZpj3m5XHqTZlKe2a7p3CANR/8aVz0M43lB3eJWzmUrwApiA1nRiSZ4WWIRUusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dslWp0Aj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5224dfa9adso661605266b.0;
        Tue, 16 Apr 2024 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713258368; x=1713863168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3r8kYckvh1mt8mTdBVXvZ+rvR0BKzdEjk+HhP8kNAI=;
        b=dslWp0AjepoguOllB3yNwQc2hFdGTGmEfI4VYiuSVt3//2HSsr3Zces6Q1JelukjaD
         okgAGj7+bTAOzmq2DVcf1vOHN2Qj7lzvwzyZSwFljhGUtXQLJqEgdEkhaSRXP0EkboUw
         yb1QdpkeVIG+BfNR7yACtQH4U0in/eqVHNgSQgT0xrsXlvOY/CaQj+J/+MZ3mecsr8iD
         Js1Co+BppYY1ynfyEB9LrzwAlq5zfPd7JIjZx2DXTS50+xR9OMIQEbBmZDSqsJ+JlxMX
         b3od9/9qAX5q249Qfrr3iaVfHp4prQlgJ3KimiSYq5QVXswT6llb6mHTt9rQhORJ6b0F
         Oi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713258368; x=1713863168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3r8kYckvh1mt8mTdBVXvZ+rvR0BKzdEjk+HhP8kNAI=;
        b=wFwjlw6TmI04QARI3qTwmDFsG6IR/db5nz7d6TjYbWpottGQK74w5PSdqZNrs5J33o
         HB5UdF4hRjmN/vSrwqKdp4smZt01nND0PQqF6hNHjQXfbW7ZyPRNzjPLjsDbzmtMObhr
         tlU7djtiFWkKqbPeTu6QANAqsW1DXhIT4svlExPiytxXN25ROwhx9/FHaiRz6G1Ya1s3
         LX0GU6GVA546cF57N/Z4C0BraILtYUj935w/e60X6IfaP88u4hU4EQ+kThKPw12zpd9J
         SWYa6Bzx9PAS/mgyD4coFSuKNEOQyBd0BbgQfjmAaTarYT7NdG/Bkxlo6m+XMmeOxg0p
         2sQA==
X-Forwarded-Encrypted: i=1; AJvYcCXAdsc4wUAH8VIita7GE+o/hXKAu5eWY8mUpPB207b1N4EpYuLkdkFiin1ydZS2w22uxvZSWXnvFFj0GqgWEein1d21U5DB1URU
X-Gm-Message-State: AOJu0YwjiII/OYs5hBe1fFjQTJgIDuK5DALAqlHs3vRGRQPS3E2A/jWG
	bim39553YRNRRYTAfEUSlD+OUV5q9CidDrCAvBm4D4ltiBtKP2LfVjtaAMFZ2zjS72OIEUf3BvM
	MQZW36FEGMYbhgybanyhdgXCqyiM=
X-Google-Smtp-Source: AGHT+IHC4U5/nbKuWyJ4my1Odf2z79buSdVtbkIZQXpCwU0GLZeBqkmpZ6FJqD8DCqRD5aWQCWLudK+5eoqzTMVwboU=
X-Received: by 2002:a17:907:844:b0:a4e:946a:3b0a with SMTP id
 ww4-20020a170907084400b00a4e946a3b0amr1489717ejb.34.1713258367569; Tue, 16
 Apr 2024 02:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <92fe8e95-bc01-4d7d-9678-8cfc55cc4a7b@rowland.harvard.edu>
 <CAEkJfYORHKO16xT3DCS04JFzkquz6oZ5CdC2USJ5-c0WihAMXg@mail.gmail.com>
 <45e246ab-01e8-40b7-8ede-b47957df0d7b@rowland.harvard.edu>
 <CAEkJfYMjO+vMBGPcaLa51gjeKxFAJBrSa0t_iJUtauQD3DaK8w@mail.gmail.com>
 <69a6f4c9-6470-40d1-99f1-aaf532497d02@rowland.harvard.edu>
 <CAEkJfYNJyyGhR9AAWc0V7o8i6pmS+OB=KSbh6XqVWAAGetS9hA@mail.gmail.com> <5704ac63-5e5b-416c-a2a1-57528e76a02f@rowland.harvard.edu>
In-Reply-To: <5704ac63-5e5b-416c-a2a1-57528e76a02f@rowland.harvard.edu>
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 16 Apr 2024 17:05:55 +0800
Message-ID: <CAEkJfYMSwuikpBJudOaFYrxgf9e=_O4nig6sTPLLAtpdEKQuyQ@mail.gmail.com>
Subject: Re: [Linux kernel bug] general protection fault in disable_store
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Greg KH <gregkh@linuxfoundation.org>, swboyd@chromium.org, ricardo@marliere.net, 
	hkallweit1@gmail.com, heikki.krogerus@linux.intel.com, 
	mathias.nyman@linux.intel.com, royluo@google.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:47=E2=80=AFPM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> Actually, I've got a completely different patch which I think will fix
> the problem you encountered.  Instead of using mutual exclusion to
> avoid the race, it prevents the two routines from being called at the
> same time so the race can't occur in the first place.  It also should
> guarantee the usb_hub_to_struct_hub() doesn't return NULL when
> disable_store() calls it.
>
> Can you try the patch below, instead of (not along with) the first
> patch?  Thanks.
>
> Alan Stern
>
>
>
> Index: usb-devel/drivers/usb/core/hub.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-devel.orig/drivers/usb/core/hub.c
> +++ usb-devel/drivers/usb/core/hub.c
> @@ -1788,16 +1788,15 @@ static void hub_disconnect(struct usb_in
>
>         mutex_lock(&usb_port_peer_mutex);
>
> +       for (port1 =3D hdev->maxchild; port1 > 0; --port1)
> +               usb_hub_remove_port_device(hub, port1);
> +
>         /* Avoid races with recursively_mark_NOTATTACHED() */
>         spin_lock_irq(&device_state_lock);
> -       port1 =3D hdev->maxchild;
>         hdev->maxchild =3D 0;
>         usb_set_intfdata(intf, NULL);
>         spin_unlock_irq(&device_state_lock);
>
> -       for (; port1 > 0; --port1)
> -               usb_hub_remove_port_device(hub, port1);
> -
>         mutex_unlock(&usb_port_peer_mutex);
>
>         if (hub->hdev->speed =3D=3D USB_SPEED_HIGH)
>

I tried this patch and it worked. I agree this patch is better and it
avoids introducing new locks.

Best,
Yue

