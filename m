Return-Path: <linux-kernel+bounces-140159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087958A0C31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0461C202F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F514431E;
	Thu, 11 Apr 2024 09:20:29 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428C13CF91;
	Thu, 11 Apr 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827229; cv=none; b=VazXHw483kPQS2rHB6WDQgqvDt9QvOzsW55D8lQEQ5q0GutYQ1Y6+iGC4SY590tXEFB51seWYuAT9VXljpqHLN31X9B7jK3yUPYUqmb9Bxy69fx4YZptRy+Qd4vQ2KDSFZ3sbmbzg5VtBSZEbibvbKZKRCMfn9rbLEooVAFYy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827229; c=relaxed/simple;
	bh=MuSa2629wjnJIwbeR+E3etbsRyL6LRWQ87Up/BxVyrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPa7dG8mqVfdMBrn8NiWHUFj1cJncXajtQPiRmZR9Py8k5IsN027rJ52eQ9LpMbSqufXSL+2fJzUnHPkmqkFkrWxGDvCN6PHjoisL05ygIb2tQHsC3ZNxRlqBd5/ZllEDF8oE1iz7vkK5YTcKmI1pUOP4HriDdj61BreV1t7mDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6153d85053aso66498107b3.0;
        Thu, 11 Apr 2024 02:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712827226; x=1713432026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWrI7vAbCyWyhkrkKcSxlbZsN3p29am8eXxJfrQzGlo=;
        b=pD0fXMIYPvDw+J6bEKNmGhegVNLwA6O9S7wMzFwum5Yu2veacBmyPH3c9zzjTnwDKZ
         mWe9yHvyzlg0jY7xt0W9/Bud6hDTcDE319JY5m1iWP7rO8sOBhBKuVhu0l7OVooeD11T
         6IXOTMSlKYYPjtNRoa4GEp0/tzQJcVJhyQ83sopkQ+4FaScSLhty4CMe7reiWUCEf2ZN
         yYLeJVE2HHYRgunp5gA4mCdg6KTi/XfFaOKQY9SSEBNww7MmptHQt9frNX3LzP2NhjSO
         jtkjY/eL/zNoR0YBJHvGJT5jw7ka/4yulcs8nOdbmP2Z2I0HyHvEk16sguAv2yRMq9Ct
         OLzg==
X-Forwarded-Encrypted: i=1; AJvYcCX629CkWdRdd9elTd+dkTHHm5uQNtK5E2sS7n45q441r3w1BRhcT+qpxOvTSqS5BH2Yp1+GPnhTiGv1M3p2dC6rw6QfsitUXxTnGTvLgZ6wcFzFDj0YluYhVGRR3urNm1+4pLhToDty+qI4FPtzq9mj9i/Y3GCRZm+N2CEkc7SqsOHx6CoArWrLJcMgikFnUAXozfUYAP3HQM6o
X-Gm-Message-State: AOJu0YwXt/N3YopQIFGMiVt5uQbqOsOe7HV+mn15SBbiySmj0iWyazqe
	qOGc7Qmfg8UwX34/nH/5oRmEo2zZ9nIsN4e+huAvjP4MR3gmAN/VG30RHS5B
X-Google-Smtp-Source: AGHT+IEf70VCszZn4E7AmD3QM76pIOuzM53vCivZ/FRPguLc1wUdDEXUP/74sFB5WtBdkfwk9h4KWQ==
X-Received: by 2002:a81:a1c3:0:b0:618:198f:aedb with SMTP id y186-20020a81a1c3000000b00618198faedbmr4732950ywg.5.1712827225836;
        Thu, 11 Apr 2024 02:20:25 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id s10-20020a81770a000000b0061537270630sm229113ywc.80.2024.04.11.02.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 02:20:09 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dd045349d42so7031135276.2;
        Thu, 11 Apr 2024 02:20:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxhRyejhRL+/YvVR0rRv3NZ/ew6Ar2I0taiVCwjRrqn9ff3/G/WXVLRBW9oVKTCduTfBJcjjtSiAsC6A3kwgbxsTP/HJKrigbK+e19BF48rpJVBsJJvqODzATGNMhION+J7hWHPHDsFChXLhxsNFGprdEfTNuuQASevBRsaTTzHu7Qt4J6cm0l/1G63Gbd/IwScYon8q3fSt70
X-Received: by 2002:a25:868a:0:b0:dc7:6f13:61d1 with SMTP id
 z10-20020a25868a000000b00dc76f1361d1mr5243102ybk.20.1712827209472; Thu, 11
 Apr 2024 02:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712812895.git.linux@leemhuis.info> <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
 <2024041156-backache-dolly-a420@gregkh> <3f395eca-fc24-469b-b5fc-de47ab2a6861@leemhuis.info>
 <2024041123-earthling-primarily-4656@gregkh> <dad33d1c-77da-4b97-a0ec-4bf566f8d861@leemhuis.info>
 <2024041159-undone-deacon-3170@gregkh>
In-Reply-To: <2024041159-undone-deacon-3170@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 11:19:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXMRJM1xQLHDc6yKWvs97W2iTZnYnNNZE=8-WrtnGRNfw@mail.gmail.com>
Message-ID: <CAMuHMdXMRJM1xQLHDc6yKWvs97W2iTZnYnNNZE=8-WrtnGRNfw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no
 semi-automatic backport"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Sasha Levin <sashal@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:13=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Apr 11, 2024 at 09:50:24AM +0200, Thorsten Leemhuis wrote:
> > On 11.04.24 09:40, Greg Kroah-Hartman wrote:
> > > On Thu, Apr 11, 2024 at 08:59:39AM +0200, Thorsten Leemhuis wrote:
> > >> On 11.04.24 07:29, Greg Kroah-Hartman wrote:
> > >>> On Thu, Apr 11, 2024 at 07:25:04AM +0200, Thorsten Leemhuis wrote:
> > >>>> Some developers deliberately steer clear of 'Fixes:' tags to preve=
nt
> > >>>> changes from being backported semi-automatically by the stable tea=
m.
> > >>>> That somewhat undermines the reason for the existence of the Fixes=
: tag,
> > >>>> hence point out there is an alternative to reach the same effect.
> > > [...]
> > >>> I do not understand, why are you saying "cc: stable" here if you do=
 NOT
> > >>> want it backported?
> > >> Because the only alternative the developers have to make the stable =
team
> > >> not pick a single patch[1] is to deliberately omit a Fixes: tag even=
 if
> > >> the patch normally should have one. Like it was done here:
> > >> https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secun=
et.com/
> > > That feels odd, but ok I now see the need for this for some minor set=
 of
> > > changes (i.e. this has rarely come up in the past 15+ years)
> > >
> > > [...]
> > >> E.g. 'ignore for the AUTOSEL and the "Fixes tag only" tools'. That w=
as
> > >> the best term I came up with.
> > >
> > > Thinking about it more, I think we need to be much more explicit, and
> > > provide the reason why.
> > >
> > > How about:
> > >     cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and m=
ust be present
> > >
> > > and we can make that address be routed to /dev/null just like
> > > <stable@kernel.org> is?
> >
> > Totally fine with me, but that feels somewhat long and hard to type.
>
> I want it long and hard to type and very very explicit that this is what
> the developer/maintainer wants to have happen (again, because this is
> such a rare occurrence.)
>
> > How
> > about just 'no-stable@kernel.org' (or 'nostable@kernel.org')?
>
> More words are better :)

And after that, someone discovers this turns out to be (a hard
dependency for) a very critical fix that does need backporting?

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

