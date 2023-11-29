Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE127FDD39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjK2Qg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjK2Qg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:36:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42910A;
        Wed, 29 Nov 2023 08:37:01 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfa7be5650so13421955ad.0;
        Wed, 29 Nov 2023 08:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701275820; x=1701880620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDYi0w7H+J+q+dM9ucawgoKr/ctQDdxFveeMbGCHqgs=;
        b=CbVZmAqIjZJqcvnM1Qy+OLHpsdg+RuL6QSYn6cnFgIwvTEtJ8Qe/1czzuRReq5k+pn
         cY8nFT/994cGbpi06YeurnMU8LX57wiZdcds41dmORZY77PiJDF4l8bikE0Z8alP085+
         9pze1+YgJY4lGfsjE08oc6QNI71em697umzxeCgWNFiAdG0D02NO4GbTEaq0Kb4nlSpI
         UgEd5H9DTbevpwKbVXiebsPCt0jjjru5+A99DmP0vX2t8YvnKBP917zSpfkOryPDbUNR
         lWmeG1hvu/5YHQ2aNPPpdZ1Sg+1hWMkd8A8uNiunZIlJn1J+gy/hFbwhYlu8yDiKh444
         56Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701275820; x=1701880620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDYi0w7H+J+q+dM9ucawgoKr/ctQDdxFveeMbGCHqgs=;
        b=QS1SWHMJR3HFMHT8hQzhXYwU8DhfRNxoD4gydqxs3/bN+/FUEyB2hSvpkEKi7zArPT
         YXYZsEsppv0z4rA1MiuseMqXShHEg4iqa3z65hH/ndi0XfdjUUJcMNshCa9I7mlMybfX
         YA3T7AyF/G5ZR69RFhhOdgnthXeksvuW4DsK7mR88+BMkWkENVVmt5lfEjwqtiKMuN0a
         AOoiJ52dsrCdqUaGPDmMDXMjAlNZUGVsKju8HmtSOOXJwUNHTBEf26YyfJVXQ3TGkGfg
         s57Iqhb8lKM4YNI/ga7cTQ1kOlYwyfWz/2P895DTzLqEZ+qtf23qKWuk3InAp3vF4Lly
         /bcw==
X-Gm-Message-State: AOJu0YxdaMbPeyC049qBWmxsUYfWhu9GzGHvHlRvS5etsN16/yWWA9Yk
        0yo9cTXEjkgVuyBZfar6MjKUcEVQ+shglk358SM=
X-Google-Smtp-Source: AGHT+IEHOS/VoqEOAE9S0a4Bo0mCXwMfAjLAWB11WdwDsJGo7JPiUty3L8kqBCtFFqb6Z8cDlcEqIcrQbJXKS8k7E9Y=
X-Received: by 2002:a17:90b:358f:b0:285:59aa:fceb with SMTP id
 mm15-20020a17090b358f00b0028559aafcebmr18947614pjb.4.1701275820473; Wed, 29
 Nov 2023 08:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com> <20231129161459.1002323-17-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231129161459.1002323-17-andriy.shevchenko@linux.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 29 Nov 2023 13:36:49 -0300
Message-ID: <CAOMZO5CZpQjWKimNReUkwHOc-mF8vWoq2HDhjGKSu6E3g5-aVw@mail.gmail.com>
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

Hi Andy,

On Wed, Nov 29, 2023 at 1:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Convert drivers to use grp member embedded in struct group_desc.

You explained what you did, but you did not explain the reason.
