Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C52763238
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjGZJc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjGZJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:32:05 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715A1BE8;
        Wed, 26 Jul 2023 02:31:02 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9pXH4mt8z1GDFR;
        Wed, 26 Jul 2023 17:30:07 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 17:31:00 +0800
Message-ID: <43731b35-c076-6d01-ad83-764fb2e9a8f0@huawei.com>
Date:   Wed, 26 Jul 2023 17:30:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v8 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <guoren@kernel.org>, <heiko@sntech.de>,
        <bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
        <atishp@rivosinc.com>, <bhe@redhat.com>,
        <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230725214413.2488159-1-chenjiahao16@huawei.com>
 <20230725-judiciary-auction-ef50be622175@spud>
 <96245a6f-cff1-9f2a-1217-4109d9a19291@huawei.com>
 <20230726-affix-employed-319aada685e7@wendy>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <20230726-affix-employed-319aada685e7@wendy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/26 14:45, Conor Dooley wrote:
> On Wed, Jul 26, 2023 at 10:20:00AM +0800, chenjiahao (C) wrote:
>> On 2023/7/26 5:48, Conor Dooley wrote:
>>> Hey,
>>>
>>> Your $subject says -next, but the patch failed to apply to
>>> riscv/for-next. What was the base for this patchset?
>>>
>>> Thanks,
>>> Conor.
>> Hi,
>>
>> My patchset was tested on current linux-next HEAD
>> (commit ID: 1e25dd777248, tag: next-20230725) and
>> it seems all ok.
>> Could you try applying with the base above, or
>> is there any problem with that base?
> There's some difference between linux-next and riscv/for-next that
> prevents the patchwork automation from applying the patches.

Oh, I see. There is definitely a difference, since linux-next applied
a bugfix patch b690e266dae2 ("riscv: mm: fix truncation warning on RV32")
recently, whereas riscv/for-next didn't. I have worked on a wrong base
and thanks for reminding :)

I will rebase onto riscv/for-next and post my v9 pathset soon, please
check over there.

Thanks,
Jiahao

