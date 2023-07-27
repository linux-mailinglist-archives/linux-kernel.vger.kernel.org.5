Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB6B76437C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjG0BoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjG0Bn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:43:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23BE61;
        Wed, 26 Jul 2023 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hp6cp7A51G4iktXiOcxoO4u7miw3X4y4lxN8UCoOFWg=; b=pm49HYnGqpGvPGwRRyIdGfVUc2
        TFYKuzsKW2So1LPZo3brH+GTA99n8QIX5QZYOJLgYu/V24erEs15gpmatnxht7iZItH9owzL7eo93
        h2hKM/IvPr5qdke5XTWavQebJhczW5N/TWUItH7co+Iy3lHHgLJXTQlUnrsVcbPlwkUpHL4h3aIl9
        HWRd8YHH8vvLj/OBR9gNlHF+P/VR69zsB7c7ZV0qhhPj/D9mwq4HUxYDF9HkBeABgR/s+EdzotJZ/
        RgsCAPEw0uKdqMJEnevaxO3y+xhvUzL4hNgzSiJLfp22HiAJZjXxARy+gM9SiabRDj/8K3Cq4Zks2
        rnjpX+3w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOq2j-00BszC-25;
        Thu, 27 Jul 2023 01:43:53 +0000
Message-ID: <d811b6c7-fe01-4f9c-be14-31defce4d864@infradead.org>
Date:   Wed, 26 Jul 2023 18:43:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] dma-buf/sync_file: Fix missing colon in kernel-doc for
 num_fences
Content-Language: en-US
To:     David Reaver <me@davidreaver.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Clark <robdclark@gmail.com>
Cc:     linux-doc@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230727011944.327807-1-me@davidreaver.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230727011944.327807-1-me@davidreaver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/26/23 18:19, David Reaver wrote:
> The struct sync_fence_info member num_fences was missing a colon in the
> kernel-doc, causing this warning when running make htmldocs:
> 
> ./include/uapi/linux/sync_file.h:77: warning: Function parameter or member 'num_fences' not described in 'sync_file_info'
> 
> num_fences was also clearly missing from
> https://docs.kernel.org/driver-api/dma-buf.html#c.sync_file_info before
> this patch.
> 
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>  include/uapi/linux/sync_file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
> index 7e42a5b7558b..b389a5495181 100644
> --- a/include/uapi/linux/sync_file.h
> +++ b/include/uapi/linux/sync_file.h
> @@ -56,7 +56,7 @@ struct sync_fence_info {
>   * @name:	name of fence
>   * @status:	status of fence. 1: signaled 0:active <0:error
>   * @flags:	sync_file_info flags
> - * @num_fences	number of fences in the sync_file
> + * @num_fences: number of fences in the sync_file
>   * @pad:	padding for 64-bit alignment, should always be zero
>   * @sync_fence_info: pointer to array of struct &sync_fence_info with all
>   *		 fences in the sync_file


Same as https://lore.kernel.org/all/20230330142720.882045-1-robdclark@gmail.com/

Hopefully someone will merge/apply that one. Rob, can you make that happen?

thanks.
-- 
~Randy
