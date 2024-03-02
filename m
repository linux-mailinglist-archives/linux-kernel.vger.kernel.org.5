Return-Path: <linux-kernel+bounces-89305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7386EE06
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4891C218B9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967627482;
	Sat,  2 Mar 2024 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqt5QWo+"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579756FB2;
	Sat,  2 Mar 2024 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344604; cv=none; b=AMMs5GCKeNnz+bzWudfzC6kpnm9HmG5l6K+BpvCENdAQbuMjg1s9QJxoaql3r+xjfOWUKpTCzWerub4mU7bkd40XbfdD40ggXOr7fu1BSZoP415esXzrZ9w8AbdjmdFkFwdhE7RCOs81IJKY4zvyN/eP3y12J8sv8a4/HtjXsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344604; c=relaxed/simple;
	bh=4He+PksBWilHxg+Qq6L94o151aUu8ph/uHKR1cVfTdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNhEvSahsWf985EmHrOmYxOEuhOLF7i1dLJv1s1KC+rKSoC5ANaG3jFVgzskA5Pbi2L0pqXQHPQ4YQS8qc+lIsVv9mBgQEUTEc4kffO8TOF7+dkXOa5DxwTUWWBep/3fdepaNmiWQc9TZ1pHnKZ2h0ziRimcxn9xe/nNBiwfudo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqt5QWo+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29a2d0f69a6so2053195a91.3;
        Fri, 01 Mar 2024 17:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709344602; x=1709949402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAjZ+kaDMbKRwjpcrRG3XyrYoFrf4nbBV7+HyQvCf8U=;
        b=jqt5QWo+NQlLavjbYyx0NwGN8FvKCvmg01P8vSonZQZx456wH9MQ0L/DvAtKCmokYq
         EDemalp1Ohvvg9jU8aNkTGY/eNQ1jWUA67tvuQCzIARV3vmbwDIYgtw93Gs8RdB9gIxg
         viCpyuXcFFao0lQudf/nZaNG/8mjk7mEG0hcisqZfhaJnHvhtB9PdpD9F81QF/YHc6ge
         nltDYdzLSR9p/JO6C2+Hy3w7ZWSVflQlogLM7yySet45Ws38RFobmKGnopAZ986uThww
         dGSLT3zf4xK1Fi4y6Vt9yoqiKB9f8OqifgWnuF0LTJCyW6/Q04A+6IIQFVlDBdCcpp4L
         Eulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344602; x=1709949402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAjZ+kaDMbKRwjpcrRG3XyrYoFrf4nbBV7+HyQvCf8U=;
        b=IhDwbrwzkIN0CWzJIQrXQ0d/4s+BlifADLQwHSfn0kK73q8W3rIqb6GGBIvfsSaqXe
         QG5gdE5zJhsAecYrXi1AAuxbsWAWepMnfoX/PFH34YEzXm1Z9lhbOQNPvzp+SOp/WieF
         xYvCvFBmY+CpGTZfkqDPgexDfRJaAbc9iRboqtO6Qn9VxTNXJERpkrDHEjadRAT8vPGG
         QebfwmaZavFmpmQXBD233WW9BK2oEnkowTSJAM+kqOoSBWh9PiywTHMEdCv16gapUAbJ
         svAfmmWKe4XuVMpVpe+wNO36bxgMsjWoGGEd7Ap0V5XQPCNLd7kflKLRJF23m2/dW07m
         mrkg==
X-Forwarded-Encrypted: i=1; AJvYcCUWUyexEcKb7O4i/HLVGHS4plaDzxxr/fSY09iTUGaG+Kl4FscrCFrgzg543U02sMKMbN6t5aEHZLASFexfbhLXPdaSa0vSH3ybVtyW+Rwec+y1ZzLlY1NXlvBsYKOX9v5CYw9YrGpXaiDW2QqiYyNlP6jEgB9GiyKjRmPv4IjDMOuZ+w==
X-Gm-Message-State: AOJu0YwcC3eyYAYLJearv0fAUAvFjpZ2BBjm04hvI8g3M88Wb0XqnOxf
	9Vi/jHcwdrdJkJzXWXMyAMX6vWwInB2AkJaM/oROkuVJYd/Mol9ylco6zzkLKCA=
X-Google-Smtp-Source: AGHT+IEZSaIuuq8xXQW17mRFdhgFLz6wv/6CBeltle2Te873kdRS3ixofr6VQxRP0FiVjG7TEMzIHw==
X-Received: by 2002:a17:90a:fb81:b0:29a:1708:9878 with SMTP id cp1-20020a17090afb8100b0029a17089878mr3559394pjb.38.1709344602521;
        Fri, 01 Mar 2024 17:56:42 -0800 (PST)
