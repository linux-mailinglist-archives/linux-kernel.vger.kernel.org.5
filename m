Return-Path: <linux-kernel+bounces-117591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB7E88ACFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5071C3F42D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19C128384;
	Mon, 25 Mar 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtYmhioa"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD941A85;
	Mon, 25 Mar 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387549; cv=none; b=Zye1U0jJy/9HvEHL7gdfJWGKCYaWU1nXk2Mz2hPImbq72EQJCvgXPwCn8UKakjL8GGHXO82R19D1spD/e8klbDNrPl8XJ8/XtRqErLys8TujTMykv7NkseG+tFjFcg+qsrYNh4jV4vOB9iw++16371t84bAA+61VBBFfN0rY/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387549; c=relaxed/simple;
	bh=nD6YpLKIKyKX/YCgn48Bw5AnmNM9aAFjepz6Uc1FLsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCdcrE2PwoIKOXci2BGCaZzxDvsJfESYkZ6eKWJ1cFvL/G+NzoYxaFZYPTbwewTeDxNQho9oltV7sXdn6yz2zAOdNTOIonGIqHiIB9GhburUAt1RiQ4XpjKBhdiH/NSJIEVBo28ljsiyIppNYVWCgipGNSip4Hm9rFUd8yk4/Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtYmhioa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1deffa23bb9so34413995ad.2;
        Mon, 25 Mar 2024 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711387547; x=1711992347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oXjJdG3y0f1e4IsMhRsRfdRWQRoTf6NEQ0J4KitWFc=;
        b=CtYmhioabJ++KhhbMIRwEZ4t6+ij9zWxVCBDvQOMvpX+VSMaSIMYmGnXwGKiOmUGlo
         WqKkIaZLD+HUQ33m0qXJrUiFr/T5nkpaHWJNDACssGQrXEd+FQ/QAVoQhJtTWRoTmBWr
         Z23KyPkQLGqU0snmQiUlZ4PViSHrlbORG+eyoyp6nXNs9O2UGqEDz1JL8t/0P+hSQilD
         C9gfZcARP0mrs1k+xbH7b0YfKVpJ1EVHuMij1EuiZV+WPGbX98y6udT9FU000EUaDaIz
         HgBkjaAfxphtAhIRS0sLFyQL1zKsfq0/RWdWpoaPiEZXExEhMGrksX6CBZ2JwD2XwCDl
         E0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387547; x=1711992347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0oXjJdG3y0f1e4IsMhRsRfdRWQRoTf6NEQ0J4KitWFc=;
        b=Ch2z6NhV/KORjauTNtA34EA1/WtxckZJf/hJHnOxoJYSNnImr1ChfIjIRu8KGkD57s
         uNKKh7+V+eyl7hnyGfKXz0ca9RVejQ5leVWla2Gm87UtXOnUI1RcWXqLqZ4yjQshJ8Hm
         LqJM9tOY+AXbMExMoRdz+wnupfUlEnjSOEGjTWoRnS8p76oTTn7PTpYokInDjtgZtIf9
         NaBPSipdCTpp9rHVZqWa4HiZyYOXr+13v+vhHrC41qrCduwV5hX6ACIlgRcyYd9e2Ze+
         Nkw/FD82dzjrNSFgYbffirX1qwZgmBwrf93zM3K5raIU8858ilz/OX9hO3mkDPGFZA/R
         9QVw==
X-Forwarded-Encrypted: i=1; AJvYcCWWDWdGbw+Lyj2KQ8/pflMDDkyt3uaK/sv75K8IfPiOG1E8dveEcMQLEDRZ+5OkLUQDLMsuITEdaV+RjmsfS9VORwqvZi91wXaAoW7Objn938aVyOY3d3HMy9n0nJF7AvZ0
X-Gm-Message-State: AOJu0YxrAS78xVtuWMReoEKYqD89L841wthN9bljr5FoKVlsBFImBiBk
	mLelcCHQbaqRCCD0DknbyxThQTU1QRt2cUVALjpvWlhZpD2CBJLP4n+IF0JmRYNJyA1h5LgQLyo
	vYjHn4Vac8ws1A/qMoePRVtm8Y78=
X-Google-Smtp-Source: AGHT+IF8bTjfMse3lUz7pNVDa0X5Q9LzATh/o0DmJjx4kBFyMsHQQS9w9NS3df5X75Qm/+KgG8xG2BMO1d5YqAWLd3M=
X-Received: by 2002:a17:902:c115:b0:1e0:58e:88a8 with SMTP id
 21-20020a170902c11500b001e0058e88a8mr9460071pli.52.1711387547251; Mon, 25 Mar
 2024 10:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325154737.3754820-1-chen.dylane@gmail.com>
In-Reply-To: <20240325154737.3754820-1-chen.dylane@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 10:25:34 -0700
Message-ID: <CAEf4Bzag72gYXWJ2+mPnWaysyTK0OC3NjnasxNsb+N0NxXY2fw@mail.gmail.com>
Subject: Re: [RFC PATCH] libbpf: Add bpf_program__set_section_name api
To: Tao Chen <chen.dylane@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 8:48=E2=80=AFAM Tao Chen <chen.dylane@gmail.com> wr=
ote:
>
> The new api can be used to reset the function we want to trace in
> runtime. So we need not to change the code again when we just do
> minor changes to the trace function in kprobe or other ebpf event
> type. We can replace the old section with new section passed in via
> parameter. Maybe the following scenario we can use the api:
>
> 1. solve "*.isra.o" issue caused by compiler in new kernel
> obj =3D offcputime_bpf__open();
> bpf_program__set_section_name(*(obj->skeleton->obj),
> "kprobe/finish_task_switch", "kprobe/finish_task_switch.isra.0");
>
> 2. dynamic adjustment for trace function offset
> obj =3D offcputime_bpf__open();
> bpf_program__set_section_name(*(obj->skeleton->obj),
> "kprobe/finish_task_switch+23", "kprobe/finish_task_switch+45");
>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c   | 24 ++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 27 insertions(+)
>

This is a wrong approach. SEC() is immutable and serves as a hint to
libbpf on program type and possibly some attach parameters. But after
that libbpf allows to override all of them though APIs like
bpf_program__set_type() and others. Attach APIs always allow to
specify all the target parameters, including kprobe function name and
so on.

Please check all of the libbpf APIs in libbpf.h.

pw-bot: cr

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 96ff1aa4bf6a..94f32e845c61 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8576,6 +8576,30 @@ const char *bpf_program__section_name(const struct=
 bpf_program *prog)
>         return prog->sec_name;
>  }
>

[...]

