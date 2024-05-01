Return-Path: <linux-kernel+bounces-165073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB1A8B875E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481612852A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714EB502B7;
	Wed,  1 May 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0r5kY3t"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0994E1A2;
	Wed,  1 May 2024 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554897; cv=none; b=YZKdSW0PrmN7sRIGxt0Ox8Pa5xxNOIloka564YKlsOr9FPvYV1M/Vpp/nFCugGc26JrybLaiFehYEJPKo1DVsXGDQFRUz0k/KnNRRg+3cnH8fsdy4x1idJS0uH/E31Ge0e26i4VOQ9CHZeN76zm4CDDhfZHiLFbb0d+jCLfcswU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554897; c=relaxed/simple;
	bh=Yrwu+7N9ljC9VYp3+kNHnWjn/O68b7FpSGtuKjbJJhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ermcCul/qXbAHOFhEjqCSOkXRB7nGtQWY3IyMbJoB2+C1795wUNhND/L2ODE/G/IOskgnl20orwLDRbDNYE9c/sjF+xFRCzbzgjzZcJZ6sDQ/54e0Tt/IMQqV5PzDd8dqi21lxGs+zD6d7St0lvssy/Zh965NCczzP/sLe8jkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0r5kY3t; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ee135f6a21so1621185a34.2;
        Wed, 01 May 2024 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714554895; x=1715159695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yrwu+7N9ljC9VYp3+kNHnWjn/O68b7FpSGtuKjbJJhY=;
        b=M0r5kY3t1nO4bNB28p7iMtY3sMVpBrFsqYZbaC6pGBWTEoQXD2ilndJVA9WOaj1whV
         itcUqXfhI7IlJK8QLfgiM2mVXp2mKpFzfoneE1pbIud+za0rT5+uKXRmTs9Xo6OviR9l
         S7kPME1DuLd0He7Zjrw0Gj+cXtIKuhcw+BjiUjiKdLuswB69uFRWTCbm+5dRF3M9GzSx
         OBVfxf8+MM87/BrH0DYrwTa0qP4/+l+b/3w3e/9lQSLOlYQYDePKsRvDfw0C496obxTP
         wPj7ygIs0k+y+rjA9Od8XlEq6ZP4WhOVie59GtljpVUYOpAKAGLtLF90MskYfH9si3pz
         VR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714554895; x=1715159695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yrwu+7N9ljC9VYp3+kNHnWjn/O68b7FpSGtuKjbJJhY=;
        b=WZETvk714pVfyTNDW9/N54PSKnJc3/C5bWLmbbQEVojXGbIYNOmq1YubGi21v2aqcV
         tH5shAtk3QCdY6GBF2bp+5/xpNk4qQ8QcvhIb5838KC9RLC6Ppu3mY4lTZ0AA14LKyZ7
         sX6z7So08EufcoRktFElvHShOY9CIr9Uq+brCI4Gw7XkQvjX0TeOzMc+jhTVN7voRT36
         VUDAYittN8yYnW75KLqO7DlSJu7wtTWMu7C3mcaSPRzKtIU0q3K64MrGnREDwvttiZYk
         k1f98wzQyxF1qcIztrSR0TypNZBFEd/XE4uLZ75T1APbMEP2Sr91ooQA6LLNRHrsSAFG
         NnWg==
X-Forwarded-Encrypted: i=1; AJvYcCVSf+iJIlIcUMKu1kQFaWjA0kSVPqjG7fRM39ReDgxsCRq3CB7hNGKlZxL+bIfADG0yAuCWYtIvXHzMZfI7BCeeAbigI8cQLxuuQYYmL0Sc/25Aq6h7NmegKDSJ4UB2/wTzUAi/uePQIiYHAXuyK5FYEaGtTA0TVSIVdNTvtbYK46MvKA==
X-Gm-Message-State: AOJu0YzjjLCZQTJ19SQ2O7xVvuoornRUkXd3HDdUwBUu8ekJ2DumrIF1
	GJM4x76nWUdsG6nSmVVLX4W5ws4gUh2rfsCl8jm9MFHqgn+n1Raxfl3VdbUr9yjvV3pISnW61T/
	T0oi0FEi1d1lDuHVWwDjv+Pwctak=
X-Google-Smtp-Source: AGHT+IGB88rqVJammMgYM3oslOHaBTKTsRsW43uAnWRMsBUZN18rwIQH5n45k77Z2MCO14x1ZQUMCgg3zOyxf+F9sXk=
X-Received: by 2002:a9d:6209:0:b0:6ee:1bfe:9a6b with SMTP id
 g9-20020a9d6209000000b006ee1bfe9a6bmr2006443otj.34.1714554895055; Wed, 01 May
 2024 02:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
 <20240204044143.415915-3-qiujingbao.dlmu@gmail.com> <IA1PR20MB49533772D594D18204E9F9EEBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAJRtX8Rz0BhbtBJq+gSRTU3vsOwfyWjrqJ-Q1fqr7ZFeY2uaNQ@mail.gmail.com> <IA1PR20MB495377FCD5101F85B02BB5BCBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB495377FCD5101F85B02BB5BCBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 1 May 2024 17:14:43 +0800
Message-ID: <CAJRtX8Ruh4BethYcGM2RueNBDioXpn8dJ3yvUD4iW_1cmiVFqg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: Inochi Amaoto <inochiama@outlook.com>
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 3:43=E2=80=AFPM Inochi Amaoto <inochiama@outlook.com=
> wrote:
>
> On Wed, May 01, 2024 at 01:03:58PM GMT, Jingbao Qiu wrote:
> > Hi, Inochi
> >
> > On Wed, May 1, 2024 at 10:19=E2=80=AFAM Inochi Amaoto <inochiama@outloo=
k.com> wrote:

> > > Another thing is that I do not think is a good way to let the
> > > rtc driver access RTC_CTRL area directly. You have already
> > > know there is a 8051 device in the 0x05025000. It is necessary
> > > to make some room for this device. Maybe you want to implement
> > > them all in the rtc driver? If so, I do think it is a bad idea.
> >
> >
> > Do you mean that RTC drivers should not directly access the 0x05025000 =
address?
> > Because there is an 8051 subsystem on this address.
>
> Yes. At least we need some mechanism to share these address between
> this devices.
>
> > Firstly, I do not intend to implement 8051 in the RTC driver,
> > but the 8051 subsystem is located within a module independently
> > powered by the RTC.
> > So if we want to implement the 8051 subsystem in the future, it can be
> > used as a node in RTC? I'm not sure.
>
> Yes, this is what I care about.
>
> > Then, Alexandre told me that there are operations related to PM in
> > RTC, such as the following files.
> > This matches the description of address 0x05025000.
> >
> > drivers/rtc/rtc jz4740. c
> >
>
> I do not think this is something related to the PM. 8051 is more
> like remoteproc. So it is necessary to arrange them carefully.
>

You are right.
I learned from official documents that 8051 works in the RTC domain.
Linux does not provide relevant interfaces to operate 8051,
Just providing a mailbox for communication between them, or through
interruptions.
I don't understand how 8051 works, so I shouldn't write to the
corresponding registers in RTC.

https://milkv.io/docs/duo/getting-started/8051core


> > > > 2.25.1
> > > >

