Return-Path: <linux-kernel+bounces-27764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8659582F580
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9841C23AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B071D559;
	Tue, 16 Jan 2024 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVA+uCp/"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573A1D525;
	Tue, 16 Jan 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433864; cv=none; b=EYjxNklZUYvJGRfDfHsJi+nUkylRbqw7fk/Y39XzU3d/I12Ps36QE5Wu6XW7omIOwoPFDwXmB/mRVq+NTaicFs2DMtVuMeVTaaPhvEw8t0rEv/qL/7ioS0t9PpAzStDUUf6bruc5nrbG+LY9wkr61WM/k7QCyxQw/LeEzp0m5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433864; c=relaxed/simple;
	bh=ausvhzAX2+0NwFS0JS+YDL4l+WoLcKo3z/1XJ+Ljgzw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=bXIH3i48KMHBJGveOJhL1S3ZY3rccyvfdkaHyMYuBLTYrTS38iouiLT23/uZcGm9Qpdxe7ibyYDhLNPY57QiyfM+vcyPM34b8eOYMSE+QjHw05Y/6aO3GQzwbXA9n7xf3uEn8uRTYSRDGfHVpc4IJrEFnIAy5bDWFvBTYA1KD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVA+uCp/; arc=none smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e89ba9810aso84443597b3.2;
        Tue, 16 Jan 2024 11:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705433862; x=1706038662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L0JaYidCVwdwRm9hVZBNloEcOvaQrqCt/gTnlhIWr74=;
        b=YVA+uCp/YQWA2+Pqcj4nLYc5JyPW56u74aIJVLxC1h6rFD5DxAeAoOIKjxv+dq3EfH
         a9u7U4hzrT3szo0EJz2mXc7c2fd7QppVCZxQqNgM3xA78KRsy6wQC3E72otTmLDexozb
         0dMqGZrEEdS+w7FNB55F9nKv/x5jGvkgLmMVjWWcwkmo/zceNvCCtrLcGIEy7/qvVAEB
         Er9lTz4yfPpf4oHxGKmziCs4tS5Fe3EPMcRY0pdE195fsHTGboWmF/5Xg78pWm7HkaZg
         PGZ/g9P3+4mYAV1FMKlUqSRnCjl2MXjpalCYT50hF4+I86YiM+bnFtWn+ta2GV3aoG7Z
         PQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433862; x=1706038662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0JaYidCVwdwRm9hVZBNloEcOvaQrqCt/gTnlhIWr74=;
        b=TNAa6kYnkchUntnIzxGhNJGTLy9lpFDApamx4c8e9CGLKPnOOreMVlkm+v1XbuJqsu
         cpc3WZW5RLhw6zh9+92ARiZgbAQVSU5/nTW6OrAE41cpcmQD7yNddfTs4fNyJezTd6AH
         HUF3wDL35BlKQlrXZO1bgIQ7BA4WTMlUcMeoplCYsOAymPGvUNKV3DGJgmCDlBBRd0vw
         G4S996/DxvGaQXUOx2O+s+rcCYG1YwmjVO53o9ATz0aA5TewNwVeCekbdK/twjcik8aN
         1NkRN3rvK0MGvUG474PEbdQG8HgiRUzm7QeWPvvEg5BI5xfdAC1VPlZvCfv6DAk6aiWq
         dedQ==
X-Gm-Message-State: AOJu0YyEVzK5eLnU8wzKwdpqtKdeJNuRzhJnNC4hPFy4mFIcg95ZpsbN
	r8N+ibKbhwARem5CerW9vf7+eTsai8p5lF7Fd7k=
X-Google-Smtp-Source: AGHT+IFPyMkknwPsbZq6kJ5rIa1dMpjxEpM+yjToWc3WUR46HAQ2vOLUvZ7pFzEHh/2UBrxWht5R89QTtKpc7dgC+Fg=
X-Received: by 2002:a81:6cd2:0:b0:5ff:4e43:8430 with SMTP id
 h201-20020a816cd2000000b005ff4e438430mr1352673ywc.1.1705433861873; Tue, 16
 Jan 2024 11:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-7-tmaimon77@gmail.com>
 <171300da-3d49-4e1f-8969-9a454ecdd698@linaro.org>
In-Reply-To: <171300da-3d49-4e1f-8969-9a454ecdd698@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 16 Jan 2024 21:37:30 +0200
Message-ID: <CAP6Zq1hifi7CY=tYaDY_o82AXhbS5P9=MZBb-bqmvNCLZk3O2g@mail.gmail.com>
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

As explained in my [PATCH v22 4/8] dt-bindings: soc: nuvoton: add
binding for clock and reset registers mail.

In the NPCM8XX SoC, the reset and the clock register modules are
scrambled in the same memory register region.
The NPCM8XX Clock driver is still in the upstream process (for a long
time) but the NPCM8XX reset driver is already upstreamed.

On Wed, 10 Jan 2024 at 22:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 14:54, Tomer Maimon wrote:
> > Replace reg with syscon property since the clock registers handle the
> > reset registers as well.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 22 +++++++++----------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > index 0b642bfce292..c6bf05c163b4 100644
> > --- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > @@ -18,8 +18,9 @@ properties:
> >      enum:
> >        - nuvoton,npcm845-clk
> >
> > -  reg:
> > -    maxItems: 1
> > +  nuvoton,sysclk:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to access clock registers.
>
> NAK. Not explained, not justified, not reasonable, breaking ABI.
Should I explain more in the commit message or/and the nuvoton,sysclk property?
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer

