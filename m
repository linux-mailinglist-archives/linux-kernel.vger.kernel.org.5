Return-Path: <linux-kernel+bounces-46614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1033D8441FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FC328EC13
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD584A26;
	Wed, 31 Jan 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/yiOGIJ"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249E5A7A1;
	Wed, 31 Jan 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711977; cv=none; b=tDDIA4/B3/Bb3x2910Nf4krPMCqXH+zJe0qVK9NvPITMSAuAYQ1c9uaT/mFj1ICyRRVAkXk3C4kmVDbtFSYtn9a7RfBzhtLiqBFa1PC8OKFP1rel0hWMia3f0xThqdZatracpiyneq2Z2l350w7KpgWOjC6JWm7AnJOdjc0euIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711977; c=relaxed/simple;
	bh=BqrU+GVrz1zcwcZi5i1BgXLhXk9f50v4UGP6Xhj2ZlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtf0sdHJRzGxfTQ/Ti59fWxnJz7Ze7s1wYlaJbOUifZoqx3YlMksujx6vmbj0cKdWuzFQR+vUPC754iPUFCPxFwhaRUkRwunCG9/Z0A8cQAJ1++TwboFyiC9rKy9dRlFH4K03jOaQsvjWRrZBgDLyjg6a8yGqJxrjuQ21m8BukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/yiOGIJ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4bd9fd9eb7aso1111190e0c.1;
        Wed, 31 Jan 2024 06:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706711975; x=1707316775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqrU+GVrz1zcwcZi5i1BgXLhXk9f50v4UGP6Xhj2ZlU=;
        b=m/yiOGIJ5LO4mzYZxXYib1NEV9Pq5FQTBGOGgoMCxG3T8HELmrQjJrJFgz8RULf3sl
         zi3F20r8tNhLLjC8SyUFA02s15mrTk6qP5m0sjaQ/tLfav1ix5kE1hxqKQknmB0tELcJ
         yDKK1AmojUuZUFAnlevg9glm5qjFPIGkvCWAQp012QWfjXsFtmfptofwRRkuX4zTe3oq
         OnGVT98bvAr3b2J8KIM6ZSE+VidnN9FVYJ+vn49zjuOxoBCU8lf2I4ts224Qs6yxgS3h
         OD6xTZ6H8S3lWbNs3sjFMli+yy4JRxgV6sZagsg97mEDYm4mdgV/76V3+y2iUAlCC5Ek
         9L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706711975; x=1707316775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqrU+GVrz1zcwcZi5i1BgXLhXk9f50v4UGP6Xhj2ZlU=;
        b=OH7ZQpowgpJfWg2+y7iZMayNs02Kbi5d2MrjXHLcCu6DOtEdl26si614xxhH7ydvz0
         1BI4YRnkLI31LK8BMOwuyLzS92EJBk7VEqQMsD3i+IIc9vrdLDzLryTtaqcLfzQbxaIE
         y+y8kkjCiCTQPxuF0xQw1BVCGz+wsehZuT87fgTL2TtLJSrNImCpWtmOrO7QHms4ul68
         Hs1W6KLrH7dON28Jij0GWEnXDm9tQgGqmWVGGIjVL9l7CTa2zRddQw1Su495AHdUlJch
         NLWfzDenkttMRg6nvYyEGvboM99NSRA20jN93CZD0afwZMHZ1ndlwJvv63UmIG//rtVn
         kE8g==
X-Gm-Message-State: AOJu0Yz85lhW6oHuOs/H40ge3ZmAyZq10AYzdJFYEu4Be5v8WiMgo/28
	iBbUombt4gemqH0svwrCAfmpC4zHYukVeT8iUn/ddX1d0NpL25i6dkArF3j7dzcORnWRQcb2Ofk
	utGg+yH5VdNKHHz/SbsiUlJYFPwg=
X-Google-Smtp-Source: AGHT+IEw488xosd62LYpZ4qUC9JuwvhcFv4GBaJXAl2lMH4ACM1qXE1Ck9LKAp28ChYZ8M+26nxopKxA3MYm9yAuUB0=
X-Received: by 2002:a05:6122:3a05:b0:4bd:728b:c108 with SMTP id
 fp5-20020a0561223a0500b004bd728bc108mr1783559vkb.8.1706711975030; Wed, 31 Jan
 2024 06:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129135556.63466-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUiiQpw5UH8s748oqaH5BuFqDy=feWxdsEPJ4jaHRzkyA@mail.gmail.com> <CAMuHMdWe1_51wxrvhrPN4HVdsZNLep_Qz2ianW0cPXxJ6ECEfw@mail.gmail.com>
In-Reply-To: <CAMuHMdWe1_51wxrvhrPN4HVdsZNLep_Qz2ianW0cPXxJ6ECEfw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 31 Jan 2024 14:39:09 +0000
Message-ID: <CA+V-a8vBv+5Yd9hHOJnvuo4=JGYj59FkBy+oqscXKxu+9W=png@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] riscv: dts: renesas: r9a07g043f: Update
 gpio-ranges property
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Jan 31, 2024 at 1:49=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Jan 30, 2024 at 11:38=E2=80=AFAM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Jan 29, 2024 at 2:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gma=
il.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > On RZ/Five we have additional pins compared to the RZ/G2UL SoC so upd=
ate
> > > the gpio-ranges property in RZ/Five SoC DTSI.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-pinctrl for v6.10, as this has a hard
> > dependency on the pin control patches.
>
> It's worse: the pin control patches without the DT patch breaks, soo.
> So I have no choice but merging patch 3/4 and 4/4.
>
Fine by me.

Cheers,
Prabhakar

