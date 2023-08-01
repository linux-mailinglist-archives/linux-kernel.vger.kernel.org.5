Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0832C76A695
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjHABwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHABwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:52:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB4199D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1RwJsJmR65gKcYjxTa6NXFcs4smX4YLaL+2O/q9ZOjk=; b=rFTeCvt2kPHLSMb9IVXxIqDAEt
        hwRkOu1e0hIi/tjQW9kUrhlXFIy0n123kMkgfSsqnSHZtqtjktCOjI4CXvhzgDfRQl7YFkspeyXtb
        uqE29SR49l9v1HkjhMKXiWBMGTWwkJIIZsPtWX4uewdlq6zJS7epggjbDIMfqbeycG2D9CB/qsJrc
        ovqIAAt2sihX8xeTdyf9P+WajfYKa1ru1FVAmzh91DsKdo/18umCH2MYH3IvKODfKzfophLH3CdIa
        bV3Hm7zbR0eZlF3JjjhKwLBopXEQ+R6QOTkPvDE0/3ZHdw43NS8lslilSF9lboaXdNqfWMtcYpYwa
        DYqLpxEw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQeZ0-000AB2-1S;
        Tue, 01 Aug 2023 01:52:42 +0000
Message-ID: <45d450dc-356b-e984-eff5-9f4c698e7ffe@infradead.org>
Date:   Mon, 31 Jul 2023 18:52:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_user=5fnamespace=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYTlVMTOKAmSB2YWx1ZXMgZnJvbSBtYXBfd3JpdGU=?=
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, paul@paul-moore.com,
        brauner@kernel.org, fred@cloudflare.com, kpsingh@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230801184512.2892-1-zeming@nfschina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230801184512.2892-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 11:45, Li zeming wrote:

^^^^^^^^^^^^^^^

Please fix your system's date/time.

> kbuf is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/user_namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 1d8e47bed3f1..6fabf388bb8a 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -928,7 +928,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
>  	struct uid_gid_map new_map;
>  	unsigned idx;
>  	struct uid_gid_extent extent;
> -	char *kbuf = NULL, *pos, *next_line;
> +	char *kbuf, *pos, *next_line;
>  	ssize_t ret;
>  
>  	/* Only allow < page size writes at the beginning of the file */

-- 
~Randy
