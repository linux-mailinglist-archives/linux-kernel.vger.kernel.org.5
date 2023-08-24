Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFE37869FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjHXI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbjHXI0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:26:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6E1727
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:26:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50091b91a83so3410043e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1692865559; x=1693470359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TdEpv+yQehOUDtMKfkCTqDpBdvgIuQ3N6LCjN8giao=;
        b=EASC/7rEBvQrMbHPL5P18e+Gv0IysWXqXE1fqTXxrHpJiN5DPS4j4Jl7iNnQVmxXRU
         hutYsBtZYQOQwpYtCBq29vUB2PCiCghVrG9CgkYYwiTJL5oJ70gkJ3FmH0xd2Je1m+II
         b6OO4C3fHi63RQA02cvgNvZ7Gbs0wcANGsxtQfdI2Cu1jz9A2lSczu8XTvMIdH9iN+UX
         Y9tGKcQxI6BcNud8UYveJoIktq7HXH0ynHtpOpwuHPZ/m31kIPbK4nThZnms2awWvfBJ
         QVj5lNoi/F93jqCjQiK5CaLU8TKosum0TbyZfpLCWAqgSybpawJHtijNV8IjyLEzhIGp
         5ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865559; x=1693470359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TdEpv+yQehOUDtMKfkCTqDpBdvgIuQ3N6LCjN8giao=;
        b=DTTCMwqeo1MVRugh1ZV/Ytmyjiy5OudE1OZZDTwJCExsOsrms77szZe1XAruls9nSu
         M0rNekQ0peuXPC6c+AdgLIR+dkAEO+0xZznL8fwoTEH4SI8gQq19eDJEPXFNa+mNq+Wb
         dFhynF9PLeAsxgDOOn5JqdTNoC3OdOYJLZrPzR0lMY65Q89HDrNpofHKsri7X0wKcNRp
         Pf488OOrZw2SDzzvT9GksTRnJOBjPgsmbClzm3fcfx/7rXSQcXC/kMdVDRyVUYSGo08o
         GR18dezlUJGZL2Eq6CJ2vggPYBJF23Cu8j6UeIgZ0Lb/E6mAd6gpmS2l0gxyadrgZvf9
         zwBQ==
X-Gm-Message-State: AOJu0Yy0XprI4efLZMNPvUL3O07pZ6p3GQgEUktcbgDXR5IMRqJLwyVT
        S81V1nYKGBv0uAGfvdL03d62VkW/zt4oNUvj0zMXJw==
X-Google-Smtp-Source: AGHT+IFTPLS7aaKK01I0mp960T0BithUnoHmGGRJbVNYRe76nw/p/hxRCaEv3yHpiI2RI6IP/xAhZqWnbUMBuPQqksU=
X-Received: by 2002:a05:6512:32ce:b0:4f9:58bd:9e5c with SMTP id
 f14-20020a05651232ce00b004f958bd9e5cmr13013611lfg.3.1692865558635; Thu, 24
 Aug 2023 01:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230823111555.3734-1-aboutphysycs@gmail.com> <20230823115857.qi44xa77doimlare@viti.kaiser.cx>
In-Reply-To: <20230823115857.qi44xa77doimlare@viti.kaiser.cx>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Thu, 24 Aug 2023 11:25:47 +0300
Message-ID: <CAH3L5QphsxcYC7=FK1=MEYcE-VyFy9t60jS8MZ_9TA5SMKTibg@mail.gmail.com>
Subject: Re: [PATCH] char: hw_random: bcm2835-rng: removed call to platform_set_drvdata()
To:     Martin Kaiser <lists@kaiser.cx>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        Jason@zx2c4.com, bcm-kernel-feedback-list@broadcom.com,
        sbranden@broadcom.com, rjui@broadcom.com,
        florian.fainelli@broadcom.com, herbert@gondor.apana.org.au,
        olivia@selenic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 2:59=E2=80=AFPM Martin Kaiser <lists@kaiser.cx> wro=
te:
>
> Andrei Coardos (aboutphysycs@gmail.com) wrote:
>
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
>
> You're right. The platform_get_drvdata call was removed in
> 4c04b3729 ("hwrng: bcm2835 - Use device managed helpers").
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
