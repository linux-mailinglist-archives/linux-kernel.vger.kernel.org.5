Return-Path: <linux-kernel+bounces-80244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD8862C78
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC271F21A92
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EA9182AE;
	Sun, 25 Feb 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJk3G/t/"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7B1B81E;
	Sun, 25 Feb 2024 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708884420; cv=none; b=SHzTJZdApuPJjQymMycMgAb+b3brW24f2LmYH2Tm8MQkSYMs+y2kVn8o9c4ulrcuiM1jhBmyp6xmzr+XP64LQ3Hw3e5vZtjpNo8HMS3vmX8W/3LABSrTAj892CdX3IRNR08VCnqwuqBu9/67SNes4LY6kuMI8bPHXfT0lWL67Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708884420; c=relaxed/simple;
	bh=t9TH3IO25i1kABmwESoqJSXOGpunpKDuFCDvVlM+yrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzR4tp3ZaYyiyAqzyEj1bwgpw0hr8TVDv7QWoDThhCp6UzZ4US3mTo/rRD3N7GrimJ11V6S+i2TJffXOdRIsoipaF3DLy5cnn5rAEqVgYQZOaaLa2ME+gSfCF1539/863giZgWT2Z1u57Y3lEWfQZ9AuyMs0x/P6k9iclaQg7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJk3G/t/; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso2524772276.1;
        Sun, 25 Feb 2024 10:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708884418; x=1709489218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UyB5v20Xvkeo8vLOJ5G7Ayw3XFpy9UxBMT1oM+PlACI=;
        b=QJk3G/t/tSpXjTrNWAoYGQMlwyHV2ltR0Vnmk+7L+vObELPIH50GGigV6RQd8WPZKe
         4BKM5hnvIdwTXRpEBTMXRoFTzeGhVapL5qen11OkzTuMTkfKxqEnaaHcOJCIzejTxhKE
         gFIqZLCDh8uqQDqJE+Uha5T17qJzQFfui7DCEEAnl4pHcFdeZf7smLx8tRaUM8uc1AOf
         8avm8huruiC6zfcAI2qPSBxEumz0IsjdZQ+bSRbMmP+MSgTtvifxnRCpxJmT9sopSxyA
         m9jBsOzrgmBj8ahClSuSfH3CYjy/luXHkImE0MgcmZEX6m0pTwsQrFBLPFoZuxgWZaic
         SPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708884418; x=1709489218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyB5v20Xvkeo8vLOJ5G7Ayw3XFpy9UxBMT1oM+PlACI=;
        b=QD+EtY/bRiIiqIslAeawZgbkqDzPv7AzN60pkvskruO/EdIgvvlVf+YEN0AeRrbbP1
         JaSytUJwvQh0n97QtCCI0gU2M1gAjkaODGkNKp2lleoRBdCF1V7gt93mkSo3yb9JtOR/
         WHLRqitrKdDE6rffkSh8pAgwtD9WjPumeP1qpReFNE5dqyJq1z16DmKKNfc2MakyCrj/
         Mwmxu0G5M7CpSEy969Wz9tVIvPaI8YMPWrC4m5x784XUehvsq0vhxAaW3lM5bE5dVZ9f
         dQBJznKXQcWYlJdlDwRyuB2hiw0HRbi2YrgfPodXsWVuvZJ4PyjrUT8I+N5XZyoW0NVi
         Gw3g==
X-Forwarded-Encrypted: i=1; AJvYcCUlRsLmB2J/231pyEL4atMrCwO+KZ6EPX9hNUMujAxO5/zoO6pF39/pG7kLFi+5jfG+X9YLRrwW0u0Z71QZNPp4DxTEg27oCAdtwyc85jY+Oc2f6n4NjgylVJ69KW0R7uIjo+CKPlZ4TbBYIZ6lNcrXearGsKsQjKO3Bvs5ZOJ/IP55Lw==
X-Gm-Message-State: AOJu0YxxfN4KYMsyoHcGjRJ7WkXdbCy6mjGvMUSyVOLT0oQ4LT8WeTiY
	kpz+u8EzAIw+IG20V4OIQmPlpVChbsOSCY9q35oq3rbCOC6PNNEH4AZjXMKKPLkqfrHCQZkUIIb
	NE9BlQ6a/U+2dRsKROg7hR4zS04M=
X-Google-Smtp-Source: AGHT+IG+svL+R0QQtjbfole4iAKAk0sCbIV/24aVRBshgzy9tOplCpuFeVEJTnIBol1v6+b0OREk9APWtD3AvDe4zXI=
X-Received: by 2002:a25:9012:0:b0:dcf:464d:8ec3 with SMTP id
 s18-20020a259012000000b00dcf464d8ec3mr2767391ybl.3.1708884418030; Sun, 25 Feb
 2024 10:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131182653.2673554-1-tmaimon77@gmail.com> <20240131182653.2673554-2-tmaimon77@gmail.com>
 <bea8b72f61caaeac0ce112b57c28297b.sboyd@kernel.org>
In-Reply-To: <bea8b72f61caaeac0ce112b57c28297b.sboyd@kernel.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Sun, 25 Feb 2024 20:06:47 +0200
Message-ID: <CAP6Zq1jtYAg11EDrhJtzEOM+trKSpLuSbHPOx5ON93UDtr9JVg@mail.gmail.com>
Subject: Re: [PATCH v23 1/3] dt-bindings: clock: npcm845: Add reference 25m
 clock property
To: Stephen Boyd <sboyd@kernel.org>
Cc: benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, robh+dt@kernel.org, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, openbmc@lists.ozlabs.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

The plan is for both the clock and reset will be under only the memory
region handle like
                sysctrl: system-controller@f0801000 {
                        compatible = "syscon", "simple-mfd";
                        reg = <0x0 0xf0801000 0x0 0x1000>;

                        rstc: reset-controller {
                                compatible = "nuvoton,npcm845-reset";
                                reg = <0x0 0xf0801000 0x0 0xC4>;
                                #reset-cells = <2>;
                                nuvoton,sysgcr = <&gcr>;
                        };

                        clk: clock-controller {
                                compatible = "nuvoton,npcm845-clk";
                                #clock-cells = <1>;
                                clocks = <&refclk>;
                                clock-names = "refclk";
                        };
                };

is it problematic?

But this commit is not related to it.

Thanks,

Tomer

On Thu, 22 Feb 2024 at 07:58, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Tomer Maimon (2024-01-31 10:26:51)
> > diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > index b901ca13cd25..7060891d0c32 100644
> > --- a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> > @@ -44,6 +54,8 @@ examples:
> >              compatible = "nuvoton,npcm845-clk";
> >              reg = <0x0 0xf0801000 0x0 0x1000>;
> >              #clock-cells = <1>;
> > +            clocks = <&refclk>;
> > +            clock-names = "refclk";
>
> The driver seems to want this to be a child of the mfd syscon. Is that
> right?

