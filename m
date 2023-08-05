Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F1771127
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHERuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHERuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:50:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B835AA;
        Sat,  5 Aug 2023 10:49:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcd6c0282so450153666b.1;
        Sat, 05 Aug 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691257793; x=1691862593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYJH/1P//NwsKipiDkgfl/z4aZz2q+xkqCsqTOu5Bf0=;
        b=j/mPVWvYXvbo/U83l1AGEhWBbnbL5ajrpLlTTSCXbdaJLSvpWA8XqfqCvpKRezoFL4
         GDCsmSuw4dObYIn1NQHIrtO7ZljDdV247wdhWW9+Cpfz688iwYU7cQKJu8T7/HeszQsu
         +gOMBaXAsF7foZDrq8HVld7TYkXDQW+G3tzwyD91WjNo33t6Kge2uh7vGnl85cJX+P2T
         V62JC9p/sXMehHtY70AFIe2oLRP5xx/e6aaK28Uh53j+ytu8bBbd8/iOo+q7pwuDOAcS
         7egsQyG0sDLHfjw1HKaoZ1wV0CIE8QTdpfWHlZNK7w4Krg8Mxi8EMbY2Url/mmGqVuOu
         4Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691257793; x=1691862593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYJH/1P//NwsKipiDkgfl/z4aZz2q+xkqCsqTOu5Bf0=;
        b=ihBy1agR/z4cQ81YN6x9YESZwq8IgeMBQXPs1DJD5yyojORrNcj7AaVsukaP5rQXBC
         qnwIG7fWHJF2coGSVZN4a6w9LDvGgdfliDXccCGUsx79SJD8JbiXHf9fMSOP2DzQsqDy
         H/i1++ZjRTajfGLRqNrwuft4IROruWPnr5gvB2lk8vjKsScTKsk+Bsm3poEFBX6jyNcF
         HgLooSauRfNK92t5ivxEAsoLF1CgPxx7kbvK53a1SJiahdkkEEI1Q5lp650KrU1/Bs3K
         G2kPmGQsO8THH3Lu5KnqTaG/h9kPovZCcDGSb3Mmhqbt8v+3yQ7QfwqkjQVhrVW3C7OH
         o62g==
X-Gm-Message-State: AOJu0Ywn3B6SMCrmLxbnQaOl2H1ApNF224cCVwz3PDZdfqzbdsN69lsc
        FiuSVPuhIJK4Kq8JtYuPKtc=
X-Google-Smtp-Source: AGHT+IEj+JsLAYsRvKq5tljy3+gyroq6CmwWB5RDT+QP3IP4h/PpnBkxNteaPS5GTU473Jm9OxjtOg==
X-Received: by 2002:a17:906:14:b0:98e:1156:1a35 with SMTP id 20-20020a170906001400b0098e11561a35mr3934964eja.74.1691257793309;
        Sat, 05 Aug 2023 10:49:53 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906138800b00992ae4cf3c1sm2938044ejc.186.2023.08.05.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 10:49:52 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maksim Kiselev <bigunclemax@gmail.com>,
        John Watts <contact@jookia.org>
Cc:     aou@eecs.berkeley.edu, conor+dt@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, mkl@pengutronix.de,
        netdev@vger.kernel.org, pabeni@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org, samuel@sholland.org,
        wens@csie.org, wg@grandegger.com
Subject: Re: [PATCH v2 2/4] riscv: dts: allwinner: d1: Add CAN controller nodes
Date:   Sat, 05 Aug 2023 19:49:51 +0200
Message-ID: <2690764.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <ZM5-Ke-59o0R5AtY@titan>
References: <20230721221552.1973203-4-contact@jookia.org>
 <20230805164052.669184-1-bigunclemax@gmail.com> <ZM5-Ke-59o0R5AtY@titan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 05. avgust 2023 ob 18:51:53 CEST je John Watts napisal(a):
> On Sat, Aug 05, 2023 at 07:40:52PM +0300, Maksim Kiselev wrote:
> > Hi John, Jernej
> > Should we also keep a pinctrl nodes itself in alphabetical order?
> > I mean placing a CAN nodes before `clk_pg11_pin` node?
> > Looks like the other nodes sorted in this way...
> 
> Good catch. Now that you mention it, the device tree nodes are sorted
> by memory order too! These should be after i2c3.
> 
> It looks like I might need to do a patch to re-order those too.

It would be better if DT patches are dropped from netdev tree and then post 
new versions.

Best regards,
Jernej

> 
> > Cheers,
> > Maksim
> 
> John.




