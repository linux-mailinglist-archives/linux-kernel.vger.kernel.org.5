Return-Path: <linux-kernel+bounces-27732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D62582F4FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110061F26321
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F231CFB7;
	Tue, 16 Jan 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URFrkTNa"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75781EB5E;
	Tue, 16 Jan 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431850; cv=none; b=N/TlZ35GDpXBB6jPaZnS82JLgVVW5M1tUK8lJ79QgAuuIdhQzOyic1TE9NO64IwY+Nw7nPqkRrkT0W5QUCIZAzQu2LqDxQKtW5tVvPQh8vuCXFOBH9pFDcki81RZDLuMUJhulfp+YsbHgcEEF6ohZn3L78mDzj/V2E8JVcoQnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431850; c=relaxed/simple;
	bh=dm1liQhJtUkVgWIxniNMTu3WXC8cfV96Gig0jkhd8J0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=SfyfZeHayXxfyPDUTtkTAFGOVBpciOxeE7HQIw0fSQt+K7Efni6o1APVOwv8IjAI2Poc7NX0JyJjypZSBWxJmcZwIcHyXVUGQ09QvpKOVyfcyCH3ymYmNhH1TJ2KSLvLJXNcIjMdFyMGB/jUGlRwd114u+9Y7EL//cklIieRljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URFrkTNa; arc=none smtp.client-ip=209.85.128.175
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5f15a1052b3so93254817b3.1;
        Tue, 16 Jan 2024 11:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705431848; x=1706036648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p0O8J1tKk/vVn8InKgNLS/4PstZ3a8iy9tIk4iRsjlc=;
        b=URFrkTNaW838UPlyD67zfArGEBczk/55JuBVXRI6R47tsxHJpj5okDs4BjGczSs77p
         trwUzyQvjNUMh1Hm9aeoifl5LFGSc/zQt3dyguAtu26WWZcicdw2APU5CZnJexMNb9fp
         pSiNimow9f9BfwUFHGyjOCzkhidVUdNUzOX91VoVLumt12sD0yIUUr5BQHSyBBYAVapA
         6nh1Shyy8O+BPV76nx+9+NfDCIbAPofb7Bv2IuEGOwLBmbScHzQ4KAcEb8A1+p8BZqrp
         ISnunq9tgxV2fQIQZfTA+JXcBlapM//cQPD7OhUQSHV1qzS9syD+JTYomj8dJf/e4K/k
         phDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431848; x=1706036648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0O8J1tKk/vVn8InKgNLS/4PstZ3a8iy9tIk4iRsjlc=;
        b=PPRIRY6aXwJJT9/lOdvwQhnorpj+f/oo1+dt1ehiGDH3BD2/UHVTQzDzcJa9JZ0B5x
         UXT4iegz1bgd4TP+ezGBvWfAn8YoCQXx1VRWMYr2xAVRfgvlH7H6t3MTx4K3xDRgymSD
         FeQUTZFxc6BJj82r6haAk2weyCdkCYj/muybCubV4g4zpyolhus+/vSnKFT2qqerAvQd
         YOvS22j8zJZAmEqwhbLjM0Sq/dVt3oi7KT8tbZQcoiBl49PaTb8FUseA7uUh7yYWmNSe
         B/nFAKNdGoayUwMQjJMFsi5H7KgZwwbQz9/dk2PmC6iyf8zJyMqlFyHRwKkV3CjCo+Tx
         w48w==
X-Gm-Message-State: AOJu0YyNl9s8hYbkUpukhPlLoP1BsPLqlyyk1LFxdXvU/MdD9kDPJWhO
	7fuK1jPApooBQDAssAcJczOil4BhAO6rvGmrBWc=
X-Google-Smtp-Source: AGHT+IEXRnUGPJD1ri/U8Wt1UsnIWkVnxKEeRpoqtaXWVOvyxun/wO91g+xEArSw8LKoeOWz3vF8MWxtTZ4kYuvg0w4=
X-Received: by 2002:a0d:df8d:0:b0:5ff:5f3a:4405 with SMTP id
 i135-20020a0ddf8d000000b005ff5f3a4405mr651310ywe.30.1705431848648; Tue, 16
 Jan 2024 11:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-6-tmaimon77@gmail.com>
 <4e9cc473-dbab-4e7c-ac7f-871a4025ef5b@linaro.org>
In-Reply-To: <4e9cc473-dbab-4e7c-ac7f-871a4025ef5b@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 16 Jan 2024 21:03:57 +0200
Message-ID: <CAP6Zq1ii49BFPAg_erhiu6qMj7zC7iLg=C-N1c3UKy7iEe9CXQ@mail.gmail.com>
Subject: Re: [PATCH v22 5/8] arm64: dts: nuvoton: npcm8xx: add clock reset
 syscon node
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your comments.

On Wed, 10 Jan 2024 at 23:01, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 14:54, Tomer Maimon wrote:
> > Add clock reset syscon node to handle reset and clock registers
> > controllers.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > index 9c4df91031e7..7d5956e2c9f3 100644
> > --- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > +++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
> > @@ -22,6 +22,11 @@ gcr: system-controller@f0800000 {
> >                       reg = <0x0 0xf0800000 0x0 0x1000>;
> >               };
> >
> > +             clk_rst: syscon@f0801000 {
> > +                     compatible = "nuvoton,npcm845-clk-rst", "syscon", "simple-mfd";
>
> This is not a simple-mfd. No children,
>
> > +                     reg = <0x0 0xf0801000 0x0 0xC4>;
>
> Use lowercase hex. Please store this feedback in your checklist and do
> not repeat the same mistakes in further submissions.
>
> Best regards,
> Krzysztof
>
will be fixed in the next version.

Best regards,

Tomer

