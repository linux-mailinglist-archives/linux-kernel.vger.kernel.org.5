Return-Path: <linux-kernel+bounces-111779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B88870DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B558F1F230C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05957864;
	Fri, 22 Mar 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7Ihghk4"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC156B98
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124960; cv=none; b=CX5McPpyw4J3WryvGPTkF3sneaK1/aHdLkJXqe9ImdetL+InWy407AKBQyOug6tS2aVU60td3Zl8y598GZxoK2bQx24FMbfCmELnnhLc3xWAQf9lJmPTqRXdD9L7g7w4C61gBcMJ15kDEFbD7AMr9QCtyMWf5boFuboDNDw7ID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124960; c=relaxed/simple;
	bh=NeAqeTVeviIxXnXomn14RmAblPjhwq1FWPD7pUA+ghI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIObE0sXueyxFZb8JmwhsP3Zci4IDyCc3CZfy2+gZzAGUxU2W7rhqpfFR1zySwwlXDNmCFrt19YT87G1S/v3YGP93d1P4I+Fn3BmAYmeisojZ8FWspYiX52q/i1jtxv5SFAN7YVUDovDR/kqBF0ETLwQvNjPBnWKJwcO5ZI+p3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7Ihghk4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso23035a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711124958; x=1711729758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeAqeTVeviIxXnXomn14RmAblPjhwq1FWPD7pUA+ghI=;
        b=c7Ihghk4HSJ4mxv/GG3WY85ZmR8JajFHW+yj+ySd/gyV+3kEweEAB2KIM/YtfDwmAw
         W+DwuQE1Nh/u3ZiUK1q6o2EZmyocSHKaful6blkVyog45Wy/SP1bv3hlOmrxQMfY8kU0
         EqfkyYxdAXuvZPBQX5+S0895Vm4ppLHQiKhEPAH25IHe3wH/4VqX8P3V7z7AM89XbE93
         /oZXgJvXRLZwjdxxi3eyIrtleiAaHdWKFPX/eFT7XBS8oEMQT4+AE78aYPFPiGLAlOw5
         mkpx3PvSHx9Yi/hW5B6Nw8/3jlmJEcdzJ4czC6glaf+uxO+P+WvEL3iOY47YRswK05Ig
         s0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711124958; x=1711729758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeAqeTVeviIxXnXomn14RmAblPjhwq1FWPD7pUA+ghI=;
        b=qGXE5Qif0LUKRlspW+bBU11ZImaXHe1W96/POjaqOftWNw8hlKJkD+iC3SEGP6hKdA
         fFjsb3g5LeP0pmJDdkNiwSMx7bMF0QOq9/TMlJGvNQYIHfimkKAG+vyaVTJSPfbpbq/y
         /qXp5tKb+zXLFwpDKJj77OmOrkiIkVqV+DtzHWBQulWudGzKrXRPhMOAdUFUlaLy8xiv
         3WjxjE8y103tlwR30hwXJjVXp1kas3dL1bjEEif0i9a5J5bgPEGTpgeVAHrXtT3VIJ5I
         gH+ECQuHyfrmucETUZejP/dFUsIaalQ9x/wEDf3Mh53DBff9TCVqyZsM54G53nsd1VHC
         w8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXbkWnosz7RmycRqq3StO7NxIYguxZVqQrV70g0/0TWx6xgf5VNXdtd7YEo0/MI7+PJpi6erDjzWFzvd4QGBzxbgUcYW1Jy9mv3b98e
X-Gm-Message-State: AOJu0YwkndnlNhfDg2GTHTTgVOHlhR3FCbRKEYDlYNPd5I/N4jHqcUHN
	jUzmOw8/FsslqduKmgc7x2RZymnS2G5soFbdok8T3i8bAWP943JuyN9hgk0k1oiy2p9vEWQ6mYM
	B4FcsD80n64W2eq/n57v4QjFuvWI=
X-Google-Smtp-Source: AGHT+IFjaOeAw9XGYO7zNRizWZ0C8XANLVydJhzwF7Py8oqF8bVQ/2sMI4hkhGm8mTPw1JtDipQd8lCaIGqro0z4hnM=
X-Received: by 2002:a17:90a:b395:b0:2a0:350a:a7a8 with SMTP id
 e21-20020a17090ab39500b002a0350aa7a8mr123918pjr.2.1711124958335; Fri, 22 Mar
 2024 09:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322130646.1016630-1-marcel@ziswiler.com>
In-Reply-To: <20240322130646.1016630-1-marcel@ziswiler.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Mar 2024 13:29:05 -0300
Message-ID: <CAOMZO5ANM-ze3=ZG33ZgO+=4V_z5QJhqherB_d7WSe33sVB21w@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] phy: freescale: imx8m-pcie: facing pcie link-up instability
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, 
	Lucas Stach <l.stach@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
	kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>, linux-kernel@vger.kernel.org, 
	Marcel Ziswiler <marcel.ziswiler@toradex.com>, Heiko Stuebner <heiko@sntech.de>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Tim Harvey <tharvey@gateworks.com>, Vinod Koul <vkoul@kernel.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Fri, Mar 22, 2024 at 10:07=E2=80=AFAM Marcel Ziswiler <marcel@ziswiler.c=
om> wrote:
>
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
>
> In our automated testing setup, we use Delock Mini-PCIe SATA cards [1].
> While this setup has proven very stable overall we noticed upstream on
> the i.MX8M Mini fails quite regularly (about 50/50) to bring up the PCIe
> link while with NXP's downstream BSP 5.15.71_2.2.2 it always works. As
> that old downstream stuff was quite different, I first also tried NXP's
> latest downstream BSP 6.1.55_2.2.0 which from a PCIe point of view is
> fairly vanilla, however, also there the PCIe link-up was not stable.
> Comparing and debugging I noticed that upstream explicitly configures
> the AUX_PLL_REFCLK_SEL to I_PLL_REFCLK_FROM_SYSPLL while working
> downstream [2] leaving it at reset defaults of AUX_IN (PLL clock).
> Unfortunately, the TRM does not mention any further details about this
> register (both for the i.MX 8M Mini as well as the Plus). Maybe somebody
> from NXP could further comment on this?
>
> BTW: On the i.MX 8M Plus we have not seen any issues with PCIe with the
> exact same setup which is why I left it unchanged.
>
> [1] https://www.delock.com/produkt/95233/merkmale.html
> [2] https://github.com/nxp-imx/linux-imx/blob/lf-5.15.71-2.2.0/drivers/pc=
i/controller/dwc/pci-imx6.c#L1548

The detailed information above is important. It should be in the
commit log of the patch IMHO.

Thanks for the fix.

