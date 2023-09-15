Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFBB7A14FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjIOE7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjIOE7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:59:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FDC271B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:59:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c336f5b1ffso15500275ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694753967; x=1695358767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYRpyQlIT436zPtN6nLdUj+VpyPz7BPfenc2yhNBnyA=;
        b=kn7dvYybNkJRobdb6fmVvLdZR+A3XSsfiz3ovZfnaJDL2Z/QnZrbeZhtiDMdt5UXdw
         TSE/dgk83EnytXgxVcR0hz1lnKV3LxJDl76Q745AC497I6ms0PvLpczFecuaefaUwp9G
         7IZD4tu2bOPTZRpTjpnH2RM3IhY+BeZQ9FRYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694753967; x=1695358767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYRpyQlIT436zPtN6nLdUj+VpyPz7BPfenc2yhNBnyA=;
        b=GTSnjgozHgGjBu6LwwCssjqSkH/ZJMxAFpXd+ug4LgnY2XOh26bC6GExY7nqRprjjG
         Or/RxqJ9St2+kPRpI3ATPffpSLX9a8LuiIm6Hrk825I4nDz15uyrKGKC1yUJe7uPt9t7
         zDmN6quPKyGwIqguS/PkfGOf4w7UwqBL4w7lCtAUBQ3kNjmMFgnTopnUXyXitHi7sXrz
         p77JGDDxJ/6xrM48SbKNP27AZ0oZHsarVj8t3+5/5PP9RijXz/mc2yaQXHng025wFD8g
         1KesF6LhFs4nIqMDoJ7I9RKNH54hUw1vCdoWYi0P4+WNnCHxelEdI7ACK8+hLGxmmqMH
         OjlQ==
X-Gm-Message-State: AOJu0Yx7Cn2FTUqtWxN9fd08L/xmSuTI526jfFVVVi3EreqD5lYrIQkz
        FpolXtBaFetSv60R5ZDYuV462Q==
X-Google-Smtp-Source: AGHT+IHpnSwhbI66lN4Z3sU7pXA6O9Wq2OcHhE6YgrndvyVXYXJ9PNFRMH9fyCLkUgX/bGvjpC5C/A==
X-Received: by 2002:a17:902:7081:b0:1b7:fd82:973c with SMTP id z1-20020a170902708100b001b7fd82973cmr618871plk.39.1694753967460;
        Thu, 14 Sep 2023 21:59:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p21-20020a170902ead500b001c0a414695bsm2461749pld.43.2023.09.14.21.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:59:26 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:59:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/pm: refactor deprecated strncpy
Message-ID: <202309142158.59A6C62F@keescook>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:17:08PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

The "- 1" use in the original code is strong evidence for this being a
sane conversion. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
