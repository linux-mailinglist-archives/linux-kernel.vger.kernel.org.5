Return-Path: <linux-kernel+bounces-22270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8390E829BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334311F213BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D948CED;
	Wed, 10 Jan 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZxskO5+"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F44A98B;
	Wed, 10 Jan 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ebca94cf74so37826147b3.0;
        Wed, 10 Jan 2024 05:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704894474; x=1705499274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F+Dl/Il2vrbZxDbYc+SRyVGBLpDYXTxt7Tb1vd4cwvQ=;
        b=TZxskO5+F7i7ifTYtAahV9igz+0F75UmIFJavM8g3O2w79eklotRxdyQn1ynyCCmiK
         CLifijie7qm4DBswaqrrEuHwfZof8mws3m4v/1jjJyj2O8bPL3A4UMjp1VauWzSfzgyY
         x/Kb4LJAHJdJHUJ/JPHnELTDJS0QnPVIrVkKfc/VsZoA265dQphwLjfkoD7DH7EEBixn
         p9rtzP2aSS7oHopeCEUSS9JttrVzCVjHwnELvGszluCVSZKsz9cMWtLzCWSetifcj+co
         wnHty9fTnU7TrHIXCHmU5pLNFIlI7LOX9cCz5OQhf7CEITfYfn9wCfDZE68umatKF6ax
         yGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704894474; x=1705499274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+Dl/Il2vrbZxDbYc+SRyVGBLpDYXTxt7Tb1vd4cwvQ=;
        b=obYMQAK43LLfZiSXbGj0DX4dTma4fqBtPrhGFJtCDBeMK4AJT7eEi4w2zCY/1Ilh76
         aNKhWmnMr70+VT2L01Z4+2gyHnzi//J9MaCXUKBj5VWbjSDIuMIp7kEWMi6rr8Q+L9jy
         EqlTzJtw5/FiXmvYvNONH5TNAx5RiNXD+fX/72OVPdv19DkJ9yY6YformEscnSlwtXR8
         IBlJpKgG/3Y80/k7Os9sGtuPfoKr4Lsf1uPUidSZ2Roo/e5xNAH9ktfdk/DmJT4mf5WL
         vhMMV/0DpZMd11gyUNC0yoCJ635Rt0GlAKT9DFkgTt9EEUTg5497lvyMt9qFbuwGBEAb
         pS2w==
X-Gm-Message-State: AOJu0YzkksytFsTkXdoyRIe1GC8nv7D5nE24tq31QcVw3gXPQ7rvC4kl
	UDy0vwP9QIuvME/xY6itLHTEQbDhf/8AyN0JfWQ=
X-Google-Smtp-Source: AGHT+IF5GSh+GAYoRYse0osNDKjpebp3XYF6+cNYz6K9Yfp6hvlCj7DACrSbLrXqYpd5qwBs2GWfV/3aVWO2g9Owgg8=
X-Received: by 2002:a0d:eb07:0:b0:5f9:25b:398b with SMTP id
 u7-20020a0deb07000000b005f9025b398bmr855139ywe.52.1704894473970; Wed, 10 Jan
 2024 05:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-2-tmaimon77@gmail.com>
 <20240109170830.GA2772086-robh@kernel.org>
In-Reply-To: <20240109170830.GA2772086-robh@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 10 Jan 2024 15:47:42 +0200
Message-ID: <CAP6Zq1jCHVrFfRa6c3DZ4t2aaJTkWukeEkia0AqhzppC0mjbfg@mail.gmail.com>
Subject: Re: [PATCH v22 1/8] dt-bindings: clock: npcm845: Add reference 25m
 clock property
To: Rob Herring <robh@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Thanks for your comment.

On Tue, 9 Jan 2024 at 19:08, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 08, 2024 at 03:54:14PM +0200, Tomer Maimon wrote:
> > The NPCM8XX clock driver uses 25Mhz external clock, therefor adding
>
> therefore
>
> > refclk property.
>
> 'refclk' is not a property.
>
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/clock/nuvoton,npcm845-clk.yaml      | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > index b901ca13cd25..0b642bfce292 100644
> > --- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > @@ -21,6 +21,14 @@ properties:
> >    reg:
> >      maxItems: 1
> >
> > +  clocks:
> > +    items:
> > +      - description: 25Mhz referance clock
>
> reference
>
> > +
> > +  clock-names:
> > +    items:
> > +      - const: refclk
> > +
> >    '#clock-cells':
> >      const: 1
> >      description:
> > @@ -30,12 +38,20 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > +  - clocks
> > +  - clock-names
>
> New required properties are an ABI break. That's fine if you explain why
> that's okay in the commit msg.
What do you mean?
Could I add the new required properties to the required list?
>
>
> >    - '#clock-cells'
> >
> >  additionalProperties: false
> >
> >  examples:
> >    - |
> > +    refclk: refclk-25mhz {
> > +        compatible = "fixed-clock";
> > +        #clock-cells = <0>;
> > +        clock-frequency = <25000000>;
> > +    };
>
> Examples don't need to show providers.
>
> > +
> >      ahb {
> >          #address-cells = <2>;
> >          #size-cells = <2>;
> > --
> > 2.34.1
> >

Best regards,

Tomer

