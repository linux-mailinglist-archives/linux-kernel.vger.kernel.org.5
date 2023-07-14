Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B07534A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGNII3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjGNIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F35270
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58AB61C50
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0B9C433C7;
        Fri, 14 Jul 2023 08:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689321946;
        bh=oytKwMj95473zu5Ab+t1wCWp1rgXlx7Cj+HneDgfVw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwnDIlQSZYD/Dn12tbw4y63iG53MxqrrMLR0wTS5/iDR0LH02TtgynD9V6ErsNFR+
         g2pLgvualq83QpFvfw3Y6HNrbhY/Jl09x2n4xzK1bOAsEN3VVuRdHi9Kma5rYH7OTm
         2Zysyfw0nYRLSDdMup7LnFbZzU8LKyk3qEDFApT8bGFReRuh9u6mhLU0aZ4pnN3Ktz
         2pQV07kBQ/n2rwYc0BBOJcYq++VsCj33pUqqzA2yMGIqnnGnD1d5uw6nGTjtMoh4Tm
         dqF27qb4DQuxbGP6UoMW19NPNovVySDJ/s6TRdwDMRrSg+xr3Z2mFbISQm0+D/sGSH
         hLOh9yjd87gsg==
Date:   Fri, 14 Jul 2023 09:05:41 +0100
From:   Will Deacon <will@kernel.org>
To:     chenqingyun001@208suo.com
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64:#include <linux/cacheflush.h> instead of
 <asm/cacheflush.h>
Message-ID: <20230714080541.GA5117@willie-the-truck>
References: <tencent_6FFBC70CAC8F277E10997551331C8029D006@qq.com>
 <31be9696f7a019a700176a2549992bfd@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31be9696f7a019a700176a2549992bfd@208suo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 01:09:10PM +0800, chenqingyun001@208suo.com wrote:
> <linux/cacheflush.h> is a generic header file,
> while <asm/cacheflush.h> is an x86
> architecture-specific header file

wut?

Will

> Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
> ---
>  arch/arm64/lib/uaccess_flushcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/lib/uaccess_flushcache.c
> b/arch/arm64/lib/uaccess_flushcache.c
> index 7510d1a23124..cf8052f6e091 100644
> --- a/arch/arm64/lib/uaccess_flushcache.c
> +++ b/arch/arm64/lib/uaccess_flushcache.c
> @@ -5,7 +5,7 @@
> 
>  #include <linux/uaccess.h>
>  #include <asm/barrier.h>
> -#include <asm/cacheflush.h>
> +#include <linux/cacheflush.h>
> 
>  void memcpy_flushcache(void *dst, const void *src, size_t cnt)
>  {
