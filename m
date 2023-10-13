Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8F7C839E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJMKsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjJMKsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:48:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B6C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:48:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32d834ec222so1855106f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697194091; x=1697798891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLLFkGf7Achrz0z+pSaE//aRnm/rW1Ix0xcw7kiGLrg=;
        b=YMBZzBsvWrXzr+2Lui3vC3LGzmnhKWRPLcnD4DAH2B9gmTZ5mUfChkGGZg6KPRV1xG
         QSixK2jNL/qY7uGbPDRtSsFncVVHCwVLbynkm/PfgWaembmTl4WmDR++KAsJftCXUOzy
         MhaeA3fOQoTLLd/2vul/otNAluMEVvTA4oplvHiCIhblBcwV909SZW6LKEWSfRH0DIrc
         aAFIcgfBJOEgjerNi4qtt7Kd+7+6lfboEBDw9xgK/ngYtAHBHdksxBNv0cXKxtxSR8/A
         ORiSSzXHjjQEKuX231JVpptaBd+owl43k1XgCDvk5foZO3S5i5kUINDU7rfandIqRZRE
         kBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194091; x=1697798891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLLFkGf7Achrz0z+pSaE//aRnm/rW1Ix0xcw7kiGLrg=;
        b=wVr8lCu3+hLKdU9T92XEPVQIUxLX51acB09O9C0d8sryXqVOKfWCk4bZ4TF38DuXeM
         Um1vNLwE/TOuKr+UcKrLmTI4/vXnHj6d9WzR51TT/HvDgonrg5rBkc75haUC1FV91Kz0
         Tuy8cM4VLVy3DYVlA2kGKE3aS2Bqz9R8HuhKnPxeT1JULPom8sxvglUJyzHmL/P/3kJR
         u0rzNMO6wVL0GdWKgbO5zB3Z5ym4Nco9eGrMrIygvGJwmckSvfi8pzfhvsPw8/cAOQ4K
         h3xvgw4+R+rJwZTJTIyOndsZ6OMT2S7YM7u3/JuKxTgu8wCtFV8C9/S+mS/+OkXtAK0n
         KzjA==
X-Gm-Message-State: AOJu0Ywb3KOKGvKxjJg42ybgPL7pfvgRKHuo0nOYqHYRZBfyafFsSCSW
        ljPbxKSwRD9NYxtWOUbB8BAxBA==
X-Google-Smtp-Source: AGHT+IER8Qmwq0wdK9VvhE99s0OeRpYmMCCnwuM07qasuEB0UUtmtrLXlArFm5b/BD98dc49TPg9zw==
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id w8-20020a5d4b48000000b003197a917107mr21319385wrs.48.1697194091127;
        Fri, 13 Oct 2023 03:48:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d7-20020adfa347000000b0032d72f48555sm5239011wrb.36.2023.10.13.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:48:10 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:48:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH]Staging: sm750fb:Add snakecase naming style
Message-ID: <efcb4734-0349-493e-be93-b95381eb6c78@kadam.mountain>
References: <20231013104220.7527-1-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013104220.7527-1-anonolitunya@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:42:15PM +0300, Dorcas AnonoLitunya wrote:
> From: Dorcas Anono Litunya <anonolitunya@gmail.com>
> 
> Change camelCase variables in file to snake_case for consistent naming
> practices. Issue found by checkpatch.
> 
> Signed-off-by: Dorcas Anono Litunya <anonolitunya@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 86 +++++++++++++--------------
>  drivers/staging/sm750fb/ddk750_mode.h |  2 +-
>  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
>  3 files changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index e00a6cb31947..f08dcab29172 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -14,13 +14,13 @@
>   * in bit 29:27 of Display Control register.
>   */
>  static unsigned long
> -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> -			     unsigned long dispControl)
> +display_control_adjust_SM750LE(struct mode_parameter *p_mode_param,

The p stands for pointer.  We don't like that naming style.  Just call
it mode_param.

Thes are the renamed things.

displayControlAdjust_SM750LE => display_control_adjust_SM750LE
pModeParam => p_mode_param
dispControl => disp_control
programModeRegisters => program_mode_registers
ddk750_setModeTiming => ddk750_set_mode_timing

I feel like this would be better broken up probably into one variable
per patch.  It's jumping around between files.  These variables are not
closely related.

regards,
dan carpenter

