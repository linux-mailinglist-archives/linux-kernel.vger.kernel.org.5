Return-Path: <linux-kernel+bounces-127286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F49789493F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EB5286811
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2DBE552;
	Tue,  2 Apr 2024 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZgvwutw"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502433201;
	Tue,  2 Apr 2024 02:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024229; cv=none; b=gKcZ7PO3gg3eHQrjcnqQq2ASM674UYMbG+L5OlnOhgi+CuQjoecFHAIs9kWDqFysLs0zgPxS+czVVeCoegzWa/VAkp4/A7ILV4KJIBP5uPJqTBpcLUTyrBjeHS6O4YJOtgVfwTl62AyEZq84ol/awrfwnzCnTxOUVdVeiQdyR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024229; c=relaxed/simple;
	bh=Ef4kssK340Juz37nU0tCDhC7KCfbmR7SgP+Es/VKnnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agvNq+Eo0AsBYFp27pXfXj8Zy6r98Z58553kztiYHX3wvvW8m9gOe4XNrCCs/6PDiahtkI8WQ/vHxzsQ+ROfcOX9SUA2V7AfKkUSqnWPPi8KC4G52XTVLtXiBUdDEg+27fEUwiwfPQbbhSiwOkIhIXTiRAlKzjtLEdH3fzq6Qns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZgvwutw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3026786a12.0;
        Mon, 01 Apr 2024 19:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712024228; x=1712629028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URVVc+oj5g9wwvSmWmTYuTJD0GkL7MWxP8pYMy4NH+k=;
        b=fZgvwutwtGKRzxC951BHpTSg5dScGt/ufHWokNCom361JS/0HKjlqtcW3s88A8oA0i
         YcIcG+Qbfv1tKJfsVtxL8danyl4lL4LxZ0EcYWcks1S9df1dB3LwRhV/twK+eV6W2x/C
         eq5/7x40gPC5L3FoB2k889xL/kwGZdWWdaaqkgqw4xh4f1EL/ftR3XD77ZIkPP69NiB6
         Bv5+KT1GZKZwNfAZRzMjOi7tkrvsp8f2hTcP6ydQi1DQML/fe5kNsHNL+gtTDYveXF37
         I4IxPpvTinVVLgyPohsiMtnvagyulQdrRL2dQv7VXYelJOtMDLF93C3/Cv4JR81nL75E
         3z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712024228; x=1712629028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URVVc+oj5g9wwvSmWmTYuTJD0GkL7MWxP8pYMy4NH+k=;
        b=oe1LpmTQlJZQ+Y8Hzqq2cRz3ZVF2xIdXd/xDEQ8fMpWmlS7NwhA9hbirxbJfxtC9Tc
         WgoUmRMPG5jfBS8tujguO5qMf8ajNkR/0EInMvPCLSbR652arEvmU9JHjUIQmKMOjzlQ
         YR21LKx3ORjWehESUpkrWJFKaLhVXPsFFYT2xaEGrUqng4ANf875uwCMldanlvEa0Aq/
         K2sZfzXKFp/6T1E6TiBUIvKrvphCAEeFTYWh9C3XewpQXutNRcu985o7jLf9HTWUft+8
         XCB00iUPGvYjpXU7Z3/djFaG0jDn24ncwNiY82nh/sZJMH8SyzZptac99/2ql5W7d7LB
         Xobw==
X-Forwarded-Encrypted: i=1; AJvYcCXIV7acRmRmu7kqXWf4Uu/uTRz58XfK6+KwG8z6+ycnY8UtZQVcQDq8nNDTjL0OOzPCUIkFDy5HeXb/X1dDCgj2Bfw2I2uDhZMZICpExKoPuZBBii5An62L62WiKdziFJWR
X-Gm-Message-State: AOJu0YxEejI2vwe19yjwUWJ0vfJT2naScbIl7nbiobkYIo7GZAjgOjnX
	2eTvuaRNj9G2WjIaipjbFZ16g9lFV8dn3f0RCQ/7AmUe9O6RUYgpf8v3zszNDqQ/EWHFrNPXouz
	1a2FiFXumsuKW1dOwTzgPUpyRDfw=
X-Google-Smtp-Source: AGHT+IGjFUVYJIhBOaBO7LOPtsB5/sVQWnavSwk4JClD2bCho5E1n2FAecy6M0qBPFMrkDFRcgm33JaLWQpvFM5si+c=
X-Received: by 2002:a05:6a20:3cac:b0:1a1:67a6:bba7 with SMTP id
 b44-20020a056a203cac00b001a167a6bba7mr14283456pzj.1.1712024227652; Mon, 01
 Apr 2024 19:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331041830.2806741-1-andrii@kernel.org> <Zgp+lYLOZU3OkO7w@gmail.com>
In-Reply-To: <Zgp+lYLOZU3OkO7w@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Apr 2024 19:16:55 -0700
Message-ID: <CAEf4BzZEuDRt=dLN79uJ0EwQcxuxCp8LZx1ayNBsw82BytPTqg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] perf/x86/amd: add LBR capture support outside of
 hardware events
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@linutronix.de, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:30=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Add AMD-specific implementation of perf_snapshot_branch_stack static ca=
ll that
> > allows LBR capture from arbitrary points in the kernel. This is utilize=
d by
> > BPF programs. See patch #3 for all the details.
> >
> > Patches #1 and #2 are preparatory steps to ensure LBR freezing is compl=
etely
> > inlined and have no branches, to minimize LBR snapshot contamination.
> >
> > Patch #4 removes an artificial restriction on perf events with LBR enab=
led.
> >
> > Andrii Nakryiko (4):
> >   perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
> >   perf/x86/amd: avoid taking branches before disabling LBR
> >   perf/x86/amd: support capturing LBR from software events
> >   perf/x86/amd: don't reject non-sampling events with configured LBR
> >
> >  arch/x86/events/amd/core.c   | 37 +++++++++++++++++++++++++++++++++++-
> >  arch/x86/events/amd/lbr.c    | 11 +----------
> >  arch/x86/events/perf_event.h | 11 +++++++++++
> >  3 files changed, 48 insertions(+), 11 deletions(-)
>
> So there's a new conflict with patch #2, probably due to interaction
> with this recent fix that is now upstream:
>
>    598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")
>
> I don't think it should change the logic of the snapshot feature
> materially, X86_FEATURE_AMD_LBR_PMC_FREEZE should be orthogonal to it,
> as the LBR snapshot isn't taken from a PMI.
>

Yep, seems like there was a parallel change to related code in
perf/urgent branch. And yes, you are right that it's orthogonal and
doesn't regress anything as far as branching and whatnot (just
retested everything on real hardware). So I've rebased my patches on
top of perf/urgent, will send v5 momentarily. Sorry for an extra round
on this.

> Thanks,
>
>         Ingo

