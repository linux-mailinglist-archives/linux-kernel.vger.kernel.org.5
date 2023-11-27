Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AE67F9CE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjK0Jos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjK0Jor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:44:47 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA9DE;
        Mon, 27 Nov 2023 01:44:53 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AR9iXg3103463;
        Mon, 27 Nov 2023 03:44:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701078273;
        bh=c4TtKqduz23cMV1eZmISPwEE/csEVvL4e4+SaaESj70=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=P9R6pejpJK+lsHtH6xicrdIRfB/UOrt60nfqI3I9lYsIL77JuqHc7UuRDNDarUEIL
         t8+Aa5AjPngsAxBZCTVgSZRKcfUHJsbItZ+E+kkk45bd/oeykEcWonfpOdFEmhB+yk
         RIEJYp3GM3MuFrFprhcj9LFz9jWf9f0CBCvCN2vM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AR9iXIR038381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Nov 2023 03:44:33 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 03:44:33 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 03:44:33 -0600
Received: from [172.24.227.133] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AR9iTdX003241;
        Mon, 27 Nov 2023 03:44:30 -0600
Message-ID: <0c26613b-4aba-4e1e-bf0e-57feff23e303@ti.com>
Date:   Mon, 27 Nov 2023 15:14:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ti_am335x_adc: Fix return value check of
 tiadc_request_dma()
Content-Language: en-US
To:     Wadim Egorov <w.egorov@phytec.de>,
        Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <robh@kernel.org>, <heiko@sntech.de>,
        <peter.ujfalusi@ti.com>, <mugunthanvnm@ti.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <upstream@lists.phytec.de>
References: <20230925134427.214556-1-w.egorov@phytec.de>
 <20231005150917.2d0c833e@jic23-huawei>
 <a58ae80e-e281-425a-9b72-bad8fd305e6a@phytec.de>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <a58ae80e-e281-425a-9b72-bad8fd305e6a@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM !!🙂

On 24/11/23 5:41 pm, Wadim Egorov wrote:
>
> Am 05.10.23 um 16:09 schrieb Jonathan Cameron:
>> On Mon, 25 Sep 2023 15:44:27 +0200
>> Wadim Egorov <w.egorov@phytec.de> wrote:
>>
>>> Fix wrong handling of a DMA request where the probing only failed
>>> if -EPROPE_DEFER was returned. Instead, let us fail if a non -ENODEV
>>> value is returned. This makes DMAs explicitly optional. Even if the
>>> DMA request is unsuccessfully, the ADC can still work properly.
>>> We do also handle the defer probe case by making use of 
>>> dev_err_probe().
>>>
>>> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
>>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>
>> +CC Bhavya,
>>
>> Could you take a look at this given you had comments on v1.
>
> Bhavya, any comments on this?
> If not, is there anything else that is blocking this patch?
>
> Regards,
> Wadim
>
>>
>> Thanks,
>>
>> Jonathan
>>
>>> ---
>>> v2:
>>>    - Update description
>>>    - Drop line break after Fixes tag
>>>    - Move decision about optional DMA into probe/caller
>>> ---
>>>   drivers/iio/adc/ti_am335x_adc.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/ti_am335x_adc.c 
>>> b/drivers/iio/adc/ti_am335x_adc.c
>>> index 8db7a01cb5fb..5f8795986995 100644
>>> --- a/drivers/iio/adc/ti_am335x_adc.c
>>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>>> @@ -670,8 +670,10 @@ static int tiadc_probe(struct platform_device 
>>> *pdev)
>>>       platform_set_drvdata(pdev, indio_dev);
>>>         err = tiadc_request_dma(pdev, adc_dev);
>>> -    if (err && err == -EPROBE_DEFER)
>>> +    if (err && err != -ENODEV) {
>>> +        dev_err_probe(&pdev->dev, err, "DMA request failed\n");
>>>           goto err_dma;
>>> +    }
>>>         return 0;
