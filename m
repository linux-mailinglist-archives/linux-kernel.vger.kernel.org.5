Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8901080ADEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574718AbjLHUd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:33:26 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B2C1724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:33:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce934e9d51so1952022b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 12:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702067611; x=1702672411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QDm0samvC5P/9akoWEQePvjxWAFPqGq3UDU4GCf/u2w=;
        b=biz4J9KIXHNfFMbLKLd6Vip5DgTs3WNWMW8OpSG60hKVvBvSBf85ugT4Fp9ClQtRxP
         4lqiRypX3LgE/bv921jNX81eUMvjfb/wFOs4Z0bnokqysi04jMakpvOKogTNba9rVrZV
         rs8te3+sMR9g24qEoevHKZpoYK/jEGzCPWJBys6zDxaMP2eo2pfsx86s3TwGJJ1UZSeE
         z3WDvlGvYpsRbHE0/Usjc1yVDgcG40ZTjJ3BNCgemb+UtgQh1Xfd0tu4uGKkLVJZTDYC
         zj2NcRvF3PLbTaQ+Q3KgvkWjw/NmuoIt52qkWDtU9YqokTlTdFKD+xZqKm4+NavD0huv
         ZY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702067611; x=1702672411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDm0samvC5P/9akoWEQePvjxWAFPqGq3UDU4GCf/u2w=;
        b=uiYmqYz+rAUGOJS7VSEAmvRJL3tMMfDTGuT3VB58CdKdgbJTvqtUnjrDx/pdahJh5i
         Fh1wqMzWdk07pi0ntyWhj7uc9ynACOlK3QhimyGRDaHQMkyUIpBgnzPrwd1IyRc7Ceqs
         OGK3nnDZuKJ0jlm9Xmo+73r50vhPR0FjUBWoN1nnUYOm0FQ+jzXDsxsvsx70iQt7e+BF
         J13MrKHZInCHETho+mn6Xx8QvNATTF+p2ICYPbb5XKL5WomAiKAQoQ5epGkGe6x3+Apt
         MV0aAsNMH6h1aixQrBv6N+l8HSDEF81iVviX5pQgl4itluhKp7fSrzpiEwmogVBq/IAp
         IsZg==
X-Gm-Message-State: AOJu0YxKygBnaxk7qVPysC4TOO1ZXZyARNoHU1umPkEuh2EBnTcgDrtM
        MglDesBnl3gLMWKHVTp2bCcYvA==
X-Google-Smtp-Source: AGHT+IFnMNHGLXwMuu/G8AJ6XSzadocAlVjm2CAHJzFuxIZSIqeBa5t6fI09aIMFEJdey2lv+sByOQ==
X-Received: by 2002:a17:902:ea0c:b0:1d1:c917:2e5c with SMTP id s12-20020a170902ea0c00b001d1c9172e5cmr833506plg.95.1702067611033;
        Fri, 08 Dec 2023 12:33:31 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:bc99:83ae:a2d5:c5ca])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b001cfcc10491fsm2120947plf.161.2023.12.08.12.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:33:30 -0800 (PST)
Date:   Fri, 8 Dec 2023 13:33:28 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Adrien Leravat <adrien.leravat@gmail.com>
Cc:     andersson@kernel.org, corbet@lwn.net,
        linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: rmpsg: update with rpmsg_endpoint
Message-ID: <ZXN9mAXUeHopmdiQ@p14s>
References: <20231203200606.255302-1-adrien.leravat@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203200606.255302-1-adrien.leravat@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 12:06:04PM -0800, Adrien Leravat wrote:
> It seems the documentation was not updated when `rpmsg_sendto`
> and related switched from `rpmsg_channel` to `rpmsg_endpoint`.
> This change updates the proper calls, text, and the sample.
> 
> Signed-off-by: Adrien Leravat <adrien.leravat@gmail.com>
> ---
>  Documentation/staging/rpmsg.rst | 50 ++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
>

Thanks for the refactoring.  I have applied this patch.

Mathieu

