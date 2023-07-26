Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4365763E36
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjGZSP1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGZSPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:15:24 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B02E78;
        Wed, 26 Jul 2023 11:15:24 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1bb69c0070dso139391fac.1;
        Wed, 26 Jul 2023 11:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690395323; x=1691000123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxLo+ssfIcGr82bGMB16DLkdE3iFP1HlTtobqG8HjjU=;
        b=eLu2z0gBr3mJOhjjzDoDpgkGId/gi2rUTa6jkEoaH3BP4E+Qp6ZYw1RlD/08ntX89m
         TklHZdrOzLzpMkwz4QwfDTGwGlfK+rHbpODZb2pCBcdpQvb/ZO3TeXcRhdRjyoG2hUru
         +IggZU2z2wZa3AHo8kXsmsZ9Y9fT4P4RY190xr10GunQJKThLD16zFHCt++OKqwm9Zbl
         T2CH4zTLDOWt/UlzM+F8XW8+m0DERDrHLl84VQD5i0S1F2Db86I1i/ABih4wQkyUNNiQ
         VSTCg8cNDXARkRVeu+NuEhnmXm7wUkcgtPXNNLR/4u+a3AAuB8SMbqKqhaBODwJ9rUew
         pKDg==
X-Gm-Message-State: ABy/qLZ0cy42fNxRTMnivOgD5F49NtdMIIqDJK7VyzrADJJyf+ybukv8
        nlPK+RkDL24hwqrDCTcd6upjgdfeFma5PQ==
X-Google-Smtp-Source: APBJJlENQxxy9+hEQrtwV3ftQDOXryfK++Uc5gK5IcooB0jhaKarnClg9nIJJ0rlI/G+hi+UBbbtCA==
X-Received: by 2002:a05:6870:8197:b0:1bb:6c17:2715 with SMTP id k23-20020a056870819700b001bb6c172715mr340020oae.2.1690395323260;
        Wed, 26 Jul 2023 11:15:23 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id h185-20020a0ddec2000000b0057399b3bd26sm4302115ywe.33.2023.07.26.11.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:15:22 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d07c535377fso64793276.1;
        Wed, 26 Jul 2023 11:15:22 -0700 (PDT)
X-Received: by 2002:a25:8046:0:b0:cee:a470:89dc with SMTP id
 a6-20020a258046000000b00ceea47089dcmr2430924ybn.52.1690395322627; Wed, 26 Jul
 2023 11:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174028.4040093-1-robh@kernel.org>
In-Reply-To: <20230714174028.4040093-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jul 2023 20:15:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdqo-OFKtHdVNu77-cuS67Cvb6NV98eYK+gtba7ir5jA@mail.gmail.com>
Message-ID: <CAMuHMdXdqo-OFKtHdVNu77-cuS67Cvb6NV98eYK+gtba7ir5jA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Jul 14, 2023 at 7:44 PM Rob Herring <robh@kernel.org> wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch, which is now commit 657c45b303f87d77 ("MIPS:
Explicitly include correct DT includes") in next-20230726.

> --- a/arch/mips/lantiq/xway/gptu.c
> +++ b/arch/mips/lantiq/xway/gptu.c
> @@ -8,8 +8,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> -#include <linux/of_platform.h>
> -#include <linux/of_irq.h>

Based on https://lore.kernel.org/all/202307270140.uClzsYnD-lkp@intel.com,
I guess you need to keep of_irq.h for of_irq_to_resource_table()?

> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
>
>  #include <lantiq_soc.h>
>  #include "../clk.h"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
