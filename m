Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9064F7888E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245254AbjHYNqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245320AbjHYNqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:46:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F09268A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:46:11 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d66f105634eso895299276.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692971170; x=1693575970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoBf9yEiYNSj7LpWNz2WUTLupdyL6E9irB0nHYwcJ0Q=;
        b=hj2qsrqISzlnPtcNvVuxksoGTMp3sBJyat9urrboVW2ESgFm3sB4EfTBbI8YzsQ52y
         kHlGCdbsY/sfTt11BN/i0jLk7QaFnlx0NjWpxVvlG1y0luycwGyIVJceWrOC4Nk4m9lS
         53n2FNS9oU5YcS19a9JjqXlyGFB3tCOkLxeqCJWKouTexAcsnjW8SUDL6u8WDwPZCHpO
         l+c/RrU9x8k7fSFm5ME43x9KqIuSTdfLiN6fmlJdoot52532PDJZWQJ8bQ0cHH9G4ta+
         zw8tfE6gpE4E79HaX4g/Rs2MH3slF5tPwiWbVFT1P3tNuZpL3+Ro62j/djTeAkEaGyi1
         GevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971170; x=1693575970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoBf9yEiYNSj7LpWNz2WUTLupdyL6E9irB0nHYwcJ0Q=;
        b=Sm2pGYkYPqp6nWfYJILWP08VWG0rgtgCa5j0TzQCgqwc+bULngzsnEmZrzh9jwUlL9
         HeokHo7rLvVTXnT3SS7voC6JG0tUOy9coyifxjeY4nabQXCjqaj3e9iB3oMlRC7vHc+E
         Kkex0GDUFROnnr6g8EEgulLXGfBcURs3ec3ardiRJ0UTT89k7VAH92wE73WF6CpQh/fs
         OGQt3KLYOcDr4Vesj/+MurCv+0R8i3dlU7OtbnJPGE5CKS9r/EhNG9YTVB5q4w6phgp7
         muHj66UjllLV8+mEycV6nQaQjA3zvtRpGLLMDpm37LCVliYDXe2urX38BI9/0oYhj4GR
         a0uw==
X-Gm-Message-State: AOJu0YwwRk9+c5nnvZnrKluhO8aOsmjX5EqQO6LKyJUx+IGlbUE4Zc1p
        xriFYVwiHKmgeYg0TPb+bMeAMJ5wtEQcAT6BAzLAUA==
X-Google-Smtp-Source: AGHT+IH/VwYzbXaobNFegA4uRBSoYdkmZzOyLTtqlc1smsTkPCb3hCVybf6SyGIk+P3Z7lKcYCGDhCZifehJAa7n4EI=
X-Received: by 2002:a25:ce03:0:b0:d72:4395:38c1 with SMTP id
 x3-20020a25ce03000000b00d72439538c1mr20201071ybe.50.1692971170404; Fri, 25
 Aug 2023 06:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230824083550.49539f4b@canb.auug.org.au>
In-Reply-To: <20230824083550.49539f4b@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 15:45:59 +0200
Message-ID: <CACRpkdYM8Rji5muAnik_hEeBvzdhL9zrfbi3zDCjSLw=F7u1Uw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 12:35=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:

>   - SHA1 should be at least 12 digits long
>     This can be fixed for the future by setting core.abbrev to 12 (or
>     more) or (for git v2.11 or later) just making sure it is not set
>     (or set to "auto").

I fixed it. Thanks!

Yours,
Linus Walleij
