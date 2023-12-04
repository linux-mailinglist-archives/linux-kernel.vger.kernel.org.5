Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67B803722
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjLDOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjLDOlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:41:49 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459ED7;
        Mon,  4 Dec 2023 06:41:54 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SkR8V5xhxzShbk;
        Mon,  4 Dec 2023 22:37:30 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:41:51 +0800
Message-ID: <0d0e0fc4-ff7c-4e54-8fe6-2a5754cf7910@huawei.com>
Date:   Mon, 4 Dec 2023 22:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 1/2] net: hns: fix wrong head when modify the tx
 feature when sending packets
To:     Wojciech Drewek <wojciech.drewek@intel.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
References: <20231204011051.4055031-1-shaojijie@huawei.com>
 <20231204011051.4055031-2-shaojijie@huawei.com>
 <5db8b856-27fe-41df-82df-774a3ec312a7@intel.com>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <5db8b856-27fe-41df-82df-774a3ec312a7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/12/4 18:15, Wojciech Drewek wrote:
>
> On 04.12.2023 02:10, Jijie Shao wrote:
>> From: Yonglong Liu <liuyonglong@huawei.com>
>>
>> When modify the tx feature, the hns driver will modify the
> Upon changing the...
>
>> maybe_stop_tx() and fill_desc() functions, if the modify happens
>> during packet sending, will cause the hardware and software
>> pointers do not match, and the port can not work anymore.
>>
>> This patch deletes the maybe_stop_tx() and fill_desc() functions
>> modification when setting tx feature, and use the skb_is_gro()
>> to determine use tso functions or non-tso functions when packets
>> sending.
> and use the skb_is_gro() to determine which functions to use in the tx path.
>> Fixes: 38f616da1c28 ("net:hns: Add support of ethtool TSO set option for Hip06 in HNS")
>> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
> Some commit msg suggestions, other than that:
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>
Thanks，
   commit msg is refined in v3
   Jijie

