Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A09580DE2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjLKWRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLKWRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:17:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386948F;
        Mon, 11 Dec 2023 14:17:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c4846847eso13624545e9.1;
        Mon, 11 Dec 2023 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702333060; x=1702937860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tp9YUq5vWpe1+ZnJGAbvZAkepuaBVbVaZfpHzIC5g=;
        b=DEzJAL+DGJ365ADX3v5yv/iMSA0tN0xUzQPGS/V6vxBKGJZekl445z2gnBP8hA0izA
         6G4g+WwUrSSQJFBATCAyDToZjK2M3/Mtjy23RbIBVPVwz2qBap+ee4Iq8P98qrMbtpoQ
         UZ01Y1fedsTS4n8Jt/ux78ed2QjYYOFIpmY8tA/fxLtae0dLmsIt9WMfy/ri3lYt4Wmz
         q/aoSnm169ugH/JQ4EvsfxEvobzbgreQx+rnRnM28GrkQx2BFgiCI78ebztB4HxSK7Jx
         4+42ClUt8oUlOV1d7INBwuS7CMJCvTbOrxaytV/+u6CKdXKglvlSJPxrUPMNBZK0lwWC
         wcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702333060; x=1702937860;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9tp9YUq5vWpe1+ZnJGAbvZAkepuaBVbVaZfpHzIC5g=;
        b=s28e3L1xM4O9QbprqNJeF19687tvtqBhOtNDAEo42whrN3anQPhG4xrQVamVfwcx4K
         BPEJfVKe1EChoG9jJpuxMcoMvFqgHaDMg7cpElVrXT9asU7JJrTJnlB6lgvvPE8pougF
         11LP7XvCM8wMK06WHzJ9P9Ycjh7YLId1IvxS7U2loravqpNAJOdK3FwPZlD7y5KqlZVG
         7Um+O5vTaTQGv2yPRInzxDGgliXcALjzUuovn+GHFCWxJhPgiMYqrAmiJ0277wd07g75
         wvGockVp33jVIIldooztuZ7/STWHdNf0a+6YPmthzVjeRi8q6n7J/sg7+y22S78d/6hK
         a7ew==
X-Gm-Message-State: AOJu0YxiM5wws7nqa6+kr5Z5lgmZj3prHAFVbi67aKq5hSwideqBWU1m
        oezQOwdwFKTWfrnIX8zXRxs=
X-Google-Smtp-Source: AGHT+IFmQW9IHLsf1rjDUOGUiGQD+zZRcRhxTeab+Q1YCndW3ZED0ngtFstIjQrgx202OEoE+6NTjA==
X-Received: by 2002:a05:600c:5249:b0:40c:243b:3d7f with SMTP id fc9-20020a05600c524900b0040c243b3d7fmr2374419wmb.18.1702333060470;
        Mon, 11 Dec 2023 14:17:40 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b0040c31bb66dcsm14004808wmq.20.2023.12.11.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:17:39 -0800 (PST)
Message-ID: <65778a83.050a0220.b2844.2af7@mx.google.com>
X-Google-Original-Message-ID: <ZXeKgZt0QlAm209k@Ansuel-xps.>
Date:   Mon, 11 Dec 2023 23:17:37 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Andrew Lunn <andrew@lunn.ch>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
 <170142826116.3357002.9561246405642038358.b4-ty@kernel.org>
 <6577315e.050a0220.50f30.0122@mx.google.com>
 <20231211084656.26578d89@kernel.org>
 <657784f6.5d0a0220.617b5.20ee@mx.google.com>
 <20231211140546.5c39b819@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211140546.5c39b819@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 02:05:46PM -0800, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 22:53:55 +0100 Christian Marangi wrote:
> > Soo that it's problematic to also have on net-next? (Sorry for the
> > stupid question)
> 
> Unless I pull from Lee the patch would be duplicated, we'd have two
> commits with different hashes and the same diff. And if I pull we'd
> get a lot of netdev-unrelated stuff into net-next:
> 

Thanks for the explaination... Sad... guess I have to wait, hoped I
could have the qca808x series before proposing the at803x driver split
but I guess it's not possible... Maybe I can try pushing the change for
link_1000 for now and later add link_2500 ?

> $ git merge f07894d3b384344c43be1bcf61ef8e2fded0efe5
> Auto-merging drivers/leds/trigger/ledtrig-netdev.c
> Merge made by the 'ort' strategy.
>  .../ABI/testing/sysfs-class-led-trigger-netdev     |  39 ++
>  .../ABI/testing/sysfs-class-led-trigger-tty        |  56 ++
>  .../bindings/leds/allwinner,sun50i-a100-ledc.yaml  | 137 +++++
>  Documentation/devicetree/bindings/leds/common.yaml |   2 +-
>  drivers/leds/Kconfig                               |  21 +
>  drivers/leds/Makefile                              |   2 +
>  drivers/leds/leds-max5970.c                        | 109 ++++
>  drivers/leds/leds-sun50i-a100.c                    | 580 +++++++++++++++++++++
>  drivers/leds/leds-syscon.c                         |   3 +-
>  drivers/leds/leds-tca6507.c                        |  30 +-
>  drivers/leds/rgb/leds-qcom-lpg.c                   |  52 +-
>  drivers/leds/trigger/ledtrig-gpio.c                |  26 +-
>  drivers/leds/trigger/ledtrig-netdev.c              |  32 +-
>  drivers/leds/trigger/ledtrig-tty.c                 | 247 +++++++--
>  drivers/tty/tty_io.c                               |  28 +-
>  include/linux/leds.h                               |   3 +
>  include/linux/tty.h                                |   1 +
>  17 files changed, 1247 insertions(+), 121 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
>  create mode 100644 drivers/leds/leds-max5970.c
>  create mode 100644 drivers/leds/leds-sun50i-a100.c

-- 
	Ansuel
