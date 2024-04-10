Return-Path: <linux-kernel+bounces-138189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F5289EDE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714811F21D37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C8A155390;
	Wed, 10 Apr 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uvVfbqTx"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5F1552E0;
	Wed, 10 Apr 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738573; cv=none; b=DKtXRxUMugU9MOzFeRPvoxGwxLsEAZ3hshf6JTLVl4KEMpaqTcJIvvlV9m9pPdxuVba5DwFsn4BjUs0ox1Sc4x45Drge+4LOf04if2mEJXugzmU0bgrv3Blb/Q+FwT4umd6nBYv2PSoC3VHKOHFiFEXXKtXKnvxOP9wVbmqc8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738573; c=relaxed/simple;
	bh=7k0geQtKctDRHUCAeNxKnmtqw7tTLtM5JqO5OR0ecVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P4rpDGsipguDTFBlE30QBaAREduQfBEg/ax2DTUbnF9XBVX+EUeFsZJGUnUn/72ruX0YqNS4GQlVuNfsISMsUA2IDrPN3sW1r+kk3aDH1VOzpEkD+dDKXoQyUxWdIHrrl5LZVYKV5KtRwZ91LgZcuaY+n1+qqqSXNBz99Xc7eeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uvVfbqTx; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A8gNUL041435;
	Wed, 10 Apr 2024 03:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712738543;
	bh=swUSXL7PVIUJc7GOlNkYC+/+3PmSDVyctkmAasa7e3w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uvVfbqTxMB6C7tidhT/angdvB1LljKC8xOvMMhROV3iULd8fdTg4P5+LkBh8+a1pg
	 CjSbMYwyuD5L0iGhxfNNgTGmXcsqksSRqrBwIRB2mK47jQijFJZHxo4o0oGd+Z1eka
	 XkjImJ2b0aRYuYhNvPcONtGPK4vy461Gj8g0zjhY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A8gNMG018789
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 03:42:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 03:42:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 03:42:22 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A8gF3u011914;
	Wed, 10 Apr 2024 03:42:17 -0500
Message-ID: <ff567495-d966-42c9-9015-ba0ba0dbe011@ti.com>
Date: Wed, 10 Apr 2024 14:12:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Diogo Ivo <diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240327114054.1907278-1-danishanwar@ti.com>
 <20240327114054.1907278-4-danishanwar@ti.com>
 <27d960ed-8e67-431b-a910-e6b2fc12e292@lunn.ch>
 <c94815f8-798a-4167-8f69-359b9b28b7ce@ti.com>
 <cca25c3d-a352-4531-a8ae-5a0fb7de44df@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <cca25c3d-a352-4531-a8ae-5a0fb7de44df@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 28/03/24 6:09 pm, Andrew Lunn wrote:
> On Thu, Mar 28, 2024 at 11:39:33AM +0530, MD Danish Anwar wrote:
>> Hi Andrew,
>>
>> On 27/03/24 6:05 pm, Andrew Lunn wrote:
>>> On Wed, Mar 27, 2024 at 05:10:54PM +0530, MD Danish Anwar wrote:
>>>> Add support for ICSSG switch firmware using existing Dual EMAC driver
>>>> with switchdev.
>>>>
>>>> Limitations:
>>>> VLAN offloading is limited to 0-256 IDs.
>>>> MDB/FDB static entries are limited to 511 entries and different FDBs can
>>>> hash to same bucket and thus may not completely offloaded
>>>>
>>>> Switch mode requires loading of new firmware into ICSSG cores. This
>>>> means interfaces have to taken down and then reconfigured to switch
>>>> mode.
>>>
>>> Patch 0/3 does not say this. It just shows the interfaces being added
>>
>> I will modify the cover letter to state that.
>>
>>> to the bridge. There should not be any need to down the interfaces.
>>>
>>
>> The interfaces needs to be turned down for switching between dual emac
>> and switch mode.
>>
>> Dual Emac mode runs with ICSSG Dual Emac firmware where as Switch mode
>> works with ICSSG Switch firmware. These firmware are running on the
>> dedicated PRU RPROC cores (pru0, rtu0, txpru0). When switch mode is
>> enabled, these pru cores need to be stopped and then Switch firmware is
>> loaded on these cores and then the cores are started again.
>>
>> We stop the cores when interfaces are down and start the cores when
>> interfaces are up.
>>
>> In short, Dual EMAC firmware runs on pru cores, we put down the
>> interface, stop pru cores, load switch firmware on the cores, bring the
>> interface up and start the pru cores and now Switch mode is enabled.
> 
> This is not the Linux model. Try it, add an interface to a software
> bridge. It does not care if it is admin up or down.
> 
> You need to hide this difference in your driver.
> 

I have been working on this and have found a way to change firmwares
without bringing the interfaces up / down.

By default the interfaces are in MAC mode and the ICSSG EMAC firmwares
are running on pru cores. To enable switch mode we will need to stop the
cores and reload them with the ICSSG Switch firmwares. We can do this
without bringing the interfaces up / down.

When first interface is added to bridge it will still run emac
firmwares. The moment second interface gets added to bridge, we will
disable the ports and stop the pru cores. Load the switch firmwares on
to the cores, start the cores and enable the ports. All of this is done
from the driver.

The user need not to bring the interfaces up / down. Loading / Reloading
of firmwares will be handled inside the driver only. But we do need to
stop the cores for changing firmwares. For stopping the cores we will
change the port state to disable by sending r30 command to firmware.

As we are not restarting the interfaces, the DRAM, SMEM and MSMC RAM
doesn't get cleared. As a result with this approach all configurations
will be saved.

Please let me know if this approach looks ok to you.

Below will be the commands to enable switch mode now,

     ip link add name br0 type bridge
     ip link set dev eth1 master br0
     ip link set dev eth2 master br0 (At this point we will stop the
cores, reload switch firmware, start the cores)
     ip link set dev br0 up
     bridge vlan add dev br0 vid 1 pvid untagged


>>> I keep asking this, so it would be good to explain it in the commit
>>> message. What configuration is preserved over a firmware reload, and
>>> what is lost?
>>>
>>> Can i add VLAN in duel MAC mode and then swap into the switch firmware
>>> and all the VLANs are preserved? Can i add fdb entries to a port in
>>> dual MAC mode, and then swap into the swtich firmware and the FDB
>>> table is preserved? What about STP port state? What about ... ?
>>>
>>
>> When ports are brought up (firmware reload) we do a full cleaning of all
>> the shared memories i.e. SMEM (shared RAM). [1]
>>
>> Vlan table and FDB table are stored in SMEM so all the configuration
>> done to VLAN / FDB tables will be lost.
>>
>> We don't clear DRAM. DRAM is used for sending r30 commands [see
>> emac_r30_cmd_init()], configure half duplex [see
>> icssg_config_half_duplex()] and configure link speed [see
>> icssg_config_set_speed()]. r30 commands are used to set port state (stp).
>>
>> Now when the interfaces are brought up (firmware reload) r30 command is
>> reconfigured as a result any changes done to port state (stp) will be
>> lost. But the duplex and speed settings will be preserved.
>>
>> To summarize,
>> VLAN table / FDB table and port states are lost during a firmware reload.
> 
> So you also need to work around this in your driver. I think it is
> possible to get the network stack to enumerate the configuration. Take
> a look at the Mellanox driver. If i remember it does something like
> this, but i don't remember the details.
> 
>       Andrew

-- 
Thanks and Regards,
Danish

