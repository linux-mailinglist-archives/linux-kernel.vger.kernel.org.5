Return-Path: <linux-kernel+bounces-63263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B2852D00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EADB272A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E2250F6;
	Tue, 13 Feb 2024 09:48:13 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9162375F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817692; cv=none; b=SLe6AbSgdRC4A1YY8hkcQtHdbNfS1fWq5fIFHSDi8wldzhThF6DO7sEzkfzjuEaiP6jApbRP1nMmTiKIyqfQczwjxuC3YMEZQw5gwjfSGAVUg4EPKiJmW3Oj5dFfXeFylHnNPhOCnqJf2EHtIgDq+0Q31fVu3zHwIGG+IFszSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817692; c=relaxed/simple;
	bh=8AK3cgx3MUVUYDzTDSdES6qOJwGDLNZ5wrsqdVzP8Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IuPnusP9s8kdQkkxkJyHR0uRN/6VTscw46UwKrmpLnb9/+0GZSzhmof5D1O2LAHNT65bRuJDA0aRdP7Goulbw+toQXpXQonMYOtXLQm54XfBrxMbnfWXn0HWyqxuSwFbAFz6abQ3H+m013ADArJ9iftVnSX/vDzWIeEVUljAesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60778d7b02bso12106807b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817687; x=1708422487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1CaRShlNFED4/8VznKN1KNzTk/U5YKiI8Uuiz6aLE4=;
        b=e+EG26xzvqbIkcGJQgB+ZF20DjuN3NHZcwmVYSq8iLItW6ulcCM0G1bdModP3mK6oK
         bG2Kq5F0UlRI8ggrMBCSBvzLAMMve74zhm9CYrYD/cvcLQCBtxBD6ARitm5jI320Wtvc
         8qAmCp5EB8XqI2D/XjRo6H/DRVKozLh3inMYkzOnAt3Bj1n+foCakIFYOLN5BtgJ/ins
         9eWyVfmvnB8al15Vc3OUyqNILY+8rp/Ms6ufKFmfjBu76RyVPr1WZZvAve75ytEt+qxI
         PIWRkyDlzMp/GBtrEArcTOu8LzzpaIMKXXpWh7OjQ5MYkZxkq+WpZpyaLTNR9HXaaE1w
         sdUQ==
X-Gm-Message-State: AOJu0Yzua8wyjnQ//t0bvGfhhEzcsiai38n1yyX/GqNk3U6SQeBM4HUx
	7dOaqlev9DbM77kP0P/RpSk++JfWOCSzc2Ek1kAXguOm99IP8lParG+Rk+eBKHA=
X-Google-Smtp-Source: AGHT+IHUuGIk9MDPzGstYLK1zpkt2QbjTfRrwv2RqiahCvh88IzUqgJcWfJL52ufKQ1RpV3Cg6uZUg==
X-Received: by 2002:a81:4fcc:0:b0:607:8472:f33d with SMTP id d195-20020a814fcc000000b006078472f33dmr1104920ywb.25.1707817687672;
        Tue, 13 Feb 2024 01:48:07 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id w184-20020a817bc1000000b0060493d50392sm1640828ywc.103.2024.02.13.01.48.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 01:48:07 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso1310685276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:48:07 -0800 (PST)
X-Received: by 2002:a25:6606:0:b0:dc6:b779:7887 with SMTP id
 a6-20020a256606000000b00dc6b7797887mr6918280ybc.20.1707817686859; Tue, 13 Feb
 2024 01:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Feb 2024 10:47:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-JXjXmd5yan0-on52oH1dbRg1=N9OL2C7FAhLaOsTgQ@mail.gmail.com>
Message-ID: <CAMuHMdV-JXjXmd5yan0-on52oH1dbRg1=N9OL2C7FAhLaOsTgQ@mail.gmail.com>
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org, 
	torvalds@linux-foundation.org, paulmck@kernel.org, akpm@linux-foundation.org, 
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org, 
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com, 
	bristot@kernel.org, mathieu.desnoyers@efficios.com, 
	glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com, 
	mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org, 
	David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, 
	bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, 
	konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ankur,

On Tue, Feb 13, 2024 at 6:56=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
> This series adds a new scheduling model PREEMPT_AUTO, which like
> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> on explicit preemption points for the voluntary models.

Thanks for your series!

Can you please reduce the CC list for future submissions?
It is always a good idea to have a closer look at the output of
scripts/get_maintainer.pl, and edit it manually. There is usually no
need to include everyone who ever contributed a tiny change to one of
the affected files.

Thanks again!

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

