Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A037C9E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJPEt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjJPEtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:49:25 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008DFA1;
        Sun, 15 Oct 2023 21:49:19 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39G4n1OY118152;
        Sun, 15 Oct 2023 23:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697431741;
        bh=JrRh9ubyzzH2MAP+bXtYybav8jXiF8o2AzNmGNsNuZc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BBBIVCCEr7LI2YqfXWJILudS0rvjsSj8cHdwiFwYOBGW5i9joGP4LlMlxxtfs7BA/
         oOYNxUai18/m/UWhvHpwqdaNsAdkTEPwf1r8O44Znj+PPUKn1uTDPcai9uo7izP+Qh
         MhoNy5j3p2JJK+gUeIBUst0wTgp5pmCV5Yec0pV8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39G4n17r077749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 15 Oct 2023 23:49:01 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 15
 Oct 2023 23:49:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 15 Oct 2023 23:49:01 -0500
Received: from [10.249.135.225] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39G4mud6116504;
        Sun, 15 Oct 2023 23:48:56 -0500
Message-ID: <345f6891-0898-0bba-1d28-84b5aaaaeb08@ti.com>
Date:   Mon, 16 Oct 2023 10:18:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [EXTERNAL] Re: [PATCH net] net: ti: icssg-prueth: Fix r30 CMDs
 bitmasks
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>
References: <20231013111758.213769-1-danishanwar@ti.com>
 <8b11140d-6d91-48aa-be66-9c4a117366af@lunn.ch>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <8b11140d-6d91-48aa-be66-9c4a117366af@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On 10/13/2023 9:30 PM, Andrew Lunn wrote:
> On Fri, Oct 13, 2023 at 04:47:58PM +0530, MD Danish Anwar wrote:
>> The bitmask for EMAC_PORT_DISABLE and EMAC_PORT_FORWARD has been changed
>> in the latest ICSSG firmware.
>>
>> The current bitmasks are wrong and as a result EMAC_PORT_DISABLE and
>> EMAC_PORT_FORWARD commands do not work.
>> Update r30 commands to use the same bitmask as used by the latest ICSSG
>> firmware.
> 
> Please indicate in the commit message this is backwards compatible
> with old firmware. I assume it is actually backwards compatible.
> 

The bitmasks that are used in driver currently is not used in firmware
anymore. The latest ICSSG firmware is using different bitmasks and the
older bitmasks are no longer compatible with the latets ICSSG firmware.
So it is not backwards compatible. I'll mention this in commit message
once I post next revision.

>     Andrew
> 
> ---
> pw-bot: cr

-- 
Thanks and Regards,
Md Danish Anwar
