Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB707AC65A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 04:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjIXCxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 22:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjIXCxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 22:53:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C7F124
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 19:53:42 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a76d882080so3010321b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 19:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695524022; x=1696128822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/d9b/PeADBzIfI3pWZpLK3xrhqpPASs1Sf8duAT6F0E=;
        b=YLqJ6ECN2eQnUTmHlZCt/ErWq7nPAWXVCe/o4FVh/UpzZcaIDQBpgWB4c7gn1m9E9M
         3T7NJOBFoBPd7A7IjBOEbbaE1BEmesmgRKuNNlHE5BvHp7vvnnuyfAGrZBb/H4I+BGx+
         Xpc/Qu49XLGMk5rvPtHyOyEjutf8VcarmdMOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695524022; x=1696128822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d9b/PeADBzIfI3pWZpLK3xrhqpPASs1Sf8duAT6F0E=;
        b=OQ/igJei1nLv8V0dyKR44I/fpAFPb3dRePxo+kMZJjLNbEAgvBC2QU8X0qypd8vK7F
         0hT8HHYHL1p9ux1hz09CCjUGA6+/rYYB00wruh4WLKLnQz8PpsTWBeKpBLUhkujmHQxg
         YdtwtdQFsA14bYMc6EQpmcHmTfSpACfyj4oR03dkoAxhkeVfiovaLweYb1EMnByx03ne
         bVvSsYnB1UtyRz07OjJMDzYAnTkf/RYkSDN0sCZF9UjEXTbal2Qx5fNdhy/lPHs44SDF
         EPR7hHwnQqQDkuY8WIxJsndOmGTV5UY8+ZqML9Q8jD8h+jXbkFX2T4bJrS9HTSNpBJ6t
         /JUw==
X-Gm-Message-State: AOJu0YylBM8ACIYMy4c4jhGtEOCW/3iepre8XAQMd5KQpFPkd3zC9rLD
        epzuDUzX5KnQAYuT83uEHPXIeg==
X-Google-Smtp-Source: AGHT+IFC6DSYvUj9536i9d90/GS4ktpilI0BoWD5bQsotIoh2JHoAVTBOKOCB9AQfdY2ieUWLZZx9Q==
X-Received: by 2002:a05:6808:f8c:b0:3a7:366f:3b01 with SMTP id o12-20020a0568080f8c00b003a7366f3b01mr4444965oiw.33.1695524022174;
        Sat, 23 Sep 2023 19:53:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b001c55e13bf2asm6022710plf.283.2023.09.23.19.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:53:41 -0700 (PDT)
Date:   Sat, 23 Sep 2023 19:53:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>
Subject: Re: [PATCH v2] drm/etnaviv: refactor deprecated strncpy
Message-ID: <202309231952.6E01CF3589@keescook>
References: <20230918-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v2-1-8ae12071c138@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-strncpy-drivers-gpu-drm-etnaviv-etnaviv_perfmon-c-v2-1-8ae12071c138@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:34:08PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst maintaining
> the NUL-padding behavior that strncpy provides.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Bo YU <tsu.yubo@gmail.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good to me now. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

(Though again if you need a v3, making the Subject more specific would
be nice, "...: Replace strncpy with strscpy_pad"

-Kees

-- 
Kees Cook
