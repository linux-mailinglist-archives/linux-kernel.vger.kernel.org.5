Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C7E7AA707
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjIVCim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjIVCil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:38:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17245192;
        Thu, 21 Sep 2023 19:38:35 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38LBJKR7107142;
        Thu, 21 Sep 2023 06:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695295160;
        bh=sV7+6G3yKC3Rpx42RLBRQq3uGcn7glfICsPgVYKKByo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=xpRQXcmWi6VYTxsITB7mGzxgyg+3h6wKMH3+cSgTgmoEgf8sMgRFPJVyY6cROZ+FZ
         MkbdbcGpuUxwi8InT6DeVTbmUdlx4s37gqO6YBK+oQizWj3pYRO70LR3CCqN2Eozps
         X3DSrm5GDS4Ny/P4KGjydccseo/IvJvNjaAhRKXY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38LBJKot122446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Sep 2023 06:19:20 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 06:19:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 06:19:20 -0500
Received: from [10.24.69.199] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38LBJFNJ013074;
        Thu, 21 Sep 2023 06:19:16 -0500
Message-ID: <92864bda-3028-f8be-0e27-487024d1a874@ti.com>
Date:   Thu, 21 Sep 2023 16:49:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH net-next 3/4] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware on AM654 PG2.0 EVM
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
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
 <09931a97-df62-9803-967f-df6135dc3be7@ti.com>
 <055e781e-f614-4436-9d8d-e60e17fac5c9@lunn.ch>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <055e781e-f614-4436-9d8d-e60e17fac5c9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 13/09/23 17:49, Andrew Lunn wrote:
>> As discussed on this thread, switching operation can work with the ICSSG
>> switch firmware, without creating bridge. However without bridge only
>> forwarding works. If we want the switch to consume packets bridge is
>> required.
> 
> What packets will the switch consume? The only packets i can think of
> are pause frames. Everything else get passed to the CPU.
> 
> You also need to think of what happens when a single switch port is
> added to the bridge, and an external port, like a tun/tap device for a
> VPN is added to the bridge.
> 
> For most switches, a port not being a member of a switch means the
> port is pretty dumb and every frame is forwarded to the CPU. There are
> however some switches which perform address learning as usual,
> learning if an address is on the port, or on the CPU. Maybe you can
> see if that is possible.
> 
> It might be you need your firmware people involved to produce a new
> firmware version which combines both firmwares in one.
> 

Thanks for the offline discussion and explanations. As discussed, we can
not have one combined firmware to do both switch operations and dual
emac operations. It is required to have two different firmwares.
Currently which firmware to load is decided by flag 'is_switch_mode'
which is set / unset by devlink. I will not use devlink here as asked by
you. Instead, I'll use the approach suggested by you.
ndo_open() will load the dual mac firmware. I'll swap to switch firmware
when the second port is added to the same bridge as the first port.

I will re-work the changes and post v2 soon.

> 	 Andrew

-- 
Thanks and Regards,
Danish
