Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4164379DFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbjIMGVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjIMGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:21:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C036D1731
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:21:17 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8162698f0dso113704276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694586077; x=1695190877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoXC3yvfBpLixJRP91CxkpaobvElPhxw8dM6b9Mxn6o=;
        b=o40OJaDk9g0w2AxrWox58yIuDWuvuUs7PGiee3VNNchrTkzBWKUB+7vEpZa+X2pxpJ
         WiimXR92zkl1ylB+V0EGEQXK5ZOa+hmZpuOywF53zL7B+3fHsx68WhTIDDXIlQfmqmx/
         T7hSY//3Xh4J5fto92KXR7MrkVnJwQWuFtiQkw2HFjp777TgfOzELqG/uW49tm8NobYf
         Bv479J/meaEzy+pH3lq2tyce7Z7GtB5urrgiKxa5ow0VTChvsYifNTAN9CUtye6wOvbZ
         BZtUpAZbwLtj6XFm9njaWP7DaA+llnjvg2rL34DEJ9Z4b038Cl7MtrLZ22uPtHLsIg5f
         Gcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694586077; x=1695190877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoXC3yvfBpLixJRP91CxkpaobvElPhxw8dM6b9Mxn6o=;
        b=n2n6stjdZ3F4T3C6S+LN9KW6pIB7MidWI+5dhpe4vHbwe+yWI0m4rTFHqws7zkgjdv
         xZ3tNi4YwA2+Y9m3D1bpvf5MEHzEbQVN3aNBAHCm1NlxLtn/IEoYscJCqbu4DfUqO67V
         HhaDZsxdIdLSpJFnmH3idc1j5c030/acYpBYpjZIXZLEdg01heuXPfftEXaTUBCb11vX
         GsinUfUpb1g4izktveGiOAi+EqBGyIQPtO0+new/DwSbuD0dq+/aWvlfSdEy1l7tkAI1
         cR5tl1dqnHI7lEpz0lq5Zjpbx0Bhc1OJoSB35lfK1xvE1/CZ7XotdLrlk275QohTI1dO
         tYEg==
X-Gm-Message-State: AOJu0YwinGai2zHgNoTtI8wfoWn7aeQ0kob4cEv/Lz6Ug2pE/Q5LDsxS
        iP5uLoGKpGbUInSINzmbtf3bjv/Doygdh/MTiDrWsA==
X-Google-Smtp-Source: AGHT+IHv9uix8l+Zc0n109BayrmZNR9aXP3GoZYplPy00RAPTywtz3MWTii/2pyuXGKFoos6xg7sPLyQy/fCkiT3ZYU=
X-Received: by 2002:a25:e08b:0:b0:d7a:b8e1:eda3 with SMTP id
 x133-20020a25e08b000000b00d7ab8e1eda3mr1391697ybg.29.1694586076927; Tue, 12
 Sep 2023 23:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230912221127.487327-1-ulf.hansson@linaro.org>
In-Reply-To: <20230912221127.487327-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 08:21:05 +0200
Message-ID: <CACRpkdb4S7JUOTiX8-2hr6D1p11gGv_K6UrzrEa8BbiryH9Mtw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: Rename the genpd subsystem to pmdomain
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Olof Johansson <olof@lixom.net>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:11=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:

> It has been pointed out that naming a subsystem "genpd" isn't very
> self-explanatory and the acronym itself that means Generic Power Domain, =
is
> known only by a limited group of people.
>
> In a way to improve the situation, let's rename the subsystem to pmdomain=
,
> which ideally should indicate that this is about so called Power Domains =
or
> "PM domains" as we often also use within the Linux Kernel terminology.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Why not.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
