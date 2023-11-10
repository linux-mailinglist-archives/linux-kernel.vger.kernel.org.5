Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135BF7E84E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKJVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjKJVCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:02:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F4C3AA6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 13:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ciYCEHiStEhiV9bzFF69iuJLlDU5uempC1NU0f76Ntc=; b=SbVTDBXEpdDKR34RZ9GglRImS0
        fR01/rYEiniFGMXNRyWd4qTa2uOkHW5nEr+OQ7XJ9veY5GfVFGr4mgELoHlIA8lugGGBwxxhJ9j/T
        k901DX4UztXnSemAzTFct9RFZIB0WT40JwmniThSmjUCO3hsTmJDtnLr/ZK8WXYG3z+p3HmKC+Cng
        rWq1/27zTCC1oayECyni8O0C9ObbJVE8Sefos4kmGvvwdWLLZY+o1cEjn2PH+SycvXbkrGdqeF4ZB
        W92sUrMC0VZbfciJaHZI8RcxBvXBfdPjP/l7x5p9eKiNMGq+1s5oSritU4VD5/C1EEgHa4/jRV8xV
        VfWm4yWA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r1Ydt-009RVi-0g;
        Fri, 10 Nov 2023 21:02:17 +0000
Message-ID: <abfb5b1c-45cf-4b37-bca3-75c6028cf3b0@infradead.org>
Date:   Fri, 10 Nov 2023 13:02:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm:hugetlb_cgroup: Optimize variable initialization
Content-Language: en-US
To:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Cc:     James.Bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <785e7f99-ccb9-4640-b554-825061f73ee1@infradead.org>
 <20231107211307.14279-1-zhaimingbing@cmss.chinamobile.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231107211307.14279-1-zhaimingbing@cmss.chinamobile.com>
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



On 11/7/23 13:13, zhaimingbing wrote:
> Initialize 'max' with 'unsigned long' instead of 'long'.
> 

There is no variable initialization here, so the $Subject
does not match what is being changed.

Also there is no description of Why this change is needed.

> Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> ---
>  mm/hugetlb_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index dedd2edb0..d4ca2ac55 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -685,7 +685,7 @@ static char *mem_fmt(char *buf, int size, unsigned long hsize)
>  static int __hugetlb_events_show(struct seq_file *seq, bool local)
>  {
>  	int idx;
> -	long max;
> +	unsigned long max;
>  	struct cftype *cft = seq_cft(seq);
>  	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
>  

-- 
~Randy
