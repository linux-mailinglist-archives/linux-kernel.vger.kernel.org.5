Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3EA793BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbjIFLxD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 07:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjIFLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:53:00 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE2BF;
        Wed,  6 Sep 2023 04:52:56 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59234aaca15so36366747b3.3;
        Wed, 06 Sep 2023 04:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694001175; x=1694605975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l619IiJ0KCtPDL+pldHQPgfnh20UhK/b+vepWlezdcI=;
        b=dudaA4fjypyFwhP+hu2gSd9Ordd7BJMHvRM9myK0Mu/Hknq0+xkQ9b7dtMc6hmdmgH
         WsTVoTaGKYhxCeEkhrPLVGdHP4Wyr0rDUtr3a3UqevWI6GwIoAh8/7jInXtOH1po35tg
         4r1G8bbaouriLUVhfF/zv58BlXgAxqdpE/jvCoVw7yFEqr6o/+MumECeAlCmxItvLVSp
         iNg8I6zD0IXIm4oeMgBoA3LeA4eal62Uy1pxz7+nY5HWNb4Zs4d6IelZ0BkiBSHxKXiU
         Vpa5c1j2unytMyIQdaq6Bkhfm806cTRS3bpe2UlZqVmEihI6elikNfzzH4aPwJ0wjfyS
         L3hQ==
X-Gm-Message-State: AOJu0YwubUvcZ4oZaQMFd9A1414gd3x2F1F06EakLjcRFoLi0RIX42nF
        4VciHbUkoaHHHdWTHN2GgnAV/utf5MjF4g==
X-Google-Smtp-Source: AGHT+IEqW2hWMENiEEBhkk0PRki4fAE8Cr7AYpaV681T0HgxDzyIdsRSvskuMMvi2MsRuHn+gZx7Pw==
X-Received: by 2002:a0d:c004:0:b0:592:8893:3fa2 with SMTP id b4-20020a0dc004000000b0059288933fa2mr15966536ywd.29.1694001175229;
        Wed, 06 Sep 2023 04:52:55 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id p189-20020a815bc6000000b0054bfc94a10dsm3705390ywb.47.2023.09.06.04.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 04:52:54 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d77ad095f13so2698370276.2;
        Wed, 06 Sep 2023 04:52:54 -0700 (PDT)
X-Received: by 2002:a25:ca17:0:b0:d7b:7249:6dc3 with SMTP id
 a23-20020a25ca17000000b00d7b72496dc3mr15978642ybg.53.1694001174255; Wed, 06
 Sep 2023 04:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230905231342.2042759-2-contact@jookia.org>
In-Reply-To: <20230905231342.2042759-2-contact@jookia.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Sep 2023 13:52:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhHbdxFqqKdnrGV=Goax-ewpPh109b2Tfm8v+BE5d8aQ@mail.gmail.com>
Message-ID: <CAMuHMdXhHbdxFqqKdnrGV=Goax-ewpPh109b2Tfm8v+BE5d8aQ@mail.gmail.com>
Subject: Re: [PATCH] can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set
To:     John Watts <contact@jookia.org>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 6, 2023 at 1:15 AM John Watts <contact@jookia.org> wrote:
> When adding the RISCV option I didn't gate it behind ARCH_SUNXI.
> As a result this option shows up with Allwinner support isn't enabled.
> Fix that by requiring ARCH_SUNXI to be set if RISCV is set.
>
> Fixes: 8abb95250ae6 ("can: sun4i_can: Add support for the Allwinner D1")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/linux-sunxi/CAMuHMdV2m54UAH0X2dG7stEg=grFihrdsz4+o7=_DpBMhjTbkw@mail.gmail.com/
> Signed-off-by: John Watts <contact@jookia.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
