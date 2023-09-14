Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75297A00B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbjINJt0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Sep 2023 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjINJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:49:26 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B43E3;
        Thu, 14 Sep 2023 02:49:21 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59bbbeea69fso8778527b3.0;
        Thu, 14 Sep 2023 02:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684961; x=1695289761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gFLY2IMJxQUgyhc4c6QO4qakT/ISmys8Z8hG9m2OZ0=;
        b=iyLqbP09/fI0q2uTcLxZMBuNRcXKOsZsUum0LY4k598lh3MSCLYLhSLyFVfuuP+lzF
         6wU0kPdWXusTun5TrBXZmQWqbt3gc+Xof3hY1qOIRBr4RwUKBWN7mnCy++CAjcgWrVsw
         XlAnH33K0bno/aDKnFhxrqQM+SVndKp3eiiLGU8I7KyTFYDrN2kb3WM0sVmAJNFh7iO+
         jFPMhnP1/uVCj/ebsWmygd61mT3ChmdD99FND6kfmHUuJUZ3uzkFR1ekKl9tlp50gm/o
         PAlG90iEDtE0NKUAMpaWVd8TnckKqJBwYSh073R3n68Yiuz7IMXBlflnRsRoHAzgC06U
         4f9A==
X-Gm-Message-State: AOJu0YyrP0ukobi3dWgaYLj0afVO0kLWikOZolLO69J9wYvkXwZreY1M
        WZF+dMEoF8c1UXK7ACJfEnw3sBTExw/AJw==
X-Google-Smtp-Source: AGHT+IFp9ulQBIKOKi9VDoashW8zbaOQfXpQJiQhP3lQPQJdqOSO2x9xLrL4P0fMJ1m1P1uUGUdBuQ==
X-Received: by 2002:a81:de4f:0:b0:592:ffc:c787 with SMTP id o15-20020a81de4f000000b005920ffcc787mr4514871ywl.30.1694684961014;
        Thu, 14 Sep 2023 02:49:21 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id q66-20020a815c45000000b0059b547b167esm239119ywb.98.2023.09.14.02.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:49:19 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7b91422da8so755976276.2;
        Thu, 14 Sep 2023 02:49:19 -0700 (PDT)
X-Received: by 2002:a25:87:0:b0:d44:af:3cce with SMTP id 129-20020a250087000000b00d4400af3ccemr5046648yba.27.1694684958968;
 Thu, 14 Sep 2023 02:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-3-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Sep 2023 11:49:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSFkeV0u1GsQox1EQZzOHBrhV5roRLp17VCZRCQzkDZw@mail.gmail.com>
Message-ID: <CAMuHMdWSFkeV0u1GsQox1EQZzOHBrhV5roRLp17VCZRCQzkDZw@mail.gmail.com>
Subject: Re: [PATCH 02/37] dt-bindings: soc: renesas: document Renesas RZ/G3S
 SoC variants
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
> Document RZ/G3S (R9A08G045) SoC variants.
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
