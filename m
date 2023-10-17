Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F71C7CC87D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjJQQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjJQQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:13:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689CE101
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:13:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so896299766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697559213; x=1698164013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ocr30lr2y0V9zsCKJhUGQr9AXtBKIbrFwvST7PQfksE=;
        b=Pt2cHvsO/1oBbToYDW4aO8hTnkWqlL9aMHNH+VbnTwE9kuETn6hyWYRADEYs1c7WWV
         finkwglffO9HawJIjA203SBMrplmA5C/4F0YMsiPmdNeq4qsjRI125tkudSmhxy1xKLR
         J4OM//UiHpvq2Vpc2m/F0UQdptLOWHfn4AL0jzoLzcxUtOV+1LzjMYYgOjeXO6Q90A2f
         5Lh3bj7qqSaseFYMNbPFueCtnWfHSWqba3BQv6so10MJZEthQXfLU3SpSBsLB9MOcNAs
         HwReLJYDyg0Q3lSIKL1S4qCvCB1mV6+zTz98CEepCiVU+Pc0mzHQREQuZu8d3hx+/NXF
         fQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559213; x=1698164013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocr30lr2y0V9zsCKJhUGQr9AXtBKIbrFwvST7PQfksE=;
        b=KrbkIubEq4Ui/EEyoC0yTnldFZ+6NLaSIHQ7IYxgAeMpFtJlm4R3AYcT9mrSIfiTQI
         EbAWWyIpwPChMhFZpHrLDL7ryBdkXro1u7KXvJ9+UJCBgJPLL+ti1OEje5cjDYQojV4r
         8XJMCPLkxJ4IRG2u1VfVHFx9gkPAcHQlf6p9zL0POgSSWi6ht/Xu1vswiK6XPLJBbXOK
         TulI+TO+uAm2broEiEfMLP+/79CDGwm+4/KgLfQ8jjatFrXg7Csh2LVFM6FHVMqhNuR8
         Y+69fCX+Mkk8v3Vi4c/gPOueAZbHd9MeVSs9VwZQI1AL1sJWbZbGUz17sxuiHeauyMtM
         wnYA==
X-Gm-Message-State: AOJu0YzbsQdlzNCtUrFxGwioF1aFAKCjDG+f/18WnRo3oefIvEOcPAEr
        YMlAgZXDHc1xFBJLLE1JiXw=
X-Google-Smtp-Source: AGHT+IGODw23Lmd2iRtY12QUdiToBzSvkpXPO70t94AvsEAsozYbIEwH6uMm9DaBYT4+8zL3FtnVQw==
X-Received: by 2002:a17:907:6d0c:b0:9b8:e670:657b with SMTP id sa12-20020a1709076d0c00b009b8e670657bmr2044955ejc.64.1697559213113;
        Tue, 17 Oct 2023 09:13:33 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ox30-20020a170907101e00b009a1be9c29d7sm68306ejb.179.2023.10.17.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:13:32 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 17 Oct 2023 18:13:24 +0200
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buildid: reduce header file dependencies for module
Message-ID: <ZS6ypB/Jb+rOXqVK@krava>
References: <20231017143408.2876181-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017143408.2876181-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:33:58PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The vmlinux decompressor code intentionally has only a limited set of
> included header files, but this started running into a build failure
> because of the bitmap logic needing linux/errno.h:
> 
> In file included from include/linux/cpumask.h:12,
>                  from include/linux/mm_types_task.h:14,
>                  from include/linux/mm_types.h:5,
>                  from include/linux/buildid.h:5,
>                  from include/linux/module.h:14,
>                  from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
>                  from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
>                  from arch/arm/boot/compressed/decompress.c:60:
> include/linux/bitmap.h: In function 'bitmap_allocate_region':
> include/linux/bitmap.h:527:25: error: 'EBUSY' undeclared (first use in this function)
>   527 |                 return -EBUSY;
>       |                         ^~~~~
> include/linux/bitmap.h:527:25: note: each undeclared identifier is reported only once for each function it appears in
> include/linux/bitmap.h: In function 'bitmap_find_free_region':
> include/linux/bitmap.h:554:17: error: 'ENOMEM' undeclared (first use in this function)
>   554 |         return -ENOMEM;
>       |                 ^~~~~~
> 
> This is easily avoided by changing linux/buildid.h to no longer depend on
> linux/mm_types.h, a header that pulls in a huge number of indirect dependencies.
> 
> Fixes: b9c957f554442 ("bitmap: move bitmap_*_region() functions to bitmap.h")
> Fixes: bd7525dacd7e2 ("bpf: Move stack_map_get_build_id into lib")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/buildid.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 3b7a0ff4642fd..8a582d242f067 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -2,10 +2,11 @@
>  #ifndef _LINUX_BUILDID_H
>  #define _LINUX_BUILDID_H
>  
> -#include <linux/mm_types.h>
> +#include <linux/types.h>

looks good, but I think we should now include <linux/mm_types.h> in lib/buildid.c ?

thanks,
jirka

>  
>  #define BUILD_ID_SIZE_MAX 20
>  
> +struct vm_area_struct;
>  int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
>  		   __u32 *size);
>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
> -- 
> 2.39.2
> 
