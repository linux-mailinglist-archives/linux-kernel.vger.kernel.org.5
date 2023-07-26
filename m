Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D587632B7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjGZJsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjGZJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:48:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B197
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:48:14 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9psF1lGfzNmTw;
        Wed, 26 Jul 2023 17:44:49 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 17:48:11 +0800
Message-ID: <f4a50436-4409-0bde-429f-f01e54e6fccc@huawei.com>
Date:   Wed, 26 Jul 2023 17:48:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RESEND v3 1/2] soc: hisilicon: Support HCCS driver on
 Kunpeng SoC
To:     Randy Dunlap <rdunlap@infradead.org>, <xuwei5@hisilicon.com>,
        <arnd@arndb.de>, <krzk@kernel.org>, <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>,
        <lihuisong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230725075706.48939-1-lihuisong@huawei.com>
 <20230725075706.48939-2-lihuisong@huawei.com>
 <d35eddd6-0089-bbe8-c2f9-416941dcbed6@infradead.org>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <d35eddd6-0089-bbe8-c2f9-416941dcbed6@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy Dunlap,

many thanks for reviewing my patch.


在 2023/7/25 23:28, Randy Dunlap 写道:
> Hi--
>
> On 7/25/23 00:57, Huisong Li wrote:
>> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
>> new file mode 100644
>> index 000000000000..87a1f15cbedb
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/Kconfig
>> @@ -0,0 +1,19 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +menu "Hisilicon SoC drivers"
>> +	depends on ARCH_HISI || COMPILE_TEST
>> +
>> +config KUNPENG_HCCS
>> +	tristate "HCCS driver on Kunpeng SoC"
>> +	depends on ACPI
>> +	depends on ARM64 || COMPILE_TEST
>> +	help
>> +	  The Huawei Cache-Coherent System (HCCS) is a bus protocol standard
> Just curious: what makes it a standard?
HCCS is just a self-defined bus protocol and used for multi-chip 
interconnection.
The description above doesn't seem appropriate.
I will fix these releated description in next version.
>
>> +	  for ensuring cache coherent on HiSilicon SoC. The performance of
> 	                     coherence
Ack, thanks.
>
>> +	  the application may be affected if some hccs ports are in non-full
> 	                                          HCCS
HCCS is a bus protocol, it should be all capitals.
And hccs port is an abstraction object in code layer here.
So maybe it is ok here. what do you think?

Best regards,
Huisong
