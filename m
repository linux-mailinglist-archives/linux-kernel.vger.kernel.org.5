Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0475C1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGUInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjGUIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:42:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED012D53
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:42:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso13753805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689928974; x=1690533774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQaE+aGAoPiWTrzxC0m23eci3gy8Nzf0koJxtpNK2YA=;
        b=N2h3UNJDdhqd87L3F4mYmBXLz0qK1XjoAFFJkLXJL1KKoYmOgmauzLv185j/ocWYA5
         R3etvIdFfA2ZAkggjQMd+poAmzQfVSvcsKMAoR3TgARskd/Rqg5htrh0tAqZFbm020Q6
         EhTfIwPbnUM8RX+KkLUC/QvNUXBwqtk05iaLgVGW5/ml0lYCOH9AAQiG2jw9/OVbQTYd
         sPYqSXzbVvHjiO297NGcXQMx+BbECWhZsHR6Z2eL2XqeB/IvWoqSLhivGEkxUMN50hlg
         6G5rCstvluru5Nbve2rK0+JFlo4a/7uf7gcJKLy6AYImNAoLJDVS4tn2rrKhZpSALEYU
         +V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928974; x=1690533774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQaE+aGAoPiWTrzxC0m23eci3gy8Nzf0koJxtpNK2YA=;
        b=UCg1JEvLgPokTKeJvieuj8JOEHeEhaR2fvp8Z81LWqEInEgEpQWim50z/NT4V7igBO
         Pht5G9zEY02Dbu9TJUbLIZvgauYyNhkU+Mr7TiRcfl5CwD/JjQMRnLV/CpOm4RZWiFAZ
         xfnqoDGcWZFDOwLCv+tB0OXeCU/2kQyyHzYideYegEOtC0MMgCcqiiUztLFySD4hvTjT
         NG+U27UXltKPStXdA0m5r9vg4vDqHCJXqPR5FvdcbX+6PF5csVATeSpH1OloiVTNSe2H
         UO9/MpwA8lvRWCUQQ5m99rqB8KNG/JRoSqSVPUogY5uLNUG1tucyYESI/FjEQcpRMMiI
         EOCg==
X-Gm-Message-State: ABy/qLZ6tSPKtn97AyFHSHzql6HA3BYiZgjsxQpO9acQ/RzdLs8ZjTfW
        SGhCdRYGeMOQKrvwOIRek89dxg==
X-Google-Smtp-Source: APBJJlE3K30Gc1FY8KUg8IGeriUSJfp+eK3+VTcAwyFZWEeBiWs4OcFMYvjx+IJ5eAdxug70zn9QFQ==
X-Received: by 2002:a5d:6ac8:0:b0:317:15f5:a1ca with SMTP id u8-20020a5d6ac8000000b0031715f5a1camr925360wrw.10.1689928974175;
        Fri, 21 Jul 2023 01:42:54 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id u1-20020adfdb81000000b0030e5bd253aasm3564628wri.39.2023.07.21.01.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:42:53 -0700 (PDT)
Date:   Fri, 21 Jul 2023 09:42:51 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Ying Liu <victor.liu@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "andy@kernel.org" <andy@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>
Subject: Re: [PATCH v2] backlight: gpio_backlight: Drop output gpio direction
 check for initial power state
Message-ID: <20230721084251.GF2525277@aspen.lan>
References: <20230721073555.1377236-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721073555.1377236-1-victor.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 07:31:37AM +0000, Ying Liu wrote:
> If gpio pin is in input state but backlight is currently off due to
> default pull downs, then initial power state is set to FB_BLANK_UNBLANK
> in DT boot mode with phandle link and the backlight is effectively
> turned on in gpio_backlight_probe(), which is undesirable according to
> patch description of commit ec665b756e6f ("backlight: gpio-backlight:
> Correct initial power state handling").
>
> Quote:
> ---
> If in DT boot we have phandle link then leave the GPIO in a state which the
> bootloader left it and let the user of the backlight to configure it further.
> ---
>
> So, let's drop output gpio direction check and only check gpio value to set
> the initial power state.
>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Based on the discussion for v1 about 706dc68102bc ("backlight: gpio:
Explicitly set the direction of the GPIO"), I think there should
be a Fixes: tag here.


Daniel.
