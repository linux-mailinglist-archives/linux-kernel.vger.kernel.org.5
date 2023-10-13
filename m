Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6467C82AB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjJMKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjJMKAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:00:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40666AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:00:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d9552d765so1186356f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697191201; x=1697796001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyPAgTzM1/g4gPZZcwICWt2m4l0zgMIJEbaa3FF8/rc=;
        b=zI9VZdM08lOeBX4iYZ055a6JwXfKmpllusNnpfvVwNpvNW3SAX1c1veNvrCMnbhQum
         Vn7w7S68MBqLaKdcgKOxbPMG+kc5KYxQ4Vk3gMjX4286NfvUqvuEu9rr847wqitoMFEI
         6CMCpkzQw84u+QiX0ZqtinSvTq6/L6PogCv/q+NMA4IZWvZ2b6ZvYO85vaAD4Av8YLub
         xWldPFwIMIwOpsl9w/Mm5v3lPSq+eOnLg2pFEcPh8e27XBKQ9CYrq3iopHlw1UGrbjcB
         J6S8BBkDH9iw1XHjpZ/C/Re5xSjbynIaQH/BXrvdDsakjytXmbSw87j8qj5ds9VxnLVo
         KNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697191201; x=1697796001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyPAgTzM1/g4gPZZcwICWt2m4l0zgMIJEbaa3FF8/rc=;
        b=Zl7TjCr6GLy0blYQE1FPNBoRRIO/yiAmx1b+lPArAVJTAuj/erQ1wqx4RCSA6Iuf9u
         sDjVyHy1l+9BMgMMyYrcnInED8PsitQIWUIBXdpuPmDtIjpizFvhZLej40ic6ECxRPjf
         HCdwPpCbtMZaM/Srw2pgGjl3jlSyY4lFj6WVdhUiDrHwFCDgwBTnzwg9HHSlZPfQJraK
         ryvavjtD/w5E6EjHHnD3X3QYka2jYwvR9W3IQCTef+3MB+jQEBF59uMjZc7kFxcqs7P0
         ZYFhCNEDocBOr7NUD8zc+dyfA1++2oD4LXyNvtdRi3JVrPTPJ206yHJUrgbEToheG0GP
         vuJg==
X-Gm-Message-State: AOJu0YzzXMmqa8rdb6TuRFQ8H++DzXd7jvb9h3NhMAkd0bsGS3vi+/Qs
        MGdfoJES+mtFCgePPoT+joK9ZA==
X-Google-Smtp-Source: AGHT+IFtG5rE+zx5Zt2wiuAc9FukWFD0iWAMWdFFwP31fcLpwYJAkqFbL7DnufhzKAsr+EjYbbPSAQ==
X-Received: by 2002:a05:6000:1c09:b0:329:6b35:d141 with SMTP id ba9-20020a0560001c0900b003296b35d141mr22025569wrb.44.1697191201245;
        Fri, 13 Oct 2023 03:00:01 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d55c5000000b003142e438e8csm1307815wrw.26.2023.10.13.03.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:00:00 -0700 (PDT)
Date:   Fri, 13 Oct 2023 12:59:58 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH v4] staging: wlan-ng: replace  strncpy() with strscpy()
Message-ID: <b53cc9c0-f1fd-43ae-85d9-2c502fc4fcec@kadam.mountain>
References: <ZSkT0pFu0VClVc1V@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkT0pFu0VClVc1V@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:54:26PM +0300, Calvince Otieno wrote:
> Checkpatch suggests the use of  strscpy() instead of strncpy().
> The advantages are that it always adds a NUL terminator and it prevents
> a read overflow if the src string is not properly terminated.  One
> potential disadvantage is that it doesn't zero pad the string like
> strncpy() does.
> 
> In this code, strscpy() and strncpy() are equivalent and it does not
> affect runtime behavior.  The string is zeroed on the line before
> using memset().  The resulting string was always NUL terminated and
> PRISM2_USB_FWFILE is string literal "prism2_ru.fw" so it's NUL
> terminated.
> 
> However, even though using strscpy() does not fix any bugs, it's
> still nicer and makes checkpatch happy.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
> Patch version v4:
> 	Provide a valid description of the patch

Good.

However, you've still included the v1 patch...  See below.  Don't do
that.

regards,
dan carpenter

> Patch version v1:
>         Replacing strncpy() with strscpy()
> 
>  drivers/staging/wlan-ng/prism2fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
> index 5d03b2b9aab4..57a99dd12143 100644
> --- a/drivers/staging/wlan-ng/prism2fw.c
> +++ b/drivers/staging/wlan-ng/prism2fw.c
> @@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsigned int nfchunks,
> 
>                 if (j == -1) {  /* plug the filename */
>                         memset(dest, 0, s3plug[i].len);
> -                       strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
> +                       strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
>                 } else {        /* plug a PDR */
>                         memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
>                 }
> 
> -- 
> Calvince Otieno
> 
