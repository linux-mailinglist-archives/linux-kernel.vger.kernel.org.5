Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B5755923
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGQBpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQBo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:44:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF0FE51
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 18:44:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R44c63XhczVjcf;
        Mon, 17 Jul 2023 09:43:34 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:44:54 +0800
Subject: Re: [PATCH v1] mm/hwpoison: rename hwp_walk* to hwpoison_walk*
To:     Jiaqi Yan <jiaqiyan@google.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>
References: <20230713235553.4121855-1-jiaqiyan@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3e587e41-b363-338a-9034-838013051cb1@huawei.com>
Date:   Mon, 17 Jul 2023 09:44:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230713235553.4121855-1-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/14 7:55, Jiaqi Yan wrote:
> In the discussion of "Improve hugetlbfs read on HWPOISON hugepages",
> Matthew Wilcox suggests hwp is a bad abbreviation of hwpoison, as hwp
> is already used as "an acronym by acpi, intel_pstate, some clock
> drivers, an ethernet driver, and a scsi driver"[1].
> 
> So rename hwp_walk and hwp_walk_ops to hwpoison_walk and
> hwpoison_walk_ops respectively.
> 
> raw_hwp_(page|list), *_raw_hwp, and raw_hwp_unreliable flag are other
> major appearances of "hwp". However, given the "raw" hint in the name,
> it is easy to differentiate them from other "hwp" acronyms. Since
> renaming them is not as straightforward as renaming hwp_walk*, they
> are not covered by this commit.
> 
> [1] https://lore.kernel.org/lkml/20230707201904.953262-5-jiaqiyan@google.com/T/#me6fecb8ce1ad4d5769199c9e162a44bc88f7bdec
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

