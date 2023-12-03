Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EEE80254F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjLCQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:08:59 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E1CA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 08:09:04 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AFB613F322
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701619742;
        bh=Jr2viQE+KNXdoLwjt3YG8fOnB+WKPmtD8qV0RS5wcNE=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SIihe6oh8Pdg/qzj6ZLeulNjUKAEY45iD1C8Y/jpN0FxCuX2ETt716dOAsORS97Ps
         a1uf5lM6VcCn9E3oVhMu3fhyhiJoboAgpsYExq/KQ1nen2N2S2YBLFhB83zxkIU1CK
         NOuOLsUnPeBl38U95GCTX6PFtCoemsqw5vqvrTuu/jA/KhEPlJzN1gajiNmlTjv0U8
         u3Trk+aLtJqeB06EsxkASd43Gvn4I9M7EJA/5cGmVqR3nzEvAcOsU1sNOOeeoWcG3A
         EBWgsHEffQaZKUgWyZiEAxUMPB2dTWVyHbhEyzpInhAZ9FupqVZ0GvAeriyVzjlF1T
         Udb7SW279X9bQ==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-423e22075f4so53278581cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 08:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701619741; x=1702224541;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jr2viQE+KNXdoLwjt3YG8fOnB+WKPmtD8qV0RS5wcNE=;
        b=qhiQJacWWZhWxATTi0I5ZE0S3sDOpMZbZ118ouDLp4jxOP0/lSHGzHx7ghj/0tJk4L
         xQiKT6HUs9rCpaUELDRf5cv1wgF0T0W2Koi/exOwe6rcmoNebrpTzi7FM2fJJAbbJZlI
         vH8iNg/7rmCScBTSj/hho8pt9ZSCH+EzmfHjDEbaIctfRYj1rGMsyznxMYc8/v4qai1Z
         xJUfuIVlgP0M5LjQY2TBmcjwLkO2SBqIwAOD17Xoz4DrVuB6UFOMKOhL8Hd+W8g+dY3B
         se+vWmuII52+KuJQqwuI6hzxbTIxvq0NBvncJtJJvzrGHLw8jtxNS2s+Di0Y8T4HJzMM
         uuRA==
X-Gm-Message-State: AOJu0YyLoC3t8Z4crA3nKX7NkawwMA+jZQn5hCzN8JFbhNj20GA8i7px
        dMkZxYpGZxmgQvAzFiLYPlqsXmiBxTCEU7yacw4FY6gRhFdKaKWFlyQawudvW1jgGuZk4bQQS5L
        tiW11Q7wPYQ0TXNiCGIuj+xdwOeibpwOVZLrfvlIIlkPKOn3vqBEdfgR8lw==
X-Received: by 2002:a05:622a:1010:b0:425:4043:1db6 with SMTP id d16-20020a05622a101000b0042540431db6mr4559531qte.137.1701619741644;
        Sun, 03 Dec 2023 08:09:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElcjoXi0CImvP0OyCrnumGiuHmDr6BY0KTDzIC+pp9TQpbbFvQn54i+0pGeMyf5ZofZVoSlxlxQt+VbXqNHm4=
X-Received: by 2002:a05:622a:1010:b0:425:4043:1db6 with SMTP id
 d16-20020a05622a101000b0042540431db6mr4559513qte.137.1701619741411; Sun, 03
 Dec 2023 08:09:01 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 3 Dec 2023 08:09:01 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231203-mountable-snowsuit-24e4252c9eb5@spud>
References: <20231130-bobbing-valid-b97f26fe8edc@spud> <CAJM55Z9=smqcZ=su1oNdk1YZL_XdYAKrwtrZS7ScS=cAVmxZOA@mail.gmail.com>
 <20231203-mountable-snowsuit-24e4252c9eb5@spud>
Mime-Version: 1.0
Date:   Sun, 3 Dec 2023 08:09:00 -0800
Message-ID: <CAJM55Z-cb=0X2xToKnEwmqMkBSZkQ-kjAZyoGo1AY=edTLvxew@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: starfive: move timebase-frequency to .dtsi
To:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley wrote:
> On Fri, Dec 01, 2023 at 02:44:58PM +0100, Emil Renner Berthing wrote:
> > Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Properties fixed by the SoC should be defined in the $soc.dtsi, and the
> > > timebase-frequency is not sourced directly from an off-chip oscillator.
> >
> > Yes, according to the JH7100 docs[1] the mtime register is sourced from the
> > osc_sys external oscillator through u74rtc_toggle. However I haven't yet found
> > a place in the docs that describe where that clock is divided by 4 to get
> > 6.25MHz from the 25MHz.
> >
> > I expect the JH7110 mtime is set up in a similar way, but haven't yet dug into
> > the available documentation.
>
> Your other reply suggests that this is a fixed division for the jh7110,
> in which case it makes sense to leave it as-is. mpfs is different in
> that it is fixed to 1 MHz regardless of which of the permitted external
> oscillator frequencies you use.

This is what I've found for the JH7100:

osc_sys (25MHz) -> u74rtc_toggle (gate) -> ? (div 4) -> mtime

The divide by 4 is not in the regular clock tree, so if it is configurable it
must be some bits hidden in the syscon area or something. The only restriction
I've found in the docs is that it must be strictly less than half the rate of
the core clock.

For the JH7110 it goes:

osc (24MHz) -> rtc_toggle (div N) -> mtime

..where N defaults to 6 and this is also the maximum N.

/Emil
