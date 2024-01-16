Return-Path: <linux-kernel+bounces-27608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7170582F2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31A128569F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC21CA9F;
	Tue, 16 Jan 2024 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="EmY52/eF"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8901CA89;
	Tue, 16 Jan 2024 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424777; cv=none; b=Z+dHEtUGMpRdYhceRnPOMpcqhzSKn/yk+eQq65sT2iqDPir8udBZMCheD/H8sowuShfMsNWmMCoUtIP06sduoyu/IHfbTiE0FRmBjIDqRBcGQmplKN2XO8g8JvJ1clZtOVZ7DF/X28Rsn3VEOSJ/oftJudLJs/NR2fxlxUOsKZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424777; c=relaxed/simple;
	bh=hOhScMHFg3gAHygDBlOtJfPi//nUjBk2KcM+TPrxUhU=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-GND-Sasl; b=sUa0cuXlM8Hg2cyOEyfCl7YYCVnTklM4cqPxLxMYnm3zWDf3bv3kKM60kJ06kS3MCPq5BPAX6EuAKDHx96Ke/XZn2D8+2NMR6MENmW9m8n/BxZDWQstKTDD7alBv6pl87U/ZBv45y7k7yEOvUzQlqVoCQ6nfkDf14s0xBIW32x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=EmY52/eF
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56CE41BF204;
	Tue, 16 Jan 2024 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1705424767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HbZN4CyG8XR5HbXWl1OlbE6KwGeSWI/unoisp6ImNs=;
	b=EmY52/eFthuRUhpVhsbjsK+A6rs+RHpeZUlai6n64lBUcnxrMzTld4zvurzDsEkejPiz6G
	z1DEU4qSG3V8H7LEqRqkhsXTiU4ECLRF3yxZfGi0TcBSPfPq+T2E2VB9gdSC271RsoZnpU
	spoFhfo/jlaYTHcV6CHzg4+/AFBYXxrp3w418zoK9jPV/fZxjXD2P8G84pn6CUgDbcmNRH
	R6MWmIVmfSyt+Cn2saJD1E+3OsupJkpf+r3OtdG3r6pgrdae5019MW9yoDGYUcdEuijoCP
	oR0iN5wpmGm1ZcYCFv6PvNiZq4qJl2r/xM174AtI9KRXkwWib6acok2jWKol/w==
Message-ID: <b9070fb6-4b85-441e-a863-8fe562408e48@arinc9.com>
Date: Tue, 16 Jan 2024 20:05:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next 6/8] net: dsa: mt7530: simplify
 mt7530_setup_port6() and change to void
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240113102529.80371-1-arinc.unal@arinc9.com>
 <20240113102529.80371-7-arinc.unal@arinc9.com>
 <20240115213720.vxlumsjwrjdkqxsl@skbuf>
 <7f59d9e6-1653-4a8d-910d-5922452bb9e8@arinc9.com>
 <20240116134705.mw2a2twoakw5b7jq@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240116134705.mw2a2twoakw5b7jq@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16.01.2024 16:47, Vladimir Oltean wrote:
> On Tue, Jan 16, 2024 at 04:09:18PM +0300, Arınç ÜNAL wrote:
>> Do you mean by internal port that the port does not have MII pinout? Port 6
>> of the MT7530 switch do. It is possible to have an external PHY wired to it.
> 
> Yes, this is what I meant by internal port. It seems I was wrong to
> assume it is always connected to GMAC0.
> 
> How is the selection done between internal and external wiring?

There are two variants of MT7530. One is standalone, the other comes with
the SoC as a part of the multi-chip module. More information at
mediatek,mt7530.yaml.

The standalone one is straightforward. A MAC or a PHY can be wired to the
MII pinouts of port 5 and 6 on the PCB, just as the relevant MII standard
describes.

On the MT7621 SoCs which include the switch IC, port 6 is wired to GMAC0,
port 5 is wired to GMAC1. I assume you mean internal and external wiring in
reference to this case. This is the internal wiring.

The external wiring works by wiring the PHY or MAC to the MII pinouts of
the SoC's two MACs. Since RX of the switch MAC is wired to TX of the SoC
MAC and vice versa, the external PHY or MAC must be wired TX to TX and RX
to RX. Ubiquiti EdgeRouter X SFP is wired this way. The wiring for clock
pins may need to be mirrored too, I haven't studied the RGMII specification
that much in detail. This works by not enabling the SoC MAC.

> 
> If external wiring to a PHY is possible, shouldn't the driver accept all
> 4 RGMII variants with phy_interface_mode_is_rgmii(), because the delays
> specified in "rgmii-txid", "rgmii-rxid", "rgmii-id" always pertain to
> the PHY, and thus it doesn't make sense for the MAC to not allow the use
> of the full spectrum?

Great point. I think delays are not supported on port 6. There's only the
"MT7530 Giga Switch programming guide v0.1" document mentioning setting
delays on page 8, and it's only for port 5. It is also implemented on
mt7530_setup_port5():

/* P5 RGMII RX Clock Control: delay setting for 1000M */
mt7530_write(priv, MT7530_P5RGMIIRXCR, CSR_RGMII_EDGE_ALIGN);

/* Don't set delay in DSA mode */
if (!dsa_is_dsa_port(priv->ds, 5) &&
     (interface == PHY_INTERFACE_MODE_RGMII_TXID ||
      interface == PHY_INTERFACE_MODE_RGMII_ID))
	tx_delay = 4; /* n * 0.5 ns */

/* P5 RGMII TX Clock Control: delay x */
mt7530_write(priv, MT7530_P5RGMIITXCR,
	     CSR_RGMII_TXC_CFG(0x10 + tx_delay));

There's only the TX driving mentioned for port 6 on the document. I'm
guessing port 6 was intended to connect to another TRGMII capable MAC so
delays were out of the question. TRGMII is just overclocked RGMII to
provide up to 2Gbps TX/RX, at least in theory. The whole existence of the
TRGMII interface on Linux is only being used by the MT7621 and MT7623 SoC
MACs, and port 6 MAC of the MT7530 switch.

> 
>> So it would make sense to design mt7530_setup_port6() in the sense that
>> dynamic reconfiguration is possible.
> 
> Ok, you mean to keep the dynamic reconfiguration possible rather than
> redesign to disallow it.

Very much so.

Arınç

