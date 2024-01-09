Return-Path: <linux-kernel+bounces-21261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39809828CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BD22874E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982BE3C6AC;
	Tue,  9 Jan 2024 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="2N821F09"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684993C693
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9b050e88cso1595360b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1704825025; x=1705429825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wuehQIOXoKxKvR7IfGc8qPJ5fDo+dRhQ24T0MSYH2w=;
        b=2N821F09EGeswp/UJdblxCiv7BMut/htPitEUV5Ii5NIQn+CBl2opbXWgLM90LIURS
         jY/EwIsuHrzKuMY25CYAo8meoGIhxIdMTTdMvIiDHg5MiXHUDMivu/YrJelEmVZf2wNo
         Zz0kTMc4GW24XkQIpAn05HSBWt0s9cKO3uHx5QrW3iFZPk+c+qY24H40ccdzROkolrwv
         d5MsejmDQlE3onwJaM8LrQxF69zRVv9obGNxvrQS4BGt3anNms+f6cbCdsAYx0Vl6XRB
         W9kfoDbz8su6fH7bclsEJxjr2wPIvy0gz1UNJE6xZ+lYJUmyGeOCT2GzLmI4eCnvBZH5
         utEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825025; x=1705429825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wuehQIOXoKxKvR7IfGc8qPJ5fDo+dRhQ24T0MSYH2w=;
        b=SPWVlorgVHWe+fFp4E9mK8bXBzTspSCuPrf2czM5czlKxVcvY+BK3Z3GNzayddU17l
         xoUAsTCMdv0QFlCFxTC4apCmPTOTKBZSrFbiB2+Xhj63W+YrZNPrH/GVbjk9PiVn39Kq
         38yDUF4WNEwo/SO4bul9FfI/R7gYBrYITYINBidYKeIxHxl0hRybLkIs1ttrkjOSvS9q
         508gcRP/td2H8sZrusf87Gz4YcEwuWucwuJOhFMfQuiSAFbgxoZUNRe+HKGAcKrPx54g
         hTt0pmi28YMb7uRrbYApKw+aBQNtWiaehQnPN5LJMJ+cdd2pkm9bI8Zn5GFhubErTgOf
         1HFw==
X-Gm-Message-State: AOJu0YyUHgKv3I/vUfGq8X27zScUhRpwehHfQQHEo0l6aHuWMoLkg49u
	Qm+Eyyf/6ZVExWGNXpnJAkpUaI3ZEhsQ
X-Google-Smtp-Source: AGHT+IHMaIlxFZkyAjIjl7Fnz8/lzJ5jA7vI2S3G0WFQ6c+y6vsFBpuUI1mJKNcRCD/KUkvTSdiCsA==
X-Received: by 2002:a05:6a00:1d8f:b0:6d9:a0da:4fbc with SMTP id z15-20020a056a001d8f00b006d9a0da4fbcmr2895967pfw.36.1704825024696;
        Tue, 09 Jan 2024 10:30:24 -0800 (PST)
Received: from x1 ([2601:1c2:1800:f680:6e8d:949b:d6c1:a68a])
        by smtp.gmail.com with ESMTPSA id b3-20020a62cf03000000b006db0f35296esm1543303pfg.148.2024.01.09.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:30:24 -0800 (PST)
Date: Tue, 9 Jan 2024 10:30:22 -0800
From: Drew Fustini <drew@beagleboard.org>
To: Conor Dooley <conor@kernel.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2 3/8] riscv: dts: thead: Add TH1520 pin control nodes
Message-ID: <ZZ2QvqlWYxgfHgQX@x1>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
 <20240103132852.298964-4-emil.renner.berthing@canonical.com>
 <20240108-majorette-overtly-4ec65d0a15e9@spud>
 <CAJM55Z_2zhELW3E7p94J05We17xTC2Rejs5AigNJOHCGHVr_zg@mail.gmail.com>
 <20240109-tiptoeing-twirl-ebb943e17a29@wendy>
 <CAJM55Z9Ka3hiNmgFuy01Yd0YyxL-SzS=A7S3k84=B1xABKbJhA@mail.gmail.com>
 <20240109-boggle-frugality-03a77cab8308@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109-boggle-frugality-03a77cab8308@spud>

