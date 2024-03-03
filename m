Return-Path: <linux-kernel+bounces-89902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C860C86F714
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6B7281522
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820877A146;
	Sun,  3 Mar 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTb53jJC"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218B78B4E;
	Sun,  3 Mar 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709498621; cv=none; b=TsI7ZEmoXE06xO1XD8X5MUO0KSB2LBM9wylVqwNT6fFQrF4ZKt0T4OywwQYxykovDZj1ceRWag17W5uwgB10jQGmKmVgBmq364+fNmv+819JYpS7h45MuvQVcaJJZxloH4XfRNG0jiNJ/5RPjfk8/wOpKlFulJMJUinZKHqheao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709498621; c=relaxed/simple;
	bh=ueJg5DrOaw6e2rEWEWzV763JHiRIGI4SK/gGgUMTXwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4r+PoEEqtpflIYjKDo/aPvccr4qv0sYZC/UlsrQ6yoLQP40LG+UUZfEhwgannPvLn9Ps/tl7vDTFkA9kWDpGC/g/6TpYt8wFmKMtuX4OilJ8Bn4O+Yi6vI1/C6gnTtAeqW86TYBX7McL+7kdzZqMzFSLC71GHBt8oKje4XyAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTb53jJC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a449c5411e1so288539266b.1;
        Sun, 03 Mar 2024 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709498618; x=1710103418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tsWGXN79Ep2DiEv+qklB4RzrUDWXWJUGUgSyi2Drqw=;
        b=dTb53jJC54f113ZTvmZbF2HADXJvPORqKZDplIPUNsuejL1GtWq0O4d5o1iKnOub45
         BwTgikDCfPAD7D5sr5TGkp1iU41B4rrs5ZeaJ4L2xuIw1AbuIOtwsSK3La1yZw8NFkHz
         cDlzbhyi7fG9rWFX7YSt9ZGSiZ1B0B3qKyd0zE9OQyiSIZi+d8QePYx2ADye6U2JWzQT
         W3K4L96RJsSsq3S/YM6IfXLlpcRBoNftjOAvAtRgLzKAiR479taX5NPrKbuOvjFIpsWj
         SlQw1U2IV9a2piLtuhlmGYpn6vQxBtbZtLD0t4BkTvT0nEhnow337hA1paUOQaLnrRiI
         kffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709498618; x=1710103418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tsWGXN79Ep2DiEv+qklB4RzrUDWXWJUGUgSyi2Drqw=;
        b=lwkF/j/iKIR7NOGVmAcR6Nl0LZU+2ruF1FqcIByiCaqnh9bU8RfiT6st2tEw9A0p9u
         uALB6QDux6EyHNDyckYMfQoYUhEtnwcBsTKLXweI7Bh0VM8Uc52HJsEkLNXrwKhlBFAn
         OY3C9ZitfOjSEvlZbJuL61Y0xlzrwR3lKnMppZA/3k3jsQsqW3o2gSSRsTWvxf/lE5n8
         ZNi5TdoanA7rtmYnhZpU0fViAPOf0U3smYA+hPT6yvz7sTy4bo/S0LucaEJvCc1qGNrZ
         u/6tjPYNWsEqC2+t6bdPXTc9hDc02pkgSQHbOYhV0FqIWIgNswyLdVTyqLvCdT9QP0iK
         0qNg==
X-Forwarded-Encrypted: i=1; AJvYcCUOCnMu8nwwaTaBW/a0vNQrYYbFlDFhrya1x/B2NBi5wdcSElW0cMLzvjPSbYnLliABAIGbVze1kRIVHT9H8a46avlVbhQOb1c1cyZA4fMAdf8xpouQV9jwK/tXAqGFVgytbrNm3eacvkN/v4ZB8UgOzRqbNjKu03rP8ETGuP2xkjAxrCk=
X-Gm-Message-State: AOJu0YyrXMDAbXdpOI1QSXn70vjomvCAa4KnOj46xXNC/dehEMOl1exD
	7kT0eVsjtecvpGkHPlTkOYNRkfyjC0dj0PKr6V6G9BI1wf2OsN/TDZBHC2wuvk1DJkwcEf1ZFK6
	byDldln6tgaBE5Vufr0mQLEb7nLQ=
X-Google-Smtp-Source: AGHT+IGFHHgSnK9sA7UciEqXiDd1WR8IQ0rHldMdHM9AxIzGL9m+cII+F7Xa92wdk0gKg5IRkU0P/Yu0Q0lnBBCkWAw=
X-Received: by 2002:a17:906:7f92:b0:a45:3fe6:8ae8 with SMTP id
 f18-20020a1709067f9200b00a453fe68ae8mr644347ejr.28.1709498618328; Sun, 03 Mar
 2024 12:43:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301014203.2033844-1-chris.packham@alliedtelesis.co.nz>
 <20240301014203.2033844-5-chris.packham@alliedtelesis.co.nz>
 <ZeIdXIx5zYjKQiSO@smile.fi.intel.com> <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVJiWtB4MSGHXXz=OAEvu-+b9Xp-jQ_NXWck+hwKGK4TQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Mar 2024 22:43:02 +0200
Message-ID: <CAHp75VesLCo72ftQ2BNEKSXwF9A2pe0Vbnuves2-L3ist_twNQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: marvell: Indicate USB activity on x530
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	pavel@ucw.cz, lee@kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 11:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Fri, Mar 1, 2024 at 7:24=E2=80=AFPM Andy Shevchenko <andy@kernel.org> =
wrote:
> > On Fri, Mar 01, 2024 at 02:42:03PM +1300, Chris Packham wrote:
> > > Use the dot on the 7-segment LED block to indicate USB access on the
> > > x530.
> >
> > As I said, I'm not going to apply this even with Acks.
>
> I guess you should not apply any of the dts patches to the
> auxdisplay tree anyway?

I think it depends. If we got maintainers' Acks, etc, why not? If DT
maintainers think otherwise, then no, we shouldn't.

> > The problem here as I see it is the future decision on how DP should
> > behave like.  If you put this into DT, we will to support this to the e=
nd
> > of the platform.
>
> As there exist 7-seg displays (and wirings) with and without DP,
> the 7-seg driver and DT bindings should handle both cases.  How to
> wire/use the DP LED is up to the hardware designer / DTS writer.

Right. But my personal statistics for now is: 100% has DP (out of
about a dozen of different chip + LED combinations). What's yours?

> I agree it's a thin boundary between hardware description and software
> policy, though.  Is that your main concern?

I believe so. Because if we mark DP for use for something else, it
makes it much harder to re-use it as dot/comma later on.

--=20
With Best Regards,
Andy Shevchenko

