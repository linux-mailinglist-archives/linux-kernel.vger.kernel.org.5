Return-Path: <linux-kernel+bounces-4043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F45817714
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282061C25B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8C4238D;
	Mon, 18 Dec 2023 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm+Ex8Zi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AA42390;
	Mon, 18 Dec 2023 16:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C57C433C8;
	Mon, 18 Dec 2023 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702915926;
	bh=+gDFHiUihVO9YBtJ8DDjinIUtn2dVVzpQVgSxl0p0lI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hm+Ex8ZiURA0F5paydO7ZLLIg3KNQQlTFBJ0mw6XFkJlZz0Z8GltQT//tsgdtVJ1f
	 yWpOK5soe6FtNz61AaJ2UjDAqWhyxOueiT+NHqHVaoq70dxYXKKPsJkiXaFsVyB+SX
	 ZgvpxEDJNhJ5T3zufg2R1EI7oentL9EQntXtrRU06IykKyA7ncUCEzcDAcBjNV+poM
	 BdKuO8M8ksN7Ccx4qFpiiftObmtA+bfPndtmPzOECOLHk7h2zfjPsrvHXPh1UuhObB
	 d6XcyLAUnPmuVblEKfXGpaXz0Or3kPqPMpYf5uYbC8FNLDEVSbdVIjiINhzVRsvuxr
	 4wSmFWSM0Evhg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e3845abdaso1611300e87.3;
        Mon, 18 Dec 2023 08:12:06 -0800 (PST)
X-Gm-Message-State: AOJu0YxxcHHlvyKkBDH3JYA6yB6ZPiJkCQo/tIsN1pqcRtYz3G9iWjy1
	wJYa6HyoMRT1rAhs+60H2OfY4+B10W+ydZC2gsM=
X-Google-Smtp-Source: AGHT+IFX38T/oiryJnVRtGF33LbC+xeoNQMiXNLbUmvcuvnSgPEGquuxe9tB7QSqJygcut2TdqNcVjLjBSpbpJMiM3o=
X-Received: by 2002:ac2:4c42:0:b0:50e:ce9:b2f6 with SMTP id
 o2-20020ac24c42000000b0050e0ce9b2f6mr6348086lfk.125.1702915925051; Mon, 18
 Dec 2023 08:12:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222107.2016042-1-song@kernel.org> <20231215125059.00006270@linux.intel.com>
 <CAPhsuW6GZnufqFseLvgpMrrX6qRXodX1n89vEbbC-FqTjsWPDg@mail.gmail.com> <20231218093201.000020dd@linux.intel.com>
In-Reply-To: <20231218093201.000020dd@linux.intel.com>
From: Song Liu <song@kernel.org>
Date: Mon, 18 Dec 2023 08:11:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7w7WbWePpQd4aqnvXHwbdEJzw9efEP_r6tJwpeg0_qLw@mail.gmail.com>
Message-ID: <CAPhsuW7w7WbWePpQd4aqnvXHwbdEJzw9efEP_r6tJwpeg0_qLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] md: Remove deprecated flavors
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Paul E Luse <paul.e.luse@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mariusz,

On Mon, Dec 18, 2023 at 12:32=E2=80=AFAM Mariusz Tkaczyk
<mariusz.tkaczyk@linux.intel.com> wrote:
>
[...]
> > >
> > > Please note that there are mdadm tests for those levels. I can approv=
e it
> > > only when mdadm clean-up is merged. Our tests must pass continuously.
> >
> > Is the continuous test result available publicly?
>
> We are working on public CI (Paul owns it). On my side I'm not executing =
all
> tests, IMSM only. In this case it is obvious that mdadm tests will stop p=
assing,
> I don't need results to see that. We should keep both mdadm and md compat=
ible.
> We are continuously adding new MD regression tests to mdadm (at least Kua=
i is
> doing that) so we should also care about removing things.
>
> >
> > >
> > > It is a nice code complexity improvement so let me know if you would
> > > like to get my help with mdadm patches.
> >
> > On my local tests with mdadm, I need to make changes to the following
> > tests:
> >
> > 00linear...
> > 00names...
> > 00raid0...
> > 00readonly...
> > 02lineargrow...
> > 03r0assem...
> > 04r0update...
> > 04update-metadata...
> >
> > The changes are all straightforward (just remove things related to
> > linear/multipath/faulty).
> >
>
> Please do not forgot remove dead code from mdadm. For example simple find
> "multipath" (case insensitive) reefers me to multiple places with special
> handling for this level. We need to remove it from code and documentation=
.
> Can you handle this too?

I think this is a bigger discussion: will mdadm stop supporting these
flavors on
older kernels? Say, mdadm-5.0+ (or a different number) will not support
multipath flavor on older kernels?

>
> Oh and last one, I can't find update for md man in your changes. Could yo=
u
> please remove those levels from md man?

man side is easier. Once we know which major will have this set (6.8 or lat=
er),
we can update the man pages with the information.

Thanks,
Song

