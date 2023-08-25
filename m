Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D6788FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjHYUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjHYUb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:31:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1250F212A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:31:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c0bae4da38so9876645ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692995513; x=1693600313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QbK8/oWiBIVoC/jcfdbNeWkeAfPt8MN35+9MR6xg494=;
        b=SxnUxYAjr8JBfiuonQG266dkmNZ+5hxrKSEPI6Vea0liNat+HCYvAi9Sce60JmkTTS
         NkmK35yvV3w2ctId7cF5uOOTYxJncbBpHmtzNTtx2jY11mbHnkmKu+9ep3ALYca2Ryw7
         eNv610zPxC5b6fT7ht5Sbi2rsFWV6WE3Y2AWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692995513; x=1693600313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbK8/oWiBIVoC/jcfdbNeWkeAfPt8MN35+9MR6xg494=;
        b=PcNwAZpnCNHSI28idb/u4X/F0ARa5xCKGIIZu8022f9hfUVP3DfwNBkjcYU490KK3m
         tmkl8g9IV9M7vcpLgXEtUqxGTe39vlxZIGiC/w955FKaJjnhO83HAHWf/9amMSZJuLkx
         /J8n76NXb6WwFO/VUrK4zVFy3Vz8N+BAd0DA58M3V9NWCIBig8Ld480pyvaS+R1p92OP
         YBk/ZwILP0yZND6UsrZZ5TeYF/2IwVSL1LFabGDD4EoZDjlqgjCkHHv0vNfF7xE9/fJX
         i6NKVYSdiMrafMM2n6Ka5p7ebTJU1uXicl0dBVTir3TI7pBVMFqmHkE6xUMPFTn6rx0l
         T4KA==
X-Gm-Message-State: AOJu0YzJWcGBqAO68QliEiyaHbIPgK7HXUhb/7NnBQNcsFgWCY6o/OrR
        NslMN5xx/xNs6PIc7RJ6S9UDbQ==
X-Google-Smtp-Source: AGHT+IFkHOomC5fDsX51fb+z+kMZfOW5mXRYL7CREwQSq5bU6xwcUnwTW+gBCrrDOo3EofQSeq3+Nw==
X-Received: by 2002:a17:902:d511:b0:1bb:55be:e198 with SMTP id b17-20020a170902d51100b001bb55bee198mr27660915plg.0.1692995513531;
        Fri, 25 Aug 2023 13:31:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902b40200b001bba3650448sm2158060plr.258.2023.08.25.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:31:52 -0700 (PDT)
Date:   Fri, 25 Aug 2023 13:31:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] habanalabs/gaudi: refactor deprecated strncpy
Message-ID: <202308251321.E19D664F0@keescook>
References: <20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-v1-1-a7fb9054734c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-v1-1-a7fb9054734c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:41:26PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!

For strncpy replacements the commit log needs to always address 2 items,
and really get spelled out for reviewers since the diff context is
rarely enough information to judge the safety of the change:

1) How did you determine that the destination buffer does or does not
   require %NUL termination?

2) How did you determine that the destination buffer does or does not
   need to be %NUL padded?

> 
> Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only
> ---
>  drivers/accel/habanalabs/gaudi/gaudi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
> index 056e2ef44afb..f175456cdef0 100644
> --- a/drivers/accel/habanalabs/gaudi/gaudi.c
> +++ b/drivers/accel/habanalabs/gaudi/gaudi.c
> @@ -660,7 +660,7 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
>  	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
>  	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
>  
> -	strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
> +	strscpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
>  					CARD_NAME_MAX_LEN);
>  
>  	prop->max_pending_cs = GAUDI_MAX_PENDING_CS;
> @@ -8000,7 +8000,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
>  		return rc;
>  
>  	if (!strlen(prop->cpucp_info.card_name))
> -		strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
> +		strscpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
>  				CARD_NAME_MAX_LEN);

When I look at this string, I see it gets copied out to userspace
directly:

static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
{
        struct hl_info_hw_ip_info hw_ip = {0};
	...
        memcpy(hw_ip.card_name, prop->cpucp_info.card_name,
                min(CARD_NAME_MAX_LEN, HL_INFO_CARD_NAME_MAX_LEN));
	...
        return copy_to_user(out, &hw_ip,
                min((size_t) size, sizeof(hw_ip))) ? -EFAULT : 0;
}

So if "prop" isn't zero initialized, this is now a kernel memory content
exposure, due to the lack of padding.

If I track the allocation of "hdev" all the way back, I can see it is,
however, zero initialized:

static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
...
        hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);


But since it's still sent via copy_to_user(), the more defensive
replacement here should be strscpy_pad().

(Also, I think you can do all three files in the same patch -- it's
operating on the same struct and in the same way.)

-Kees

-- 
Kees Cook
