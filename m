Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF02809D69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573321AbjLHHog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573311AbjLHHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:44:34 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A9171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:44:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vy2OseO_1702021475;
Received: from 30.25.236.68(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vy2OseO_1702021475)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 15:44:37 +0800
Message-ID: <8bdc5203-2356-4a7a-8f26-39fa4b2e2a46@linux.alibaba.com>
Date:   Fri, 8 Dec 2023 15:44:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] erofs: refine z_erofs_transform_plain() for sub-page
 block support
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
 <20231206091057.87027-5-hsiangkao@linux.alibaba.com>
 <20231208132031.00003b8d.zbestahu@gmail.com>
 <9ced71c9-4460-4907-abb9-21b517a883c7@linux.alibaba.com>
In-Reply-To: <9ced71c9-4460-4907-abb9-21b517a883c7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/8 15:34, Gao Xiang wrote:
> 
> 

...

>> min_t(unsigned int, ,)?
>>
>> ../include/linux/minmax.h:21:28: error: comparison of distinct pointer types lacks a cast [-Werror]
>>    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> 
> What compiler version are you using? I didn't find any error
> and
> https://lore.kernel.org/linux-erofs/202312080122.iCCXzSuE-lkp@intel.com
> 
> also didn't report this.

Did you test against the latest kernel codebase?

> 
> Thanks,
> Gao Xiang
