Return-Path: <linux-kernel+bounces-35652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2D68394CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9E31C22A61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3D7F7D6;
	Tue, 23 Jan 2024 16:36:14 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D6481C7;
	Tue, 23 Jan 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027774; cv=none; b=Hrv1gX1fDPzt5Ni2p5OJSwmPa/WpxfoKStAFVgpjjSLo4zJ+Yv5iePODjX8WPg1u8DnIFPALdykWH7cTfAfZl6hdC8MIqNkIH+10mGEJ8tFDrUs5ylF4CF9gWETcf64U4AhFih/dMg01WpHt7KE3n3WUoRpolcPQ2sn0N+E4nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027774; c=relaxed/simple;
	bh=slEEUvS5yWbLFstaB903ZyuNsFWyRLdO8mIwBpg5IAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6VqP3r2hMkiFn6FnnvSAYLoCHGQgwU7w465Se5b5AaXUHGDl1KJ+REQTCxaY/+PqW+gryshJgSZpE/KQK7uBHHdQRbY+u+koKBAMrb3VfB9ovYd6bp6yRLKtE1N8heRGuSKCDWS6ZCmvSyUXnSFAwKyVojcC2s6Hbf1peevgQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff7dd8d7ceso39502627b3.0;
        Tue, 23 Jan 2024 08:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706027771; x=1706632571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiyJdU6PhJ45i7bpAb37xxoLaCkKdVvy6nsNT0rREKI=;
        b=fqMAkn7fSTalC6KTfzhiFjuE6tGpbOHxkxaWmiZFClCPzNA6pj8UOH0RN3AGJWuqI0
         rWUaLnfa8HyPI1bf2fvESxAFecFSZRBejo7WJ8zR5J3INzSI3ttoaykSuNTrdVhCn37b
         IW6c5qbKgTCPtXD4EbgUFyVK7zWAgTK1iU0gyf2kAjmwlhrWzbaLIgh5u7bSbhDGirsY
         1t15TF4m4TrBNOr0vwFWAQRObQR9KXMhDlgAPMoe51Fa9WZrmXsaThRY+/iwuQQGoNyQ
         +RQuPnFHcM2dLI+JCanKnsDGYV2yRJ2+T09G3lXJWm3SmocnUkWFe9tGcf/fQUBgPrfP
         HXKQ==
X-Gm-Message-State: AOJu0YzxfKPMaT6UlMWlGpT69MbBR3xZMTD2IljXjGK+wcf7osd4tzM6
	nauWHNyP0JfcRwYHn7XBkA1eZs5cVloQF7bSVFvaHd8Pq64dPuKXxw4wlca7Fg4=
X-Google-Smtp-Source: AGHT+IE5K5XiSLyq3cMkoMyANm3Uj1BZNOKVoyZ1EF23j+Yi14/cnOWshf4GezQ5elVZTh9TcX4CYw==
X-Received: by 2002:a0d:fec1:0:b0:5ff:5d73:2fb1 with SMTP id o184-20020a0dfec1000000b005ff5d732fb1mr5732575ywf.93.1706027770173;
        Tue, 23 Jan 2024 08:36:10 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id cj3-20020a05690c0b0300b005a7d46770f2sm10110488ywb.83.2024.01.23.08.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:36:09 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60032f9e510so8447797b3.2;
        Tue, 23 Jan 2024 08:36:09 -0800 (PST)
X-Received: by 2002:a81:4746:0:b0:5fc:d382:4bfc with SMTP id
 u67-20020a814746000000b005fcd3824bfcmr5185832ywa.97.1706027769362; Tue, 23
 Jan 2024 08:36:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123132335.2034611-1-arnd@kernel.org> <1ab7594855718e24ddc629ebbab1edc8bdcd799a.camel@physik.fu-berlin.de>
 <8d37ad26-efdf-4e10-9a72-d49e37de0307@app.fastmail.com> <f00ef92b6ed93babe677e2585a7cad26347d2988.camel@physik.fu-berlin.de>
In-Reply-To: <f00ef92b6ed93babe677e2585a7cad26347d2988.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jan 2024 17:35:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZp6aM8DmC-VrOqPwh=9DLSDmeDW0k=thOah-Di2Xh5w@mail.gmail.com>
Message-ID: <CAMuHMdVZp6aM8DmC-VrOqPwh=9DLSDmeDW0k=thOah-Di2Xh5w@mail.gmail.com>
Subject: Re: [PATCH] sh: use generic uaccess
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Tue, Jan 23, 2024 at 3:20=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2024-01-23 at 15:14 +0100, Arnd Bergmann wrote:
> > On Tue, Jan 23, 2024, at 14:55, John Paul Adrian Glaubitz wrote:
> > >
> > > Wouldn't that make these operations slower or do you think that GCC i=
s able
> > > to optimize this well enough?
> >
> > It's only single load/store instructions, so it should make no
> > difference. If anything, the generic code should allow the compiler
> > to have better register allocation and produce better output than
> > the assembler version (which is how this avoids the ICE), but it's
> > unlikely to be noticeably either.
>
> I have not seen an ICE on v6.8-rc1 so far. What config was it that trigge=
red it?

v6.8-rc1/sh4-gcc12/sh-allmodconfig
v6.8-rc1/sh4-gcc11/sh-allyesconfig
v6.8-rc1/sh4-gcc13/sh-allmodconfig
v6.8-rc1/sh4-gcc13/sh-allyesconfig

e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/15111229/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

