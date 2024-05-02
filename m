Return-Path: <linux-kernel+bounces-166062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0788B9566
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA59DB2129A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07F42261D;
	Thu,  2 May 2024 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvrD7mrX"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538611CBD;
	Thu,  2 May 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714635608; cv=none; b=G1FdrU9s5QTbLh48+ppUk5XMtHFwIOKJKHo+k/wSmsUAmZBAZ0DnrrfP4Srf6wh+Hz0aCmmVTxEGpB7MmdRM0k9BAdhNNqWYDUZop+aRtcrxUW5lxtP6L+hsqHDBl4yq01uysHSNsvhn0yuUsZyly/KiFP67dXxkXsO8xvCmTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714635608; c=relaxed/simple;
	bh=6piqrJAqzeQazaG8M25GP2vpM8ki8oUXlFsk190Fyeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1hpo5TyBfB6XGQ7oh9OpVzylkL6IaixnCsFjmPKgN7pEvMzwRKScxBcEgn27gVb2goB/DYeIdOpx4Fm2GekbLwwyBNZNrq97qVW4JMOLSRCKd1aV/zuyjhJGiIb+/dy6zMbxsVgbhf8cWAUpwPCwecTgHuLeGrZymJjWIuMFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvrD7mrX; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ef9dee5bddso328119a34.1;
        Thu, 02 May 2024 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714635606; x=1715240406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6piqrJAqzeQazaG8M25GP2vpM8ki8oUXlFsk190Fyeg=;
        b=BvrD7mrXUzFY+SHzRS3PXhbhCUe4QWiLN2dP1TaX02XQQrAefi4WmUl2q0LDT1C4Qx
         QATNnnK6O1eUuKaUE/6YqTZBEvwuI7lnA5Q9y9rD+KxkeZuDYmjk15Ral57XG8rnjff9
         SumsX987H9vGXmL/iGG+XnkPKFnz/Oy1j3996kqRmMKOoBsIsgtKhNY1WWK9WhtydnTM
         Poh9PA4t65FpNojb7ajStgX8D1XhJlUlmCuHXo/zkD9jG0gf3CsxWajY+yYB5PwEV4PJ
         IiwSlDbM0Yaf2fAcplVzSV8UF7pTmUryASuUY9LrbXH9I7YdmMFWHzmNvhEYwNfa62Ff
         OF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714635606; x=1715240406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6piqrJAqzeQazaG8M25GP2vpM8ki8oUXlFsk190Fyeg=;
        b=gsb2JS4kTvtB9++XecIfhO8q5yBXBQ/V4pmdg3cNDfIGl/u488LJW6JPwteftBISln
         W9fTq08lNACSwSGNow/HUrVgSElTQroLpy+2slopTnhmF8QcwSITmG6+lsOqJZc8xKOM
         iHZrVoXZiQVQWdV3DYDwzwUDfYl0u6OeECSzTJVONr65fgHjoaXYD4kZpfzrndplBJtI
         wRwKqGuT4QDqXayMghw8rrk0KY2OI8Cw2OwfcD0j5EFgxJVT0xBnqJYKBYcyXRiHxW6C
         24SQtP3EZxOs/WepNqKH7R+xt+RYwnx32m0G2bazfMjdkc511RM5OaisOMPQHNd1uP0b
         Wh7A==
X-Forwarded-Encrypted: i=1; AJvYcCX8TCuelGLywWRcTqGNoXHpj84O4HRHEm9W2UqlPe5pBbfFOgwMLrM3GavxC5QbmQD+f50E7DF66uG7Ck6ws4UmWotQCFKDMhmLc+H7r1iwdzyHiAwA2vZbd/R2MP9yqU92Lkl719N5My1lDN0yBt1peBQhVB6FMqWYwIZrC3PrdxncKQ==
X-Gm-Message-State: AOJu0YyQcrO1/n3g9YJ8Zi0BgnSP4kISWf+R02LHT4/L9saGaEnFuMl5
	LCWmlyU7qbtDjlBfzIv9aS0dCC2p2Dt624+ll7usInfB7MVAyF57vtUvc+f45sZoHkQj4/82uo/
	hNvZxp2oLCNhC17SNIekj2chHEmA=
