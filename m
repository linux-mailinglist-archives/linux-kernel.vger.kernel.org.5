Return-Path: <linux-kernel+bounces-89306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FF086EE09
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4675BB219C3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF597483;
	Sat,  2 Mar 2024 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzZplzVp"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8E7462;
	Sat,  2 Mar 2024 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709344668; cv=none; b=DGetEfjSArwBERgo8+z7Xxn0PdbI+EA7K7beTHGTF+clhjQLSWhcouNLIngTAFqhpsSLX61Y2GiEn/BHytUxr1+By7EoLGhLS2AT4G+nHs9VKOJTMqo9xXDtY/Kz89kKLbgk36oFbPOMRor0SKbUO6TabhPeUaf74FzF4A5U+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709344668; c=relaxed/simple;
	bh=vEbJOxLaLpVRoVoWasmjlDw6p78ReF4zm83sfr0xmFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QikTS36L64qUHaYpcOD1pa9BdIWQYTcrHx7zKfBGXlUm7oEq0XquzOqsRFmCN6g/LRm71SZz/X9eVwzZ69BW9Hazlq//RJprSgPaKg3YfHyJxGxMNPSW3s3s/nWBpP0GQYmV1zdtZTFAWgVfNeaGx5xOrsvi4Ee/H4cw3EhC6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzZplzVp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-299dba8fd24so2065174a91.2;
        Fri, 01 Mar 2024 17:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709344666; x=1709949466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGpbRY6Ql3ENUUIaWJTC4TKDZgjRVQXeNBSs+capKhs=;
        b=lzZplzVpXOpGuF2Pmh8LdY2WpRAjWKGfGoX12WnuFWlbz0WTUILODK4XKa1EfPuXKx
         OW3VzcGq25vAJ9trZuPfLBL7NeKQ/puJpQsPHoj0786NxK+huwjN+ZpQ1CfYgkvwXSBB
         vmPSx1zdAuY4XzKdVIQVYCnwZ/p1XzRlefx1sX9nTZkBPQ8aMXGcsaJR69sgv7Zk0V44
         pSbSJX/5g4S2qzWp2a6RATUXwTOLFe9K/NBTfDhxiNZoxz5zMqqSuAzS0fa6bN3ij4Rp
         fLdaVSLadzF1pei+FD32i6Qz6ZLR0j5at6Sir/X8qHWQUhsUIf4lnAYQBGflEOJ11kyz
         BjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709344666; x=1709949466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGpbRY6Ql3ENUUIaWJTC4TKDZgjRVQXeNBSs+capKhs=;
        b=H8toNyGVigMnxx3lW9hYg+5j0JmnZ1oef0H9Dk+76z/nalgzvur9rKujqGDAq9lnjj
         gl7DgAizF6dwa16KqRq8kT6Y+0/vJ87DX4zNpHPxKW8hjR5Zjd/lWug2/e/hvFsQAnCU
         Zg8fX4ppe50uSu7eqFPHHBAbKmZMo72VHL6REsSHa0w4Cr+jBkvX/eQXyTVghCnuMVz1
         xsKxJSD/v9SPSx3lk2f5VROr8awlWks+do2qb00LhnUbJyCnplaFGGQF7nrBQ2zMq+aL
         fEo/KWcaFKrsD4m5jTU/EGwQ0Rbd0ulin0AXfhWbJagIrx0R8HpqO6Ec/eTkf08rjNJx
         2HBA==
X-Forwarded-Encrypted: i=1; AJvYcCU7u1sTEEdl7jqNjJIEzwatguy93quzl23KKjSzYMNaB16V0inS2RuKU2pxlSYV+h7+qggAVP9/N4Ss9t3qFmV2QC3vtnVJEOdpVmbHeq6cJroXwc5Htv4Z3j01rexljOe3MqiTUeWf/XpFkkfz0drwcgG4rsIsBq77UAaDe0Ki3lkjQQ==
X-Gm-Message-State: AOJu0YxRA9wY2e1bNLBsJgptvXlqrAnhxLJmMGwK9caJXObEdY7b9LRF
	LAQr6sAp83itjgUifK4fx/mVLq/IhQpfjypYa/TcIHfu9fGlOOfK
