Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6487A17BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjIOHqj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjIOHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:46:37 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1751724;
        Fri, 15 Sep 2023 00:46:32 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bc9c01e154so1552326a34.0;
        Fri, 15 Sep 2023 00:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763991; x=1695368791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlbDJ1qD3XxXTi41UC3S2BlvV/2SQ/t6iNEBcbR7qLI=;
        b=aiuL7fpsv0tnBSe7fAemXaIzjoblR1Riy7l58iQtM+Jk/MV6KIqabBHpw/5eTP68SW
         XYE/IEwrucS2f0HyCZdRi0USb2yj/kwszQAZXOjoZ/pviSstKNseaPluufLT1950Sv79
         9037GTQEyG+0/SAPJOeXXhCUhG0AIvH2/89G7KbI4DTu2zDxg9vaOJld8V8BkYP+b0yM
         Zt7DlCXOI4paetfZyg92cA0S13VOKI5eKsVR0QhdFGJOo4mRP+MH2nsQP4ZRSMw6klqS
         0VqnHvjsR+4lJUGNFB4lmd4o/6suuyVYw/ruz5UeCU3pYHOhiGHalkL7OL05WdpvZV0z
         GV8w==
X-Gm-Message-State: AOJu0Yx85kHoQOEHgelRO6HwXqsvuKsmy1BP8RXmzcJmpWTZkVz2XkGP
        WQw3RvAi36KrTJSdRzS9x5ZQ8OcoU3V/mw==
X-Google-Smtp-Source: AGHT+IGEnDpC9B5m9B6LcLfFhO7Fw46r+1mX05cdGH7KIAitVPxvYKi70sEXSP5fT1vSBCkgWFSLHg==
X-Received: by 2002:a05:6870:d1cf:b0:1d5:a22d:3020 with SMTP id b15-20020a056870d1cf00b001d5a22d3020mr2810004oac.3.1694763991248;
        Fri, 15 Sep 2023 00:46:31 -0700 (PDT)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id ed23-20020a056870b79700b001cd14c60b35sm1663538oab.5.2023.09.15.00.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:46:31 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5739965a482so1021534eaf.0;
        Fri, 15 Sep 2023 00:46:31 -0700 (PDT)
X-Received: by 2002:a25:cf55:0:b0:d7a:c85c:7254 with SMTP id
 f82-20020a25cf55000000b00d7ac85c7254mr937969ybg.21.1694763526785; Fri, 15 Sep
 2023 00:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
 <20230912160330.GA864606-robh@kernel.org> <CAMuHMdWxKFrTi7c0Df0cHLrVFt3=a7UOy0jnKxsG8PEuD=15Pg@mail.gmail.com>
 <c199fb5e-927c-aa39-ff3a-3a7906fadec0@linaro.org>
In-Reply-To: <c199fb5e-927c-aa39-ff3a-3a7906fadec0@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 09:38:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwFnirDL7=06YofG5ON5U+eMUfe=JGAoU+X8rZWokS4g@mail.gmail.com>
Message-ID: <CAMuHMdWwFnirDL7=06YofG5ON5U+eMUfe=JGAoU+X8rZWokS4g@mail.gmail.com>
Subject: Re: [PATCH 21/37] dt-bindings: clock: add r9a08g045 CPG clocks and
 resets definitions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Claudiu <claudiu.beznea@tuxon.dev>,
        mturquette@baylibre.com, sboyd@kernel.org,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Sep 15, 2023 at 9:24 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 14/09/2023 17:26, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 6:03 PM Rob Herring <robh@kernel.org> wrote:
> >> On Tue, Sep 12, 2023 at 07:51:41AM +0300, Claudiu wrote:
> >>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> Add RZ/G3S (R9A08G045) Clock Pulse Generator (CPG) core clocks, module
> >>> clocks and resets.
> >>
> >> This is part of the binding, so it can be squashed with the previous
> >> patch. The ack there still stands.
> >
> > Usually we keep it as a separate patch, to be queued in an immutable
> > branch, as it is included by both the clock driver and by DTS, but
> > not by the yaml bindings file.
>
> Binding also should be shared, so you get compatible documented in both
> places (thus lack of checkpatch warnings). It still should be one patch.

Hmm, I see your point...

For core Renesas SoCs components where I am (sub)maintainer for both
the driver subsystem and the DTS, I can take care of that.
For the generic case, that will need a lot of cooperation with subsystem
maintainers, to create lots of small immutable branches with DT bindings
and DT binding definition updates.

Alternatively, are you (the DT maintainers) prepared to handle all
DT bindings and DT binding definition updates, and create immutable
branches for all of them (in a timely manner, of course)?
Then we can start enforcing the rule that driver and DTS updates must
not cause checkpatch warnings for missing compatible values, and must
not be applied without merging the corresponding immutable branch first.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
