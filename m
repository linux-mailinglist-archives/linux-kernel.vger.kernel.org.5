Return-Path: <linux-kernel+bounces-62270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B252851DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA00282B95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA246549;
	Mon, 12 Feb 2024 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="d9B3RZDC"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDA3FE2B;
	Mon, 12 Feb 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765658; cv=none; b=aj2J6qlogb5doPoX7h2rO6KSP3KOBsUuzKOFavFzXbL8ag2sPSFN6WBg3HEuaOIBJeoeXOrojGoL2XcN8pviEcjAFt1Vm+OqDaV4rt6sNIx///Y9wTcRBL1GKodol/O/C5ScnziKz/JfZn9pXhRfdlTRQ7T69vV/bI2T1DfP0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765658; c=relaxed/simple;
	bh=m/nnbo9t9llzuDrjDfg773KWN06cSwpoOOsPm+Rso+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8vS8TTd5Yr+ZBHmlPp6W9uhmQlqkt7fHYXGlQRfF38dEfGzw6Yzo2jyaOGlq40mGBwJWkbEnwUGVtaEs11gqp6Umn15RNIkzJYTFmnXNcACt6mMDAE+kQOmu2B7A4vhx0dv+lT/QQnSjUPKDiNzhiRyRLo9VZt3dM1Il2QgT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=d9B3RZDC; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707765636; x=1708370436; i=wahrenst@gmx.net;
	bh=m/nnbo9t9llzuDrjDfg773KWN06cSwpoOOsPm+Rso+I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=d9B3RZDCKG+aC5fWmGtKT8Et/C/xrs9t53icpTEisB48pJ68e+JQlGnsSs/RCPLo
	 G15KKjxeD29kRd2EoZm6lOskWZpfl879hDLXNSkInJdNz6oDwYmmlFen3un1tQdGV
	 jpBvXtoeKPm83Nu7j46SxMdEZ8WWPeluTPaAmhIKEYsqMLV6KUb3Qjvd98iLKNFXt
	 6uDYi8OXPxdWLT3OsMYwENX0Byd/qB8spA7XEWZjc1o7Tu6XpolHQXkKR8kiUwojv
	 1aQ7sdPYiFCRrGmsm7ZHF0ayoesfmEJZUq2SoyRxescPXlAwEJpTHDDn0KJw6c7Dq
	 0OFbw2UU+g9e9S+zYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1rFBKI2pMw-00KO0E; Mon, 12
 Feb 2024 20:20:36 +0100
Message-ID: <a8b55331-a8c3-457e-83e0-2aa361ed23c6@gmx.net>
Date: Mon, 12 Feb 2024 20:20:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/14] dt-bindings: lcdif: Do not require power-domains
 for i.MX6ULL
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-8-sre@kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240210012114.489102-8-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cEsgKI+16Md82LZUqRfviCaQzTwOZv1uZIdgBUf6C+ELFNEYV0k
 fDL1uyXfCIlTaE9owHzJ071BBatiJerEu7IR700PB+hciPB2rUpLLREZvAVMdJkJp2RGfpu
 bz9yIAqAiEe+MoLYMR58r/fq/YK69wXem+SZ9sz0bswn28MMB2A60r1/FkTiMP/YxP+qHuE
 77addxEgbXXd+Jdqm58jA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ThW6baTiFnw=;0wRr/fpi7cJZ8csHtNlVFmrtbV+
 u21Tio09hN7ZMiu4raYPf5QbiCLC3cW1hmYN2/+cSX770STkW3zTqa/RSURma7PtILUP2rug6
 hcuAAlXKWKIIfYD4b3TfRse+O3wS0IrVLUHTkaLbMNMIDeMGW2EQx0PXBiDUA5m/BORKcGddM
 MmBSG9pyKkcPuH4HTZtDHBOgrSmwOw1UuFn6HfN3mUj8iCZIrCcirO9IFFaihfZ36kAWYA8qd
 FH3v+Rx74yJEgSCK+oTDXlRLpBAthy/GrYCJTsV2TipeVniFQ4AXQtrxhmvyyblp+umpw8GXa
 Y0rI4H6x56EtvG+PuyYW09LCikS2+9l2lQiv+/Pof7gZbU741bDhx5fetNaBkKNRMZOawP53E
 EXselfOW1TtjeYFMXWSopvtKDAyjqaIn25YJaLdsCA1pBcshA+D2CUfeSZB9N73LOgOO4tBpS
 jcaSMHMKosvCD8VsDCBjMcz+Km9iMOB5MXy9vMmOdNzAmzXbYRa+H3VcJ0Qn2kcRPCkVKMVMv
 cUeo6ciRKneQmkvPFlLQaOEM9HufTow/zCtygKvH3Lm8Yy+sAklIL1LQT/ipF709p2TL70dlZ
 AGwHaQyDuX/K70WCkUfOQFJf5xxkREYzs01G7oxWbxLoXYrxV0k9Q3LwdHADmDHH0G3uBRrgY
 R4AQIZnNeasSdJ01gVwj0NmxZnqSPUO1ZkeGiQmZzAK2inNnsFzwzI8pEyBtZDFLJFJpAo6CM
 uq3jBbn9QYvPMfxe+sxwjx7+yJIKYGDvsphKrB0n3JSiEYUR/KWNsQsWHNxutq4BJF5H0DIJO
 peryN63vGuI7BEC8SwCau+TCzP6Jq8IoBlavLVsbziFyE=

Hi Sebastian,

Am 10.02.24 um 02:18 schrieb Sebastian Reichel:
> i.MX6UL(L) uses "fsl,imx6sx-lcdif" as fallback compatible string,
> but has only very lightweight DISPLAY power domain. Its DISPLAY
> power domain is not supported by the binding / Linux kernel at
> the moment. Since the current setup is working, let's remove the
> power-domain from being required for that platform to fix the warning
> printed by CHECK_DTBS=3Dy.
i'm not sure this is a good idea. In case i.MX6UL(L) is different from
i.MX6SX here, then it should have a different compatible.

Regards

