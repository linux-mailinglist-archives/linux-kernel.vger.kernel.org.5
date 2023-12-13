Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B098110A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378636AbjLMMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjLMMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:00:25 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B68E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:00:31 -0800 (PST)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 88D4D3F15F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702468830;
        bh=d2k9g+CDQlS0u/Axm3QhPzDXMJCmIzyDAkyUWJItYfY=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=PEysiXbrq77iErl9Dy9xuktY9UE28lQ8J7sAyn8ziwf6BhVlpWHFHL0J2+bJMgjkT
         cvk+7dBm6jDSJLzQYrmkNVV2a75kbTn2ycDZECJmYqMSUzR0DI3rXNsOkZTEq9/EKW
         e477U8PijvoUOROR+evBYViExVZ/IZHGtbqAjAjWn3jKY/0504aIzwOPFuWLCjTr2+
         JjA3FuAFC6uWpkp+Dp9njtWDixEbQB7JUSlhLT0Fv27P90kZsRqw6VjQ6Xuh/T7Gsa
         /1TDcWlq/vE76sxQGtymrRelxlE/QPvpCi2Qcm+mATGi2E315cpf3zZbYX5Gpyr+jw
         in2SUmvXX+awg==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77f2d8199e4so926045785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702468829; x=1703073629;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d2k9g+CDQlS0u/Axm3QhPzDXMJCmIzyDAkyUWJItYfY=;
        b=CXFqRG8KOFyykUEzyvVN+IxA1OmcjkA/z4miqfNUzXtUsWs4daSbMRfUAn50CHGswR
         M1OiFwEKgePySqwE0yeJkgBsuqUUUMisq9tW4ISoHxbiT6lwSI8pEi3vX0Yaf07N+7ek
         0JD8fFM00YU5rQCygK2qonqkfigQiqsKpIZixWBmnzypD2cG8/8TniG1Y8xOroYJLF0d
         8Za5Zp2zLDGiDG5PgFpudmzr2jw+5DxlOtJuaFHPRFrl9+FRrg3nnGcD9v/d59AKxC6x
         tHPkGuXWnDQFdvB2rVJtmdb0tigIsqJROrt9peqLDqbm/eI4dXG4zApFmvEaHItFw5C6
         Trgg==
X-Gm-Message-State: AOJu0YwiyEGvUavO4xcpOnBL9mrjuYaf98qEaaadyTyPkf67iXoicWVd
        0HVLVOMsk+3+6X8TFz0LJkgTQiLrAusyuJAooL7ElGkUE59iLVRgsXYT5VQfSqwA8V6Iq/kF76H
        i4O/C41/idyYJp7S9bnl18jIg45kzFivB4vz3p5ko7lQA+Pqf6YEo2k7Fzg==
X-Received: by 2002:a05:620a:1d97:b0:77d:88cc:e759 with SMTP id pj23-20020a05620a1d9700b0077d88cce759mr9425944qkn.44.1702468829686;
        Wed, 13 Dec 2023 04:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQyE19HlHZoU/6ZbCTx8+T9R2+zaT+Qju6cnML0AE3RTJpk0HMKR1T19a5ApinlnNf+jiWW68wxrNoj0JLy3s=
X-Received: by 2002:a05:620a:1d97:b0:77d:88cc:e759 with SMTP id
 pj23-20020a05620a1d9700b0077d88cce759mr9425929qkn.44.1702468829479; Wed, 13
 Dec 2023 04:00:29 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 04:00:29 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <56031a2fadf442e297b1e0ea03777e5f@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-8-jeeheng.sia@starfivetech.com> <CAJM55Z-FXV-Go4yj_AJyU4pRC0msHqTCT3q24HkNtBTWW9rAgA@mail.gmail.com>
 <56031a2fadf442e297b1e0ea03777e5f@EXMBX066.cuchost.com>
Mime-Version: 1.0
Date:   Wed, 13 Dec 2023 04:00:29 -0800
Message-ID: <CAJM55Z8ndFEg1gqk5=HydjN93iKY-f0k=FDpcL-hYH+_GA4Taw@mail.gmail.com>
Subject: RE: [PATCH v1 07/16] dt-bindings: clock: Add StarFive JH8100
 System-North-West clock and reset generator
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "conor@kernel.org" <conor@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JeeHeng Sia wrote:
> > -----Original Message-----
> > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Sent: Saturday, December 9, 2023 12:37 AM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>; kernel@esmil.dk; conor@=
kernel.org; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; paul.walmsley@sifive.com; palmer@dab=
belt.com; aou@eecs.berkeley.edu;
> > mturquette@baylibre.com; sboyd@kernel.org; p.zabel@pengutronix.de; emil=
.renner.berthing@canonical.com; Hal Feng
> > <hal.feng@starfivetech.com>; Xingyu Wu <xingyu.wu@starfivetech.com>
> > Cc: linux-riscv@lists.infradead.org; devicetree@vger.kernel.org; linux-=
kernel@vger.kernel.org; linux-clk@vger.kernel.org; Leyfoon Tan
> > <leyfoon.tan@starfivetech.com>
> > Subject: Re: [PATCH v1 07/16] dt-bindings: clock: Add StarFive JH8100 S=
ystem-North-West clock and reset generator
> >
> > Sia Jee Heng wrote:
> > > Add bindings for the System-North-West clock and reset generator
> > > (SYSCRG-NW) on JH8100 SoC.
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > ---
> > >  .../clock/starfive,jh8100-syscrg-nw.yaml      | 119 ++++++++++++++++=
++
> >
> > The JH7110 clocks, the JH8100 system and always-on all follow the Xcrg =
pattern:
> > syscrg
> > aoncrg
> > stgcrg
> > ispcrg
> > voutcrg
> > etc.
> >
> > Is there a reason the north-west, north-east and south-west breaks this=
 pattern?
> > I'd have expected them to be called something like
> > nwcrg, JH8100_NWCLK_*, JH8100_NWRST_*,
> > necrg, JH8100_NECLK_*, JH8100_NERST_* and
> > swcrg, JH8100_SWCLK_*, JH8100_SWRST_*
> >
> > Just like all the other Starfive drivers.
> Understood your concern. We don=E2=80=99t have the intention to break the=
 pattern,
> but the reason we skip the SoC_ prefix is that the SoC names were already
> defined in the header file with the SoC name.
> However, I can put it back, of course.

Yes, all these 3 JHXX00 drivers are almost identical. There should be no re=
ason
to name any one of them differently. Having them all be as similar as possi=
ble
will make it a lot easier to maintain in the future. If you don't like a
pattern then please change it for all the similar drivers and don't make ju=
st
one of them be different.

/Emil
