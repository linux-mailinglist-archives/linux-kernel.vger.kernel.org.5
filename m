Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3FA773DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjHHQVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjHHQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:19:36 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57DA9011
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:48:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso93554281fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691509736; x=1692114536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0zLEburh9ZFfE548pNOj7q2UOj2GGR4k/WQno4jj70=;
        b=jdvJRDwKm2gcnBDRl4o5xnvg3QUYH+E4SgORVNfOBD2j77DIz7H9HwmE+MxErQRoPD
         oA+pe67shBFRawNfMu78CxLeS/sNa5P1T1TapiY0EzuaWCr6LQ2CZo3xxtbHfGiFqXMJ
         PlK6BmCJicukU4c9sb7vysJZgXk3a9hl5zCLPH4zK4Izxtdetu4q6EuKQtVhtJNEfLMk
         qW8CnorK6KRk5fzVq758jsVWLwCWQhiNI0vOGJSh38zdE4cVfLRVedm0uCJLvCjLWoZl
         WJbjrGgP7rPKjjcnBeD3B9QelLW7+lUII1uGxvV5ARh6cXt8sp0E8mOLuNsgkxYm23hF
         Ornw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509736; x=1692114536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0zLEburh9ZFfE548pNOj7q2UOj2GGR4k/WQno4jj70=;
        b=RZwHxhHaeGLoDNKwaG3ZIcNC7GFG+miimu5x3NFxhFTVBMAEoGHOt97KTvFVtBu/Yh
         warwftWDRl3W72RSiQ9sUbgSTXEZ3JhxMoyypwhmI90S1B0E4k9S/NYS44AbSLT5GX33
         C11uxT6Ehoz1ZziDZDh1FrAtP6+NpX3zxEKyzjhN7VzvFqMmFRVbKySY+3OKMdSi67wd
         upz0chhAaIF8UMKmdVxhhCBXofnm9BiJHR9XbxrNrGIxXAJ2QQxhrmuBBkj/mwbk8U+y
         YHVNSo5u2zTkUw3tTUx5I0T/7Wp1HdazIULN9ArqltJZZoVahghLEbnTScpaOcjFnfg4
         C9kw==
X-Gm-Message-State: AOJu0Yyh/cRAePCiqb/rwBMlcujZbMEpZrCukSc5SWpfQOQY8juntyIK
        kH0MxnZvbYB/eUhJ7r4H3oeWpUfHrdOvQoR4qf4=
X-Google-Smtp-Source: AGHT+IENaoLogdmwEquxviK7pRALZnOeydEhILSaohDlqrXatiaCu5M9MfM3jQOl2xSE+z2HLZbssA==
X-Received: by 2002:a05:600c:2213:b0:3fe:2b76:3d7 with SMTP id z19-20020a05600c221300b003fe2b7603d7mr9376833wml.10.1691487533357;
        Tue, 08 Aug 2023 02:38:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.177.253])
        by smtp.gmail.com with ESMTPSA id e13-20020a05600c218d00b003fe2bea77ccsm13219267wme.5.2023.08.08.02.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:38:53 -0700 (PDT)
Message-ID: <60ac32e8-5fea-84d4-ff3f-f09e6f8ad499@linaro.org>
Date:   Tue, 8 Aug 2023 11:38:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] mips: replace #include <asm/export.h> with #include
 <linux/export.h>
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230807153243.996262-1-masahiroy@kernel.org>
 <20230807153243.996262-2-masahiroy@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230807153243.996262-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/23 17:32, Masahiro Yamada wrote:
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.
> 
> Replace #include <asm/export.h> with #include <linux/export.h>.
> 
> After all the <asm/export.h> lines are converted, <asm/export.h> and
> <asm-generic/export.h> will be removed.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/mips/cavium-octeon/octeon-memcpy.S | 2 +-
>   arch/mips/kernel/mcount.S               | 2 +-
>   arch/mips/kernel/r2300_fpu.S            | 2 +-
>   arch/mips/kernel/r4k_fpu.S              | 2 +-
>   arch/mips/lib/csum_partial.S            | 2 +-
>   arch/mips/lib/memcpy.S                  | 2 +-
>   arch/mips/lib/memset.S                  | 2 +-
>   arch/mips/lib/strncpy_user.S            | 2 +-
>   arch/mips/lib/strnlen_user.S            | 2 +-
>   arch/mips/mm/page-funcs.S               | 2 +-
>   arch/mips/mm/tlb-funcs.S                | 2 +-
>   11 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

