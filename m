Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AFA78692A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjHXH7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbjHXH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:59:19 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1321732
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:59:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401187f8071so3312685e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692863953; x=1693468753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TRrvqQ3IZLAdSlE7q0JdmLktMWfLBLUB6iMUFk1H1B0=;
        b=b7awhB3JxPGC1U2utUaUWUoMqd5Gi2fgvsWc4MTD3rdnH9vz9kK4Y8SYb9N2esmkbs
         ms9rCQ+i7pXPHElIaDYezbALOQAC8QgeP3bzI68a/2XUQ8P+QQhBDt+SD2nfoQCdF9bE
         lQz+6bUOgaN85hdZE1ZEHKRI9E5+RaRTVEouHJ9NYWZbhmSysTvUQZy6r7J/wk3RBcvO
         VYI+kBWkxgLzkkbgfTVyQ8bFbHCFFzo9qnmYU0uu+sBHAj1shWZuNqX3CXNuvASBKn3z
         cWuq7X+rJ6euOw8AFyoWHoh0TKPo5k8GIDUa8AztLaAyqikRC4nFXeK+wF7AiBUgHczr
         o5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692863953; x=1693468753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TRrvqQ3IZLAdSlE7q0JdmLktMWfLBLUB6iMUFk1H1B0=;
        b=d87r0yu1fEiDpCXI6Pcnv+/kq7MxkBHRUtjeEwJDAYl4oACg0amQKA3y7lSq+VPQV2
         jeOB3pQzNiB/L71TWSfUHx5FxzAr3x+wKhNT8I4N/S4HyPe+nmxX6/yVU7NvqKa0Aj7s
         3DyAY+LHT+I4j24Z5Ot3u0MjW2BuSOgPuUm/ThEYJ6W0E/gkILSEh2sD+12DfehOYt3w
         5M6XjeKH+ohFzRbW0igPas86uHYKRCPHheRnV0UdGCHIIe+zRLZeOxKT7vcfCtr16Js1
         7SVDGUC+nz6OCM1EmaHkERZg4QLIjz6Rd6ld9wlxTs1TpKX/8OfevHlavXuzH8aNW5QM
         jXuA==
X-Gm-Message-State: AOJu0Yy9HSyijfp0jGgnDf105gPtMopusfyms5m0wTrODWxQiLSth5ip
        N84ShpVRQV/qOM24QPit0CwSkg==
X-Google-Smtp-Source: AGHT+IHpWEv8c9m4s79ebXxyWhXfYXtwG0Bdy7u8GYkIalo4ANdcTW+fEYNeCRHcVdjsYx6LUQi2nw==
X-Received: by 2002:a05:600c:210e:b0:3ff:516b:5c4c with SMTP id u14-20020a05600c210e00b003ff516b5c4cmr3495753wml.18.1692863953436;
        Thu, 24 Aug 2023 00:59:13 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.239])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c029500b003fe1a96845bsm1834769wmk.2.2023.08.24.00.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:59:13 -0700 (PDT)
Message-ID: <94b1a5eb-e49c-e19e-a16f-7453930d36ec@linaro.org>
Date:   Thu, 24 Aug 2023 08:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 03/41] mtd: spi-nor: xilinx: use SPI_NOR_ID() in
 S3AN_INFO()
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-3-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-3-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 08:09, Michael Walle wrote:
> In commit 59273180299a ("mtd: spi-nor: Create macros to define chip IDs
> and geometries") SPI_NOR_ID() were introduced, but it did only update
> the INFO() macro in core.h. Also use it in S3AN_INFO().
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi-nor/xilinx.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
> index 00d53eae5ee8..de5189c38432 100644
> --- a/drivers/mtd/spi-nor/xilinx.c
> +++ b/drivers/mtd/spi-nor/xilinx.c
> @@ -22,12 +22,7 @@
>  		   SPI_MEM_OP_DATA_IN(1, buf, 0))
>  
>  #define S3AN_INFO(_jedec_id, _n_sectors, _page_size)			\
> -		.id = {							\
> -			((_jedec_id) >> 16) & 0xff,			\
> -			((_jedec_id) >> 8) & 0xff,			\
> -			(_jedec_id) & 0xff				\
> -			},						\
> -		.id_len = 3,						\
> +		SPI_NOR_ID(_jedec_id, 0),				\
>  		.sector_size = (8 * (_page_size)),			\
>  		.n_sectors = (_n_sectors),				\
>  		.page_size = (_page_size),				\
> 
