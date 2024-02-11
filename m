Return-Path: <linux-kernel+bounces-60848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B8850A22
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C6D1C20B8B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7465BAE8;
	Sun, 11 Feb 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0nFFH5C"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967FB2AE74;
	Sun, 11 Feb 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666621; cv=none; b=Id/lU9PlIh/ETXXZ9mSsFXoTiKlzN9PjbX3JHfzTzVRAUP2tAxJRb1du1enjEZrrzMCQ7DyEwC5B+Fosu/D9ay6ciC34+2tYVOgmk0NzshsPBXhNHiMGvllp1fkq7tWsWJcLS2w3OekOD8ap1ldT2ZTx2IeO46cAnCN+ZboSAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666621; c=relaxed/simple;
	bh=1AeHJtrdMgjm8OhokFhnF96FWl3RsoojhDf2i8SMJ0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqxE6b9LiXbGBozzPY6g71vVUWcEHH3BEndplH7H9C2UksTcmmzuGDVYu5nVvScz18Z0wpxHcgFFTUOkgdzv2sxhMSEMIfJtk0AOiHOsWWji2+BP2DhqgHwy4wR+f65yi30dZoYka9Kl2KfY8rDbbPQ84YhnddLAnjKwzY0UMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0nFFH5C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410cd2c7f27so1494055e9.0;
        Sun, 11 Feb 2024 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707666618; x=1708271418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6yl3f+TEf2QrklR8BNS/51tQjJKHqU6ha2GsC+d38E=;
        b=m0nFFH5C7Y0yOpqOLiN4rL917TWCu2KYzHtGUDzkZGPcwuzNOImnNjYF3p7NN8GQMW
         8qOKRFv2EojqkMCqIdhKBt/SjFh58Du/oRUApIUjMRSUmi6aT5D+XqX9BFwGAt1J/ZPu
         MleGcAbk3cs23gCM3d1KyDb5IStex1vAAaGCM8dvZWve0N6ZujPcC+0DyvrZb6KdaJQq
         VFw8JjaP0k0XXcU+5alDPvgdOLuqUJBmjDn3ueDkLlCOqrEwK31Qa7QGGqaKnvP7er9X
         kNYfH5zlv/hLcvJh6rlqDJl1PsTj4jLWFARNVN+eVYcjDS4JXxYEgJ6M0pkbvI6fiMJq
         2MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666618; x=1708271418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6yl3f+TEf2QrklR8BNS/51tQjJKHqU6ha2GsC+d38E=;
        b=I/6CwhD9Lx9speyXqPTBph86HBIXuk2jFVI20jAZSP807GFta1XOIP4yIP568XGOB6
         eoX46lRko2lF+wTYmoNqS1ZScJ1nuXbYTJSJfOG3RpbXMSiX0FH7r47kkcyF9T5y8qoD
         UkmFgmQ8S1BfH6JhsZUsau8PXA6ANtoXL3SMdUKvTg1H89M0ZSeoZe6M7vU2MKjoxzbp
         +KSj0Q2d9c9QTFR+pf9cPh92rqAC35BTQKmUcxSAZw+PwNlhdsQH5IqhM6k+ZUxal6jt
         vhjnr4QPDLqwteXWtDcJCRtzBK/tENrEv7PA9OgbLZXbcFPpR3agJ33bT3zK/PgsDLww
         IRSA==
X-Forwarded-Encrypted: i=1; AJvYcCWcy4R6dzbEpgI99gIvPrPHByCCO0Os1lDLz/YK4NusQjzZ0R+AiZ5RI9NOog3PvL4z/hSVjX0nEDDfqFXZsqnhiCiTtlM/giu6d1SWX3hl/ClsZWaXzO/SDGYV4yQHAQ00RaYLiL0zUVbvPmajA5goZvTdTL59e3yLfr8VoGcT
X-Gm-Message-State: AOJu0YzwHTgzjY1AmIny3dY3sjs9/2jezFILPuSgbatDS99gPnkdD/nL
	TXZzud9n6hSEjX/uaiWl5z7anNnSx1Rbh+b0vwzKSUCrKqbBZZ4v5LSnBsQa6rNR5bR5Hgf94St
	wS+tHAlKm8J43MGTzF5EJ0Jrm8/O4XsR1
X-Google-Smtp-Source: AGHT+IEDuC8Y6MShKtfyIVwfeyPOlr88Fy7/UO6jB0atzdVY8bM1sR6qCNBEEnbJk7goT4IAttwPF9w63WmgJuVvaUY=
X-Received: by 2002:a5d:64c6:0:b0:33b:734f:3a8d with SMTP id
 f6-20020a5d64c6000000b0033b734f3a8dmr3355234wri.4.1707666617436; Sun, 11 Feb
 2024 07:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117114742.2587779-1-badhri@google.com> <ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk>
