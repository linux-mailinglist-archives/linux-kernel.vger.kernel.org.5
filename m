Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9B76FA16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjHDG2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjHDG1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:27:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2004420F;
        Thu,  3 Aug 2023 23:27:33 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3746RG70004029;
        Fri, 4 Aug 2023 01:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691130436;
        bh=aVMkm0fvjJq74xKoRYCdUE5Kf1yzRBggpT42jKgZ5yg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cIaTf2EeK34kk3is6LYN2Ee1SNV7kjfLEf9op4Y5ztmEVhj9+cHnVKOwzFKnEaLDe
         ohEevU5sKLCpr7JzWIbuTU7Kok6NHP9Dps3ctlKU2qxSgmU4IhyCa/L6vbf8nBhDU3
         wJD/ZlRBDWD2RR88rp09+RIGQWuuNBCMGOSgEqRc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3746RG69078710
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 01:27:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 01:27:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 01:27:15 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3746R9hp109638;
        Fri, 4 Aug 2023 01:27:09 -0500
Message-ID: <8e0da18c-3856-d9af-3940-85dcc7f698a0@ti.com>
Date:   Fri, 4 Aug 2023 11:57:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] net: ti: icss-iep: Add IEP driver
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230803110153.3309577-1-danishanwar@ti.com>
 <20230803110153.3309577-3-danishanwar@ti.com> <ZMvE63ooNyoRZK/y@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <ZMvE63ooNyoRZK/y@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/23 8:46 pm, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 04:31:51PM +0530, MD Danish Anwar wrote:
>> From: Roger Quadros <rogerq@ti.com>
>>
>> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
>> support timestamping of ethernet packets and thus support PTP and PPS
>> for PRU ethernet ports.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> ...
> 
>> +static int icss_iep_pps_enable(struct icss_iep *iep, int on)
>> +{
>> +	int ret = 0;
>> +	struct timespec64 ts;
>> +	struct ptp_clock_request rq;
>> +	unsigned long flags;
>> +	u64 ns;
> 
> For networking code, please arrange local variables in reverse xmas tree
> order - longest line to shortest.
> 
> https://github.com/ecree-solarflare/xmastree is your friend here.
> 
> ...

Sure Simon, I will take care of this in next revision.

-- 
Thanks and Regards,
Danish.
