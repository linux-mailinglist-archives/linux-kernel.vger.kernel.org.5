Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058FC758C36
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSDl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGSDl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:41:27 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE54A4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:41:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R5M6r43TXz4f3kFv
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:41:08 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgAH2K5VW7dkLzM2OQ--.655S2;
        Wed, 19 Jul 2023 11:41:11 +0800 (CST)
Subject: Re: [PATCH 0/3] minor cleanups to page_ext header
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230717113227.1897173-1-shikemeng@huaweicloud.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <fd753649-537f-af47-6ab5-1eea351c1c84@huaweicloud.com>
Date:   Wed, 19 Jul 2023 11:41:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230717113227.1897173-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgAH2K5VW7dkLzM2OQ--.655S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4xJr1UGry7Cw15uw17Jrb_yoWfGFb_Cr
        W2y3s2k347Ka42qF1jk3Z7Xr4xGFW8Wr45urn5tr1aq34rtFZ0q3Z7A3sxXr4FgrW5AFy5
        Cw4DZ3sakr12vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, sorry for the bother. I notice that you have taken my patches sent
later and I do appreciate it. I send this email just to avoid this series sent
early is missed for some unknow reasons. Thanks!

on 7/17/2023 7:32 PM, Kemeng Shi wrote:
> Hi all, this series does page_ext header relevant cleanups.
> First two patches remove unused page_ext header from page_poison and
> vmstat. The last patch move page_ext_operations definition under
> CONFIG_PAGE_EXTENSION. Thanks!
> 
> Kemeng Shi (3):
>   mm/page_poison: remove unused page_ext.h from page_poison
>   mm/vmstat: remove unused page_ext.h from vmstat
>   mm/page_ext: move page_ext_operations definition under
>     CONFIG_PAGE_EXTENSION
> 
>  include/linux/page_ext.h | 3 +--
>  mm/page_poison.c         | 1 -
>  mm/vmstat.c              | 1 -
>  3 files changed, 1 insertion(+), 4 deletions(-)
> 

-- 
Best wishes
Kemeng Shi

