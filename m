Return-Path: <linux-kernel+bounces-14777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 161EE82220D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F532B22621
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0915E9C;
	Tue,  2 Jan 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgHGZVTi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F916403;
	Tue,  2 Jan 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e766937ddso7714349e87.3;
        Tue, 02 Jan 2024 11:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704224016; x=1704828816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oGWoUo2kZlWi4+ZRV37RZOEE77veWDQM4/zk4+0W71I=;
        b=XgHGZVTiZtlNYQFlxxLkkPyoze8QrYQ34IwRUbpBuhOL+9GOiyPH7PXJ7zFZ7C36lS
         NXF4JCg4Y3YRg4nLAuZgfnPTgjWLd5VZDsuHJhmT4GgkuiyFBKMMbmVZaxocL9/rroc/
         ay9kg3+T5bnhdFKpvMF/KUEBuZ5/SlxZ4mQAp3mqbeey+BheClppP8aen6Eyi2ERG+bN
         DoK64GvweLaAQqgBwB5Z6nbJTI5XxCdBTaDT+phImpP036QISHLpscFZik/EPaWnT1o1
         +B2jRbGHW2hBJYHZujDAQP8SDq3mcQlh64hvIqKh5EsWulIpPh0J5bK0bAalN38gF1W6
         162w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704224016; x=1704828816;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGWoUo2kZlWi4+ZRV37RZOEE77veWDQM4/zk4+0W71I=;
        b=kvaC8/iN2gGMTMfzn33trfGYBsSoYO9CSxj4/e341lesGrrevHI29KAp/3jlt56lfV
         YuIcQvkTWqHPjfHLZpc00YTxXoKu+kAkIMsIG28BmJArNihFpqEV5jFfe2kgX0DWMEsl
         4j/7Y4ThOw0usAaG/kJGHjHN3ggCnj/nbGQ+kC9QlbES+ZcRrMSh/gQ23F+KHUaJbc5M
         JzrPuze1nPYXgIcdWVacv/U129RAtsNGC2cQa5keLvlC9fHxCkZIgcbWbbwx8s0JOBlt
         MY2r1fxS5qap7cyURSfvpXt7DFwLNkINYd7JLZW2vzLzGis7tK0JJZOpVhVoRKjJFHIz
         z+YQ==
X-Gm-Message-State: AOJu0Yy0HCMSyLs1Ah7tZpjL8tHJLxFB5mM7uzFj8VU+kiiIf83u66wh
	TID3GJlOveBqfwNavX3+FPo=
X-Google-Smtp-Source: AGHT+IHAMCc2uUTYdMnHH6EZ3MG+3mPuQY5aw/m25i+1vyPNfiDcSX8Fpt45zOIL54FWe3//85BuDQ==
X-Received: by 2002:a19:5e56:0:b0:50e:80d2:4dd2 with SMTP id z22-20020a195e56000000b0050e80d24dd2mr4459004lfi.103.1704224015732;
        Tue, 02 Jan 2024 11:33:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id x14-20020a19e00e000000b0050e7433d7d7sm3205889lfg.52.2024.01.02.11.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 11:33:35 -0800 (PST)
Message-ID: <74223164-ab50-4d6d-a4f4-561b0a70d396@gmail.com>
Date: Tue, 2 Jan 2024 20:33:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: pcs: pcs-mtk-lynxi fix
 mtk_pcs_lynxi_get_state() for 2500base-x
From: Eric Woudstra <ericwouds@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Couzens <lynxis@fe80.eu>, Daniel Golle <daniel@makrotopia.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240102074408.1049203-1-ericwouds@gmail.com>
 <ZZP9GR15ufDbjGAJ@shell.armlinux.org.uk>
 <92190426-3614-4774-9E9F-18F121622788@gmail.com>
Content-Language: en-US
In-Reply-To: <92190426-3614-4774-9E9F-18F121622788@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


With some extra info:

echo "file drivers/net/phy/* +p" > /sys/kernel/debug/dynamic_debug/control

The log looks like this when sfp inserted:

With the path (on original net-next, no further modifications), Traffic OK:

[   71.212634] sfp sfp-1: mod-def0 0 -> 1
[   71.216403] sfp sfp-1: tx-fault 1 -> 0
[   71.220140] sfp sfp-1: SM: enter empty:up:down event insert
[   71.225716] sfp sfp-1: SM: exit probe:up:down
[   71.230059] sfp sfp-1: SM: enter probe:up:down event tx_clear
[   71.235803] sfp sfp-1: SM: exit probe:up:down
[   71.240195] sfp sfp-1: tx-fault 0 -> 1
[   71.243939] sfp sfp-1: SM: enter probe:up:down event tx_fault
[   71.249688] sfp sfp-1: SM: exit probe:up:down
[   71.254052] sfp sfp-1: tx-fault 1 -> 0
[   71.257810] sfp sfp-1: SM: enter probe:up:down event tx_clear
[   71.263542] sfp sfp-1: SM: exit probe:up:down
[   71.534808] sfp sfp-1: SM: enter probe:up:down event timeout
[   71.570662] sfp sfp-1: module OEM              SFP-2.5G-T       rev 1.0  sn SK2301110007     dc 230110  
[   71.580153] mtk_soc_eth 15100000.ethernet eth1: optical SFP: interfaces=[mac=2-4,22-23, sfp=23]
[   71.588848] mtk_soc_eth 15100000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 10,13-14,47
[   71.598941] mtk_soc_eth 15100000.ethernet eth1: optical SFP: chosen 2500base-x interface
[   71.607605] mtk_soc_eth 15100000.ethernet eth1: requesting link mode inband/2500base-x with support 00,00000000,00008000,00006400
[   71.619321] sfp sfp-1: tx disable 1 -> 0
[   71.623287] sfp sfp-1: SM: exit present:up:wait
[   71.636489] hwmon hwmon0: temp1_input not attached to any thermal zone
[   71.684749] sfp sfp-1: SM: enter present:up:wait event timeout
[   71.690587] sfp sfp-1: SM: exit present:up:wait_los
[   74.704872] sfp sfp-1: los 1 -> 0
[   74.708199] sfp sfp-1: SM: enter present:up:wait_los event los_low
[   74.714389] sfp sfp-1: SM: exit present:up:link_up
[   74.714422] mtk_soc_eth 15100000.ethernet eth1: Link is Up - 2.5Gbps/Full - flow control off

