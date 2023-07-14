Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604C97537BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbjGNKQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjGNKQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB82708
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689329689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VDPdK5Oor5Kw2bqZn3fIKe7+JBJ69095qwlRLBTDYJc=;
        b=P/y12WEDXtw5lGtPOgdQUxRTkUvOgTk9sZIUuiEfi73+6FZ/uPw3Cxzf7D/ecyEl9JdKGE
        d9w9E4e+EnUZ1h+48afm8aQVCuAktPIytyU5CytDwT1X9B0+E0JhhnPYmSFxW/aEU6aMrr
        Ab7g8lL7diCteBtXXWIE32AYE7XMDc4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-KdZTUNPQPFmT2RsUlc4CBQ-1; Fri, 14 Jul 2023 06:14:47 -0400
X-MC-Unique: KdZTUNPQPFmT2RsUlc4CBQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbe590234aso10075535e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689329686; x=1691921686;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDPdK5Oor5Kw2bqZn3fIKe7+JBJ69095qwlRLBTDYJc=;
        b=ex5kr2PkmvtRU7+hdNKTNJMMs6OKCSB09YsZQWmC7hmyrLD0EsI8UT/OZwMIE+cTbt
         kyQuiUbqbAwcb7E+9qZl9cUxfHlF+Rb0W7hrbasCiJnveQM1R4wDfcKrRIu7x1MX36XA
         iKxnW4TW3Rehix768w6HxhBUHapfd5x1/75yXgsTjdLpbTSSt/9RaX9SF/9/kJmEF/b3
         JYRpQ/BTTh7xecMBIOb6s3x8bR8erQ/e/sPft82LvzJaiszlovxpDxt9ZkAxRvxqtR07
         0+Jce7zzSKI1Bb7OwV1YhGnx6jEWEJq14URHKC4Fzm6YtCyEbre+iVtPdUR23stuHvSn
         Ejbg==
X-Gm-Message-State: ABy/qLb3c+LopiImQdxH2CnIvmCogWcvULlpMyPNW/WnB5Ds6lP+s2tl
        dXXfCOny/VWEdHf4vGEbrGKcndo2Jd8XX9uGNOFIQzPE/NbZ8Yx38hSeD4Fs1zEikUp27rBShSu
        YguIgPgOl74vTMLTmywp2tyEv
X-Received: by 2002:a5d:4acc:0:b0:315:99be:6fe4 with SMTP id y12-20020a5d4acc000000b0031599be6fe4mr4197170wrs.69.1689329686469;
        Fri, 14 Jul 2023 03:14:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFWG05PEub0RlJ3ldMFlpn9gHopzRMDXENCQEZqn/pCYz8EFuUfF/KoRBPBx6rx56Ah0A3k1g==
X-Received: by 2002:a5d:4acc:0:b0:315:99be:6fe4 with SMTP id y12-20020a5d4acc000000b0031599be6fe4mr4197153wrs.69.1689329686102;
        Fri, 14 Jul 2023 03:14:46 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id z13-20020adfe54d000000b003143ac73fd0sm10526624wrm.1.2023.07.14.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:14:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/8] drm/ssd130x: Add support for DRM_FORMAT_R1
In-Reply-To: <72746f6d9c47f09fc057ad7a4bbb3b7f423af803.1689252746.git.geert@linux-m68k.org>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <72746f6d9c47f09fc057ad7a4bbb3b7f423af803.1689252746.git.geert@linux-m68k.org>
Date:   Fri, 14 Jul 2023 12:14:44 +0200
Message-ID: <87ilamu7e3.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

Thanks a lot for your patch, this has been on my TODO for some time!

> The native display format is monochrome light-on-dark (R1).
> Hence add support for R1, so monochrome applications can avoid the
> overhead of back-and-forth conversions between R1 and XR24.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> This work interfered with commit 49d7d581ceaf4cf8 ("drm/ssd130x: Don't
> allocate buffers on each plane update") in drm-misc/for-linux-next,
> which always allocates the buffer upfront, while it is no longer needed
> when never using XR24.
>

you mean R1 here, right ? It's still used in ssd130x_clear_screen() though.

> Probably ssd130x->buffer should be allocated on first use.

Yes, that makes sense.

> And why not allocate the buffers using devm_kcalloc()?

I think there are some lifetimes discrepancies between struct device and
struct drm_device objects. But we could use drm_device managed resources
helpers, i.e: drmm_kzalloc().

> ---
>  drivers/gpu/drm/solomon/ssd130x.c | 57 ++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 17 deletions(-)
>

[...]

> +	case DRM_FORMAT_XRGB8888:
> +		dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
> +		buf = ssd130x->buffer;
> +		if (!buf)
> +			return 0;
> +

I think this check is not needed anymore now that the driver won't attempt
to update planes for disabled CRTCs ?

It's OK for me to be paranoid though, specially after the other issue that
you found. So I'll let you decide if you think is worth to keep the check.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

