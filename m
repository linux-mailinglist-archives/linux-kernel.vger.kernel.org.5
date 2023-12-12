Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AE80E999
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjLLLFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjLLLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:05:40 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F6AB;
        Tue, 12 Dec 2023 03:05:45 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SqG4J43J8zsSFp;
        Tue, 12 Dec 2023 19:05:36 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
        by mail.maildlp.com (Postfix) with ESMTPS id 24A7B180032;
        Tue, 12 Dec 2023 19:05:43 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 19:05:42 +0800
Message-ID: <c51d3d95-4b59-405f-b5c2-71ccc4dc7cce@huawei.com>
Date:   Tue, 12 Dec 2023 19:05:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/6] net: hns3: add support for
 page_pool_get_stats
To:     Jakub Kicinski <kuba@kernel.org>
References: <20231211020816.69434-1-shaojijie@huawei.com>
 <20231211020816.69434-2-shaojijie@huawei.com>
 <20231211191759.61764363@kernel.org>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231211191759.61764363@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/12/12 11:17, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 10:08:11 +0800 Jijie Shao wrote:
>> Add support for page_pool_get_stats, then the hns3 driver
>> can get page pool statistics by ethtool.
> Sorry, you're late to the party :( We have now added the ability to
> read page pool stats via netlink. The support was merged as
> a379972973a80924b1d03443e20f113ff76a94c7.
>
> If you use the page pools in your driver in a normal way (each page
> pool only used by one NAPI instance and one netdev) you should use
> that instead of dumping the stats into ethtool -S.

Okay, we'll try to use netlink instead of ethtool.
And this patch will be dropped in v2 patch set. Jijie

