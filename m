Return-Path: <linux-kernel+bounces-79509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0D4862367
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF231C222BF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B461759C;
	Sat, 24 Feb 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnv9z4lQ"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2681400B;
	Sat, 24 Feb 2024 08:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708762485; cv=none; b=sM4GyO8l+1aoAcTvYqDXQx55j0Fskd58Eb6IXPWe/S+B9olY2pd3kud58hX6fvVQNczQxKs6cafiIlwRgXfQB28pnYHwP763YuJZEGbKxKBzOlq38tU3SQTYQVw9wouJC/cr4nwlgrUlFZLcHDxdRi8O1tAH9M9RsSDl/dDiRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708762485; c=relaxed/simple;
	bh=Qhz9N/fmoRItK8W7Ipwzkn/wGHgDt+GnC9r4h0Wl+7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZebBevVcBzzvDFW3lXkOKiha0+doyIeUWiKSuSdq04h1nbNjtZ1KhjhVbMpavqui8VVYyxRTs2UlH/9NfoSr5TZmdMpgwqYlK0/xZf+BQWLuoXAr2yBwmhGbdBFgA5woRMr1gxfjYRQyMY8oWK66UFIlnPKUZ789wxNY3ykMU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pnv9z4lQ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so747916b3a.3;
        Sat, 24 Feb 2024 00:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708762483; x=1709367283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Li+1ch1KmBlW/URGhiU4Afn1fK88RrMkohfrJAlOTqA=;
        b=Pnv9z4lQp5WhBwTfiRGK2M/ojsXboTOjc3kjPDv3b0oqS/NEfWxl7tX+BcQJFTW0t9
         yDUTt1Adwctm6AwA0XuPKhmvfsLJVrz9EciQc8+CypqzvO+tfCJq8gGMy6YUcrsgAaBT
         Gi0N8+yoEpN51t1K9HJbHUTSShHwm7ply3TSjSNgwxGPo/PhiuLv7Vdekg4clIm2unZt
         qQW5O7NfdVK2hde5RhbolgVqDHSpc2lH79xkdAgE7SLIxWlyUDMlHrzSdav06aFtUYFk
         aBjZTcRUVTW6ibhkrZ8xKLPvIJ5XB3WWNSP7/C7Em1Zmnxm/rtFlRvv5ZxGTRvCMUovD
         qKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708762483; x=1709367283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li+1ch1KmBlW/URGhiU4Afn1fK88RrMkohfrJAlOTqA=;
        b=EU7uzZvTMGCqolHNZM9d0AebY2SR5MjTj4FXAnAIIwuI+tvNiitiOKTyKH/oERIzP+
         L5zragIGCIhMJQYYus8B+b7uSlatEfi/tcFuGpL02FkNfN/ktTtbofyMSb8UCM2m3cVM
         c19HuLtOBPim1K0I/FP68eF31G4olDV58hMyKYkDcOubjnMDCf7Rej3f4C3EG/l1oYeZ
         a9jB6Hb7PZlm5B+eQ+v7nOk8VW+YqCpYYqsVpJW4cyqf7iKa3Gs6Mz/fjc+q0tJHi87D
         rY0clHbRnXbsmgUOS4rnDyIMqU0C7SCZvevRn+zy/HmOpB6btGw4uVGxYAIkG4Cy9pWe
         HlSw==
X-Forwarded-Encrypted: i=1; AJvYcCWDHkvEildx0yORAQlJc0x1fNsJlGIi3klSrP8P/demHoPXcyJ38EgnHC6YiqeAaIcUSUkX+rf+G9tEQ+pvIPHuk0CQxYjm+KjlDqzTx5UyBPKcOYqYdZNjE5ZFZPBFCojCchqI6/SChWgAa9fj09YvEbRfzaks1cp4CzyKHD57qTyYZw==
X-Gm-Message-State: AOJu0YxA+tjBh5SaqJAmWa3HMOcXfY2ba+5SXFbBg0eXjN5xyPCXnGg8
	Hzmo9p3jnun09zg8C/NE7AuQmp3EctGgDTDV9wJRxy70k5VUnXqD
X-Google-Smtp-Source: AGHT+IFAhkrYbVSfRBTZ/EXXjiDnKExGzM6P/79vWS26AYFoZIC/I3bnnsgAxFkQCVZs+EDNz4NvsA==
X-Received: by 2002:a05:6a21:33a9:b0:19c:90fc:f0d3 with SMTP id yy41-20020a056a2133a900b0019c90fcf0d3mr2936969pzb.46.1708762483141;
        Sat, 24 Feb 2024 00:14:43 -0800 (PST)
Received: from linux-8mug (220-129-204-58.dynamic-ip.hinet.net. [220.129.204.58])
        by smtp.gmail.com with ESMTPSA id dj8-20020a17090ad2c800b00297138f0496sm2802436pjb.31.2024.02.24.00.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 00:14:42 -0800 (PST)
Date: Sat, 24 Feb 2024 16:14:21 +0800
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
Message-ID: <ZdmlXYq962azlVRe@linux-8mug>
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

Hi Ghennadi,

On Mon, Jan 22, 2024 at 03:39:09PM +0100, Matthias Brugger wrote:
> 
> 
> On 22/01/2024 15:06, Ghennadi Procopciuc wrote:
> > From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > 
> > Linux controls the clocks over SCMI on S32G SoCs. Therefore,
> > add the SCMI device tree node and the reserved region for SCMI

Is there any dt-binding required to match the SCMI clock IDs declared in
SCMI? I assume that s32g series will need fixed dt-bindings for clocks to make
sure there will be no kabi issue in the future.

Thanks,
Chester

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

