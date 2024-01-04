Return-Path: <linux-kernel+bounces-16981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD18246CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AA42B21A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9499625567;
	Thu,  4 Jan 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPyPUwYD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2425550
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso15328a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704387613; x=1704992413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7Lsys18+QLbhvJo1oU17jTxhs7Vm21Mssqg/1v1e8M=;
        b=UPyPUwYDHRz3UeQOl06v8Wh2TXQ4J0eOlFGWxJ7FcwwI5FMFoMpChsB9GpXzbQJnH1
         3MgVtOJwFoiAnhE8gizlVjfzBNOXnuaWU1FcU3L/lx67Qpxcci1ieTqoBFb4XZ0Ehk+P
         /kMg6PmppHUQafYUxgBn9yiHKLiriJKP1UqVLFpWYNNSauZlYaC4u9XBaTeh34eUrJhk
         rFo6rrN/GW1o2dbhCbiSbytRKpEapOZk3YRCh+HqKtxUS3EqL3GTA00AmVghuYQNsSh8
         jE71XB8s5wlHmjGPJ496w/0KTXVcEZN524wRwus93qFRGEeLoVNTSIGhrPFv5W8d+MOx
         /7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704387613; x=1704992413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7Lsys18+QLbhvJo1oU17jTxhs7Vm21Mssqg/1v1e8M=;
        b=N18qRH5LTly30u0SB6MCCibYJ7UFNYdvNmph+eTQa2RAYGe+7VsGBR9KSPVYfc254N
         vpFZiTaO75StecnYcTJ+ns5CIvQuMZ6nrJn0iwWtlU6GdNpd47Gq4eHCBoZlpiczxqyj
         KPf/utB0+Cl9/zoT5AlqHA7nvTdsbeE1F+KAD+AnulPU0nzZIUV1ovTG4/1P/KinRyu3
         I2SDZgGN6QyjFwa7q9cckrxsisM6Xa/GzK3PIpOAme7s8pyPsr5zGXRSUbFCGbUK8WLh
         N0awoqeYTKWxDSc1wc5DQzwUIHH0Bla549owJMNZG2leGLvSrFRvLDkqUv7RPu6S4Bfj
         7IVA==
X-Gm-Message-State: AOJu0YztFLMqHDfDcg27nrYPqKcPS8JzAnLDNsi9NVac8k+AvF92NCsL
	kVjJptyBkW0RHAUBU5iffNu0ixLcHltx5Bgp24VYMW9enhWg
X-Google-Smtp-Source: AGHT+IEzAZ1C3OXPfozmVxB3Da5JUcONDXK9BVnWIsu7ZNrjTLNyOitGTs6zenk+rMuCVsOMniS0jdk+cPetZBH3AYk=
X-Received: by 2002:a50:9ece:0:b0:554:2501:cc8e with SMTP id
 a72-20020a509ece000000b005542501cc8emr366378edf.6.1704387613291; Thu, 04 Jan
 2024 09:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-tcp_hash_fail-logs-v1-1-ff3e1f6f9e72@arista.com>
 <20240104075742.71e4399f@kernel.org> <335a2669-6902-4f57-bf48-5650cbf55406@arista.com>
 <20240104085855.4c5c5a1f@kernel.org>
In-Reply-To: <20240104085855.4c5c5a1f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Jan 2024 17:59:59 +0100
Message-ID: <CANn89iJ79ibHGu-4MCLpkG3w7dr7jqbc7CX1T7Cm+d6vwnwLGg@mail.gmail.com>
Subject: Re: [PATCH] net/tcp: Only produce AO/MD5 logs if there are any keys
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Christian Kujau <lists@nerdbynature.de>, 
	Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 5:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 4 Jan 2024 16:42:05 +0000 Dmitry Safonov wrote:
> > >> Keep silent and avoid logging when there aren't any keys in the syst=
em.
> > >>
> > >> Side-note: I also defined static_branch_tcp_*() helpers to avoid mor=
e
> > >> ifdeffery, going to remove more ifdeffery further with their help.
> > >
> > > Wouldn't we be better off converting the prints to trace points.
> > > The chances for hitting them due to malicious packets feels much
> > > higher than dealing with a buggy implementation in the wild.
> >
> > Do you mean a proper stuff like in net/core/net-traces.c or just
> > lowering the loglevel to net_dbg_ratelimited() [like Christian
> > originally proposed], which in turns becomes runtime enabled/disabled?
>
> I mean proper tracepoints.
>
> > Both seem fine to me, albeit I was a bit reluctant to change it without
> > a good reason as even pre- 2717b5adea9e TCP-MD5 messages were logged an=
d
> > some userspace may expect them. I guess we can try and see if anyone
> > notices/complains over changes to these messages changes or not.
>
> Hm. Perhaps we can do the conversion in net-next. Let me ping Eric :)

Sure, let's wait for the next release for a conversion, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

