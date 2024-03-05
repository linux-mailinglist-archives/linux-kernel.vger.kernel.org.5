Return-Path: <linux-kernel+bounces-92461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2A872084
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06BC7B280AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAD886136;
	Tue,  5 Mar 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DOCvtJWD"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9594984A48;
	Tue,  5 Mar 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646101; cv=none; b=blZk2CXhQ4m2u6NRUA/u9TjZ3+8JnpeXeGLgjuis8F9wAnVYZFbFeEuMiD9TidtxOlzxA/ljiVC/5oLjAkyh9EbL2nGteH2LfFJKGfHtczB9i54fJ5PturfdpvboVq+eF65KdvtIIXPHz+7UKyG5Pq74aU7wag3klUEx8DyuAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646101; c=relaxed/simple;
	bh=W+2nNfu/SH120fh3upXQutRAF4cFUOE0j3C5s8jvs54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DY6Wrirn568kV0CpbgFT53TBhG+a+Qd0GZSa1Ycj+Ux0ajpyoRSy6FLut5Y1clIOu3jAauaKiXwdTh58CTfBswgFWpBrQES8ABFi0KqW5G8EvHwKh81ga1IS8yhejXxd3Gcp4MpCadfLoX4JXPgIq2xZKuayEoLSGv4VIKx/3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DOCvtJWD; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 136191BF20B;
	Tue,  5 Mar 2024 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709646091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZDyctNRQfxHIrXGUPl9xyE+ahVMXlpoMQhkMhBvw8w=;
	b=DOCvtJWDLZSm2JIeQ9Omeu4d1Hzx3R3n13mnOKJCS0QzLpxZ+i7VVBJsa00u2c3FzBbsZr
	TmtD2SjBYbmETmRwp/+3T5y3zzza3j1KOfQ1xoW2OUELvxf4NQMhBDz6e3XWjVquzKlEJC
	x+dgTmKckoL+noQtiQMSS547dTOKuynN+8mmywNWdhm87b8lE8dgTk45OOlyiPZvJeeGiO
	sNI13I1pKmRGBOTt5JmHC9Bfhf5+aR8uhvo7caHoYM7kl+4HZ7orI3kIkQCB6w2oB2q9Ld
	LuRUyZ8zDKFaO1V3pkg+qhqKCUBUnC7667dPZPzCnsziw+PqKqwchkGgI+CMBA==
Message-ID: <85da1b70-d3fe-4117-a87c-53559b299867@bootlin.com>
Date: Tue, 5 Mar 2024 14:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: net: dp83822: change ti,rmii-mode
 description
Content-Language: en-US
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Yen-Mei Goh <yen-mei.goh@keysight.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
References: <20240305133137.125020-1-jeremie.dautheribes@bootlin.com>
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
In-Reply-To: <20240305133137.125020-1-jeremie.dautheribes@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Sorry I forgot to include the "net-next" entry in the subject, I'm 
sending this patch again with the correct subject.

On 05/03/2024 14:31, Jérémie Dautheribes wrote:
> Drop reference to the 25MHz clock as it has nothing to do with connecting
> the PHY and the MAC.
> Add info about the reference clock direction between the PHY and the MAC
> as it depends on the selected rmii mode.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
> ---
> This patch follows on from my previous patch series [1] which has already been
> merged into the net-next tree and which added the "ti,rmii-mode" property.
> As suggested by Andrew Lunn, this patch updates the description of this
> property to make it more consistent with the master/slave relationship it
> conveys.
> 
> [1] https://lore.kernel.org/all/20240222103117.526955-1-jeremie.dautheribes@bootlin.com/
> 
>   Documentation/devicetree/bindings/net/ti,dp83822.yaml | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> index 8f23254c0458..784866ea392b 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
> @@ -84,10 +84,10 @@ properties:
>       description: |
>          If present, select the RMII operation mode. Two modes are
>          available:
> -         - RMII master, where the PHY operates from a 25MHz clock reference,
> -         provided by a crystal or a CMOS-level oscillator
> -         - RMII slave, where the PHY operates from a 50MHz clock reference,
> -         provided by a CMOS-level oscillator
> +         - RMII master, where the PHY outputs a 50MHz reference clock which can
> +         be connected to the MAC.
> +         - RMII slave, where the PHY expects a 50MHz reference clock input
> +         shared with the MAC.
>          The RMII operation mode can also be configured by its straps.
>          If the strap pin is not set correctly or not set at all, then this can be
>          used to configure it.

