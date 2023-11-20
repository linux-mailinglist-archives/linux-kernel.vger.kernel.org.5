Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64627F0E70
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjKTJFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjKTJF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:05:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F36D5E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:05:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-331733acbacso1533675f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700471113; x=1701075913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkLluJIfs9A2WfK4ws6uTuiWflu7QIwTGk5lEdGrZ8Q=;
        b=hUo+Pljdj6x5DCjR/jo7P1BtRCgtwcj5R+aXWuUgcTe5aDpa5k2//Bgtbu3Ls9SCsB
         fJ2CtzrsxrCXB80LUyj8UGgvAgyKbVbVjJOYubMepvOEjjpW6ANw1i+GQnzRRNztUK5x
         5EG+fr9meG3V1P5Py6rBU8Kp08piIKFYOpJN8aCN2HgPWjtSYVYfOOlwCyokisJYwdUC
         gOWjAHZen9uqfhrBOxF+m6RcQPhCgMA0hbgQ8tfcUd1pPlf0sZGggvNWKWvH5KMDiBoC
         /cRHWUF2epMv2Ml/Kbw7xmZ6HSavMtv+5mlRsddVFUVk1Il5fRcBN5T85wXqYcW2QE8x
         m5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471113; x=1701075913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkLluJIfs9A2WfK4ws6uTuiWflu7QIwTGk5lEdGrZ8Q=;
        b=C2s+CQcDcS3APiiZPDNh2pmEhBIDKeBmXlz3qfMqdrNab+8fl8Mdw//m1GFyyNJTC6
         pBaZLLXh296k2N1UXhEvBxW/1c7RqklTzoRP7J6PfBktIgFlOJLGeYQhxbKmXBEC5ajh
         HE4M+5JtZgmRcOV6cPV31Vris5LuYQXh3AnrnizAGaUjEvGlZaGlm2UVsMRLtr1Mj2De
         LWr8Bud1AHnyJ9Dl1kwfSMm4mAOUOVAA+9PXz8DKIRT+urNsr7dawBpPXtpXnixCeEWU
         xHD0EQRs/mU9t8yl7wBRw0Nqm36kq45MQcxvujbxpbs3Z8Vus4DHdc7oYBWRc6hYOVav
         m/2w==
X-Gm-Message-State: AOJu0YzSgiPX6RP4rTNi7Ivdp/FUP9fD7SFTwE03BeKejKZhdZjo6B9J
        OlvVI15vHjEXo9dmfbnEs0T3fg==
X-Google-Smtp-Source: AGHT+IFq74/v4yVRRxE+pvLLMGOf1Rfctzf+CaYkqnL15lGut/2IP8miObeas0tpSho4tWROmvLB0w==
X-Received: by 2002:a05:6000:2c1:b0:32f:c369:6b00 with SMTP id o1-20020a05600002c100b0032fc3696b00mr5665046wry.14.1700471112833;
        Mon, 20 Nov 2023 01:05:12 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4c92000000b00331424a1266sm10473085wrs.84.2023.11.20.01.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 01:05:12 -0800 (PST)
Message-ID: <ea3567ef-1293-4679-bd25-730c1b3e60b9@tuxon.dev>
Date:   Mon, 20 Nov 2023 11:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm: multi_v7_defconfig: Enable CONFIG_RAVB
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Davis <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-15-claudiu.beznea.uj@bp.renesas.com>
 <bd25377b-b191-4d81-b144-2936cb5139d9@app.fastmail.com>
 <CAMuHMdUkVO7cXpsHd_oGvEpZdJpP6GP+VC8H5GAZ94KJf2joLA@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdUkVO7cXpsHd_oGvEpZdJpP6GP+VC8H5GAZ94KJf2joLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.11.2023 10:58, Geert Uytterhoeven wrote:
> On Mon, Nov 20, 2023 at 9:44 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Nov 20, 2023, at 08:00, Claudiu wrote:
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> ravb driver is used by RZ/G1H. Enable it in multi_v7_defconfig.
> 
> Used by:
>   - iWave-RZ/G1M/G1N Qseven carrier board,
>   - iWave-RZ/G1H Qseven board,
>   - iWave-RZG1E SODIMM carrier board,
>   - iWave-RZ/G1C single board computer.
> 
> So I'd write "used by various iWave RZ/G1 development boards".

OK, I'll update it in v2.

I noticed it is needed while checking various bits on a RZ/G1H based board
so I considered that if there is at least one user for it it is enough to
have it enabled.

Thank you,
Claudiu Beznea

> 
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> We have a mix of =y and =m for ethernet drivers, and usually
>> only have drivers built-in when they are frequently tested
>> with NFS root booting.
>>
>> Do you need this as well, or could it be =m instead?
> 
> As the default chosen/bootargs for the iWave-RZ/G1M/G1N Qseven carrier
> board contains root=/dev/nfs, builtin is appropriate.
> The iWave-RZ/G1H Qseven board defaults to root=/dev/mmcblk0p1.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
