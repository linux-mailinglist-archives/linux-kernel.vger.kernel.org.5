Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4339F7CB11B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjJPRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjJPRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:10:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C652413;
        Mon, 16 Oct 2023 09:56:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GGuTmc113281;
        Mon, 16 Oct 2023 11:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697475389;
        bh=8uawIvwXCNY3cQCPZEe1PeCx0P4Tg5jesgAAUCp7n7U=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tgzt7S9peZqtq4Jwc7d96+kGQYhJN63L4gsd6B9J73K9syja/gy0lsoiexDrgMnR6
         czoMV0M3HRefUzpLFovVmBTKnypzH2EvMrnkI/6o0Xn1/SEtV8CYDwtlsrIs4/oxRL
         6aqGRZpvtvz/0Dg9c01J5u9XoBJUQYbPA7ihSza0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GGuTMH002669
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Oct 2023 11:56:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:56:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:56:29 -0500
Received: from [10.249.135.225] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GGuOOI032386;
        Mon, 16 Oct 2023 11:56:25 -0500
Message-ID: <d7e56794-8061-bf18-bb6f-7525588546fc@ti.com>
Date:   Mon, 16 Oct 2023 22:26:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix r30 CMDs bitmasks
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20231016161525.1695795-1-danishanwar@ti.com>
 <11109e7d-139b-4c8c-beaa-e1e89e355b1b@lunn.ch>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <11109e7d-139b-4c8c-beaa-e1e89e355b1b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2023 9:58 PM, Andrew Lunn wrote:
> On Mon, Oct 16, 2023 at 09:45:25PM +0530, MD Danish Anwar wrote:
>> The bitmask for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD has been changed
>> in the ICSSG firmware REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05.
>>
>> The current bitmasks are wrong and as a result EMAC_PORT_DISABLE and
>> EMAC_PORT_FORWARD commands doesn not work.
>> Update r30 commands to use the same bitmask as used by the ICSSG firmware
>> REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05.
>>
>> These bitmasks are not backwards compatible. This will work with
>> firmware version REL.PRU-ICSS-ETHERNET-SWITCH_02.02.12.05 and above but
>> not with lower firmware versions.
> 
> Breaking backwards compatibility is generally not allowed.
> 
> As far as i understand the driver, it loads whatever version of
> firmware is available. It does not ask for a specific version. So you
> should ask the firmware what version it is, and then handle the
> bitmask as appropriate.
> 

Understood. I will try to find a way to do this at runtime.

> How many different versions of REL.PRU-ICSS-ETHERNET-SWITCH have been
> released? They don't appear to be part of linux-firmware.git :-(
> 

The firmwares are currently not posted to linux-firmware.git. They are
maintained internally as of now. Different version of firmware is
released for every SDK release (3-4 times a year)

>     Andrew
> 
> ---
> pw-bot: cr

-- 
Thanks and Regards,
Md Danish Anwar
