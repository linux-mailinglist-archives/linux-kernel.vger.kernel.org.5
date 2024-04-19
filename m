Return-Path: <linux-kernel+bounces-151567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664A88AB084
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A5FB20CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2A08562A;
	Fri, 19 Apr 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL0F9+1G"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F14F214;
	Fri, 19 Apr 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536143; cv=none; b=a/Ostu7B+wG+CLOwgYbLdH6EX1EA64E9khQ8AX+7WEvmFE7nZNyby/55CQBjYK5W+OrqN8JJQJjOA8CdXZ0mMjXrg5+lfllCCaTo2glajxy9qJ+FVaq+bvJFc2Lwkjgvtj4A/jETV4ccUyk2cHGzlJvZLwUyzG66fu5fxgolvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536143; c=relaxed/simple;
	bh=W0mdvqs2asOd11DMoCEkH+mk70+oTv/de/UTORfTO0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2CLh97j/PNLm7ICjHpEqjSE4a3Em+ua2RMdYzYJ6JCC6LSMPQEl0ZTqBI7AbAGQmTkFEL7Jz7zvcro7KtP/sHE4Rly9Vzxhp/7vT1oZZ8fCeXLOwTsIgbDJUKFvd3f1tf2Yy3gkG+eJv0MmG6fVDwospSw6s/q0sbWhMJdXObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eL0F9+1G; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso3277417e87.3;
        Fri, 19 Apr 2024 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713536139; x=1714140939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od1HuzfQ62qye8I9y6ria+FsgJWb4Ms5/RYXQrdJrHw=;
        b=eL0F9+1GDvvDxXN3ndO1S3ip3Xz7Dgi//9lN2dAgAipFm8xZJl5UHELNMIse7T7ALA
         KP2aj8NOHi+IoYGEs3dL7vwe4UTfzVu98XAI7LoXSxko4sz3QVdVzlPSvPo8/XlIrPVv
         Rp8O96zIGT9cYa7ieWgXsKClSLKGyx0irWwCfgpYMCX45YxYFFhLWk8Xk7YgvO6ZaMMu
         8P9JVEhYYPnuTePNSJcnXKHsTgUeGIwQqeLwjtxXVNATHtfK0H8cGFlsrcQzGD0p2ITz
         35VoEWxZHWmHYWy9yMZ8RiHJqgK4B9ke7ld2aOiHIpMBa8j1JwIB52kVkOCnXrp74Cnm
         47iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713536139; x=1714140939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=od1HuzfQ62qye8I9y6ria+FsgJWb4Ms5/RYXQrdJrHw=;
        b=hxKhZdjt7aLa7bRFM/+Ub7XqrpJQ/TvWMG8ujVSWRbGsjCH1FpUSlFwFEBKcBqN5U/
         hz0zHDkLl39BwewD95c/6k4CS9wJPJQI6JN1go9KSA7gKxbb3UfHDOEhGT8FHlPIeuGz
         gM19rFzDnFhIYX15Dk9dh1cPauho1wYcPHvEg4UfXmwZR/hQIlE8KjlqWt71rPeBRakF
         g2FgeCESnGR0dGx+/fIo0kXW2qQpONlcbs65H3CBPtLlFHHCWOPAKC6rNM0TbS514wcE
         pkzF7u3f1h2OXzXkcOocy3YD+ZstUEW1C5fn3NFmcdmaNjwXQOzeOtKoh0RFknmlWC6j
         hQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUdDch2fhWB6Q+7lgk/PX2UOO05MKuAHOxN9rUqMJ/OqTIvyUH0FFBv+eAawH9HvB5KuMslarSAtD6oqeZplG/dS2F0a0CjibS7c9kRTnpF6HwScLnwOdvxltXitSfwZY6tYFp7zR1J18OuoRAdPXT+0HbhcMnelne0IFbLUTaaKvnXXA3HFA==
X-Gm-Message-State: AOJu0Yzu9HoE6pTXmUDdSnMzzLOznSsS/EBzNkEJD4OjnFwDdj6WB6bO
	8lygIwyEdTf8Hf0zWgrGEOrRaW2FdJVi0Qqix9mQIklPBluPoXLIfmNdRb8gA0arvuqQcByk1SG
	X8w3ygJjzRVVlneTXIt5Gs/3xiug=
X-Google-Smtp-Source: AGHT+IE1lEiJ+HQHyKO37TEXweZDgaRCH2dQqiCpfF+bVzG/msLkLTqXljXaNiBmiD8F6JAq7LVM4pgzv4o3VJhcgAI=
X-Received: by 2002:a05:6512:38c1:b0:513:ca40:fafc with SMTP id
 p1-20020a05651238c100b00513ca40fafcmr1600944lft.11.1713536138669; Fri, 19 Apr
 2024 07:15:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419124506.1531035-1-rilian.la.te@ya.ru> <20240419124506.1531035-3-rilian.la.te@ya.ru>
 <20240419-glue-pyramid-584728c0076a@spud>
In-Reply-To: <20240419-glue-pyramid-584728c0076a@spud>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Fri, 19 Apr 2024 17:17:43 +0300
Message-ID: <CAF1WSuy4OJVTU5VJdn23BSw4aTAq7i8UQ416V7BxveuQ+5=-1w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
To: Conor Dooley <conor@kernel.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, Vladimir Zapolskiy <vz@mleia.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 5:08=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Apr 19, 2024 at 03:45:02PM +0300, Konstantin Pugin wrote:
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > Add EXAR XR20M1172 UART compatible line into devicetree documentation.
>
> What you're doing is obvious from the diff, why this exar device is
> related to the nxp devices is what should be mentioned here.
>
> Thanks,
> Conor.

It is already mentioned in cover letter and in previous patches in the
series. Do I need to repeat it in DTS patch?
If so, I will do it.

Citation from my cover letter:

EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
it has additional register which can change UART multiplier
to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
flag to guard access to its specific DLD register. It seems than
other EXAR SPI UART modules also have this register, but I tested
only XR20M1172.
Yes, in datasheet this register is called "DLD - Divisor Fractional"
or "DLD - Divisor Fractional Register", calling depends on datasheet
version.

Also, comparision from NXP itself:
http://www.bdtic.com/download/nxp/75017168.pdf (pp12-13 is about XR20M1172)=
.

> >
> > Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> > Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yam=
l b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> > index 5dec15b7e7c3..c4bedf23368b 100644
> > --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> > +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> > @@ -12,6 +12,7 @@ maintainers:
> >  properties:
> >    compatible:
> >      enum:
> > +      - exar,xr20m1172
> >        - nxp,sc16is740
> >        - nxp,sc16is741
> >        - nxp,sc16is750
> > --
> > 2.34.1
> >

