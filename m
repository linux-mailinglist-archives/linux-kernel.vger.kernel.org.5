Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905D47DDAD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjKACGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKACGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:06:01 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C75B4;
        Tue, 31 Oct 2023 19:05:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d84c24a810dso5929638276.2;
        Tue, 31 Oct 2023 19:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698804358; x=1699409158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEKlb9+ZY0B9mrv/T98IQK90StjaDbNde8cN8esmJ2I=;
        b=KewMRLCavlkUTR3cNhriYucpF6RDEPSScNbMu4qbpZRcqy6VyMofzJJEMs7ROzaoUS
         oiJ6OKL4gbo/GIdeZXHRhu94d9ny6JprulGkZ5/My2WYIRA9buFx1aC6oX4W7griBKSb
         xtGKoD5fACuiEKMhuc7cmq7v+zztzeBfRAMwasvQ4N3DlPe6qN2wOOdAdYFeDns8hrlh
         uYIhpsqHjc2XyfxLiBSwCxsZC4WBJJhZrD4aOekc8255Dasykwgx8y2ds68QB+Ojs8a6
         3mgcPeZSZarHESGMC99azyGF4Ez4EQcDkKlKzdXAN+50D73vc1YnBi1ZkqfB/xUoJesK
         Wnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698804358; x=1699409158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEKlb9+ZY0B9mrv/T98IQK90StjaDbNde8cN8esmJ2I=;
        b=BZWj9METYo9OFzJilYQVQhGiu6dY1k3MAsrZsoYhjsyLd9b3vvrqUJHEdQtdISNHD8
         oL2BymAxyQ753uhUQNdDccF1PZT9z76b2dvW6/uLkc04Yc96en/xWYYbhwstqCsOT+se
         LN+TGqvO9mhsN+e8YtroG/tRRxd7Bf9DLYVXX9jeNN3NQwWBO2LarguatqHiBiqqQK5W
         O72yDxLdAMHZTE7qogpiOEA3y1EuNLIkgYzI5GEV5cA9oBcn07Rl4xyBOVTjzkwy3IgK
         9ei0oIUAlDqEeldY2s85ABZGEULmBychLqrOzDMTny+0RZXpsWOKkmnyLTlewMKRImTa
         monQ==
X-Gm-Message-State: AOJu0Yz3oC7DkQ970W107QtEDWSG2zHbql0k0ptN/NOnXomggdLJgFH7
        B7QXgUC1JzAi8KXuOLsxWCdFoT+prjMiWF+nx5Q=
X-Google-Smtp-Source: AGHT+IFooif2X5+/CJeuSxxULskFOAk5A4KRknHkAg3yGC3gdg+4uZvRH2WSCmbJ5vxEtXGGlfsugeWUSMqdBCqfOcM=
X-Received: by 2002:a25:68cd:0:b0:da0:4453:8f10 with SMTP id
 d196-20020a2568cd000000b00da044538f10mr12049799ybc.43.1698804357417; Tue, 31
 Oct 2023 19:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698717154.git.zhoubinbin@loongson.cn> <7fae3ce932b455effcf73ff0208f4776959f2f44.1698717154.git.zhoubinbin@loongson.cn>
 <20231031175342.GA1805362-robh@kernel.org>
In-Reply-To: <20231031175342.GA1805362-robh@kernel.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Wed, 1 Nov 2023 08:05:46 +0600
Message-ID: <CAMpQs4+fz7Xx90QnU23kRAtcyaq9nFQAfp7Qa1RxWhpKr_TiHw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: interrupt-controller:
 loongson,liointc: Fix dtbs_check for interrupt-names
To:     Rob Herring <robh@kernel.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 31, 2023 at 11:53=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Oct 31, 2023 at 10:36:38AM +0800, Binbin Zhou wrote:
> > The Loongson-2K0500/2K1000 CPUs have 64 interrupt sources as inputs, an=
d
> > a route-mapped node handles up to 32 interrupt sources, so two liointc
> > nodes are defined in dts{i}.
> > Of course, we need to ensure that the routing outputs (intx) of the two
> > nodes cannot conflict.
> >
> > For example, in Loongson-2K1000, 'int0' is typically used by the lioint=
c0
> > node, then the liointc1 node can only use the outputs starting with
> > 'int1'.
> >
> > So "interrupt-names" should be defined by "pattern".
> >
> > This fixes dtbs_check warning:
> >
> > DTC_CHK arch/loongarch/boot/dts/loongson-2k0500-ref.dtb
> > arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1=
fe11440: interrupt-names:0: 'int0' was expected
> >         From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> > arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1=
fe11440: Unevaluated properties are not allowed ('interrupt-names' was unex=
pected)
> >         From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> > DTC_CHK arch/loongarch/boot/dts/loongson-2k1000-ref.dtb
> > arch/loongarch/boot/dts/loongson-2k1000-ref.dtb: interrupt-controller@1=
fe01440: interrupt-names:0: 'int0' was expected
> >         From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> > arch/loongarch/boot/dts/loongson-2k1000-ref.dtb: interrupt-controller@1=
fe01440: Unevaluated properties are not allowed ('interrupt-names' was unex=
pected)
> >         From schema: Documentation/devicetree/bindings/interrupt-contro=
ller/loongson,liointc.yaml
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../bindings/interrupt-controller/loongson,liointc.yaml    | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loo=
ngson,liointc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/loongson,liointc.yaml
> > index 7393d7dfbe82..a90c609d351e 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,l=
iointc.yaml
> > @@ -54,11 +54,9 @@ properties:
> >    interrupt-names:
> >      description: List of names for the parent interrupts.
> >      items:
> > -      - const: int0
> > -      - const: int1
> > -      - const: int2
> > -      - const: int3
> > +      pattern: int[0-3]
> >      minItems: 1
> > +    maxItems: 4
> >
> >    '#interrupt-cells':
> >      const: 2
> > @@ -87,6 +85,7 @@ required:
> >    - compatible
> >    - reg
> >    - interrupts
> > +  - interrupt-names
>
> A new required property is an ABI break. Is that okay for this platform?
> The commit msg should answer that if so.

Hi Rob:

Thanks for your reply.

In fact, 'interrupt-names' is essential for both liointc-1.0 and
liointc-2.0, and we now pass it to get the corresponding interrupt
number.
To a certain extent, I think it's already 'required'.
Of course, I'll try to explain it more clearly in the commit message.

Thanks.
Binbin
>
>
> >    - interrupt-controller
> >    - '#interrupt-cells'
> >    - loongson,parent-int-map
> > --
> > 2.39.3
> >
