Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44647CF325
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344941AbjJSIrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjJSIrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:47:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01777AB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:47:15 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SB1VP0tpmz15Nh1;
        Thu, 19 Oct 2023 16:44:29 +0800 (CST)
Received: from [192.168.98.209] (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 16:47:12 +0800
Message-ID: <aa593e44-2075-2261-6593-bd120d68be92@huawei.com>
Date:   Thu, 19 Oct 2023 16:47:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <chenhao418@huawei.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 drivers/perf: hisi:] drivers/perf: hisi: use
 cpuhp_state_remove_instance_nocalls() for hns3 pmu uninit process
To:     Yicong Yang <yangyicong@huawei.com>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <mark.rutland@arm.com>,
        <yangyicong@hisilicon.com>
References: <20231016105139.1436425-1-shaojijie@huawei.com>
 <46461fdf-575d-fa32-28b8-420bf0e54210@huawei.com>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <46461fdf-575d-fa32-28b8-420bf0e54210@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/10/19 9:52, Yicong Yang wrote:
> On 2023/10/16 18:51, Jijie Shao wrote:
>> [27169.898241]  kthread+0x168/0x16c
>> [27169.904178]  ret_from_fork+0x10/0x18
>> [27169.911943] Code: 944beda1 aa1403e0 944bed9f f8460f5c (f9400394)
>>
>> And tested some other uncore pmu driver such as hisi pcie pmu and hisi uncore i3c pmu,
> It's l3c pmu, not i3c pmu. Please just use the driver name like hisi_pcie_pmu or
> hisi_uncore_l3c_pmu in the commit. So is below.
>
> Others looks good to me. With this fixed,
>
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
>
Thanks, I'll replace them in v3. Jijie

