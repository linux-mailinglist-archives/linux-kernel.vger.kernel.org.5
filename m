Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C980A229
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjLHL2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHL2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:28:44 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8F610D8;
        Fri,  8 Dec 2023 03:28:50 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Smpmv2xLRz1Q6FZ;
        Fri,  8 Dec 2023 19:28:47 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 19:28:48 +0800
Subject: Re: [PATCH net-next v6 08/12] libie: add Rx buffer management (via
 Page Pool)
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
 <20231207172010.1441468-9-aleksander.lobakin@intel.com>
 <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
Message-ID: <687ac9bb-c7ca-fc71-9e61-d9247198224a@huawei.com>
Date:   Fri, 8 Dec 2023 19:28:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/8 17:28, Yunsheng Lin wrote:

>> +
>> +	page_pool_dma_sync_for_cpu(page->pp, page, buf->offset, len);
> 
> Is there a reason why page_pool_dma_sync_for_cpu() is still used when
> page_pool_create() is called with PP_FLAG_DMA_SYNC_DEV flag? Isn't syncing
> already handled in page_pool core when when PP_FLAG_DMA_SYNC_DEV flag is
> set?

Ah, it is a sync_for_cpu.
Ignore this one.
