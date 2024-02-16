Return-Path: <linux-kernel+bounces-69066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E233785840C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FE31F29F09
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C865B131E30;
	Fri, 16 Feb 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="BzmQcEEM"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44402130E4F;
	Fri, 16 Feb 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104201; cv=none; b=DWKsacoi7av8G1TGffLxuRkMBxIcq+glo+gJp0Qn+eELO3vMkDq8BxO+6WOyl4bMEH1/JyCVKd/WoDsmacwVl2Ur/FAkaUsrIFjc9/qlLHmW5cBa2lgJjCkzjF9bAPZZL/7tuNnUmQNahU++rJe7m+YUqBS/ShLJ9xNqQCp9jvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104201; c=relaxed/simple;
	bh=C+UdeynDOGq0mrHveglMdaqWxl9GfAv8DWBDN7EsUJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTn+zH+nrUVip97RaLYkjcQh/8D+v7wQvAhlK0aLNWE99+nXZ3AHpZHxBnVuaDtsdr5EGtsjEytrTM4rMsLMblYKL0J8W5iq/ZJ0wUFn3Dcp/VjGyUU+GB2reClMo6ozqIEhlsmkyLalN5Ts8EjUaEA8gY4MbceoGvDx30A+gsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=BzmQcEEM; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1304B2000E;
	Fri, 16 Feb 2024 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1708104189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RimLjOdN8rzQMpG0ae9IdH673ga5rpJ5Vs6DdQd0/gQ=;
	b=BzmQcEEMGCl+P5qGARHIVL1y4ADNuv8bQFuLLYUM4/lqqGfcpNFu8HWyOQ2A2GzE8/tujf
	UdWhRocg/l4UUe5et5gtQBAgVrF+9ZwquMbxcE3A9fXfYokgnN2lO5n7jn9cmkJkNt5Bfj
	Z3XEQF/p7R0XqIXTdm/O19LvG6YZkAXU8wtvI50pIW6S6P4He/7ayaQRFdsujG4PnqNC1w
	9yDN2fWfqEQMQ/6KvImzgcEwtU9GeYgWcau+2qsYZVfxPvi2xhBRpBoHq+PWUgOF++yFwO
	Mnt+zGFq4nDdn50+Gz6cOWfWNFE4Uj3bgAALObqxxiPVojQVFESnzXTA+GzbSg==
Message-ID: <c8393e61-7c44-4aca-acce-10b5f6b34fdd@arinc9.com>
Date: Fri, 16 Feb 2024 20:23:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH netnext 8/8] net: dsa: mt7530: simplify link operations
 and force link down on all ports
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
References: <20240208-for-netnext-mt7530-improvements-3-v1-0-d7c1cfd502ca@arinc9.com>
 <20240208-for-netnext-mt7530-improvements-3-v1-8-d7c1cfd502ca@arinc9.com>
 <Zc+ConfebmQdpCOF@shell.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <Zc+ConfebmQdpCOF@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16.02.2024 18:43, Russell King (Oracle) wrote:
> On Thu, Feb 08, 2024 at 08:51:36AM +0300, Arınç ÜNAL via B4 Relay wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> Currently, the link operations for switch MACs are scattered across
>> port_enable, port_disable, phylink_mac_config, phylink_mac_link_up, and
>> phylink_mac_link_down.
>>
>> port_enable and port_disable clears the link settings. Move that to
>> mt7530_setup() and mt7531_setup_common() which set up the switches. This
>> way, the link settings are cleared on all ports at setup, and then only
>> once with phylink_mac_link_down() when a link goes down.
>>
>> Enable force mode at setup to apply the force part of the link settings.
>> This ensures that only active ports will have their link up.
> 
> I think we may have a different interpretation of what phylink's
> mac_link_down() and mac_link_up() are supposed to be doing here.
> Of course, you have read the documentation of these methods so are
> fully aware of what they're supposed to do. So you are aware that
> when inband mode is being used, forcing the link down may be
> counter-productive depending on how the hardware works.

No, I haven't read the documentation [1] until your response here. My patch
here doesn't touch mt753x_phylink_mac_link_down(), it is already the case
with the driver that falls short of not forcing link down when inband mode
is being used.

That said, what I explain on the patch log does not properly describe the
driver behaviour. This should explain it correctly:

Enable force mode at setup to apply the force part of the link settings.
This ensures that the ports that were never active will have their link
down.

I could, in the future, study this thoroughly to make the driver fully
conform to the documentation.

[1] https://docs.kernel.org/networking/kapi.html#phylink

Arınç

