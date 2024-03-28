Return-Path: <linux-kernel+bounces-123501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1BE890995
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38161F22F45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6E21386CF;
	Thu, 28 Mar 2024 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyQBiupU"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E0B3BBEB;
	Thu, 28 Mar 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655240; cv=none; b=S7CaoVEOVo8lZ20TkfzZnJqGOg91tVn/AHoDHTsiWhVvgZ1lOrGJMxT+kf88xKzjBcfBr4FhP588j7oDAqKv8Bp7OIyp7CEHHANFih3u4g1vid4fDNClTP5C8w065P370Dub8jpu9eQUw56f4FaZW0Qfuqs9HNWFQSRaZ00YNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655240; c=relaxed/simple;
	bh=1Mt4TUpvlSuvJ96g0VUvqcJE8it+xvkFfhZZ5MLz++E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLBwgjiNQK24n7hL1J7faBcTh0VTivWC03nJG2O4jb9zhpXZ2xI+HXL+yrBYcgjwpNiG+QFLuRuiPcaD7KvKfiktkCwUYbYpfTbyPmr/mKG7iDRRQjx3wDy6cCytVUspDxYEVZUiC+2egZXmfuT4Dw/E4HLr198Ocrs9MbRdPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyQBiupU; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d86ef290e0so689050e0c.1;
        Thu, 28 Mar 2024 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655237; x=1712260037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y98AXy2EPHAOgeK4+7hLFbzZGIuwi3MKj49JJNRL6V4=;
        b=KyQBiupUpx9bp73BnhcBkdHss0e+9KqXYpwf5Juc6x4/RKXek45QzGFR8QIVEOV6oU
         KpWJdt0IvnX3gcrGkOeeiRXJZeFeSIoSo1/B4D/uvvOgDG92FPf6UGKlxm3ovJUEcuQQ
         C/5+wS1LTgvwdIxRHB34Xjzo+uP9fsChtcQQZzE5AJ5P5JVmA6+Leon1OsykF8uP4VXQ
         JNvgnsWQb7CtNN1muItCHpRLk2yJfoORkzFHmsffx2VXuXnihLqFy0Oz0UNxV7NI+5Ff
         js5aCse7XMDsTUtQQ+N23KwQTybrMW6K8BYENqFsllH00zd3Pyg+ow6R4FrvU2hqPCiQ
         Rvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655237; x=1712260037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y98AXy2EPHAOgeK4+7hLFbzZGIuwi3MKj49JJNRL6V4=;
        b=OkSmUAVg4XDEJ+cQxXbwb1HkoT7UZyopTVzJEYQAgRcs7zLxeL/X/m/Zrq8FliHRpY
         jDSnkIKVeaUSJoxMy9C02q3ogdlyLpxI8C+T3pLGd9PtArMrfEgHKCaE4eq0mzujtQ2r
         b0tMaRbRf6BS0iLctKptJuaKzbZp+UsPw8DqB1LeaeFNw2wMkrkNu1z7H96VuIYI/SA4
         sf57ZQLRt27hfERg6GcFCGp1Lvi6i8ifDWTtnOCVZ4O437clMARs2D+oNXI7bR3MqkQL
         cNCW8E5iVwsaktQ5ibphEkAVsHN+14lha/jAi7cwwmcpBctvdDu+c1kNDIXpVUcop3LQ
         zhBA==
X-Forwarded-Encrypted: i=1; AJvYcCVPsfxwcTTt74FxmMy+lcfdI+1EsZx8dhx5YSVpa0C5aBTLIZYJV7UtJF+z7j3zqRonQtyMs61Drr9gBF0bFWkTlS5GwVZ/ulK4C23ptBMiOkkrA82WK05FHz9Mw+rpvrDpgeKochrOAHWbs1iZTkFV7EbbyJE9SxvrXb6/p2BNtpPkf72uXCf04ZKhWpLA84j2T0qYRaAf9i3wghOEdZrMDrlEIHIdig==
X-Gm-Message-State: AOJu0YyPxsBAvgk6jtr3Szv6qk363XTe2BSbUC0kcp7ECrH9V6IsCcx9
	zrzGJ7dUhY6zkhsFOWdTchs/F6KmAyxr9e8601Lk4TlTBWFRBmxX844zGMGHJGF2ODffCdJt8S8
	oKrPes0C59PhYozy/Yl2w9J9FP76HqHqa
X-Google-Smtp-Source: AGHT+IHq+M0xcSEGdG0zTRcuGqPDcXDiiWkDbr8S6oB/sxErqalgI2SDqSXZm4KesSzFeB3zGJXaJSvNZYTFxI7LGSg=
X-Received: by 2002:a05:6122:c8a:b0:4d8:76fc:3aa9 with SMTP id
 ba10-20020a0561220c8a00b004d876fc3aa9mr3104788vkb.6.1711655237587; Thu, 28
 Mar 2024 12:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <4bd3b33d-564a-45e0-905c-d0deb52e6f38@tuxon.dev> <3d3a651e-2853-4b5b-bc8a-6f494250d9c7@tuxon.dev>
In-Reply-To: <3d3a651e-2853-4b5b-bc8a-6f494250d9c7@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 28 Mar 2024 19:45:33 +0000
Message-ID: <CA+V-a8u3C_-V=s64qj-EN+YB1Men37m-r1p7x8dmEvU+JXdMJw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/13] pinctrl: renesas: pinctrl-rzg2l: Add function
 pointers for writing to PFC
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the review.

On Thu, Mar 28, 2024 at 8:13=E2=80=AFAM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
>
>
> On 28.03.2024 10:02, claudiu beznea wrote:
> > Hi, Prabhakar,
> >
> > On 27.03.2024 00:28, Prabhakar wrote:
> >> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>
> >> On the RZ/G2L SoC, the PFCWE bit controls writing to PFC registers.
> >> However, on the RZ/V2H(P) SoC, the PFCWE (REGWE_A on RZ/V2H) bit contr=
ols
> >> writing to both PFC and PMC registers. To accommodate these difference=
s
> >> across SoC variants, introduce set_pfc_mode() and pm_set_pfc() functio=
n
> >> pointers.
> >
> > I think the overall code can be simplified if you add  1 function that =
does
> > the lock/unlock for PWPR. See patch 13.
>
> I meant to say one function for lock and one for unlock.
>
I agree, let me remodel it that way.

Cheers,
Prabhakar

