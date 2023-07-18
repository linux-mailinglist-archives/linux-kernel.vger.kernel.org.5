Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD2757A01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGRLBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGRLBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:01:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98BE43
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:01:19 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R4wsb0svdztRTs;
        Tue, 18 Jul 2023 18:58:11 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 19:01:16 +0800
Message-ID: <64B670FB.6080703@hisilicon.com>
Date:   Tue, 18 Jul 2023 19:01:15 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     "lihuisong (C)" <lihuisong@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <andersson@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] soc: hisilicon: Support HCCS driver on Kunpeng
 SoC
References: <20230424073020.4039-1-lihuisong@huawei.com> <20230530112746.2767-1-lihuisong@huawei.com> <02f74b25-2ade-5b87-b316-ab902f08ead2@huawei.com> <3e106062-9ceb-eb51-70ba-32734c769bd5@kernel.org> <2cc391ce-0e87-040f-6a45-d3e128a988f0@huawei.com>
In-Reply-To: <2cc391ce-0e87-040f-6a45-d3e128a988f0@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2023/7/18 16:07, lihuisong (C) wrote:
> Hi Krzysztof,
> 
> Thank you for your reply.
> 
> 
> 在 2023/7/17 20:06, Krzysztof Kozlowski 写道:
>> On 14/07/2023 08:17, lihuisong (C) wrote:
>>> Hi all,
>>>
>>> Can you take a look at this series?
>> People you listed in "To:" field are not maintainers of HiSilicon, so
>> why pinging us?
> This "To:" field are from the get_maintainer.pl script.
> ./scripts/get_maintainer.pl -f ./drivers/soc/
> The hisilicon in drivers/soc/ is created for the first time. So there are no maintainer of HiSilicon.
> 
> Thanks for reminder.
> add HiSilicon SOC maintainer Wei Xu.
>>
>> HiSilicon DTS has numerous issues, so if you want to increase the
>> chances anyone cares about your patch, please contribute to fixing and
>> improving your company DTS. See for example commit b2bbc8687 which is
>> bad (underscores are not allowed) or 1860a51823 which is just wrong. The
>> latter one is being fixed, although I do not see the fix being picked

Sorry, it seems wrong of the commit 1860a51823 which changed the clock pin.
I have checked the mail list but did not find the bug fix for it.
Could you please kindly share the subject of the patch?
Or I can simply revert it. 
Thanks!

Best Regards,
Wei

>> up... my feelings are the platform is just dead.
> The HCCS driver has nothing to do with HiSilicon DTS.
> So I cannot understand why you say DTS.
> 
> /Huisong
> .
> 
