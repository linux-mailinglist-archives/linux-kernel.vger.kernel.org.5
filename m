Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CFB7CD2D9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjJRE2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJRE2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:28:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A10C6;
        Tue, 17 Oct 2023 21:28:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39I4SLmx007283;
        Tue, 17 Oct 2023 23:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697603301;
        bh=ymnhw4SfegKgXsNAJHa1nXVssww8LjwrpNl0AxLmOvA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jeVwhUsMetYuMRsZDyMKyzCGRhCn9WvO3eWn4gh0o88RPuhEc+IKuibw0YxPGa+yN
         ocUTZ9u4Df29Is1LEk/LMSpazOAzWiIOscyRf/EltwAA/+Ti30C9Tkm5JJQvTb4arR
         UOhpL8o7fPDb0d2dGnOSPpkupvm7Vlser2hbl3/I=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39I4SLRQ128032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Oct 2023 23:28:21 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Oct 2023 23:28:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Oct 2023 23:28:21 -0500
Received: from [10.24.69.31] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39I4SG8Z055260;
        Tue, 17 Oct 2023 23:28:16 -0500
Message-ID: <5408c3c6-568d-4a05-9db5-7be11438da5e@ti.com>
Date:   Wed, 18 Oct 2023 09:58:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net] net: ethernet: ti: Fix mixed
 module-builtin object
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20231013100549.3198564-1-danishanwar@ti.com>
 <a3612d9fce07dffc1029cf49286f16913d2e2df8.camel@redhat.com>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <a3612d9fce07dffc1029cf49286f16913d2e2df8.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/23 4:34 pm, Paolo Abeni wrote:
> On Fri, 2023-10-13 at 15:35 +0530, MD Danish Anwar wrote:
>> With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
>> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
>> the expected CFLAGS are different between builtins and modules.
>>
>> The build system is complaining about the following:
>>
>> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
>> ti-am65-cpsw-nuss
>>
>> Introduce the new module, k3-cppi-desc-pool, to provide the common
>> functions to ti-am65-cpsw-nuss and icssg-prueth.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> Given that you target the -net tree, please include a suitable fixes
> tag, thanks!
> 

Sure. I'll add the proper fixes tag in commit message and send next
revision.

> Paolo
> 

-- 
Thanks and Regards,
Danish
