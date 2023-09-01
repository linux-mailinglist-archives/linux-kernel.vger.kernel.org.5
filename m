Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE02178FCF0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349353AbjIAMJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjIAMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:09:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1210D4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:09:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so2142e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693570165; x=1694174965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk0R5HmkInGGVBhixKSI0EHyOyIQVsim4IRVh14h/Ak=;
        b=c7W56axAoVMPEMyWNLNsCz9qtogAjTYCrG9jgzR/Ig4c6+IDEYjox5uR5oe+SdnHv/
         B9RLl7NnSgFIExNgVC5j2fKfEGJY+EFjuEKpuDoRT4oNc7mbUy+u4/pyw2AAgbVHNJkf
         otD/UGCCyq/yfj0GhVNFkDMz3U0/U0qdFHVE3vekJy5ZHmMv9SDfDh+EiZZbTVjej7Zv
         PbPu/lmU4FiTB0xgqfAmjgwPk4capZkDmt+4dimVkNu1hvJnKG8BYLJ5u8AHCcq0Kkrs
         0r3pXPb0GVJlnaC7eiz0N4PtIKsw+cJl/EloC5uH9IrAfNdSC5Gul8abTEhE/9FHhyTH
         Y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693570165; x=1694174965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bk0R5HmkInGGVBhixKSI0EHyOyIQVsim4IRVh14h/Ak=;
        b=FIjiWGPt1BMIKwk1cZqD7n5E9xcGwoScKhhm3P4h6EsiUaoVI3kHgSFnBSr3+LX1ZO
         9aP551vBz44eDR1GF9F4yT/NcBk6hqUlljbB1RDO/G4qhjEjEeS+Jl+8xa5s9yz1RCv9
         AWL3SRxxoFuDo9o0azrUFt9w0erJ3J42ALIVK8zElEQ1/YFkuFqqYrcf2VT050Haivb8
         lfRILA4EWIxs4N6yhf0+1VE/HWHsbYbHEfx7ejavcgYKjZlAB2h0Ey/RT3WTfdMkUPH6
         5aTlQPJ2LF3Jce+77A0/+N0Jx6gL3kWC1BnI3BsA71TmTm2uzzqCWDQunaeORw/n5zc7
         yjrQ==
X-Gm-Message-State: AOJu0YwDGyrMiK4oD488k5muKwZD2+dSmV7PbQPbgamRe252LwK6qYZH
        Pco6ARS9hnmKW1/CtSC00HrbQO9KIs7xcySGsw017w==
X-Google-Smtp-Source: AGHT+IHyKH8gMHRqGy2CjmSPN/h9VmmoCG4dnvHumTIUR4FELciwbo+qucTHdn4HDTYm+hg6r/fSDA==
X-Received: by 2002:ac2:5a0a:0:b0:4ff:d0c0:5d75 with SMTP id q10-20020ac25a0a000000b004ffd0c05d75mr93760lfn.0.1693570165014;
        Fri, 01 Sep 2023 05:09:25 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id l16-20020a5d6690000000b0031c6dc684f8sm5006684wru.20.2023.09.01.05.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:09:24 -0700 (PDT)
Date:   Fri, 1 Sep 2023 12:09:19 +0000
From:   Mostafa Saleh <smostafa@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] arm64/sysreg: refactor deprecated strncpy
Message-ID: <ZPHUb4svC//EhyqJ@google.com>
References: <20230831-strncpy-arch-arm64-v3-1-cdbb1e7ea5e1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831-strncpy-arch-arm64-v3-1-cdbb1e7ea5e1@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

On Thu, Aug 31, 2023 at 10:55:59PM +0000, Justin Stitt wrote:
> strncpy is deprecated [1] and should not be used if the src string is
> not NUL-terminated.
> 
> When dealing with `cmdline` we are counting the number of characters
> until a space then copying these over into `buf`. Let's not use any of
> the str*() functions since the src string is not necessarily NUL-terminated.
> 
> Prefer `memcpy()` alongside a forced NUL-termination as it more
> accurately describes what is going on within this function, i.e: copying
> from non NUL-terminated buffer into a NUL-terminated buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Here's a quick rundown on the history of this patch:
> 1) v1 (changes requested)
> 2) v2 (applied to arm64 (for-next/misc))
> 3) v2 reverted (https://lore.kernel.org/all/20230831162227.2307863-1-smostafa@google.com/)

This is just a patch, it is not reverted yet, also Marc replied with
another proposal to use strscpy instead but with the correct length.

> 4) v3 (fixes problems with both v1 and v2)
> 
> Changes in v3:
> - Fix faulty logic and use memcpy over strscpy (thanks Mostafa and Kees)
> - Use '\0' instead of 0 to make it abundantly clear that `buf` is a NUL-terminated string
> - Link to v2: https://lore.kernel.org/r/20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com
> 
> Changes in v2:
> - Utilize return value from strscpy and check for truncation (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com
> ---
>  arch/arm64/kernel/idreg-override.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 2fe2491b692c..3addc09f8746 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -263,8 +263,8 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
>  			return;
>  
>  		len = min(len, ARRAY_SIZE(buf) - 1);
> -		strncpy(buf, cmdline, len);
> -		buf[len] = 0;
> +		memcpy(buf, cmdline, len);
> +		buf[len] = '\0';
>  
>  		if (strcmp(buf, "--") == 0)
>  			return;
> 
> ---
> base-commit: 706a741595047797872e669b3101429ab8d378ef
> change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8

Your patch will not apply on mainline but on the revert, otherwise

Tested-by: Mostafa Saleh <smostafa@google.com>

> Best regards,
> --
> Justin Stitt <justinstitt@google.com>

Thanks,
Mostafa

