Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108467A3126
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjIPPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjIPPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:39:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2A4CE3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 08:39:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so3631289a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694878739; x=1695483539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ay/XJm2CQEAe9izGpgoj4ekm9m5LhbW3TZH5V4bngg=;
        b=P4+HGN6UQ/oiLdmuVt02F4gilWQ7wiPXb0Wz0eBg6xeNvbD5+V4/5HLmfY38W8kiJh
         igVecuj5Pac3/36Y5wHCbc6EJPPUyKc+eAcjCMk43UEJWLZsB4ZbIr0l7LuRS0EFJbpK
         OtA5SiaiNSMqz45+/oRdyJ3NZgaEYhLqCF7KGb4jf7TITE9107Gw+pF4q/CNNXrx20Vg
         mQiit2c5o7A7HTzUbrD7BHUJIVCAhCRN7iOF/MXOxX+fzrrPpS7dr+blPxPr5PeKFUNW
         2xzdi0jVSXiscUiHh6EgTGdU7VtnjguMLtkRg5U84zoMLVUtY9VIId8SCCIP/A8RdvG7
         D4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694878739; x=1695483539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ay/XJm2CQEAe9izGpgoj4ekm9m5LhbW3TZH5V4bngg=;
        b=QM0FHZj2MoQfhn34XA2OUcclAOtFCeaHtn8uyL2frDgef0c2BvhzszxCBYcRgcwfEU
         RqsQ+MoZalTYiXP3rRpHkaV/vSv0nm2BHtmTsKenJCiy9lMyQxmWnHnHStfyB3fzCvcl
         3E/JodRo8tB3auMAY88b+EKq/H0Y3yacOcWIpBCe59dfqUP1RYnptfBHKU9kK4J4dtIS
         Qu4dLFNdt/BWIseFua14ZAocgffVr2y4LRdnXb4IKS3CEw5QIceAa4pT4ENqshpp/SOA
         djLhSS1FT9xf0v6Urb0mKv4H5wKJG5U9cz5OIqqm722yfyYCTNQKAqxelbhaYMv29DQ6
         EdHg==
X-Gm-Message-State: AOJu0Yyw9/HnMmYUDR/9h1xXCGeEQ+C+eNqm2DXaAVK2EA+PpmL1xDMu
        NEb89eZDzUmTDe2Dn2z1kAI=
X-Google-Smtp-Source: AGHT+IFpOMdG9Hm4bBK1ESC1PCpK/LcovHi1OTeDYCDlPyoiGjzKbwOSXIf33m1g+21OTcn98q3Z1w==
X-Received: by 2002:a05:6402:389:b0:52e:8973:6482 with SMTP id o9-20020a056402038900b0052e89736482mr3538305edv.6.1694878738764;
        Sat, 16 Sep 2023 08:38:58 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id n24-20020a5099d8000000b00530df581407sm356894edb.35.2023.09.16.08.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 08:38:58 -0700 (PDT)
Message-ID: <93997981fb20fd83f42b83853e258ea28575cbe1.camel@gmail.com>
Subject: Re: [PATCH v4 02/42] ARM: ep93xx: add swlocked prototypes
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     nikita.shubin@maquefel.me,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 16 Sep 2023 17:38:57 +0200
In-Reply-To: <20230915-ep93xx-v4-2-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
         <20230915-ep93xx-v4-2-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita!

On Fri, 2023-09-15 at 11:10 +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Add ep93xx_regmap_write and ep93xx_regmap_update_bits to make drivers
> compilable before actual implementation is added.

It should be possible to re-arrange the patch series so that real
implementation comes before the drivers using it.

We must assure that bisecting the kernel tree is possible, that
means no matter which (initial) part of your series is applied, there is no
regression allowed.

> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> =C2=A0include/linux/soc/cirrus/ep93xx.h | 6 ++++++
> =C2=A01 file changed, 6 insertions(+)
>=20
> diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus=
/ep93xx.h
> index 56fbe2dc59b1..8b4b8221ed4c 100644
> --- a/include/linux/soc/cirrus/ep93xx.h
> +++ b/include/linux/soc/cirrus/ep93xx.h
> @@ -3,6 +3,7 @@
> =C2=A0#define _SOC_EP93XX_H
> =C2=A0
> =C2=A0struct platform_device;
> +struct regmap;
> =C2=A0
> =C2=A0#define EP93XX_CHIP_REV_D0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A03
> =C2=A0#define EP93XX_CHIP_REV_D1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04
> @@ -34,4 +35,9 @@ static inline unsigned int ep93xx_chip_revision(void) {=
 return 0; }
> =C2=A0
> =C2=A0#endif
> =C2=A0
> +static inline void ep93xx_regmap_write(struct regmap *map, unsigned int =
reg, unsigned int val) {}
> +static inline void ep93xx_regmap_update_bits(struct regmap *map, unsigne=
d int reg,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, unsigned int val)
> +{ }
> +
> =C2=A0#endif

--=20
Alexander Sverdlin.

