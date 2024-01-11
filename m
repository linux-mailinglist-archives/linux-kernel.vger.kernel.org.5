Return-Path: <linux-kernel+bounces-23374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B782ABBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B731B2173B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730FE12E6E;
	Thu, 11 Jan 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKGMeEMi"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566B1426A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so6339a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704968205; x=1705573005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unRXO3bgzqCCGiqSMIo1ZdR+Jk1lzWVg4UVCVYa4eOE=;
        b=xKGMeEMiLjAIaSfB9KVnefiD/cvQbAP0mBzusMOYYx0pN5A2Htd+SEf0344fAEBmEE
         rcBxrHudLe0sR9+P2MbVT4NCgymnmFpV0djHVXhTR1GNs3fOTTORPjjzI6f8qgfg/9wc
         Dfpnf969MWSjH44aBa8OrbMlpL8T8OaXDQHz5UthXBfdUojeO5cyldDt9QRctYJOW52s
         mL1r7VVS6I8MKgsRiwPk0nQqnyQF3efwTFNBC3iLZjDcQm6IhqeQpobsXOGddFo0L5WQ
         6RfYcNQyf0krGfd7HF9xMV9bzxdnUK5G6diB63504PR0WVN6Gn2LIV1F3Tnd9DpQd8o7
         ZbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704968205; x=1705573005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unRXO3bgzqCCGiqSMIo1ZdR+Jk1lzWVg4UVCVYa4eOE=;
        b=OCNK3UCikgGkvbq+p4ZPGrypw+YvXX9scFUuGabdu0gfpjBrwdSXN+QGCu4CEHbE6k
         GCai8rnzntz7HSxpgCuWILZ2eyHKci0h9F/Kjp389LhkZLNJjvXeD1L/6sJKUdiOscyI
         0OZmNyJ7jcL4uLINffdYw9LPMS2GDRS19DZCpwc2F6ZINgBzxTQEsHo6muxoVHpPpd6R
         PDxkKPkLcTKnSDp6DMl3eGdEb8fGcK2GeK3CxrZbbHrxkTEXSZjZYOPwEbc/KdX01voG
         Oi+hx9PibSgUidA0Oo6eAY1ZgkAJaUezfyuO44p6BleSuHPiYqrPTHYOOH6wtj23WQP3
         Up1Q==
X-Gm-Message-State: AOJu0Yw4G1fFXIy7gUF7erbsCohKx+OxPMsdJgoq1MBH1LN5AyEaNyG/
	smbK8UioeOM2XEZv+v/XpXvOa/M98IPfyZmTHnNlyKws32Ca
X-Google-Smtp-Source: AGHT+IGxWYLQ1uL3PYlNCMstxI3MLGwlpuku2to8bjjPFO5aEOWNKZ8VRWSKdu5fSLonkU0n0e6fZ3ukIqJjHmgxMN4=
X-Received: by 2002:a05:6402:34c9:b0:558:8016:b347 with SMTP id
 w9-20020a05640234c900b005588016b347mr59573edc.5.1704968205361; Thu, 11 Jan
 2024 02:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109031204.15552-1-menglong8.dong@gmail.com>
 <CADxym3azdds6dRDdvofHj1cxZ1QxcN1S8EkrLtYtKy4opoPrFw@mail.gmail.com>
 <CANn89i+G-4=70KA4DBJqmFRXH9T3_eaOUmVVDBDH9NWY2PNzwQ@mail.gmail.com>
 <CANn89iLe9q3EyouoiSfodGBuQd1bHo5BhQifk47L9gG7x29Gbg@mail.gmail.com> <CADxym3YHYoLpDsJ1qx3p74eqGPV-CY8sOqxnX+VvzL8SegD_AQ@mail.gmail.com>
In-Reply-To: <CADxym3YHYoLpDsJ1qx3p74eqGPV-CY8sOqxnX+VvzL8SegD_AQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jan 2024 11:16:34 +0100
Message-ID: <CANn89i+0CWaoPr9rMrgB6UeOQwGjfG-9Cj-c=gmNLdxYFUogaQ@mail.gmail.com>
Subject: Re: [PATCH] net: tcp: accept old ack during closing
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 11:06=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> On Wed, Jan 10, 2024 at 6:41=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jan 10, 2024 at 11:25=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Wed, Jan 10, 2024 at 4:08=E2=80=AFAM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > >
> > > >
> > > > Oops, It should be "SKB_DR_SET(reason, NOT_SPECIFIED);" here.
> > > > Sorry that I shouldn't be too confident to compile it.
> > > >
> > >
> > > net-next is closed, come back in ~two weeks, thanks.
>
> Okay, I'll send the V2 after two weeks.
>
> >
> > Also look at commit d0e1a1b5a833b625c ("tcp: better validation of
> > received ack sequences"), for some context.
>
> Yeah, I already analyzed this commit before. I think that the return
> value of tcp_ack() mean different thing to SYN_SEND and FIN_WAIT1
> if it is zero, and should be handled separately.
>
> Anyway, we can discuss this part when the net-next is opened.

Discussion can start now, but make sure to add RFC tag so that netdev
maintainers
can prioritize accordingly ;)

