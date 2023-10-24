Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A47D45CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 05:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjJXDIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 23:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJXDI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 23:08:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277B95;
        Mon, 23 Oct 2023 20:08:21 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SDxjY0pmyzNnGW;
        Tue, 24 Oct 2023 11:04:17 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 24 Oct 2023 11:08:18 +0800
Message-ID: <320656f5-5f6a-4d5c-a028-98d4a1b0dd85@huawei.com>
Date:   Tue, 24 Oct 2023 11:08:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net-next] net: hns3: add some link modes for hisilicon
 device
To:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC:     <shaojijie@huawei.com>,
        "shenjian15@huawei.com" <shenjian15@huawei.com>,
        "wangjie125@huawei.com" <wangjie125@huawei.com>,
        "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
        "chenhao418@huawei.com" <chenhao418@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231023010836.507078-1-shaojijie@huawei.com>
 <MW4PR11MB57763C8FF069B2A567EDCC85FDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB57763C8FF069B2A567EDCC85FDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/10/23 16:55, Drewek, Wojciech wrote:
>
>
>   }
>
> +static const struct hclge_link_mode_bit_map hclge_sr_link_mode_bit_map[8] = {
> Names of those arrays are a bit too long. I know this is a standard here but I'm not sure if
> "bit_map" at the end is necessary.

"bit_map" will change to "bmap" in v2 patch，and the structure name will 
be changed together.

>> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseSR_Full_BIT},
>> +	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseSR_Full_BIT},
>> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT},
>> +	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT},
>> +		if (speed_ability & hclge_sr_link_mode_bit_map[i].support_bit)
>> +			linkmode_set_bit(
> Checkpatch complains about wrong wrapping (here and in the next 3 functions):
> CHECK: Lines should not end with a '('
>
>> +				hclge_sr_link_mode_bit_map[i].link_mode,
>> +				link_mode);
>> +	}
>>   }

this wrong wrapping will disappear if "bit_map" change to "bmap".

Thanks.


