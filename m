Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA267CDB83
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjJRM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjJRM0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:26:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C998;
        Wed, 18 Oct 2023 05:26:02 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S9VPJ6ZLSz15NZL;
        Wed, 18 Oct 2023 20:23:16 +0800 (CST)
Received: from [192.168.98.231] (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 20:25:59 +0800
Message-ID: <f256ba6b-b0e7-333a-10a7-57b73892d626@huawei.com>
Date:   Wed, 18 Oct 2023 20:25:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
        <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
To:     Andrew Lunn <andrew@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
 <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
 <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
 <e7219114-774f-49d0-8985-8875fd351b60@lunn.ch>
 <a21beff2-9f38-d354-6049-aed20c18c8d4@huawei.com>
 <150d8d95-a6cd-dc28-618b-6cc5295b4bf9@huawei.com>
 <06cd6f53-e0af-4bdf-a684-68fc55b9b436@lunn.ch>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <06cd6f53-e0af-4bdf-a684-68fc55b9b436@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/10/17 21:59, Andrew Lunn wrote
> I still think this is totally valid and correct.
>
> When you turn auto-neg off the link partner is going to react to that,
> it might drop the link. After a while, the link partner will give up
> trying to perform auto-neg and might fall back to 10/Half. At which
> point, the link might allow traffic flow. However, in this example,
> you have a duplex mis-match, so it might not work correctly.
>
> Turning off auto-neg is something you need to do at both ends, and you
> need to then force both ends to the same settings. Link down is
> expected. I would actually be suppressed if no link down events were
> reported.
>
> 	Andrew

Hi Andrew,
Thank you for your comments, we are re-evaluating this issue and may drop this patch.

Regards
Jijie

