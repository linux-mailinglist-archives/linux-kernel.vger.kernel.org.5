Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50678EB48
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbjHaLCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjHaLCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:02:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F08CFA;
        Thu, 31 Aug 2023 04:02:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a1de3417acso404897166b.0;
        Thu, 31 Aug 2023 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693479724; x=1694084524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTXl8mKJCoSXKQpNwtK+OO0amUPSdiia5crdcPt8muI=;
        b=E+oqK58T2xDwEFt28ap15LWJt4vmTlg+bnDCandK7A7O8dNb1mv5LaTHniKEOeccoO
         SHM0+lHqPtLGBxU9/4Fy6r15+TReFKndNTY5qERIYKG+Af3FfXcO1rAtJoQruF4SihUn
         lfOe+v/F/AsbofieYDEHOCxV71GT9C6JM+ZFE25hoWsaihelCnrOOZ7I7+R3gijJ9Y/d
         L4RbR4KTDtRZ/P7Hv9luhmCkTwWVPIvU9SoAMC87QRjJ10rTByvXTDVUIuTJSOkl3tkJ
         2FOTGOS1O+5Uv7vGKMGM6KSQgqV/lKKkk4YfHP1UOA+z+JzL+Q501lmTUFIDtrUo8oKO
         HhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693479724; x=1694084524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTXl8mKJCoSXKQpNwtK+OO0amUPSdiia5crdcPt8muI=;
        b=QjJomj4LvMGns58nrlekzKu8bEV3eCfc6luFpLzoVlPwuS/CzQojY33hhlpr6JC7zR
         KQwq0798MNmkG4p7WyF6+lVPy4LP+ve5INCQc0gYvCZaUljAsdpwQ7eGxOL8qcjJ2cPv
         L5U+H8txcibNqFCzQAor5kYuQDXQHEDqkoMAJGZ7cUSSBmPbRPMVxnhD5EmOOdyzucjY
         f4S97m7F20WVSnq7aP6JcRDzM/6KqMx4yDhDzlYc/aFtj9xt8OjHncB/Y9PhSAwahK+b
         FCNgLEjxCL5AI+mwvh8DN1MeDaank/XgvDpK2dynQTXtrjQpeLNcd3d7FIpFdEd7EWnz
         52Tw==
X-Gm-Message-State: AOJu0Yy9poTVX7d5jWWldKrZh7D3TtOlA4QugbJpks+4BLov33VRTu3i
        DGbSxqoU3km5WA40rQAJDe8z+1SJqY+4hYfunwd0inVK/3rGgA==
X-Google-Smtp-Source: AGHT+IFq6TiAayoEpOcVY3q+kTFxUlMOEDYcxgXQPawqzmVsOEzqNB3KNO4GhQ+DoCSP8vjisiE6mD7ms+6bcSzzPmM=
X-Received: by 2002:a17:906:7311:b0:9a5:b66a:436d with SMTP id
 di17-20020a170906731100b009a5b66a436dmr2847772ejc.14.1693479723591; Thu, 31
 Aug 2023 04:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-5-keguang.zhang@gmail.com> <1cc2c8f8-1f9b-1d47-05d4-9bcad9a246cd@linaro.org>
In-Reply-To: <1cc2c8f8-1f9b-1d47-05d4-9bcad9a246cd@linaro.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Thu, 31 Aug 2023 19:01:27 +0800
Message-ID: <CAJhJPsVj1836-DoKTokxMd664FPX70vtSv96x4DfHzBFRZ_9Tg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 4:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> On 30/8/23 15:42, Keguang Zhang wrote:
> > Add two new F: entries for Loongson1 Ethernet driver
> > and dt-binding document.
> > Add a new F: entry for the rest Loongson-1 dt-binding documents.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V3 -> V4: Update the dt-binding document entry of Loongson1 Ethernet
> > V2 -> V3: Update the entries and the commit message
> > V1 -> V2: Improve the commit message
> >
> >   MAINTAINERS | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ff1f273b4f36..2519d06b5aab 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
> >   M:  Keguang Zhang <keguang.zhang@gmail.com>
> >   L:  linux-mips@vger.kernel.org
> >   S:  Maintained
> > +F:   Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
> > +F:   Documentation/devicetree/bindings/net/loongson,ls1*.yaml
>
> Why not simply squash in patch 2
>
> >   F:  arch/mips/include/asm/mach-loongson32/
> >   F:  arch/mips/loongson32/
> >   F:  drivers/*/*loongson1*
> > +F:   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
>
> and 3 of this series?

Do you mean squashing patch 2 and patch 4 into one patch?
>
> >   MIPS/LOONGSON2EF ARCHITECTURE
> >   M:  Jiaxun Yang <jiaxun.yang@flygoat.com>
>


--=20
Best regards,

Keguang Zhang
