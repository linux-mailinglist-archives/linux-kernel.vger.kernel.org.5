Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F7E813668
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443513AbjLNQhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjLNQhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:37:09 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680AD11B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:37:15 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6d26eef7438so208009b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702571835; x=1703176635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ytGugjo0G0b+BPvqCI62+RFEO79iMDy6vjEWkwFFqNo=;
        b=GCJi+iSKpjqkkNglOX7WPB7/8KITsstZp0kPuEDUMvK0hDP8P5OlgM3DvnT1kZ+Ht3
         qD4TydnzFsFH4nERqqpXyGSovEHKbC72lFZVKreji5eX4kcfOz5hXq9m14gDXYNVVeji
         /lRcyO7zCIbtqFnCH78mjwSjhqOdfo3BNPNoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571835; x=1703176635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytGugjo0G0b+BPvqCI62+RFEO79iMDy6vjEWkwFFqNo=;
        b=aBfyOqlV/ZlCULv2Jy5AFBgJBrj1LOD8AQf1LY7+2HVASMF5OApC4Yzg5cS5c/zdky
         OXi2YCYxQFjp7Lorc+meuiwXmxFx9gp8oxgPP8XHqxWB/5Ug7W4JZ1BWxstgVVWIPEcW
         bxX8LwaRRYnfxpaT8NBl9gXNuHNCr8pJl3cFlNb+udPE0xYE4xkBnMrnTQrMBgKWq6UN
         R1Sc36NZk84dSsl1NMJ5K0/BtY1ZMtaKDdFiSC5c4LZEqSYz1WPUxCnNxXx2xROyMYe6
         /66+5mf8PMXlE99pojBKPyfaP6iU1zm2UYrPOc+basgFX3s0rEO8zd43CebawshFjL1F
         suzg==
X-Gm-Message-State: AOJu0YyflhtZcnPELqc+Qf5oRDzn26q1vn+QpyP74l4IuuHg5tN4kkvv
        AkyqVE58XpzUfnGkK8rJIsk6Iw==
X-Google-Smtp-Source: AGHT+IHCcgxq6RgAT4BqOXPUetDHHLYdNS0fny6BFi7+klsE9cZ2F0ubu4OKof7NjbKXCrj/xdfJ9g==
X-Received: by 2002:a05:6a00:2d9e:b0:6cd:fda4:b57c with SMTP id fb30-20020a056a002d9e00b006cdfda4b57cmr12902654pfb.15.1702571834799;
        Thu, 14 Dec 2023 08:37:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b006cbb71186f7sm11945039pfb.29.2023.12.14.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:37:14 -0800 (PST)
Date:   Thu, 14 Dec 2023 08:37:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: Fix -Warray-bounds warnings
Message-ID: <202312140836.5AB528D54F@keescook>
References: <ZCTrutoN+9TiJM8u@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCTrutoN+9TiJM8u@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 07:54:02PM -0600, Gustavo A. R. Silva wrote:
> GCC-13 (and Clang) does not like having a partially allocated object,
> since it cannot reason about it for bounds checking.
> 
> Notice that the compiler is legitimately complaining about accessing
> an object (params, in this case) for which not enough memory was
> allocated.
> 
> The object is of size 20 bytes:
> 
> struct ec_params_vbnvcontext {
> 	uint32_t                   op;                   /*     0     4 */
> 	uint8_t                    block[16];            /*     4    16 */
> 
> 	/* size: 20, cachelines: 1, members: 2 */
> 	/* last cacheline: 20 bytes */
> };
> 
> but only 16 bytes are allocated:
> 
> sizeof(struct ec_response_vbnvcontext) == 16
> 
> In this case, as only enough space for the op field is allocated,
> we can use an object of type uint32_t instead of a whole
> struct ec_params_vbnvcontext (for which not enough memory is
> allocated).
> 
> Fix the following warning seen under GCC 13:
> drivers/platform/chrome/cros_ec_vbc.c: In function ‘vboot_context_read’:
> drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript ‘struct ec_params_vbnvcontext[1]’ is partly outside array bounds of ‘unsigned char[36]’ [-Warray-bounds=]
>    36 |         params->op = EC_VBNV_CONTEXT_OP_READ;
>       |               ^~
> In file included from drivers/platform/chrome/cros_ec_vbc.c:12:
> In function ‘kmalloc’,
>     inlined from ‘vboot_context_read’ at drivers/platform/chrome/cros_ec_vbc.c:30:8:
> ./include/linux/slab.h:580:24: note: at offset 20 into object of size 36 allocated by ‘kmalloc_trace’
>   580 |                 return kmalloc_trace(
>       |                        ^~~~~~~~~~~~~~
>   581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   582 |                                 flags, size);
>       |                                 ~~~~~~~~~~~~
> 
> Link: https://github.com/KSPP/linux/issues/278
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

FWIW, I think this is the right change that disrupts the code the least.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
