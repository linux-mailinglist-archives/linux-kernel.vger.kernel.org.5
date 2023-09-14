Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7777A08DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbjINPSj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 11:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjINPSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:18:38 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D41FC9;
        Thu, 14 Sep 2023 08:18:34 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bb07d274feso578512a34.0;
        Thu, 14 Sep 2023 08:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704713; x=1695309513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BChh75bEcSaxJJl7tWdTOKHuwxeHKids/7PeYE9C1lk=;
        b=pzDlu0D3gD+EcN3FbCB2NvMr0w1wrHPurro6WU5x8aSx4D15rZSMI7o0YYdyJy1np/
         iXZSGQn/FKyJChCCz0qJW9XSRMOBatV3iVIG1+sOIVEDBc3KGMgOW0lzsmnCMASWiVXB
         vFf04eFD82g6CXiRvGBe16u/Xso9kz42WPYjlWd5YFyJOpiKIdToAdCQQUgLMIh3IPvK
         tfWfr29zagVCOvj0Uaj/lK+OW9zREprs0f+kZ/nZMylQW65rCLGNdhiVw0e+M1xnV0eB
         TNU1O004k0UA5i1Z5rhmS6k6cu8qKxZuKmY4hrLcrbE/CjyLZsk8csYUw412ags4Ke4Q
         Bxxg==
X-Gm-Message-State: AOJu0YzLc5Yz7RvvtDerA5qNOa/6BMUFMwy5s4QSiXSQ5d/tot+TkOcK
        o/AZPCISJw8ZuT2gdBvhcvYo+4QsKsfFfQ==
X-Google-Smtp-Source: AGHT+IH7eOlatrKAriczeEhXliYekYxTLUMmJPuJ3Ded22iwaHaQ9y/VwgW1ogmQWKkZggtrABH3jg==
X-Received: by 2002:a05:6830:22d1:b0:6bc:f6d0:87d4 with SMTP id q17-20020a05683022d100b006bcf6d087d4mr6445767otc.29.1694704713411;
        Thu, 14 Sep 2023 08:18:33 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v82-20020a252f55000000b00d8161769507sm375918ybv.25.2023.09.14.08.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 08:18:33 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d8198ca891fso674171276.1;
        Thu, 14 Sep 2023 08:18:33 -0700 (PDT)
X-Received: by 2002:a25:ae28:0:b0:d7a:d628:f69d with SMTP id
 a40-20020a25ae28000000b00d7ad628f69dmr5882414ybj.32.1694704712931; Thu, 14
 Sep 2023 08:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-18-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-18-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 17:18:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXL6oEb_ydbB0ZA0HEgnAwi9R_ZQnsJWvB-f8tzmG-RDg@mail.gmail.com>
Message-ID: <CAMuHMdXL6oEb_ydbB0ZA0HEgnAwi9R_ZQnsJWvB-f8tzmG-RDg@mail.gmail.com>
Subject: Re: [PATCH 17/37] clk: renesas: rzg2l: remove CPG_SDHI_DSEL from
 generic header
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for your patch!

On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Remove CPG_SDHI_DSEL and its bits form generic header as RZ/G3S has

from

> different offset register and bits for this, thus avoid mixing them.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/clk/renesas/r9a07g043-cpg.c
> +++ b/drivers/clk/renesas/r9a07g043-cpg.c
> @@ -14,6 +14,13 @@
>
>  #include "rzg2l-cpg.h"
>
> +/* Specific registers. */
> +#define G2UL_CPG_PL2SDHI_DSEL  (0x218)
> +
> +/* Clock select configuration. */
> +#define G2UL_SEL_SDHI0         SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 0, 2)
> +#define G2UL_SEL_SDHI1         SEL_PLL_PACK(G2UL_CPG_PL2SDHI_DSEL, 4, 2)

As all three above are local to this file, the "G2UL_" prefix is not
really needed.  Removing the prefix (in all files affected) would
make this patch smaller, though, and would make the DEF_SD_MUX()
declarations (which keep on growing) shorter.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
