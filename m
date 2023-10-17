Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643357CBCE8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbjJQH44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQH4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:56:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647AC93;
        Tue, 17 Oct 2023 00:56:52 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S8mQs5jvzzvQ67;
        Tue, 17 Oct 2023 15:52:05 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 17 Oct
 2023 15:56:49 +0800
Subject: Re: [PATCH net-next v11 0/6] introduce page_pool_alloc() related API
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20231013064827.61135-1-linyunsheng@huawei.com>
 <20231016182725.6aa5544f@kernel.org>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2059ea42-f5cb-1366-804e-7036fb40cdaa@huawei.com>
Date:   Tue, 17 Oct 2023 15:56:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20231016182725.6aa5544f@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 9:27, Jakub Kicinski wrote:
> On Fri, 13 Oct 2023 14:48:20 +0800 Yunsheng Lin wrote:
>> v5 RFC: Add a new page_pool_cache_alloc() API, and other minor
>>         change as discussed in v4. As there seems to be three
>>         comsumers that might be made use of the new API, so
>>         repost it as RFC and CC the relevant authors to see
>>         if the new API fits their need.
> 
> I have looked thru the v4 discussion (admittedly it was pretty huge).
> I can't find where the "cache" API was suggested.

Actually, the discussion happened in V3 as both of discussions in V3
and V4 seems to be happening concurrently:

https://lore.kernel.org/all/f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com/

> And I can't figure out now what the "cache" in the name is referring to.
> Looks like these are just convenience wrappers which return VA instead
> of struct page..

Yes, it is corresponding to some API like napi_alloc_frag() returning va
instead of 'struct page' mentioned in patch 5.

Anyway, naming is hard, any suggestion for a better naming is always
welcomed:)

> .
> 
