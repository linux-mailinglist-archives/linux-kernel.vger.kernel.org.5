Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF87D8DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJ0ElR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0ElP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:41:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE491;
        Thu, 26 Oct 2023 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=YwYy7CIo5U+Zesb2DBIodGQ6exTjv4uv07unmWGw3G8=; b=aYSJEZKkG2j1gSs+mQHgcZN2+B
        8KLhzoHx8c0kCcIOcXeJOjzGV4oKauluJkZgstSEwJ5oBxCmSk8emkkXM2iB/HCC5hMBWHBRkpcAO
        WHaqzPAc6O5b6V1BBzF2Dfi2MlNH4CPjVBZWk0f4dZ47dmeJ/aKr6hl6kSt+VOx0gYw+eZ/Fk87rW
        fI5euSWj5goVlP14kDhxkRJtyuNlhncyP5bnqCldBKzIZc3g/RQFal7IGSBjb8tUtsL6CBdmt293m
        CedST09CTLOFg0kfk85A3bqv1dDBRfJE4Mz5aT+qw79P5vFeg6J033ZJE5/zFlI7btgtBc2V9Qwbz
        mPIw9xBA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qwEei-00Fa9L-1t;
        Fri, 27 Oct 2023 04:41:10 +0000
Message-ID: <4257cc2a-c116-4a5a-8c4e-422e67258525@infradead.org>
Date:   Thu, 26 Oct 2023 21:41:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: admin-guide: Update bootloader and installation
 instructions
Content-Language: en-US
To:     Hunter Chasens <hunter.chasens18@ncf.edu>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231027041023.16681-1-hunter.chasens18@ncf.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231027041023.16681-1-hunter.chasens18@ncf.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/23 21:10, Hunter Chasens wrote:
> Updates the bootloader and installation instructions in admin-guide/README.rst
> to align with modern practices.
> 
> Details of Changes:
> 
>  - Added guidance on using EFISTUB for UEFI/EFI systems.
>  - Noted that LILO is no longer in active development and provides
>    alternatives.
>  - Kept LILO instructions but marked as Legacy LILO Instructions.
>    Suggest removal in future patch.
> 
> Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
> ---
>  Documentation/admin-guide/README.rst | 71 ++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
> index 9a969c0157f1..fba66f909f98 100644
> --- a/Documentation/admin-guide/README.rst
> +++ b/Documentation/admin-guide/README.rst
> @@ -252,7 +252,7 @@ Configuring the kernel
>      - The "kernel hacking" configuration details usually result in a
>        bigger or slower kernel (or both), and can even make the kernel
>        less stable by configuring some routines to actively try to
> -      break bad code to find kernel problems (kmalloc()).  Thus you

I don't see a problem with the above notation.

> +      break bad code to find kernel problems (kmalloc()().  Thus you

This way has unmatched parens.

>        should probably answer 'n' to the questions for "development",
>        "experimental", or "debugging" features.
>  


-- 
~Randy
