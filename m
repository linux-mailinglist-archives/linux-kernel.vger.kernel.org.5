Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327D77AC423
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjIWRmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjIWRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:42:22 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F81A5;
        Sat, 23 Sep 2023 10:42:09 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id jq43qzx7eWU1ck6dtqUhMO; Sat, 23 Sep 2023 17:42:09 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k6dsqFkZIIDdmk6dsqEVCs; Sat, 23 Sep 2023 17:42:09 +0000
X-Authority-Analysis: v=2.4 cv=HcYH8wI8 c=1 sm=1 tr=0 ts=650f2371
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0rkBlmV7dOjQhBHsZ5GTBisbKAaQB5v8qd8FFYm1jjE=; b=gDzaf9mgGEPzjYwWt9k1zjunVm
        kiCe+R15b5ygw6mW8y8DI/nchsHnlOi0xRigLWG9oGd0KFCP8ir2WiRrQn5NboMn0nAM34Nd42LZ6
        x+sLRke2d85WZDZirtFoJwv1l7juJIkSTJ3YDR0sW80cSL6MuhK/mop5lNe/t9qmnq3m+4X3DYT+E
        mtTHzKIq6RwlQKypARoflwQ8shVmU2nFsMiJx9Xnfd/vHjrqhrvJQz6ZK9/hYHei0v1L7xiptgwry
        Zb7r76eQN4oDMZxD1kZo/QcTheXAi9fLif9ydnGNpHnq37lJdVJ7QPbAlYP72cehx1CpJUxRlh9bJ
        o+S6M/6g==;
Received: from [94.239.20.48] (port=52760 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy3g-003bRP-1r;
        Sat, 23 Sep 2023 03:32:12 -0500
Message-ID: <6dae12b4-125c-a7be-4129-75065f7a5128@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:33:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] video: fbdev: mmp: Annotate struct mmphw_ctrl with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175137.work.062-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175137.work.062-kees@kernel.org>
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
X-Exim-ID: 1qjy3g-003bRP-1r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:52760
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDA/7fhybGLm27idUlLz4PuTe0rBgfzesmVyPUXNIA2L4RMXX3pMqbXkIhR3HkWaOWrAOOzEM/jkYXvBUi87smvR00RiJM9WlxDFRGI4QW0s7RUPeAEk
 cm/rruSa1aFyxOuDCnepYUtDIERLHoHcIurLJsSUZ1mWAbGEx1vj+buvZ4Bsnt0hSqmjNtUMsbVQ2ValLyBJ+31TOdsXww8Djo6l9Aakwdhd/JrcBuPqBDdL
 1/rGR5WQHZDpwbS1n9Mu0Do4/VK2LCk2mNEPdWxLG6zfR5jk77rTMRUTk0FgsRRpNPtccV10WIOYjewtuSGvkQ==
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
> As found with Coccinelle[1], add __counted_by for struct mmphw_ctrl.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/video/fbdev/mmp/hw/mmp_ctrl.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> index 167585a889d3..719b99a9bc77 100644
> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> @@ -1406,7 +1406,7 @@ struct mmphw_ctrl {
>   
>   	/*pathes*/
>   	int path_num;
> -	struct mmphw_path_plat path_plats[];
> +	struct mmphw_path_plat path_plats[] __counted_by(path_num);
>   };
>   
>   static inline int overlay_is_vid(struct mmp_overlay *overlay)
