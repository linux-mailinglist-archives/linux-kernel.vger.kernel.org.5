Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB09A7F29D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjKUKKv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 05:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjKUKKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:10:44 -0500
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB110E;
        Tue, 21 Nov 2023 02:10:38 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a877e0f0d8so49403457b3.1;
        Tue, 21 Nov 2023 02:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700561438; x=1701166238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoVtVz3fpUU/SjmxthCzYdpUjh79x4EQaoeFPJrIWPo=;
        b=to19NI5qblF5dtBm5vlNSBQPDNeb/dqOSV+4K18kbQNVpATw/ugGV55Vk/Db6seHZG
         1Mu99jiCjdLAGGsJWDlAJviyKIGNaOhpwQMRZU6l3TDFSutLSVR0PfJsyUR0738eSv7D
         9SwdONsVLPoziGTFkpDXGnRnVNj1+P7o6uXnyKbx6frzaaCjHRET02LvIfPhI+ZiqQJK
         5aLJSifdzU4jYwrRSvui2f3JDpRuPOnV1OiIB2RSb+8tMCt8/QSVFox5UB/Zjw5Pmtri
         oeOSeF1EjuYD326yIBkTuJXo6qorfIkKq9gbacV/t4lwHt47eV3tmX9ge11WW+rIrT+B
         ytzw==
X-Gm-Message-State: AOJu0YypOnRNOqfY0UTGDZ1RsEsODG9Y+hh5W9VbLMy9rNRT079UUwY/
        Idm8571Cj2sgTc4z80za+WQcpEARy5KxVslj
X-Google-Smtp-Source: AGHT+IHWw4m4D3bN6Xmo7kWfh4Cac9alp2eV6jg3UT+M0lDoSzGIJzfdzsieTV20MhikFbcMUlBzmQ==
X-Received: by 2002:a5b:711:0:b0:db3:84cc:3f59 with SMTP id g17-20020a5b0711000000b00db384cc3f59mr1679598ybq.10.1700561437948;
        Tue, 21 Nov 2023 02:10:37 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id e201-20020a25e7d2000000b00d9cbf2aabc6sm602536ybh.14.2023.11.21.02.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 02:10:36 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so4154667276.0;
        Tue, 21 Nov 2023 02:10:36 -0800 (PST)
X-Received: by 2002:a25:cb54:0:b0:db3:52de:1d96 with SMTP id
 b81-20020a25cb54000000b00db352de1d96mr1711069ybg.15.1700561435204; Tue, 21
 Nov 2023 02:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20231120111820.87398-1-claudiu.beznea.uj@bp.renesas.com> <20231120111820.87398-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120111820.87398-5-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Nov 2023 11:10:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmk+DM3FH2qBJDLCeRaCYzXLJbgAAf3ZRO0+U9CqpejA@mail.gmail.com>
Message-ID: <CAMuHMdVmk+DM3FH2qBJDLCeRaCYzXLJbgAAf3ZRO0+U9CqpejA@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] irqchip/renesas-rzg2l: Document structure members
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
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

On Tue, Nov 21, 2023 at 7:16 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Document structure members to follow the requirements specified in
> maintainer-tip, section 4.3.7. Struct declarations and initializers.
>
> Link: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
