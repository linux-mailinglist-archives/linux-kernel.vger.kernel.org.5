Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6224F7C5A41
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjJKRab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjJKRaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:30:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06FB0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:30:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40566f8a093so1364185e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697045424; x=1697650224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=me7Hf3Bi0S2OqFfc7MfvwerAXxLHdIkSHVDAhrcUZMQ=;
        b=UlI/soEC7ZcP9RwGPfskw36ZU8nYNe92JyiUKMGMRj/7ZRaULnDeUZgW+/q761XI0d
         qR6peUEW2eqB5o83hxIpZCg/wO4USwkdQapsgQUz6qDPWum5I2ZnB4hWn0Mq1QGDuAA7
         EpcVXa925WQIxi4iM+mgRbuslg0QPUl26ua1Zte+v9ly8NseSGah5GOCS5IL+c5UBcUD
         Azb1dgwwZ5LiTNyHR3//uZcT5tTE84UJH+lTZmCIPTCWUvJH8xq3Hyv/b+iZAXf+G7YS
         CUGBbHnymu6TSMqw/03F54ZJ61dMMO5BmUbMpcb9t+SnWya+gyPuibUGfHkorKhQf09N
         oTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697045424; x=1697650224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me7Hf3Bi0S2OqFfc7MfvwerAXxLHdIkSHVDAhrcUZMQ=;
        b=hSDYjAuj3lFcPO7ByUCB5CdUmdMkpK6q0z79QNfmnq+u5fjvg1DY8q96KF/W+nNR51
         OjtrTtBsIje968sPRDiX79Qe90YrXj2BgWdUJH/1IiC0zVoX2BKHhmGSIfgxQuzFAQOB
         YY196Hd1T09XoYF7nujvcCykUq6zoDxDbzNgrg0PTd8gE+oX3j/y8Uqc8LVQlmtMvry4
         cWtWIwz5Va0Q3VkaVvGDw6yjZK9A1U3iF/eso+rtqI3ZTHQc7HyleikUzlog9NYWF8OZ
         1qAAu8wD9exYS+TIdJDyQTqRTtC3kZBC2GKHGAFvSuEPBgbicTJmO273IOxbmw3CZB0N
         25Dw==
X-Gm-Message-State: AOJu0Yyr4fPcuoIcLU6qqPyEjgVfAYrbFzMDLy7/5wgZq9dg6mXtECqB
        6dE6Z35S79UAn4AWZu/jv43RDQ==
X-Google-Smtp-Source: AGHT+IH25Gk9gu7bi2ki+3ZgFXad+L/iUZXUkkYb4XCbhICFDVqbOpLWWS83+XQeZrlIDcbGWx0KYg==
X-Received: by 2002:a7b:c40a:0:b0:401:23fc:1f92 with SMTP id k10-20020a7bc40a000000b0040123fc1f92mr19865951wmi.25.1697045424518;
        Wed, 11 Oct 2023 10:30:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b004060f0a0fdbsm19775974wmi.41.2023.10.11.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:30:24 -0700 (PDT)
Date:   Wed, 11 Oct 2023 20:30:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     drosdeck <edson.drosdeck@gmail.com>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs:Fix coding style errors and warning
Message-ID: <03446a07-ef54-49c3-a7a2-644715603891@kadam.mountain>
References: <20231011164232.28866-1-edson.drosdeck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011164232.28866-1-edson.drosdeck@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You need to fix your From: header.

On Wed, Oct 11, 2023 at 01:42:32PM -0300, drosdeck wrote:
> Warning found by checkpatch.pl script. Fixes warning replacing printk to
> pr_crit and fixes conding style.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 21 +++++++++-----------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index 490431484524..e178a6881e0c 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -48,7 +48,6 @@ static void sd_sync_int_hdl(struct sdio_func *func)
>  {
>  	struct dvobj_priv *psdpriv;
>  
> -
>  	psdpriv = sdio_get_drvdata(func);
>  
>  	if (!psdpriv->if1)
> @@ -73,7 +72,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
>  	err = sdio_claim_irq(func, &sd_sync_int_hdl);
>  	if (err) {
>  		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
> -		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
> +		pr_crit("%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);

Use dev_crit() instead.

Otherwise the rest of the changes are fine, but you'll need to break
the patch up into multiple patches.

regards,
dan carpenter

