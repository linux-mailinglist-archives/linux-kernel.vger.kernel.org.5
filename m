Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13309792702
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjIEQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353939AbjIEInd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:43:33 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71CCCB;
        Tue,  5 Sep 2023 01:43:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3858hKep034884;
        Tue, 5 Sep 2023 03:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693903400;
        bh=AudSJA9iYvKkq4w9grIgZlqTekwQAu0gWkAM2I2VDlw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=KuqSptb/7zQttvnVZ8mXK2yZIrIZZXn3JnW4KXiJAJeM6aKekojW4RyKLbB6QYwFj
         XGnWVKSUBq6mvnRKjhLdypcezZ+1Tarl8YqdwGD5YSNsLneeKLw2P1W6DhMvqVf1Ls
         /Kk25T+4bMMl3qgGnWZVuPw/j84uSjCtcp8HshJg=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3858hKFF002349
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Sep 2023 03:43:20 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 03:43:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 03:43:20 -0500
Received: from [10.24.69.199] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3858hFCM045128;
        Tue, 5 Sep 2023 03:43:16 -0500
Message-ID: <0d70cebf-8fd0-cf04-ccc2-6f240b27ecca@ti.com>
Date:   Tue, 5 Sep 2023 14:13:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 3/4] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware on AM654 PG2.0 EVM
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-4-danishanwar@ti.com>
 <1fb683f4-d762-427b-98b7-8567ca1f797c@lunn.ch>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <1fb683f4-d762-427b-98b7-8567ca1f797c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/23 19:38, Andrew Lunn wrote:
>> Switch mode requires loading of new firmware into ICSSG cores. This
>> means interfaces have to taken down and then reconfigured to switch mode
>> using devlink.
> 
> Can you always run it in switch mode, just not have the ports in a
> bridge?
> 
> 	Andrew

No, we can't always run it in switch mode. Switch mode requires loading
of different firmware. The switch firmware only supports switch
operations. If the ports are not in a bridge in switch mode, the normal
functionalities will not work. We will not be able to send / receive /
forward packets in switch mode without bridge.

When device is booted up, the dual EMAC firmware is loaded and ICSSG
works in dual EMAC mode with both ports doing independent TX / RX.

When switch mode is enabled, dual EMAC firmware is unloaded and switch
firmware is loaded. The ports become part of the bridge and the two port
together acts as a switch.

-- 
Thanks and Regards,
Danish
