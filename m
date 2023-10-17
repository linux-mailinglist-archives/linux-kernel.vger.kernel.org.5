Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA07CCC06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbjJQTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:16:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60982C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:16:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507ac66a969so3385103e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1697570209; x=1698175009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSiJ+SgnN8DTqfMtIC3KGjxwzeSBjvuis9ayU/E7k5Q=;
        b=Fsk5sdq0QPekw4lw7dsDPzDNScYVayP3D2iinpnQygiTnw3hYQ68o2XFtE5rC3ihrI
         ZtpGkoKuK8cuXXPiiJ63Fi97rYH9GhoqMji2dh1069OqkS68MlcGhR7/AiSQSxq4IRJv
         rMJnOHjdzJQhzZve7JjLYzQDrTc6bJhHjcCyfb95mYMxzHVblQEEjm0LUxJsEDGMmVuT
         H7j38Um972vFcMjRUZN10etjPJrMFHEU+GH3CAd6UhkwnBhNWzoIxSnDzv8H7Nxj5/2q
         4s4tLNxWzx98N+XeMWMAe2Q18P+NLIioVfCj5IL7Ftrof4zyNVD/9zLz86o+ldJxvcFn
         amaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570209; x=1698175009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSiJ+SgnN8DTqfMtIC3KGjxwzeSBjvuis9ayU/E7k5Q=;
        b=h5e5IZ/Z9jb07fCih9bcKNLr9gPx4LLqXd8SKj36yOrA+MDEv2tkw7RxG5K3h2oUt7
         mEOOxVVpklX0xcEd370jBZF8ZFTo1zZCyCv8cS6XtxGapi6HNp+DCUQ2JSO5wYi+wmfg
         8+YIpz1cGVu2Yv8g6OmqrFeVTVDaCwKPIyGaA75nk7tYRkMelJtmY+1wxrOh9auo6/nm
         soLft0BjWXFwTAb0HDmWHbM7f/nPzRxne0GePNdD4gMEMwsWqbsja8/6strBsSE3Qfmi
         AcuYrIB7/B7oq7vEZd2fD1+Q5A+QELodWpFQ9dTy9SVD/h1+bZW4vMFzQJVnJUOgXLyv
         eEzQ==
X-Gm-Message-State: AOJu0YxMsGzcr8GKl2Fso+PPgag20pXG1UwJ9tnu2sR2PHxD2cpLydyo
        /rOXd72qKdTpCRLMgf4mzDFInA==
X-Google-Smtp-Source: AGHT+IG2cO3Bsb5IUnEpZlFyKPEwG5sdEK4KsPtXu1MxCxw/7byNBiQ69TVDDbf0IJsQgD7CQ79rOQ==
X-Received: by 2002:ac2:47f2:0:b0:507:a6b2:3996 with SMTP id b18-20020ac247f2000000b00507a6b23996mr2099211lfp.56.1697570209407;
        Tue, 17 Oct 2023 12:16:49 -0700 (PDT)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id c13-20020a056512324d00b004fe333128c0sm389408lfr.242.2023.10.17.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:16:49 -0700 (PDT)
Date:   Tue, 17 Oct 2023 21:16:48 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     ihor.matushchak@foobox.net
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: max96712: Fix device name in description
Message-ID: <ZS7doO43ijXhBqkm@oden.dyn.berto.se>
References: <ZS0wxi7SUhJcVh5Y@oden.dyn.berto.se>
 <942346374212972ef938ecac7c892558a48bfe75.1697568186.git.ihor.matushchak@foobox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <942346374212972ef938ecac7c892558a48bfe75.1697568186.git.ihor.matushchak@foobox.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ihor,

Thanks for your work.

On 2023-10-17 19:46:54 +0100, ihor.matushchak@foobox.net wrote:
> From: Ihor Matushchak <ihor.matushchak@foobox.net>
> 
> Fix the device model name in driver description,
> which appears to be a copy-paste error

Super-nit: You are still missing a trailing dot here.

> 
> Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

> ---
>  drivers/staging/media/max96712/max96712.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/max96712/max96712.c b/drivers/staging/media/max96712/max96712.c
> index c44145284aa1..ea67bcf69c9d 100644
> --- a/drivers/staging/media/max96712/max96712.c
> +++ b/drivers/staging/media/max96712/max96712.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Maxim MAX9286 Quad GMSL2 Deserializer Driver
> + * Maxim MAX96712 Quad GMSL2 Deserializer Driver
>   *
>   * Copyright (C) 2021 Renesas Electronics Corporation
>   * Copyright (C) 2021 Niklas Söderlund
> -- 
> 2.30.2
> 

-- 
Kind Regards,
Niklas Söderlund
