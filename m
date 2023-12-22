Return-Path: <linux-kernel+bounces-9772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B5481CB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5381C214BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3D1CA9F;
	Fri, 22 Dec 2023 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYm1uYro"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1E2031B;
	Fri, 22 Dec 2023 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so254814a12.1;
        Fri, 22 Dec 2023 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703254505; x=1703859305; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zSMHDuQX1y5+DYhjAAy/0kV003znPZue6vWKu4XMzcM=;
        b=gYm1uYroCKmxmSJzdloQ7lUn/STP99g9cZKDBszIggG/qVCmPVU679AJguP8NStMpi
         OhiXwXLATrHmIDTDEKYoY/uC0HjvdhB/jYwuRmdAYjy4WgEzsCcuF23+k0jZv6Sj9IyA
         JfTuQFwHtl5miFJt+VWDLZb6RGV2RrLKDeoJvUBSuUqQLJsbAAgpEo33UomrS155EDHW
         NlB1qdemmSdXNhYDU3xAcQYaAB30DI66UEGtkC4T+FBrUpa8nLZU/Vk5/yXQUwSCbCQ6
         3jZ7JfuvyihevaF6742I0zpPE/ggD3lI4xVBqdHomM16f27dxBf2xURsvcWOSxx1tXoB
         RPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703254505; x=1703859305;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSMHDuQX1y5+DYhjAAy/0kV003znPZue6vWKu4XMzcM=;
        b=LcpewFvmnMHkKrX8KGsFikOGGovgPto67UYd+qUJRQnWf/4f3kj+MQgGUO5XtUEk1M
         SJtfxm4gQLBj2UUjVngddG94VlstNs7Jr6fooDtdwrmvGrp8F0wfBPvuyUjPEoW1upOh
         /dJMRQ3RKIE9oISCrDOPsW7M8B36H/rnLuyTM/k4I9oPxv7mpu9D5lf/jRJDeTjmbrYl
         P3L77U1cYVS5YXLhfxHpxVC3f4JnhyoILj85a8a9szCNtoXBVacyDqhNoxXoLd2Ms7DV
         Y14H3jsV6Tei0AD03XAtfoV0KLWSK7cWI8O2skyA8drsbUHCutE8HKrWx2bTAq8x0xY5
         V5NA==
X-Gm-Message-State: AOJu0YxJq8q/5i4kTl0UOTcZ79CZ7vCwdo54EoNhV2cjAohc3I/NEBc3
	BGLQUqWmYV5sxaUDQNB15Yc=
X-Google-Smtp-Source: AGHT+IF925AGB69UOlptiaAH4z/poi0QYDbpNb9g0blYiQZ+nfY2PqOSUMGxBI7zS38w3vvvpKXXqw==
X-Received: by 2002:a05:6a20:4905:b0:195:37be:952f with SMTP id ft5-20020a056a20490500b0019537be952fmr479040pzb.107.1703254504814;
        Fri, 22 Dec 2023 06:15:04 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b001d3ef3eb988sm1667855plg.253.2023.12.22.06.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 06:15:04 -0800 (PST)
Date: Fri, 22 Dec 2023 22:14:59 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
Message-ID: <ZYWZ4yhqzTF8rShe@rigel>
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
 <ZYTihbWMcHMHSkC_@rigel>
 <ZYWDij-J1YruTIM7@smile.fi.intel.com>
 <ZYWHjq_7PnwO27ro@rigel>
 <CAMRc=McPzQyR1J5Mhn7_cBrWEcqz2JKg7t8CpjHx6jgVEnYBvA@mail.gmail.com>
 <ZYWYZ6Ys3hSb4IOe@rigel>
 <CACMJSeu-bS+MpP8HCcD74w0j6vFt821bpgth5LHpqq-fHnEe1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACMJSeu-bS+MpP8HCcD74w0j6vFt821bpgth5LHpqq-fHnEe1w@mail.gmail.com>

On Fri, Dec 22, 2023 at 03:09:54PM +0100, Bartosz Golaszewski wrote:
> On Fri, 22 Dec 2023 at 15:08, Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 02:37:43PM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Dec 22, 2023 at 1:56 PM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> >
> > > > > > And you could've included me in the Cc so I didn't just find it by
> > > > > > accident.
> > > > >
> > > > > Maybe it's time to add you to the MAINTAINERS for this file as a designated
> > > > > reviewer?
> > > > >
> > > >
> > > > You are patching my recent change that you yourself reviewed only days
> > > > ago. I would think that you would Cc me whether I were a maintainer or
> > > > not as I'm very likely to have relevant feedback.
> > >
> > > On that note: do you see yourself as a full GPIO reviewer or do you
> > > prefer I split out the uAPI part into a separate section in
> > > MAINTAINERS and nominate you as its maintainer?
> > >
> >
> > Not sure I'm comfortable with either.
> >
> > Definitely not full GPIO.  I don't feel sufficiently familiar with GPIO
> > and the related subsystems to qualify.
> >
> > Splitting out cdev and the uAPI makes more sense to me, but in my mind at
> > least even that requires a level of commitment higher than the rather
> > spotty attention I've been providing recently.
> > I'm more inclined to leave it as is.
> >
>
> I can still split the uAPI files into their own section, make Linus
> and myself maintainers and make you a reviewer, how about that?
>

That is closer to the reality, so that would work for me.

Cheers,
Kent.

