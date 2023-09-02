Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181F79076D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352011AbjIBKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIBKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 06:49:40 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F151DF3;
        Sat,  2 Sep 2023 03:49:37 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 382AnTE6053508;
        Sat, 2 Sep 2023 05:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693651769;
        bh=eSltXZan7LriIla3Y/IlaziApsmbM659wA9eteSvgpE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JGxNtEuL9dVwlT8GcMA3L//75O6YPUslI9ojSaes306PUq8wQgHqN6raeV07PonzC
         gkzghRgxcPfMog7xmMYTQ6IMgsIlITgWZMA2ITVbFmJOiEp9iMjdBYK/IOMV8XJK4d
         UT5jVOWf/9uFMLEmE6AhTiMCOQZnjzhH5fyI0VwM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 382AnTn5007790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 2 Sep 2023 05:49:29 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 2
 Sep 2023 05:49:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 2 Sep 2023 05:49:29 -0500
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 382AnSYv001654;
        Sat, 2 Sep 2023 05:49:28 -0500
Message-ID: <d2abf77e-5a9b-0394-8105-e31832c813ef@ti.com>
Date:   Sat, 2 Sep 2023 05:49:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 5/5] remoteproc: k3-m4: Add a remoteproc driver for M4F
 subsystem
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <andersson@kernel.org>, <p.zabel@pengutronix.de>,
        <martyn.welch@collabora.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20230808044529.25925-1-hnagalla@ti.com>
 <20230808044529.25925-6-hnagalla@ti.com> <ZO5OnjJAQJC0UCq+@p14s>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <ZO5OnjJAQJC0UCq+@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 15:01, Mathieu Poirier wrote:
>> + *
>> + * ti_k3_m4_remoteproc.c:
>> + * Copyright (C) 2021 Texas Instruments Incorporated -https://www.ti.com/
>> + *	Hari Nagalla<hnagalla@ti.com>
>>    */
>>   
>>   #ifndef REMOTEPROC_TI_K3_COMMON_H
>> @@ -82,6 +86,7 @@ struct k3_rproc {
>>   	u32 ti_sci_id;
>>   	struct mbox_chan *mbox;
>>   	struct mbox_client client;
>> +	bool ipc_only;
>  From the comments above this should have been removed.
> 
I got it removed from the driver replacing the ipc_only flag with 
runtime logic, but failed to remove from header file. Will fix it and 
send the patch series. Thanks

