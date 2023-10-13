Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A97C8117
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjJMI5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjJMI5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:57:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF355BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:57:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4066241289bso19555995e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697187464; x=1697792264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BAC5kzitTDQn20v79RDexnUptsmfPFexGphHJBvI8cw=;
        b=S8pAfi5VlcIvjmTMY+aKsVcwgVLJCYszVHxCYAsEAhT2bEpJFejtBXxDahMYemy6Xa
         YddQ78nG1+DinVIjPPwZ7Jtbm7do/2LJDIAsmyrufZS7O/vrk5er84wy5y1Z1iFJspr7
         nTg55bD1caOVFi01QFGXqLPIDj2aTNxnjk5WUX/b5KYoHuJ9xHSl2gh+tT6+LvsnMRh9
         43J3p5MdpBtigPp/Yea8RoFQ5Te6C5w8ZJLlJXE+aHOTpAlL1tXpqhWnYcxgEOqvvaWo
         BO4+ex8QxJ6UrOz+zUQmyF42BJfrmytmmDxqhHfGa9AWuX0nT3Osso7zyP8hyqi9+x73
         1+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697187464; x=1697792264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAC5kzitTDQn20v79RDexnUptsmfPFexGphHJBvI8cw=;
        b=Tr1raSM3AVY9chYVa/PU7+kc5MHiJByung1ekYG+fQipYsdN8wZR4OEPdH0GwC/AQ2
         kDm6qEKkVUs8Eidf5Lklp2F0Sma2Mhq1j+8QCwUzPkvjKvdrEnbG7K23JYPEnYxPzk8+
         1V07llcEYc2Xt9ceFbTJu/F08KZndBLbr4lIH235z+MxgY3SN34BszonMOOCej63Or9l
         O9zs/OxmgNNyPqWi10LfE8jx4ya4vq+IWXsOjRFr1M5UbZGRAbs+Duo9kG6ieVp2Namk
         OcxhZlVdGxrUdfLjwuhnILYx90B+YIcgGq1QQVrFZvqoFgxHW493L5NmsaP0d+NXYLeE
         XDHw==
X-Gm-Message-State: AOJu0Yy2tMfE+ZzFNJJjtbNsYK4Gea3Q/WQWgYJL9hKAzjgcZVhGWkCH
        aI3z+RrWUNUrTK89HH1wx6gcTw==
X-Google-Smtp-Source: AGHT+IHFQ1Q33o5z565Sh4eE318TfBuHLEcrvdnZ/WFi/WGhfesLfCmWVGxQvtq7daaoXgXbidNCxg==
X-Received: by 2002:a05:600c:3786:b0:405:359a:c965 with SMTP id o6-20020a05600c378600b00405359ac965mr24219595wmr.4.1697187464002;
        Fri, 13 Oct 2023 01:57:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c00c800b004068495910csm1975273wmm.23.2023.10.13.01.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:57:43 -0700 (PDT)
Date:   Fri, 13 Oct 2023 11:57:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: gdm724x: Match alignment with open parenthesis
Message-ID: <a0a7274f-eba6-4f72-9569-ec4c4fff3a1a@kadam.mountain>
References: <cover.1697184167.git.soumya.negi97@gmail.com>
 <ff627fcbc9e450c2e8f4aa5810b94e56151efa2a.1697184167.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff627fcbc9e450c2e8f4aa5810b94e56151efa2a.1697184167.git.soumya.negi97@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:26:34AM -0700, Soumya Negi wrote:
> Fix CHECK: Alignment should match open parenthesis
> Issue found by checkpatch.pl
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 32b2e817ff04..4e5cac76db58 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -271,8 +271,8 @@ int register_lte_tty_driver(void)
>  	int ret;
>  
>  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> +					      TTY_DRIVER_DYNAMIC_DEV);

I prefered the original code.  It was more readable.

regards,
dan carpenter

