Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7076C275
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjHBBsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjHBBr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:47:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A13F1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0CUaD88ixdQlKKg3c3lyTBnIp7cf8tS4gItoh+RXFxk=; b=pU/Iu5vO32up1nvIi6eVLX5UMX
        tNHo+fsvkXmyNMV5uyWWB03Vk/ZdOhnMJfmiGZfAvG4uE5OmYhgRQuw/absf+jeIxSKeVMTFm0vfR
        aQusR+aTK8zUrD2JqAgAFjTKg72aFUnoRPChIl1P0PedyskAAks1W347Fahqn+jmJq6mDRjPwxg8H
        8zFydT0Z2WHYo1MbsP8eHx9OnBfmtPXXtQVoYquH9M/iOqU/r7gKRtNCeXU9gk/MufUJjcvfhSFB2
        Cf4bmH09+A+z+TafnyV/nNPZi+16jls8kqjHC3XgJd1Y4zGBO2tnpSVATAa7ZKsnera1lZbBVyK4Y
        bbT0bCXg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qR0xt-003jDJ-27;
        Wed, 02 Aug 2023 01:47:53 +0000
Message-ID: <b77460b7-b126-a3a3-d1fd-d26c57c6fcba@infradead.org>
Date:   Tue, 1 Aug 2023 18:47:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] drm/tests: Fix one kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230802004630.74104-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230802004630.74104-1-yang.lee@linux.alibaba.com>
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



On 8/1/23 17:46, Yang Li wrote:
> Make @drm_kunit_helper_context_alloc to
> @drm_kunit_helper_acquire_ctx_alloc, to silence the warning:
> 
> drivers/gpu/drm/tests/drm_kunit_helpers.c:172: warning: expecting prototype for drm_kunit_helper_context_alloc(). Prototype was for drm_kunit_helper_acquire_ctx_alloc() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6073
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 3d624ff2f651..c1dfbfcaa000 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -156,7 +156,7 @@ static void action_drm_release_context(void *ptr)
>  }
>  
>  /**
> - * drm_kunit_helper_context_alloc - Allocates an acquire context
> + * drm_kunit_helper_acquire_ctx_alloc - Allocates an acquire context
>   * @test: The test context object
>   *
>   * Allocates and initializes a modeset acquire context.

-- 
~Randy
