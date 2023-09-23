Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8E7AC426
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjIWRoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjIWRmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:42:24 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77FDE78;
        Sat, 23 Sep 2023 10:42:11 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTP
        id jnFfqzM8aWU1ck6duqUhMa; Sat, 23 Sep 2023 17:42:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k6duqYt1ssKmik6duqOQUx; Sat, 23 Sep 2023 17:42:10 +0000
X-Authority-Analysis: v=2.4 cv=JOMoDuGb c=1 sm=1 tr=0 ts=650f2372
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=QyXUC8HyAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=qjWHau5h7Oqj65Zv8QkA:9
 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l/Fa2g6PgtI/l80Yludonwd/RnBWl59lIxgeKs29bP4=; b=im+3DqFCWX2/Oi88WqFAOx2B0S
        AO+dk1KB0IMZ9RxhtSqGHgHIxe0LTwhGKSKxdLspoX7P1WmsfyE9Qy4mFwQKapgBcdMOdXpEvR/qo
        pfuBLeKnsaW60CLDi1pOlbhrkviaLDVRusBVU/eySxnVnTZoXc32HpnEGNyMY0q0Fz+1VhnZPfEvg
        AVUPdYOe7pmSe8EC4mmoMrzC7bJZb5vpw+E+oypqdEYjEKDsfO9G+/fTvhmYDibtVycjAo3S9HmKm
        p+T7QI9OXM0ALpGx6hKf5Oc2mpJqV3dgg5VxZrsZLVmbcG/nuqo8uoMRYYG+SAn2xpFc8lv3RfQ3g
        Gtq2dBxQ==;
Received: from [94.239.20.48] (port=36114 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy2g-003aI4-2i;
        Sat, 23 Sep 2023 03:31:11 -0500
Message-ID: <665343e3-d2d0-82bf-350c-20f935510ce7@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:32:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] virt: acrn: Annotate struct vm_memory_region_batch with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Fei Li <fei1.li@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175102.work.020-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175102.work.020-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjy2g-003aI4-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:36114
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMXcGdFyXwjqwrh3Kji2n+g/L5ix7e8CmYGw2WhlCL0SmE0vszJTakmZtt0P6WKHn9kzGLes7Fnznh0PIWLdtXVHZblnY1DKSaxhDK+Mb4pAH4LkNVof
 DDJFWDxq/fOO0wf8eA1DbHwnFEDaLa8Cxh4H/6lbcfpCadoC+EsHQ5H6YupkJhlVPqAt+ZvBYmKnoMRcW2ofyYuKrIggGlmz9B0vM8Epf2PyTbiFTkmRLcNH
 yLSyK6pwwmo5gYz5AjqrZJy5UUDJBF0KHaNJkoex8mI=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:51, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct vm_memory_region_batch.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Fei Li <fei1.li@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/virt/acrn/acrn_drv.h | 2 +-
>   drivers/virt/acrn/mm.c       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
> index 5663c17ad37c..fb8438094f6f 100644
> --- a/drivers/virt/acrn/acrn_drv.h
> +++ b/drivers/virt/acrn/acrn_drv.h
> @@ -60,7 +60,7 @@ struct vm_memory_region_batch {
>   	u16			   reserved[3];
>   	u32			   regions_num;
>   	u64			   regions_gpa;
> -	struct vm_memory_region_op regions_op[];
> +	struct vm_memory_region_op regions_op[] __counted_by(regions_num);
>   };
>   
>   /**
> diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
> index b4ad8d452e9a..fa5d9ca6be57 100644
> --- a/drivers/virt/acrn/mm.c
> +++ b/drivers/virt/acrn/mm.c
> @@ -250,11 +250,11 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
>   		ret = -ENOMEM;
>   		goto unmap_kernel_map;
>   	}
> +	regions_info->regions_num = nr_regions;
>   
>   	/* Fill each vm_memory_region_op */
>   	vm_region = regions_info->regions_op;
>   	regions_info->vmid = vm->vmid;
> -	regions_info->regions_num = nr_regions;
>   	regions_info->regions_gpa = virt_to_phys(vm_region);
>   	user_vm_pa = memmap->user_vm_pa;
>   	i = 0;
