Return-Path: <linux-kernel+bounces-26517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C6F82E287
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B98B2216A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7481B5BC;
	Mon, 15 Jan 2024 22:25:24 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D4B1B594;
	Mon, 15 Jan 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rPV9M-0001ug-11;
	Mon, 15 Jan 2024 22:09:45 +0000
Date: Mon, 15 Jan 2024 22:09:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH net-next 7/8] net: dsa: mt7530: correct port
 capabilities of MT7988
Message-ID: <ZaWtIMC9zqwjVewO@makrotopia.org>
References: <20240113102529.80371-1-arinc.unal@arinc9.com>
 <20240113102529.80371-8-arinc.unal@arinc9.com>
 <20240115214238.bnlvomatududng6l@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115214238.bnlvomatududng6l@skbuf>

On Mon, Jan 15, 2024 at 11:42:38PM +0200, Vladimir Oltean wrote:
> On Sat, Jan 13, 2024 at 01:25:28PM +0300, Arınç ÜNAL wrote:
> > On the switch on the MT7988 SoC, there are only 4 PHYs. That's port 0 to 3.
> > Set the internal phy cases to '0 ... 3'.
> > 
> > Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> > Acked-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> 
> For this patch to be obviously correct, please make a statement in the
> commit message about port 4. It doesn't exist at all?

Correct. As shown in Block Diagram 8.1.1.3 on page 125 of
MT7988A Wi-Fi 7 Generation Router Platform: Datasheet (Open Version)
Version: 0.1
Release Date: 2023-10-18
which is available publicly on BananaPi's Wiki[1].

Port 0~3 are TP user ports, Port 6 is internally linked to XGMII of MAC 0.
Port 4 and 5 are not used at all in this design.

[1]: https://wiki.banana-pi.org/Banana_Pi_BPI-R4#Documents

