Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C24B79779E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbjIGQ3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbjIGQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:29:32 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65456583
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:27:01 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-412195b1e9aso8254701cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694103930; x=1694708730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KplJiPzBxNOpapXXXI8tqe4hm+W6bB0cw/mtgdg+JQc=;
        b=FgO/FUL/I+h5Gmk1NOka86TypujCKS9hDzUDkddeHL7CpHshzMjC3uq53OZuFdbUw+
         +qO05B7uW1rLTX1zhQeqAU1tt9/uHzs5UlHa+oqP+nLTV+xyd58zv0hWTxv85Vk2nW62
         Tf07eC3XosgR8+o/AF7pxhcvJ6DQDNR2fpaSdrdxhrJUkrF6RIrfnpzht4Kern5Thms9
         +C+7odccMKPmwEmcbxbde97Q+P+lb7QpmEcmbGIiKWSmSvIDqGDufi/QWT7o533fYOUN
         1HlVY/9pcKvFqF/ETC6P33fmSEoEpNXXfaHG161KnkiFEHluIjiCt3yObDs8KSCrukhG
         Yg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103930; x=1694708730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KplJiPzBxNOpapXXXI8tqe4hm+W6bB0cw/mtgdg+JQc=;
        b=l8zuSCvVe4bev4DD1ONpHFjEJRsCebQPXms1aAh3pYsc7sqgRCu6guzB/f7dQfrP2m
         wnm534K+UTB9PdSti+CUQucWjACcZ3PCU4sBjdBUuuwghbXIcDUrd/JETbkOul5L6Rk2
         cHU8L2C97vOYn3gAIFyRiTl9hU6PIHAO+uIAWb3fICdJHSQY4g0wspPfQ8/N8ni3q0DE
         u8Oe1cPnqIwCAniJVHOFKUpHXvHktfw3XYclaCePxzsCvoF1eGs67sZlWcuJ0j4XqNL0
         S6y7eDHcd7b6GPad/6KCtVy8mvsE45xuE6JtaG+GJKr1NHnnLvNuuofapiLYpykLZR1C
         YEeQ==
X-Gm-Message-State: AOJu0Yy0+zHIGmObxlp/Luc0MzBBckazlOTApfQuIOcmZM54HGaqPORy
        iog9i2qAyHU156pjqBjco2vFHQ==
X-Google-Smtp-Source: AGHT+IGcYxYeHKIJTYTxIaKdKv42AR0cUYD5qydh4HN6EPxFKqkEbHOi+6fri8lZqsehxdUgDtzUfw==
X-Received: by 2002:a05:622a:15c1:b0:411:4d2b:67c1 with SMTP id d1-20020a05622a15c100b004114d2b67c1mr21548512qty.19.1694103930464;
        Thu, 07 Sep 2023 09:25:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id fj8-20020a05622a550800b004109d386323sm6255150qtb.66.2023.09.07.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:25:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qeHot-0017CW-Qm;
        Thu, 07 Sep 2023 13:25:27 -0300
Date:   Thu, 7 Sep 2023 13:25:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     kvm@vger.kernel.org, David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 2/3] vfio: use __aligned_u64 in struct
 vfio_device_gfx_plane_info
Message-ID: <ZPn5d8VFAo5PQmpj@ziepe.ca>
References: <20230829182720.331083-1-stefanha@redhat.com>
 <20230829182720.331083-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829182720.331083-3-stefanha@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:27:19PM -0400, Stefan Hajnoczi wrote:
> The memory layout of struct vfio_device_gfx_plane_info is
> architecture-dependent due to a u64 field and a struct size that is not
> a multiple of 8 bytes:
> - On x86_64 the struct size is padded to a multiple of 8 bytes.
> - On x32 the struct size is only a multiple of 4 bytes, not 8.
> - Other architectures may vary.
> 
> Use __aligned_u64 to make memory layout consistent. This reduces the
> chance of 32-bit userspace on a 64-bit kernel breakage.
> 
> This patch increases the struct size on x32 but this is safe because of
> the struct's argsz field. The kernel may grow the struct as long as it
> still supports smaller argsz values from userspace (e.g. applications
> compiled against older kernel headers).
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/uapi/linux/vfio.h        | 3 ++-
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 4 +++-
>  samples/vfio-mdev/mbochs.c       | 6 ++++--
>  samples/vfio-mdev/mdpy.c         | 4 +++-
>  4 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
