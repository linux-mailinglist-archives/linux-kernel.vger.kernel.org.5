Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33BF792966
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351882AbjIEQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354857AbjIEPH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:07:28 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25A18D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:07:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so41475091fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1693926442; x=1694531242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8d5KFcSRcmH0JCc/DKLzz+3RGk6xH5isDQxBMPU7qY=;
        b=Ox0TsDWCkmQl4dyhtUVoL9kJqYjU+WDovLFWVvvSDlj4rezLOmqnONAWnH8J/Ki0wC
         oYj8GT2mlT1Gdrtvr8CRyLGvO0lZjfENOCA4B9gTnJQ+1PUGcrUC+zGSUTbSUBwrlHNk
         G87DhZrgTbtYTVXuIBm5LqT1OzkrSKpZSmrVXPtpHuFXWGEwJGF5DpTtUKzhKex6AOtd
         LzbipKmChBMtgt0M52BvzBZv3gm6P9QLiVLAWrRCCcbSvyRtqwXXCWa8fEe5X6vR5mFU
         vFwMlv5CcigyNgelbzuB38maMMA/0oXgbzn+crDGt82X7h+wp/fSagpuTr9pjDHl7dMr
         2nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693926442; x=1694531242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8d5KFcSRcmH0JCc/DKLzz+3RGk6xH5isDQxBMPU7qY=;
        b=cKIm2lCDpt/43f6tRHGpuuhnYXs4I9VupUHa1lqRocZX3Oq87XzPgmrViy0Gx49dxW
         n4EYhZFzNs1YcVIz5JBa9PXzmSERV5+6Ucs3K5jo/Id9LgYXP1anMBaFyLmZXmV82haQ
         wCmjlIdyCAUExlbA6mqL6s6mj4wYLcreeDyt98cApQz5hrTlHCLFCXw9VGRio5kmZU+G
         IILAbOi44ms1+c2BzfGRINR90MHUbexOY3TuHRpFQd2tCdJEBqgdZDOfdgwFKkiQtnLD
         5pbmUBf8CVWaS0wfguoI72Fa9SzPCvhRZAhKpr3p0uJUV0PLh0E/lt1nf7IRHPA78rKO
         7E9w==
X-Gm-Message-State: AOJu0YwvWWp9Q6hX1MYhIIP/1w1FZGdMkKIPKeSMAdsg+N2rsHFcKD55
        JrppQd6wydCyBeFOnXGjesQbkhcFKxBok+5F137yyQ==
X-Google-Smtp-Source: AGHT+IHOnDDzrKhACbl2MVW/szUGryvjFTJ7hcXSlFr4SFXnR0m9slCKMXPxqlVlZCIWngKKVMz0uryu42aXAN6j2Ks=
X-Received: by 2002:a2e:7c09:0:b0:2bb:94e4:6b07 with SMTP id
 x9-20020a2e7c09000000b002bb94e46b07mr34242ljc.12.1693926442628; Tue, 05 Sep
 2023 08:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230720135125.21240-1-eric.lin@sifive.com> <20230720135125.21240-2-eric.lin@sifive.com>
 <20230720-slept-guru-216e2803061e@spud>
In-Reply-To: <20230720-slept-guru-216e2803061e@spud>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Tue, 5 Sep 2023 23:07:11 +0800
Message-ID: <CAPqJEFrM51aQrcVgj8RFvai4QPR2+iOC=ueqFpU0oNX+h4aQbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Conor Dooley <conor@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor and Krzysztof,

On Fri, Jul 21, 2023 at 1:10=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Eric,
>
> On Thu, Jul 20, 2023 at 09:51:19PM +0800, Eric Lin wrote:
> > This add YAML DT binding documentation for SiFive Private L2
> > cache controller
> >
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Nick Hu <nick.hu@sifive.com>
> > ---
> >  .../bindings/cache/sifive,pl2cache.yaml       | 62 +++++++++++++++++++
>
> btw, your $subject should be "dt-bindings: cache: ...." rather than
> "riscv: sifive".
>
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cache/sifive,pl2c=
ache.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/cache/sifive,pl2cache.ya=
ml b/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
> > new file mode 100644
> > index 000000000000..ee8356c5eeee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2023 SiFive, Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive Private L2 Cache Controller
> > +
> > +maintainers:
> > +  - Greentime Hu  <greentime.hu@sifive.com>
> > +  - Eric Lin  <eric.lin@sifive.com>
>
> There's extra spaces in these lines for some reason.
>
> > +
> > +description:
> > +  The SiFive Private L2 Cache Controller is per core and
> > +  communicates with both the upstream L1 caches and
> > +  downstream L3 cache or memory, enabling a high-performance
> > +  cache subsystem.
> > +
> > +allOf:
> > +  - $ref: /schemas/cache-controller.yaml#
> > +
>
> I'm pretty sure that I pointed out last time around that you need to add
> something like in the ccache driver:
>
> select:
>   properties:
>     compatible:
>       contains:
>         enum:
>           - sifive,ccache0
>           - sifive,fu540-c000-ccache
>           - sifive,fu740-c000-ccache
>
> otherwise this binding will be used for anything containing "cache" in
> the dt-binding.
> For this binding, I think that the following is sufficient:
>
> select:
>   properties:
>     compatible:
>       contains:
>           const: sifive,pl2cache1
>
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sifive,pl2cache1
> > +      - const: cache
>
> You omitted the pl2cache0 from here, that needs to come back! You'll end
> up with 2 items entries.
> Either way, I can't take this binding without a soc-specific compatible,
> per sifive-blocks-ip-versioning.txt..
>
Sorry for the late reply.
OK, I will wait until the customer's SoC tape-out before upstreaming
the PL2 cache and PMU drivers.
Thank you for your review.

Best regards,
Eric Lin

> Thanks,
> Conor.
