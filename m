Return-Path: <linux-kernel+bounces-26508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C182E247
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A471F22F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92311B5B1;
	Mon, 15 Jan 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="fMVhFjid"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8EF1B296
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e67e37661so12612022e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1705355085; x=1705959885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dKtPTrWnoc6fMe3lLbkoCZ1Tu8sXcss1oKD1gcrdh4=;
        b=fMVhFjid2D7Lz92OgvhmIi2wShwKnHmIrJW5CAZN6t5jjvMH59SuPnLn3w1S53aHZn
         P8f7Ia0E3z45wjy92YZKXzvQguwLpekz3AEGB9Uix+9H3NE/qX+3SX9kP4xAlyjOxjkN
         cZTZ2pG6XTNbSO0uZBTS3AoHkJJ15GX8K0juZoS8U9ucjKoWMid169yePGMyv1dFrUxI
         8dt5tQkuyw7o7mPMb+lfDZnCSdvPwgC18HDbC9Drk9Uos+wtyxs95lY+ApchaS7+NrBy
         8ALgb73DF8hdPe71E75jGXKVt3CTFs197TgasDV835++bJvir644jAtg+mY+NLGa9E3u
         Yt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355085; x=1705959885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dKtPTrWnoc6fMe3lLbkoCZ1Tu8sXcss1oKD1gcrdh4=;
        b=g7w+GvkP5UXvvzTtVgW0WoC0zKGk02JAjCQ2bqzOTXQUFpWvLjHC0prvFO1G/mZlrk
         y/PXx0fZFlRUefxsxYenUmpTcLOHBjTm3zHAJlnwyvSh58/cp4myGjloNVTp7LJGrybz
         6incuFHzZjsMjgjrdLACK13NQRQF3w5EG1ZEffcWAOHkMKEhXEAm2fRoWoN0dgZKzZbl
         Nm+be73ZO+a7gc+9bMybI0BP776TotVMVGB7MyWIHdpQMhl275DWqemoRZYuK/N/5+8E
         snup/Njdui92RYiJjgxXazgkoWWpRdkqfFQX8stdO4A5WCWOGfLHmox0t5jKvLVs5KaP
         P7gg==
X-Gm-Message-State: AOJu0Yz160SYRlS2xUsCN9PfNZMfr3AQfGmSvHDCzuYczU8Jvgb8pMaW
	iaSInwTq5BHj0wOf/OhIH6mtwEjBdf+PF7BGzO1yAVaxsdYoetLC4ns6/+8xKb0=
X-Google-Smtp-Source: AGHT+IHKiK8prqPQNKjM0sjGqQfOTCEmNaayIspi6IUCYFWmkjH19fSrGZkx3kzlTUFqZaeipvcci4afBS1SYzofu+c=
X-Received: by 2002:a05:6512:1284:b0:50e:7b2c:6818 with SMTP id
 u4-20020a056512128400b0050e7b2c6818mr3603951lfs.26.1705355084857; Mon, 15 Jan
 2024 13:44:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115194840.1183077-1-andrew@daynix.com>
In-Reply-To: <20240115194840.1183077-1-andrew@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 15 Jan 2024 23:44:32 +0200
Message-ID: <CAOEp5Ofk5NrKujDApLXT6RL=hD6b4NFxv9GZ-NSvkbJvRYtG8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: linux-kernel@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, yan@daynix.com, 
	Andrew Melnychenko <andrew@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

See also https://issues.redhat.com/browse/RHEL-1303


On Mon, Jan 15, 2024 at 9:48=E2=80=AFPM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> When the Qemu launched with vhost but without tap vnet_hdr,
> vhost tries to copy vnet_hdr from socket iter with size 0
> to the page that may contain some trash.
> That trash can be interpreted as unpredictable values for
> vnet_hdr.
> That leads to dropping some packets and in some cases to
> stalling vhost routine when the vhost_net tries to process
> packets and fails in a loop.
>
> Qemu options:
>   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/vhost/net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..57411ac2d08b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtq=
ueue *nvq,
>         hdr =3D buf;
>         gso =3D &hdr->gso;
>
> +       if (!sock_hlen)
> +               memset(buf, 0, pad);
> +
>         if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>             vhost16_to_cpu(vq, gso->csum_start) +
>             vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> --
> 2.43.0
>

