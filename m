Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DC37AF994
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjI0EhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjI0Efw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:35:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718D2713;
        Tue, 26 Sep 2023 19:26:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-530bc7c5bc3so12180973a12.1;
        Tue, 26 Sep 2023 19:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1695781568; x=1696386368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emIKXtRIs/yM2DWwZD9zMtoiHVTkPPbqlVWgbeCiXyc=;
        b=DP/bBc/dIpsB5DhQVva+sSfLpN0+1lOOg6nw/SsMTCAoznpTyh/EmfVcCUW5vnRf8X
         y6U7KmkFWqEnq+yopqQRYjYHf5IXaL871jHrOBdU6c1hCFitnO6UX2keP1DxAy3WzvqE
         BNTCYAUgOm4xvMcYU54DuHaFc7cibNsT2aq4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695781568; x=1696386368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emIKXtRIs/yM2DWwZD9zMtoiHVTkPPbqlVWgbeCiXyc=;
        b=Z/lhA+NBoh7LDNvHpth6LRGwpEDf5KCsQk9bBS5XEzr6oji/wkmnSxBYeWoq8KkAFX
         aJOBHe7IQV/414fi0zed1yJOT4rw8e7aFnr1i40X28kSuVse1Je4OPQpAxfaejQww1Tl
         /TqBycF8ebV3lPgQJRjDeQk0vmYnajRRn3vkVaTYZVmT4mQVaoPX5gopSqomvxw0HALF
         NrQiY1V/zYTHIqmMuGBgM4ZX8x5hlWrambpkTJT289WgIJcHMzBN+YNDxpejhs4+YiFO
         XmGueOm8ZA351yetc5xIocwGz6Ora/Q4qJcjCz2fyCpRPs7RCbRWSjcAql0tM9CQYQtF
         y2iw==
X-Gm-Message-State: AOJu0YwTyFFQjV5eAbgVdFs3WiTRE7jFlcoomv990c4+0Lu/PybOB6J9
        Ekpna/RJNbfMls62SYIGX85yeaArvFqSSUGLFGY=
X-Google-Smtp-Source: AGHT+IHCCOjXb8+6pc5O9HOXdlXxVDhFBKsFiifAI3BglZZL/BL8JlMYEB/1h28CGguKKA8HQFS3La5RDl0OFTUHTbc=
X-Received: by 2002:a17:906:9a:b0:9b2:9d6f:2949 with SMTP id
 26-20020a170906009a00b009b29d6f2949mr400624ejc.57.1695781568293; Tue, 26 Sep
 2023 19:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 27 Sep 2023 02:25:56 +0000
Message-ID: <CACPK8XeROYz_XaB3TvUhdXm7Vm8fjC8yU+mfvA58=_FiDrBy-g@mail.gmail.com>
Subject: Re: [PATCH 00/40] soc: Convert to platform remove callback returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Huisong Li <lihuisong@huawei.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Zev Weiss <zev@bewilderbeest.net>,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Ruan Jinjie <ruanjinjie@huawei.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sept 2023 at 09:55, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> this series converts all platform drivers below drivers/soc to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
>
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
>
> As there is no single maintainer team for drivers/soc, I suggest the
> individual maintainers to pick up "their" patches.

I'd be happy if Arnd merged the lot at once. Arnd, what do you think?

If that will be too messy then I understand. I have queued the aspeed
ones locally and will push that out if we decide that's the best way
to go.

Thanks for doing this cleanup Uwe.

Cheers,

Joel
