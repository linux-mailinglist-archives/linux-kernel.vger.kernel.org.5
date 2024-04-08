Return-Path: <linux-kernel+bounces-135606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDDA89C850
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1845D2867AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421F1420D4;
	Mon,  8 Apr 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7i0wLNY"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE331419A9;
	Mon,  8 Apr 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590267; cv=none; b=Xafd7UbciFuyBBFoMmH8npYbiToAoAIyKsCrbspIvKuovB99Fk9Ws6btNxD2vDPOGJUNI8QlPxUiufl0iSxl+R8GDhYC0OINaZYo7iq72XZj01SLlMx/ilVRnmNUYbEOcfDd9NeyOQXPRpC57xzes0qDdo8AikJ+WGDjjeje4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590267; c=relaxed/simple;
	bh=+z2w7i+pXbMoc2p8XQel83YU0QDWMIDOLJeexi/+aJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOhUELkVlOV7NDDHVyTrCjc6JkH2fPld3sPfBFO/8PyCDWrnSrCuFQLVpRUOEfPSvAqTC6dEkh0D5a4vLOeQ7zfSxcDRUdmlNa6zTusevqu6qmABPRVe89xOOiAssOlHQnlZzPBX66xY6PR9I1x8FRGI+YU23VLWLHRmQ0ejmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7i0wLNY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso5197188a12.0;
        Mon, 08 Apr 2024 08:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712590263; x=1713195063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+z2w7i+pXbMoc2p8XQel83YU0QDWMIDOLJeexi/+aJA=;
        b=Y7i0wLNYXDZ6xQmNyv4EuR4je9bcJMN+lJ8QCd0oZqS9VdRDHYiU3q0hvXsWzDChjA
         Xgb1OMo3ZMecxivfALR1jaoRTLzpC4LSg1dB0beV/EenT9skoNHuAe655unXoxW0dnC+
         FPRQHwkIBI5wJTXuhIZLs+NozdoxwTPV48G/c+xyROBlsMgqvuy0YV5Uv6vG6IYq9W1h
         TZKL+bkmk+/gtbNe+0XwRVB5fL+n8pI53DdPuRklgkUPlobBWgvqmZiqyC3ilVZLIpUf
         HwP6mWI+pndI4cY1NAMQMnbYj+GNSMQosul/kA3mdMEaVOWfE7cLM49uWttgCyBjeGOE
         9vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590263; x=1713195063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+z2w7i+pXbMoc2p8XQel83YU0QDWMIDOLJeexi/+aJA=;
        b=Xpp8onWWaEyfI00lCTrBAT+1xMF5fnJ72DWYAWqEMNjfxE3uus3Jsw84wXjS4jMIT8
         NaS9UGldcll5FsQcUi6oA07z8f4SmQK+8zOEAhqDHYpuW9dBzIzESwYGMqKLGVjLbZJv
         2iKgHGjD0uavLQXDn+RV8rG078u2pChGpNYBGyWxiKkY+riXEMeXVcLhI6wxUnfGDwUl
         yVAIWI4hE5SCdG+o2wapbydRUdDk9oNmYdNyzgH4+knzyMh0npGIJtBfjT6qIbRbAwSZ
         giTl4FBhCOwW90QnlYkGKbG3I8FVYA+N9xgJeuv7wO8mFr7ms5spBzGxdXuKYnX+Wita
         jqEA==
X-Forwarded-Encrypted: i=1; AJvYcCU2/HZeOgT6W2LNv/fmic7tZV11wIJnxZ33lq95UhuHrCxnnROp9ouZmmDZKZz1tLiId//ffAIrzoXXYCivlkUPPpIzUXSXIOzszvCzXMVSNJxE6TRGoU8L5tQD5EuH2qAX+QOjrJ5P/taG/6w=
X-Gm-Message-State: AOJu0YyFhYWq5jJw+yk77obnpWxKwxGSf9XYrtMHfqnrFE6rwtVEKwit
	HXoHhVwJGao+LrVsAFdpDBR1mDkG0vBcYz/9sVQdX6ZiWws+eiVNHu8EJAYk4zL4p8iOGfsC9im
	UnkuYwsniL2gQqQE5IzrJTKFduwo=
