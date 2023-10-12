Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D737C65A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347076AbjJLGdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbjJLGdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:33:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE09B8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:33:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso7522795e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697092390; x=1697697190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phl5W3+qj5b5s8Bsed+j+WLh4nK22bVVfYDfsSd3Poo=;
        b=A/B2JqXMvKNIAv8xIJ+dn+S68VuUCy29k3MbbzHIZeTH4oUwM7jBVNGEGbHSwwv9fO
         s90DFlN1G0SX7hG7upNLnmPZ7YA3kpx187Agb3fQIogCSTk5tTv8unqScC88lzh018W+
         RLKIA9wytH/Pu7oR2uUAzVZyGwHJNHMzysGQcOyty8JAGVXZFs8aR7b7fUyUdsUCs/KA
         vdEPJFWO35BrGGPUcDoP3oFoZr/R+M0ILz2ZN/s1FKFqGJ/jxjJjjPcak0ud7NrFUShm
         066wURsmmEyrfowOR7acYIoLt/+hKZ6HT0I9FEHyJ6TU4q5ww8FY30uS9iH80J+pg9cU
         sj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697092390; x=1697697190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phl5W3+qj5b5s8Bsed+j+WLh4nK22bVVfYDfsSd3Poo=;
        b=qCVlxEqEmpUgiUKaplLjdMncX+OZlDjQ5Wsy0npSg2gFhPjhZtNePSvwhoGS25ymXZ
         w+Ql5QxXFEjKHVs6k4PcGGGd96D0GIx3LCrzkrrRq3zdMUz4XuGdhF3Brh5Jesdx3uSD
         N4ii0vBurDBkAkQTfhAbUkbEmQQizXJuYXGulPfybkMV/xaSN0asBaRhy/NHzhqfjA7E
         ldgl1GuM/XZy3eKZzTsOSHcf6rxEknR/ejsCAqv4pjofFrQZWHgH5p7d00ikDd8Fomy7
         AvL9onoaREUhsaT4kqOa05dJPE/s4OpyC6YfYjXb6j2IvCPiOPPa7FgJ1x9MzACD4S4W
         Owsg==
X-Gm-Message-State: AOJu0YzbCG6jJONJpmf21Lff7dPinBpRLaMa3MeKjB7iyhmURe95OOUy
        532F1SdO4tEZtaRkMRvbYW9sAg==
X-Google-Smtp-Source: AGHT+IFQ3UuhcbmL5nDmRzL7RHQDZpDGZlVDtI11m8XgEEIoIDkUDGj/sgKidZxvEZtzRGSsgxOK5w==
X-Received: by 2002:adf:fb0b:0:b0:31f:c1b5:d4c1 with SMTP id c11-20020adffb0b000000b0031fc1b5d4c1mr18781994wrr.35.1697092390464;
        Wed, 11 Oct 2023 23:33:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600000c800b0032415213a6fsm17313023wrx.87.2023.10.11.23.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:33:10 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:33:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Parenthesize macro arguments
Message-ID: <81d6e283-fd87-4fd6-964f-22cbf420cdaa@kadam.mountain>
References: <20231012050240.20378-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012050240.20378-1-soumya.negi97@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:02:40PM -0700, Soumya Negi wrote:
> Use parenthesis with macro arguments to avoid possible precedence
> issues. Found by checkpatch.pl
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
> index 2e101da83220..1cc05956ab6d 100644
> --- a/drivers/staging/rts5208/rtsx.h
> +++ b/drivers/staging/rts5208/rtsx.h
> @@ -40,17 +40,17 @@
>   * macros for easy use
>   */
>  #define rtsx_writel(chip, reg, value) \
> -	iowrite32(value, (chip)->rtsx->remap_addr + reg)
> +	iowrite32(value, (chip)->rtsx->remap_addr + (reg))

These would be better as functions instead of defines.

>  #define rtsx_readl(chip, reg) \
> -	ioread32((chip)->rtsx->remap_addr + reg)
> +	ioread32((chip)->rtsx->remap_addr + (reg))
>  #define rtsx_writew(chip, reg, value) \
> -	iowrite16(value, (chip)->rtsx->remap_addr + reg)
> +	iowrite16(value, (chip)->rtsx->remap_addr + (reg))
>  #define rtsx_readw(chip, reg) \
> -	ioread16((chip)->rtsx->remap_addr + reg)
> +	ioread16((chip)->rtsx->remap_addr + (reg))
>  #define rtsx_writeb(chip, reg, value) \
> -	iowrite8(value, (chip)->rtsx->remap_addr + reg)
> +	iowrite8(value, (chip)->rtsx->remap_addr + (reg))
>  #define rtsx_readb(chip, reg) \
> -	ioread8((chip)->rtsx->remap_addr + reg)
> +	ioread8((chip)->rtsx->remap_addr + (reg))
>  
>  #define rtsx_read_config_byte(chip, where, val) \
>  	pci_read_config_byte((chip)->rtsx->pci, where, val)
> @@ -131,8 +131,8 @@ static inline struct rtsx_dev *host_to_rtsx(struct Scsi_Host *host)
>   * The scsi_lock() and scsi_unlock() macros protect the sm_state and the
>   * single queue element srb for write access
>   */
> -#define scsi_unlock(host)	spin_unlock_irq(host->host_lock)
> -#define scsi_lock(host)		spin_lock_irq(host->host_lock)
> +#define scsi_unlock(host)	spin_unlock_irq((host)->host_lock)
> +#define scsi_lock(host)		spin_lock_irq((host)->host_lock)

For these ones, the name is too generic.  probably the right thing is
to just get rid of them completely and call spin_lock/unlock_irq()
directly.

regards,
dan carpenter

