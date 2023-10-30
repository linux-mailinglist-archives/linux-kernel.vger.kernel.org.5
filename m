Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1154D7DB4AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjJ3IBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3IBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:01:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3AB7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:01:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c51388ccebso57803341fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698652862; x=1699257662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4hbEsVZloBKDJVfZ06YyJZ36O1TQO3SiJssr4ux4hSA=;
        b=QzvNQaAiJu+aWAXGxuywlvIK+av/woUJxKA4ibDxbKTBa/EqvQPjBR/U6jI/9IZm0S
         n0TtwAopAUgJTEwnP2r7fMR3qrd1kD00cxjFnGoFafKH7gjyYD9cY5kjCovkJHpJQGiG
         S88wmpnlWYdZrzEi1SGX3RmvIYrsDL4VQlJRWC+gd9uKDc/6H6amuesdu9y7CPORrvq8
         3QvhcpvLTDK6OKn2dbGuylPLUaT2FjQrVV+n8nqzMQIlFf4h7NdV0MtiZKF6J/Haogyq
         iiv+rDwJ5f0/JAwtdM3UWc16Ue/GKGRbdCI86o2HhZN8gNDlXrHa6/Moo9JDkCYIfvwl
         zPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652862; x=1699257662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hbEsVZloBKDJVfZ06YyJZ36O1TQO3SiJssr4ux4hSA=;
        b=tREfzXf21xorN/5wZNhK4ElTtf5w5vlqRhH9uQraRQmWwsZhvieu3BH8SvU5DB9vh/
         XfqHs1/HosUNrsjQkzzfbXejDRsxxuCS2GC6qFzNPLMxw77ssIUZppwOJOvDFCBP1zX+
         1AFpSG24XjgAFLjGzI9HbZUUaipGLzymEE73dDOFB334aPUS/ZqHR1V3vbUyBNNHtUd1
         883HWC8+GtfGqeSxNnMwJQaBonhOMqYZrIQkQn59SQh444bFOF0LX07JXwh+ktMbxm2Y
         8zoBn5EX9N/9JVi4XPv+iCdCMwicLIgfwJfF481gBRtmbueMOTfdnb9jP9M5nj2QLV5y
         y0kQ==
X-Gm-Message-State: AOJu0YzSUIKum3beKDCfdw0vbRViWe3l8G9lRxJc6d+F1cRwwEccj70O
        MSYuGKJi/a+Wo6kFLlNtGlhCvA==
X-Google-Smtp-Source: AGHT+IFi8eKhOYLqIIwKZfwvbJG+2VeCGiU8fe7jnQB5TpLBBKB0L2OFKAFmTGfMOmF4SaDJZ4T8Xg==
X-Received: by 2002:a2e:731a:0:b0:2c5:6d8:8dfc with SMTP id o26-20020a2e731a000000b002c506d88dfcmr6554965ljc.13.1698652862384;
        Mon, 30 Oct 2023 01:01:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o38-20020a05600c512600b00407752f5ab6sm8605325wms.6.2023.10.30.01.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 01:01:01 -0700 (PDT)
Date:   Mon, 30 Oct 2023 11:00:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: ti_sci: Fix an off-by-one in
 ti_sci_debugfs_create()
Message-ID: <6fa05bc4-55ad-4173-9af0-9db713b4d148@kadam.mountain>
References: <880aeea52f3bdde5e3e8843bbedb7fd068a58be2.1698565938.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <880aeea52f3bdde5e3e8843bbedb7fd068a58be2.1698565938.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 08:52:36AM +0100, Christophe JAILLET wrote:
> The ending NULL is not taken into account by strncat(), so switch to
> strlcat() to correctly compute the size of the available memory when
> building 'debug_name'.
> 
> Because of the difference in the return type between strncat() and
> strlcat(), some code shuffling is needed.
> 
> Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")

The fixes tag isn't really required.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/firmware/ti_sci.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 7041befc756a..1036c6b0f3eb 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -181,10 +181,9 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
>  	/* Setup NULL termination */
>  	info->debug_buffer[info->debug_region_size] = 0;
>  
> -	info->d = debugfs_create_file(strncat(debug_name, dev_name(dev),
> -					      sizeof(debug_name) -
> -					      sizeof("ti_sci_debug@")),
> -				      0444, NULL, info, &ti_sci_debug_fops);
> +	strlcat(debug_name, dev_name(dev), sizeof(debug_name));

Eventually we are going to want to get rid for the strlcat() as well,
right?  Everyone hates strl* functions because they do a strlen() on
the src string.  It's fine if the src string is a string constant, I
suppose.  Here we basically trust dev_name() to be reasonable so either
strncat and strlcpy() are fine I guess...

But it's is more readable if the we use snprintf().

        snprintf(debug_name, sizeof(debug_name),
                 "ti_sci_debug@%s", dev_name(dev));

regards,
dan carpenter

> +	info->d = debugfs_create_file(debug_name, 0444, NULL, info,
> +				      &ti_sci_debug_fops);
>  	if (IS_ERR(info->d))
>  		return PTR_ERR(info->d);
>  
> -- 
> 2.34.1
> 
