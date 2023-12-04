Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7069803550
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjLDNqX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 08:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjLDNqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:46:22 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF91F2;
        Mon,  4 Dec 2023 05:46:28 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77dce4d41d5so246306385a.3;
        Mon, 04 Dec 2023 05:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697587; x=1702302387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdujGorCpR4eYA2UA1cuFkywZ2De5u0jlPuiHfhxLz4=;
        b=wuWLsSRgU5a6QJ0y4Ln7VHxcs9Zbnm2M5dUqqhW14lGLRoAAwA5+aBV8YEEVTztC+8
         QWFSxsGh7I2+SxPp8ZctRI1E46j792tUqeEuFyeNvpRresCNmxZxE8EnDGAeM5jWYD8j
         jYf5Mpx+/pS6GhN52e1orxbRAmDxtwpOQmWvZmzQ8p8NXPCiaAU/1pA/RWWZDZKTB2s9
         I1BonnSkuWgl8aHfDanYsSonJPcwGVwld5Y7Jx3PVLgam/jbaXqDwzejw0R7V+i6MzCI
         qhsZ6IMWjxZ2sfxPU9VAe/hkaesCI/+mxe6VKPSZqrFl19aYxoaqPD6o8/LRaKGrk7sz
         dMgA==
X-Gm-Message-State: AOJu0YzFx2KHXKIecU6RSWlMh7vNmshqy6Yfo4BMfBQnu7PEb45mRdvf
        ym6Yv/A+eASFq+BJ2dXcxxaPMyCmzTesJA==
X-Google-Smtp-Source: AGHT+IGzONsoBT2irRYexPHD1YjxAsndsReWSf7JnnSMMSprgODC3VlGH5cLlb4H16vbOeR8etAq1g==
X-Received: by 2002:a05:620a:6845:b0:77e:fba3:756e with SMTP id ru5-20020a05620a684500b0077efba3756emr5082792qkn.102.1701697587209;
        Mon, 04 Dec 2023 05:46:27 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id pf21-20020a05620a859500b0077d62e78db9sm4249687qkn.128.2023.12.04.05.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 05:46:27 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4254853d4d6so12836961cf.0;
        Mon, 04 Dec 2023 05:46:27 -0800 (PST)
X-Received: by 2002:a05:690c:997:b0:5d6:8d41:669c with SMTP id
 ce23-20020a05690c099700b005d68d41669cmr1337270ywb.6.1701697189014; Mon, 04
 Dec 2023 05:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
 <20231129161459.1002323-13-andriy.shevchenko@linux.intel.com>
 <CGME20231204114039eucas1p29c6f8a162191e58ff658d3a1c44429bf@eucas1p2.samsung.com>
 <9e4e65de-7234-4234-8091-796277a1f1c5@samsung.com> <ZW3PrSQWyZvvhN66@smile.fi.intel.com>
 <CAMuHMdU-E7jemjAS0EunWFPq1LfF9vcNE+50ah4WH9oD1TXYew@mail.gmail.com> <ZW3U5-LBqWiyxB6-@smile.fi.intel.com>
In-Reply-To: <ZW3U5-LBqWiyxB6-@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Dec 2023 14:39:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVz=dLaBt-Td0UdOOs79ju7UfX_2vUcy8Kdeo9aSP+edw@mail.gmail.com>
Message-ID: <CAMuHMdVz=dLaBt-Td0UdOOs79ju7UfX_2vUcy8Kdeo9aSP+edw@mail.gmail.com>
Subject: Re: [PATCH v4 12/23] pinctrl: mediatek: Make use of PINCTRL_GROUP_DESC()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Dec 4, 2023 at 2:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Dec 04, 2023 at 02:19:10PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 4, 2023 at 2:10 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Dec 04, 2023 at 12:40:38PM +0100, Marek Szyprowski wrote:
> > > > On 29.11.2023 17:06, Andy Shevchenko wrote:
> > > > > Make use of PINCTRL_GROUP_DESC() instead of open coding it.
> > >
> > > > PINCTRL_GROUP_DESC() macro from drivers/pinctrl/core.h contains a cast
> > > > to (struct group_desc), what breaks users of the above macros.
> > >
> > > There is no cast (*).
> > > Thanks for report, I will check.
> > >
> > > But this was v4 of the series and LKP actually sent a positive feedback.
> > > Besides that I have tested this locally with modules enabled.
> > >
> > > *) It's a compound literal, _not_ a cast.
> > >    Taking above into consideration I'm wondering what compilers
> > >    are in use?
> >
> > kisskb reported the following m68k failures to me:
> >     linux-next/m68k-allmodconfig/m68k-gcc8
> >     linux-next/m68k-allmodconfig/m68k-gcc11
> >     linux-next/m68k-allmodconfig/m68k-gcc12
> >
> > However, according to [1], linux-next/m68k-allmodconfig/m68k-gcc13
> > did succeed, so I guess you are using gcc13?
>
> Yes, I compiled with these:
>
> $ gcc --version
> gcc (Debian 13.2.0-5) 13.2.0

Time to install and try an older version ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
