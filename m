Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944267D3948
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJWO1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjJWO1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:27:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD9D73
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:27:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083f613272so28911185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698071227; x=1698676027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwAfBCzyEL9M9CAS9M5go7qNbD/H8dJ1LrQUAE2nRV4=;
        b=euHkdPwbVhDYCgRDAUjXfPZWd5ZDSrTU6IGdEzOACrOzNUQSvQg541RRBoOJog24sW
         NG5YuX9+CuDBD0jJkKM+wdBYg8uk5x6VJt/ctSBGcSv9mISTugovMpFV3LQtBNPuEG5P
         xnRAMrrzpQoIHS8uYC74DjjLjApLOYhIoVdAmRZ0RCiqUWnttSV3Iw33eGaMXS4JKq8b
         LYQ6wR44Y9q8c+rdMAE4AXUoWEyePeiidzEbLOjIgT0+Xuzc+1kv25c5M8M1pFxcAa7t
         j8hH86EaQF6aUkWf8MVFs3uuB/sLEKf9CmaNGX4XcH6m23CbID6DzVuKnDC6Tcth7HSt
         o2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071227; x=1698676027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwAfBCzyEL9M9CAS9M5go7qNbD/H8dJ1LrQUAE2nRV4=;
        b=Yt/OIbZ6PUCn3PjZ8mvVAvJ/t9dXqixHnH2fI2+3MCZ2oa1Uf6a6Dc3uzZ3cev86O/
         uxrbLOEqe6ez2bTLxtWtXjq/oyAlk38oeE8r8ZRPtvkTI9NzHNktsPl2Bfuy7imUyGN/
         xT0QEg5sfzN6+9cVRrn4y63XpXbbckWpX7yiB8K3aXgM5kI192XWuOAiTM2ARAJR1ycH
         1nwzoWqVpQ8vAKoz30R4aShvqVdwr+aEgZsQmPpUSiA3exMnKyx7E3XdUmp6Iw2+Ssx7
         5PUJP3L/zE+09un8UBb0a1KjPcihGILDibnLpVZuKyRsKojEqCh5EAf4eEwaIgCDoLkK
         nyCg==
X-Gm-Message-State: AOJu0YynLpCqaHJyDZp5/9YJ8Ar0lw9V5Xzi02hVRpYmSKujBKUN8hNd
        rCsMgvGf4K6Bu0GV3kKeylLZnyrzrJLDh7hIPQk=
X-Google-Smtp-Source: AGHT+IGsPviJvYb+Qa0YPg1rlRYHeafkFn9M5YrEypyA+svUk2pOnU8f56Un06MUp/IZG22EqE/hTw==
X-Received: by 2002:a05:600c:5115:b0:403:cc64:2dbf with SMTP id o21-20020a05600c511500b00403cc642dbfmr8051547wms.27.1698071227028;
        Mon, 23 Oct 2023 07:27:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c499100b0040772138bb7sm14226886wmp.2.2023.10.23.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:27:06 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:27:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] staging: media: av7110: Remove unnecessary
 whitespace before quoted newlines
Message-ID: <68f20f25-d612-473d-8dcf-a5dfc1ae6279@kadam.mountain>
References: <20231020232332.55024-1-bergh.jonathan@gmail.com>
 <20231020232332.55024-4-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020232332.55024-4-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 01:23:30AM +0200, Jonathan Bergh wrote:
> Fixed multiple instances where whitespaces were placed before quoted
> newlines
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/media/av7110/av7110_av.c | 40 ++++++++++++------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
> index 482dfc548b16..880fa8a314ba 100644
> --- a/drivers/staging/media/av7110/av7110_av.c
> +++ b/drivers/staging/media/av7110/av7110_av.c
> @@ -150,7 +150,7 @@ int av7110_av_start_play(struct av7110 *av7110, int av)
>  {
>  	int ret = 0;
>  
> -	dprintk(2, "av7110:%p, \n", av7110);
> +	dprintk(2, "av7110:%p,\n", av7110);

Just delete all these printks.  They are useless.

regards,
dan carpenter

