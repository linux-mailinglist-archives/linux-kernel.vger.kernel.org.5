Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189757CDCB4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjJRNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjJRNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:07:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674B3133
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:07:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso69925281fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1697634441; x=1698239241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=56lqzAcgtdJPl7JHirL9fzd0FCjYyOYyIARceuj/CkY=;
        b=qeSp4l6tnMVfKkVnwizKjqw04PZg41wQLZ7DX/RgqaGwvlgSXvoS/EHgc/oOu20pzm
         BjFpmd/RaMM+xr7OMco2i3KoZlBIcDf+wxDsQOpGeAwVC6Kz08kQDPVzLkaeS8bJkWBj
         Ju08nnFnVv1WUrTGoo499wYjMtz8fBYTkNQIJ7IMaNQN3D6PWiMu2WnMSiUgTMW9a1Xd
         8E5nCrEt9gQptOVErnsKna941P57Zoq7w4YGGkwaxigQADzNuHowRrcX7+mqFk5OKOH+
         /Git7g5Wg45FP66X8Uje1I/5/m65irCzZTglA6gaXBKG4xTTbVgyM1i42gehXsQY5KFD
         qyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634441; x=1698239241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56lqzAcgtdJPl7JHirL9fzd0FCjYyOYyIARceuj/CkY=;
        b=TQ//H0RWYrK4qbFjIlyeXQBC0VmiUbfnnKCXjdfTbguaCHmXT7F1PC6WNYre5GnhNs
         x2jZoohAcpVi77D8lVe98eDZ3P6nPx1thNZ+AMgsQPS8rJnU9wUvjWi0ONL+Hb5H6NVv
         VHjFpJVU4vbnwv0H5kNb5X+zEpPXfH1TxMWKm4Is5PEYXBvbGueOs/zox8+o463rvij2
         e8hLU4jplfKcWjUhSrWeCYRbVfACWOPx8FTRCSjp9AAxYV+Uc412ccaxzFsxg/LTcbvB
         iDv33qXdoV+EkYNoJsIpsMBy1e9p9Az9buhdEagtOHfvKCduG2XVzMmf2IaRH2YaC8t0
         jG6Q==
X-Gm-Message-State: AOJu0Yy9FOQNtcZLv+GCHDPqHuH9zVCk7KFWmuXDblhjuKWZk8SkPolJ
        nzF8nqeIfYtMvZ+v5AjqJVYR3g==
X-Google-Smtp-Source: AGHT+IED5LOQF4gPuytjBt6ZHSRvZ7g8+GSXt9ldsLC1rJ70oCBHJbItwMZL7pVuGVt2d2SPRx1wrg==
X-Received: by 2002:a2e:3c08:0:b0:2c5:1900:47a4 with SMTP id j8-20020a2e3c08000000b002c5190047a4mr3750816lja.0.1697634441016;
        Wed, 18 Oct 2023 06:07:21 -0700 (PDT)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id d2-20020a2e8902000000b002c5056bcbb2sm699184lji.16.2023.10.18.06.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 06:07:20 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:07:19 +0200
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To:     ihor.matushchak@foobox.net
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: staging: max96712: Fix device name in description
Message-ID: <ZS_YhwYJnS5ZC6EF@oden.dyn.berto.se>
References: <ZS7doO43ijXhBqkm@oden.dyn.berto.se>
 <11a00300c76df12c13adabfc71111607619a49f9.1697572799.git.ihor.matushchak@foobox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11a00300c76df12c13adabfc71111607619a49f9.1697572799.git.ihor.matushchak@foobox.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ihor,

Thanks for your work and taking the time to work thru the review.

On 2023-10-17 21:02:39 +0100, ihor.matushchak@foobox.net wrote:
> From: Ihor Matushchak <ihor.matushchak@foobox.net>
> 
> Fix the device model name in driver description,
> which appears to be a copy-paste error.
> 
> Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>

Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>

Small note, in future remember to increase the patch version for each 
new posting. You did this correctly between v1 and v2.

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
