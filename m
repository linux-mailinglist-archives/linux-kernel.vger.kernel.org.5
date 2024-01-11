Return-Path: <linux-kernel+bounces-23723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD2582B0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD879282E75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4AD495CC;
	Thu, 11 Jan 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ3q0zXo"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDEC4879E;
	Thu, 11 Jan 2024 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7af5f618so6133555e87.1;
        Thu, 11 Jan 2024 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704984001; x=1705588801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mAIvsCtxIylMlbMRjknP4e8iPnfceCQkHo2rcUGc2I=;
        b=BJ3q0zXoCcAyqrdLx25YQeLfKD5s4mHRHYT+8nTKFpyY9gKWprW+XHkfS3OnZcyY6F
         x2bvuHPTZ68B+CLkBBOWLiSXLJCaSNonC3KMfvEkZMmTDGnf014TyA/O/8Xtn9KKRnbF
         LR8q9N7W4Rm6MvELKMquqUU3TfQSQS1oH8oy0eXwW1O4k5czgjkR3tAnoGQ37EZBVLSx
         j6rRRijGVc8Vjv6obEMFVntGxsVbjJEFrh6CDJeVknyy8ASKqDe1eJTWpSouKIIeuIx2
         1pMGcbSKsXFYl6vijD9L9QPjFsvEhh2yezixdVIu5o8oyI+a0u2ejDGthg2mqSiP65C7
         hScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704984001; x=1705588801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mAIvsCtxIylMlbMRjknP4e8iPnfceCQkHo2rcUGc2I=;
        b=vFIWPQZt50T9ANN3R2afMroWUHH2b7OJDCZT75/58Fh1anO7AiWRx0VJjVre09UlLS
         ROWFRRpgVEy8p6cfPbXoiAFrSkwVE/sPU/TVSytndLsjmbIhBNNr/4BMtqtlOWH/yjsl
         CXXiCXX+BMxT8kysrZF36wRh2A5bxBg3LuyjHgYY03eZ6PakvZgbTlMh4p1Se4aurGoD
         8VVGNuN29KS1hBEGo0x+Di04Eef86x0Kjhm5FbJMLGBdM9yztB4dWLJ7VxCXpqgd8yYx
         Gj7cU+0eTEAej0EOxlgTUpJbNsIQ9iErblINV9HhhiDAMpHNe3iMco/In216W+VCQukj
         /q6A==
X-Gm-Message-State: AOJu0Yyes1jquXysmgWztG5xXYXU0AqOxSu+BzkZGzkVY5XlRjQii39v
	Wh67FCyO6xEr6m3eDEil4tFkNYqvoMF+WraI2NzE+ryxlIyPQg==
X-Google-Smtp-Source: AGHT+IFyZDF02qfgdF+6WcVylw8qmSkY3NTBJXWOY0xj18fA1mBswAQ86LK62ie6goXkLZpapcGcTOoZ+H5O13P0u0U=
X-Received: by 2002:a19:655b:0:b0:50e:7e53:8f6b with SMTP id
 c27-20020a19655b000000b0050e7e538f6bmr612536lfj.127.1704984000555; Thu, 11
 Jan 2024 06:40:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108143627.29ac91fe@canb.auug.org.au> <2024010830-swimsuit-ferment-8b88@gregkh>
 <20240108115155.f2d2f1e5789d74b90d1b7426@hugovil.com>
In-Reply-To: <20240108115155.f2d2f1e5789d74b90d1b7426@hugovil.com>
From: Yury Norov <yury.norov@gmail.com>
Date: Thu, 11 Jan 2024 06:39:49 -0800
Message-ID: <CAAH8bW-eLNebwabvvJeos4XbB77p4vGsutkwGtKMxR5-HpzTDA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bitmap tree with the tty tree
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 8:52=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
>
> On Mon, 8 Jan 2024 08:53:40 +0100
> Greg KH <greg@kroah.com> wrote:
>
> > On Mon, Jan 08, 2024 at 02:36:27PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Today's linux-next merge of the bitmap tree got a conflict in:
> > >
> > >   drivers/tty/serial/sc16is7xx.c
> > >
> > > between commits:
> > >
> > >   8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines bitfi=
eld in case of probe error")
> > >   3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using o=
ne regmap per port")
> > >
> > > from the tty tree and commit:
> > >
> > >   e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()")
> > >
> > > from the bitmap tree.
> > >
> > > I fixed it up (the former removed the function updated by the latter)=
 and
> > > can carry the fix as necessary. This is now fixed as far as linux-nex=
t
> > > is concerned, but any non trivial conflicts should be mentioned to yo=
ur
> > > upstream maintainer when your tree is submitted for merging.  You may
> > > also want to consider cooperating with the maintainer of the conflict=
ing
> > > tree to minimise any particularly complex conflicts.
> >
> > Fix looks coks correct, thanks.
>
> Yes, I confirm patch:
>     e63a961be48f ("serial: sc12is7xx: optimize sc16is7xx_alloc_line()")
>
> is now obsoleted by patch:
>     8a1060ce9749 ("serial: sc16is7xx: fix invalid sc16is7xx_lines
> bitfield in case of probe error")

Hi guys,

I've already sent a pull request that includes the e63a961be48f. If I'll ha=
ve to
re-send it, I'll exclude the obsolete patch. Otherwise, can you adjust the
8a1060ce9749?

Thanks,
Yury

