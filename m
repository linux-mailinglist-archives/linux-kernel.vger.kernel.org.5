Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A737AB6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjIVRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjIVRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:01:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E700194
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:01:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99357737980so296499966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695402096; x=1696006896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prIJYO4UCCa6Vt94U+NHB8APLB3E/mezXQCP+edywR0=;
        b=BEMsmtupvlAH0gzfsM4XZaqBFNVnsAPECW+HZ8ISoS3pIG/63qKRJVgby3915kuuwZ
         AX/HlaU28scNtw949VyZF2YHMmtdXRyACizRfq20UavdOLNF0HJiPM9ZMRm1SySq9Epc
         YjAFdfdAvWIRTiTRfLQi5RbuebW9Vm22LtDyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695402096; x=1696006896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prIJYO4UCCa6Vt94U+NHB8APLB3E/mezXQCP+edywR0=;
        b=CVTS6inUQDwcVCan3p3FLsD67n/3YqPlG0mnghLiqkrLyOFWKKPlx0798mwj+5Gxoh
         QE8KFP9B9Jb2a2Q25KMLnZtCimSruu4haIVTLkSBYVM09e8Vel2PVWzIVabEP6gSiUic
         48GW8FRGeZ98cjphV7uk8hvT8eA8JSmqAjq6DUZBrTxlDoTU1/YwF2l/yWxxc4XBAeg4
         oDW4K+BKs/Bz0cwjnoO4yvjNcs8HrnxB/H/lR6bJOwIMlNhBD3iugojRYUQK2j0SsaIL
         v0CSci8tEdbZNLkFpXQ/KE3o39Gt9Ljhq0MLjoSsuMtYjwRS0hkhTwOPgYbygljD2teO
         0UjQ==
X-Gm-Message-State: AOJu0YxoNHZ9XVMG1LsxAzuVm95JO2Xo7PMosuCe253vjtEATfKmuVTg
        s2QZPUh3MqO3UEJV9eaPt8CP05AS9HunHxBi577Ibg==
X-Google-Smtp-Source: AGHT+IHHv1gP/4pypmekIUolVP4Bg2MyLQnwNSeSTQqinVXlc3czJqPwmHasOlWBXAyzd5YREZkr1Q8LAEn78+XhqMI=
X-Received: by 2002:aa7:c7d3:0:b0:523:3fff:5ce2 with SMTP id
 o19-20020aa7c7d3000000b005233fff5ce2mr42790eds.41.1695402095589; Fri, 22 Sep
 2023 10:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
In-Reply-To: <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 22 Sep 2023 11:01:18 -0600
Message-ID: <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Binman[1] is a tool for creating firmware images. It allows you to
> > combine various binaries and place them in an output file.
> >
> > Binman uses a DT schema to describe an image, in enough detail that
> > it can be automatically built from component parts, disassembled,
> > replaced, listed, etc.
> >
> > Images are typically stored in flash, which is why this binding is
> > targeted at mtd. Previous discussion is at [2] [3].
> >
> > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromiu=
m.org/
> > [3] https://www.spinics.net/lists/devicetree/msg626149.html
>
> You missed:
>
> https://github.com/devicetree-org/dt-schema/pull/110
>
> where I said: We certainly shouldn't duplicate the existing partitions
> bindings. What's missing from them (I assume we're mostly talking
> about "fixed-partitions" which has been around forever I think (before
> me))?
>
> To repeat, unless there is some reason binman partitions conflict with
> fixed-partitions, you need to start there and extend it. From what's
> posted here, it neither conflicts nor needs extending.

I think at this point I am just hopelessly confused. Have you taken a
look at the binman schema? [1]

I saw this file, which seems to extend a partition.

Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.ya=
ml

I was assuming that I should create a top-level compatible =3D "binman"
node, with subnodes like compatible =3D "binman,bl31-atf", for example.
I should use the compatible string to indicate the contents, right?

Re extending, what is the minimum I can do? Are you looking for
something like a "compress" property that indicates that the entry is
compressed?

I'm really just a bit lost.

>
> I did a bit more research. "fixed-partitions" as a compatible has
> "only" been around since 2015. Prior to that, it was implicit with
> just partition nodes with addresses (i.e. reg) and that dates back to
> 2007. Looks like u-boot only supports the newer form and since 2021.

OK

Regards,
Simon

[1] https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#ima=
ge-description-format
