Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926D076FBDC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjHDIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbjHDIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:23:01 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769DFAC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:23:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHJXk3LFLztRsM;
        Fri,  4 Aug 2023 16:19:34 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 16:22:57 +0800
Subject: Re: [PATCH] mm: no need to export mm_kobj
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <2023080436-algebra-cabana-417d@gregkh>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dbcc4b24-050d-d08b-772d-a24ffbf38dc1@huawei.com>
Date:   Fri, 4 Aug 2023 16:22:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2023080436-algebra-cabana-417d@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/4 14:43, Greg Kroah-Hartman wrote:
> There are no modules using mm_kobj, so do not export it.

Yes, there's only in-kernel user left.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.

> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/mm_init.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a1963c3322af..1c9d6f428906 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -154,7 +154,6 @@ early_param("mminit_loglevel", set_mminit_loglevel);
>  #endif /* CONFIG_DEBUG_MEMORY_INIT */
>  
>  struct kobject *mm_kobj;
> -EXPORT_SYMBOL_GPL(mm_kobj);
>  
>  #ifdef CONFIG_SMP
>  s32 vm_committed_as_batch = 32;
> 

