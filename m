Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8507B3BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjI2VOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2VOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:14:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FF01AB;
        Fri, 29 Sep 2023 14:14:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so1981309066b.0;
        Fri, 29 Sep 2023 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696022058; x=1696626858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCiSP7da6dKIVaXYl+J/yofIbbMGcrO8k/37XWQQNwI=;
        b=Crkf6RvAP6A5wQssikxRu8KClqvkX/3qwcQnf278xKA14/bPfOuTN+wcSUHWMbJgke
         fzaBp/gYDosKsLQtH7GSJaBH2AgE+m2r0qbJfdVaNi7DupKGdLwKJ9Ky13reRuvNc5q5
         nh8d9xXJ4tD0+Jsuuy0COq27X3jM9LMdNSTPwYxztotWeo+9qH4lP+VPfLG0tIyHGinT
         08jMHXQIhfnOlo3dGO8VKhaSZkoW+NBclb+E4lJRhZQQZns0svZQE+A4QLAp74Kp8HVx
         K+VqKSUt43t4c42VAA+PoYIbID+Cd8KiJen9waKv6GiVHbPKwxrbr1hAwxt89s8NVe5w
         QhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696022058; x=1696626858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCiSP7da6dKIVaXYl+J/yofIbbMGcrO8k/37XWQQNwI=;
        b=UK01WDC8k5ulVCMwJz6FpCvWWvJRlfup40E2QnIADSkxhGR4IAk4S5MKBmBOB0RAFp
         YU2XjB9wJy4iReXs5y7fU3lQmTdQYMAI1pyAPK7e4ORQNv8ghmk9UjD6JgwdiITLfwAz
         XxLHTgagNsrDX5F/Dex8kD1vP0TaNmG/do8ltJl0O6VSK86W2x/3nwS0qb+cjEXeB/CK
         vZreAhM0TZy7gAHI7lXWk1ACztrh+lhOJeYqAU29aMdkeHB7kcUys5Nx0t7L4tFvSBgd
         G4hW571smxUUh2siaaBUGAgq8mLnDCoMAKuupHiKn5G2pEWAjP0gJt96MFZUMfyL6ikY
         s3DQ==
X-Gm-Message-State: AOJu0Yx3IIYk/mXvikFhymncg98mDOKRqMJaD8wiD6la0fz+1+D9ojHC
        D2PR7BIOavyOTgG+Jv0ahMU=
X-Google-Smtp-Source: AGHT+IFM1wsL2knvOz7Q0hswor0QTx2gj0akK4JwiiMBw6U8vA9MMI/AJosKPrLpN+4NkuTI6n+gxQ==
X-Received: by 2002:a17:906:209e:b0:9ae:829e:d930 with SMTP id 30-20020a170906209e00b009ae829ed930mr5670424ejq.9.1696022057599;
        Fri, 29 Sep 2023 14:14:17 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7df8a000000b0052284228e3bsm11640256edy.8.2023.09.29.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:14:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 29 Sep 2023 23:14:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/tdx: refactor deprecated strncpy
Message-ID: <ZRc+JqO7XvyHg/nB@gmail.com>
References: <20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com>
 <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169601242377.3008066.9973846266706309040.b4-ty@chromium.org>
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Mon, 11 Sep 2023 18:27:25 +0000, Justin Stitt wrote:
> > `strncpy` is deprecated and we should prefer more robust string apis.
> > 
> > In this case, `message.str` is not expected to be NUL-terminated as it
> > is simply a buffer of characters residing in a union which allows for
> > named fields representing 8 bytes each. There is only one caller of
> > `tdx_panic()` and they use a 59-length string for `msg`:
> > |	const char *msg = "TD misconfiguration: SEPT_VE_DISABLE attribute must be set.";
> > 
> > [...]
> 
> This appears to be trivially correct, so I can take it via my tree.
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] x86/tdx: refactor deprecated strncpy
>       https://git.kernel.org/kees/c/e32c46753312

Please don't apply - Dave had some reservations, plus after the
change the comment would be now out of sync with the code ...

Also, we generally carry such patches in the x86 tree.

Thanks,

	Ingo
