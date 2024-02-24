Return-Path: <linux-kernel+bounces-79571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1ED862454
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFD7284335
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53645249EE;
	Sat, 24 Feb 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFOsAdzu"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0421A0A;
	Sat, 24 Feb 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708771512; cv=none; b=YL5xOXOBsgPHLBXUczVcvjFjoYtrjjNeOIeKNw3WS9/eCWvv3seJZ0bqilEbTPWyd8y/rAOmqMvvPGoaC6jJE0c5EjKBmDdqyJT0CN9yPuSw6wMVKrdXDQ1sEPqClxXE4ms5OaPQjh17xl9dIX9jR/oNe1XiBvxLU2ah2owhZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708771512; c=relaxed/simple;
	bh=5svl/D2cmebuOMxgI6OVmNsXDJ7Bg4jtKgMY2jlkomw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQoKOuKbgXqqQ3ANeFa3mB9+/AWfUBribwcMuil807ACgX+/FfswVKluiCHjjCUrQPF/LphDY1t2F8FMA7A7mhP54yM9cDho4UVibcbcwyy9jBxWVWTfeG4hC2A1OFn4v1ZHvuOYtKcm0FMg2lwIqugW9xblUJF0lKTj5NLfzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFOsAdzu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d934c8f8f7so15013695ad.2;
        Sat, 24 Feb 2024 02:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708771510; x=1709376310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XVqOjvQSDEDKq31auMq76nWKFY0pe+j+Ca5udl4+VwU=;
        b=lFOsAdzu2PzGKlSknYTx3LvcOJXMe340niA+mO8cdHCHaELj/VqMBbD3P2M/IxGoVi
         Qc1sxCKu0RYTxKTvgkA9cuTXhEY7G3iTqNFG4erUZFdvpph3pj1bRt95yglKNnE6eTkx
         bjqqMWRMj/p+mIiYwYPNYEktyZQcg1ZG9oz5+MJMAW/4R+Gq95klXFsvft7wGZq6ybg4
         6LRFVvadYXdYw4JTJkbNWvpB2zJLO0XEQKEuYLakbGijWy6xZMZxtel0tNmHncPlPJyK
         LWKzpDkOxRQ/Cvk3G0oKlYj4EynL4z18WtTAFJyUCMADmNhN51D8V5GCc2McfkdtUcZY
         6Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708771510; x=1709376310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVqOjvQSDEDKq31auMq76nWKFY0pe+j+Ca5udl4+VwU=;
        b=SuUpNc7QbHjKJGwJHOAf7TlfoUx7ArHJ2QdTFaH+5po/BttgiAe5DWSOtrVywwiZrT
         YV+Dh4M5pweth6VUdyGH8eMsuXTDQpnLfvtAIhyD5tHPCDmA0zUK3qwGYDWffE0VuD/f
         zMJz9LGj2ZjjHmaRQQWSPJ+ihix2/X4Hs5Tltfh11vWCLLH2ZeEA3VowihwHjDDukTTk
         KtjldgMrICA/02ro/mwK2buxFboX9GQNbzw11B82019EfjBqx/Uc+b/OYKiWV3X0cHBk
         mcTmO4SjI7paKM+rcZco4uWUv/gsm+KaOSPKiUoEWcxIZh4BkMGimkJseW311xaswxBK
         jZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCVQGZqrfVt/AbUYlmV64bZuuyDd+/EgNiBonHm56culPncv3EjoTKiRWxFPY3mAapRRFY02X3+cywMQvW2f5WLtZHOIhll1pUZzH6Uqx3OPuWgGWqTDywYaUVBEATex7XGvlzO+SYgZva0lK4Gr0KwpIbeRFekqqpJ2pdvQNq3OfTsDSA==
X-Gm-Message-State: AOJu0YyCJx45OeI4DOomFXj8AEQXnxrpkRIcvtz8bTSAtrZEHfro8lBb
	AMghfvtM+bkTP7e4ZgX/SDG0JQoMgbMdIF2h0ZtEtOQgO0+Nym2i
