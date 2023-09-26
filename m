Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776F67AE834
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjIZIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjIZIiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:38:15 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356B7EB;
        Tue, 26 Sep 2023 01:38:08 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5739972accdso4819780eaf.1;
        Tue, 26 Sep 2023 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695717487; x=1696322287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9WTdFbfgD8PWJJN8ElB5etSNlTYmtIcow35neC8gMI=;
        b=nqqMRg3Ri8b7c+M9ePq5CBCZ9tik4xxWIzGhKdb94Cw8pI2HJ9Ffb/wu8uZ1otIrhw
         3dSMIFmgCRirKUQZz9Fj/OGiHsXvZlGTqiaMR5huT+5Ffmo5B6JEONhyyMtIaaBmW/+0
         037uyev8nASA3lwcfLpjkBQpigaRyVEwxZrtdGG6U++w0uJIbdP/ei7fwXu40JouP/Au
         ecith2a3l65om9drN51u5r9OQ3yEK8ZX5AXeuckhXpzuOK+upjG9Kv0/X8lt9e26KioX
         PynsI9TOqhrxeLlMUdOxl1OeKCBmLkmlaWzYJ/m8Jjor9N1kq6+9ZFPh4whq3apxXGrR
         C5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695717487; x=1696322287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9WTdFbfgD8PWJJN8ElB5etSNlTYmtIcow35neC8gMI=;
        b=wnOp9b36AA5ZUY31Idc6dVk6STRftOfSi+w6vih5XhsTL0y0f0zrwLwV1Rcqjv8MfI
         3kOfjxd+9A7lDyKAQgbZPSzEv8n0vbcDt/WNwQ2TVAripiwteeTVIVOTKNuelkD5v9vg
         nLillxc9MnhRN6U/IDzash9eVFDmzm+vDQoTdGUv6CrxZU8GEA8WYCihjff0/qcatTg5
         Pz7x47E+pWBrooWiBOvwfqvmr4MUMjXpFzl3c0rSPAQUIteO1pZmjKJxybsl4YhAFod9
         BtKBdMWHmSkY/ZlIr5RnQhO2fPwLDN/sBcsBV3MGrqBzFXoMDLp/q6jbGB6Lsb2BjO31
         lT+A==
X-Gm-Message-State: AOJu0YyArWbQXRh6N+f19Nmk4kPDzJxbZj7F9OqhMmF9VxbjH6J6Dk9C
        uUVngyK1NUWQgCwQlg3LQnBHdCOm7Nkqtfw9O8SVXzF+
X-Google-Smtp-Source: AGHT+IGx7MZtsEcLX1+5BoGvOJornsWK9NOloJY9pJNjev2EleQNjGF0kF6eRWj+2Fhgvwvtvgj5hhpPITRmJv7i/O4=
X-Received: by 2002:a05:6870:5608:b0:1dd:2a3f:cef3 with SMTP id
 m8-20020a056870560800b001dd2a3fcef3mr1175635oao.26.1695717487413; Tue, 26 Sep
 2023 01:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230628082716.2075736-1-sergio.paracuellos@gmail.com>
 <20230628154022.GA520881-robh@kernel.org> <CAMhs-H_WD7tkawv1cg3GympqyzzPwK4Es_GxoFD5gPR=Y0H7kw@mail.gmail.com>
 <CAMhs-H9Aafp1FPe9Y=pX-TeviMfXnFd4vBmfGMy9k-y7P+boqA@mail.gmail.com>
In-Reply-To: <CAMhs-H9Aafp1FPe9Y=pX-TeviMfXnFd4vBmfGMy9k-y7P+boqA@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 26 Sep 2023 10:37:55 +0200
Message-ID: <CAMhs-H_9kAdOfR-RaJWqAq6d3S3DXtKJqWy-EWCu0-ZjWKB9Sw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: add Ralink SoCs system tick counter
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Aug 30, 2023 at 8:54=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> On Wed, Jun 28, 2023 at 6:42=E2=80=AFPM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > On Wed, Jun 28, 2023 at 5:40=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Wed, Jun 28, 2023 at 10:27:16AM +0200, Sergio Paracuellos wrote:
> > > > Add YAML doc for the system tick counter which is present on Ralink=
 SoCs.
> > > >
> > > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > ---
> > > >  .../bindings/timer/ralink,cevt-systick.yaml   | 38 +++++++++++++++=
++++
> > > >  1 file changed, 38 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/timer/ralink,=
cevt-systick.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-sy=
stick.yaml b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.ya=
ml
> > > > new file mode 100644
> > > > index 000000000000..59d97feddf4e
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.y=
aml
> > > > @@ -0,0 +1,38 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: System tick counter present in Ralink family SoCs
> > > > +
> > > > +maintainers:
> > > > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: ralink,cevt-systick
> > >
> > > What is "cevt"? Would be nice to define. Really this should have been
> > > SoC specific, but it looks like it has been upstream "forever", so fi=
ne.
> >
> > Not sure what cevt really means, I guess maybe "clock event"? Inside
> > the documentation this is just listed as "System Tick Counter". It is
> > upstreamed since Ralink SoCs are on tree. I am just documenting
> > already mainlined stuff since there are lots of missing  binding docs
> > for old Ralink SoCs.
> >
> > >
> > > Otherwise,
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Daniel, is this patch going through your tree?
>
> Thanks,
>     Sergio Paracuellos

Gentle ping on this patch. I guess nothing missing is here and this
patch can just be added with Rob's RB?

Best regards,
    Sergio Paracuellos
>
> >
> > Thanks!
> >
> > Best regards,
> >     Sergio Paracuellos
> > >
> > > (the error report can be ignored)