> diff --git a/Documentation/staging/rpmsg.rst b/Documentation/staging/rpmsg.rst
> index 1ce353cb232a..dba3e5f65612 100644
> --- a/Documentation/staging/rpmsg.rst
> +++ b/Documentation/staging/rpmsg.rst
> @@ -68,13 +68,14 @@ User API
>  
>  ::
>  
> -  int rpmsg_send(struct rpmsg_channel *rpdev, void *data, int len);
> +  int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
>  
> -sends a message across to the remote processor on a given channel.
> -The caller should specify the channel, the data it wants to send,
> +sends a message across to the remote processor from the given endpoint.
> +The caller should specify the endpoint, the data it wants to send,
>  and its length (in bytes). The message will be sent on the specified
> -channel, i.e. its source and destination address fields will be
> -set to the channel's src and dst addresses.
> +endpoint's channel, i.e. its source and destination address fields will be
> +respectively set to the endpoint's src address and its parent channel
> +dst addresses.
>  
>  In case there are no TX buffers available, the function will block until
>  one becomes available (i.e. until the remote processor consumes
> @@ -87,17 +88,18 @@ Returns 0 on success and an appropriate error value on failure.
>  
>  ::
>  
> -  int rpmsg_sendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst);
> +  int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst);
>  
> -sends a message across to the remote processor on a given channel,
> +sends a message across to the remote processor from a given endpoint,
>  to a destination address provided by the caller.
>  
> -The caller should specify the channel, the data it wants to send,
> +The caller should specify the endpoint, the data it wants to send,
>  its length (in bytes), and an explicit destination address.
>  
>  The message will then be sent to the remote processor to which the
> -channel belongs, using the channel's src address, and the user-provided
> -dst address (thus the channel's dst address will be ignored).
> +endpoints's channel belongs, using the endpoints's src address,
> +and the user-provided dst address (thus the channel's dst address
> +will be ignored).
>  
>  In case there are no TX buffers available, the function will block until
>  one becomes available (i.e. until the remote processor consumes
> @@ -110,18 +112,19 @@ Returns 0 on success and an appropriate error value on failure.
>  
>  ::
>  
> -  int rpmsg_send_offchannel(struct rpmsg_channel *rpdev, u32 src, u32 dst,
> +  int rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  							void *data, int len);
>  
>  
>  sends a message across to the remote processor, using the src and dst
>  addresses provided by the user.
>  
> -The caller should specify the channel, the data it wants to send,
> +The caller should specify the endpoint, the data it wants to send,
>  its length (in bytes), and explicit source and destination addresses.
>  The message will then be sent to the remote processor to which the
> -channel belongs, but the channel's src and dst addresses will be
> -ignored (and the user-provided addresses will be used instead).
> +endpoint's channel belongs, but the endpoint's src and channel dst
> +addresses will be ignored (and the user-provided addresses will
> +be used instead).
>  
>  In case there are no TX buffers available, the function will block until
>  one becomes available (i.e. until the remote processor consumes
> @@ -134,13 +137,14 @@ Returns 0 on success and an appropriate error value on failure.
>  
>  ::
>  
> -  int rpmsg_trysend(struct rpmsg_channel *rpdev, void *data, int len);
> +  int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len);
>  
> -sends a message across to the remote processor on a given channel.
> -The caller should specify the channel, the data it wants to send,
> +sends a message across to the remote processor from a given endpoint.
> +The caller should specify the endpoint, the data it wants to send,
>  and its length (in bytes). The message will be sent on the specified
> -channel, i.e. its source and destination address fields will be
> -set to the channel's src and dst addresses.
> +endpoint's channel, i.e. its source and destination address fields will be
> +respectively set to the endpoint's src address and its parent channel
> +dst addresses.
>  
>  In case there are no TX buffers available, the function will immediately
>  return -ENOMEM without waiting until one becomes available.
> @@ -150,10 +154,10 @@ Returns 0 on success and an appropriate error value on failure.
>  
>  ::
>  
> -  int rpmsg_trysendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst)
> +  int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
>  
>  
> -sends a message across to the remote processor on a given channel,
> +sends a message across to the remote processor from a given endoint,
>  to a destination address provided by the user.
>  
>  The user should specify the channel, the data it wants to send,
> @@ -171,7 +175,7 @@ Returns 0 on success and an appropriate error value on failure.
>  
>  ::
>  
> -  int rpmsg_trysend_offchannel(struct rpmsg_channel *rpdev, u32 src, u32 dst,
> +  int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  							void *data, int len);
>  
>  
> @@ -284,7 +288,7 @@ content to the console.
>  	dev_info(&rpdev->dev, "chnl: 0x%x -> 0x%x\n", rpdev->src, rpdev->dst);
>  
>  	/* send a message on our channel */
> -	err = rpmsg_send(rpdev, "hello!", 6);
> +	err = rpmsg_send(rpdev->ept, "hello!", 6);
>  	if (err) {
>  		pr_err("rpmsg_send failed: %d\n", err);
>  		return err;
> -- 
> 2.43.0
> 
