Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2287E2E52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjKFUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjKFUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:40:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE6FD7B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dm4PKVH0zujNea/smzC8Gnr5hhMiZzhQN7hg9BVvXek=; b=RJWRGNf/5+ZaGvAOy+07MEhwXQ
        XbIIkWRd8X0C9IPsK/c4zDi0xTx2LIgzc1Pf//K2slbU/zK7WGa0GNUJ3Sy/4bBq96nMJ2E2Jvd+X
        ISLyDAGyLySUBnpdEWCS0ZB9KonAsOMiBEO5Hb9OmzeGL3RoL1OCxWAdRxTrvtwAPPvfOgFINzVi0
        D52o0laaMA+Tla6CyPksu1B6TXAk9w9beQACSyM4gshAbACeouDRVupRwCAwJfeWRXVjqCqvYywIU
        mPpXHW0N6QGsfMAyH9pbItvDCV86eQlaDV+8LlnC7xlkIT2sCbLIiPSjqxS9rk2RYX91gHuzTc9ZD
        EUxRUoKg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r06Oi-00HWGb-35;
        Mon, 06 Nov 2023 20:40:36 +0000
Message-ID: <785e7f99-ccb9-4640-b554-825061f73ee1@infradead.org>
Date:   Mon, 6 Nov 2023 12:40:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm:hugetlb_cgroup: Fix the wrong format specifier
Content-Language: en-US
To:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
        James.Bottomley@hansenpartnership.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231106082723.8728-1-zhaimingbing@cmss.chinamobile.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231106082723.8728-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/23 00:27, zhaimingbing wrote:
> The long type should use "%ld" instead of "%lu".
> 
> Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  mm/hugetlb_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index dedd2edb0..3c132795c 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -696,7 +696,7 @@ static int __hugetlb_events_show(struct seq_file *seq, bool local)
>  	else
>  		max = atomic_long_read(&h_cg->events[idx][HUGETLB_MAX]);
>  
> -	seq_printf(seq, "max %lu\n", max);
> +	seq_printf(seq, "max %ld\n", max);
>  
>  	return 0;
>  }

-- 
~Randy
