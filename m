Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6F782A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjHUN0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHUN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:26:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB408F;
        Mon, 21 Aug 2023 06:26:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so4311236a12.2;
        Mon, 21 Aug 2023 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692624393; x=1693229193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivp3Kmvd1KiyuA0TajyJFX+EMDTxCUTbleFELmRAXdc=;
        b=kOBLPfwyxwwTzXem9eYsvblIj9PNfqrNLntcyl84RNSWbCUmBGHBwy+3xY7zxJk/mX
         lm177M31nVSSJmVKXiLQGmFqkXEdyZGNNoO4b2gbEA98xEFJoMogBUOCghmJ4rrDEAV4
         HaFv4BGetogqjcrDN1WJzFhtnSaSrVS2jVABDSKsqK3xERyBuy0hfCQvZMz6Y1eH9EaZ
         cOkoGd6DhGkDaUXA9/CEFhP9PkRBmISlJWwb0AM7u9Iw2f3ejKXWNuNxX2cl01Sjt3xN
         lA1EbeJ4fmFdJoQ1qnMw+ullOU6NH6rfYPpByqLu+Py9NP2VEvkcxLqQ+mu0zOopfKlL
         S1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624393; x=1693229193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ivp3Kmvd1KiyuA0TajyJFX+EMDTxCUTbleFELmRAXdc=;
        b=dN3RW3i3jNnu1R7HrMITJXszVENZAlXr35cgrRYK2pcjyUxGup0mgL/+Gc2Qgpbkc6
         gsaqhTwI3ktnFWbqoVWBuY8hujvGi4ua1mOU73t7dQ4SaoH1j6WDF6Tkkdx0pdW1OMq+
         j207Nu4cIdjHcuP+Eb4ruowXmLaM6n2K7zahDRwJrGqIfzEprqtzL26vCvqPes1glATV
         7oOZK6m8tjZEzCpGQJ77BqNqIWc8HWPeRv1VoHSw+C+xdvZM8ZPp3KxC9HfYfRH03Zqs
         yDBRAVsiUbSv6sMPzLR4cIgS2UAYAhGHFnzzF4dhiycWScc2cJi8eJ+dDWJzF8xFAzG0
         ojkQ==
X-Gm-Message-State: AOJu0YyLXt4hgLxdsQiBLC1ncjE/qm5eMkvD1LX63FZ3di7brNOj98e6
        Ry23mYNLLH+2w0TrxT3G3cRsqTepYwOdyX0f+BA=
X-Google-Smtp-Source: AGHT+IEVuYuf/qp19UPbKwtg758s0lJ66lQhjhFhYzfyWwydig257yItnAqpSmQLFo3ZIXBLtdzuuVy4LcxCVObTIJU=
X-Received: by 2002:a05:6402:505:b0:525:3e99:8ab9 with SMTP id
 m5-20020a056402050500b005253e998ab9mr5110542edv.10.1692624392358; Mon, 21 Aug
 2023 06:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-3-keguang.zhang@gmail.com> <c1499974-17c5-2f6b-8d6b-be225299fa9c@linaro.org>
In-Reply-To: <c1499974-17c5-2f6b-8d6b-be225299fa9c@linaro.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 21 Aug 2023 21:26:16 +0800
Message-ID: <CAJhJPsUpAOhNH9q6gqrUjc=0WGMmSj1xJAgZoMBZ_6+pHdN5fA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: net: Add Loongson-1 DWMAC glue layer
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 10:26=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/08/2023 13:13, Keguang Zhang wrote:
> > Add devicetree binding document for Loongson-1 DWMAC glue layer.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V1 -> V2: Fix "clock-names" and "interrupt-names" property
> >           Rename the syscon property to "loongson,dwmac-syscon"
> >           Drop "phy-handle" and "phy-mode" requirement
> >           Revert adding loongson,ls1b-dwmac/loongson,ls1c-dwmac
> >           to snps,dwmac.yaml
> >
> >  .../bindings/net/loongson,ls1x-dwmac.yaml     | 98 +++++++++++++++++++
> >  1 file changed, 98 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1x=
-dwmac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.=
yaml b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
> > new file mode 100644
> > index 000000000000..cf5477450e29
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/loongson,ls1x-dwmac.yaml
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/loongson,ls1x-dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1 DWMAC glue layer
>
> Please implement Serge's comments about title and description. Rest
> looks good:
>
Will do.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
As suggested by Serge, this file will be split into
loongson,ls1b-gmac.yaml and loongson,ls1c-mac.yaml.
Due to this significant change, I'm not sure whether I should keep
your Reviewed-by tag or not.

Thanks!

> Best regards,
> Krzysztof
>



--
Best regards,

Keguang Zhang
