Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0057AA9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjIVHFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIVHFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:05:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFBB192;
        Fri, 22 Sep 2023 00:05:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38M74bwP024089;
        Fri, 22 Sep 2023 02:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695366277;
        bh=ZoxXZ3Y37cG93Q4rzhxBeq+p7DzB6VmKffMfMcF/QFc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PyLgQVhMUGbUpfsQ4lBYHBbg17QVJjkI2cg2azeZg3679NqvcPQrzoY91+j1/Zlac
         lImXdEqTfrB958/Rb2aNCx23ToQpNFqpyrqoDsmTBslWudAzX46PckcIRmI8c0R1GM
         YY1jEgZi8/n/QQT4xwIed6Dc2Qg8mtaJJOrqzwjo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38M74bql078327
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Sep 2023 02:04:37 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 02:04:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 02:04:36 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38M74Wal056954;
        Fri, 22 Sep 2023 02:04:32 -0500
Message-ID: <c64625b5-ef67-70a7-4190-ae0fae9951bc@ti.com>
Date:   Fri, 22 Sep 2023 12:34:31 +0530
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
 <92864bda-3028-f8be-0e27-487024d1a874@ti.com>
 <fa86c001-e01e-45b8-b6f4-514e8c507f02@lunn.ch>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <fa86c001-e01e-45b8-b6f4-514e8c507f02@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/23 19:07, Andrew Lunn wrote:
>> Thanks for the offline discussion and explanations. As discussed, we can
>> not have one combined firmware to do both switch operations and dual
>> emac operations. It is required to have two different firmwares.
>> Currently which firmware to load is decided by flag 'is_switch_mode'
>> which is set / unset by devlink. I will not use devlink here as asked by
>> you. Instead, I'll use the approach suggested by you.
>> ndo_open() will load the dual mac firmware. I'll swap to switch firmware
>> when the second port is added to the same bridge as the first port.
>>
>> I will re-work the changes and post v2 soon.
> 
> I'm sceptical you can actually make this work correctly, but lets see
> what v2 contains.
> 

Sure. I will try to make this work and post v2 once it's ready.

>      Andrew

-- 
Thanks and Regards,
Danish
