Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6D97E2798
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjKFOtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjKFOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:49:21 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80F8D67
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:49:11 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so3886818276.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699282151; x=1699886951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4MAqq03rlcsxc0StZw7VxjL7ypfmXvyq54vttyIPkXA=;
        b=nOkZA9yNf66J3K2Rb3TSeOC0xHXndccNN2zQyhYecVhVglztsd/uQp2mA/3Aiy9cdn
         kVEjoFQBkpMZDAj2VH0TIg7cmcYhOt63LKGqv2NsMugRTjfLzZoc/F9qjf8qIXiNldMu
         Zf2hUGv9/vm1NRDklvHFZLJw38GdRFrH3yRdLREmlh8RuwRdZZGfSZoRUKvNs13yQGZl
         rpxFg0KG8QT9wQ3S+0veHAmfs8ran8yJY0Xs0arwQMD+2VmUhhHJHA6RYGDQ2K9R1yZc
         XL7kAZoZ1eXh+nIV9xSpUhheUEavce5S7RYIoNwusg0LdHLfuHQ2enSUQ60j/8wFQgyB
         JTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699282151; x=1699886951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MAqq03rlcsxc0StZw7VxjL7ypfmXvyq54vttyIPkXA=;
        b=E407dOAMdxaUZGl4RU+CDmnOCFKUoGvIVf9JjeD+yl6r2fAULu6tluss81AKMKnyFt
         tBrjULJq9JUtiad5C7KkL/VZozbDSSW7TZc8496oXAL96g8jKftHL0ENVS9CHdhOE7Bb
         5ouRTRJuIV7WwLyTI1j4zmpTur9iyCC/ByDn84IqxjsXaxEUllTWAR7Ko89WxKt896NG
         smkoO/auF+AbPJvbogGj2Si8UEjGE5+urdwkenQwuqYlbPbnvokpBRKkKa3H214ZTfog
         yERgg4Q9osyWVXPfSWARSnuSpx3n5AZ/4MtMUjf+Q11kmOpKfhay0981xtIMmDFFj//M
         ezJw==
X-Gm-Message-State: AOJu0YzGs1CFB+VP1TpGcjKU75Pha5cjebqkn5IPKUsHG6OZBXS+s3f7
        yfFjEIxx4wj/PXwvh93HWEpmdCAEKHc8evAnLJEEFNzRnNq925WL
X-Google-Smtp-Source: AGHT+IGU74fb4TyBaaI9P8CuZMnMsbExX4WftfwEEZSO556AatiiECmlGmzfMxyvIeX8NrborvtJBPkWvYFREQVgm6I=
X-Received: by 2002:a25:1102:0:b0:da0:8283:416e with SMTP id
 2-20020a251102000000b00da08283416emr6928886ybr.27.1699282150855; Mon, 06 Nov
 2023 06:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20231104034033.14926-1-rdunlap@infradead.org>
In-Reply-To: <20231104034033.14926-1-rdunlap@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Nov 2023 15:48:35 +0100
Message-ID: <CAPDyKFp+rXEnCZq30w1BiQRn09usYQ49qTqeouxEN3BHmV7CRA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: fix inappropriate use of kernel-doc
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2023 at 04:40, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> There is no mechanism for using kernel-doc notation on a data item
> (only struct/union/enum definitions, functions, and function-like
> macros), so convert the "/**" notation to C comment "/*" notation
> to avoid a kernel-doc warning:
>
> drivers/base/power/domain_governor.c:412: warning: cannot understand function prototype: 'struct dev_power_governor pm_domain_always_on_gov = '
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/base/power/domain_governor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -406,7 +406,7 @@ struct dev_power_governor simple_qos_gov
>         .power_down_ok = default_power_down_ok,
>  };
>
> -/**
> +/*
>   * pm_genpd_gov_always_on - A governor implementing an always-on policy
>   */

While at it, may I suggest that we instead just drop the function
description altogether. It's not really adding something useful that
is not already understandable by looking at the code below, I think.

>  struct dev_power_governor pm_domain_always_on_gov = {

Kind regards
Uffe
