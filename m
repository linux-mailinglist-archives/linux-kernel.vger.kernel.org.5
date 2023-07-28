Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2DD7663D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjG1GBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjG1GBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:01:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D9D26BC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:01:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b93fba1f62so26654031fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690524100; x=1691128900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jjGYCkpEYu58BQfAwhDMVJPr8BDJrnt1s54RDMlMPA=;
        b=EnOmxiQ6Hqmfy468wQrckhNRtCZUvLNfddXLnUKst3m5+Y0BW/6amJY7gYXx93hbzs
         sLFVbe4SCueWxW0c4vDtLXQpXxTYItb40QIoGjlZAf5Q2gtjlqT5bYnU05UwhrAFts80
         1Jmlt+8A4WgU3xkX0A8vfJrce924O4THWo5b4UMGc9wfwkCT/3z6WS33GgeLPbhmw4BZ
         vWbzRrv/vFXJbiDnTGA/u7UGeyqtFpHrjLnt7MOKuI4dShzt47mnjHPOnlNB+V4d2HEz
         FothBpUXrwksIcuDHGmEAKHZfgkx1PFGKHcBEZ18x13fxtLRAuU/Hh7SUb0z3ldmouW9
         f54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690524100; x=1691128900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jjGYCkpEYu58BQfAwhDMVJPr8BDJrnt1s54RDMlMPA=;
        b=NtwRd4vkiA9deN9fN2SSGsl4F7cmHN8Roufg66cNDWE0+m9kUVeXip3LOLNCxWtmUd
         LTY6lnoBod+0VyyerzvgeBXIbjdryEvSer74UfL/DaW9AiEvcwi1zbppQ8VaBAItfJgR
         gckhLNXSZmrdY2gM3OJmt3rXYUBQ9DMBnEbn0ZbSaXtZzD+H/KvvvSB9lzhc6COjtU4Q
         Dyc+b6VcoHOgWI5yph5AUWRsgPTE3gJrebLQ4gUDspvMeQZIoAufAWBPIwv/z6nSobd7
         oxLHUZvGvfpn3ycwbAQi7Hn6EIKNGMadPu8XXffAacJUVN3m4LUJm4smf5/+kb1hI1Hg
         ibNg==
X-Gm-Message-State: ABy/qLbVySarpnEFJMyy/upiE+vBRVd32wGXOsBNKImGXZkM1h63SOiX
        TVyioCGhZR+2Br996eoTCapLD2JyX0dhUeavzL1Clg==
X-Google-Smtp-Source: APBJJlGRtJ5h9JlYPOw784edK7V79G0d0vYdwCpHUuo8Is7oxaLejqe++lmUOh2FkvVkmSEOAEMEiq2mT/bVif0U91I=
X-Received: by 2002:a2e:7c01:0:b0:2b9:4476:ab28 with SMTP id
 x1-20020a2e7c01000000b002b94476ab28mr977256ljc.38.1690524099313; Thu, 27 Jul
 2023 23:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230720135125.21240-1-eric.lin@sifive.com> <20230720135125.21240-2-eric.lin@sifive.com>
 <cbf0a8fd-3479-1684-fe90-81f2159804ef@linaro.org>
In-Reply-To: <cbf0a8fd-3479-1684-fe90-81f2159804ef@linaro.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Fri, 28 Jul 2023 14:01:28 +0800
Message-ID: <CAPqJEFr5h+5+F4TdNuRMaWsrmeedbfGgbgd9wh8sUUQsj2Pw-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Jul 21, 2023 at 4:35=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/07/2023 15:51, Eric Lin wrote:
> > This add YAML DT binding documentation for SiFive Private L2
> > cache controller
> >
> > Signed-off-by: Eric Lin <eric.lin@sifive.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Nick Hu <nick.hu@sifive.com>
>
>
> ...
>
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sifive,pl2cache1
>
> I still have doubts that it is not used in any SoC. This is what you
> said last time: "is not part of any SoC."
> If not part of any SoC, then where is it? Why are you adding it to the
> kernel?
>

Sorry for the late reply. I didn't describe it clearly last time.
Currently, we have two hardware versions of pl2cache: pl2cache0 and pl2cach=
e1.
The pl2cache0 is used in unmatched board SoC. The pl2cache1 is
utilized in our internal FPGA platform for evaluation; it's our core
IP.

>
>
> > +      - const: cache
> > +
> > +  cache-block-size: true
> > +  cache-level: true
> > +  cache-sets: true
> > +  cache-size: true
> > +  cache-unified: true
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  next-level-cache: true
> > +
> > +required:
> > +  - compatible
> > +  - cache-block-size
> > +  - cache-level
> > +  - cache-sets
> > +  - cache-size
> > +  - cache-unified
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    cache-controller@10104000 {
> > +        compatible =3D "sifive,pl2cache1","cache";
>
> Missing space.

OK, I'll fix it in the next version.

>
> > +        cache-block-size =3D <64>;
> > +        cache-level =3D <2>;
> > +        cache-sets =3D <512>;
> > +        cache-size =3D <262144>;
> > +        cache-unified;
> > +        reg =3D <0x10104000 0x4000>;
>
> reg is after compatible.

OK, I'll fix it in the next version.
Thanks for your review.

Best regards,
Eric Lin

>
> > +        next-level-cache =3D <&L4>;
> > +    };
>
> Best regards,
> Krzysztof
>
