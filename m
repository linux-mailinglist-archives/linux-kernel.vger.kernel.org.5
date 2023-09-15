Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB37A1BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjIOKKF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 06:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjIOKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:10:00 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4773C00;
        Fri, 15 Sep 2023 03:07:42 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d81a4b96a86so1199536276.1;
        Fri, 15 Sep 2023 03:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694772461; x=1695377261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCP/bqHWsbn9rerqUX6579e9W6CEA2JjevHJAYB2WlM=;
        b=d65mVpClZuyfNtBBTQH/yzhzukFOun4S7STjxpUK69MmRBDD77no2UfgOF5mWBSQcW
         CevdvQZyx9uFprMHrfCTR3/VV8+m6rKO4QDg0VzV4v/QAZ3FW0GCZ8ZACX8gAc4wtXwc
         X8rD0EPccISfO27/hdh8z2aRstnQgmTZL9iqFcvlU1KMTL0d1ICJYq3uszHzWJqne+wZ
         8+HC9jlm5lOk+MPuPaLJyeiZ8IFIyJ2UnHLqtunZ7v60B+rkESG5F5hAZEepIywcJQ0B
         On+A8BUGviIErHH0csSzkOOjPTLyLkw1fwGk2sDJBO36B9WzwMF4dF4yCckXTBNyxMmR
         p2RA==
X-Gm-Message-State: AOJu0YyKQlnh0Roo4+TxL28wm+nwn87xYiWAejTDmUayYPK3NNdHU/x2
        7g7+sta3Wy9sXbRmYNodrRqRKZE/jq3rnA==
X-Google-Smtp-Source: AGHT+IEMINmp4SZbisd5naO2sFqvzSF7Oxj7vfW266wLQGHh+XfpsgEjubz+5M5MdFPaWU+71BhrdA==
X-Received: by 2002:a25:1343:0:b0:d05:1e5c:1127 with SMTP id 64-20020a251343000000b00d051e5c1127mr899696ybt.49.1694772461224;
        Fri, 15 Sep 2023 03:07:41 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id l198-20020a2525cf000000b00d801440ed1dsm759766ybl.23.2023.09.15.03.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:07:41 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d81a4b96a86so1199530276.1;
        Fri, 15 Sep 2023 03:07:41 -0700 (PDT)
X-Received: by 2002:a25:dcc3:0:b0:d62:6514:45b7 with SMTP id
 y186-20020a25dcc3000000b00d62651445b7mr688004ybe.37.1694772460915; Fri, 15
 Sep 2023 03:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230915092003.658361-1-ulf.hansson@linaro.org> <20230915092003.658361-2-ulf.hansson@linaro.org>
In-Reply-To: <20230915092003.658361-2-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 12:07:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-JrRn51dBk=K=JDtBP7HAp+GGTx_EqP7bZvQxHY0J2w@mail.gmail.com>
Message-ID: <CAMuHMdX-JrRn51dBk=K=JDtBP7HAp+GGTx_EqP7bZvQxHY0J2w@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] pmdomain: Prepare to move Kconfig files into the
 pmdomain subsystem
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Rather than having the various Kconfig files for the genpd providers
> sprinkled across subsystems, let's prepare to move them into the pmdomain
> subsystem along with the implementations.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
