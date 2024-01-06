Return-Path: <linux-kernel+bounces-18686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABCE8260FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08461F2235D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 18:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4788D2FC;
	Sat,  6 Jan 2024 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="IrwcmRO7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846EC8C3;
	Sat,  6 Jan 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 213CC40004;
	Sat,  6 Jan 2024 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704564092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFWawH0E560JxudljiU+bgsrIpK63GPFMn0rSwov+Lc=;
	b=IrwcmRO7+If4cFKJdvrDmMOZosXpRPRKYskT0KyXZaFeGd7T8DWlFFb+B0jmTYZTPULITg
	gJ5QfnFCjuUHOtbY4klSUqXA1iEMSE9HRKHX8MJX9epmF2L7DPTN7QqCErD7hsi1aTBBZd
	4ZFyWjezIaYeLFF86AblzoSZUlFk9AP57ebrE7XFmgCNVZNAhPqv3o4wREhZYsEJGBh/F4
	tlQj/U9aqQZ+lz14IHVDeMJ7Vx4QCE1XF8qnmkdoDBiuJqBIECYYXi4R+0c91PA3IfM1Lj
	cDnb8QzRwJBDjWFS4S7PbOJ+NWvGV0aV2ZOYGGYP8wGQFRMzHqsNc/8Y3UiqQw==
Message-ID: <2ad136ed-be3a-407f-bf3c-5faf664b927c@arinc9.com>
Date: Sat, 6 Jan 2024 20:01:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
 <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
 <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 1/2/24 13:16, Dan Carpenter wrote:
> On Sun, Dec 17, 2023 at 03:22:27PM +0300, Arınç ÜNAL wrote:
>> On 8.12.2023 21:46, Vladimir Oltean wrote:
>>> Hmm, maybe the problem, all along, was that we let the -ENODEV return
>>> code from of_get_phy_mode() pass through? "interface" will really be
>>> uninitialized in that case. It's not a false positive.
>>>
>>> Instead of:
>>>
>>> 	ret = of_get_phy_mode(mac_np, &interface);
>>> 	if (ret && ret != -ENODEV) {
>>> 		...
>>> 		return ret;
>>> 	}
>>>
>>> it should have been like this, to not complain:
>>>
>>> 	ret = of_get_phy_mode(mac_np, &interface);
>>> 	if (ret) {
>>> 		...
>>> 		return ret;
>>> 	}
>>>
>>
>> I just tried this, smatch still reports "interface" as uninitialised.
>>
>> $ export ARCH=mips CROSS_COMPILE=mips-linux-gnu-
>> $ ../smatch/smatch_scripts/kchecker --spammy drivers/net/dsa/mt7530.c
>>
>>    UPD     include/config/kernel.release
>>    UPD     include/generated/utsrelease.h
>>    CHECK   scripts/mod/empty.c
>>    CALL    scripts/checksyscalls.sh
>>    CC      drivers/net/dsa/mt7530.o
>>    CHECK   drivers/net/dsa/mt7530.c
>> drivers/net/dsa/mt7530.c:217 mt7530_mii_read() warn: call of 'warn_slowpath_fmt' with non-constant format argument
>> drivers/net/dsa/mt7530.c:454 mt7530_setup_port6() error: uninitialized symbol 'ncpo1'.
>> drivers/net/dsa/mt7530.c:868 mt7530_set_ageing_time() error: uninitialized symbol 'age_count'.
>> drivers/net/dsa/mt7530.c:868 mt7530_set_ageing_time() error: uninitialized symbol 'age_unit'.
>> drivers/net/dsa/mt7530.c:2324 mt7530_setup() error: uninitialized symbol 'interface'.
> 
> That's so strange.
> 
> Vladimir was right that I was misreading what he said and also hadn't
> noticed the break.
> 
> For me, his approach silences the warning with or without the cross
> function DB.  Also of_get_phy_mode() initializes interface on all paths
> so checking for -EINVAL doesn't matter as far as this warning is
> concerned.

I must be missing something.

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 7f9d63b61168..05ce3face47c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2325,7 +2325,7 @@ mt7530_setup(struct dsa_switch *ds)
  
  			if (phy_node->parent == priv->dev->of_node->parent) {
  				ret = of_get_phy_mode(mac_np, &interface);
-				if (ret && ret != -ENODEV) {
+				if (ret) {
  					of_node_put(mac_np);
  					of_node_put(phy_node);
  					return ret;

$ ../smatch/smatch_scripts/kchecker --spammy drivers/net/dsa/mt7530.c
   CHECK   scripts/mod/empty.c
   CALL    scripts/checksyscalls.sh
   DESCEND objtool
   INSTALL libsubcmd_headers
   CC      drivers/net/dsa/mt7530.o
   CHECK   drivers/net/dsa/mt7530.c
drivers/net/dsa/mt7530.c:469 mt7530_pad_clk_setup() error: uninitialized symbol 'ncpo1'.
drivers/net/dsa/mt7530.c:895 mt7530_set_ageing_time() error: uninitialized symbol 'age_count'.
drivers/net/dsa/mt7530.c:895 mt7530_set_ageing_time() error: uninitialized symbol 'age_unit'.
drivers/net/dsa/mt7530.c:2346 mt7530_setup() error: uninitialized symbol 'interface'.

Just so you know, I intend to remove this whole PHY muxing feature once I
bring changing DSA conduit support to this subdriver. I've got two strong
reasons for this.

- Changing the DSA conduit achieves the same result with the only overhead
   being the DSA header included on every frame.

- There can't be proper dt-bindings for it as the nature of the feature
   shows that it represents an optional way to operate the hardware, it does
   not represent a hardware design. Overall, the implementation is a hack to
   make it work for specific hardware (switch must be connected to gmac1 of
   a MediaTek SoC, no PHY must be present at address 0 or 4 on the MDIO bus
   of the SoC. It should rather be configurable on userspace. Which will
   never happen as it is specific to this switch and the changing DSA
   conduit feature is the perfect substitute for this.

Let me know if you've got any suggestions that can get rid of the warning
without reworking the whole code block. Otherwise, I'm just going to ignore
it until I get rid of the whole code block.

Arınç

