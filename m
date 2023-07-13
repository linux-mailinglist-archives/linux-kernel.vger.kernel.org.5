Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481E9751FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjGMLVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjGMLVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:21:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D5AD198A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:21:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D66EA1576;
        Thu, 13 Jul 2023 04:22:00 -0700 (PDT)
Received: from [10.163.49.144] (unknown [10.163.49.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97EF53F740;
        Thu, 13 Jul 2023 04:21:16 -0700 (PDT)
Message-ID: <14549550-d8d1-612b-fc6a-4b1145784cf5@arm.com>
Date:   Thu, 13 Jul 2023 16:51:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/mm_init.c: mark check_for_memory() as __init
Content-Language: en-US
To:     Haifeng Xu <haifeng.xu@shopee.com>, rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230710093750.1294-1-haifeng.xu@shopee.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230710093750.1294-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 15:07, Haifeng Xu wrote:
> The only caller of check_for_memory() is free_area_init(), which
> is annotated with __init, so it should be safe to also mark the
> former as __init.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a1963c3322af..a313d1828a6c 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1737,7 +1737,7 @@ static void __init free_area_init_node(int nid)
>  }
>  
>  /* Any regular or high memory on that node ? */
> -static void check_for_memory(pg_data_t *pgdat)
> +static void __init check_for_memory(pg_data_t *pgdat)
>  {
>  	enum zone_type zone_type;
>  
