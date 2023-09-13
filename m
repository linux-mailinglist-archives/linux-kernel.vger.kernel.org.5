Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1687279F552
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjIMXHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMXHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:07:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE51BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:07:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26D2C433C7;
        Wed, 13 Sep 2023 23:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694646424;
        bh=ff4Xglxtnbq7pMTBdXo/zVGkPU3zPuCRWBB6q8+lHzQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ro3uh6ilWqg62WQdB59QKFPdBxd9k5F9ZvjGq9dmM++9OsZJBn8IDIV/KSIzTNYWt
         jo0VWNH50+2+vTCvsrxad6rGpp+BDrZGVrr2XhLHpL4/5/D7NAd+vsypFnvV1KyOzQ
         /OPFMGnuApBQqNp/UNo2U1MloPOzrE/7smTfoQWaFP6m49jE35lust8QTw2wIvIgnr
         kTN3cVHzDRLzQwBPsMMBc3gTPAOaQ0e8wPtrGvRUzuWMgVBkXqoajEGd4CfZepBISJ
         PTzDDWYctZMwpG5vY7YXYw+QbHmMH1t7//Gwm03ZbWj2ES5HqFmebnOpdTwXVzqI0x
         /2JS6TWueCfbg==
Date:   Wed, 13 Sep 2023 16:07:01 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/3] arm/xen: remove lazy mode related definitions
In-Reply-To: <20230913113828.18421-2-jgross@suse.com>
Message-ID: <alpine.DEB.2.22.394.2309131606560.2295162@ubuntu-linux-20-04-desktop>
References: <20230913113828.18421-1-jgross@suse.com> <20230913113828.18421-2-jgross@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Juergen Gross wrote:
> include/xen/arm/hypervisor.h contains definitions related to paravirt
> lazy mode, which are used nowhere in the code.
> 
> All paravirt lazy mode related users are in x86 code, so remove the
> definitions on Arm side.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  include/xen/arm/hypervisor.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/include/xen/arm/hypervisor.h b/include/xen/arm/hypervisor.h
> index 43ef24dd030e..9995695204f5 100644
> --- a/include/xen/arm/hypervisor.h
> +++ b/include/xen/arm/hypervisor.h
> @@ -7,18 +7,6 @@
>  extern struct shared_info *HYPERVISOR_shared_info;
>  extern struct start_info *xen_start_info;
>  
> -/* Lazy mode for batching updates / context switch */
> -enum paravirt_lazy_mode {
> -	PARAVIRT_LAZY_NONE,
> -	PARAVIRT_LAZY_MMU,
> -	PARAVIRT_LAZY_CPU,
> -};
> -
> -static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
> -{
> -	return PARAVIRT_LAZY_NONE;
> -}
> -
>  #ifdef CONFIG_XEN
>  void __init xen_early_init(void);
>  #else
> -- 
> 2.35.3
> 
