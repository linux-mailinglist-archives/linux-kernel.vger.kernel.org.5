Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064BD7A06A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjINN6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjINN6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:58:16 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D831BE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:58:11 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8198ca891fso580456276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694699891; x=1695304691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+rU7wcT/qbiZt6TYqHVxXtgFSA+h60mY5w5mpZqjdw=;
        b=efxBzJTzTHReFf2hKOtVfFVuLgEMAx1SixQkry70nJAoN9O/AURxcSuC0RCtvIerWe
         TRT9lL3/YvKPNnivkuAr/lg1HsK+1A3tlQUKCo80eJsI7uzlBQxyd1h6x9Bky5Lx38eN
         Z8WMUUV2LMWtujwhce/QqnBrHcoNmiITLO3duRVmMhC+DhfbW6JATkVMM4Y9cPpclw2Z
         WcE+2L+0SvMLOpVhN48D5sxAT93bYNUu+M+NjX6kOEiBTY9dSVRsP8m96Sz4jUGDrHq1
         +G2ITtyJbhL5gHABRKeR+epN386hAdf+YB/f6kRNuVkYYI0DfYaIDNJyhYS0ltuig0eJ
         4XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699891; x=1695304691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+rU7wcT/qbiZt6TYqHVxXtgFSA+h60mY5w5mpZqjdw=;
        b=ur/2Rub9nr2xOtRrdxcw0CmSEOsv9T4C8++ZsLwgBJPC0P7TkmfvYxbfjNDtBFHkup
         ibPzl6yl6HmNooAfg6QM0be5qQMYJq3aUoztUUWaeieb2oQoBX+CN+4emArbgq+ba6+x
         haECE2XUYb2oqqN7eXODTT+vUOxFvAW7xN6S1kG38hFywBN9QJp53bFHxxd9aRntyRg7
         Q7gElG97tdmjt2C0t+xaz63RXCbhqsJ6tffxFfh4qtonxPaLP/FecsNdWB6f8E0UWXqx
         ovR6XsnCSGjRZ9w9EguGFC5f9fIu3TAkYAj0kPi2ioob59P6xWOnff736+u2iBabOAk4
         bLrw==
X-Gm-Message-State: AOJu0YxBBhRhIERUXxIhD0mWjGlwVjPcCczQnn8RKsZfFgBZR/g2NSBf
        ERgdjRH9E/TecFDeWz24NOStirMNPGjh3DPWKqV83Q==
X-Google-Smtp-Source: AGHT+IHtqSuxfX37TdLlQhpuaApFbUBAzl2bugfZGY9ZHyuAt+CaOOescQKQCctSEApJSGlm5aiEU2AKwAUFIaM7+Dk=
X-Received: by 2002:a25:2044:0:b0:d7b:9d44:7574 with SMTP id
 g65-20020a252044000000b00d7b9d447574mr5730857ybg.64.1694699891168; Thu, 14
 Sep 2023 06:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220615090517.3961621-1-windhl@126.com> <CAL_Jsq+609wEjMLsiLAMjSfAcMc-ashF9+f0rhbZRhM2FVPhmA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+609wEjMLsiLAMjSfAcMc-ashF9+f0rhbZRhM2FVPhmA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Sep 2023 15:57:58 +0200
Message-ID: <CACRpkdaUpmhoXS-K=e85GahQBVY8aL2K+F_88hLOGUtfHa_KEA@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: mach-versatile: Add missing of_node_put in integrator.c
To:     Rob Herring <robh@kernel.org>
Cc:     heliang <windhl@126.com>, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 3:01=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Wed, Jun 15, 2022 at 4:06=E2=80=AFAM heliang <windhl@126.com> wrote:
> >
> > In cm_init(), of_find_matching_node() will return a node pointer with
> > refcount incremented. We should use of_node_put() when the pointer is
> > not used anymore.
> >
> > Signed-off-by: heliang <windhl@126.com>
> > ---
> >  arch/arm/mach-versatile/integrator.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-versatile/integrator.c b/arch/arm/mach-versa=
tile/integrator.c
> > index fdf9c4db08a7..fba19357171a 100644
> > --- a/arch/arm/mach-versatile/integrator.c
> > +++ b/arch/arm/mach-versatile/integrator.c
> > @@ -76,6 +76,7 @@ void cm_init(void)
> >                 return;
> >         }
> >         cm_base =3D of_iomap(cm, 0);
> > +       of_node_put(cm);
>
> Not really sure this is right. It is in the sense that the DT node is
> never accessed again. However, the device itself is still accessed and
> I tend to think a ref to the DT node should be held for that lifetime
> which in this case is forever. Really, none of this matters because
> nodes are never removed and these fixes are kind of pointless.

I'm just gonna scrap all these of_node_put() patches these automated
static analyzers have sent to the Versatile board and SoC code, it's
too dangerous.

> Note that cm_get() and cm_control() are never used and can be removed.
> That would be the more useful clean-up.

Yeah :/

Yours,
Linus Walleij
