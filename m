Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A279BAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358941AbjIKWOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbjIKL02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:26:28 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7CFF5;
        Mon, 11 Sep 2023 04:26:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rkktc1bvGz4f3kG1;
        Mon, 11 Sep 2023 19:26:16 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
        by APP4 (Coremail) with SMTP id gCh0CgDHXd1W+f5klhzLAA--.27685S3;
        Mon, 11 Sep 2023 19:26:18 +0800 (CST)
Message-ID: <1cf7abfa-df99-38af-021f-fcaeea8f6ee1@huaweicloud.com>
Date:   Mon, 11 Sep 2023 19:26:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] ata: libata-eh: Honor all EH scheduling requests
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>, luojian <luojian5@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "htejun@gmail.com" <htejun@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <20230906084212.1016634-1-linan666@huaweicloud.com>
 <202309071557.3a90e7a8-oliver.sang@intel.com> <ZPo6fXqTbmwDyopr@x1-carbon>
From:   Li Nan <linan666@huaweicloud.com>
In-Reply-To: <ZPo6fXqTbmwDyopr@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHXd1W+f5klhzLAA--.27685S3
X-Coremail-Antispam: 1UD129KBjvdXoWrGF4DKF45Zr1rJF47WF43Awb_yoWxGFgE9w
        4v93srGw1DXr40ka12kFs3tryDGF98ZwnrCr1FqF12gr1DJr93Crs5Kr1rtryxJ34ruFZx
        WFy5ZrWDZr1DWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbaAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67
        AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3
        Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU1VOJ7UUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/8 5:02, Niklas Cassel 写道:
> On Thu, Sep 07, 2023 at 03:43:19PM +0800, kernel test robot wrote:

[snip]

> 
> It might be worth mentioning that the race window for the bug that the patch
> in $subject is fixing, should be much smaller after this patch is in:
> https://lore.kernel.org/linux-ide/20230907081710.4946-1-Chloe_Chen@asmedia.com.tw/
> 
> Li Nan, perhaps you could see if you can still reproduce your original
> problem with the patch from the ASMedia guys?
> 

Thanks for your suggestion. We have briefly tested this patch and it can
fix the original problem . More tests is underway.

-- 
Thanks,
Nan

