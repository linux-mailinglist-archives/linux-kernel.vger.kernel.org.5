Return-Path: <linux-kernel+bounces-61925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066EC85187E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119891C222E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDE3CF73;
	Mon, 12 Feb 2024 15:53:28 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F683CF4C;
	Mon, 12 Feb 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753208; cv=none; b=Gqw9vJKkpeMXzhNgPqZ60Z90wm1a2FXTRToa5sjxo5LJ/HPvX6phg9kKrIbZPa/HB+xejeq52ezZSX0aVadGBLg8p+YT5MLQDX+vGsskQay5ijqflhgZloWZYNlb7WvJE/C+PPU42OxidQdD5oF9wg/4KQcEVqZBmqX8635+SrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753208; c=relaxed/simple;
	bh=TOQB1xmE2dkL80NHNKG1E+aZ+PSpqk+pA1ImOXMe5yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPUAJCTWWfBipR37jOjijR7n/VDpyvqWeBMN2Hiulb+3vDZACrfbhavnNg4CmdnFwLoAcvfKkc7GCTFLF7v/kYwddBcPSrtk3dvw/X5HgfSCCs7Hv3po+o415sumBWFr3H2zziJdAQDZZDy9xPtJAkHlLwPAsyZ/f5rq8gRhWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59ceb5a0593so247443eaf.0;
        Mon, 12 Feb 2024 07:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753205; x=1708358005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+YOPCfQJnpnizUm6zYCwiKQ1fID8ackk+hSsNCFZD0=;
        b=J2ADd2zhtR9typ8hpmBy7uGhGFDW5jq4+8B2q/igFNit90kluX1tdjzZKX/NC+nKRT
         ZxoCXfKTDeWTrwownRv8SwIwJREmtC34GWtoEk/zIKXcliUXkVAppw/pfKKrexPml+hO
         fFR/7GjKhqgNm0BDSCgwn3xCydDcUHHvAVdqrLT7hlBgxflgDKFsUR/Bh2nPoIj8jWzt
         UeJr3eqq+AkTuRGahtahPyz9wdPeiH0qtnrw7ZaYhPl/9KmUbdIJClbcnTt544golYJx
         mky312TGyL+pZz00t69GDVrDZVySkS1PkCugpgQYAolcJ5hWtIVMux3MKCbTQCieyzvl
         SV+w==
X-Gm-Message-State: AOJu0Yxc8hZom/TMl8ryvxvMzojHIEvBVXsSB6HqBRhgLGk2o+4gsIpV
	KD1edDnDEcG+auJBD0OmTu2m4GlCwfMoWEzgFWUgZdGIME2m1un94CM6e6a6HTcdFdGDMMdfdRA
	QGf08Z6iWGes27ZrhZrIJ/Vg6Lgk=
X-Google-Smtp-Source: AGHT+IE5QENzIXBg5xGKZIfgEgEh6YFzH+0YN/lgkbU8Q1TdmxQbD9AISfe6RY43rxZXl9auuu1LVL5lQrpIXnCX7Q0=
X-Received: by 2002:a4a:ce94:0:b0:59a:bfb:f556 with SMTP id
 f20-20020a4ace94000000b0059a0bfbf556mr5691586oos.0.1707753205534; Mon, 12 Feb
 2024 07:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205022500.2232124-1-qyousef@layalina.io> <20240205074514.kiolurpounokalum@vireshk-i7>
In-Reply-To: <20240205074514.kiolurpounokalum@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 16:53:14 +0100
Message-ID: <CAJZ5v0j2rA-+Jpdv6OZ_ymiqh0+RGzmJBNncKGBwuxO3PxgSKA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
To: Viresh Kumar <viresh.kumar@linaro.org>, Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:45=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 05-02-24, 02:25, Qais Yousef wrote:
> > 10ms is too high for today's hardware, even low end ones. This default
> > end up being used a lot on Arm machines at least. Pine64, mac mini and
> > pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> > it's too high for all of them.
> >
> > Change the default to 2ms which should be 'pessimistic' enough for wors=
t
> > case scenario, but not too high for platforms with fast DVFS hardware.
> >
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >  drivers/cpufreq/cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 44db4f59c4cc..8207f7294cb6 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(s=
truct cpufreq_policy *policy)
> >                * for platforms where transition_latency is in milliseco=
nds, it
> >                * ends up giving unrealistic values.
> >                *
> > -              * Cap the default transition delay to 10 ms, which seems=
 to be
> > +              * Cap the default transition delay to 2 ms, which seems =
to be
> >                * a reasonable amount of time after which we should reev=
aluate
> >                * the frequency.
> >                */
> > -             return min(latency * LATENCY_MULTIPLIER, (unsigned int)10=
000);
> > +             return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2=
*MSEC_PER_SEC));
>
> Please add spaces around '*'.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I've adjusted the whitespace as suggested above and applied the patch
as 5.9 material.

Thanks!