Received: from linux-8mug (111-248-209-112.dynamic-ip.hinet.net. [111.248.209.112])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902869800b001dbae7b85b1sm4118565plo.237.2024.03.01.17.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:56:42 -0800 (PST)
Date: Sat, 2 Mar 2024 09:56:24 +0800
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
Message-ID: <ZeKHSEcQ4h0nk8qb@linux-8mug>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
 <20240122140602.1006813-3-ghennadi.procopciuc@oss.nxp.com>
 <ZdmnQTtUxOEUy06L@linux-8mug>
 <ZdnIp8PPtfbuIzwP@linux-8mug>
 <bc9bcc98-62db-420c-b30f-e4af513cbd8c@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9bcc98-62db-420c-b30f-e4af513cbd8c@oss.nxp.com>

On Mon, Feb 26, 2024 at 08:29:31AM +0200, Ghennadi Procopciuc wrote:
> On 2/24/24 12:44, Chester Lin wrote:
> > Hi Ghennadi,
> > 
> > On Sat, Feb 24, 2024 at 04:22:30PM +0800, Chester Lin wrote:
> >> Hi Ghennadi,
> 
> Hi Chester,
> >>
> >> On Mon, Jan 22, 2024 at 04:06:01PM +0200, Ghennadi Procopciuc wrote:
> >>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> >>>
> >>> Add the uSDHC node for the boards that are based on S32G SoCs.
> >>>
> >>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> >>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> >>> ---
> >>>  arch/arm64/boot/dts/freescale/s32g2.dtsi        | 10 ++++++++++
> >>>  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  |  6 +++++-
> >>>  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts |  6 +++++-
> >>>  3 files changed, 20 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> >>> index ef1a1d61f2ba..fc19ae2e8d3b 100644
> >>> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> >>> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> >>> @@ -138,6 +138,16 @@ uart2: serial@402bc000 {
> >>>  			status = "disabled";
> >>>  		};
> >>>  
> >>> +		usdhc0: mmc@402f0000 {
> >>> +			compatible = "nxp,s32g2-usdhc";
> >>> +			reg = <0x402f0000 0x1000>;
> >>> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> >>> +			clocks = <&clks 32>, <&clks 31>, <&clks 33>;
> >>
> >> Same as I have mentioned in [PATCH v2 1/2], could we have fixed dt-bindings to
> >> replace with these raw clock id values (32, 31, 33)?
> >>
> > 
> > Just found the previous review discussion in v1:
> > https://lore.kernel.org/all/f54d947c-58dc-498f-8871-b472f97be4a8@oss.nxp.com/
> > 
> Indeed, I switched to raw clocks instead of placing them into a binding
> header after receiving this feedback on v1.
> 
> > What I'm worried is that, could these raw clock IDs be rearranged in the
> > downstream TF-A? If so it would cause ABI inconsistency and clock issues
> > since the kernel is not aware of any raw ID changes in downstream TF-A.
> 
> These clock IDs will become immutable in the downstream version of TF-A
> once the patches get merged. This will prevent any unfortunate events
> when the Kernel and TF-A are not in sync with regard to SCMI clock IDs.
> 
> Best regards,
> Ghennadi

Thanks for explanation.

Reviewed-by: Chester Lin <chester62515@gmail.com>

> > 
> > Chester
> > 
> >>> +			clock-names = "ipg", "ahb", "per";
> >>> +			bus-width = <8>;
> >>> +			status = "disabled";
> >>> +		};
> >>> +
> >>>  		gic: interrupt-controller@50800000 {
> >>>  			compatible = "arm,gic-v3";
> >>>  			reg = <0x50800000 0x10000>,
> >>> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> >>> index 9118d8d2ee01..00070c949e2a 100644
> >>> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> >>> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> >>> @@ -1,7 +1,7 @@
> >>>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >>>  /*
> >>>   * Copyright (c) 2021 SUSE LLC
> >>> - * Copyright (c) 2019-2021 NXP
> >>> + * Copyright 2019-2021, 2024 NXP
> >>>   */
> >>>  
> >>>  /dts-v1/;
> >>> @@ -32,3 +32,7 @@ memory@80000000 {
> >>>  &uart0 {
> >>>  	status = "okay";
> >>>  };
> >>> +
> >>> +&usdhc0 {
> >>> +	status = "okay";
> >>> +};
> >>> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> >>> index e05ee854cdf5..b3fc12899cae 100644
> >>> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> >>> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> >>> @@ -1,7 +1,7 @@
> >>>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> >>>  /*
> >>>   * Copyright (c) 2021 SUSE LLC
> >>> - * Copyright (c) 2019-2021 NXP
> >>> + * Copyright 2019-2021, 2024 NXP
> >>>   */
> >>>  
> >>>  /dts-v1/;
> >>> @@ -38,3 +38,7 @@ &uart0 {
> >>>  &uart1 {
> >>>  	status = "okay";
> >>>  };
> >>> +
> >>> +&usdhc0 {
> >>> +	status = "okay";
> >>> +};
> >>> -- 
> >>> 2.43.0
> >>>
> 
> -- 
> Regards,
> Ghennadi
> 