X-Google-Smtp-Source: AGHT+IGjYrjkPdxGJ2i2wEkxCfqMD1u03K9iLSZQ+f3MlsLo4wzSznr1FC4I93/9saaTGjG+ETx3qMKgSjkZScvK6nM=
X-Received: by 2002:a9d:3e12:0:b0:6ee:50c2:6fa0 with SMTP id
 a18-20020a9d3e12000000b006ee50c26fa0mr5106332otd.7.1714635604219; Thu, 02 May
 2024 00:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
 <20240204044143.415915-3-qiujingbao.dlmu@gmail.com> <IA1PR20MB49533772D594D18204E9F9EEBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAJRtX8Rz0BhbtBJq+gSRTU3vsOwfyWjrqJ-Q1fqr7ZFeY2uaNQ@mail.gmail.com>
 <IA1PR20MB495377FCD5101F85B02BB5BCBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAJRtX8Ruh4BethYcGM2RueNBDioXpn8dJ3yvUD4iW_1cmiVFqg@mail.gmail.com> <20240501112001dc47d549@mail.local>
In-Reply-To: <20240501112001dc47d549@mail.local>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Thu, 2 May 2024 15:39:53 +0800
Message-ID: <CAJRtX8Q-4qYrnbuJ_NbH+1m4oPTkPWz_gm-3rb9p1KvFxTiZzQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 7:20=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 01/05/2024 17:14:43+0800, Jingbao Qiu wrote:
> > On Wed, May 1, 2024 at 3:43=E2=80=AFPM Inochi Amaoto <inochiama@outlook=
com> wrote:
> > >
> > > On Wed, May 01, 2024 at 01:03:58PM GMT, Jingbao Qiu wrote:
> > > > Hi, Inochi
> > > >
> > > > On Wed, May 1, 2024 at 10:19=E2=80=AFAM Inochi Amaoto <inochiama@ou=
tlook.com> wrote:
> >
> > > > > Another thing is that I do not think is a good way to let the
> > > > > rtc driver access RTC_CTRL area directly. You have already
> > > > > know there is a 8051 device in the 0x05025000. It is necessary
> > > > > to make some room for this device. Maybe you want to implement
> > > > > them all in the rtc driver? If so, I do think it is a bad idea.
> > > >
> > > >
> > > > Do you mean that RTC drivers should not directly access the 0x05025=
000 address?
> > > > Because there is an 8051 subsystem on this address.
> > >
> > > Yes. At least we need some mechanism to share these address between
> > > this devices.
> > >
> > > > Firstly, I do not intend to implement 8051 in the RTC driver,
> > > > but the 8051 subsystem is located within a module independently
> > > > powered by the RTC.
> > > > So if we want to implement the 8051 subsystem in the future, it can=
 be
> > > > used as a node in RTC? I'm not sure.
> > >
> > > Yes, this is what I care about.
> > >
> > > > Then, Alexandre told me that there are operations related to PM in
> > > > RTC, such as the following files.
> > > > This matches the description of address 0x05025000.
> > > >
> > > > drivers/rtc/rtc jz4740. c
> > > >
> > >
> > > I do not think this is something related to the PM. 8051 is more
> > > like remoteproc. So it is necessary to arrange them carefully.
> > >
> >
> > You are right.
> > I learned from official documents that 8051 works in the RTC domain.
> > Linux does not provide relevant interfaces to operate 8051,
> > Just providing a mailbox for communication between them, or through
> > interruptions.
> > I don't understand how 8051 works, so I shouldn't write to the
> > corresponding registers in RTC.
> >
> > https://milkv.io/docs/duo/getting-started/8051core
>
> Then you will have to have a driver for the 8051 firmware before being
> able to access registers that are outside of the RTC range. However, I
> se the firmware is using RTC_INFOx without any form of locking but I
> guess this just means Linux will have to ensure it never writes to
> those.
>

Yes, you are right. Not only are the registers on 0x05025000 used by 8051,
but some of the registers on 0x05026000 are shared by the C906 and 8051 cor=
es,
such as the RTC_INFOx you mentioned. The reference link is as follows.
So it is necessary to ensure that registers that implement RTC
functions can be read and written,
registers that are accessed together with 8051 can only be read but
not written, and registers
that are private to 8051 cannot be read or written.


https://github.com/milkv-duo/duo-8051/blob/main/sdcc/mars/include/chip_cv18=
22.h

Best regards
Jingbao Qiu

