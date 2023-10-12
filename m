Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F047C708D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376440AbjJLOoZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjJLOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:44:24 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A4BB;
        Thu, 12 Oct 2023 07:44:22 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d9a398f411fso1132377276.3;
        Thu, 12 Oct 2023 07:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697121860; x=1697726660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlohsKaxaDfJsNn0JXsIdvrAgoGkujT/EvyViDc7jh0=;
        b=iVaApVkpKZ0pZLEK/pwPLTGauu7UeCClkUXAvxljBqIBU1NUZs6cKGofDWJThZovdD
         R+PdLalbZM71D7ARoXO/MV4ug5UKaBN7EYKhisGUarhoFIB+u2aDKmjvKNryIMT2aIqO
         7/rZpngyCi+cRcrWj+Ljwabg37SERfQgi8WtaeQYVTNWOPdTwmY3Eiqo5b1d91OgEU+X
         OwM7HO8hcBH96SMHCWMZBR/flQmynraseXWZKASSLNXhZLvq6nY7oVyQoeYKpb3MecBD
         rLfQkWBHPsC4Fb2NSAEY87llPNTUsHsTAyzbENvMh2nqQoc9g1o8gON/b/XWCkwsTVFk
         wCvA==
X-Gm-Message-State: AOJu0YzhgL2UMdRD2jcmbJXTtWBs89z1oEWz3+mXltBwiC9qNGDczA/L
        056Ay9qlISdQmNim66B0mJc/KD8J7n4cnQ==
X-Google-Smtp-Source: AGHT+IHL1VVdNNqwHnZcPkiD9AZddyC3g7gvOS4O13vQR8K7sd/ecIhw/doKpo16fiV6v+feVkzXxQ==
X-Received: by 2002:a25:ac46:0:b0:d9a:53cc:aaad with SMTP id r6-20020a25ac46000000b00d9a53ccaaadmr8935045ybd.24.1697121860167;
        Thu, 12 Oct 2023 07:44:20 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id z96-20020a25a169000000b00d8128f9a46bsm2632ybh.37.2023.10.12.07.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 07:44:19 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7ba0828efso13058287b3.3;
        Thu, 12 Oct 2023 07:44:19 -0700 (PDT)
X-Received: by 2002:a0d:e2c4:0:b0:5a7:bc38:fff2 with SMTP id
 l187-20020a0de2c4000000b005a7bc38fff2mr8513742ywe.15.1697121859775; Thu, 12
 Oct 2023 07:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231010132701.1658737-1-claudiu.beznea.uj@bp.renesas.com> <20231010132701.1658737-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231010132701.1658737-6-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 16:44:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW+5MZXRbDtZtmrMkrCtwqqKUcW_W1_5U_2yO6w6aCa_w@mail.gmail.com>
Message-ID: <CAMuHMdW+5MZXRbDtZtmrMkrCtwqqKUcW_W1_5U_2yO6w6aCa_w@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: renesas: rzg3s-smarc: Enable SDHI1
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
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

Hi Claudiu,

On Tue, Oct 10, 2023 at 3:27 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add SDHI1 to RZ/G3S Smarc Carrier-II board. This is connected to a uSD
> interface. Although Vccq doesn't cross the boundary of SoM it has
> been added to RZ/G3S Smarc Carrier-II dtsi to have all the bits related to
> SDHI1 in a single place. At the moment SoM is used only with RZ/G3S Smarc
> Carrier-II board.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> @@ -11,6 +11,27 @@
>  / {
>         aliases {
>                 serial0 = &scif0;
> +               mmc1 = &sdhi1;
> +       };
> +
> +       /* Reserved regulators 0-9 for SoM. */
> +       vcc_sdhi1: regulator10 {

You can use sensible names for the regulators to avoid conflicts.
E.g. "regulator-vcc-sdhi1".

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
