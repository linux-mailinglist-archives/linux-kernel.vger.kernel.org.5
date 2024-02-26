Return-Path: <linux-kernel+bounces-81167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F986728E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7212FB2B7B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E557300;
	Mon, 26 Feb 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="LD9y0C60"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2456478
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943442; cv=none; b=qyiLkCd0ScR2wDcVpqJhSTDkDlkTf2Aowua8PDAishkJYdDvwoLyahOAKnrA8NBsQ/YskimFL75QN2t1hjXG6SQF2JD9AwuOxjTFq6RHtpium8ETmyvof9gNJAmmPhsZPFbf6ZYeC+sS/E1z6A2EENgUry/Mzs2pfFa+5Rlh+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943442; c=relaxed/simple;
	bh=3AEg61c9t2RdSbrA3SOYlabwim+w14UVA/dDDZpqvZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSt3MWDFZOGfVKyz0xalLEKs6aP59yg+zy3ey0qHSHi1KvqoZic14xQ/4dRhybtlWsfFQKejD03aTuTgHKEiZGN0Dic0UGOYs+mntn1+BUTJrcq9YqYqyertFptHiP9YWEosKHZb+p2+gseYF9kZPF6Ad5sMmImiyKFhOOpHBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=LD9y0C60; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3e72ec566aso356430766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708943438; x=1709548238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz6b+eCtgnaUFENSuU3KdIVlMwnoCTOF+cGcVtN0DkI=;
        b=LD9y0C60HOh1RKDhvMKmtT2nQe+qq2hbqV2q0nc9XCGhJ2wEJ5KveN6fMOpovGmq5C
         i5dPH6raI2NaBnEG5ymEiHTsrVbSf7bQ0w5lW/VMxst3jZy6alVWpyyCvnpsXHeSJukD
         hV6TjnjL/fm3eRWGZ8dR+lkgiqzKZOUBDjBhxtQiEXGrV8MOcfgB/ho5m/jsYSa+8cI5
         nhycQDBOFyooPAbnZhyh9XFncW367sg5bBjf1ByZRWloVxIsa6V8+iGs0tAnMJ+hs4IY
         0HJ0uAxdsG2TrwXvoDeuvAKIITjPlKU5AMALDEttgL9162t+u7ptmm5Q9ewpGa7Ebpgv
         TrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943438; x=1709548238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz6b+eCtgnaUFENSuU3KdIVlMwnoCTOF+cGcVtN0DkI=;
        b=l27dsP5clAKfYp7vErOL2i141dqaOQzyGfKAc6C755n4emGmoq0vt87wpExshoZd4e
         tgI7IjeLmpkaTnZ9dkWO88B9B1/oVmofqdqI7w9y9gP2Nv6PRiyu3V7bwkc8atXkSf6o
         8QSY3fQY2Nb1Cj4bPtyi59ykSYUZB3kArvyZSOb6y/3l8ddEX7K91VtRywml/nCM9r8S
         soW+umNhx1243OWxUaFSTzn2hGkY3ahucljVfS+aRDsomrpyO0mmtoINTlBnz3BNwn+3
         ISpxMDRBdbVeRN7RJA5ihsg3upie1pIz5UcUxI7jbUAlTbd0hQ3ojiVk7FQwuf9MXVXj
         ORdw==
X-Forwarded-Encrypted: i=1; AJvYcCVpWt/dC/He0m5IjCI1cMuEKJMiB9N8I0xC8vhKZOKqF6MP1dpXJdypLgTexJWEKQGcl9HYuWQtdHPJt+OsncXH5l+pfSZgt8VW5aFZ
X-Gm-Message-State: AOJu0YytiymE1cmWhlO66S8ss0AykHEpY5Qu7L/8vcgleYE5HscpK45r
	LkWP7zupyHTzro3h671ILJuIYmh97Mu+oeZoB4pfGRQQlw5O6EO+MWmtK/Zg04uzbJFuLZpm77F
	gwjS5q2WmpD3Gt0DoSwLK4TZ5vgKpB0nI86DlRA==
X-Google-Smtp-Source: AGHT+IFRPov8/cpih2mq251F4b8kRlFyC5NNX1J7o+YMmyopd5NzNTlRC1I0AnsNzV9tfVe1KWjRjh446NXfYck2paE=
X-Received: by 2002:a17:906:68d2:b0:a3e:5b7f:6d31 with SMTP id
 y18-20020a17090668d200b00a3e5b7f6d31mr3616604ejr.5.1708943437867; Mon, 26 Feb
 2024 02:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115194840.1183077-1-andrew@daynix.com> <20240115172837-mutt-send-email-mst@kernel.org>
 <20240222150212-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240222150212-mutt-send-email-mst@kernel.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 26 Feb 2024 12:30:27 +0200
Message-ID: <CABcq3pEtW4j60n3jJgkSUDy=VbcfzAbS_4eYMHpEPR2bYU9aww@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,
Ok, let me prepare a new patch v2, where I'll write a
description/analysis of the issue in the commit message.

On Thu, Feb 22, 2024 at 10:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jan 15, 2024 at 05:32:25PM -0500, Michael S. Tsirkin wrote:
> > On Mon, Jan 15, 2024 at 09:48:40PM +0200, Andrew Melnychenko wrote:
> > > When the Qemu launched with vhost but without tap vnet_hdr,
> > > vhost tries to copy vnet_hdr from socket iter with size 0
> > > to the page that may contain some trash.
> > > That trash can be interpreted as unpredictable values for
> > > vnet_hdr.
> > > That leads to dropping some packets and in some cases to
> > > stalling vhost routine when the vhost_net tries to process
> > > packets and fails in a loop.
> > >
> > > Qemu options:
> > >   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
> > >
> > > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > > ---
> > >  drivers/vhost/net.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index f2ed7167c848..57411ac2d08b 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_v=
irtqueue *nvq,
> > >     hdr =3D buf;
> > >     gso =3D &hdr->gso;
> > >
> > > +   if (!sock_hlen)
> > > +           memset(buf, 0, pad);
> > > +
> > >     if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> > >         vhost16_to_cpu(vq, gso->csum_start) +
> > >         vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> >
> >
> > Hmm need to analyse it to make sure there are no cases where we leak
> > some data to guest here in case where sock_hlen is set ...
>
>
> Could you post this analysis pls?
>
> > > --
> > > 2.43.0
>

