Return-Path: <linux-kernel+bounces-82814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A074868A09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEDD1C20D60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB28A54BF1;
	Tue, 27 Feb 2024 07:42:04 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAD53366
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019724; cv=none; b=AGufA2LOqd5AnVOz9Dpu9OW3XU1KwMMEFxSAyU2VIchQJobywfMX11egOZaEASdWt3/1wEOluR3oydcPfix4LJdDPqChHw0zZJEQkV3Y9HV6F6i0u4ObLGYd32GNyrvWytK2xgDu0UqSZkMJ4gJKwyBqvAaLmFhhbKEwdyxCCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019724; c=relaxed/simple;
	bh=PRocj1N0mGG48q41v7UAxjcCgltfFv4sY0S/bF2PfVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKENsBnfFBharxuOU9eRuYOgXFc/TWTCv/UQ9bhg/Ckpfv0s+yJBTSjVYJP3c2ybVWiJEIJrRFtMClB6ud5lfctSQuFXrgqVJdbMxfWxmge0ZzAOsUeT8C05KXy/7YQXa609Fl6ptzgjWansTLjC5pbcVcrZmBzbiNXWlWdmM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608d55ab7b0so26380887b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709019720; x=1709624520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFl5adFzYYsCMJUvAOgdtPjYk4mF+SvLHr40WscSKV8=;
        b=LvM4q0uGlUFA2s/nNHe2AZ3deUL6wTWDG3hgY4tvDEhB6wNu4mnxkD6w//H9CjDlyx
         6JexiDb9HipjgVIV5RjMt3yuGU2PI9/lOowl3LTSDHq4e53+zeKxmq9jKKQZdtPL0Hib
         wHzDJ2cXE/eAJ2RR8JmhswfDXIfkGBve/bjaOBkEZ1/sRpkhW2kpiPGzbJ916xVfW5w1
         qRSQf/7fDK+sAyVsNPnbT6ianoPGJdcC5MpEtUo1qRyNgo6zKwfrYKskP7ZaNVT0XHqf
         ZFoZgesOhCtO8v0eV0f6lqltuZGKYSfjNMQ/rx64GtQMOcPUaobcqFIHatKRH3wlQL86
         JvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSD8V33B6NvuP4TpBUrSv+RPrd4MAg4vZNcy6cKa1DOPIKMhM+/ztbNDfEkznyZ7xV7s4542PNMi2OfNU7FrAvNWnE/qcvIYwE3HUq
X-Gm-Message-State: AOJu0Yy1BJeOMpIFe5HjZ9VJ57P7gPveEfaLeMI0+SiT05RUOPDYJO5B
	wacYZKtgrOAjIr+/UpkiWx2HnQcUNDlponJ2Y7X7PPsxyCUVTx6VMdr1yh9Ir4s=
X-Google-Smtp-Source: AGHT+IEiYyQE2XqMzREHlUyEiPKioq2CGSV5hRAaWfX/NsFBCC2NDcK1MhjxwPAWZSfedX5fRDElog==
X-Received: by 2002:a81:ee05:0:b0:5ff:c4b9:be5f with SMTP id l5-20020a81ee05000000b005ffc4b9be5fmr1110569ywm.47.1709019720083;
        Mon, 26 Feb 2024 23:42:00 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id i184-20020a0dc6c1000000b00607e72b478csm1641612ywd.133.2024.02.26.23.41.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 23:41:59 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so3831045276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:41:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWs9/KR5wbBAPRjGvzYl/D+89/4Go3Br4QwTR0fYZRlNRQVeK3x4L7U/pd5g5PpoFNMgzrX3sRIwJEZPa3w3E+w72vslaMhUNzKV9aU
X-Received: by 2002:a25:aa47:0:b0:dcc:4cdc:e98e with SMTP id
 s65-20020a25aa47000000b00dcc4cdce98emr1469633ybi.5.1709019719163; Mon, 26 Feb
 2024 23:41:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com>
 <6bb3f88b-bf57-442a-8b46-cb4784dd4cab@roeck-us.net>
In-Reply-To: <6bb3f88b-bf57-442a-8b46-cb4784dd4cab@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 08:41:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYjw9CEBUzxuJ-10wudK_mvJZgqP3gR4kuv-FDYBZ-Aw@mail.gmail.com>
Message-ID: <CAMuHMdVYjw9CEBUzxuJ-10wudK_mvJZgqP3gR4kuv-FDYBZ-Aw@mail.gmail.com>
Subject: Re: Linux 6.8-rc6
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi G=C3=BCnter,

CC Kees

On Mon, Feb 26, 2024 at 6:52=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> stackinit
> ---------
>
> Seen with m68k:q800 emulation.
>
>     # test_char_array_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
>     Expected stackinit_range_contains(fill_start, fill_size, target_start=
, target_size) to be true, but is false
> stack fill missed target!? (fill 16 wide, target offset by -12)
>
>     # test_char_array_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
>     Expected stackinit_range_contains(fill_start, fill_size, target_start=
, target_size) to be true, but is false
> stack fill missed target!? (fill 16 wide, target offset by -12)
>
> Report:
> https://lore.kernel.org/lkml/a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-u=
s.net/

I don't think these have ever succeeded before, see
https://lore.kernel.org/all/CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFYAL4Tzv=
stFg@mail.gmail.com

> I suspect this may be caused by the test assuming that stack growth is
> downward, but I don't really understand the test well enough to be sure.
> I'll disable this set of tests for m68k going forward, so I am not going
> to report the problem again in the future.

On m68k, the stack does grow downward.
AFAIK only parisc has a stack that grows upward.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