X-Google-Smtp-Source: AGHT+IGTCcw1nPo5uilPjR3XkAVmnW1KGl5IrYp5yQPGFpjcH9vaGA0Owygfz8dt8AbR2tyHeqGzQw==
X-Received: by 2002:a17:903:2607:b0:1db:c6a0:d023 with SMTP id jd7-20020a170903260700b001dbc6a0d023mr1849674plb.8.1708771510260;
        Sat, 24 Feb 2024 02:45:10 -0800 (PST)
Received: from linux-8mug (220-129-204-58.dynamic-ip.hinet.net. [220.129.204.58])
        by smtp.gmail.com with ESMTPSA id ko8-20020a17090307c800b001db3361bc1dsm795726plb.102.2024.02.24.02.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 02:45:09 -0800 (PST)
Date: Sat, 24 Feb 2024 18:44:55 +0800
From: Chester Lin <chester62515@gmail.com>
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Cc: Andreas Farber <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: s32g: add uSDHC node
Message-ID: <ZdnIp8PPtfbuIzwP@linux-8mug>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
 <20240122140602.1006813-3-ghennadi.procopciuc@oss.nxp.com>
 <ZdmnQTtUxOEUy06L@linux-8mug>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdmnQTtUxOEUy06L@linux-8mug>

Hi Ghennadi,

On Sat, Feb 24, 2024 at 04:22:30PM +0800, Chester Lin wrote:
> Hi Ghennadi,
> 
> On Mon, Jan 22, 2024 at 04:06:01PM +0200, Ghennadi Procopciuc wrote:
> > From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > 
> > Add the uSDHC node for the boards that are based on S32G SoCs.
> > 
> > Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/s32g2.dtsi        | 10 ++++++++++
> >  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  |  6 +++++-
> >  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts |  6 +++++-
> >  3 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > index ef1a1d61f2ba..fc19ae2e8d3b 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > @@ -138,6 +138,16 @@ uart2: serial@402bc000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		usdhc0: mmc@402f0000 {
> > +			compatible = "nxp,s32g2-usdhc";
> > +			reg = <0x402f0000 0x1000>;
> > +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clks 32>, <&clks 31>, <&clks 33>;
> 
> Same as I have mentioned in [PATCH v2 1/2], could we have fixed dt-bindings to
> replace with these raw clock id values (32, 31, 33)?
> 

Just found the previous review discussion in v1:
https://lore.kernel.org/all/f54d947c-58dc-498f-8871-b472f97be4a8@oss.nxp.com/

What I'm worried is that, could these raw clock IDs be rearranged in the
downstream TF-A? If so it would cause ABI inconsistency and clock issues
since the kernel is not aware of any raw ID changes in downstream TF-A.

Chester

> > +			clock-names = "ipg", "ahb", "per";
> > +			bus-width = <8>;
> > +			status = "disabled";
> > +		};
> > +
> >  		gic: interrupt-controller@50800000 {
> >  			compatible = "arm,gic-v3";
> >  			reg = <0x50800000 0x10000>,
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > index 9118d8d2ee01..00070c949e2a 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >  /*
> >   * Copyright (c) 2021 SUSE LLC
> > - * Copyright (c) 2019-2021 NXP
> > + * Copyright 2019-2021, 2024 NXP
> >   */
> >  
> >  /dts-v1/;
> > @@ -32,3 +32,7 @@ memory@80000000 {
> >  &uart0 {
> >  	status = "okay";
> >  };
> > +
> > +&usdhc0 {
> > +	status = "okay";
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > index e05ee854cdf5..b3fc12899cae 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >  /*
> >   * Copyright (c) 2021 SUSE LLC
> > - * Copyright (c) 2019-2021 NXP
> > + * Copyright 2019-2021, 2024 NXP
> >   */
> >  
> >  /dts-v1/;
> > @@ -38,3 +38,7 @@ &uart0 {
> >  &uart1 {
> >  	status = "okay";
> >  };
> > +
> > +&usdhc0 {
> > +	status = "okay";
> > +};
> > -- 
> > 2.43.0
> > 

