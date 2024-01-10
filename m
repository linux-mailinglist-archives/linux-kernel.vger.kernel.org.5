Return-Path: <linux-kernel+bounces-22093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB52829910
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDD5287855
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCDF47A63;
	Wed, 10 Jan 2024 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Tzfpi8yu"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE447F5E;
	Wed, 10 Jan 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36DB0C0004;
	Wed, 10 Jan 2024 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704886204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSqO5eCZ27MS2fADuP5ThwfLEsbc8s+DlvDx2BBPL9k=;
	b=Tzfpi8yuk+TImYcUywQQIvFFpb91SjmS/Ouw4VxsSkKzJYC8O8pINGX9ZiuhuFPx76S8MP
	U0Wi4gkUhaAaxwL5hPdzb50wFg23My4q65d4VZlhj4qID9HOZ7DiFQnQqnmVC+T89ofRpM
	dUA4DVECweXkce6hnMN8egguyQviZZSAmR+M6WthOF75YBd0tnqDw5ejsZAup7Ie11i1Uu
	UFNdQwyX15P67nNAfNJPcVnkTfGxZuXGjKmN28/kHW4fU8a6vu+mo1m21ASjCqVe/Lwm+g
	5Q+t4YJQJne3IgPPWP9IW8vFuddLKx4pyL0EGJGiuN/A9ca9hxoV1sIEj3FjNw==
Message-ID: <ad2df325-2a48-4a81-be13-be8230b7aa8a@arinc9.com>
Date: Wed, 10 Jan 2024 14:29:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
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
 Russell King <linux@armlinux.org.uk>,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-7-arinc.unal@arinc9.com>
 <20240104154241.rxjins4mi5zkbhia@skbuf>
 <f9ad000a-2e42-4ddf-89a4-9a3ff452dc4b@arinc9.com>
 <2793938a-91e1-419d-a011-850756177e31@arinc9.com>
 <20240109115115.yuct3yw4oy6ipd3i@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240109115115.yuct3yw4oy6ipd3i@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 9.01.2024 14:51, Vladimir Oltean wrote:
> On Tue, Jan 09, 2024 at 02:42:45PM +0300, Arınç ÜNAL wrote:
>> Running mt7530_setup_port5() from mt753x_phylink_mac_config() multiple
>> times is being prevented which shouldn't be done. That's because of a
>> different reason involving MT7531. I will deal with this with a later
>> patch.
>>
>> I intend to put this on the patch log.
> 
> Still not clear why it shouldn't be done. Ideally you could come up with
> a plausible hypothesis as to why it's there in the first place, and why
> it's not needed.

I can't tell why it's there. Russell did analyse why it's not needed [1]
and my test [2] confirms it.

This patch is about removing the unnecessary setting of priv->p5_interface
on mt7530_setup_port5() which I believe I have already explained. I would
like to get into the details of priv->p5_interface and priv->p6_interface
when I remove them along with cpu_port_config().

That said, I will refrain from including the last paragraph on the patch
log.

[1] https://lore.kernel.org/netdev/ZHy2jQLesdYFMQtO@shell.armlinux.org.uk/
[2] https://lore.kernel.org/netdev/9308fa1a-6de3-490b-9aeb-eb207b0432df@arinc9.com/

Arınç

