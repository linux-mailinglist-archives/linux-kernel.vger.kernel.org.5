Return-Path: <linux-kernel+bounces-47806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB6984531C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62258286332
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C515B0EF;
	Thu,  1 Feb 2024 08:49:49 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFA15AACA;
	Thu,  1 Feb 2024 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777389; cv=none; b=MSeySq1Dk1gyhLdMbbp5W8rfv0andqpFAHPGX99FH+QTBBZQ0Hz6y8MJi5FgKyDloEdJ9p9d7C3B3rSZwyYDt60aOMcs2sI0rT4Yf8BVc1P+/cAFmQHcYfMfE+uZ3PO8rDR3RTOf9jMCLgTxeMQeCKFGyeJlGZjo3Haaw4LXFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777389; c=relaxed/simple;
	bh=Ulnq2zn7bBBl2so00pXdu5lo8VqAKDsNxF4Hn9YyZng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtQud7MQNt57x6qcYctKIdoAEIrXc/a3XXmZq1AbtFAAc2TePdiHt2ERe5crGThox5SbEX1GUqCyRfjKqtIQR/frflf6dRzeDDmKxzLLWY4vZ4qf5pECI4WZEKHAxsrS0PjynZ/V6iPZMJVyRpC1EkS18vpr/ee14lrK74a0kdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso419065276.1;
        Thu, 01 Feb 2024 00:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777386; x=1707382186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pM08Vaje05uNT4MpqrPqJ/UBHu1iKyKE3BU4yiYaf+c=;
        b=wYeUN0n84/vV6dxYlKWvxdl7qb1mdI9sM8pfpcCyI+gTkY48jhhGLLtXzYIMA+xGuM
         52cMP1wMrjmvczI2Ej2heNB3xqbrM+Ag4PRwACNMiGx55wycNhi1JlYpIAhZkpHz6twC
         gnuH7wTOlqROBPGM3tYOqLvsfoJ06Nu6IDNpj6hl9uOEw7OXQQq5vrpkSk+qHSMC8l4R
         nWndAy93eQVqoDPDswsEytMGU3TM/oFL70qRX0O1k/O8IYBIyspiNRdb3LT3XA3fdGmg
         TtpHbczVZK0Vx3C0TAiuNeuQ/d4Lf8VXt/sgv8Ho92g70MMtgLjzKNqy88Koifxm7Js6
         fsMg==
X-Gm-Message-State: AOJu0Yz6JjQgWq10+FOSO0n7Oym44Paxd+A3arhQfjQBvWhaXauCKr6T
	xMG71EYzHq1zAKf+ZmTKiyYiyDTBlU6h5cbwKxaLwq4zzC3adKsQbVZGX+K6SOQ=
X-Google-Smtp-Source: AGHT+IHcNq1Zh+RabdfjL3GJtJHf3wVDJDhlxODaScChPfaA42qab3yo/v3cgSMCHn1DX9nhxS5H+g==
X-Received: by 2002:a25:d617:0:b0:dc2:50ca:7d03 with SMTP id n23-20020a25d617000000b00dc250ca7d03mr4203495ybg.1.1706777385854;
        Thu, 01 Feb 2024 00:49:45 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id m127-20020a257185000000b00dc2310abe8bsm4088533ybc.38.2024.02.01.00.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:49:45 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6040d9e52b9so7064677b3.0;
        Thu, 01 Feb 2024 00:49:45 -0800 (PST)
X-Received: by 2002:a0d:d60b:0:b0:5ff:83f7:57e7 with SMTP id
 y11-20020a0dd60b000000b005ff83f757e7mr4170513ywd.31.1706777385132; Thu, 01
 Feb 2024 00:49:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a2396ae072d6f9e009b5de558efe166b844a1397.1706718625.git.geert+renesas@glider.be>
 <ZbqFsroYDjSoYEps@1wt.eu>
In-Reply-To: <ZbqFsroYDjSoYEps@1wt.eu>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2024 09:49:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWrjag3icVi2mJbtEftwz_jH51Ov4-FAV67Mdz7UvxQXw@mail.gmail.com>
Message-ID: <CAMuHMdWrjag3icVi2mJbtEftwz_jH51Ov4-FAV67Mdz7UvxQXw@mail.gmail.com>
Subject: Re: [PATCH/RFC] lib: add CPU MHz benchmark test
To: Willy Tarreau <w@1wt.eu>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Wed, Jan 31, 2024 at 6:39=E2=80=AFPM Willy Tarreau <w@1wt.eu> wrote:
> On Wed, Jan 31, 2024 at 05:46:48PM +0100, Geert Uytterhoeven wrote:
> > When working on SoC bring-up, (a full) userspace may not be available,
> > making it hard to benchmark the CPU performance of the system under
> > development.  Still, one may want to have a rough idea of the (relative=
)
> > performance of one or more CPU cores, especially when working on e.g.
> > the clock driver that controls the CPU core clock(s).
> >
> > Hence add the CPU MHz benchmark test[1], which estimates the clock
> > frequency of the CPU core it is running on, and make it available as a
> > Linux kernel test module.
> >
> > When built-in, this benchmark can be run without any userspace present.
>
> That's a great idea, I never thought about turning it into a module!
>
> > Parallel runs (run on multiple CPU cores) are supported, just kick the
> > "run" file multiple times.
>
> Hmmm does it mean it will run on the CPU that writes this "run" ?
> Because this could allow one to start tests using e.g.:
>
>     taskset -c $CPU tee /sys/.../run <<< y

That does indeed work.

> But we could also wonder if it wouldn't be easier to either send "y"
> to /sys/.../cpu0/run or may just send the CPU number to "run" instead
> of "y".

That would complicate the code a lot.

> In my experience with this tool, you most always want to easily
> control the CPU number because SoCs these days are not symmetrical at
> all.

That's why it prints the CPU number ;-)

On multi-core systems, you can also do e.g.

    for i in $(seq $(nproc)); do echo yes >
/sys/module/test_mhz/parameters/run & done

and collect the results for all CPU cores.

BTW, this is the same for test_dhry.

> Another point is that it would be nice if there was a way to present
> the result in a form that a script can retrieve from the directory,
> maybe the last measurement or something like this. I know that scripts
> are commonly used to check for a machine's correct behavior, and I try
> to encourage users to verify that it's working well, so anything we can
> do that makes it easier to use would be welcome.

I'll give that a try...

> But overall, I like it! You've got my ack.

Thanks!

> Hmmm I don't know if this is intended, the SPDX tag says MIT but the
> MODULE_LICENSE at the top says MIT/GPL. I can't say I care that much but
> I preferred to report it in case it's an accident ;-)

That must be an oversight.  I'll change the SPDX-License-Identifier to
"GPL-2.0 OR MIT".

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

