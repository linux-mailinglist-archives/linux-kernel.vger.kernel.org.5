Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208E977A77C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHMPc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:32:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA2E0;
        Sun, 13 Aug 2023 08:32:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so32635815e9.0;
        Sun, 13 Aug 2023 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691940775; x=1692545575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHC2PrwVZbPBq2NkHpw5N6Fi7dCDYwmxUMmMrb2ihiw=;
        b=aPusA+Kfzfaakwp2yGbsos5TOM37I7KTnn8UJ3i7+jaL4ed1jeqI3cbYEDExF71Jk2
         J5FOulBtQoFay0nuzb39SYTh1htAu1NMxdXW1MpduspuRSAmbGpkIvFRnlNBAgiFowtB
         6Zu+ehPo9FaEWJiD9zG88CtM74ImJBDk0+IfSoC1To/0niGYbWcUOBuGym0wChsbvq8I
         Chk/7IxWBuk+TLPZR1DN4i6KwmvTPtXWDHbnOUK8980iuu06vFy82bIValMpVlAsdF0u
         GijiRbEBI+z7Ug0L6kyMHyjsYpYgTUeuCjiLlqudfCcwbKS4RBl/b6AeJGmu3mU8MINe
         inRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691940775; x=1692545575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHC2PrwVZbPBq2NkHpw5N6Fi7dCDYwmxUMmMrb2ihiw=;
        b=ARODJ3zfuSETgUt9K/EEIyE2wA45WeFQGmIzEde5hGKjAVldtNW2sFOGflOd2ROD54
         dLU5EmHDd/hXciBm2yGXhH4pgiX0CYMCjR/mqSJvKNSGmrbMnkPV8om/87Z+/rygmYd/
         8KT161RXmauUKhhxYJGsGofj4GoXmtCadMp7QT8EpGXBV1ccmujlhMJVZldV/ra3/9zX
         7IvLXB0e+KTcnUT6mF0aNg2wMjHq71LrT2U8u3jJwbnvp/0//57aANcOhTsJIj8AS9xz
         ZNYry+ODCsrWe5ZwA2A+l2FpgTHRStYmkrI+7CVtpzDclebmUphVnh+753tVPO8R0da9
         Aghg==
X-Gm-Message-State: AOJu0Yyx4gg9fBUTnYUF5pVg8DFWZNgB87E5MXY4ydVVhkS4q14dF9z6
        bRKg+1nIFvwmWOfs6e+ferUMqGJEJF0JCA==
X-Google-Smtp-Source: AGHT+IHSXe6/T9CvpBgMmER/udVuOtLH8XRr2Nb2vBbWHtGXoCITBGWe9aN7L3n59eUjgEY5U8t3SA==
X-Received: by 2002:a7b:c8c5:0:b0:3fe:2079:196c with SMTP id f5-20020a7bc8c5000000b003fe2079196cmr5748914wml.16.1691940774826;
        Sun, 13 Aug 2023 08:32:54 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d6e10000000b003176bd661fasm11698387wrz.116.2023.08.13.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 08:32:54 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Andrei Coardos <aboutphysycs@gmail.com>
Cc:     samuel@sholland.org, wens@csie.org, rui.zhang@intel.com,
        amitk@kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org,
        tiny.windzz@gmail.com, anarsoul@gmail.com, alex@shruggie.ro,
        Andrei Coardos <aboutphysycs@gmail.com>
Subject: Re: [PATCH] thermal: sun8i_thermal: remove unneeded call to
 platform_set_drvdata()
Date:   Sun, 13 Aug 2023 17:32:52 +0200
Message-ID: <4850013.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230811194032.4240-1-aboutphysycs@gmail.com>
References: <20230811194032.4240-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 11. avgust 2023 ob 21:40:32 CEST je Andrei Coardos napisal(a):
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/thermal/sun8i_thermal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/thermal/sun8i_thermal.c
> b/drivers/thermal/sun8i_thermal.c index 195f3c5d0b38..61a2f287ac90 100644
> --- a/drivers/thermal/sun8i_thermal.c
> +++ b/drivers/thermal/sun8i_thermal.c
> @@ -489,8 +489,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
> if (!tmdev->chip)
>  		return -EINVAL;
> 
> -	platform_set_drvdata(pdev, tmdev);
> -
>  	ret = sun8i_ths_resource_init(tmdev);
>  	if (ret)
>  		return ret;




