Return-Path: <linux-kernel+bounces-120622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D973A88DA66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924A3295DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221838382;
	Wed, 27 Mar 2024 09:41:39 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09101EEE3;
	Wed, 27 Mar 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532498; cv=none; b=NOpSGdiO/elITeNJ/AS/Nt0uJhHcTUgkgX3wXn9jUBEv0alv9IUcivcASx7ZC7haRjbhIKiW91PKkXZDGfP2Rko0SnI+jQcMh8nWu8vZJhvBAZt71pBwXap6xRnkzDLgwhW5U4zh+AQ0CtSrBcQcfbIJy/9xEb1IM5xjVGrC/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532498; c=relaxed/simple;
	bh=y2rDKQzYyf9wanVJ3dcvgOgPMFErVnUpmRh76I+k0/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDM6FWGpCnmqz7TK4guAyNQEV7g7gxLepuJYWNSD/yTAITKt2kPWYbtR8fSNiYyIxgh68XLU+cF3RJA4VXWhkOcg1bvTvkE64x9TOhV9Pm0n7+NH/hvEEkjV1E5zR6cfxCZzPKqxFn6V9cjZhLd3XwPcWEtTxFdwo1jqWEbz9p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-611248b4805so48267677b3.0;
        Wed, 27 Mar 2024 02:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532495; x=1712137295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neGfOeBkEcopbYO8hmsRVi5kcTfEIsxbfUuBOXrqKxk=;
        b=vqr9ppRzNhDnNbDci/D0f7ZWKz2HE3/rBV/eY0jF13B+MFgHa2+RnGqf3Apnp8iIrM
         Sk+NZT4d6u05vfNqM4HBLrPfEDUhm9Jwm1y8aC13V+5c9EsbEUcNSC1d4Okbt9HCta/L
         io9yjpuDJMlEUxIwEDJwUy3NtVESwXirda4iB8eTZt29TrrCJtdL0jLwBFJl1GMeqWSI
         Q84WXynwFAkcUDMa20XdvqULaIwBFHVMtxjU//ZnmGkbg4pAfcTlChRg6MJCpBMk5t+H
         ZV/fJ3tlXFu+UWN49wJrM9WVGD6GvTaXBIpqSV+GyLO0gzeA/hwiDLO7zDbdvdrWK6ox
         /AgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfe5RJ9Xi6mLh6uCR/yGkp47/6dTa6TWxsexhN9kA5NQPohpOoqkt1u5cg5KD7MA4Fx0FKyPab+lwt0rGtb54/3ruiEX34dorSExtBcBcRth9CaPmESXvKjoZUqp9q1F/qitvixDwSBHI=
X-Gm-Message-State: AOJu0Yy/mZLHYyw1gNbjLOg/HjD5N1OleNPMX8c3IjNW7UIH+vCbiMjw
	l0IfEOV8qNXTJGoGc6bwYdc5lpDKkAqXik47NUHtrV+Brs3nwRc/MVmilRVHq5g=
X-Google-Smtp-Source: AGHT+IFJcsvj0s3RzT2Z5O7gAYP2rxlDzGM9aM4aITYfNawcoG/j8p0SsSJXzhcXOCKJd8slPtDgbA==
X-Received: by 2002:a81:87c4:0:b0:608:290d:9f1b with SMTP id x187-20020a8187c4000000b00608290d9f1bmr3515713ywf.49.1711532495246;
        Wed, 27 Mar 2024 02:41:35 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id ev7-20020a05690c2f0700b00610fdb81077sm1840791ywb.139.2024.03.27.02.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 02:41:34 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6098a20ab22so58956537b3.2;
        Wed, 27 Mar 2024 02:41:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZSH1+7aze+cwKXl+gCVFMqSMvawi4oZDui/5JLQCznBTdr1lVp7SEj1rA8O7ApFzEZgGZkOFEpNgdvLGFzeuWP1DCx/eQMTjgEGVHsHTZYeTnBtt7WdEnIMzcsQiwawpzB5fu18cVTx8=
X-Received: by 2002:a25:6b45:0:b0:dcd:4e54:9420 with SMTP id
 o5-20020a256b45000000b00dcd4e549420mr3841275ybm.5.1711532494725; Wed, 27 Mar
 2024 02:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324233458.1352854-1-sashal@kernel.org> <20240324233458.1352854-111-sashal@kernel.org>
 <CAMuHMdUK0YYELTN=JQDtGuYg03Em6c7kskpqUR0Y6NbNuR7hfQ@mail.gmail.com> <ZgMfbenM7Kav2BTJ@sashalap>
In-Reply-To: <ZgMfbenM7Kav2BTJ@sashalap>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Mar 2024 10:41:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUU0TYKhm3FkqjgrYQdS58oLPQJFPxYidjn0h-ZJ9qeFg@mail.gmail.com>
Message-ID: <CAMuHMdUU0TYKhm3FkqjgrYQdS58oLPQJFPxYidjn0h-ZJ9qeFg@mail.gmail.com>
Subject: Re: [PATCH 5.15 110/317] arm64: dts: renesas: r8a779a0: Update to
 R-Car Gen4 compatible values
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Tue, Mar 26, 2024 at 8:18=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
> On Mon, Mar 25, 2024 at 09:43:31AM +0100, Geert Uytterhoeven wrote:
> >On Mon, Mar 25, 2024 at 12:36=E2=80=AFAM Sasha Levin <sashal@kernel.org>=
 wrote:
> >> From: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> [ Upstream commit a1721bbbdb5c6687d157f8b8714bba837f6028ac ]
> >>
> >> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> >> family.  Hence update the compatible properties in various device node=
s
> >> to include family-specific compatible values for R-Car Gen4 instead of
> >> R-Car Gen3:
> >>   - DMAC,
> >>   - (H)SCIF,
> >>   - I2C,
> >>   - IPMMU,
> >>   - WDT.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Link: https://lore.kernel.org/r/73cea9d5e1a6639422c67e4df4285042e31c9f=
d5.1651497071.git.geert+renesas@glider.be
> >> Stable-dep-of: 0c51912331f8 ("arm64: dts: renesas: r8a779a0: Correct a=
vb[01] reg sizes")
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> ---
> >>  arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 24 +++++++++++-----------=
-
> >>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/bo=
ot/dts/renesas/r8a779a0.dtsi
> >> index 26899fb768a73..c7d1b79692c11 100644
> >> --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
> >> @@ -583,7 +583,7 @@ hscif3: serial@e66a0000 {
> >>
> >>                 avb0: ethernet@e6800000 {
> >>                         compatible =3D "renesas,etheravb-r8a779a0",
> >> -                                    "renesas,etheravb-rcar-gen3";
> >> +                                    "renesas,etheravb-rcar-gen4";
> >
> >This change will break Ethernet, as the Renesas EtherAVB driver in
> >v5.15.x does not handle "renesas,etheravb-rcar-gen4" yet.
> >
> >That can be fixed by also backporting commit 949f252a8594a860
> >("net: ravb: Add R-Car Gen4 support") in v6.1.
>
> I'll just drop this patch instead, thanks!

Looks like it still made v5.15.153?
The easiest fix is to backport 949f252a8594a860, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

