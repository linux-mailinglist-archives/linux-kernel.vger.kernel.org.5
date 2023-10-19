Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4A07CF2AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjJSIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSIeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:34:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7B611B;
        Thu, 19 Oct 2023 01:34:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2400DC43397;
        Thu, 19 Oct 2023 08:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697704462;
        bh=NhE5UIsqUJ4efk9oQr6qapwxmbKSoNoKRWUzC+fdU/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mfOJFjvNTwSFckxY8HVYKBdkuAvKK2M1sGBFjPYxaefFJOs25rTAhU+Rz/XkzUDsP
         7ZG6NVlLtrmyh2UnWdcTTvKnv0Ri9cTPDKnnP8QKgoDoQte2xDFxuqHh+2CFJni6OH
         UnpSCujhj0HqMbcfS4yyAemzQCrEcGslxDqcd+joFCb/HlB9dYh+6QLIzjscIvWMCB
         h0p3a4ysggwrxmCyWDOHqdti1U9h9XmWwvUKhrItqUaZSFYQRW3xh6eG5Uyags4OOl
         kIpJPJHJDIEKQp20gjbHYBc0ytizLGA52FaVFGs5LAn97piCYpUebHipa9tJal98Oi
         rmq6AhSP9zb8w==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso1158721a12.0;
        Thu, 19 Oct 2023 01:34:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YwYzLsNEpIaQBHWwnvuYjBWZI2B5DxhBz2HwcPrOHMEGlxjfD0k
        XcqqZXTuAprq99czDj8J8lFjF4tjsa5SDnpDVzE=
X-Google-Smtp-Source: AGHT+IG1scZ789rr7dQG139RsrK3rRMsLv+J/dEBVZhjOtJ1+/tUHJQBuLx63Z1s4dB1EVoakod2MaMhPSLUphq3mAo=
X-Received: by 2002:a50:9353:0:b0:53d:a18d:73b4 with SMTP id
 n19-20020a509353000000b0053da18d73b4mr998683eda.12.1697704460540; Thu, 19 Oct
 2023 01:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com> <20231017-th1520-mmc-v2-1-4678c8cc4048@baylibre.com>
In-Reply-To: <20231017-th1520-mmc-v2-1-4678c8cc4048@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 19 Oct 2023 16:34:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSZPR1Gxj8sCB6Q7KiJiYot60qryEzt8GFwtwMubFBWsQ@mail.gmail.com>
Message-ID: <CAJF2gTSZPR1Gxj8sCB6Q7KiJiYot60qryEzt8GFwtwMubFBWsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 4:45=E2=80=AFAM Drew Fustini <dfustini@baylibre.com=
> wrote:
>
> Add compatible value for the T-Head TH1520 dwcmshc controller.
>
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index a43eb837f8da..42804d955293 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -19,6 +19,7 @@ properties:
>        - rockchip,rk3568-dwcmshc
>        - rockchip,rk3588-dwcmshc
>        - snps,dwcmshc-sdhci
> +      - thead,th1520-dwcmshc
Acked-by: Guo Ren <guoren@kernel.org>

>
>    reg:
>      maxItems: 1
>
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
