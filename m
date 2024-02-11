Return-Path: <linux-kernel+bounces-60913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97470850AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F90282ED0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A05D758;
	Sun, 11 Feb 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fiziFszN"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DFE5C5E8;
	Sun, 11 Feb 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677733; cv=none; b=Zd85YfdnyVK6fGeRtGIa2c8hB4wZPKAQM7F8lY535oSTbXw4QbtnmSnKfKA/MAocl2gmPtX/iIRZ2eOr5MchQuG+RBk3NAI+RIav/kK627KFGLb+/qsmZiefPYeAAEpg/u08P+LLzHThl35vdxorJnZo+6lPLYIbZ1/EpqiZ0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677733; c=relaxed/simple;
	bh=o4EUdcycJYoX6utonVd20XMLBJXsW2DxLdu5vp9IXUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTYUtahBUZc2WTnqFG5/yhNCXpJ95pTTCW8nUhjauCW6h9odn5ynGJ2Y7Dle6spKtHbz2xLqisjcqEURrFcC8EXfU93O4kuT4mJRRfvcSLLQtVmvkG4Kf9OSKMJ7vgzS5VWNbxxRagqrWif15lUs8QRhXUwqO130tGXSiOHGGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fiziFszN; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 91D4D87B71;
	Sun, 11 Feb 2024 19:55:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707677723;
	bh=T3BcS+Oe2i97YKSCZYhRXLq4o/rrJHTgklytQd/lwi8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fiziFszNEAhnu2Zt2C1n9acnOewnvx1+Yrz+Q+8c2DIGNJNazY0I6U2aio6MrYFEq
	 hVdjLmzJYjOa2acEfd/VHZhWc1MH886tdGwGrri3wKMjvLh3HD9Ku01xP393iXw9vl
	 tlOgOZaIV1Gkv3rz6cEuSUgaEDEezoIOYG7QCIL3ZS8DaBYTKrklIwFX5t+CdPszjv
	 5z499XYAHiu7n4dyoeKbrVq5LWGKPWEYObsJNegB8hKjGL4BSIysPgGT3BWEd95CxJ
	 9EOOceyiIhb3pdkPcDK7v9siWfDzuplB7bICsJdDZJ39SmExRw0k1uImur+cL7/97N
	 L0kyhhG3j/qUg==
Message-ID: <dda8ca75-1792-4933-9240-39259ae721b7@denx.de>
Date: Sun, 11 Feb 2024 19:51:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/6] phy: freescale: add Samsung HDMI PHY
Content-Language: en-US
To: Adam Ford <aford173@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Richard Leitner <richard.leitner@skidata.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240210204606.11944-1-aford173@gmail.com>
 <20240210204606.11944-3-aford173@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240210204606.11944-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/10/24 21:45, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the driver for the Samsung HDMI PHY found on the
> i.MX8MP SoC. Based on downstream implementation from
> Sandor Yu <Sandor.yu@nxp.com>.  According to the TRM, the PHY
> receives parallel data from the link and serializes it.  It
> also sets the PLL clock needed for the TX serializer.
> 
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> (v2)
> Tested-by: Richard Leitner <richard.leitner@skidata.com> (v2)
> Co-developed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Tested-by: Marek Vasut <marex@denx.de>

Thanks !

