Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753E17A1471
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjIODgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjIODgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:36:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773111BF4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:36:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so1372839b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694748977; x=1695353777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDCW9QY50E84DgY19QOwTRVYm400Nkn5gM2+Uo9YUF4=;
        b=Jp4S0f2dpXWjYdmG5iW4tCPEW1M09RATpNkLgUAq5AS2BtnFBH9sU2nkZbl8K2qwn7
         MeTLztD+1apzev+6p9fvIQ2i2DWVlKWBrypLOYRCtGmtMJsQXY6jhVnOLhZpUZK/J1mG
         /h2KNda4pGuHxAxhnDHAW7BwB/+a0EgapMm1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694748977; x=1695353777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDCW9QY50E84DgY19QOwTRVYm400Nkn5gM2+Uo9YUF4=;
        b=ORwYjgdCvmllhxGkl/04uwDWBw+/7z+NIkxeDXcxBvbLnFIVVxxpHeAd1I5ikHjhJr
         iEfghhweJZtDOOSFvhTp489SnrzPMQ1d1pG+FebhXYWOYu6Poc5SPIYxcTC6tlxgYQeE
         2wKnJgWJwr+MBqRWTCIBD4azz36NUMJq2Kgzt0MNv2IvPG14cgozxYfDlV6dHTmDsKhR
         eKQdNAA03skXDX6ivB7ANFkiNux6rd05Px798sEz1OcaipXu3zQiRfKlqQlqRYR3CyvO
         Ct9NBYwVFyL1wSSZAiuAi1CksACBOLfhw6Q6Svaw1Iwc12omO7EpuyoIjZftwBGLZwwX
         nIvw==
X-Gm-Message-State: AOJu0YwigS9Aji6z2Iqlo9xK/dQiMfi4uz1H9B3Re1L8IpmbOyeWr81p
        hbzFCdYxnpx0pJb+hVV7s/8jdg==
X-Google-Smtp-Source: AGHT+IETCwyaUHOy0Dso27B6lcA82SsUmHFq0Ep0JwCtQNJHBgNgHiBlml3qfkH7mh2dS3MtYv58Eg==
X-Received: by 2002:a05:6a20:3cac:b0:15a:478f:9f2e with SMTP id b44-20020a056a203cac00b0015a478f9f2emr761496pzj.1.1694748976964;
        Thu, 14 Sep 2023 20:36:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001b81a97860asm2340421pla.27.2023.09.14.20.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:36:16 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:36:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc: refactor deprecated strncpy
Message-ID: <202309142034.2B1DC7DE51@keescook>
References: <20230912-strncpy-drivers-bus-fsl-mc-dprc-c-v1-1-cdb56aa3f4f4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-strncpy-drivers-bus-fsl-mc-dprc-c-v1-1-cdb56aa3f4f4@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:52:04PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We need to prefer more robust and less ambiguous string interfaces.
> 
> `obj_desc->(type|label)` are expected to be NUL-terminated strings as
> per "include/linux/fsl/mc.h +143"
> | ...
> |  * struct fsl_mc_obj_desc - Object descriptor
> |  * @type: Type of object: NULL terminated string
> | ...
> 
> It seems `cmd_params->obj_type` is also expected to be a NUL-terminated string.
> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst keeping the
> NUL-padding behavior that `strncpy` provides.

I see evidence that %NUL padding isn't needed, like this:

                      /*
                       * Mark the obj entry as "invalid", by using the
                       * empty string as obj type:
                       */
                      obj_desc->type[0] = '\0';

but there's little harm in being conservative and leaving the padding
in.

> 
> Padding may not strictly be necessary but let's opt to keep it as this
> ensures no functional change.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested
> ---
>  drivers/bus/fsl-mc/dprc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
> index d129338b8bc0..dd1b5c0fb7e2 100644
> --- a/drivers/bus/fsl-mc/dprc.c
> +++ b/drivers/bus/fsl-mc/dprc.c
> @@ -450,10 +450,8 @@ int dprc_get_obj(struct fsl_mc_io *mc_io,
>  	obj_desc->ver_major = le16_to_cpu(rsp_params->version_major);
>  	obj_desc->ver_minor = le16_to_cpu(rsp_params->version_minor);
>  	obj_desc->flags = le16_to_cpu(rsp_params->flags);
> -	strncpy(obj_desc->type, rsp_params->type, 16);
> -	obj_desc->type[15] = '\0';
> -	strncpy(obj_desc->label, rsp_params->label, 16);
> -	obj_desc->label[15] = '\0';
> +	strscpy_pad(obj_desc->type, rsp_params->type, 16);
> +	strscpy_pad(obj_desc->label, rsp_params->label, 16);

I really don't like all the open-coded sizes, but yeah, okay, it's not
technically wrong. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dprc_get_obj);
> @@ -491,8 +489,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
>  	cmd_params->irq_addr = cpu_to_le64(irq_cfg->paddr);
>  	cmd_params->irq_num = cpu_to_le32(irq_cfg->irq_num);
>  	cmd_params->obj_id = cpu_to_le32(obj_id);
> -	strncpy(cmd_params->obj_type, obj_type, 16);
> -	cmd_params->obj_type[15] = '\0';
> +	strscpy_pad(cmd_params->obj_type, obj_type, 16);
>  
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
> @@ -564,8 +561,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
>  	cmd_params = (struct dprc_cmd_get_obj_region *)cmd.params;
>  	cmd_params->obj_id = cpu_to_le32(obj_id);
>  	cmd_params->region_index = region_index;
> -	strncpy(cmd_params->obj_type, obj_type, 16);
> -	cmd_params->obj_type[15] = '\0';
> +	strscpy_pad(cmd_params->obj_type, obj_type, 16);
>  
>  	/* send command to mc*/
>  	err = mc_send_command(mc_io, &cmd);
> 
> ---
> base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> change-id: 20230912-strncpy-drivers-bus-fsl-mc-dprc-c-bc7d818386ec
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
