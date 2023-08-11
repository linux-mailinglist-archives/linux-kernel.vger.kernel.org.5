Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5B7792CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjHKPTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbjHKPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5B3A92
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691767101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jvk9gOBrnZNGwTR3Eif+kJzbn0hYBEZnzfA7q6zH3g=;
        b=F5u1aP+NgQnqLZjsSnNk3Chdt+3lNN6K0r3bC7woXyss4/4djUU4y5UjeU45AiJtW6+y+F
        ULsVFrhnYkprEkZoKZU831GXOj77ZNKnEKpE208LY66Zw67kxUzMRQ2AQ6FzzD8dkQBNLy
        cenZ8T4e1hujnPCG3qk4kSE0fPRMCmE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-tFdZRDGSP4qjKYmgaQY1Zw-1; Fri, 11 Aug 2023 11:18:19 -0400
X-MC-Unique: tFdZRDGSP4qjKYmgaQY1Zw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7913a5d6546so167072639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767097; x=1692371897;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jvk9gOBrnZNGwTR3Eif+kJzbn0hYBEZnzfA7q6zH3g=;
        b=Z0dfzW+pfEwE8v2x4xWY40zPWYZcUtXIFp7yfiMMdt6ECpChID/mH2Spe4vubawgAH
         p38nISkAY0lIzXWDixEew1mMZn+82CU76XOmlpanjj/FPzA5nGV5rErA3nAk/+WN7+1k
         KJERZ0sON8ALTL/T2TAxKttNgSFgM2tZ3kfISlukrL0lyb6reo3PxPqIJ7GkqMHu/ru6
         tXyauOa2yoT+olLxclsmB5S/xGnryevQ6LhJRsSUzEIfKs2B8zBoe/CPz3q08CiqzTsF
         BMf5Iyl2WMLk9XeaeYwifAKiJD6wjS1YZ24v1YMXOfI3vgCQG6rU6+uEnjEHCtZdP9X1
         GH1Q==
X-Gm-Message-State: AOJu0YzXQmvJBGIVm492FXSWpRQvCYYyMBtS6Bk8K4dEP82Y8xjs3SjP
        fxjYAJViCiQcsLUN+E8wDmGmam2kIlwNw/kaNfHGliBzxFMlYVh0f36AdRsRAx6TwD7JVws1QrX
        qRaOVcCpg6FsqLH3GEEQp3/4AbG2ck5ed
X-Received: by 2002:a6b:e617:0:b0:787:6bd:e590 with SMTP id g23-20020a6be617000000b0078706bde590mr3051928ioh.3.1691767097170;
        Fri, 11 Aug 2023 08:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKw28KuDhVAyNPv6MlOEjB1eJ9SY9VxRRQMppZ4UgGp6JYUxVHXcfayh7m4Drb+Z4OuccpNw==
X-Received: by 2002:a6b:e617:0:b0:787:6bd:e590 with SMTP id g23-20020a6be617000000b0078706bde590mr3051912ioh.3.1691767096942;
        Fri, 11 Aug 2023 08:18:16 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id u12-20020a02cb8c000000b00430159b03f1sm1122994jap.93.2023.08.11.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:18:16 -0700 (PDT)
Date:   Fri, 11 Aug 2023 09:18:14 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <diana.craciun@oss.nxp.com>
Subject: Re: [PATCH -next] vfio/fsl-mc: use module_fsl_mc_driver() macro
Message-ID: <20230811091814.1808a01a.alex.williamson@redhat.com>
In-Reply-To: <20230811092911.894659-1-yangyingliang@huawei.com>
References: <20230811092911.894659-1-yangyingliang@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 17:29:11 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> The driver init/exit() function don't do anything special, it
> can use the module_fsl_mc_driver() macro to eliminate boilerplate
> code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Your colleague submitted a nearly identical patch, but also removing
the redundant module owner, 2 days ago:

https://lore.kernel.org/all/20230809131536.4021639-1-lizetao1@huawei.com/

Thanks,
Alex

> 
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> index f2140e94d41e..8053f13c2be5 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -604,19 +604,7 @@ static struct fsl_mc_driver vfio_fsl_mc_driver = {
>  	},
>  	.driver_managed_dma = true,
>  };
> -
> -static int __init vfio_fsl_mc_driver_init(void)
> -{
> -	return fsl_mc_driver_register(&vfio_fsl_mc_driver);
> -}
> -
> -static void __exit vfio_fsl_mc_driver_exit(void)
> -{
> -	fsl_mc_driver_unregister(&vfio_fsl_mc_driver);
> -}
> -
> -module_init(vfio_fsl_mc_driver_init);
> -module_exit(vfio_fsl_mc_driver_exit);
> +module_fsl_mc_driver(vfio_fsl_mc_driver);
>  
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_DESCRIPTION("VFIO for FSL-MC devices - User Level meta-driver");

