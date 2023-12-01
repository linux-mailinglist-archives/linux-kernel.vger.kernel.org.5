Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33318800CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379097AbjLAOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379101AbjLAOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:05:37 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2161722
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:05:42 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5cdc0b3526eso17982817b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701439541; x=1702044341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S981KapfzO045oI7EezmWMBJ8fVn+98mRDxQPvPZv8g=;
        b=V4trwNxFf+s7KYOqzzLek9nMTOpq3xYJz9nrOKvoJn7RAI7+g6JBhG9uFOYiO9BMna
         zPok0K+ZnEJw3c+ZEIuldKepv2m+T7vGOU01V4kDVSxBhcg4YEybYL+kXsfpPPKKp2s9
         9PRjGvWuTA4MbFHG96kM9ohUvPvIiXyHwxlwjRb/izsXem80byp+t1Y+T2gwo2zlflge
         ZXSZ1AyZS01G7zcHB7LfW97KUBXbDJdCo/TnH7PUCLNBC/1aiqukYZqdQILkvBLvyVdg
         qdSx+8nFVTEVKhPIvVP94F7xi0TkawDPg6nmuoLAO3z/WPOlrhABWV4Hhi9kIrfU1qe2
         n56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701439541; x=1702044341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S981KapfzO045oI7EezmWMBJ8fVn+98mRDxQPvPZv8g=;
        b=indeIQ+wZqvZMqglJIu6jTeuYgRxN5vfc7nyDPdOZEUtdZvZP3VvzPGHHBvPCjK8eO
         1K1HBNtPFyH+83c1kaa6A7W8QfY15rvQwQZiMgy928Id2mY+eLyOSIN0tE6cRNfgORgR
         PEgVeprLMu4J18rVwPbO3wudilkmWAQhZvp6AVOAWUXIFBHzKSeGjT5yJrW/ilbkF/Dt
         tEPbPYaTdNzorDp1NLNjo0d8qMVBEI+JdSOLuAivf0QhVdl1/k3LV91zzaYJW5iu3bza
         mksk62xDYNbFcE3ArlVvXLvSPnJum3d3ao2r5VC0Li+5nYbqXJbI1TE7TCdI4wuzNAnT
         8AaA==
X-Gm-Message-State: AOJu0YwtZ5wmiKwiAF6JEa9b/ex/AvBpa4Cepo9gGEpcHbGeMd3wr0x7
        VmwZXPivXZTb796/lIr1wbW3RUYcaYPXwmq6VDRfcA==
X-Google-Smtp-Source: AGHT+IGgZieAgbL8W8KVNwc6EnusoD/krGGnayXbUe4OQQFB/f3qh/vCdT4Gm9aE0Qgd6YmyIbk9BOCGJMnoZgchng0=
X-Received: by 2002:a81:a184:0:b0:5d3:b71b:4d30 with SMTP id
 y126-20020a81a184000000b005d3b71b4d30mr3497574ywg.17.1701439541650; Fri, 01
 Dec 2023 06:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Dec 2023 15:05:30 +0100
Message-ID: <CACRpkdZAriTP3iOgmwvoAH-3-aO_ugoEkBHE7mHH5YLxhMXSXg@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] pinctrl: Convert struct group_desc to use struct pingroup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The struct group_desc has a lot of duplication with struct pingroup.
> Deduplicate that by embeddind the latter in the former and convert
> users.
>
> Linus, assuming everything is fine, I can push this to my tree.
> Or you can apply it (assumming all CIs and people are happy with
> the series).

I applied the series to devel so we get some rotation in linux-next,
augmenting the relevant commit messages as discussed!

Yours,
Linus Walleij
