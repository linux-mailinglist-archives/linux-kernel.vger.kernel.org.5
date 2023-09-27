Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D497AFF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjI0JLW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjI0JLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:11:16 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F86BF;
        Wed, 27 Sep 2023 02:11:13 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59c0d329a8bso131600407b3.1;
        Wed, 27 Sep 2023 02:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805872; x=1696410672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kT5xQELVLk7uusSSsznnnd5tIH8qDLjO1UEAzy07OsA=;
        b=Yuo+bPsfxjO0oPNDawp8TCWQLa85WrM80BTN0oAutD1V3p0Osszngb0DyEtD2+n7r7
         0AgXQRBfOF6JkDknZQV2r+SJwJkbdhDtjviDQPjMib2p/wvWkXOkr4a39fpArHTH8tWb
         f21MPgznaoIZDNjxQCxbyRvHBOMW2emxqYtIkbzb30itOVv0WmQjwCT0It5OLyO2Yzda
         768qZAYKAxqqgoqsU3vKLIKpnOCi5JZgqNdMgn/PMUlb4aco/qAK7EQwaHjuHWp9lyip
         68qooiqSefN9R5N10HDQ5EYhL7gq+5u8D6FFqb39avt0bS7PnzwUe4XCLmhx5jMzhoNP
         EF7w==
X-Gm-Message-State: AOJu0Yw/RWvtbj6Zy9xIHwyR+qola6TqgimVK80q8U0w6FmwT1sjSaEE
        2EU3sKl+uTgpBBTeewUh7k0Fj/84UJ6LHg==
X-Google-Smtp-Source: AGHT+IFJ74w9GvEdlwxKPeVi2H1pLKC9BHDPLx0a2JuDv/hhfQKppSj6zXfXnv9pu61WI/PN78QHKA==
X-Received: by 2002:a0d:d415:0:b0:569:479f:6d7f with SMTP id w21-20020a0dd415000000b00569479f6d7fmr1702501ywd.43.1695805872377;
        Wed, 27 Sep 2023 02:11:12 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id gq10-20020a05690c444a00b0059f5828346csm2374946ywb.3.2023.09.27.02.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:11:11 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59bc956b029so131375657b3.2;
        Wed, 27 Sep 2023 02:11:11 -0700 (PDT)
X-Received: by 2002:a0d:c946:0:b0:59b:fb69:1639 with SMTP id
 l67-20020a0dc946000000b0059bfb691639mr1846689ywd.32.1695805871578; Wed, 27
 Sep 2023 02:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com> <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
 <ZRPvHJXbuZ9Db2Go@finisterre.sirena.org.uk>
In-Reply-To: <ZRPvHJXbuZ9Db2Go@finisterre.sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Sep 2023 11:10:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
Message-ID: <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related properties
To:     Mark Brown <broonie@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Sep 27, 2023 at 11:00 AM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Sep 27, 2023 at 09:59:05AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Sep 26, 2023 at 11:08 PM Fabrizio Castro
> > > +    type: boolean
> > > +    description:
> > > +      Use CSI Slave Selection (SS) pin to enable transmission and reception when
> > > +      in slave mode.
>
> > Can't this be done in a more generic way? I had expected that the
> > existing SPI_NO_CS flag can be set using a property in the "slave" subnode,
> > but apparently there is no "spi-no-cs" property defined yet.
>
> The description is clearly saying there is a chip select, _NO_CS seems
> entirely inappropriate.  It's not specified in the device tree because
> when there's no chip select for a device it's a fundamental property of
> how the device is controlled and we don't need any information beyond
> the compatible.

In host mode, it indeed doesn't matter, as you can have only a single
device connected with SPI_NO_CS.
In device mode, the device needs to know if it must monitor the chip
select line or not.

In hindsight, I should have kept the question I had written initially,
but deleted after having read the documentation for the corresponding
RZ/V2M register bits:

    What does it mean if this is false? That there is no chip select?

So "spi-no-cs" would be the inverse of "renesas,csi-ss".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
