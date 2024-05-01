Return-Path: <linux-kernel+bounces-165791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C048B91A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BD2282C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90213D892;
	Wed,  1 May 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgGWzdiU"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2CE1E481;
	Wed,  1 May 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714603003; cv=none; b=qk/UNzOaxgTJ/w2Cv+gSA6irFtFgUQxJjImBpQ/MxVGhTfLuSFIaSxFCBcnSuSAXZeEY1t5lO0lCY5CbDjCc7L+YDVjEHsroWSh4OoGnv6alRnbv0K021UN4ui2XzuuxEusDw81FyibmivENzwDaQJBq6swLXZsFNJV1acc61D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714603003; c=relaxed/simple;
	bh=YV/YYgGA9K7WCW33ZoIL8lsNGMgwRz4GdkdRG3dcyvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7LqjVqXj4VrLJa3Cn6hqo0uE1k96M+ooO4ksVBmBbg6Ytz8Cys292Z0m7IamdagMSDuS+t5AV+qpUZPBXioc+k9iL9sc/o1ChUyxzuNkzgJGuotv5cqZSwcrv4WtR8kR58JvmdF1F2DqR3I5WrvCOb4j0xdrRfNUYzGckoirZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgGWzdiU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so95151921fa.1;
        Wed, 01 May 2024 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714603000; x=1715207800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuaLRdO6Js2gxidW/S+ZrLyYPpQmg/450rRpegKnffI=;
        b=WgGWzdiUgmd9tsFVfTbWFZISx3VgNUj6+ED0vXDXdnTVCSFFTexWITdCz9tzQTRR6Q
         4hgXmKr6QOo0wl9BQhOvJNKJlCpy+G7TYzhMgwpN7o5RgThpz04PQ+m7yPP6X4Wr8P1k
         lHcTpEY6g+7RbXxCTV+1hxtyWR3I4DJ1/hhAav9vN8DuS+x513l8B8lRNUmVMY86T2+0
         x//hdvKjc+n9+J05IqRRS471kdPhGyCrhuOjpUSVPOpkaJTXslt9P8jLZqw4hOu7dPwx
         qlDb6WZdXPp2SQJ8VMFsGOgMys/kSRIS/IY9TKYCGT6Ikv9bvA/3VZrQ8ybSCalmYT9M
         sDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714603000; x=1715207800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuaLRdO6Js2gxidW/S+ZrLyYPpQmg/450rRpegKnffI=;
        b=ERHNGpAs4i+ZygwFjMPHu12z8BVFb6nkir85EPYrLTHttWOwC3qnrVl/cFH4LpkXKf
         SYeuwpFkMpFzitKNFQQQEuyHcQ/eYCIfg691Zcp89C33bVsDcd5Lqa6PUXIwzWTBxycU
         ZJbwqs/i/ydH2udcQMKiFAgd8rd3e+wSvNRPwWb9yT3xoXstopjx5KqTIPIVwpE9syrs
         44Ig8GzJDBYcrCuSzumreAnz0G4tGvDW/J6+EE8v9hs1Y2IBx2SN89mux2G/GqdAwQ0/
         sK3i7UeWqcuyeRZF+lW1kyOUYGU4kSg/Ry6vN6+N9AQ/ZEHxc1GqU1FfWLQ3xK1jgQhv
         tylA==
X-Forwarded-Encrypted: i=1; AJvYcCVk8vw+R/qrKGXmqTmui6ZC5JJaQjjedPEhik8eQv9B9rj+ktQh7Lr/w++7SioQkVYIuATm7iLU774ZwMSn0zt2yDFoMF30lLVp0T74RnBGuL4fzaodyRl7+4zXte9yjlTohvvKlFa/TzDIC76L
X-Gm-Message-State: AOJu0YxRNYAkdMWRYhOG00A2D/UNnXKQQisPwntzVR7lp3/vEm3/VnEa
	jdtWaYQPKZmyLdMXuX+a2plqKPU0aI3YeYaM4qnRKANrFrx5gVVNt4p8/h+nzoMOtSyi3QD9zw7
	UaeEbUBsuLqB6PyU1f3kGpwrGljE=
X-Google-Smtp-Source: AGHT+IFI6cU2TyISxjTsCefjdE2CQgkkMJ3oJHSpconaHzgOnd8/y0Dk7qw2kqHP9H/1RtQDUIoawNept0jscyUmlzg=
X-Received: by 2002:a05:651c:212a:b0:2e1:ce2b:a55f with SMTP id
 a42-20020a05651c212a00b002e1ce2ba55fmr229192ljq.53.1714602999525; Wed, 01 May
 2024 15:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428054307.1178347-1-iam@sung-woo.kim> <CABBYNZKDouOrxG1XcSq2me0WW3A3yAbfdtonw2XJ54VZ8+Nbfg@mail.gmail.com>
 <CAJNyHpKzhFBJ3N0eF1x0icd7O1VkWbTA9k0Gkm8aCMonsagYwg@mail.gmail.com>
In-Reply-To: <CAJNyHpKzhFBJ3N0eF1x0icd7O1VkWbTA9k0Gkm8aCMonsagYwg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 1 May 2024 18:36:26 -0400
Message-ID: <CABBYNZ+Mr1c7UKa4Vey7Wmh-+WQaFU0P8AifBf7HDEb7G8PTJQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sungwoo,

On Wed, May 1, 2024 at 6:23=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
>
> Dear Luiz,
>
> On Mon, Apr 29, 2024 at 11:15=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Sungwoo,
> >
> > On Sun, Apr 28, 2024 at 1:43=E2=80=AFAM Sungwoo Kim <iam@sung-woo.kim> =
wrote:
> > >
> > > Hello, could you review this bug and its patch?
> > >
> > > l2cap_le_flowctl_init() can cause both div-by-zero and an integer ove=
rflow.
> > >
> > > l2cap_le_flowctl_init()
> > >   chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SI=
ZE);
> > >   chan->rx_credits =3D (chan->imtu / chan->mps) + 1;  <- div-by-zero
> > >
> > > Here, mtu could be less than or equal to L2CAP_HDR_SIZE (4). If mtu i=
s 4, it
> > > causes div-by-zero. If mtu is less than 4, it causes an integer overf=
low.
> >
> > That is because it is not valid to have hdev->le_mtu < 0x001b (the
> > range is 0x001b to 0xffff), so we should really look into checking
> > that conn->mtu is actually valid.
> >
> > > How mtu could have such low value:
> > >
> > > hci_cc_le_read_buffer_size()
> > >   hdev->le_mtu =3D __le16_to_cpu(rp->le_mtu);
> > >
> > > l2cap_conn_add()
> > >   conn->mtu =3D hcon->hdev->le_mtu;
> >
> > Yeah this assignment is incorrect and in fact we don't do that if
> > le_mtu is zero so we probably should do some checks e.g. le_mtu >
> > 0x001a, or perhaps we need to move the MTU directly to hci_conn so it
> > can check there are enough buffers to serve the link so we stop the
> > connection procedure earlier.
>
> Let's say we moved MTU directly to hci_conn and already checked enough
> buffers at the creation of hcon.
> Then, what should happen if hdev->le_mtu is updated? (by a new
> le_read_buffer_size cmd)
> Should hcon->mtu be synced with hdev->le_mtu? Or hcon->mtu can keep
> its old value?

What now, why would we read it again? These commands are only suppose
to be send during init phase and if you do this sort of thing as an
event without a command then it is also against the spec and we shall
probably just ignore it if there is no command pending.

> Best,
> Sungwoo.



--=20
Luiz Augusto von Dentz

