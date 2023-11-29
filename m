Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BE17FD54B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjK2LQE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 06:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjK2LPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:15:40 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0D1FF5;
        Wed, 29 Nov 2023 03:14:42 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5c8c8f731aaso67862937b3.0;
        Wed, 29 Nov 2023 03:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701256481; x=1701861281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfvOZ/r/9xhV2IOVZmWGdwaESTpDCIgP8OCrBiOEH34=;
        b=wpBDv/1MfTt7pLEYPHP1CT4Jr+CnuASEhYM+OtIGsZHNAJdIOps1qAo+1AL9PNh97m
         l2jwANUl6lPzND0SLrpQNzBLKxFDAw1csEtER0qPGazC6JvwQLbRi1HkllARtduGr+WI
         QCvRraA/MmujSSam5Qzhx733nR3psVrzmyXOybVTVIMPqeZi3n3uWDwwleLOmxJoXytr
         OyIfBYyoDweu3GYUXs9mCpZk3ZYuf4yzIPWrQqAnR/0C55cXngQd5AOrH4WKJltvgvkE
         RKk8mOtiCxBWd65L3Hn+wu2vOE/nFh4P7stlFTRAYVZWr7DCNGSYv3zxu4RUV/Rp2SJp
         yl1A==
X-Gm-Message-State: AOJu0Yz/Yk794w4cIlPG1/yAvEiprmh/mj/26m2iw6Jx8BUOSIzbP/vi
        gwf3abz6NHAKteD6muJ0DgfBbVtOpdgZXw==
X-Google-Smtp-Source: AGHT+IFdxb0wQCD90c+WtUlDl1m6Ai4ilgHchvgLoh1lxsH5zH4N2CifWJEDcvUV5m8mfLx1hT1Zlw==
X-Received: by 2002:a0d:dd04:0:b0:5ae:dff7:6159 with SMTP id g4-20020a0ddd04000000b005aedff76159mr19766119ywe.18.1701256481401;
        Wed, 29 Nov 2023 03:14:41 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id ex5-20020a05690c2fc500b005d25be5c7f4sm316582ywb.73.2023.11.29.03.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 03:14:40 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5b383b4184fso67726077b3.1;
        Wed, 29 Nov 2023 03:14:40 -0800 (PST)
X-Received: by 2002:a05:690c:4041:b0:5ce:39b:84c6 with SMTP id
 ga1-20020a05690c404100b005ce039b84c6mr14916699ywb.17.1701256480754; Wed, 29
 Nov 2023 03:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com> <20231128200155.438722-23-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231128200155.438722-23-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 12:14:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVhhU9ew0KXw1nYygBxTc5ucYq_rBC06=U1b6iRoxdqGw@mail.gmail.com>
Message-ID: <CAMuHMdVhhU9ew0KXw1nYygBxTc5ucYq_rBC06=U1b6iRoxdqGw@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] pinctrl: core: Remove unused members from struct group_desc
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 9:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> All drivers are converted to use embedded struct pingroup.
> Remove unused members from struct group_desc.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
