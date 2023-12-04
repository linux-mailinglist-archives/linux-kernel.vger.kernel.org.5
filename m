Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F288A8029C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 02:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjLDBT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 20:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLDBT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 20:19:58 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D8E7;
        Sun,  3 Dec 2023 17:20:04 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Sk5N14z2dz1P93b;
        Mon,  4 Dec 2023 09:16:17 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 09:20:01 +0800
Message-ID: <c10de383-829e-4c24-bf21-0a2cfd0e4cec@huawei.com>
Date:   Mon, 4 Dec 2023 09:20:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: hns: fix fake link up on xge port
To:     Jakub Kicinski <kuba@kernel.org>
References: <20231201102703.4134592-1-shaojijie@huawei.com>
 <20231201102703.4134592-3-shaojijie@huawei.com>
 <20231201211926.3807dd7f@kernel.org>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231201211926.3807dd7f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/12/2 13:19, Jakub Kicinski wrote:
> On Fri, 1 Dec 2023 18:27:03 +0800 Jijie Shao wrote:
>> +void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
> drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:69:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     69 | void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
>        | ^
>        | static

Thanks,
   v2 patch is sent to fix it.

