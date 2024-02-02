Return-Path: <linux-kernel+bounces-50263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBA984768B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2577DB2B1FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E01509A8;
	Fri,  2 Feb 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="gMnuts5L"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861214C5A5;
	Fri,  2 Feb 2024 17:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895896; cv=none; b=rYxcmJpllmh5I3Bs/9pvUjiTUyA8b+TrL/FwPDLkJyDOTDwELdEFs2niV8h6CVGKnO2yUXSyV7t+oJKGfJ6LDFqKlsUlQoqG4O5I98+yrxlQo3Bcar/1BaSnqe70EnWwlyo/mX5b4cTm5hPfxLHQIgLiLGCEPXSB98XXUbvLhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895896; c=relaxed/simple;
	bh=uw5lYvRz7me5BtWDmKAyakAi0GQyrUa1obli20c2iTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuWGaHsS+Gdg7elijYjWz22NVI86XR1p6OYyOr/3vNI+urvC4OleYgfffb+6U90fui8g8KzTiVehXdPevYnFjCtXJ+YVHgkJDENeiFbMqiQjoC62yHGPK+iGSrYKb3tZcJRWUth5CQd5gtjzvEOEPrQYOPTm8toVSxishbf/D5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=gMnuts5L; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07E1E1C0003;
	Fri,  2 Feb 2024 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1706895886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4uIPG7Nra39EUwOvsm4b3NYu2+PD/eNW8/4vOlSOB4=;
	b=gMnuts5Lxz0WzF6krO3ay2/xk9bENZ0R9500jzKTl6II5Pl1QNZQkV5+pvJEGddg0ljX4u
	nj5dYRWbMH/9KzOS7AeqcnQa7NuWabvlvrXgDHlsbcC25TI/r3OoxKStXMrc/M/YKNzF7e
	PC5M3035FEr3TMV/4SEkNirvrkfDpeWMskWmCei9MQiuMjpHR3Hhgu+ga8cfrXMNa2xHpF
	BuJfp6HqnLXt5fqP0KbeyaTnAVhwYGBfuX8xIqDpdiY0hrZVsaeRKTcKxoLcogNhQ6oDrA
	R4hfkShWlwy/zj1dyErgAi4P8/UGMGQOQ+GO6ki0xDDGtpnrwh6fFrAOW4xkig==
Message-ID: <e3b4add6-425c-46ca-9da5-8713055fc422@arinc9.com>
Date: Fri, 2 Feb 2024 20:44:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/7] net: dsa: mt7530: empty default case on
 mt7530_setup_port5()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
 <20240202-for-netnext-mt7530-improvements-2-v3-1-63d5adae99ca@arinc9.com>
 <ZbzUotyQm/FyKK7G@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZbzUotyQm/FyKK7G@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 2.02.2024 14:40, Russell King (Oracle) wrote:
> While reviewing this change, but not related to it, I notice that this
> function sets the TX delay based on the RGMII interface mode. This isn't
> correct. I've explained why this is this many times in the past, but
> essentially it comes down to the model:
> 
> 
> phy-mode in NIC node	Network driver	PCB		PHY
> rgmii			no delays	delays		no delays
> rgmii-id		no delays	no delays	tx/rx delays
> rgmii-txid		no delays	no delays	tx delays
> rgmii-rxid		no delays	no delays	rx delays
> 
> Then we have rx-internal-delay-ps and tx-internal-delay-ps in the NIC
> node which define the RGMII delays at the local end and similar
> properties for the PHY node.
> 
> 
> So, if we take the view that, when a switch is connected to a NIC in
> RGMII mode, then the phy-mode specified delays still should not impact
> the local NIC.
> 
> Now, for the switch, we specify the phy-mode in the port node as well.
> Consider the case of a switch port connected to a RGMII PHY. This has
> to operate in exactly the same way as a normal NIC - that is, the
> RGMII delays at the port should be ignored as it's the responsibility
> of a PHY.
> 
> The final scenario to examine is the case of a RGMII switch port
> connected to a NIC. The NIC's phy-mode has no way to be communicated
> to DSA or vice versa, so neither phy-mode can impact the other side
> of the RGMII link, but should only place the link into RGMII mode.
> Given everything I've said above, the only way to configure RGMII
> delays is via the rx-internal-delay-ps and tx-internal-delay-ps
> properties. So, DSA drivers should _not_ be configuring their ports
> with RGMII delays based on the RGMII phy interface mode.
> 
> The above is my purely logically reasoned point of view on this
> subject. Others may have other (to me completely illogical)
> interpretations that can only lead to interoperability issues.

I will address this with the next patch series. Thank you for explaining it
in detail.

Arınç

