Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE21A7FFE14
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377062AbjK3VzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377029AbjK3VzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:55:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6639910DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:55:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso13956025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701381306; x=1701986106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec58TXbgvOF1VJEyaIIIq5ozr+88I6s94LR1x+GzWU0=;
        b=GHEGZawkG+YEHM22bGO+Wv1uRcyNO4qv/rLKB0DEKxMwGX64mNFdV0k5rUCgfU6u+1
         xXfjKqgveUmhrhItfA4U77hqv4elPQH57IUXViePHnzNFlDxCzQRZQo+638Im42kpX87
         1Pm2mAPVrT6S1GRe7SdOTnmPFy7sESsiQkmI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381306; x=1701986106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec58TXbgvOF1VJEyaIIIq5ozr+88I6s94LR1x+GzWU0=;
        b=SWQUdoVhX84+vuWn6f44i1bcrew1YG+rh/64WZK8b89F1NBJQi+Mhac88N+EtSKPVr
         iyrS6ooypdqGoC31QsjVe4cIHGavmTfCPByAD21ZkqaWogpDtlzj677OhEBu1D6LzxCM
         nv36XRKeOQtQ+cwp/ZTaJZTC35y/ufbylaxtc55pjvTMI97cLFl63xkAyoXI9QKhTd0h
         9v+P6NEjqubEXWHHU24x+HTe0aByNcNa+eZRkpf+gcpvYmNH5eigECUCOOIwQgIt3yAc
         GuU1KJaTWYb0Fi8V+y4xDZWxxUTqD3hH92thm7ip36vwXmq6AQzPe3WFlHkiqG4gtXCt
         5H2Q==
X-Gm-Message-State: AOJu0Yys9AXkk+5YNM8UYI2iZoyQJOdIVwfl8z99ULLdXzaEC3Bw2vgL
        L3X6U0yhQznB9tlDSX9tnOYWBQ==
X-Google-Smtp-Source: AGHT+IHCY4czfywkANHTsCYBSUHuXcP9OHpxs/rSKhmXqfephZQVfxjWeOEEDd54uCq4zLIB1i+6Cw==
X-Received: by 2002:a17:902:d303:b0:1cc:4e81:36a4 with SMTP id b3-20020a170902d30300b001cc4e8136a4mr25857013plc.5.1701381305897;
        Thu, 30 Nov 2023 13:55:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001cfd35ec1d7sm1867953plo.243.2023.11.30.13.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:55:05 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:55:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with
 strscpy_pad
Message-ID: <202311301354.0DAC97C@keescook>
References: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:44:59PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
> both dump_info->dev_human_readable and dump_info->bus_human_readable are
> intended to be NUL-terminated.
> 
> Moreover, since this seems to cross the file boundary let's NUL-pad to
> ensure no behavior change.
> 
> strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
> it.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thread ping. Can the wireless folks please pick this up?

Thanks!

-Kees

> ---
> Changes in v2:
> - prefer strscpy_pad (thanks Kees)
> - Link to v1: https://lore.kernel.org/r/20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v1-1-bf69ec7d1b97@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> index 3ab6a68f1e9f..7aa282592cdc 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> @@ -880,10 +880,10 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
>  			cpu_to_le32(fwrt->trans->hw_rev_step);
>  		memcpy(dump_info->fw_human_readable, fwrt->fw->human_readable,
>  		       sizeof(dump_info->fw_human_readable));
> -		strncpy(dump_info->dev_human_readable, fwrt->trans->name,
> -			sizeof(dump_info->dev_human_readable) - 1);
> -		strncpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
> -			sizeof(dump_info->bus_human_readable) - 1);
> +		strscpy_pad(dump_info->dev_human_readable, fwrt->trans->name,
> +			sizeof(dump_info->dev_human_readable));
> +		strscpy_pad(dump_info->bus_human_readable, fwrt->dev->bus->name,
> +			sizeof(dump_info->bus_human_readable));
>  		dump_info->num_of_lmacs = fwrt->smem_cfg.num_lmacs;
>  		dump_info->lmac_err_id[0] =
>  			cpu_to_le32(fwrt->dump.lmac_err_id[0]);
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231017-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-1f49f00b8a2e
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
