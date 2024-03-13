Return-Path: <linux-kernel+bounces-102270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6B87B00B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C5328A2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FD212A161;
	Wed, 13 Mar 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj7zaRI5"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B551021;
	Wed, 13 Mar 2024 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351223; cv=none; b=pAAW42x6CH2exDGDNHsmKZa5At3sGX9P2UyVsRpE7vR268eL9kXQIps3BDVwkzREyW/RiHgzjz59sMBPn63LULDdMYcQLITlej3oFaIIqNUspexNgjr36HjMKMXGWBi1/AClY9nEDob/S5iXK0+YSVQzQJCma1qiYqaV0OgauZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351223; c=relaxed/simple;
	bh=t/meYn2//gmVYkp7P0vow+AvSYr+P2IoQgUqP9xrrMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s82G+ZAYWd9hQUW/50RX+wJzPBTJdO3d7Hn0ia4We3/zU9nLnJuO0F1r0sJfZ84KGTbspD2aLu0VYqOxhkjfCjDIgpbjtPlfsiwXhodBt2kiFycW9dtu7gq01YRwg/ZZOVbL5BKoUs6L6bAGyVpyTKfCKwMiNSdfyUNNGZYddo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj7zaRI5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce2aada130so49237a12.1;
        Wed, 13 Mar 2024 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351221; x=1710956021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44Vskwsk5gQiVM0kOdLBvtJVlmH+VOeRs73HeGYck7g=;
        b=Hj7zaRI5dR9tsiv1bpGz4x4iHDhnAkMKkTirfN9RVw6fYvY45WQnWXNmkv0LiXwvjk
         8Pyz/t8lUYXx6WxaKWbgTG1045QTCN8eeZ7tpok/NJ2LxLGxE2fQZxEn54roSw8/f3JK
         VDq4vahLksp/USDzxMP5ASZorZlgSQ0Vk2xz6A/k4BIL54QIP5bBuWn3Nvx6uc0KgWLg
         3+hqB1e1XvIdE6K9B1n8QB41Myu4Fo0uvGFQ9E/ur4eoqd9gnDYdpOf+bxe5J7HQ7dRB
         +63Xzc6SGtlLhKEap8P0aO94uLDH3WITijB2nS5VSnVIxRjA4Lrv7iEFhuqiY/PalRUV
         Xzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351221; x=1710956021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44Vskwsk5gQiVM0kOdLBvtJVlmH+VOeRs73HeGYck7g=;
        b=NemlnW7fxuZVoBp+993q2Umbxrq0WTpbRMcgVVx6ObIr+sq5KfqS/EyllZkfDvpA4C
         XTuBlmUD1wg5CHFscSqTkNNAxKk++d1lWCtecNAg+WanaFrR1+ovFXzRsvnCkxFxAyVA
         Rp3AYVYxjrO1LfKGk+/LFmX7v0MD8f/mwHCYCS49QrWFnGa2GcyIYTUmv0hzvAidDIuR
         lC7J2pGDt4lMVcN8OjTsrA1NaPScvbuE3EffFlggoccLZiDHuHHUsJsoBJnD35CD96nY
         5RZctM4Nzd7MPwSkADgOrbIvGyD/OhBB+rWrfDgChOoMVBK7P2sMmMDbz6K/yjBD6P07
         v3/w==
X-Forwarded-Encrypted: i=1; AJvYcCVqev5uUNlE2tlGaATKMiRBZRr6nMeY6Uyb679iukqa/QW1nPNXD+lQ6H2AHZ3c3dVKVPVSd4NX+ABoL9+a3nMhIB2vn20cqYEO+sD4gbQqzQFdPav35qiJ1Z62E1g0nKSCLMMS3AmeWz3k/e1Pbt6F3n0ozh7z9+9vd0A7xf4fy5lux+nB
X-Gm-Message-State: AOJu0Yy3w9mDBbCrPWCOC2vSv0RC2FJ5slfWqYaFFKdNQbFjeNNALwA2
	JWEhOqkyQYP8oRdQnULGkwxuu5q+69SG9SNrpT+2hdsLizT27o0eXRljdCwdjYRGDFjdyAQB7LC
	1Xl+aF8jbQNEtLxzRxumBHRv/iRQ=
X-Google-Smtp-Source: AGHT+IEbz15QjLVfbB/SxHmwa0IZioDlMthks84TvTvC9JdJERJmGOLeEMSPc1KUYOHSA48kWjfeKPg91JLDCX1+DNo=
X-Received: by 2002:a17:90a:c386:b0:29c:7170:fa33 with SMTP id
 h6-20020a17090ac38600b0029c7170fa33mr925284pjt.29.1710351220723; Wed, 13 Mar
 2024 10:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312210233.1941599-1-andrii@kernel.org> <ZfF02HCzYLcuwmw9@krava>
In-Reply-To: <ZfF02HCzYLcuwmw9@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Mar 2024 10:33:28 -0700
Message-ID: <CAEf4BzaSy8wcuqmi6UqeH-UV8Kf4J_67TfP49Z334LmXrxoFpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] uprobes: two common case speed ups
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 2:41=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Mar 12, 2024 at 02:02:30PM -0700, Andrii Nakryiko wrote:
> > This patch set implements two speed ups for uprobe/uretprobe runtime ex=
ecution
> > path for some common scenarios: BPF-only uprobes (patches #1 and #2) an=
d
> > system-wide (non-PID-specific) uprobes (patch #3). Please see individua=
l
> > patches for details.
> >
> > Given I haven't worked with uprobe code before, I'm unfamiliar with
> > conventions in this subsystem, including which kernel tree patches shou=
ld be
> > sent to. For now I based all the changes on top of bpf-next/master, whi=
ch is
> > where I tested and benchmarked everything anyways. Please advise what s=
hould
> > I use as a base for subsequent revision. Thanks.

Steven, Masami,

Is this the kind of patches that should go through your tree(s)? Or
you'd be fine with this going through bpf-next? I'd appreciate the
link to the specific GIT repo I should use as a base in the former
case, thank you!

> >
> > Andrii Nakryiko (3):
> >   uprobes: encapsulate preparation of uprobe args buffer
> >   uprobes: prepare uprobe args buffer lazily
> >   uprobes: add speculative lockless system-wide uprobe filter check
>
> nice cleanup and speed up, lgtm
>
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
>
> jirka
>
> >
> >  kernel/trace/trace_uprobe.c | 103 ++++++++++++++++++++++--------------
> >  1 file changed, 63 insertions(+), 40 deletions(-)
> >
> > --
> > 2.43.0
> >
> >

