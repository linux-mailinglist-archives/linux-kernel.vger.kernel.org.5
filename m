Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E537BA4D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbjJEQLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjJEQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:10:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC08C27;
        Thu,  5 Oct 2023 08:52:27 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3955e7Cv037929;
        Thu, 5 Oct 2023 00:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696484407;
        bh=iacW/bffmnzgmS8vl8HxLPwXy/XTDkcCnrPlXbOzKeI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XASewxDbXR9MjecUGxfHiVjJW3Q7Mvwc/beYKngZC2Q1+XGQ9EW/0W5EoOu4IjssR
         dLRlVcc2rnuebB9L+6wt3/ylpzdXrki2FNZpbRB3lC6DXenX0yDGtjGeWHpqYxlRiC
         WdwFA9OLCpOARfJECcmAPTzVatLTTcCOdd1hLd1U=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3955e7Dl021794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 00:40:07 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 00:40:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 00:40:07 -0500
Received: from [10.24.69.31] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3955e1fl034891;
        Thu, 5 Oct 2023 00:40:02 -0500
Message-ID: <fba767da-ae4d-9fb8-b637-955363a57540@ti.com>
Date:   Thu, 5 Oct 2023 11:10:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3] net: ti: icssg_prueth: add
 TAPRIO offload support
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <vladimir.oltean@nxp.com>,
        Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20230928103000.186304-1-danishanwar@ti.com>
 <20231004135833.6efdbced@kernel.org>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20231004135833.6efdbced@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/23 02:28, Jakub Kicinski wrote:
> On Thu, 28 Sep 2023 16:00:00 +0530 MD Danish Anwar wrote:
>> +/**
>> + * Config state machine variables. See IEEE Std 802.1Q-2018 8.6.8.4
>> + */
> 
> Please use correct kdoc format with all members documented or not use
> the /** marker.
> 

Sure. I will update the documentation with correct kdoc format.

>> +struct tas_config_list {
>> +	/* New list is copied at this time */
>> +	u64 config_change_time;
>> +	/* config change error counter, incremented if
>> +	 * admin->BaseTime < current time and TAS_enabled is true
>> +	 */
>> +	u32 config_change_error_counter;
>> +	/* True if list update is pending */
>> +	u8 config_pending;
>> +	/* Set to true when application trigger updating of admin list
>> +	 * to active list, cleared when configChangeTime is updated
>> +	 */
>> +	u8 config_change;
>> +};

-- 
Thanks and Regards,
Danish
