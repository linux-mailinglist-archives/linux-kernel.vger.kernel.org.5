Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322427A7701
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjITJOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjITJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:14:48 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0217091;
        Wed, 20 Sep 2023 02:14:42 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4527ba546d2so1146321137.2;
        Wed, 20 Sep 2023 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695201281; x=1695806081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mF6CeWKLwBn15UINCBFcbVA7YfC1Xb7XUsRVvGCQiA=;
        b=lVHFkwJipBehCTfoV99RYRBWBmepqzW67fyWhzhMR1hyD3b4u6/BZAwm5cLgWDpns2
         JOHHG18FYyJq9K+1YyiJzl5BHyTFGidCJG4iBC2PLuMUiyRFheaEMQj96mZNcUy/lBxi
         So2pQlZHMuB7TbremK2/Xh+fxTLJQNrFMS9ymIeHTi7k5MoBPjS0VhepHK5Qgn8ZHWXf
         ZGN2gYUQMmd3MUjX+VxXCIoPGD5a0l2Yxo4AHbZz7+oQpx6u5A+Vm2djkIIqbdT929SR
         WfhyFHwP/6+AhlZ322ooRXYhlgUsCgLqooYuS0x3mNWl0FB2DxvbJsJPXr8jBjWlZwCg
         t6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695201281; x=1695806081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mF6CeWKLwBn15UINCBFcbVA7YfC1Xb7XUsRVvGCQiA=;
        b=PvMlduzrRCDebndut/BpTCt5nbPoPMX2tUJI/0yjrehGY2F1UGAQoecEIhl3rQpVGB
         8WwXm7u2dYNQ5CU9imPy+r9AYGpc7v8q/H65qRYdxOHVv/PHg4LWg9nnPz2Crjlix/QJ
         AnJ9T7U8J6/MPcnPcMMpwyHFDIH51xsItNMU5Zqj4HgESuLDHY9MKH2IO/blZoV5lllK
         5K01YEhsFJp4S5wPj20sTYGtaCMa/fX5ONLe9pzecAUZA9Oe5cg+OAnl9jTK0ekKXOub
         veFXdBnXxb1673BQjIvtjJ4/SEytUr6WvRk/VujXBAK5nthYve9uuteurdWtNK38C4Wg
         YMvQ==
X-Gm-Message-State: AOJu0YzkQ3KAq+v4oJ5D/zzl9dskTamPIZ3/ngceiEjJ5U2tGDuTkY7G
        tnmy/BWxppTvgKKOG4PCQhpZLsZMbBn6x92tYr4=
X-Google-Smtp-Source: AGHT+IGxzQADeWT6kYJOJKC8HUxl0HRk5ruso9MvtCd8ytX6mRPXAwEeqntPJQ9v3bijs8zJu0D+of8PjYf6VROe+40=
X-Received: by 2002:a67:ebc1:0:b0:452:6fc1:a3e5 with SMTP id
 y1-20020a67ebc1000000b004526fc1a3e5mr1782743vso.1.1695201280888; Wed, 20 Sep
 2023 02:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <dbd7d823a73d8a9484efcd55f6616f5392daf608.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-unable-impish-373fd26b7d16@wendy>
In-Reply-To: <20230920-unable-impish-373fd26b7d16@wendy>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Wed, 20 Sep 2023 17:14:29 +0800
Message-ID: <CAHAQgRAj74HJ2j_Rt+hGxps9T3E1z9c+s61aa-dneWgPmnD2cw@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] dt-bindings: vendor-prefixes: add milkv/sophgo
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
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

Regards,

unicornx

Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=882=
0=E6=97=A5=E5=91=A8=E4=B8=89 16:23=E5=86=99=E9=81=93=EF=BC=9A
>
> Yo,
>
> On Wed, Sep 20, 2023 at 02:37:28PM +0800, Chen Wang wrote:
> > Add new vendor strings to dt bindings.
> > These new vendor strings are used by
> > - Sophgo SG2042 SoC [1]
> > - Milk-V Pioneer board [2], which uses SG2042 chip.
> >
> > [1]: https://en.sophgo.com/product/introduce/sg2042.html
> > [2]: https://milkv.io/pioneer
>
> If you resend, make these link tags please. Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
Sure, I will correct them in next revision. Thanks.

> Thanks,
> Conor.
>
> > Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index 573578db9509..fcca9e070a9a 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -863,6 +863,8 @@ patternProperties:
> >      description: MikroElektronika d.o.o.
> >    "^mikrotik,.*":
> >      description: MikroTik
> > +  "^milkv,.*":
> > +    description: MilkV Technology Co., Ltd
> >    "^miniand,.*":
> >      description: Miniand Tech
> >    "^minix,.*":
> > @@ -1273,6 +1275,8 @@ patternProperties:
> >      description: Solomon Systech Limited
> >    "^sony,.*":
> >      description: Sony Corporation
> > +  "^sophgo,.*":
> > +    description: Sophgo Technology Inc.
> >    "^sourceparts,.*":
> >      description: Source Parts Inc.
> >    "^spansion,.*":
> > --
> > 2.25.1
> >
