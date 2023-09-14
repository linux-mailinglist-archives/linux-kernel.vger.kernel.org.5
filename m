Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F17A00C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbjINJuE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjINJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:50:01 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1BA210B;
        Thu, 14 Sep 2023 02:49:56 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5925e580e87so8546057b3.1;
        Thu, 14 Sep 2023 02:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684996; x=1695289796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfpp/Af3xabHlaVRlvYm0skC5SHxJ43BMDzzbLSj3YY=;
        b=d2VjYCL9WGpcWGFb3r0h0HQKuyy37v26Yl1wBdNuvxOe/kB5bvauwP9y3xYKl38l93
         fU/6cnafsd7tzqkne8SvUm2Ns+gTYcUUnCXg3N+QXvPGDHot+6Tf32xlVb6oVZmQpj4n
         Urbr/rNkhOl+0mM7TtG/KqRb0mZR6IW5jAthBrnk6mW83Up/nKUSZwWQcEWCnMkqMwc5
         i0YVL82IyAsmZpHh9ScxgYHnwnx7f9sDcUBO1wVZT64w9Hc/GKBTGoCi+/3XMj4GQwha
         tPwACCkmc1jPopje8xPjnCVHR6eA2sC9r3khZulgBb2jPwPiyweW+fc/QW9ZlHsUa+CR
         luqQ==
X-Gm-Message-State: AOJu0Yy+qNkw8QFKGrabgjUOgDhDfjDN6lzlchdywEV5aQgSxI0zPUHh
        vlLgBXxyXKVu03Mb/dKROpMcJSyqkqGi/g==
X-Google-Smtp-Source: AGHT+IFNZycGkuruh+1n989pMoRs4+4dNdg9II2A0bozZOUhGtbAaZyqTQvViAN8qyYD9Tdro6mICw==
X-Received: by 2002:a0d:d686:0:b0:577:1560:9e17 with SMTP id y128-20020a0dd686000000b0057715609e17mr5679286ywd.35.1694684995768;
        Thu, 14 Sep 2023 02:49:55 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id e9-20020a816909000000b00583e52232f1sm237323ywc.112.2023.09.14.02.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:49:53 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso799905276.0;
        Thu, 14 Sep 2023 02:49:53 -0700 (PDT)
X-Received: by 2002:a25:ad08:0:b0:d7f:8e1e:a95f with SMTP id
 y8-20020a25ad08000000b00d7f8e1ea95fmr4921480ybi.6.1694684992798; Thu, 14 Sep
 2023 02:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-5-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 11:49:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXyJ=e9DWadg9w5Ee3eCR6KcbTCFzRx4hG6wRpAcPu9w@mail.gmail.com>
Message-ID: <CAMuHMdUXyJ=e9DWadg9w5Ee3eCR6KcbTCFzRx4hG6wRpAcPu9w@mail.gmail.com>
Subject: Re: [PATCH 04/37] soc: renesas: identify RZ/G3S SoC
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

On Tue, Sep 12, 2023 at 6:52 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add support to identify the RZ/G3S (R9A08G045) SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
