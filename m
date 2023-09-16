Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012487A2CBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbjIPAvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbjIPAu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:50:57 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B080F272E;
        Fri, 15 Sep 2023 17:47:10 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-65637f0d10eso4766716d6.1;
        Fri, 15 Sep 2023 17:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694825228; x=1695430028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBHxW502vU8e53k9oCuqrI/4gYcnPRfLjigLIIeAUug=;
        b=TGYf6yL+lpRLojXBYPaIa4uiZA8pvfPaCakdfkslwqtlGz0xzwwfVPEPi6guLtxdhc
         HToYzCjq7UyGf8CteELt+BTn3keAaMIX2DKwFVp0LlowDcWLjTRl1lW0LU7Oy9ZHANU0
         1GophPdoR4oAjsGFL2QmoiOHLa9g8YZyOmCbN263pillqtXDsiB3gULyDRki0JkbMNQA
         UqUjhoNuWFwM9V+/LrOck6oIxpPAdrnfZ/vKtAF4/n8IRlI24NuBxwowKSmmLIJK2MxD
         JBKDZ2EvVeblxqflSa66c4ek2GqwjGqahGy5X7ZF+EMTUj7aG0R/byKweaMbqdlXi9Ty
         ipLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694825228; x=1695430028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBHxW502vU8e53k9oCuqrI/4gYcnPRfLjigLIIeAUug=;
        b=WXmENQlhItncb2tlECTC2RoJ97E3u9MwXdpVMy9eg62SHxylBFB3tK3MTbev+XL3Zp
         2neQbaFOyEkhspIkUFutg3/+7PQsg+GpYMUAAXA3G73xm7B0p91XEGdabPLVdMQUt16d
         dPgGhZ0+5jKq52EPbyRPbnxHP2VMtNbHXzv2nG0IyLcYr0CqB7LzKHDn3fTHvfuARYZC
         rn/v1p04q1bPTo+RNrrq8JdlxdGMpXUKv1bx5hFwCv2gn4F+I6okfwyFffHkS32VJgp7
         YePQz/cvJcCzsufi+65wFe/0/WZTOJP926NNpZlAlYdHHx38sTvhbbRMh4OZ9x/drb+H
         DH0A==
X-Gm-Message-State: AOJu0YxUOJnm9h+1KZRf3eu7SuEtLrQw96/YA+Sjwd8/jy08Jyw1ApnH
        eOQtnQRQYYyCqg5cwWLQ0dAUNOa6p64khtAtRFo=
X-Google-Smtp-Source: AGHT+IFFKdbmFxyTAEg51NciK8t4OKI137LB+9RsFkYxzW1wvBThEcZn7VBiNX9iRv/ryzCHsYTOgq/nirF2i6sMg+s=
X-Received: by 2002:a0c:f3c4:0:b0:656:eae:d7b2 with SMTP id
 f4-20020a0cf3c4000000b006560eaed7b2mr4468467qvm.2.1694825227951; Fri, 15 Sep
 2023 17:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230915072333.117991-1-wangchen20@iscas.ac.cn>
 <20230915-muster-viability-93d7d4ec2b49@spud> <20230915150332.GA3719864-robh@kernel.org>
In-Reply-To: <20230915150332.GA3719864-robh@kernel.org>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Sat, 16 Sep 2023 08:46:57 +0800
Message-ID: <CAHAQgRAtFBvoKbfL266cjUNnhSCM4UkU=g6n++7XXXeKOXR8yw@mail.gmail.com>
Subject: Re: [PATCH 04/12] dt-bindings: riscv: Add T-HEAD C920 compatibles
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
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

Thanks for your detailed clarification, Rob. I'll pay attention next time.
Regards,

unicornx

Rob Herring <robh@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8815=E6=97=A5=
=E5=91=A8=E4=BA=94 23:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 15, 2023 at 03:11:43PM +0100, Conor Dooley wrote:
> > On Fri, Sep 15, 2023 at 03:23:33PM +0800, Wang Chen wrote:
> > > The C920 is RISC-V CPU cores from T-HEAD Semiconductor.
> > > Notably, the C920 core is used in the SOPHGO SG2042 SoC.
> > >
> > > Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> > > Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> >
> > I figure this is missing a From: or Co-developed-by line.
>
> From: (author) as 2 authors for 1 line change is questionable.
>
> The sender's email should be the last S-o-b. So like this:
>
> From: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
>
> ...
>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
>
>
> >
> > > ---
> > >  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docu=
mentation/devicetree/bindings/riscv/cpus.yaml
> > > index 38c0b5213736..185a0191bad6 100644
> > > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > > @@ -47,6 +47,7 @@ properties:
> > >                - sifive,u74-mc
> > >                - thead,c906
> > >                - thead,c910
> > > +              - thead,c920
> > >            - const: riscv
> > >        - items:
> > >            - enum:
> > > --
> > > 2.25.1
> > >
>
>
