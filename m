Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6127AC681
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 05:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjIXDhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 23:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXDhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 23:37:08 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632FB10A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:37:02 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c4e30a3604so188076a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695526621; x=1696131421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YGwlZ8VYRbph25A8ZUwhbUOkgjuB1L7dZb4bEWDxTM=;
        b=fZSt2AkkJ+oF2xyOjmzFxg4Wcvw1EgKwVZqbJ3ER5PDmzvq4MFmiMZfxvhknpfWPJ/
         9rEVo4a7x9O2gakRVXLoL7XRAodeqGrRL9tcJwJ976z4GYNbPcQGJac+V6h54CN1eq/Q
         7QU+GJnyoqNzHvDwzSB3OPvqkXGRYE4hqK5fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695526621; x=1696131421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YGwlZ8VYRbph25A8ZUwhbUOkgjuB1L7dZb4bEWDxTM=;
        b=QlCQtZcYlKSeUG6ENmjvZZKWfgwgOJGHb5Tz7RS77OB9TMVcmsOCEsYHv3nkOFZ+o6
         HCIKZeAYki1tBORHzNQYK+OQBFd7Pe+0kT9A4g8T96GmoxywfQxPaYL9pk7X0vBwOL0B
         cXn3Ajv2/7zh1SKWBDP9FXvDXSx5NR7XCDzkN2gGRWkzmNy1c9ATBblbHUqY2fnSDWPe
         z2vWqgREYNtAwL/Zg8151h8sZoJxFwgV4JoJy03LlKLd24XE0JVWUQmTIZwehSiormvg
         CRGEI7zacv+t0rVdH6gMgb4sV2DP0JmlWMI7zXKfgTm3NS/1LG+0ztIq7quABYvVl1kk
         3wDQ==
X-Gm-Message-State: AOJu0Yy2ORHbfgtYuv1KDcW9dem/S+UfLJIlX7EGItFmvknktuDdqAza
        q5i6K5/EaP1uFWw19+brenyRNMP4Gj+OYkrmEZY=
X-Google-Smtp-Source: AGHT+IHGvXtZMAzyJXO8XVi5BpOg1ItWln8tC/mFF0KbOa2hwtha80KVkI6q/MoCj1OIZSeFEffF3A==
X-Received: by 2002:a05:6358:341a:b0:134:c859:d32a with SMTP id h26-20020a056358341a00b00134c859d32amr4772563rwd.25.1695526621603;
        Sat, 23 Sep 2023 20:37:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id oa10-20020a17090b1bca00b0026b46ad94c9sm5684837pjb.24.2023.09.23.20.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:37:01 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:37:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Karsten Keil <isdn@linux-pingi.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] isdn: replace deprecated strncpy with strscpy
Message-ID: <202309232036.32C3C37@keescook>
References: <20230922-strncpy-drivers-isdn-misdn-clock-c-v1-1-3ba2a5ae627a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-strncpy-drivers-isdn-misdn-clock-c-v1-1-3ba2a5ae627a@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:58:06AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `iclock->name` to be NUL-terminated based on its use within
> printk:
> |	printk(KERN_DEBUG "%s: %s %d\n", __func__, iclock->name,
> |	       iclock->pri);
> 
> `iclock` is zero-initialized and as such is already NUL-padded which
> means strncpy is doing extra work here by eagerly NUL-padding the
> destination buffer.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, looks like a clean replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
