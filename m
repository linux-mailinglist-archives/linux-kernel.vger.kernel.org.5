Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAC1756160
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGQLTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjGQLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:19:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7084E48;
        Mon, 17 Jul 2023 04:19:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-993d1f899d7so635098066b.2;
        Mon, 17 Jul 2023 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689592739; x=1692184739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QijUibtG40+t5LDtP3Zsswxs5UnjGxpVCNjyPMZLJl8=;
        b=iq1FnouNw8hu78GVyoQBK0Cv8f50DC2LDmg0E/jmuE7TL2mhCtlpiBtRW3xMyfbiCP
         s7Um1pL125YQciF26uaBkmJ7Sv3OseJHp+TXcKplLPdFIksRY7LGvs4h6XDKkhAqJKDj
         1cVJkAHafFI9I8eVtDFdAzjoVq2BV2qTegcJh80HbIKh1fcXi0mXS4gUINK9gDtvx9lb
         1BggqdiatGURBcKH9MqIzGcMqrzDA2HmJ7LZg+Uxd42pdVngIwYZvd3bvSUzc6gp29zu
         /wppIfELH8hKqxugJ7ig069072Mlua7HtiKIVE8l/eAqlH7Pv/Qwk3sVouIZ+OkJGU3J
         ehGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689592739; x=1692184739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QijUibtG40+t5LDtP3Zsswxs5UnjGxpVCNjyPMZLJl8=;
        b=W46qXIbH2njzUpLEszAq3bgHyfQdUEWZ105JAZP8xBBxVbj3ebpx7hkXv+JRBaes/g
         +ESS1577aGyyPhjT9KTZnVT0Sz/E0RPNCR9DPa2fB80mfnf2Mv9xYWEFDj9Y/3YFaeB5
         pnyJwwE0A6jj03e+1v3rc1LbgObf6ezpmEBoN88p6m0QHkuCT2fsPUeC8ujkfRN4BapQ
         HeRsO7z7+93eg2/5URrz6cDiFPAp9FRP9vgivlmNdjdfc5DlvMl7BsdbifPbtlqNJ80T
         IGj1FRmbHmmSUEuIkdORJdh79d9j7dJgVG962ZrAEPop12gfCf2cXdWtUiE1vVHpxn9L
         oCwQ==
X-Gm-Message-State: ABy/qLYfzUUYvqzaqrV3AziMI0w5S7GfquJLC6NyGxmL0SNzwNUrYcLc
        rXSs2K/nbCSIZEhSaMfr67T6R6NOAVy7W3j1dOw=
X-Google-Smtp-Source: APBJJlFgxJ9kqESM2vJO7AKAUkjY4G9ICt4eSFqnKKc+eDe0rOvAKel/IRN6zzvlQGEnfjkZIXlQpd77OnW6Y8Ra2Yo=
X-Received: by 2002:a17:906:e213:b0:992:48b7:99e3 with SMTP id
 gf19-20020a170906e21300b0099248b799e3mr10396878ejb.63.1689592739105; Mon, 17
 Jul 2023 04:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
 <20230715010407.1751715-8-fabrizio.castro.jz@renesas.com> <CAMuHMdUzxQfi2w8dyF8gCitkSKkw_fRE074EUuB+tHKn8WM3=w@mail.gmail.com>
 <TYWPR01MB8775869576E4B3F0FEFCF3DCC23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
In-Reply-To: <TYWPR01MB8775869576E4B3F0FEFCF3DCC23BA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 14:18:22 +0300
Message-ID: <CAHp75VdNvWS04VN58r5VcSJskeVJF0g0_spSRb8f0_OP1P04QQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] spi: rzv2m-csi: Switch to using {read,write}s{b,w}
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 1:36=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Subject: Re: [PATCH 07/10] spi: rzv2m-csi: Switch to using
> > {read,write}s{b,w}
> > On Sat, Jul 15, 2023 at 3:04=E2=80=AFAM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:

...

> > According to the hardware documentation[1], the access size for both
> > the
> > CSI_OFIFO and CSI_IFIFO registers is 32 bits, so you must use writel()
> > resp. readl().  So please check with the hardware people first.
> >
> > [1] RZ/V2M User's Manual Hardware, Rev. 1.30.
>
> You are right, access is 32 bits (and although this patch works fine,
> we should avoid accessing those regs any other way). Now I remember
> why I decided to go for the bespoke loops in the first place, writesl
> and readsl provide the right register access, but the wrong pointer
> arithmetic for this use case.
> For this patch I ended up selecting writesw/writesb/readsw/readsb to
> get the right pointer arithmetic, but the register access is not as
> per manual.
>
> I can either fallback to using the bespoke loops (I can still
> remove the unnecessary u8* and u16* casting ;-) ), or I can add
> new APIs for this sort of access to io.h (e.g. writesbl, writeswl,
> readsbl, readswl, in order to get the pointer arithmetic right for
> the type of array handled, while keeping memory access as expected).
>
> What are your thoughts on that?

I think that you need to use readsl() / writesl() on the custom buffer
with something like

*_sparse() / *_condence() APIs added (perhaps locally to this driver)
as they may be reused by others in the future.
Having all flavours of read*()/write*() does not scale in my opinion.

--=20
With Best Regards,
Andy Shevchenko
