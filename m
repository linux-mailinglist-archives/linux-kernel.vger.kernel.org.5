Return-Path: <linux-kernel+bounces-13165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6633820096
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F222847C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10212B6C;
	Fri, 29 Dec 2023 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="F1LpKjRR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA8125D8;
	Fri, 29 Dec 2023 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rJG25-0007qL-Bq; Fri, 29 Dec 2023 11:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=38VNaP7pfXM1GvqJGD2jWMf0tAg+ZbVq33Sknm8YBK4=; b=F1LpKjRRlV4aJDyJwf5s
	emr6NKrn13fWNmqGLjgPcyXXlVgH2GGhcJZs4XE/z3gQ28la1zmMOtGjNwAfLPpZF+Umij4bVDQfo
	xmK2BWDW2O+7299NW1wUs26WHr7Kx3/7sLVhf+tl1u7VJcIO4SUIFdssR0zkDGV+cIyipp+uAmhDS
	hBC9wFLDN2CYG71YD3y+7YuQusBQwFWHpQR3UklGaaHwjwhJJmhMFYT9EeXmIIbfp+0EyEIZGCZnI
	Fqr2h9clQUEhvKL264unK0tigYix/ytGRlBOlimm+ppF41lV61svejDheBTC97az8Zo52L0LH1cqh
	tek+S2I+pdZkhQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  NXP Linux Team <linux-imx@nxp.com>,  Li Yang
 <leoyang.li@nxp.com>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx93-var-som: Add Variscite
 VAR-SOM-MX93
In-Reply-To: <4e3a0328-0ae7-40fa-b37d-16b661e28a1e@gmx.net> (Stefan Wahren's
	message of "Fri, 29 Dec 2023 15:08:02 +0100")
References: <20231227170919.8771-1-othacehe@gnu.org>
	<20231227170919.8771-3-othacehe@gnu.org>
	<d378ad67-2a75-4a14-a131-7eb91de9ad3d@gmx.net>
	<87plypqi2d.fsf@gnu.org>
	<4e3a0328-0ae7-40fa-b37d-16b661e28a1e@gmx.net>
Date: Fri, 29 Dec 2023 17:48:21 +0100
Message-ID: <87zfxtosyy.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hey,

> I also saw in the other Symphony DTS a LED for heartbeat. Is it usable, too?

Yes, I will add it to in v5.

> According to the datasheet the SOM expose 7 UARTs, but only the debug
> UART is enable. What is the reason for this?

So those 7 UARTs are:

UART1: console
UART2: used by the microphone
UART3: used by the resistive touch
UART4: used by the ethernet/resistive touch
UART5: on J18.4,6,8,10 (used by BT)
UART6: on J18.7 and J18.9 (available)
UART7: on J18.3 and J18.5 (used by the M33 firmware)

I will enable UART6, and add a mention about UART7, something like:

/* J18.7, J18.9 */
&lpuart6 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_uart6>;
	status = "okay";
};

/* J18.3, J18.5 - used by M33 firmware */
&lpuart7 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_uart7>;
	status = "disabled";
};

> Btw the commit log mentions a Wifi (via SDIO?) and audio interface. This
> is currently not supported by Linux?

I am not sure about that, and I would prefer to study that a bit later
on if that's OK :) I can remove it from the commit log as this is
misleading as not already supported / tested.

Thanks,

Mathieu

