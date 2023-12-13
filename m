Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33548110B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378799AbjLMMFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjLMMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:05:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF35B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:05:20 -0800 (PST)
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B0F2D3F286
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702469119;
        bh=ed/4z9K37WF1+ypqnAItmB7J3yVCg6lzXveMVJNIB+I=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=smIesrYJpscZxloUefgTPLm9pjHmYAbyliUxqFWNWExa7S/6j5I28PBlgJJ8x7USl
         3O4ncWgyzy3F22gInJTSF4tV8xphNY2F/CC8E6Gxa9yEAwDdowosPnVylryN8B3jTP
         qdcvA8a/x9R93amX0mO3JnkMHXl5RI6iPn8LPfQrrNM9zlcaE6e88i81iOAkL9GIFp
         J21Ui9f+PJZyEL+HJJ4Lp4P+GyK+WXGaq2O+Xe+FdUeDOnBajvEbnUrBLNjkMX6eN/
         jZuuwKw2lhhotMenNnjph5wJkeJAyVstLE+DPhA/IQ3E/T5GmKggVOygQP0UxkSyp1
         ROZxhDtUUnenA==
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77f4cf43569so782877885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469118; x=1703073918;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ed/4z9K37WF1+ypqnAItmB7J3yVCg6lzXveMVJNIB+I=;
        b=lonElSJfz5Bo24S+XFUItk1c/n4asXTYWVNgCT0kQbhE4Z/r8+qiCDUNn5tivg2fm1
         3QnUaS3NISiuajk415jFxVJm+9WqCIEj23VL+ZcU/zI90sfSnLkx5oMkbuEqoj5U880O
         Kn3e2GIGBwxsmeVmNOIrJDvAWsADTndo55BpDuhyzFLMo0ehGSHxSDSko8QrkI2DEq8v
         kgnEA+WvxUJUnF9csJ9cTp1ahbE0TM3hJDY+rbGi+IwxTuFqXZeUCivjq85bFTEHKc29
         JFecej+fIjkSe1TlmV4a3caYyLFVSqABnHDkdJsRJC2viLeD/Kz+ONKGXDXouEaWJCkh
         F7eA==
X-Gm-Message-State: AOJu0YwjIRusxxiTfIcI7hcpcyS9Ws924OaIHw9FjUsl4vD/JIvvDKLC
        XSFQcWtYNk/gHk/U+AdPGBQ0tRnPrmwcPX8WFZbNTgtbBfxVr7pFflBOeuNie3lhO4sX6Ly7rIe
        nOMAhgzLCkWOxyIqvjkhgLleM0uXDVpnpK7MbEdi23YigZqUHx6evJo0g2g==
X-Received: by 2002:ac8:5cc8:0:b0:425:4043:763d with SMTP id s8-20020ac85cc8000000b004254043763dmr11389700qta.101.1702469118714;
        Wed, 13 Dec 2023 04:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9QHKlpfiHiwknItMSza3ZGQwZtx+b52QZTd9pTWAuKsITQLCClWyurTTqXFX6DTkIy2rCL/jyIwRxWdAltnE=
X-Received: by 2002:ac8:5cc8:0:b0:425:4043:763d with SMTP id
 s8-20020ac85cc8000000b004254043763dmr11389680qta.101.1702469118472; Wed, 13
 Dec 2023 04:05:18 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 04:05:18 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <a554a163793e4513b25766c21ddc3f02@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-7-jeeheng.sia@starfivetech.com> <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
 <a554a163793e4513b25766c21ddc3f02@EXMBX066.cuchost.com>
Mime-Version: 1.0
Date:   Wed, 13 Dec 2023 04:05:18 -0800
Message-ID: <CAJM55Z_3Mty2LftPVkQC1wbwtGeznMMAk9mAjH_GoNuL7CKtaQ@mail.gmail.com>
Subject: RE: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock generator driver
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JeeHeng Sia wrote:
>
>
> > -----Original Message-----
> > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Sent: Saturday, December 9, 2023 12:25 AM
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
> > Subject: Re: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock ge=
nerator driver
> >
> > Sia Jee Heng wrote:
> > > Add support for JH8100 System clock generator.
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > ---
> > >  MAINTAINERS                                   |   8 +
> > >  drivers/clk/starfive/Kconfig                  |   9 +
> > >  drivers/clk/starfive/Makefile                 |   1 +
> > >  drivers/clk/starfive/clk-starfive-common.h    |   9 +-
> > >  drivers/clk/starfive/jh8100/Makefile          |   3 +
> > >  .../clk/starfive/jh8100/clk-starfive-jh8100.h |  11 +
> > >  drivers/clk/starfive/jh8100/clk-sys.c         | 455 ++++++++++++++++=
++
> > >  7 files changed, 495 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/clk/starfive/jh8100/Makefile
> > >  create mode 100644 drivers/clk/starfive/jh8100/clk-starfive-jh8100.h
> > >  create mode 100644 drivers/clk/starfive/jh8100/clk-sys.c
> > >
[...]
> > > diff --git a/drivers/clk/starfive/jh8100/Makefile b/drivers/clk/starf=
ive/jh8100/Makefile
> > > new file mode 100644
> > > index 000000000000..af6a09e220d3
> > > --- /dev/null
> > > +++ b/drivers/clk/starfive/jh8100/Makefile
> > > @@ -0,0 +1,3 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# StarFive JH8100 Clock
> > > +obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)		+=3D clk-sys.o
> >
> > This will name the module clk-sys, which is way too generic. Please nam=
e this
> > clk-starfive-jh8100-sys similar to the JH7110 drivers.
> Just realized that I haven't reply to this comment.
> I can't give it a longer name otherwise compiler will throw warning.
> That=E2=80=99s why ends up to use a shorter name and keep it under jh8100=
 folder.

I'm sorry, how does that make any sense? If the compiler can compile

  drivers/clk/starfive/clk-starfive-jh7110-sys.c

just fine, then why would it have trouble with

  drivers/clk/starfive/clk-starfive-jh8100-sys.c

/Emil
