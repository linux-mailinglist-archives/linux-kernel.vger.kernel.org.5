Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634187A039F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbjINMTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjINMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB3B1FC0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694693913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m16z/ewKg95tn0la0oT2JApF9/p4f/9Xhfy6GUGRCOQ=;
        b=a+bt7OMiYjHEpE3AlHftal/GpvyGudzInjYpPtVqwaHDR74NYIc0yhEeg4uPhpOk9pYOqC
        zRuoW5cyF5YqDEomxHX4vvdakH0Ly5/YoRUAESqHu3diHW27EIKFJgHFeRB77TIRfjcsS3
        bsOdGKi3dByYXktr9uZpWIKbVQ2vw8Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-1VCuauvkMpe93HRVcQwUfA-1; Thu, 14 Sep 2023 08:18:31 -0400
X-MC-Unique: 1VCuauvkMpe93HRVcQwUfA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4121c086963so9090011cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694693911; x=1695298711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m16z/ewKg95tn0la0oT2JApF9/p4f/9Xhfy6GUGRCOQ=;
        b=dCXy6Mpbd3B9XIDVtA81oMTWA5GhfeOn8VdoWUJELrtV0rMo2/+3Xx6jT6YTDS8JDj
         v7OsF+lat/YohjEJPc8jsM0rGs+6WHQlqCMKKGLKO6aev/7nZlQ0qVN7x+E3GA07QpvT
         hpcwYlgs+uhmXjXtxkBnlSzGsN845oVLvDuEtUm1g+wLE03mWtgAU7j9YjddhT+WIzv1
         +94/1oqo7qUmEazh39r7T1cUQKmhJbaJ3gj0HBvmYD9AuoscZU3v3lASDpI23hOSPGPz
         MWMn4ax9ZGq/lRXZ84NUfSqazmPc0cguKKZX5Z74ZkmW/YA7SPO6yTPMBJedBVBKeScD
         yXMw==
X-Gm-Message-State: AOJu0Yx4yQ3/n5y/5Ewkzg0jT5/6kjEDXURLUxyt8rZpZcndRQ92WVSi
        innVxbhfcVoa6uTPSh4fiBPJirpIKZ2GF2X/TiBM32eo9I/7DA8fwTlxtePd4tmg9/cT7sxareX
        8+iJbU/3HUCgRA8OP6vxfsX41
X-Received: by 2002:a05:622a:1b89:b0:412:6e6:b45b with SMTP id bp9-20020a05622a1b8900b0041206e6b45bmr4606195qtb.38.1694693911313;
        Thu, 14 Sep 2023 05:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYwG9newgxoh8ajW4pGLxXSkaK0lHXU3KRPfceQZ6yon65N2SSR0jrRAhaTv6Z1H8bjQH/Qw==
X-Received: by 2002:a05:622a:1b89:b0:412:6e6:b45b with SMTP id bp9-20020a05622a1b8900b0041206e6b45bmr4606184qtb.38.1694693911083;
        Thu, 14 Sep 2023 05:18:31 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id j14-20020ac84f8e000000b004009f6e7e7csm417491qtw.31.2023.09.14.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:18:30 -0700 (PDT)
Date:   Thu, 14 Sep 2023 08:18:42 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 9/9] bcachefs: Modify mismatched function name
Message-ID: <ZQL6ItDgXFgJyU+M@bfoster>
References: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914090457.32325-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 05:04:49PM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> fs/bcachefs/alloc_foreground.c:514: warning: expecting prototype for bch_bucket_alloc(). Prototype was for bch2_bucket_alloc_trans() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6584
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

JFYI, it seems like the patch series is oddly threaded with patch 9/9
being the "cover letter..?"

Also, what's the granularity of the patches here? Per robot filed bug?
Per source file? I don't think it really matters for this particular
series, though personally I would probably squash these down into one
upon merge (and prefer to see any further patches of this nature
similarly condensed).

Brian

>  fs/bcachefs/alloc_foreground.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/alloc_foreground.c b/fs/bcachefs/alloc_foreground.c
> index e02749ddc362..10a7979707ef 100644
> --- a/fs/bcachefs/alloc_foreground.c
> +++ b/fs/bcachefs/alloc_foreground.c
> @@ -502,7 +502,7 @@ static struct open_bucket *bch2_bucket_alloc_freelist(struct btree_trans *trans,
>  }
>  
>  /**
> - * bch_bucket_alloc - allocate a single bucket from a specific device
> + * bch2_bucket_alloc_trans - allocate a single bucket from a specific device
>   *
>   * Returns index of bucket on success, 0 on failure
>   */
> -- 
> 2.20.1.7.g153144c
> 

