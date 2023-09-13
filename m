Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855E779E02F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbjIMGof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjIMGod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:44:33 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD2173F;
        Tue, 12 Sep 2023 23:44:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D6iBai079267;
        Wed, 13 Sep 2023 01:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694587451;
        bh=JPONC9PtdwExEoQhycm1a5tpuU81bC3je+jPdwVlSgE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=JaRoraeCdpyFvDBvKnDCDPgCT1mfoTKD2zN5yuRRmX6WBLzC6CK6XK1ItGEUc/ub1
         ceuX3o1wiXFxrwMjIsj5vsxIcdeLNI5QLegO6vi91pL3FmOzwTyk0WvvOFI6b9D3v0
         g6PIhup/ARjsbTJbostG39FaI6F/e+apzkQHM900=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D6iBGo028561
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 01:44:11 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 01:44:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 01:44:11 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D6i6DY099800;
        Wed, 13 Sep 2023 01:44:06 -0500
Message-ID: <09931a97-df62-9803-967f-df6135dc3be7@ti.com>
Date:   Wed, 13 Sep 2023 12:14:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 3/4] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware on AM654 PG2.0 EVM
Content-Language: en-US
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC:     Simon Horman <horms@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, Pekka Varis <p-varis@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-4-danishanwar@ti.com>
 <1fb683f4-d762-427b-98b7-8567ca1f797c@lunn.ch>
 <0d70cebf-8fd0-cf04-ccc2-6f240b27ecca@ti.com>
 <12c11462-5449-b100-5f92-f66c775237fa@kernel.org>
 <3fbf9514-8f9f-d362-9006-1fd435540e67@ti.com>
In-Reply-To: <3fbf9514-8f9f-d362-9006-1fd435540e67@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger / Andrew,

On 08/09/23 13:47, MD Danish Anwar wrote:
> On 08/09/23 13:16, Roger Quadros wrote:
>>
>>
>> On 05/09/2023 11:43, MD Danish Anwar wrote:
>>> On 04/09/23 19:38, Andrew Lunn wrote:
>>>>> Switch mode requires loading of new firmware into ICSSG cores. This
>>>>> means interfaces have to taken down and then reconfigured to switch mode
>>>>> using devlink.
>>>>
>>>> Can you always run it in switch mode, just not have the ports in a
>>>> bridge?
>>>>
>>>> 	Andrew
>>>
>>> No, we can't always run it in switch mode. Switch mode requires loading
>>> of different firmware. The switch firmware only supports switch
>>> operations. If the ports are not in a bridge in switch mode, the normal
>>> functionalities will not work. We will not be able to send / receive /
>>> forward packets in switch mode without bridge.
>>>
>>> When device is booted up, the dual EMAC firmware is loaded and ICSSG
>>> works in dual EMAC mode with both ports doing independent TX / RX.
>>>
>>> When switch mode is enabled, dual EMAC firmware is unloaded and switch
>>> firmware is loaded. The ports become part of the bridge and the two port
>>> together acts as a switch.
>>>
>>
>> Since we are loading the switch firmware and the switch logic is in firmware,
>> it means we don't really need Linux help to do basic switching on the external
>> ports.
>>
>> I suppose Andrews question was, can it work as a switch after switching
>> from dual-emac to switch mode and not setting up the Linux bridge.
>>
> 
> I did some further testing on switch mode. The basic functionality would
> work without a bridge as well. This will need one modification in driver
> but even without bridge switching will work.
> 
> When enabling switch mode the driver sets the HOST_MAC_ADDR to the
> bridge's addr. If bridge is not there, this will result in KERNEL NULL
> POINTER crash.
> 
> icssg_class_set_host_mac_addr(prueth->miig_rt,
> prueth->hw_bridge_dev->dev_addr);
> 
> However if we change this to only set when bridge is there, it works
> 
> if (prueth->hw_bridge_dev)
> 	icssg_class_set_host_mac_addr(prueth->miig_rt,
> prueth->hw_bridge_dev->dev_addr);
> 
> With this change forwarding works in switch mode without setting up the
> bridge. Just loading the switch firmware is enough.
> 
> 
>> e.g. Looking at your command list
>>
>>> Switch to ICSSG Switch mode:
>>>  ip link set dev eth1 down
>>>  ip link set dev eth2 down
>>>  devlink dev param set platform/icssg2-eth name \
>>>  switch_mode value 1 cmode runtime
>>
>> At this point, can it work as a switch. If not, why?>
> 
> To summarize, yes it can work at this point.
> 

As discussed on this thread, switching operation can work with the ICSSG
switch firmware, without creating bridge. However without bridge only
forwarding works. If we want the switch to consume packets bridge is
required.

ICSSG switch firmware without bridge
  - Forwarding works but packets can not be consumed by switch.

ICSSG switch firmware without bridge
  - Forwarding works and packets can be consumed by switch.

In order to consume the packets, creating a bridge is required.

I will keep the commands in commit message as it is. Please let me know
if this is OK to you or if any change is required.

>>>  ip link add name br0 type bridge
>>>  ip link set dev eth1 master br0
>>>  ip link set dev eth2 master br0
>>>  ip link set dev br0 up
>>>  ip link set dev eth1 up
>>>  ip link set dev eth2 up
>>>  bridge vlan add dev br0 vid 1 pvid untagged self
>>
> 

-- 
Thanks and Regards,
Danish
