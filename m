Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F77B2CED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjI2HPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjI2HO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:14:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F426199
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:14:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1835954166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695971695; x=1696576495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2OkkCi3457fhrun/Ka7gKdk+nLLGHEIhC9CyvKi8oA=;
        b=zd4Z1l+ksB42Jc7yFORoQjJzeqXLh6nVfIiu8wi7b8krk1Q3nxSjHS/wugE+LbGyLI
         F3hyRz+dVN9Q0e9k9CJcVpPo/Da/OUEHbMo893HACwp9KnRJJNcenamvOfcUAZMtQya0
         ygJ5Mr9q+TPAAy3glwAeHldrP48BvFafYFIDSgqtcQOlJms5TkPX6154nUisTfSvRtqf
         C/QWhVULgnshQHHgRuDVlV88z3XfE0KA2jkPXCFYfpVEpZg0Cde3Eb0YxCzV7snYLV3b
         p7eYb5wRxL+VaMpnbgXR5lbtkDYdyYjeut2hbNhl4TRGw9bPN6F3J2R5ePl76CaRCwiA
         6fDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971695; x=1696576495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2OkkCi3457fhrun/Ka7gKdk+nLLGHEIhC9CyvKi8oA=;
        b=SHVFbKvXgxP+3z+xHSpmfJwlyUgjmxehe6nWOUAzcTHa/dOgGdNXgnBk1s61G3dTuJ
         vL1PPMMPBZZA/om1HZHbgfi2piUhPkz+VFZPFLGGTmmDUobVlXa9bEDfEdIO6E0eqsJ5
         VBmunmBicis2eO/6wOZDKgmMIUw/wAQSIQ3uD4SNN81jqxWwRH101RTXG6pxsfPbSRG1
         Jr/o6Y5I7vsiv3bbUhtj9vk9steb46///3haRfpWcR4tbe5CbdAqKZg+kOvVn6QasPFW
         bwXFQ+DmLdry+X3eGVK7tDRSlD3cuciDBZkk9xSSFVYZfqVFmM1CR9cWuPx3BxtJKB7r
         ICSA==
X-Gm-Message-State: AOJu0YzOiNei4ipR1Lw26szEVs6lYMlvzf11HIIV0wJZAOL2JmWUoigJ
        9y2zCPs0OourFg/Kg10BHwaNFsvVDz0z37hPzn8=
X-Google-Smtp-Source: AGHT+IGZ/E7+G4cnfaB8C0RTqz4HpzEQLdCBnqk+eAgNYK3UAcdw1uetqgquWBvnEbokDk1wX/u06w==
X-Received: by 2002:a17:906:28e:b0:9ae:552a:3d3f with SMTP id 14-20020a170906028e00b009ae552a3d3fmr3026696ejf.28.1695971695031;
        Fri, 29 Sep 2023 00:14:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b004065d67c3c9sm709048wmq.8.2023.09.29.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 00:14:54 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:14:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] gfs2: Set error on error path
Message-ID: <72de9c2e-7c60-4930-acfb-556a1f0fa4c4@kadam.mountain>
References: <ZRZrUMzweaJeEJuD@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRZrUMzweaJeEJuD@runicha.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:44:40AM +0530, Deepak R Varma wrote:
> Set the error variable inside the error path on failure. Saves
> unnecessary variable assignment during normal execution.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  fs/gfs2/bmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index ef7017fb6951..93bd8ea34444 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -162,9 +162,10 @@ int gfs2_unstuff_dinode(struct gfs2_inode *ip)
>  
>  	down_write(&ip->i_rw_mutex);
>  	page = grab_cache_page(inode->i_mapping, 0);
> -	error = -ENOMEM;
> -	if (!page)
> +	if (!page) {
> +		error = -ENOMEM;
>  		goto out;
> +	}

It used to be that the other way was faster?  I'm pretty sure the
compiler can figure it out these days.  Please don't randomly start
changing people's prefered style unless it's drivers/staging/ code.

regards,
dan carpenter

