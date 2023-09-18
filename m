Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2467A4E97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjIRQTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjIRQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:19:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB43C16
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:01:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4DAC43397;
        Mon, 18 Sep 2023 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695052609;
        bh=VvMIAd0IbbqotUUOoCyPiPmt1MLsOviC0xJ4TYimsAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lzo4Z7su2CfaS68/lpoY6RgABqbMAipJoBMeCXxsdgub4CuJNP8dgiIjNmDtPjQ+v
         mHzEu/rxlr2fy3HhUjcScKhLz5otvFbUZXavt6K3198YDq9TL7IyU/zKowjWgw5ogE
         YTVh7jZfmGeL+FqmHd62lW82HE6nq0mtze3Flk1rNcIG8DfhOqofS9Cn66zn3gZ4Ei
         LxR9Hbn/hOZnFc4tn5V1dE+aQxp7PHel6BRu7hzGWQGCI2VUGUTjgWJOHqxk2JZ2oY
         VjWXwmiBrQuktaQRzkgA76oIOzMc7t581ZKq3vMUvn86JPPfEN4I2+LlNR4PHtOAMp
         zMla6GlL3L39A==
Date:   Mon, 18 Sep 2023 18:56:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, fam.zheng@bytedance.com,
        liangma@liangbit.com, punit.agrawal@bytedance.com
Subject: Re: [PATCH] memblock: add missing argument definition
Message-ID: <20230918155607.GD3303@kernel.org>
References: <20230918090657.220463-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918090657.220463-1-usama.arif@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:06:57AM +0100, Usama Arif wrote:
> Description of argument memblock_type was missing in the commit
> that introduced it.
> 
> Fixes: 70083e1c8ab4 ("memblock: pass memblock_type to memblock_setclr_flag")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

Andrew, the commit being fixed is in mm-unstable, can you please pick it
up?

> ---
>  mm/memblock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 8f7a0cb668d4..fd492e5bbdbc 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -892,6 +892,7 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
>  
>  /**
>   * memblock_setclr_flag - set or clear flag for a memory region
> + * @type: memblock type to set/clear flag for
>   * @base: base address of the region
>   * @size: size of the region
>   * @set: set or clear the flag
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
