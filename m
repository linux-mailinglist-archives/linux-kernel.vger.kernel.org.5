Return-Path: <linux-kernel+bounces-135859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DF89CC22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8321F2540B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE2144D2E;
	Mon,  8 Apr 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ+rD1vF"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30511448D4;
	Mon,  8 Apr 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602801; cv=none; b=Zte2SLCIf2ukpPDaSw/QwtWuk5cadh7/5HpeNelviRD/78fkdeDtOn5g2NXmS2S2JGZTQ/wUTg/U42BtbM+1uvmqspT6orXpEWeB0FA8orYx81mKsQsOpLetT+7G9eRBwTOU2IWIXX72PpQjt0n8QvSsOg8cYgixBl8hA4n4Daw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602801; c=relaxed/simple;
	bh=hVNRy6nxiQS7v5uHtkchJIMbzjbuzLrJZecBob6Zx6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CV6749OMS3rEMoOxifHjwPU1Wz9qEqFRkvqG7Rd++LveiZcmj5gZcraZloDCNa8NDlWKjmT7R9P1rwgUWiYk+SPOGccZK6oOvfpc6vmeLfnMSzilwL7p8koXoNZs/Wr6691TZ4bUbaU7RiH3gtUpP/Bvqv5oNdRkceF8lvGVi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ+rD1vF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516c403c2e4so4136927e87.0;
        Mon, 08 Apr 2024 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712602798; x=1713207598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh9kkcOlOamrussQ/gPrZ63/bVYdek8XEIRHeCWx3os=;
        b=RJ+rD1vFR2efPRszATmd1RD0jilvKudnsCwGp6iVL/gUbFGB3ejzezHi6yBvx7p3b+
         rIpZn7EXiVzKnPaGCstkbzUwrISaJTpbD0rdEmSCl1Yy6HEEE0b74TK5dNfUeb6XnlaJ
         qxk1mkGLbF5vjn+X9RqOp/ol3jJnAX6FKcoM5oBPiK3NupI7d+nMKhTCsdnaK7gphjDy
         dLfs2IGO3daZJBb/43SKae7NIFr+HpTQ2GAayiWTS/Iq2hfAvekdZ6TW5zjIcJdO77Ff
         RJVM2ErScy0WfYcyAlAlg0tDnWC9p86VqeP02a/2aPVz1ehTUY0ensFVkte6Fny+Ws0J
         SgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712602798; x=1713207598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh9kkcOlOamrussQ/gPrZ63/bVYdek8XEIRHeCWx3os=;
        b=tX1qf64E3MEQds5vsR/4DyQnrl4lJeDwKZ/0lZumH4pR/pIyzKFJve0XI2t4AoPDK8
         +KQXj7pD4sPAlo/Lqrl+o/ZiS/HM9PzPPErHGvegpx+HD8ELZJbV79eKZUIGiHoqrfYE
         3u4aY8Ip7xqjkHuCDkRVt5RaEcjpGVqtnG+plQs9gZ2ND3jtrvgGg3T1EiknafWVtEA8
         0v/mj5DKarUhd1sbSLCBLU1UaqesjSKgdc3bD8eqgtD5xi5j9975izTpxga4OBUXP/Yt
         xVQqewZ8KWgS3R8GU1FSWuvsgxOYWzIBiv8pG0woU6UEBM2od+BMAAHVxMpT0vXm1KH0
         S9tw==
X-Forwarded-Encrypted: i=1; AJvYcCUA8SoT5dPFNEITMKMjW57Q24dOf6br4uOCSAbtECq08rcnu81tkvvil6E8iuVLxIPnio7zsPeRh4t1KhvIQuoSJ8dDC0yZR0Xgj2+X
X-Gm-Message-State: AOJu0YxO8RAVm1VzBPpGb1mI1o6pkNO+dF0cpQ5WMq343wtyZ3Ramz9J
	oUwf2UhHgABnflXSZ476MkcEBsm+K/dQb2Yf+FK+t3vea9zJCpnspcXbOItBXRkw5lTYdVtbUYU
	GCM4GDXyL7A8+MRxZ76wW+B1hryAz1iM9dv4=
X-Google-Smtp-Source: AGHT+IHzYhwEdp+6FK6ZCIWWNClIkC3X6f/N14N+ugEpxpfc5jUrSXkNbmXJTNPJN+SfBv4Ch5B6Nn5kzVo2/WEBTSQ=
X-Received: by 2002:a19:c20c:0:b0:513:ec32:aa88 with SMTP id
 l12-20020a19c20c000000b00513ec32aa88mr159659lfc.8.1712602797534; Mon, 08 Apr
 2024 11:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220710164026.541466-1-r.stratiienko@gmail.com> <CANDhNCpAhtgdwpSUTJ2jo2J5L6rHzQHVB9q+kkZ3ouTt12b-uw@mail.gmail.com>
In-Reply-To: <CANDhNCpAhtgdwpSUTJ2jo2J5L6rHzQHVB9q+kkZ3ouTt12b-uw@mail.gmail.com>
From: Roman Stratiienko <r.stratiienko@gmail.com>
Date: Mon, 8 Apr 2024 21:59:46 +0300
Message-ID: <CAGphcdnK8Hx-YsA-HukRKbvC-HpnLktCtq8qFicQUL-8ZHC+1w@mail.gmail.com>
Subject: Re: [RFC] thermal/core: Disable uevent messages for cooling devices
To: John Stultz <jstultz@google.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	amitk@kernel.org, rui.zhang@intel.com, linux-kernel@vger.kernel.org, 
	megi@xff.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,

I haven't worked on it since I posted it initially. But it looks like
there's an alternative patch already upstreamed and backported into
stable:

https://lore.kernel.org/linux-kernel/CAJZ5v0hHTuEXmQA=3D0D90eR_KUsOsfcxYbTS=
=3DzQYDTXuY6o_K_Q@mail.gmail.com/T/

BR,
Roman

=D0=BF=D0=BD, 8 =D0=B0=D0=BF=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 21:48, John=
 Stultz <jstultz@google.com>:
>
> On Sun, Jul 10, 2022 at 9:40=E2=80=AFAM Roman Stratiienko
> <r.stratiienko@gmail.com> wrote:
> >
> > During suspend, the big CPU cluster is turned off first while a little
> > is still running. This forcibly unregisters the cooling device which
> > sends a "REMOVE" uevent to all subscribers [1].
> >
> > In case userspace netlink subscriber has set the EPOLLWAKEUP flag, a
> > wakeup event is triggered that causes suspend to be aborted.
> >
> > Without this change, suspend doesn't work on PinePhone PRO with AOSP
> > userland.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/commit/?id=3D5c238a8b599f1ae25eaeb08ad0e9e13e2b9eb023
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
>
> Hey Roman,
>   I wanted to drudge this patch up, to ask what the current status of
> it was?  Is there an alternative solution that you've been using since
> this was last sent out?
> I've heard of some vendors working around something similar, so I
> wanted to see if we could get a common fix upstream.
>
> thanks
> -john

