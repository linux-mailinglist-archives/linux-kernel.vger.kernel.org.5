Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636CB7A616D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjISLhW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjISLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:37:20 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D13BA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:37:15 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d857847be8cso299280276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695123434; x=1695728234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqfdyP+EpBuCdn7wZEzEun0x9+Aw4VCooDZ7mf8oPiw=;
        b=gUCEDAvdpLcO+OdGpipJyocKRr5mXqVHXus2pv1c88Q0MAU+3L4x8zqgBT6uK5CRhG
         VUZpBX4ujaSDC9Pg2xcAHCr27PdDe9s7Ky/R775Sy7iZn7Y5WmDsNhypXLCQRzPAHlkN
         yY61xnl98Bf+xfh8ChAsn6EbzIAwhBYlCh4RXYPj685fuJISoKt22AQ+SZOwDtdKUyOn
         MsK/esUVqkbxdedj5ajhvjTnpvDKGPs4y+JBTqs1khdKr4gXhrdkSLMN4XnNeGAwkBiw
         acXsoMzs8z5EANA9TtG80M/Y9EeDMKOcQS4dNBu616TU0TVzG1SoB41htiUFPa+5tWFs
         Y5Tg==
X-Gm-Message-State: AOJu0YxA++DKVyE5WEo//h5r3EQ1G6J6pmXUFoQadLDIDovvhYRF0kiQ
        evOhn9garSU7UmPGTKtVQjM4T7BM2hv0uA==
X-Google-Smtp-Source: AGHT+IHURC6gxDWB9TTgGrYpnq+b/zklPlE+Eu6imr/GCzJvGHo2S+LaLJOIOvz3snMKZY3QvOfHmg==
X-Received: by 2002:a25:db0d:0:b0:d80:c80:af18 with SMTP id g13-20020a25db0d000000b00d800c80af18mr10463858ybf.52.1695123434161;
        Tue, 19 Sep 2023 04:37:14 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id m196-20020a25d4cd000000b00d814d8dfd69sm2838904ybf.27.2023.09.19.04.37.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 04:37:14 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59e7fb87f1cso27016977b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:37:13 -0700 (PDT)
X-Received: by 2002:a0d:d0c1:0:b0:571:11ea:b2dd with SMTP id
 s184-20020a0dd0c1000000b0057111eab2ddmr12291738ywd.32.1695123433030; Tue, 19
 Sep 2023 04:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230814173757.1747439-1-j.neuschaefer@gmx.net>
In-Reply-To: <20230814173757.1747439-1-j.neuschaefer@gmx.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 13:37:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTU8tN1QNrAT-BWgdrgzvJRvV6a30GcDAFq3qmF1CWag@mail.gmail.com>
Message-ID: <CAMuHMdWTU8tN1QNrAT-BWgdrgzvJRvV6a30GcDAFq3qmF1CWag@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Mon, Aug 14, 2023 at 7:38 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> Add a menu "Nuvoton SoC drivers" to make it easier to add other Nuvoton
> SoC drivers later on and to prevent asking about the Nuvoton WPCM450 SoC
> driver when configuring a kernel without support for Nuvoton SoCs.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com/
> Fixes: 7dbb4a38bff3 ("soc: nuvoton: Add SoC info driver for WPCM450")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
> - Add Geert's tag
> - Fix commit reference
> - Change Link tag to Closes

Any plans to move this patch and patch 2/2 forward?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
