Return-Path: <linux-kernel+bounces-33814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB0B836EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDB72914BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1738634E5;
	Mon, 22 Jan 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESggLioe"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52AE63400;
	Mon, 22 Jan 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944386; cv=none; b=QrPvFqWxwjUy6GqPKP7P3IwV1eZ2R3mI05ITVaXX2VUo1wb8PvXEjZkIJSZNAU1tJ3HmIiQoLaaYYI3VOtxWKlxr9QBA1qRrfpUT8LcEQBuQQPxvRxyoKVYtcudks+06+1NpDn+GH/Q2E3FO9ma7ZQI1h99XkBSUZR6qMiD24dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944386; c=relaxed/simple;
	bh=26A8tfsGChMmLH71cY/nGmPPy+2IwXxvuF1dkUp/XGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhdmtCZFeN3cLs92nMPopa5UWkKo92O2TZxFIgq9KNhw2BoAZwKhL+Elo+ccZsUbQLJhSpCNdlcI9UT1tARDUQS2UvP1iVk08CbgLgx5Q5S4VsLaxTQRzPJ4OspiuLaDlp3gT6t5UC9T833J3tFJUGnd+etfJyRCEoND2bN2WQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESggLioe; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso3702707276.3;
        Mon, 22 Jan 2024 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705944384; x=1706549184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TLhmakZVx7P/y+xJl0pVM/baovZzW+u/LUkkxQgBmHI=;
        b=ESggLioeqskwcyaEN7/7f/sBd3AX0uo5969CCSQUuRUyi/lZ2MGNpBXSTewJD9BVnU
         D1h9JkaaNEb1XqY3od4YT++g0d1x8OBMiy5wrgcT+jzy1mt8YsrykwAAUcTCMNA3jlc4
         72+tEys4dfek1XG4JwmGvC1w9HZyl1V5seAOoy/QIFxQPqQcmrC/3wgmto6di5uZ9P++
         qULAUlB3raNAs6THxMgGblOH30SB9kqVRDHGMRZv6jio5z5L378mN8waBgHustjZUCNT
         vGxaSIdNQKIJQ+HjFih9rdOShgSGQ4V5/yFbZi3eaNNj5ysUt+Griru1P6SyQFPBXPVr
         LzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944384; x=1706549184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLhmakZVx7P/y+xJl0pVM/baovZzW+u/LUkkxQgBmHI=;
        b=pAZF8b/bZXrXQP5/qzqDKcVqaxuprowM8U0IpsgQ8wwqeTmk/gJMMQ2kFMqpKhyRjV
         sOOU7QCMgUdGUZT3aJ3QHC6UQn7O0jz4IH/+rFdEGdk1MLmf/V0azNbr/a1hcscQ7Imw
         ukXs29xTTfVIzxTEoAQLGG5wYWTbqrBI46P+87d2HZ3Sx5z4s1hLzjeVMwtEkK8r9D0V
         aoAbclTer2zyyRUPDoIEvsN6zful8jilPzPSID7SZcYEmCR60J3hefHsguniwAAeHrZG
         BiNKG1WrBXdcJKHcpu0O4DRPZpDd82LsxGwj4fXmPItRWIbAp10CLAyaXFHpZju4qWV8
         rjqg==
X-Gm-Message-State: AOJu0YybQw/1UFrWmW6tUE6bVf2a78UmDs3rr/keuxpowCaEI3c+uxKm
	eOhyesQHuwH1kcRB9bH6Q9WTuoMgLV4wO0e3uE9ATe+N2NsAvgVI2rjHwNSBl2YpW4jXzXJpJh6
	29gnhKCa4h9E67Phu8nxwcZ3Ed3U=
X-Google-Smtp-Source: AGHT+IGlkwiyiVqqnE5ObJjEoOKvtdd41NNwjfTkam4z85lvQtQ1t00ake2EBs3cpPEEWIqpmhcM2ZqpuRipoAA5iI0=
X-Received: by 2002:a25:8211:0:b0:dc2:36b1:7586 with SMTP id
 q17-20020a258211000000b00dc236b17586mr2974030ybk.9.1705944383702; Mon, 22 Jan
 2024 09:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-7-tmaimon77@gmail.com>
 <171300da-3d49-4e1f-8969-9a454ecdd698@linaro.org> <CAP6Zq1hifi7CY=tYaDY_o82AXhbS5P9=MZBb-bqmvNCLZk3O2g@mail.gmail.com>
 <018fc173-edf3-4490-8f29-4059bd17268e@linaro.org>
In-Reply-To: <018fc173-edf3-4490-8f29-4059bd17268e@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 22 Jan 2024 19:26:12 +0200
Message-ID: <CAP6Zq1jQ9T4Q+WvwyAH4sKLK1+Mp0utcA_STgm=_Z3ywKoLoCw@mail.gmail.com>
Subject: Re: [PATCH v22 6/8] dt-bindings: clock: npcm845: replace reg with
 syscon property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your comments.

On Tue, 16 Jan 2024 at 22:40, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/01/2024 20:37, Tomer Maimon wrote:
> > Hi Krzysztof,
> >
> > As explained in my [PATCH v22 4/8] dt-bindings: soc: nuvoton: add
> > binding for clock and reset registers mail.
> >
> > In the NPCM8XX SoC, the reset and the clock register modules are
> > scrambled in the same memory register region.
> > The NPCM8XX Clock driver is still in the upstream process (for a long
> > time) but the NPCM8XX reset driver is already upstreamed.
>
> First of all, the drivers itself don't matter here, we talk about
> bindings. I assume though they were going together, so that's why you
> mentioned driver... but just to clarify: we talk here only about drivers.
>
> If reset bindings were accepted, then why they aren't referenced?
>
> If clock bindings were not accepted, then what is this patch and this
> file about?
>
> >
> > On Wed, 10 Jan 2024 at 22:59, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/01/2024 14:54, Tomer Maimon wrote:
> >>> Replace reg with syscon property since the clock registers handle the
> >>> reset registers as well.
> >>>
> >>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> >>> ---
> >>>  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 22 +++++++++----------
> >>>  1 file changed, 10 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >>> index 0b642bfce292..c6bf05c163b4 100644
> >>> --- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> >>> @@ -18,8 +18,9 @@ properties:
> >>>      enum:
> >>>        - nuvoton,npcm845-clk
> >>>
> >>> -  reg:
> >>> -    maxItems: 1
> >>> +  nuvoton,sysclk:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description: phandle to access clock registers.
> >>
> >> NAK. Not explained, not justified, not reasonable, breaking ABI.
> > Should I explain more in the commit message or/and the nuvoton,sysclk property?
>
> Let's try to explain here first. I really do not understand why do you
> change this binding. Your device did not change, so your binding should
> not. Now, if you say "but I changed drivers", then it does not matter.
> Bindings do not change because you did something in the drivers, in
> general. At least they should not.
The confusion here is because the clock binding was upstreamed but the
clock driver has not upstreamed yet.
The clock driver will use regmap and ioremap so reg property is not
needed, should I remove it? or leave it?
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer

