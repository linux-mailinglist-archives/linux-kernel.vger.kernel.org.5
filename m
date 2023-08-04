Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC976FBAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjHDIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjHDIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE34683
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC75D61F5A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EFDC433C7;
        Fri,  4 Aug 2023 08:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691136617;
        bh=P+s8fSt/Ff2lz1Wzj3aOiie8gbC1BY8gsYF1MxQ6dAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJ+dLTesHhnNadayhgTtEJRIvHfYn0I9f7ZnnDc2oOVGXff8KbevoyXYGi8QM6Tld
         ek9KuEP7HMpKmbtjMTsssDHdszOoRp2hZ7sUQ15rAczXtSuKi1RaZUmwPY5smDOClp
         kQtM2fosQzQRRLyRT/X1Md7rSfMSFO3WbCJy/3wnWAqdsIpenQAAMEuqPBKmD83//l
         JSPByjiw2R4mUQu5ECwcJTrYdQewBGOMzR8XDec9NcmAS9kJyNUsKX7mV/5+5zn9mZ
         cq9xgOhl09UyO69BZvODa12eeLbX8QwcOr1oWMW0uWoeYmKpTxDh6dZNmy00DoNBXf
         DaM8mEeD5n4Mg==
Date:   Fri, 4 Aug 2023 11:09:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: no need to export mm_kobj
Message-ID: <20230804080930.GI2607694@kernel.org>
References: <2023080436-algebra-cabana-417d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080436-algebra-cabana-417d@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 08:43:37AM +0200, Greg Kroah-Hartman wrote:
> There are no modules using mm_kobj, so do not export it.
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.
