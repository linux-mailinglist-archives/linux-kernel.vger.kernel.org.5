Return-Path: <linux-kernel+bounces-105294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99787DB86
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D68B2119A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694101C69A;
	Sat, 16 Mar 2024 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6loINwz"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C48179AE;
	Sat, 16 Mar 2024 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710624845; cv=none; b=t+k6GQNLAg/U62Yq9bUIvJ61HdeJYaeVRR1NU/rTtSaAz2Zgm7dTMBp4tDqknD6oMuSlL9y3DXqyXk+0lbawW+CBVgiWCLuMoPP6mXr4TBxlB+CX/7VjXPJPN1Yd6BitDXPq5W93WStLIe/XY2LP3hBEN0QGHAfloQU6SPhC6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710624845; c=relaxed/simple;
	bh=eGSHNYo6iTNwAWnvsKwGTlacpriiLssspZjHuMssVT0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3zwsDx7/5QMq1szgsCUwVM0fX3GeeC6XpK7m0FSsXlGvqZ17ExBu18SJ6zCI4MmsMzu+MqCUpGvaW27mp7GvmKdTpTl1NxMEfxOeLs6x08DhPfgh55/U21D3aN3o7YVRKD2+MwDGTEePy7TzdCW0zqKA424RO/zsdenTRe/qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6loINwz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a466e53f8c0so409243866b.1;
        Sat, 16 Mar 2024 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710624842; x=1711229642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3K3Xj+4K2+7t2UBVw1YNMS/5uNqg9Yzu7R/sU+HTXQk=;
        b=G6loINwzMQ6Q4Q5OUVp1WJLdjArl/PzMybeQzY4qcisj9Sg1GVawaSmK94pLHzFjTV
         DRwu3Nv15NfgS4QVAWVWDddkZbps2jEPMkJIWmL/OCtJWerFq+8AgbsBZD5Zgyy3Ufa3
         mL57x2uL7O3j2pOydZh1454QxWuZBD93718k+t7VaWVHHP+uy1e9CjxuFWr+uTaiA7mG
         lLuv1qxyU3bJFHZfeotGcC4E9dEeoEEgSUC0oXAvpeMw6avLnEOqw9EPg3RRsS5HKPJn
         MjymsTtoPv11QSM09J6j7R0M7N8SVg8S0YXUU5FSjD/hkhkbGTnG5iMxwoe+vOeDCdKR
         xm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710624842; x=1711229642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K3Xj+4K2+7t2UBVw1YNMS/5uNqg9Yzu7R/sU+HTXQk=;
        b=lMz9CTjjMdmVC6yJMZQCmPCBf1hOAsk+v0n3H49nuI7ZlztIoy5qr3ffwRBkaU2btW
         Srtg5vprHlMWOUQFHmHR6KRTvLlA8sMbl/SDnP4MPN9rYEPvGqxu2IdFLOhYB4xbXFcu
         8dNkRBKa2Z/Zx5oJ+FyMjKE0EU41+8Y5VngwMLtBIg9QVArFvRIwVPYnMUreb+SGrC52
         ugLh13ozV1dOXH2K7QYrXJFFdnPfxs5NSXAVChG/Fv1BnRawbvnHlpcbO6IkGyHIwV+z
         A7eK00zvauUanOttq7jGzeokzQoLvM4jbolZhnKrLk3TNyc8akoLhO4vjdx1J+JcarqQ
         7yZw==
X-Forwarded-Encrypted: i=1; AJvYcCVta+R8zmo+/Z3DQ+FWc5NPSHwk76sJIypdUSTebMObDTmrjFesBCRR1VcET/TSfTmiDyn3jZpXB3admfQqtADrH5A7+HeDO4r1CShUyeS0Gl04fr1w377cBgi0tJCfomHMqXPyfKUynD8mHwPAlks5/WOJRm82F87k7WzIW3XvdfPsHpAKxrESPaZP2gQdc8AER8vuQqogdmmJHg==
X-Gm-Message-State: AOJu0YyLVYbBalt5jGnp4pzTV875HoypxRRzoI5+LrSoYY2s6hAv8R1T
	sANy797HdDAg5O18fMsx2NRxcm8d2YTembVc0ieIAFkxU9EJ6d4C
X-Google-Smtp-Source: AGHT+IGh6hRlI2QPgnitjywTHfHqxMiHgBs2kiVtdspFsEmU+BIU4SDZtu1WpQjRFIVwATWylvGBoA==
X-Received: by 2002:a17:906:bc8e:b0:a46:6433:2c2 with SMTP id lv14-20020a170906bc8e00b00a46643302c2mr5658917ejb.53.1710624842092;
        Sat, 16 Mar 2024 14:34:02 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::f845])
        by smtp.gmail.com with ESMTPSA id bq8-20020a170906d0c800b00a46550ec5b1sm3115069ejb.32.2024.03.16.14.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 14:34:01 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
X-Google-Original-From: Wadim Mueller <wadim.mueller@continental.com>
Date: Sat, 16 Mar 2024 22:34:00 +0100
To: Stephen Boyd <sboyd@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johannes Zink <j.zink@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Message-ID: <20240316213400.GA5628@bhlegrsu.conti.de>
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-2-wafgo01@gmail.com>
 <3cd275cb1f53a5fdfbf7028f233f4fd7.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd275cb1f53a5fdfbf7028f233f4fd7.sboyd@kernel.org>

On Fri, Mar 15, 2024 at 03:41:14PM -0700, Stephen Boyd wrote:
> Quoting Wadim Mueller (2024-03-15 15:27:47)
> > diff --git a/include/dt-bindings/clock/nxp,s32-scmi-clock.h b/include/dt-bindings/clock/nxp,s32-scmi-clock.h
> > new file mode 100644
> > index 000000000000..240022c1f109
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/nxp,s32-scmi-clock.h
> > @@ -0,0 +1,158 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause */
> > +
> > +#ifndef __DT_BINDINGS_NXP_SCMI_CLOCK_S32_H
> > +#define __DT_BINDINGS_NXP_SCMI_CLOCK_S32_H
> > +
> > +#define S32_SCMI_COMPLEX_CLK           0xFFFFFFFFU
> > +#define S32_SCMI_NOT_IMPLEMENTED_CLK   0xFFFFFFFEU
> > +
> > +#define S32_SCMI_CLK_BASE_ID           0U
> > +#define S32_SCMI_CLK(N)                        ((N) + S32_SCMI_CLK_BASE_ID)
> > +#define S32_PLAT_SCMI_CLK(N)           ((N) + S32_SCMI_PLAT_CLK_BASE_ID)
> 
> I think we've been recommending that scmi clk consumers simply list the
> number instead of making up defines for them.
> 

yes, that makes sense. Was not aware that this is the recommendation. I
will get rid of this file completely, and instead hard code the numbers
into the DT. Thanks for the hint.

> > +
> > +#define S32_SCMI_CLK_VERSION_MAJOR     (1)
> > +#define S32_SCMI_CLK_VERSION_MINOR     (0)
> 
> Why is this part of the dt binding?

yes, this is stupid, you are right. Simply missed to delete it! As the
file will be removed, it will be gone on the next spin. Thanks.

