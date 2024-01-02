Return-Path: <linux-kernel+bounces-14689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 198848220B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0BF1C2273E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837E6156D2;
	Tue,  2 Jan 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3gtnIdK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AF156CE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcdf587bd6so10630416276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704218339; x=1704823139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irhMPPVc4c6WbFKm+KVUoPGTtZUY5Per8OJsR/a/g3s=;
        b=c3gtnIdKuJsQaPD92A5966gkIOY+Kt2Kx2gw1nbdTXCLzx+ubd5GCe2Zfbocnrogry
         JszHomX28CLyS26Ep6HuaX2QD4cGnYVqEpgUiPm8uXek6EG+Zl1D/l7m+GrfjdQH5ZKT
         np9mS7Qi1oY8adsSXXpLPyYKRDJLO5hb8PqmdzEAURTJeVBA10rliTD2XcowUE0BnkHg
         VgGPhJ+Vs24R1y/of4xFqONZo69mM+plRpQVIO0EyXFME9ApHEs/Er0gI/0E9wQXWPWU
         m9xh34dBtBA6M7gdBfZUYGiK4CacsRsow+65tCpD9/Csq7hqg1NL9HEPXzT88w3e6nG7
         Bsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218339; x=1704823139;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=irhMPPVc4c6WbFKm+KVUoPGTtZUY5Per8OJsR/a/g3s=;
        b=VWrFTojotisE33YBAhNPMo3gyQxgUjcQylSJ6KH9SKFKl9aw5Ke/86pI+qrON2kTD3
         bfKWC959lWMvfa7u+t8w4V9Z2vt1yoL/BXEoWsIqrRFAKMD5YOPRnQ3vdYkbiRvvBxYO
         zQ6D4Ghmk2M7TnV8fmUErv2vBVn/KA6PwtLzFsfAlStHGiETqqDiUXMm79cdf/JZggNe
         Lwq62Z6M6F9LW7MqRgmp83UEQFeIw2BtizIUvt/gZUm+jRAf61jkoPefzPLu1y63kXKF
         YDgqob65b9jmWkRztg0xBpDcGjfA65aMyzxfpTlIBUWZ1+8J4j9chei7VEB7joV56JSy
         2ksw==
X-Gm-Message-State: AOJu0YzeHzxj1FJI/e2wEpnZhPKBM8LuQzgdW2uunB4yVDgYWKPWMX7B
	7oLNxvl7W7SnzVuR3JPf9aBrgWAD57r1NVRb3g==
X-Google-Smtp-Source: AGHT+IG+jfod5ghwH37i2aVvqbEbBTdML1N9js/U0OCpYRo6mr7kbqrYeD9tpdeDj+rV+ijKmTkmX0sdqT4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:5f47:0:b0:db5:3676:74dd with SMTP id
 h7-20020a255f47000000b00db5367674ddmr7084424ybm.3.1704218338937; Tue, 02 Jan
 2024 09:58:58 -0800 (PST)
Date: Tue, 2 Jan 2024 09:58:57 -0800
In-Reply-To: <AS1PR05MB939337F702FDD79AFDF18F56B69EA@AS1PR05MB9393.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <DB3PR0502MB999347F512ECFDBE3BFA9941B697A@DB3PR0502MB9993.eurprd05.prod.outlook.com>
 <ZYMator0DDfq_moN@google.com> <AS1PR05MB939337F702FDD79AFDF18F56B69EA@AS1PR05MB9393.eurprd05.prod.outlook.com>
Message-ID: <ZZRO4Y41UTNm88eg@google.com>
Subject: Re: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
From: Sean Christopherson <seanjc@google.com>
To: "Ben Mesman | Spark Narrowcasting" <ben@sparknarrowcasting.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Fred Ai <fred.ai@bayhubtech.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023, Ben Mesman | Spark Narrowcasting wrote:
> > Please don't send private mails.=C2=A0 Kudos for using get_maintainer.p=
l, but a demerit
> > for not Cc'ing the mailing lists :-)
> >=20
> > https://people.kernel.org/tglx/notes-about-netiquette
>=20
> Definitely saving that in my URLs-cache. Might need it again in a few yea=
rs :-)
> (last time I needed it was about 10 years ago)
>=20
> > > I recently started upgrading some of my remote managed thin-clients f=
rom a
> > > 5.15.x kernel to a 6.1.x kernel. When rebooting with the new(er) kern=
el, the
> > > HP t640 clients failed. The problem is that after the warm reboot, th=
e BIOS
> > > is unable to locate the internal storage (so it can't boot a valid OS=
).
> > >
> > > With some digging around I found that adding "reboot=3Dp" will solve =
the
> > > problem, but because the systems are remote managed, I am unable to a=
dd this
> > > boot-parameter in any straightforward way.
> [snip]
> > I'm not familiar with this code (I'm not actually a maintainer/reviewer=
 for this
> > code, by default get_maintainer.pl Cc's people that have recently modif=
ied the
> > file in question), but this looks like a hack to workaround a bug elsew=
here.
> >=20
> > All of these quirks are obviously workarounds for some kind of bug, but=
 AFAICT
> > the quirks are to workaround hardware or firmware bugs, not kernel bugs=
.=C2=A0 Since
> > 5.15.x kernels worked, odds are good a bug was introduced between 5.15 =
and 6.1,
> > i.e. that this is fudging around a kernel bug that can and should be fi=
xed.
> >=20
> > Are you able to bisect the kernel between 6.1 and 5.15 to try and pinpo=
int an
> > exact commit that introduced the problem?
>=20
> That took a few days, but resulted in the following:
>=20
> 4be33cf187036744b4ed84824e7157cfc09c6f4c is the first bad commit
> commit 4be33cf187036744b4ed84824e7157cfc09c6f4c
> Author: Fred Ai <fred.ai@bayhubtech.com>
> Date:   Mon Dec 20 20:09:40 2021 -0800
>=20
>     mmc: sdhci-pci-o2micro: Improve card input timing at SDR104/HS200 mod=
e
>    =20
>     Card input timing is margin, need to adjust the hold timing of card i=
nput.
>    =20
>     Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>
>     Link: https://lore.kernel.org/r/20211221040940.484-1-fred.ai@bayhubte=
ch.com
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>=20
>  drivers/mmc/host/sdhci-pci-o2micro.c | 57 ++++++++++++++++++++++++++++++=
------
>  1 file changed, 48 insertions(+), 9 deletions(-)
>=20
> I'm not sure how this code impacts this device, but it does contain a "HS=
200 MMC card":
> $ dmesg | grep mmc
> [    1.044708] mmc0: emmc 1.8v flag is set, force 1.8v signaling voltage
> [    1.044937] mmc0: SDHCI controller on PCI [0000:01:00.0] using ADMA
> [    2.120632] mmc0: new HS200 MMC card at address 0001
> [    2.122912] mmcblk0: mmc0:0001 hA8aP> 14.7 GiB=20
> [    2.124810]  mmcblk0: p1 p2 p3
>=20
> I can provide more info on the hardware, which is also available in https=
://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1056056

Adding the relevant people from that commit, this is waaaaay outside my are=
a of
expertise.

