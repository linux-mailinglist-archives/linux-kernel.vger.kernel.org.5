Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2B752F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjGNCc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGNCcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:32:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F601BF2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=vnAYT/HuY3ixM7+2cTf3F2/ewTiIm1tWUzzZyDC5XHM=; b=Ai+11+74z+pTCpUL57Bl/gc3Bi
        ++l4VLNxyssSFQxcPoyVkE7kWuBGXyuiULHDMV0nnZs4srqLMjtZ7zQN9CGJTus0H0JEehMbJWJus
        AHdoDh5cVhZMKKFflztBkSWAjygvYwZ73gJXtREuK00mTE3Y0RGUM7pUMlxnWFfOxIqQxSWVGNwwh
        DiIZLPwmSL6YlOHRv5myUwq92OCpyGKYC7Iksk+3yKLxsJxrjqx6pW4Z8AY2GAO1gabON82R9pGi/
        LJsutyMfXuihkRWOth663d1zdsNati/OjvGeqQQNk4DHztSVQrceEGpCHouSYB1R0ZTFTFBc8Lzpo
        mzXOToBw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qK8bc-004ncU-1Y;
        Fri, 14 Jul 2023 02:32:28 +0000
Message-ID: <3b646c8d-4449-40d2-e43a-a3330c77eb29@infradead.org>
Date:   Thu, 13 Jul 2023 19:32:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2=5d_kernel=3a_resource=3a_Remove_unneces?=
 =?UTF-8?Q?sary_=e2=80=980=e2=80=99_values_from_err?=
Content-Language: en-US
To:     Li kunyu <kunyu@nfschina.com>, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230715182428.3348-1-kunyu@nfschina.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230715182428.3348-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/23 11:24, Li kunyu wrote:
> err is assigned first, so it does not need to initialize the assignment.
> Modify __find_resource execution syntax to make it more in line with
> commonly used styles.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  v2:
>    Modify __find_resource Execution Syntax.
> 
>  kernel/resource.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index b1763b2fd7ef..ee79e8f4f422 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -656,13 +656,14 @@ static int reallocate_resource(struct resource *root, struct resource *old,
>  			       resource_size_t newsize,
>  			       struct resource_constraint *constraint)
>  {
> -	int err=0;
> +	int err;
>  	struct resource new = *old;
>  	struct resource *conflict;
>  
>  	write_lock(&resource_lock);
>  
> -	if ((err = __find_resource(root, old, &new, newsize, constraint)))
> +	err = __find_resource(root, old, &new, newsize, constraint);
> +	if (err)
>  		goto out;
>  
>  	if (resource_contains(&new, old)) {

-- 
~Randy
