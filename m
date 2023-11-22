Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059D87F4870
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbjKVOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343965AbjKVOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:02:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06BB83
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:02:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b2a8c7ca9so14143675e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700661730; x=1701266530; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2A/VfeBYgASVcGiKPGr1oUM7tNb5xqCmvquRYdSu8M=;
        b=NoRME1anX1X842+qkfpjiLt4vCwMc5GabgZTivm/LRaYGHOCjjGOH1qBvwqxdttrQT
         PhOYkMsbHRZuKmwMr7utufWcPRC2PhgYn0admROIjpi4ykkkUbFy6000euUOMbFzUWd1
         A/DantCCTP6EUPpv0Xs37Mkikmd/289TvrrPXcNlxGkTK3WaduJgZZnSnf4txxw5IfYg
         e21cV7vZg1pdLDTwZpLmuv7NORHHRNfyGk7W0UdROXWafaWhI7vNI9aTeTWWG/EzJ8mY
         ehQlmM+rgg7a1UcvpJfq/dRKAhdsJaJJ0pyc6Ll5D0+R/xoEVT86Q+puFaGFbozFRUdg
         RCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661730; x=1701266530;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2A/VfeBYgASVcGiKPGr1oUM7tNb5xqCmvquRYdSu8M=;
        b=pusy4UG1kEiTPLrjKzM8YXjBJD0NBO8QTQAIy5VBe+rHZyMozRo4+5rPrDfp0yG/EC
         0RwdFwqvlwTsoGM5tmXpwWJq7NxU429yI37KnqEkeMs0JjlG4k4/sq38HERTaEk25Jod
         NGA7OuHB8rWQCPfHIbq9NxfpM33lQhwWdzGvQDlWL8GQivYqI/+b5d0qVGHcu0zzQmvZ
         vhHr1X4Ty/R5eyhjTURB1N4SXCa0UtviUd1q+8VhLmrSNve6fi8kz0fweLo3+PuuLqc1
         u6EDdGDkb9ndPIVpo8fnmlt8YBkcYo+7stE4wyo2RV7pmFkquvlm1PwPqCtIn61B02nW
         +EGQ==
X-Gm-Message-State: AOJu0YxhzERVG0UimsIc2zPopbVty5N211+g2crx5rZZiXN/jdzLFOeq
        TsvrPqNeID2CaMm+xLRx8vCmC/U5EnZJwA==
X-Google-Smtp-Source: AGHT+IGI/Hw87AQZA+IqtqHeeVQr3Qx3cJNo4h/YfwXjPhjTD1kaQR4aQN0mPWL/c3D8uopHdBjiPA==
X-Received: by 2002:a05:600c:3b0c:b0:405:4a78:a892 with SMTP id m12-20020a05600c3b0c00b004054a78a892mr391970wms.9.1700661729695;
        Wed, 22 Nov 2023 06:02:09 -0800 (PST)
Received: from giga-mm-2.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b0040a44179a88sm2351048wmo.42.2023.11.22.06.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:02:09 -0800 (PST)
Message-ID: <49cb00512b712bd338c8ba052778710372dc8b8a.camel@gmail.com>
Subject: Re: [PATCH v5 33/39] ARM: ep93xx: DT for the Cirrus ep93xx SoC
 platforms
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     nikita.shubin@maquefel.me, Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Nov 2023 15:02:08 +0100
In-Reply-To: <20231122-ep93xx-v5-33-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
         <20231122-ep93xx-v5-33-d59a76d5df29@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, 2023-11-22 at 12:00 +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Add compulsory device tree support to the Cirrus ep93xx ARMv4 platform.
>=20
> - select PINCTRL_EP93xx
> - select COMMON_CLK_EP93XX, as clock driver moved out of platform code
> - select ARCH_HAS_RESET_CONTROLLER
>=20
> Select ARM_ATAG_DTB_COMPAT to update device tree with information
> about memory passed from bootloader.
>=20
> We have to leave all MACH options as they are used for board checking
> before decomp, to turn off watchdog and ethernet DMA.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0arch/arm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0arch/arm/mach-ep93xx/Kconfig=C2=A0 | 20 ++++++++++----------
> =C2=A0arch/arm/mach-ep93xx/Makefile | 11 -----------
> =C2=A03 files changed, 10 insertions(+), 22 deletions(-)

--=20
Alexander Sverdlin.

