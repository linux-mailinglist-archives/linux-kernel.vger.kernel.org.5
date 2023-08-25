Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E829C788724
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbjHYMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbjHYMY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:24:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A906D213F;
        Fri, 25 Aug 2023 05:24:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso836226e87.0;
        Fri, 25 Aug 2023 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692966198; x=1693570998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WBrrXndAbZbJ6p/Nar438q9WSE55oh82llBeggBy/I=;
        b=nQKj+pQZTHkdy7VgNuuNZ5VbLAFDgDEuEL3vnqILoN1t679DgqEme3Vjbkd3n4VMq5
         lUQ1mXtgPXbQwWwAfHxIGLBbTN6rM0h93vmPfaiw1xq1IVAqLPirjHNld5FYOXvtD9ou
         Q8Iuz1IQ27Uj07Apu2NkZd5L1xSKHRqToOADnED2h6AJZHkGTsMuMIvMu1Ip6GeRPayL
         ok5Yb0XVnQTfHyC1Ukz9n4evX6asCr3ROV5IqKo9rj7z9BZpq7FB1Voq3Im8mUgHt47H
         jCsD+10MXWzx5mSDLkvoXc/ZB+0M1Z3MV80CgIG0fNdwClxYWpHLjSXUUF5QyMrl955v
         fw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966198; x=1693570998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WBrrXndAbZbJ6p/Nar438q9WSE55oh82llBeggBy/I=;
        b=cMfJI5dIGeqDfysiPnlBKVK0DPqLyGrZbbRz9Z4K227PecEGRPSqsOawIWRFhu+O1X
         m0xZjpxeaDYNCQouGVq68h13EXDUoE3nGVbnpe8G7IyEtww7f/i4B2EG/7DvFpaw6Jj6
         p6XqrPeYG26OVB6iYKH2rYtl540BcSQJrvbw0UUMGD4zWQ9urMAHVDbt6osIBCg8LuKE
         pP+rJUVQd4pll0HRjs8+8SfcbBwdA1/hTPsvypJTRbI7staYgNWZ0xInX2A3KNyVUNp0
         GGuuBtPug1hhXYq/HqKhcnLZD12N7csEZ6+0JhL7JcYsImjEi4Awpq4ez6A52PWdhHBW
         49pA==
X-Gm-Message-State: AOJu0YxT+5Dlc3Xq3EOLLSaQKIcCf4b6s0ALJQnk0BvCGXPVVbi/n7tk
        zkAMmpo7p5sLgNooXmg2CUBHDg2nyGC6iaHyGRQ=
X-Google-Smtp-Source: AGHT+IGeYIhpQZQwYWBlFn9c0G+s1a43UuUYm0kyyGIY5iX6yP6g9N7SODjnUUyYfFNtPqSfJYqUJqDnDZHKZW5hPxc=
X-Received: by 2002:a05:6512:689:b0:4fd:d64f:c0a6 with SMTP id
 t9-20020a056512068900b004fdd64fc0a6mr16089445lfe.48.1692966198141; Fri, 25
 Aug 2023 05:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-5-keguang.zhang@gmail.com> <b8b414cf-c425-f322-51e6-c825e58ae6ed@linaro.org>
In-Reply-To: <b8b414cf-c425-f322-51e6-c825e58ae6ed@linaro.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Fri, 25 Aug 2023 20:22:41 +0800
Message-ID: <CAJhJPsV_OTY540D4_jryN57qEgK59fXJa03N5HZi=_qQWw78sQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Fri, Aug 25, 2023 at 2:47=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 24/08/2023 14:50, Keguang Zhang wrote:
> > Add two new F: entries for Loongson1 Ethernet driver
> > and dt-binding document.
> > Add a new F: entry for the rest Loongson-1 dt-binding documents.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V2 -> V3: Update the entries and the commit message
> > V1 -> V2: Improve the commit message
> >
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 250c43c675cb..f462f3d19e4a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14341,9 +14341,12 @@ MIPS/LOONGSON1 ARCHITECTURE
> >  M:   Keguang Zhang <keguang.zhang@gmail.com>
> >  L:   linux-mips@vger.kernel.org
> >  S:   Maintained
> > +F:   Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
> > +F:   Documentation/devicetree/bindings/net/loongson,ls1[bc]-*.yaml
>
> This should be just one pattern */loongson,* or even just N: loongson,
> if you want to cover any future versions as well (not only ls1).
>
Got it.
Will change to "net/loongson,ls1*.yaml" in next version.
Thanks!

> Best regards,
> Krzysztof
>


--=20
Best regards,

Keguang Zhang
