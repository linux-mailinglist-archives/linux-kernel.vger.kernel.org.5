Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD37F772B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHGQfZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 12:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjHGQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:35:23 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F38B7;
        Mon,  7 Aug 2023 09:34:58 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a3df1ee4a3so2573583b6e.3;
        Mon, 07 Aug 2023 09:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426083; x=1692030883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qm+c7GltohnosvSp0amsQIL9B6A2dq128Kc+SejjEVU=;
        b=MmHuUdR1r6U5T1gFlyft8tLVT6JTGYXpuBI3GGAEGYdhyTcor/L0+WsEnqY8/GKhda
         Z6/y/5dEbe3/2quB12QrUMSFgUmQz2UGm2oNLFU0S+RgrHaEHhItUdVfC8+hEYPvqQg+
         drP7McCiPZtkm6TmAAcI1P2g8lRg+EToZ1JRsd9xLc+/AY2hg/sSiQYKsV5wOZaq463w
         15BedfEqkxpp6ypdLoZe3vp+TnKLAYkbpIw44yCw4u6Hydyl6V1B17u3LS83g3TpO/hL
         Fp8rKpjQLY4v6jiRZ3OYkFrHJ1//EjRaZhi5qKKA99CbS+ybE22bVj+DQ/JBDt2cTey+
         VdAA==
X-Gm-Message-State: AOJu0Ywdc8AZFDU71kgZbrCb+jNrgcDWX5+EXP/GN+XwUA3jKD3R2rO0
        Pk4XxgAKWdeI+P5UfN6j8EKdt00heI1fUQ==
X-Google-Smtp-Source: AGHT+IFaAfRsUiu0UcaER8GFaiv7RVNw5PXkzju+ILMuTkDEyKDMq9xefNZEzq/93d8/Ihtylj2IKQ==
X-Received: by 2002:a05:6808:2193:b0:3a3:9df9:1918 with SMTP id be19-20020a056808219300b003a39df91918mr9266350oib.20.1691426083445;
        Mon, 07 Aug 2023 09:34:43 -0700 (PDT)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id 206-20020a6300d7000000b0056471d2ae8fsm5063597pga.90.2023.08.07.09.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 09:34:43 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-269304c135aso2046396a91.3;
        Mon, 07 Aug 2023 09:34:43 -0700 (PDT)
X-Received: by 2002:a17:90a:a792:b0:268:1f0a:9f12 with SMTP id
 f18-20020a17090aa79200b002681f0a9f12mr9283382pjq.29.1691426082966; Mon, 07
 Aug 2023 09:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230802141829.522595-1-andre.przywara@arm.com>
 <20230804153432.GA1388331-robh@kernel.org> <20230807144229.5710738d@donnerap.manchester.arm.com>
In-Reply-To: <20230807144229.5710738d@donnerap.manchester.arm.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 8 Aug 2023 00:34:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v640tCyf6HU2KGHQnMpOXdDVM6UQKw=DpWi6zhhO+paQEw@mail.gmail.com>
Message-ID: <CAGb2v640tCyf6HU2KGHQnMpOXdDVM6UQKw=DpWi6zhhO+paQEw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt
 optional for more chips
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 9:42 PM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Fri, 4 Aug 2023 09:34:32 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> Hi,
>
> > On Wed, Aug 02, 2023 at 03:18:29PM +0100, Andre Przywara wrote:
> > > All X-Powers PMICs described by this binding have an IRQ pin, and so
> > > far (almost) all boards connected this to some NMI pin or GPIO on the SoC
> > > they are connected to.
> > > However we start to see boards that omit this connection, and technically
> > > the IRQ pin is not essential to the basic PMIC operation.
> > > The existing Linux driver allows skipping an IRQ pin setup for some
> > > chips already, so update the binding to also make the DT property
> > > optional for these chips, so that we can actually have DTs describing
> > > boards with the PMIC interrupt not wired up.
> > >
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > > Hi,
> > >
> > > arguably the IRQ functionality is optional for many more PMICs,
> > > especially if a board doesn't use GPIOs or a power key.
> > > So I wonder if the interrupts property should become optional for all?
> > > After all it's more a board designer's decision to wire up the IRQ pin
> > > or not, and nothing that's really related to a particular PMIC.
> >
> > I would say yes. Particularly if it gets rid of a conditional schema.
>
> I see your point, and we might get there, but after some digging extending
> this to more/all PMICs needs more work, see below.
> Given that I was wondering if we can merge this patch now, as this
> blocks multiple DTs from being merged (and Connor already ACKed it).
> I sent an MFD driver fix to make this actually work for the AXP313a:
> https://lore.kernel.org/lkml/20230807133930.94309-1-andre.przywara@arm.com/

Question is which tree we merge it through. We can't merge the DTs without
this guaranteed to go in the same cycle without causing DT validation
errors.

ChenYu

> For supporting this on more PMICs:
> Currently many Linux (sub-)drivers registered by the MFD driver crash when
> there is no valid interrupt registered, and we so far just special cased
> the very simple PMICs to skip just the power key driver registration,
> which works for those chips. However this affects more drivers (I tested
> ac-power-supply), so it's not clear if that's really something useful for
> the other PMICs providing more functionality. I guess we can postpone this
> until either there is actually a use case for those other PMICs (boards
> without the IRQ line connected), or when this list of exceptions grows too
> large.
>
> Cheers,
> Andre
