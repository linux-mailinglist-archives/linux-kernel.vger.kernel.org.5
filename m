Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90068806FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378238AbjLFMbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378058AbjLFMbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:31:40 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929C7D3;
        Wed,  6 Dec 2023 04:31:46 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SlcB52hG2z1Q65Q;
        Wed,  6 Dec 2023 20:27:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 20:31:44 +0800
Message-ID: <f7588e40-0fea-4350-89fe-c432eacb68f7@huawei.com>
Date:   Wed, 6 Dec 2023 20:31:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <shaojijie@huawei.com>, <shenjian15@huawei.com>,
        <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net 1/2] net: hns: fix wrong head when modify the tx
 feature when sending packets
To:     Paolo Abeni <pabeni@redhat.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>,
        <wojciech.drewek@intel.com>
References: <20231204143232.3221542-1-shaojijie@huawei.com>
 <20231204143232.3221542-2-shaojijie@huawei.com>
 <ffd7a4cbefa8c4f435db5bab0f5f7f2d4e2dad73.camel@redhat.com>
From:   Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ffd7a4cbefa8c4f435db5bab0f5f7f2d4e2dad73.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.192]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


on 2023/12/6 19:18, Paolo Abeni wrote:
> +		priv->ops.fill_desc = fill_desc_v2;
> +		priv->ops.maybe_stop_tx = hns_nic_maybe_stop_tx_v2;
> Side note: since both 'fill_desc' and 'maybe_stop_tx' have constant
> values, for net-next you should really consider replacing the function
> pointers with direct-calls.
>
> You currently have at least 2 indirect calls per wire packet, which
> hurt performances a lot in case security issues mitigations are in
> place.
>
> Cheers,
>
> Paolo

Thank you for your advice. Currently, because the hardware behavior is 
different, the two versions of ops are retained to unify the subsequent 
process. We will try to unify the two version ops, and if that does not 
work, we will consider maintaining the status quo. Thanks again! Jijie