X-Google-Smtp-Source: AGHT+IGROzWZgMcBBDh5RQYHFlXb2T/GDImxNpjfPkcwu5EPMszjrc1ObnFc0I5PxOzGt6SQpXFtXg==
X-Received: by 2002:a17:90b:4f4e:b0:29a:59a7:951d with SMTP id pj14-20020a17090b4f4e00b0029a59a7951dmr3173452pjb.5.1709344665992;
        Fri, 01 Mar 2024 17:57:45 -0800 (PST)
Received: from linux-8mug (111-248-209-112.dynamic-ip.hinet.net. [111.248.209.112])
        by smtp.gmail.com with ESMTPSA id db12-20020a17090ad64c00b00298ca3a93f1sm6166007pjb.4.2024.03.01.17.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:57:45 -0800 (PST)
Date: Sat, 2 Mar 2024 09:57:40 +0800
From: Chester Lin <chester62515@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>
Cc: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Andreas Farber <afaerber@suse.de>, Shawn Guo <shawnguo@kernel.org>,
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
	Catalin Udma <catalin-dan.udma@nxp.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: s32g: add SCMI firmware node
Message-ID: <ZeKHlEyvtpx3pdSA@linux-8mug>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
 <20240122140602.1006813-2-ghennadi.procopciuc@oss.nxp.com>
 <94742ebd-bc3a-4726-9ba7-5954203e4da1@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94742ebd-bc3a-4726-9ba7-5954203e4da1@suse.com>

On Mon, Jan 22, 2024 at 03:39:09PM +0100, Matthias Brugger wrote:
> 
> 
> On 22/01/2024 15:06, Ghennadi Procopciuc wrote:
> > From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > 
> > Linux controls the clocks over SCMI on S32G SoCs. Therefore,
> > add the SCMI device tree node and the reserved region for SCMI
> > messages.
> > 
> > Signed-off-by: Catalin Udma <catalin-dan.udma@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> 
> > ---
> >   arch/arm64/boot/dts/freescale/s32g2.dtsi | 27 +++++++++++++++++++++++-
> >   1 file changed, 26 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > index 5ac1cc9ff50e..ef1a1d61f2ba 100644
> > --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > @@ -3,7 +3,7 @@
> >    * NXP S32G2 SoC family
> >    *
> >    * Copyright (c) 2021 SUSE LLC
> > - * Copyright (c) 2017-2021 NXP
> > + * Copyright 2017-2021, 2024 NXP
> >    */
> >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> > @@ -14,6 +14,18 @@ / {
> >   	#address-cells = <2>;
> >   	#size-cells = <2>;
> > +	reserved-memory  {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		scmi_buf: shm@d0000000 {
> > +			compatible = "arm,scmi-shmem";
> > +			reg = <0x0 0xd0000000 0x0 0x80>;
> > +			no-map;
> > +		};
> > +	};
> > +
> >   	cpus {
> >   		#address-cells = <1>;
> >   		#size-cells = <0>;
> > @@ -77,6 +89,19 @@ timer {
> >   	};
> >   	firmware {
> > +		scmi {
> > +			compatible = "arm,scmi-smc";
> > +			arm,smc-id = <0xc20000fe>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			shmem = <&scmi_buf>;
> > +
> > +			clks: protocol@14 {
> > +				reg = <0x14>;
> > +				#clock-cells = <1>;
> > +			};
> > +		};
> > +
> >   		psci {
> >   			compatible = "arm,psci-1.0";
> >   			method = "smc";

Reviewed-by: Chester Lin <chester62515@gmail.com>

