Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9805A7EEDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbjKQIsi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Nov 2023 03:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:48:37 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C79126;
        Fri, 17 Nov 2023 00:48:34 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7afd45199so19981577b3.0;
        Fri, 17 Nov 2023 00:48:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700210913; x=1700815713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhrXwIKU30ZSa3FIJd7wo49zA9taMAmAe87pzVISU2s=;
        b=n1qetcUnl0KTzgpkjo0CQjSEEJCfrIrPr3Qhl4t2P7jKNcmLBlKn4hGQNLc8zoMmFb
         hTApT5QFPHVbQiimPJk4hOGBKV8MViA+y/PdqwvLPgB3k2KZo0PQE+lOZXmjLkKzx/ru
         0RkiBKR5Tp5jajzNUUWPMab9bxcu506Hwp8MV3EudCA0wxBllszRBXroLAf36F/NmM9i
         1t0266D3+7diRYE8EoLGGm/9GhhSnnxq3ZFN+gKMTqN6tCk4TzOlkAW8GTQarhH9Jz9J
         9WTfK6Z1sSeri1tjUWY71eS++z4pCTPy5N7wolQ0dFdoxMK6qEwfJi2oI8cGmOC6lypG
         h7BA==
X-Gm-Message-State: AOJu0Yw3DqQB/CjZnNbH8Bqhnu9xMmIhTwDS4toZlma12YqM83m+oB83
        4F9RJhqGfmDnorZ9l+srjZzvkni96tKA8w==
X-Google-Smtp-Source: AGHT+IECsLlMQpJ6nnTdwHHrg7O8CnjcAJcb1JdwV9+7hMGLW3fQTJd5O960wgBQw3xrFRbghMHsaQ==
X-Received: by 2002:a81:4f03:0:b0:5a0:ae01:803c with SMTP id d3-20020a814f03000000b005a0ae01803cmr20419057ywb.38.1700210913035;
        Fri, 17 Nov 2023 00:48:33 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id bc26-20020a05690c001a00b005c864816364sm175379ywb.75.2023.11.17.00.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 00:48:32 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a7afd45199so19981247b3.0;
        Fri, 17 Nov 2023 00:48:31 -0800 (PST)
X-Received: by 2002:a0d:e695:0:b0:5a7:b723:8fa3 with SMTP id
 p143-20020a0de695000000b005a7b7238fa3mr19688056ywe.26.1700210910922; Fri, 17
 Nov 2023 00:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20231016105344.294096-1-claudiu.beznea.uj@bp.renesas.com> <20231016105344.294096-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231016105344.294096-2-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Nov 2023 09:48:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXC2zm9FqQH1XX51bANnYA+ezPoX2WHPMdC2J1euN+_RQ@mail.gmail.com>
Message-ID: <CAMuHMdXC2zm9FqQH1XX51bANnYA+ezPoX2WHPMdC2J1euN+_RQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for the update!

On Mon, Oct 16, 2023 at 12:54 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add SDHI2 to RZ/G3S Smarc SoM. SDHI2 pins are multiplexed with SCIF1, SSI0,
> IRQ0, IRQ1. The selection b/w SDHI2 and SCIF1, SSI3, IRQ0, IRQ1 is done

SSI0

> with a switch button. To be able to select b/w these a compilation flag has
> been added (SW_SD2_EN) at the moment being instantiated to select SDHI2.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.8, with the above fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
