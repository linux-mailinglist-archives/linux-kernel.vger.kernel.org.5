Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2CB7B59E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbjJBRrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJBRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:47:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D325C90
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:47:46 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6910ea9cddbso42618b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696268866; x=1696873666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNQQwx91b/uOnSKKZUppyBENuJr/eDgIe44FB0FMCNo=;
        b=AbT+IkSZ1SWfUy804U29it0vgHMydIrdscYuT8bTC5lUJWJ58WklfZIUl/+MloTZ6W
         +JYYgXv+A2lCdtiqWcyrUdDp22jn6vuZ1yNdNeogmUygAufZ/JMDNWIthD35YzNyXOqZ
         6YYqJjiZX997F4YgZ06AVWsu29AgD0KeZKWiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268866; x=1696873666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNQQwx91b/uOnSKKZUppyBENuJr/eDgIe44FB0FMCNo=;
        b=iaSrYM9QHoVS27zgGhKObNO2fS6NuSWD6k7CcId9rYYoHM+W3eBRlKvVFx1cAGNFr/
         CkkF5dhIXU+3KpjpjnEgjW/5dLzYgp34O5HLeJFeie4E3Bp32kDBkr7zz/mjQrfnDjxq
         fZ0FBxkO/ScIKfey01E+golKoSp3L1RleLZj+wn1NqfRzmRr7bsjmawl67eN06Md1vmk
         nBY4cSCR+prwM6YsL06cDmsuaB3NBNFW+Wq4RZQTssUo1Faav/zUJBadbSEutoInfNVg
         QT7lYDULyFkx0NXepC/gLrNYHFw/KPcG0IQy2V/zB1ZoXI7xjuSBc7Llkv51291p+2Eh
         qBlQ==
X-Gm-Message-State: AOJu0YyEWRFmzvg2DGEhYcK1LXU+JMekTUDq23YwiS1MLLuXcgkDOY2O
        PRSA3LkIAV//2OT9hWsBuuNlYg==
X-Google-Smtp-Source: AGHT+IEOGmXwzJQMmP9O9e3J1zTzuRGD6g3Odz/FFlBFPYnkIsiyFPzZQHxZCCd8Ejh+aMpMYfz8TQ==
X-Received: by 2002:a05:6a21:4841:b0:161:76a4:4f6e with SMTP id au1-20020a056a21484100b0016176a44f6emr11714690pzc.32.1696268866346;
        Mon, 02 Oct 2023 10:47:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001c3be750900sm22314441plg.163.2023.10.02.10.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:47:45 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:47:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: replace deprecated strncpy with
 strscpy
Message-ID: <202310021043.5BCA90FB92@keescook>
References: <20230927-strncpy-drivers-message-fusion-mptsas-c-v1-1-edac65cd7010@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-strncpy-drivers-message-fusion-mptsas-c-v1-1-edac65cd7010@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 04:43:08AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> The only caller of mptsas_exp_repmanufacture_info() is
> mptsas_probe_one_phy() which can allocate rphy in either
> sas_end_device_alloc() or sas_expander_alloc(). Both of which
> zero-allocate:
> |       rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> ... this is supplied to mptsas_exp_repmanufacture_info() as edev meaning
> that no future NUL-padding of edev members is needed.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Note that while `strscpy(dest, src, sizeof(dest))` is more idiomatic
> strscpy usage, we should keep `SAS_EXPANDER...LEN` for length arguments
> since changing these to sizeof would mean we are getting buffers one
> character larger than expected due to the declaration for these members:
> |       char   vendor_id[SAS_EXPANDER_VENDOR_ID_LEN+1];
> |       char   product_id[SAS_EXPANDER_PRODUCT_ID_LEN+1];
> |       char   product_rev[SAS_EXPANDER_PRODUCT_REV_LEN+1];
> |       char   component_vendor_id[SAS_EXPANDER_COMPONENT_VENDOR_ID_LEN+1];
> ... and simply removing the "+1" in conjunction with using sizeof() may
> not work as other code may rely on this adjusted buffer length for
> sas_expander_device members.

I don't agree with this assessment: without the +1, moving to strscpy()
could lead to early truncation. I would change all of them to use
sizeof(), so that %NUL termination will happen at the right place when a
maxmimally sized string source is used.

i.e. for this:

	dst[FOO + 1] = { };

	strncpy(dst, src, FOO);

we will copy at most FOO bytes into dst, leaving dst[FOO] as '\0'.

If we replace it with:

	strscpy(dst, src, FOO);

Then we'll copy at most FOO-1 bytes into dst, setting dst[FOO - 1] = '\0';

So, these need to be adjusted to use sizeof(dst)...

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Note: similar to drivers/scsi/mpi3mr/mpi3mr_transport.c +212 which uses
> strscpy
> ---
>  drivers/message/fusion/mptsas.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
> index 86f16f3ea478..1dc225701a50 100644
> --- a/drivers/message/fusion/mptsas.c
> +++ b/drivers/message/fusion/mptsas.c
> @@ -2964,15 +2964,15 @@ mptsas_exp_repmanufacture_info(MPT_ADAPTER *ioc,
>  			goto out_free;
>  
>  		manufacture_reply = data_out + sizeof(struct rep_manu_request);
> -		strncpy(edev->vendor_id, manufacture_reply->vendor_id,
> +		strscpy(edev->vendor_id, manufacture_reply->vendor_id,
>  			SAS_EXPANDER_VENDOR_ID_LEN);
> -		strncpy(edev->product_id, manufacture_reply->product_id,
> +		strscpy(edev->product_id, manufacture_reply->product_id,
>  			SAS_EXPANDER_PRODUCT_ID_LEN);
> -		strncpy(edev->product_rev, manufacture_reply->product_rev,
> +		strscpy(edev->product_rev, manufacture_reply->product_rev,
>  			SAS_EXPANDER_PRODUCT_REV_LEN);
>  		edev->level = manufacture_reply->sas_format;
>  		if (manufacture_reply->sas_format) {
> -			strncpy(edev->component_vendor_id,
> +			strscpy(edev->component_vendor_id,
>  				manufacture_reply->component_vendor_id,
>  				SAS_EXPANDER_COMPONENT_VENDOR_ID_LEN);
>  			tmp = (u8 *)&manufacture_reply->component_id;
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230927-strncpy-drivers-message-fusion-mptsas-c-f22d5a4082e2
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