X-Google-Smtp-Source: AGHT+IE24hOKRWtdyRnN5kV7dEx7IzpFfbNgFzIQKfPkyq+EWHkDQFobfa/zb1BfIbF5hqyJuyd4swQMFiZdMr3WRS8=
X-Received: by 2002:a50:9fca:0:b0:56b:c4ad:ae29 with SMTP id
 c68-20020a509fca000000b0056bc4adae29mr7698934edf.3.1712590263281; Mon, 08 Apr
 2024 08:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72meap5C9bkj5rNDE=0U5gb5OKwDrrTSrVRwJbkAPWgUsg@mail.gmail.com>
 <d912f0e0-19d5-4cde-a548-10db94da15a9@yahoo.de> <CAA76j92Sd-YN=UYET7jyMyBuzyhET+rwqF-Rxo-0S_60+TUX1Q@mail.gmail.com>
In-Reply-To: <CAA76j92Sd-YN=UYET7jyMyBuzyhET+rwqF-Rxo-0S_60+TUX1Q@mail.gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Mon, 8 Apr 2024 17:30:24 +0200
Message-ID: <CAA76j90Vw+kdaqJa23S=6-vo7XG2jjK4rgSk2BXQeVJCpch0iQ@mail.gmail.com>
Subject: Re: [PATCH] x86/insn_decoder_test: allow longer symbol-names
To: david@readahead.eu
Cc: miguel.ojeda.sandonis@gmail.com, tglx@linutronix.de, x86@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	davidgow@google.com, hpa@zytor.com, john.m.baublitz@gmail.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@kernel.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <danilokrummrich@yahoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David,

 Do you mind if we push the fix you proposed?

Best regards,
 Sergio

On Mon, 8 Apr 2024 at 17:22, Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> Hello,
>
> I was just waiting in case there was feedback from David Rheinsberg.
>
> Cheers!
>
> On Mon, 8 Apr 2024 at 14:52, Danilo Krummrich <danilokrummrich@yahoo.de> =
wrote:
> >
> > On 2/20/24 18:07, Miguel Ojeda wrote:
> > >
> > > On Fri, Jan 27, 2023 at 11:39=E2=80=AFAM David Rheinsberg <david@read=
ahead.eu> wrote:
> > >>
> > >> The current workaround is to just disable CONFIG_X86_DECODER_SELFTES=
T, which I thought is a sad state. I can gladly use `256 + KSYM_NAME_LEN` a=
nd add a comment ala "room for insn-encoding and a symbol name". Would that=
 be acceptable? The alternative would be to try to dyn-alloc a buffer and i=
ncrease it to the actual line-length?
> > >
> > > John independently hit this issue again. Could we fix this? Going for
> > > the `256 + KSYM_NAME_LEN` sounds good enough for the moment since it
> > > would be a clear improvement, though I agree this could be cleaned up
> > > further.
> >
> > I hit this independently as well. Miguel pointed me on this mail thread
> > when I sent another fix for this in [1].
> >
> > >
> > > Sergio took the approach David suggested in a related patch [1], but
> > > perhaps it is best to submit the fix on its own so that it is easier
> > > to put it in. David, would you be so kind as to submit a v2 with that=
?
> > > Hopefully x86 can pick it up, otherwise with an Acked-by I am happy t=
o
> > > take it too; and then Sergio can submit his patch on top again.
> >
> > Sergio, David: Do you intend to follow up on this? Otherwise, I can als=
o
> > pick this up and re-submit.
> >
> > - Danilo
> >
> > >
> > > Thanks!
> > >
> > > (Cc'ing also Masami who wrote this originally)
> > >
> > > [1] https://lore.kernel.org/rust-for-linux/20231119180145.157455-1-se=
rgio.collado@gmail.com/
> > >
> > > Cheers,
> > > Miguel
> >
> > [1] https://lore.kernel.org/rust-for-linux/20240325174924.95899-2-dakr@=
redhat.com/