Without the patch, No traffic possible:

[  261.515414] sfp sfp-1: los 1 -> 0
[  261.518740] sfp sfp-1: SM: enter empty:up:down event los_low
[  261.524418] sfp sfp-1: SM: exit empty:up:down
[  261.528799] sfp sfp-1: mod-def0 0 -> 1
[  261.532541] sfp sfp-1: los 0 -> 1
[  261.535843] sfp sfp-1: SM: enter empty:up:down event insert
[  261.541406] sfp sfp-1: SM: exit probe:up:down
[  261.545748] sfp sfp-1: SM: enter probe:up:down event los_high
[  261.551481] sfp sfp-1: SM: exit probe:up:down
[  261.555859] sfp sfp-1: tx-fault 1 -> 0
[  261.559595] sfp sfp-1: SM: enter probe:up:down event tx_clear
[  261.565330] sfp sfp-1: SM: exit probe:up:down
[  261.859940] sfp sfp-1: SM: enter probe:up:down event timeout
[  261.895690] sfp sfp-1: module OEM              SFP-2.5G-T       rev 1.0  sn SK2301110007     dc 230110  
[  261.905218] mtk_soc_eth 15100000.ethernet eth1: optical SFP: interfaces=[mac=2-4,22-23, sfp=23]
[  261.913929] mtk_soc_eth 15100000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 10,13-14,47
[  261.924104] mtk_soc_eth 15100000.ethernet eth1: optical SFP: chosen 2500base-x interface
[  261.932199] mtk_soc_eth 15100000.ethernet eth1: requesting link mode inband/2500base-x with support 00,00000000,00008000,00006400
[  261.945449] sfp sfp-1: tx disable 1 -> 0
[  261.950886] sfp sfp-1: SM: exit present:up:wait
[  261.973346] hwmon hwmon0: temp1_input not attached to any thermal zone
[  262.009896] sfp sfp-1: SM: enter present:up:wait event timeout
[  262.015771] sfp sfp-1: SM: exit present:up:wait_los
[  264.842218] sfp sfp-1: los 1 -> 0
[  264.845544] sfp sfp-1: SM: enter present:up:wait_los event los_low
[  264.851770] sfp sfp-1: SM: exit present:up:link_up
[  264.851801] mtk_soc_eth 15100000.ethernet eth1: Link is Up - Unknown/Unknown - flow control off


So if phylink_mii_c22_pcs_decode_state() should not set the speed, then it is not correctly set somewhere else.

On 1/2/24 13:55, Eric Woudstra wrote:
>> Please describe your setup more fully. What is the link partner on this
>> 2500base-X link?
> 
> I use a BananaPi R3, with the oem-sfp2.5g-t module. It has the SFP quirk that disables autoneg. I was trying Marek's rtl8221b patchset, but found that even with unmodified code,  original net-next unmodified, I could get link up, but no traffic is going through.
> 
> On the other side is a.rock5b with rtl8125b.
> 
> Only after applying this patch, it works and eth1 reports link up with 2.5Gbps instead of unknown speed.
> 
> If you need more debugging info, I can supply it at a later time.
> 
> 
> On January 2, 2024 1:10:01 PM GMT+01:00, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>> On Tue, Jan 02, 2024 at 08:44:08AM +0100, Eric Woudstra wrote:
>>> From: Daniel Golle <daniel@makrotopia.org>
>>>
>>> Need to fix mtk_pcs_lynxi_get_state() in order for the pcs to function
>>> correctly when the interface is set to 2500base-x, even when
>>> PHYLINK_PCS_NEG_INBAND_DISABLED is set.
>>
>> Please describe your setup more fully. What is the link partner on this
>> 2500base-X link?
>>
>> In PHYLINK_PCS_NEG_INBAND_DISABLED mode, this means that phylink is
>> operating in inband mode, but Autoneg is clear in the advertisement
>> mask, meaning Autoneg is disabled and we are using a "fixed" setting.
>> state->speed and state->duplex should already be initialised.
>>
>>> When the pcs is set to 2500base-x, the register values are not compatible
>>> with phylink_mii_c22_pcs_decode_state(). It results in parameters such as
>>> speed unknown and such. Then the mac/pcs are setup incorrectly and do not
>>> function.
>>
>> Since Autoneg is clear, phylink_mii_c22_pcs_decode_state() won't
>> change state->speed and state->duplex, which should already be
>> correctly set.
>>

