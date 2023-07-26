Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C047632C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjGZJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjGZJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:50:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E448C1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:50:05 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R9pwH5vdPzLnrf;
        Wed, 26 Jul 2023 17:47:27 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 17:50:02 +0800
Message-ID: <cec839a5-7fda-d762-190d-706355f63319@huawei.com>
Date:   Wed, 26 Jul 2023 17:49:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] misc: hi6421-spmi-pmic: Remove redundant dev_err()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
References: <20230726170644.2474917-1-ruanjinjie@huawei.com>
 <2023072646-valid-quote-d313@gregkh>
Content-Language: en-US
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <2023072646-valid-quote-d313@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/26 17:42, Greg KH wrote:
> On Wed, Jul 26, 2023 at 05:06:44PM +0000, Ruan Jinjie wrote:
>> There is no need to call the dev_err() function directly to print a custom
>> message when handling an error from the platform_get_irq() functions as it
>> going to display an appropriate error message in case of a failure.
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/misc/hi6421v600-irq.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
>> index caa3de37698b..e5ed94e98a3c 100644
>> --- a/drivers/misc/hi6421v600-irq.c
>> +++ b/drivers/misc/hi6421v600-irq.c
>> @@ -245,7 +245,6 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
>>  
>>  	priv->irq = platform_get_irq(pmic_pdev, 0);
>>  	if (priv->irq < 0) {
>> -		dev_err(dev, "Error %d when getting IRQs\n", priv->irq);
>>  		return priv->irq;
>>  	}
> 
> It's good not to add coding style errors when trying to fix up a
> different type of issue :(

I'll fix the coding style error in v2, thank you!
