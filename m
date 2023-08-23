Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993E1784F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 05:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjHWDym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 23:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjHWDyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 23:54:41 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113ACE51
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:54:39 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-79a31d66002so1691387241.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 20:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692762878; x=1693367678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpgSyn7xJbJ2ia+L5enewNstSLbJUwgFsy1ZDAGcYqY=;
        b=ZaVctbrBfkzXLNwJzOUDXAG923TLvSVpZLakRz0pr87hUdv3ji43rI6flITSmVn97s
         0GsVe/Bj2jtCJC1ibxYAtWWaPjKmPDS6WT+EQnbC9bLNSFtRNODixcCs3CAYj0egtFUl
         1o/DOg8zT1NKQxs8r2OgoanlufkClIcNRlH8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692762878; x=1693367678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpgSyn7xJbJ2ia+L5enewNstSLbJUwgFsy1ZDAGcYqY=;
        b=RsPThTf3QDOaR+d0YjBoBafw2/TI7k60RLbyz0MhGQ5We1X/lI0M0yZlVgKTs5LJtH
         I6jm+WpcNDymgw5Rbw77gNk+OL3FY/wwpApC43xeSntXtRWsLBykg3q+slD1WV0zaKfo
         CBcyZ9YqKKatpfyf4QdGLHxWVofxiTYO5/3Xck8bQZIXqrcXw0AxhQ1UtmwVNgF27HkT
         Nv0CW3fR/IB/Kb3ct9f0YpjBoVLTC0yTAm5arOdKLFDzBEOKNDlAUCfh0RDbsfNQjRa8
         F5PPFDukfxos+0PN7mUnBfXs346/UqFKNbz8oyiIw9WlY3diAbEl4NREQNS3rXjfDVv5
         ituA==
X-Gm-Message-State: AOJu0YxJDBCqPZ3pcMKFeFP8hVIlN8GEfGUprdjJeCC9EKZ12sBPVgOE
        pn1Ev+B6nC86zSq9mdOcIjZE0US4OgFm5tFUjF0m/w==
X-Google-Smtp-Source: AGHT+IGeb5cnr2HQwWpeveiYpAoaqUO+M9ALIglCvEP4e2MermSqivcFXfRWShboeciowdTOYhCl/FeBH0LwVp27qHI=
X-Received: by 2002:a67:de06:0:b0:44d:3c1b:2dc0 with SMTP id
 q6-20020a67de06000000b0044d3c1b2dc0mr8182225vsk.26.1692762878173; Tue, 22 Aug
 2023 20:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230822084520.564937-1-wenst@chromium.org> <20230822084520.564937-4-wenst@chromium.org>
 <5ad5ff92-1367-ba96-b126-da80511a2769@linaro.org>
In-Reply-To: <5ad5ff92-1367-ba96-b126-da80511a2769@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 23 Aug 2023 11:54:27 +0800
Message-ID: <CAGXv+5Gc+R-hUJi5gm8an+dkq3JMD2JGwP4kDakKaHbAX2P0gQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] regulator: dt-bindings: mt6358: Convert to DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 3:47=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/08/2023 10:45, Chen-Yu Tsai wrote:
> > Convert this from the old style text based binding to the new DT schema
> > style. This will make adding the MT6366 portion easier.
> >
> > The examples have been trimmed down considerably, and the remaining
> > entries now match what is seen in actual device trees.
>
> ...
>
> > +---
> > +$id: http://devicetree.org/schemas/regulator/mediatek,mt6358-regulator=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MT6358 Regulator
> > +
> > +maintainers:
> > +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> > +
> > +description: |
>
> Do not need '|' unless you need to preserve formatting.

Ack.

> > +  Regulator node of the PMIC. This node should under the PMIC's device=
 node.
> > +  All voltage regulators provided by the PMIC are described as sub-nod=
es of
> > +  this node.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6358-regulator
> > +
> ...
>
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
>
> mt6397?
>
> > +
> > +    regulator {
> > +        compatible =3D "mediatek,mt6358-regulator";
> > +
> > +        buck_vgpu {
> > +            regulator-name =3D "vgpu";
> > +            regulator-min-microvolt =3D <625000>;
> > +            regulator-max-microvolt =3D <900000>;
> > +            regulator-ramp-delay =3D <6250>;
> > +            regulator-enable-ramp-delay =3D <200>;
> > +            regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
>
> mt6397?
>
> Both cases look a bit confusing.

There's only two regulator binding header files, mt6397 and mt6360.
They seem to correspond to the two classes of PMICs that MediaTek has.
I believe the two header files and thus the macros are meant to be
shared?

MT6397 and co refer to their AP PMICs, i.e. PMICs that are companion
chips to the SoC and provide most of the power rails a system needs,
along with things like RTC, audio codecs, etc.. The MT6358 and MT6366
belong to this class.

MT6360 and possibly others refer to their charger PMICs, which integrate
a battery charger, USB type-C PD stuff, LED drivers, and a handful of
regulators.


ChenYu
