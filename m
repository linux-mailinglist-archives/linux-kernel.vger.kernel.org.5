Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD078DE45
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbjH3TAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbjH3GzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:55:07 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44000194;
        Tue, 29 Aug 2023 23:55:05 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a9f88b657eso11068b6e.3;
        Tue, 29 Aug 2023 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693378504; x=1693983304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykeoCIxBcWK9fprxA7xY1CjxKLMttjr+mMVbOTGVYC4=;
        b=GFOOTWCh7K0lYVQ8Rmfq01Jhlcun8kZCZ4LJ7FN9+c1Gokza5UEcH5PCjGDnY7N1po
         eK2h+DVXwC6I/e54VhuIPgnNfGAeGiHw5JLIW6+ZjCUlps42tgQ/ffYlwKxhXSLXmnzj
         TIWpjPKq0m4QFXu347OYsEUElSvkhOXFeES7rlniMHihZ6pehkfY88JZqFe6lsVdAiF0
         +PG0Ubgv0CmKufdxCXGSWTTK6jHsTNtbQM9YU1fL1lr4xCbWHws9EhCK73IIDyD0hTEV
         t8PsvZwpZ9sZ6LAdCS49BqwkgcQc4nC0JD9vtRLjezfjHUwyEQdn3RJNUq/DcjEJRBk6
         nRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693378504; x=1693983304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykeoCIxBcWK9fprxA7xY1CjxKLMttjr+mMVbOTGVYC4=;
        b=PKPOTO0fC+UH0Krxv+FOICojT7DzU8xzzNFm4zBj53mVcX/ukIeq4ayoHPHNiAnWSc
         1FP0j/EndWjjd8NKoAeuSFDVgIC5lULulk//kEBXxjJJOIR6hi3+qQy9FlCo+8HjD8AA
         0/8P40+7TCYAAHUQNqUnD6dEo3Nd9Z4d9w/9SLjY645DaDGFy7CI2iT/+p2nXdAOvpl9
         2KukAhWkXBIY+pknyKffkt9JodJNWwuJrioXVuGJbI1bA4W4nlyqvGN17GhFFwCpilp0
         5Y8oI9eKsJfxQpB/Gus9mVLEvvdR5X6pFmtQlnt12Snr07BBDYxAzNEnnLR37k8BfyGq
         U+sA==
X-Gm-Message-State: AOJu0YzHhZIxqftGAwAhQdbPvCH3OTAY903KlZjdjtrkdApjw4f+djcy
        NWdF5jO+Ov+VQ/8vEtDPnfMUk3TS5fKr8hxNKm8=
X-Google-Smtp-Source: AGHT+IE+1mSCJdU7rX2o+8csZolgC9eWB+hmFoPUKf5+lCV7ckYuycjozdi+XOJ5greba0R5UE3ntFcwzA1SZlnoSps=
X-Received: by 2002:a05:6808:14c7:b0:3a7:b094:8f2 with SMTP id
 f7-20020a05680814c700b003a7b09408f2mr1503180oiw.45.1693378504585; Tue, 29 Aug
 2023 23:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230628082716.2075736-1-sergio.paracuellos@gmail.com>
 <20230628154022.GA520881-robh@kernel.org> <CAMhs-H_WD7tkawv1cg3GympqyzzPwK4Es_GxoFD5gPR=Y0H7kw@mail.gmail.com>
In-Reply-To: <CAMhs-H_WD7tkawv1cg3GympqyzzPwK4Es_GxoFD5gPR=Y0H7kw@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 30 Aug 2023 08:54:51 +0200
Message-ID: <CAMhs-H9Aafp1FPe9Y=pX-TeviMfXnFd4vBmfGMy9k-y7P+boqA@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 6:42=E2=80=AFPM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi Rob,
>
> On Wed, Jun 28, 2023 at 5:40=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Wed, Jun 28, 2023 at 10:27:16AM +0200, Sergio Paracuellos wrote:
> > > Add YAML doc for the system tick counter which is present on Ralink S=
oCs.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  .../bindings/timer/ralink,cevt-systick.yaml   | 38 +++++++++++++++++=
++
> > >  1 file changed, 38 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/timer/ralink,ce=
vt-systick.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-syst=
ick.yaml b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
> > > new file mode 100644
> > > index 000000000000..59d97feddf4e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yam=
l
> > > @@ -0,0 +1,38 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: System tick counter present in Ralink family SoCs
> > > +
> > > +maintainers:
> > > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ralink,cevt-systick
> >
> > What is "cevt"? Would be nice to define. Really this should have been
> > SoC specific, but it looks like it has been upstream "forever", so fine=
.
>
> Not sure what cevt really means, I guess maybe "clock event"? Inside
> the documentation this is just listed as "System Tick Counter". It is
> upstreamed since Ralink SoCs are on tree. I am just documenting
> already mainlined stuff since there are lots of missing  binding docs
> for old Ralink SoCs.
>
> >
> > Otherwise,
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>

Daniel, is this patch going through your tree?

Thanks,
    Sergio Paracuellos

>
> Thanks!
>
> Best regards,
>     Sergio Paracuellos
> >
> > (the error report can be ignored)
