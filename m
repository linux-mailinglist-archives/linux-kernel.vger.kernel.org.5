Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6F47BB606
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJFLLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjJFLLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:11:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C5CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:11:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c723f1c80fso15075465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696590710; x=1697195510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkZAhzcVv5l/GWGZH+CNEm4JuaJPR9RYctj/ltot25I=;
        b=XXfvVbIkMcgc+YXpdx0S58v4rH3fLYG/oblijirqG+O2ZES3Fz0J+awMIyypsoSa+y
         PMe062U4cSeUaB/lAInp/FpT4onFSZVaq8TVGGnvcYOOhNPRngBp0IRLR204z1NBdMLl
         3si9j9z40bgLT16iN+x3LSExjehtWFsaHO3uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590710; x=1697195510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkZAhzcVv5l/GWGZH+CNEm4JuaJPR9RYctj/ltot25I=;
        b=SEj0GWvXDNI+liMZzi4JH0dOKCVbMA7WARkt2OEf1/vuz5yhyJsOc0ftcVmP6S72k4
         Oeoy3CsbokGhkAZOeE1mBxazYhBGcoo1quS16YTth+oaG6J1e2KHm1Pem0s9zqM1V3xH
         J72itI/ckluB8MMoO9Cjfy8Dl15aFHRhWS6pZyJL1QEQXySKGmIGHyuAv4RcrEQPfVPs
         mi5zLCjc6lGS3Jl9YSyC8RcHKI9Q2UO4WIAEiSp8HkhjWUj4Mjac8sPmJTxX5zqAxLBT
         DsMGWVoO9M/Nj+40J7Jp2SOr0jDwEIlvfLV+aGiwzC7OhK0wa17ZXHcgQTq7SVSLHd0X
         FCkA==
X-Gm-Message-State: AOJu0YzEeqJDiH74pmuYSAe4gfjhnUHmYcMT+70b2N17HxD/lVg8nWBM
        eFIAmZfDIw1UrbqMmnqLsVU09A==
X-Google-Smtp-Source: AGHT+IEnw2wOEXtKPkvOMaGQ/meYjnZqcW/2/XkI4MuRt4Jv7xi0tOnWU9TYjbFIEraXRPgIHyXmng==
X-Received: by 2002:a17:903:24e:b0:1c0:d7a9:1c48 with SMTP id j14-20020a170903024e00b001c0d7a91c48mr9046916plh.49.1696590710250;
        Fri, 06 Oct 2023 04:11:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4afa:2f75:6a8f:b6ea])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001b9da8b4eb7sm3539523plc.35.2023.10.06.04.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:11:49 -0700 (PDT)
Date:   Fri, 6 Oct 2023 20:11:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yj.chiang@mediatek.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] zsmalloc: use copy_page for full page copy
Message-ID: <20231006111144.GB17924@google.com>
References: <20231006060245.7411-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006060245.7411-1-mark-pk.tsai@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/10/06 14:02), Mark-PK Tsai wrote:
> Some architectures have implemented optimized
> copy_page for full page copying, such as arm.
> 
> On my arm platform, use the copy_page helper
> for single page copying is about 10 percent faster
> than memcpy.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

TIL

I've never heard of arm's copy_page() before. Is it really much
faster than memcpy()?

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>


> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index c743ce7a5f49..b1c0dad7f4cf 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1839,7 +1839,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
>  	 * Here, any user cannot access all objects in the zspage so let's move.
>  	 */
>  	d_addr = kmap_atomic(newpage);
> -	memcpy(d_addr, s_addr, PAGE_SIZE);
> +	copy_page(d_addr, s_addr);

I guess you can also look into patching zram_drv.c, which seem to have
at least one PAGE_SIZE memcpy().