In-Reply-To: <ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk>
From: =?UTF-8?Q?G=C3=A1bor_Stefanik?= <netrolller.3d@gmail.com>
Date: Sun, 11 Feb 2024 16:50:09 +0100
Message-ID: <CA+XFjirAZ8y9SyddEdwt_CfDpP0TFqAYJ0vG4bhWWsrNewJPFQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "usb: typec: tcpm: fix cc role at port reset"
To: Mark Brown <broonie@kernel.org>
Cc: Badhri Jagan Sridharan <badhri@google.com>, gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com, kyletso@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, rdbabiera@google.com, 
	amitsd@google.com, stable@vger.kernel.org, frank.wang@rock-chips.com, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's exactly what I predicted would happen.

Mark Brown <broonie@kernel.org> ezt =C3=ADrta (id=C5=91pont: 2024. febr. 8.=
, Cs, 23:03):
>
> On Wed, Jan 17, 2024 at 11:47:42AM +0000, Badhri Jagan Sridharan wrote:
> > This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
> >
> > Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
> > the CC pins, setting CC pins to default state during PORT_RESET
> > breaks error recovery.
>
> Between -rc2 and -rc3 I started seeing boot issues in mainline on
> rk3399-roc-pc running arm64 defconfig, a bisection identified this patch
> as having broken things.  The issues manifest as a hang while loading
> modules from the initd, you can see a full boot log at:
>
>    https://lava.sirena.org.uk/scheduler/job/558789
>
> which shows a bunch of video drivers loading at the end of the log but I
> suspect that's not related the actual failure.  A successful boot can be
> seen here:
>
>    https://lava.sirena.org.uk/scheduler/job/559222
>
> I do note that the board is powered by USB PD, I've got it connected to
> a PD power supply which seems potentially relevant to the commit.  The
> board had been working for a long time, at least as far as boot to
> initrd goes.
>
> Full bisect log:
>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478] Linux 6.8-rc3
> git bisect bad 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> # status: waiting for good commit(s), bad commit known
> # good: [41bccc98fb7931d63d03f326a746ac4d429c1dd3] Linux 6.8-rc2
> git bisect good 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> # good: [4f18d3fd2975c943be91522d86257806374881b9] Merge tag 'iommu-fixes=
-v6.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> git bisect good 4f18d3fd2975c943be91522d86257806374881b9
> # good: [6b89b6af459fdd6f2741d0c2e33c67af8193697e] Merge tag 'gfs2-v6.8-r=
c2-revert' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
> git bisect good 6b89b6af459fdd6f2741d0c2e33c67af8193697e
> # good: [bdda52cc664caaf030fdaf51dd715ef5d1f14a26] Merge tag 'i2c-for-6.8=
-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
> git bisect good bdda52cc664caaf030fdaf51dd715ef5d1f14a26
> # bad: [0214960971939697f1499239398874cfc3a52d69] Merge tag 'tty-6.8-rc3'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect bad 0214960971939697f1499239398874cfc3a52d69
> # bad: [3caf2b2ad7334ef35f55b95f3e1b138c6f77b368] usb: ulpi: Fix debugfs =
directory leak
> git bisect bad 3caf2b2ad7334ef35f55b95f3e1b138c6f77b368
> # good: [7c4650ded49e5b88929ecbbb631efb8b0838e811] xhci: handle isoc Babb=
le and Buffer Overrun events properly
> git bisect good 7c4650ded49e5b88929ecbbb631efb8b0838e811
> # good: [cc509b6a47e7c8998d9e41c273191299d5d9d631] usb: chipidea: core: h=
andle power lost in workqueue
> git bisect good cc509b6a47e7c8998d9e41c273191299d5d9d631
> # good: [b2d2d7ea0dd09802cf5a0545bf54d8ad8987d20c] usb: f_mass_storage: f=
orbid async queue when shutdown happen
> git bisect good b2d2d7ea0dd09802cf5a0545bf54d8ad8987d20c
> # bad: [b717dfbf73e842d15174699fe2c6ee4fdde8aa1f] Revert "usb: typec: tcp=
m: fix cc role at port reset"
> git bisect bad b717dfbf73e842d15174699fe2c6ee4fdde8aa1f
> # good: [032178972f8e992b90f9794a13265fec8c8314b0] usb: gadget: pch_udc: =
fix an Excess kernel-doc warning
> git bisect good 032178972f8e992b90f9794a13265fec8c8314b0
> # first bad commit: [b717dfbf73e842d15174699fe2c6ee4fdde8aa1f] Revert "us=
b: typec: tcpm: fix cc role at port reset"

