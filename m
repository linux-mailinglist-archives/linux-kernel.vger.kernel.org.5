Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B06758555
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGRTGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRTGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B8F4;
        Tue, 18 Jul 2023 12:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDD00616C7;
        Tue, 18 Jul 2023 19:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4576AC433C8;
        Tue, 18 Jul 2023 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689707199;
        bh=6AXogDUObuussgbwgLBOjpBMuZcG50s+2gM5QKLJIqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iaLVsbZAR/GfygYGkBHWzIMBF7N1x8Nr8LGivpj1n+JZWnZ+nGsTPk67WqJIjihQK
         OE7DGc6RD80/KIKre86+t4lqPxliDquvH/5QHfClJ9ab0c7O8U8PgGMMhsjA0jhwsm
         K0mF1ux8h13VYVw4LcCGKKi1psKXfCwFmIzReE1e0EydCrdroXovIV4kkPYSmWvQiF
         LIGp2ScDbmqglOoT5ao83vh0Q17Ln7oAEyUP9/QT+pNN09ieItiumdSqwoYlji8nrb
         P3PDgeAwFLJ20zbG5JyE8wIV38OS9aWwMq+XQwTEHbhb+Dg0HvK0nZs5iABOiH6K9X
         qHML4IOBzvnyg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so9752400e87.3;
        Tue, 18 Jul 2023 12:06:39 -0700 (PDT)
X-Gm-Message-State: ABy/qLZv+TSeF5nE28BlnfiWwmNQ4FE8Rubkp62f8uNNxTV/PPSa+93e
        0E/f/KA55CROql7TfoXM1fQGNKzAZHuwr6UDOA==
X-Google-Smtp-Source: APBJJlGB0bgDqyP6XJYTdEPy8Mz0doXTrM6SRrUuM5btq//xema+oxLHuID3ymZr1d5lAuSQSbfnZ8Wrr107kQc+0p8=
X-Received: by 2002:ac2:4c2c:0:b0:4f8:71cc:2b6e with SMTP id
 u12-20020ac24c2c000000b004f871cc2b6emr10819539lfq.33.1689707197305; Tue, 18
 Jul 2023 12:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230718143211.1066810-1-robh@kernel.org> <6e037c2051816deaa0e4361c4fb517ba7d33dc0b.camel@physik.fu-berlin.de>
In-Reply-To: <6e037c2051816deaa0e4361c4fb517ba7d33dc0b.camel@physik.fu-berlin.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jul 2023 13:06:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+vrAhG0FqqH-_rBtL2nEbJ+v=c3QfmjzOC=1A+Qi3KdQ@mail.gmail.com>
Message-ID: <CAL_Jsq+vrAhG0FqqH-_rBtL2nEbJ+v=c3QfmjzOC=1A+Qi3KdQ@mail.gmail.com>
Subject: Re: [PATCH v2] sparc: Explicitly include correct DT includes
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 8:56=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Rob!
>
> On Tue, 2023-07-18 at 08:32 -0600, Rob Herring wrote:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
>
> I would suggest rephrasing the subject to
>
>         sparc: Explicitly include correct DT headers
>
> as " ... include ... includes" sounds a bit awkward ;-).

Probably would have been better, but there's ~100 other patches with
the same subject. Some of those have been applied already.

Rob
