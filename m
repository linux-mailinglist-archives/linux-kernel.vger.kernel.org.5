Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FFF7FDDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjK2RIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjK2RIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:08:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031BFBE;
        Wed, 29 Nov 2023 09:08:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-280cd4e6f47so1132485a91.1;
        Wed, 29 Nov 2023 09:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701277729; x=1701882529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O76Cfk68KhrIxRJmJnZsx1C518bMCKM0WCIhUwoBo8w=;
        b=PRYgMA3F0Bp6pNkgNKeUdAQlRGC+iPlG85TnoAVupre+1QPulwS0cHnlgeTje09G9A
         mPE7vzEXEWAr7pe4MHdfWmcbN/vsIaEW8AYHQJGMuyEYVBdbOCIW0MSb+9yaPxPTnk5m
         LjuzykqfsG8ZEb+b6YvwfnLxZWPkAg9K3Wx3sY/5Non09c2a36k5GhWO56mxIZjsci1E
         QUreYyc3TDav+GGV5ctRTr4ubn6PT4c7WK43Mycl37yAgFAB7woFzqOw7Pi1m+BiT6tf
         /mp8kc0nNXQI2Pj71NKG+YFbEp0KH1uagoghh0QPrx6Kzdjs4x1U7/m3IPM5RvmGHEB9
         2+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277729; x=1701882529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O76Cfk68KhrIxRJmJnZsx1C518bMCKM0WCIhUwoBo8w=;
        b=kDKJc+wi3XGQCze3nzmQuGPPIAamvXl/MIt54+h85wSB//FZfZ0RiEuuIztDMXl7pE
         +Cx3Z6UPiRaAy1oUB5U7Lb64vEV7lepv4mc9zNQZEYTKIGQDevieBZBftgn1xEqwPAss
         21cmyDvpuZHTARY4A87Z0dNPdZCW48zeOoihkBKU/S0vGUYaW7mEKgxqIAZdYsJ1c/DY
         x/iZvulchB7doGhINUfGT/hZaET2PjZp4glkyGwYxIW6aWr60cgjgDsu3Lu16ZXEuavl
         57R9rxG+L7Ud7Rnma5rgjBPpnWRPHRx9rrvbSPx2lR7PBfLpf9q8wkSuCVdkcjAfqXoB
         O+Cg==
X-Gm-Message-State: AOJu0Yxi01M8CIE28NXf3DTlWmlzikAgf8ZaFsee7XMt9A2V0CmUw8hK
        +lpoLfNLRW95DNTMI2XT+h4IdNxySM1GfUqgVwQ=
X-Google-Smtp-Source: AGHT+IFtel5cMuSoclx/RD5jpcO3jFsf4gFjr/2yk0h//Bk9GZrDN+VMoKMUdgmJ/KVAvyVH4q/bBMMt3AS7ri8wwtQ=
X-Received: by 2002:a17:90a:d996:b0:285:f76:9d6e with SMTP id
 d22-20020a17090ad99600b002850f769d6emr19702101pjv.3.1701277729276; Wed, 29
 Nov 2023 09:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
 <20231129161459.1002323-17-andriy.shevchenko@linux.intel.com>
 <CAOMZO5CZpQjWKimNReUkwHOc-mF8vWoq2HDhjGKSu6E3g5-aVw@mail.gmail.com> <ZWduPKmBWkaIdLhi@smile.fi.intel.com>
In-Reply-To: <ZWduPKmBWkaIdLhi@smile.fi.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Nov 2023 14:08:38 -0300
Message-ID: <CAOMZO5C_dhvx70nk1HOSZdw8hMMmED69tdsXgydXdpnxHTJ58Q@mail.gmail.com>
Subject: Re: [PATCH v4 16/23] pinctrl: imx: Convert to use grp member
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 2:01=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It's explained in the first paragraph in the cover letter. Do you
> want to copy this into each commit message?

Yes, much better to have the information into each commit message.
