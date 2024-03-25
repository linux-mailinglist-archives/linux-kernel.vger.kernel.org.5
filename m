Return-Path: <linux-kernel+bounces-117888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899E88B0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE0F1C62649
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573634C63A;
	Mon, 25 Mar 2024 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRiLhEEZ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338743AA9;
	Mon, 25 Mar 2024 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397239; cv=none; b=nE0EppHCS8kHDj7Lxn5A1ps1rj7ZZFV7X3qaaHc+XPm7DdvMMDOTaq9TC9UunFu1TRSmHK7BE/jOMNOduMx78fJ0dpcoSbqEnOC6DA1GDMCSh5VL8vf819/CXnj3jjX7wayV00fqUsGiGBVYJLnvt0esPyA+F6JGCqLezCj0Hlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397239; c=relaxed/simple;
	bh=du4SRixuDJpsGc6Pl95gu+UfcgZcN4SGXN5Fz8Z6dDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk/W9HJXe5L89Se+EwyMlCDwTETyom0ISam9fygAvUjdIK5QZWkQKu4KAOi1P7TCMGoy54+JvaAvHN7Txrv0VNGjk93nz8Pq3zPZeFMSAzLH6JfSnuJB88eN6SMyhpp8OCj7uqBT1tLbRQkBI68J5BuHU4xOJmGXUIDhsPVTRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRiLhEEZ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d228a132acso65847131fa.0;
        Mon, 25 Mar 2024 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711397236; x=1712002036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du4SRixuDJpsGc6Pl95gu+UfcgZcN4SGXN5Fz8Z6dDU=;
        b=JRiLhEEZXzdzPRDUkZTALU+IpQCnSpytr5MTGKGqvROwBRLh8o3syWeHtzgp5c7R/1
         0+GGcFblItBEHsnrk0idTwfuXWO1uTpUy7iqvPjT3NjaYWWT68RhPTzJRI/Z00Imet4x
         wZ4GU4TBbG0De32NurtTAURmNW7oqDA6UTxXYW9D9kA3zgJKkCrxQigRG5ONJQ5e6gsl
         DM/XvFghuF6NSPMl8JxVd5m/0cGx0d7Prjo2VsHB+smWobgeRYZ9Hggpz1J6a6dAfK6K
         THYgqeKDN7Ef1edLZYJyQ0qD8TdFm7QOqvEog0gxHetIYsmTlUw0I+ZV//oxNJ9+yeQB
         whHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397236; x=1712002036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du4SRixuDJpsGc6Pl95gu+UfcgZcN4SGXN5Fz8Z6dDU=;
        b=GPaXSfrzdDwtHXE0beEilGZVR5rwfD6sYWxmlvcpvqRE9pnPzaA9C5E72HElHf0p2S
         8NnCO0vG84QljB7ShrVwCz+HBA856Sag84Pzzr9ejdAsAz119XlXVtxutZUcFte5gRYx
         x/nhJDunb/3TIm3o1Qig54V5vp5bKRYI32mExNIwKY9IJQP7PNfXqutzI2rIlIEpntdI
         u4beBMjyLTzcQl3a1s6LpDxOJ2Jy76pxLpwCHO+c6MQlrQ0b6xFHmrQPkBeUmuE8TpMu
         q/FC9/ZZsu+Qe6L7kkzldy7ZENtPIqmQ+aVJoS0SoyEe5qqgJ/Ys16c/3F3sT4FJ12Ps
         L8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVHmdGCNgjD/qUrYkn/etVB5uA3DTKzWYzz73496X3oyhCCCtwH+AwpbppHSJIaCHOc5gTl41tlR9SAiAE+L7I5lwEAYsX9nUOHd5uoBf1BETUxVyETsGEu0z8TLljsaB5w2FZhtdCivvfg2rTxBauxmKXBagsCHuCcAhfoRUNX+GOpNx1
X-Gm-Message-State: AOJu0YwypZhC8DEflFw0creFR9zZNkrPo1lItNad5lGuOF38qcotxiEI
	U5dmY5KUgqnUSiZIfpTkA5H3nQxhEGkNiRlQv0karnAUE93tbBM9O1T+c8mDZk4hUzNppLg7UeK
	upVwuXIOYGb9KmOnBssjQpo8Ryv8=
X-Google-Smtp-Source: AGHT+IHlayvaP0yY4B5G/tL55lxT++Fsn1ZkhDpnNssxYt+RRaI9Pmd8pmh3B5/obFUWOWyZNGwQqHHqCji5jwiL+Hs=
X-Received: by 2002:a2e:8552:0:b0:2d6:b8d2:3712 with SMTP id
 u18-20020a2e8552000000b002d6b8d23712mr5740462ljj.26.1711397235773; Mon, 25
 Mar 2024 13:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <CABBYNZJV1htg46Gyu=7_iUWdukM+rHLitsLjxmWWYFGXty3tVw@mail.gmail.com>
 <ZfMStHjwtCT1SW3z@hovoldconsulting.com> <964131ff-293d-47d1-8119-a389fa21f385@leemhuis.info>
 <CABBYNZJ0ukd_8=SFzy8CEwgP7hV5unodca0NZ2zDZh+jPJsEFQ@mail.gmail.com>
 <ZgGzWWV4Lh2Nal--@hovoldconsulting.com> <CABBYNZJaXUhu1A+NyVT-TAJw49zcV6TMdGeVy2F+AVKWBOVC-g@mail.gmail.com>
 <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com>
In-Reply-To: <ZgHVFjAZ1uqEiUa2@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 25 Mar 2024 16:07:03 -0400
Message-ID: <CABBYNZJUVhNKVD=s+=eYJ1q+j1W8rVSRqM4bKPbxT=TKrnZdoQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: Johan Hovold <johan@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Mon, Mar 25, 2024 at 3:48=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Mar 25, 2024 at 03:39:03PM -0400, Luiz Augusto von Dentz wrote:
> > On Mon, Mar 25, 2024 at 1:24=E2=80=AFPM Johan Hovold <johan@kernel.org>=
 wrote:
> > > On Mon, Mar 25, 2024 at 01:10:13PM -0400, Luiz Augusto von Dentz wrot=
e:
>
> > > > I guess the following is the latest version:
> > > >
> > > > https://patchwork.kernel.org/project/bluetooth/list/?series=3D83666=
4
> > > >
> > > > Or are you working on a v5?
> > >
> > > This patch (revert) fixes a separate issue than the series you link t=
o
> > > above, but it is also a prerequisite for that series.
> > >
> > > v4 is indeed the latest version, and it has been acked by Rob and Bjo=
rn
> > > so you can take it all through the Bluetooth tree. Just remember to
> > > apply this patch (the revert) first.
> >
> > Doesn't seem to apply cleanly:
> >
> > Applying: Bluetooth: qca: fix device-address endianness
> > error: patch failed: drivers/bluetooth/hci_qca.c:1904
> > error: drivers/bluetooth/hci_qca.c: patch does not apply
> > Patch failed at 0004 Bluetooth: qca: fix device-address endianness
>
> Did you apply this patch (the revert) before trying to apply the series?

Probably needs rebasing:

Applying: Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in=
 DT"
error: drivers/bluetooth/hci_qca.c: does not match index
Patch failed at 0001 Revert "Bluetooth: hci_qca: Set BDA quirk bit if
fwnode exists in DT"

> Johan



--=20
Luiz Augusto von Dentz