On Tue, Jan 09, 2024 at 05:34:11PM +0000, Conor Dooley wrote:
> On Tue, Jan 09, 2024 at 06:28:19AM -0800, Emil Renner Berthing wrote:
> > Conor Dooley wrote:
> > > On Tue, Jan 09, 2024 at 04:02:01AM -0800, Emil Renner Berthing wrote:
> > > > Conor Dooley wrote:
> > > > > On Wed, Jan 03, 2024 at 02:28:40PM +0100, Emil Renner Berthing wrote:
> > > > > > Add nodes for pin controllers on the T-Head TH1520 RISC-V SoC.
> > > > > >
> > > > > > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > > > > > ---
> > > > > >  .../boot/dts/thead/th1520-beaglev-ahead.dts   |  4 ++++
> > > > > >  .../dts/thead/th1520-lichee-module-4a.dtsi    |  4 ++++
> > > > > >  arch/riscv/boot/dts/thead/th1520.dtsi         | 24 +++++++++++++++++++
> > > > > >  3 files changed, 32 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > > index 70e8042c8304..6c56318a8705 100644
> > > > > > --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > > > @@ -44,6 +44,10 @@ &osc_32k {
> > > > > >  	clock-frequency = <32768>;
> > > > > >  };
> > > > > >
> > > > > > +&aonsys_clk {
> > > > > > +	clock-frequency = <73728000>;
> > > > > > +};
> > > > > > +
> > > > > >  &apb_clk {
> > > > > >  	clock-frequency = <62500000>;
> > > > > >  };
> > > > > > diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > > > > index a802ab110429..9865925be372 100644
> > > > > > --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > > > > +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> > > > > > @@ -25,6 +25,10 @@ &osc_32k {
> > > > > >  	clock-frequency = <32768>;
> > > > > >  };
> > > > > >
> > > > > > +&aonsys_clk {
> > > > > > +	clock-frequency = <73728000>;
> > > > > > +};
> > > > > > +
> > > > > >  &apb_clk {
> > > > > >  	clock-frequency = <62500000>;
> > > > > >  };
> > > > > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > > > index ba4d2c673ac8..e65a306ff575 100644
> > > > > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > > > > @@ -134,6 +134,12 @@ osc_32k: 32k-oscillator {
> > > > > >  		#clock-cells = <0>;
> > > > > >  	};
> > > > > >
> > > > > > +	aonsys_clk: aonsys-clk {
> > > > > > +		compatible = "fixed-clock";
> > > > > > +		clock-output-names = "aonsys_clk";
> > > > > > +		#clock-cells = <0>;
> > > > > > +	};
> > > > >
> > > > > Did this stuff sneak into this commit accidentally?
> > > >
> > > > Not really by accident no. It turns out the clock tree has gates for the bus
> > > > clock of each pinctrl block and I think it's better to add this clock
> > > > dependency to the bindings and driver up front.
> > >
> > > Maybe if I had looked a wee bit more deeply I would've noticed that it
> > > was used there, but it's always good to mention the rationale in the
> > > commit message so that it's more obvious why you're doin it.
> > 
> > You absolutely right. I forgot to update the commit message.
> > 
> > > > Since there is not yet any clock driver the initial device tree for the TH1520
> > > > included the dummy apb_clk that two of the pinctrl blocks derive their clock
> > > > from, but not the "aonsys" clock needed by the "always-on" pinctrl. I thought
> > > > it was better to add this dummy clock with the only (so far) user of it, but if
> > > > you have a better idea, let me know.
> > >
> > > No, that's fine. I was just wondering why there was an unmentioned set
> > > of clocks being added. If they're stubbed fixed clocks I dunno if it
> > > makes sense to add them to the board.dts/module.dtsi files though. Where
> > > do the initial values come from for the rates? Out of reset values or
> > > set by firmware that may vary from board to board?
> > 
> > The vendor u-boot sets the PLLs different from the reset values. For now I
> > think it's the same code for every board using the Lichee Pi 4A module (and
> > probably also for the BeagleV Ahead), but it might still make sense to move the
> > freqency to the board instead of the module device tree.
> 
> Yeah, think so. Only temporarily though, do you have a clue if anyone is
> working on the actual clock driver stuff? Seems pretty Deadge?
> https://lore.kernel.org/linux-clk/?q=th1520

Yes, I am working on it. Jisheng passed me his work-in-progress based on
that original patch you linked to. I've been trying to work out an issue
with the emmc clock but it seems timely to share what I currently have.
I will post an RFC today.

Thanks,
Drew

