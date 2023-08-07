Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C541771A6D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHGGbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjHGGbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:31:15 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEAB1730
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:30:58 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4872462d9fbso668540e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691389857; x=1691994657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz6eKo8ao64sqXLdxYJHv9qUv5zxZGq6Qjyo6fttDw4=;
        b=mqWQ6iX60FNxqn1uZdDpETS1WqNG6kf0qgn5d2qNxveiPsG7uVPGE44hkvxr0svXsf
         MCelDOTnhurHG9EEQ0GIHC5Rh5W4NedMhlr1gzMIX81oXiOOaflVbHPh+wkrUsCeaww2
         Mk3vAx+AqD5UCOQfkpMjJLnfF1GJah1GEUPcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691389857; x=1691994657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz6eKo8ao64sqXLdxYJHv9qUv5zxZGq6Qjyo6fttDw4=;
        b=NjYmjTFp3+cavw5APuCbbGxw4kHqdgEMM3yS3oYdFKfKWlpYyDPu9TWi0PCg5602gY
         sVKsBzl4OOz4kWvOhhzx6JkUoHqCLBTa8t1dT6RYo5515G/gsgXaHDCfwBEWkpmzDOhd
         j91s61tqj51jW/dTQBe8Zpy8Ub3rXOHpDhYVoEwIs14OCf1fUx36sPXRlIj9k5+WMomM
         Q5p7+nxQqvGrZpSHIL/5NZJ761Inv07cVHcMFDCIjfOYoRiaM/2Fp9CkrMWIfls36KAM
         8QvS3aWROUE7m25pOBsJ+Chp3bS0djcCJ9P//Ca2CF6YdRIickYua4iiHgXAESC1oHPE
         YjFw==
X-Gm-Message-State: AOJu0Yw39GbQiOY5zF00QZnkTSg+iusCK4eqQg8uaG2agHZQztrAfyjq
        vqEewu5HQukVjRduJ9GyhzSdUnRjmw01wNNFYzF6cw==
X-Google-Smtp-Source: AGHT+IHAIsK2vrz4BJhQdqKK6BvozPPoH0WWweyvQz4XE8NxINWS7h3Y07jWSgKFBY6rRarBKCKnMXk8PH9IDMazhhs=
X-Received: by 2002:a1f:4511:0:b0:486:4a16:63c6 with SMTP id
 s17-20020a1f4511000000b004864a1663c6mr2586648vka.15.1691389857325; Sun, 06
 Aug 2023 23:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230803074249.3065586-1-wenst@chromium.org> <20230803074249.3065586-5-wenst@chromium.org>
 <6bf91ced-076f-ecc1-f626-f531f7d991bd@linaro.org>
In-Reply-To: <6bf91ced-076f-ecc1-f626-f531f7d991bd@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 7 Aug 2023 14:30:46 +0800
Message-ID: <CAGXv+5HkKQ79k8T7LbowpHLCLHDvyxKrOZn=PePyrPREdpT1sg@mail.gmail.com>
Subject: Re: [PATCH 4/9] regulator: dt-bindings: mediatek: Add MT6366 PMIC
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:23=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/08/2023 09:42, Chen-Yu Tsai wrote:
> > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> >
> > The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
> > to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators and
> > 29 LDO regulators, not counting ones that feed internally and basically
> > have no controls. The regulators are named after their intended usage
> > for the SoC and system design, thus not named generically as ldoX or
> > dcdcX, but as vcn33 or vgpu.
> >
> > Add a binding document describing all the regulators and their supplies=
.
> >
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > [wens@chromium.org: major rework and added commit message]
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since Zhiyong's last version (v4) [1]:
> > - simplified regulator names
> > - added descriptions to regulators
> > - removed bogus regulators (*_sshub)
> > - merged vcn33-wifi and vcn33-bt as vcn33
> > - added missing regulators (vm18, vmddr, vsram-core)
> > - cut down examples to a handful of cases and made them complete
> > - expanded commit message a lot
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhi=
yong.tao@mediatek.com/
> >
> >  .../regulator/mediatek,mt6366-regulator.yaml  | 154 ++++++++++++++++++
> >  1 file changed, 154 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/mediate=
k,mt6366-regulator.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt636=
6-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6=
366-regulator.yaml
> > new file mode 100644
> > index 000000000000..715c6ffcb3ab
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regul=
ator.yaml
> > @@ -0,0 +1,154 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MT6366 Regulator from MediaTek Integrated
> > +
> > +maintainers:
> > +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> > +
> > +description: |
> > +  Regulator part of the MT6366 PMIC. This node should be under the PMI=
C's
> > +  device node.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6366-regulator
> > +
> > +  vsys_ldo1-supply:
>
> Don't use underscores in property names. Only hyphens, if needed.

I assume that applies even if the actual name in the datasheet has
underscores?

Will change, but will wait on discussion on patch 3 before sending a new
revision.

ChenYu


> > +    description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28, =
vsim1, vusb, vbif28
> > +  vsys_ldo2-supply:
>
>
>
> Best regards,
> Krzysztof
>
