Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4BC7D0BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376757AbjJTJfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376750AbjJTJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089AAD5D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697794490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tAB7Iz32RgXSddcXY/V5m8QJyFvIuwe2gAktuOJNjXM=;
        b=FPcMcYHFdDSjNMsx+rQygzJ2eC5cx5CeBL73Nz6Czxi0RyK1txQQB5GodY9CKV2RzUmode
        z4Wnd3GhCG4sqhG6mVlAmWO3avr9bFbhBEGJaEwjoeK8rBgbHU1GEJe4hoqQ+4+mqhEyrq
        N8ztSABdJsgpd60zQFdMdO4yYOAn3bI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-EUcvNctrMjuL_KOxFspCNA-1; Fri, 20 Oct 2023 05:34:37 -0400
X-MC-Unique: EUcvNctrMjuL_KOxFspCNA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4083a670d25so3915635e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794476; x=1698399276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAB7Iz32RgXSddcXY/V5m8QJyFvIuwe2gAktuOJNjXM=;
        b=kujPYKw+JAcgmphCLQThK1lRNtjLQW78+GEyuKyTWIFq6ZV7EZtgJXLfGPwETpSFpZ
         Q0S40Ffov/XJ39G5EgxCHVp6N8mkbq7vpD6MAiKspxH78VhKrn68hGDzVomxcb0RX3Qa
         KXKW6bKJkZwZyxIfulpFDYz/n8hHivH9/ZWsGxlotGYO0DFYSdJKyHRs5opGIF0MmG31
         XcROCPQwyyrwYyajcUIC7p92nWAoFI0z3kJL4i0pnJMFtdnq4iRHFIyRM+MhsUehegLq
         N9T+sQFg8bDSs62lcz+jCAe1qvzlKQQnC9zytaljlV6iHLTan3zYVUgpwCcJmuThIVxz
         XfCQ==
X-Gm-Message-State: AOJu0YwT4Pj5W5e7S4cg6Sklq1ySJUp+9Z6PocM0XQfw++BNMyvE46QB
        SKA14KPmaU22aPjF7be69yb4GblOTz0Ggd0n0wrFvJaCpGYyroPuV74WszeBeJ6jeeoznU+iE9M
        zgRvuyfh/5gJcUvevBlNwtwh6
X-Received: by 2002:a05:600c:3111:b0:406:8491:ec2 with SMTP id g17-20020a05600c311100b0040684910ec2mr958414wmo.15.1697794476062;
        Fri, 20 Oct 2023 02:34:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4API/mXl60/J/SzspOM0lDrt9ZQKAaYMDD+MpiY1h5LWvzInLOfYWTEBlY+tciVYRMLzAyQ==
X-Received: by 2002:a05:600c:3111:b0:406:8491:ec2 with SMTP id g17-20020a05600c311100b0040684910ec2mr958402wmo.15.1697794475694;
        Fri, 20 Oct 2023 02:34:35 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm6420179wmf.5.2023.10.20.02.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:34:35 -0700 (PDT)
Date:   Fri, 20 Oct 2023 05:34:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231020053047-mutt-send-email-mst@kernel.org>
References: <20231020092320.209234-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020092320.209234-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:23:21PM +0800, Su Hui wrote:
> virtqueue_resize_packed() or virtqueue_resize_split() can return
> error code if failed, so add a check for this.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> 
> I'm not sure that return directly is right or not,
> maybe there are some process should do before return.

yes - presizely what virtqueue_enable_after_reset does.

Error handling in virtqueue_enable_after_reset is really weird BTW.
For some reason it overrides the error code returned.





>  drivers/virtio/virtio_ring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 51d8f3299c10..cf662c3a755b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	else
>  		err = virtqueue_resize_split(_vq, num);
>  
> +	if (err)
> +		return err;
> +
>  	return virtqueue_enable_after_reset(_vq);

So I think it should be something like:

	int err_reset = virtqueue_enable_after_reset(_vq);
	BUG_ON(err_reset);

	return err;



>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
> -- 
> 2.30.2

