Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E29D777279
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjHJINR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjHJINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:13:11 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2A10DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d45caf42d73so595333276.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691655190; x=1692259990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUKzUe/YyFhhVGKQt0xdm9btYh3sRyVbNPpkYzJKMoI=;
        b=bRY2YoCod9u62sIwPgfgb8aYWgek9jPHcXp/hxWWgqGtQZUuDjFZtEEVF5lxydclBF
         nJoKdEVwqq7ihD0E61B3Y9TFFo82SHbFLUT4OCD0iNB7PUqR3EX1LzumZmNdnfTz6hNe
         4E6TgvY+LhWUJ0tl8jT6T9Z7R89Pqfc6QI1kvmWnkv1pNmk4YdmkeocN4GDvYqghdGXP
         C+umo72eBzANdsdWP6pDHj7RFbRRiQ7gEzJjIe9Zc+8vxuy9l3lrA4Wc6CBbGZXuE7jI
         BB960HaGQynFykhVXAkdQ7UjNnjgRPgw/I9CojZ+uOPW8khcdbtMvb9OKicDwYxRX88w
         8i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655190; x=1692259990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUKzUe/YyFhhVGKQt0xdm9btYh3sRyVbNPpkYzJKMoI=;
        b=EmWAHi7UUBrEniZz8AVV23Yqh+A5ReWzASjg9CmCoH1l84B2kk6DD028duudGQXsrG
         k+IYbNeDvkk2u7iHScNwrBshFKW+Prhy4eduV2u6XlEm4CC8HRJSuCnsMLSbHKBCQfnq
         mgVJbOU95MOU/1idoN4FYa3RsBUBhex0TGCJROBFcCS7nDnMVLI0xh5o10XqyRmiIWrs
         UDSgzGWUmPTppj6pCjGNxiOqj/AHOKAul6lgg7myb8XNzEe5EBoF7cs97e/LbC0VqeTd
         vj1vndj+0oFVW9hssv23pWDk100qCl9NJtE8Mk4ZF+NNL6j5ZpEprSbRWGLNkYckjEcv
         g+fw==
X-Gm-Message-State: AOJu0Ywql7c9y2AqC8PkQ/oXQey1M7w/f1rWx7jR1mXOTpdwSSJbjJwn
        /laZIg+UXLgFGIWPSAIyckvfra2+TRz74tadxSIK6Q==
X-Google-Smtp-Source: AGHT+IECw31XWKd+U7j9b/LiSbo9opwGRS/q3/tik63UV+snDZRshYv6V4za3/FUyIWHMnbBx5WXpxOt6SS1GhjOoL4=
X-Received: by 2002:a25:ac89:0:b0:c5d:f2af:5a24 with SMTP id
 x9-20020a25ac89000000b00c5df2af5a24mr2106757ybi.14.1691655190358; Thu, 10 Aug
 2023 01:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230620104349.834687-1-valentin.caron@foss.st.com>
In-Reply-To: <20230620104349.834687-1-valentin.caron@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:12:59 +0200
Message-ID: <CACRpkdYfPin4hAdPxUT7v20qeq3TeqQ9k-jtZLZCvRy0eZ7h1A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: set default gpio line names using pin names
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:43=E2=80=AFPM Valentin Caron
<valentin.caron@foss.st.com> wrote:

> Add stm32_pctrl_get_desc_pin_from_gpio function to find a stm32 pin
> descriptor which is matching with a gpio.
> Most of the time pin number is equal to pin index in array. So the first
> part of the function is useful to speed up.
>
> And during gpio bank register, we set default gpio names with pin names.
>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

Patch applied!

Yours,
Linus Walleij
