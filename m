Return-Path: <linux-kernel+bounces-29485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F32830F32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DD41C21F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A91E53F;
	Wed, 17 Jan 2024 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wkh2t6ld"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587D67C46
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530670; cv=none; b=CUcyYdMdcqpW9iHY8nrKWk0VW3i/5Vm+TxLG2S8Q81rwpa3oDMaOSqLuWEfItu75JwFlTMP1koJK4pGfgwaRU1NRtUh0JZj38k+MRMkanS/q48XpeAwfwKQtZY6pMqnH8Sq8PZnTiYLFsucLGUScu04N+mVnsLlmzbFVGyIFJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530670; c=relaxed/simple;
	bh=4f1kY/emerjctETgsSCrNxLIJQK/YvsfI/jXTSsl0T0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=GmI/FA1OwovFiFh7dYas8x1IOYGqXXc4fD913aXdy9BaghPCkCMK038mMRNjllvxFOR2LL5rsVH9CYFbenOWnv67qF6aZQXRUxzK8cPcfECsHXl3t5FkyHsPNZZGO8/yyHx5fvkZ/JdPwyHNNBmsq7PtGbsWA2LzPo4qYgAYYWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wkh2t6ld; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd64022164so141062301fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705530667; x=1706135467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a8gE34dI8NjsS8VJpR4MrnFRbqSC1FKg49JTFwcTQA=;
        b=Wkh2t6ldVf/+liRYk0qU2ungUtPlnW43vko/O7eQ1o13BUHlbeN+uCpw/6iWu9W7Ft
         c9H/S1/eG1zNp52Rvckrl/PrG+YekfZlZ5LZrJYdsWyx2qaqi+RLZiWJiEMmLF0OjFV4
         znT5piPUmjgwmBQjg/r5M6BV36FYNNEDgrXjPqPD1WjzDpTI8sFplhtfYq5Jt0+jzS9g
         KSKmwull7BYsJ/UN8k7LOBXbPW85KPt4Dd9w6qo4+CXJV80nfT59VlHchRsyG1YALSVF
         3akePkNtXdSc4fPhYRNEat61mvwIrZnZLzbDm6YWqYyDUPtMfQixCerGF3uYQC0SQqXi
         lm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705530667; x=1706135467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a8gE34dI8NjsS8VJpR4MrnFRbqSC1FKg49JTFwcTQA=;
        b=s6Cxr5/xoTixhbANsFBiqznbg1/Py1Xzv35xASlusn2er93xqjB7LE8bP3HICYzY8Z
         H4qPUWZQE18m+e0MGXgn2Gbnitb43rdpy5+FRvMnP1GHms/0gW+DBiPuwbrVh5wwni0p
         PUgFE3BQGETMBBqQ5vh5PROLki09z0/cg8YPlOxmRgwSUAKBp06S5dNDKz9ZvcN0KV1z
         V11oB72VPYBEU4NGT9zvNarYTkhafe79NJNZBA4ns6DvSfKNJVdzLFy2hHd4QEmIFV1Q
         2u9LMIBHEcQiyv9W9QlNfyF5+wIu/6y+JGo85rnoqTV+9KUOTpwHpZAxb6HUXG3FpUAB
         /rZQ==
X-Gm-Message-State: AOJu0Yyayu2TjMIaTf0/a3xo01+m1VeHmNhpUvr3jRNE4J0724JhtpRy
	ABGEMY1zEaSpNWP8eobUIMPvtp12fBbeD0q0f8I=
X-Google-Smtp-Source: AGHT+IEC0dHEU4nW63HZAJc0VM1jINZca/1hbU7qXUWueU3WQ5qrUC+BSpDXSgfuETv/2Q5B9+8n3nC22QHCedHgNzs=
X-Received: by 2002:a2e:a49a:0:b0:2cd:2cb2:8ea9 with SMTP id
 h26-20020a2ea49a000000b002cd2cb28ea9mr4831144lji.90.1705530666957; Wed, 17
 Jan 2024 14:31:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116234901.3238852-1-avagin@google.com> <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
In-Reply-To: <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 17 Jan 2024 14:30:55 -0800
Message-ID: <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andrei Vagin <avagin@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:34=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> .. adding LKML.  More context here:
>
> https://lore.kernel.org/all/20240116234901.3238852-1-avagin@google.com/
>
> On 1/16/24 15:49, Andrei Vagin wrote:
> > +     /* xstate_size has to fit all requested components. */
> > +     if (fx_sw->xstate_size !=3D fpstate->user_size) {
> > +             int min_xstate_size =3D
> > +                     xstate_calculate_size(fx_sw->xfeatures, false);
> > +
> > +             if (min_xstate_size < 0 ||
> > +                 fx_sw->xstate_size < min_xstate_size ||
> > +                 fx_sw->xstate_size > fpstate->user_size)
> > +                     goto setfx;
> > +     }
>
> The bug here is that the buffer from userspace is garbage and the (XSAVE
> XSTATE_BV) metadata doesn't match the size of the buffer.  Right?

right

>
> This proposed fix just checks another piece of user-supplied metadata
> instead: fx_sw->xstate_size.
>
> Can't userspace just provide more bad data there and end up with the
> same problem?

It can't... I would not post this change if I thought otherwise...

>
> Seems like the real problem here is that the fault_in_readable() doesn't
> match the XRSTOR.  It's going to continue to be a problem as long as we
> don't know what memory XRSTOR tried to access.  We can try all day long
> to precalculate what XRSTOR _will_ do, but that seems a bit silly

I don't understand this part. The behavior of XRSTOR is well-defined
by CPU specifications, allowing us to easily precalculate the memory it
will attempt to access. What does it mean "we don't know what memory
XRSTOR tried to access"?

xrstor restores only features that are set in fx_sw->xfeatures.

> because the CPU knows where the fault happened.  It told us in CR2 and
> all we have to do is plumb that back to fault_in_readable().

I considered this option as well, but then I decided that this approach
is better. The most important aspect is that it always rejects bad
buffers, allowing a user space to detect an issue even when a fault
isn't triggered. I believe proper handling of xrstor page faults could
be a valuable additional improvement to this change. If we detect a
fault outside of a provided buffer, we can print a warning to signal
that check_xstate_in_sigframe is incomplete.

>
> It would take a little XSTATE_OP() munging to pass something back other
> than 'err', but that doesn't seem insurmountable.
>
> Anybody have better ideas?
>

