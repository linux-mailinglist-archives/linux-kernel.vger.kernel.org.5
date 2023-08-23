Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C465C784F90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjHWEUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjHWEUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:20:37 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6732E58
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:20:34 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44d3fceb567so2071626137.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 21:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692764433; x=1693369233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLeSvRfIx4PVPeQt/rFhWm1oDvWuw0iMFdz9tbbC74E=;
        b=Mq1LQgkkgYS6DXeKoiFP4rNMd48SNvrPOeM9XGAyDQtuS+6Njv1fHiPzvP/Z0+kiqH
         90/zX7rTNLn34DM2lDCusrDDLYczXCYvzmwDxwLv2F89ucWmlyA2qizV+TT7oqsTHL9I
         4Wsfhd52yWd6fYoRBSRFC4dbx4P1NpxPo70Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692764433; x=1693369233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLeSvRfIx4PVPeQt/rFhWm1oDvWuw0iMFdz9tbbC74E=;
        b=Lsgrv8HMrBOm4Q94FjZqfHwBkZayerbjdeP8P2ei2qJTdCvSORMoBo+ygVzL6rT0tL
         PmCHGHCDrhl6JNLVisJg60c8z0JgxlA96xtcQY+ceMV1/fSztbTB82t0JH18r6FDdlIs
         ERtzhufgjrXQfaogtTjsw3z+lGpgFTkbus/iVElke1uNe+6Al+L052/Bt9MmKzXlDlM8
         M0skVrFIQrK0rllmfjNlndK7PsDkSuhuV+P4mH5dt8bGeP4t/Qi95Gym5T6qCwpRpk9T
         Zb9Cpct/75lU8XSQHAhlj23xF9zOTW7SdG11PgsIfDTSYuZhQ7eUjRr1maw+0gZ5g95z
         /IgA==
X-Gm-Message-State: AOJu0YxXIISzafuyuEqpywjotLWN9jTQ3q8QFBeZhDaRYKbgtfZhksjx
        QQfJzVLJ9hWrdbUpRyPIgI0qX9XXc/cUXQP9If5YtA==
X-Google-Smtp-Source: AGHT+IGkmJmLY4wMj6vP1TNI7EpooGhWQsy4/U8cmG12MqWmn3P/a0hCY1KT6V16YK3bBft3Jtu+5uBd2DXcc+hCHBE=
X-Received: by 2002:a05:6102:33c7:b0:44d:426f:ab3b with SMTP id
 w7-20020a05610233c700b0044d426fab3bmr4527009vsh.15.1692764433743; Tue, 22 Aug
 2023 21:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230822084520.564937-1-wenst@chromium.org> <20230822084520.564937-6-wenst@chromium.org>
 <337f20d5-4dfe-90ef-16b9-c10b14060b97@linaro.org> <60221aab-d8da-9f0b-057b-e8a28840849f@linaro.org>
In-Reply-To: <60221aab-d8da-9f0b-057b-e8a28840849f@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 23 Aug 2023 12:20:22 +0800
Message-ID: <CAGXv+5EiiDT_TWdyhrdq7HrBuMxpzZeKWNuhiVqJpmzcHEhaMA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] regulator: dt-bindings: mediatek: Add MT6366 PMIC
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 3:40=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/08/2023 21:39, Krzysztof Kozlowski wrote:
> > On 22/08/2023 10:45, Chen-Yu Tsai wrote:
> >> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> >>
> >> The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
> >> to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators an=
d
> >> 29 LDO regulators, not counting ones that feed internally and basicall=
y
> >> have no controls. The regulators are named after their intended usage
> >> for the SoC and system design, thus not named generically as ldoX or
> >> dcdcX, but as vcn33 or vgpu.
> >>
> >> Add a binding document describing all the regulators and their supplie=
s.
> >>
> >> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> >> [wens@chromium.org: major rework and added commit message]
> >> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >> ---
> >> Changes since v1:
> >> - Replaced underscores in supply names to hyphens
> >> - Merged with MT6358 regulator binding
> >> - Added MT6358 fallback compatible to MT6366 regulator
> >>
> >> Changes since Zhiyong's last version (v4) [1]:
> >> - simplified regulator names
> >> - added descriptions to regulators
> >> - removed bogus regulators (*_sshub)
> >> - merged vcn33-wifi and vcn33-bt as vcn33
> >> - added missing regulators (vm18, vmddr, vsram-core)
> >> - cut down examples to a handful of cases and made them complete
> >> - expanded commit message a lot
> >>
> >> [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zh=
iyong.tao@mediatek.com/
> >>  .../regulator/mediatek,mt6358-regulator.yaml  | 227 +++++++++++++----=
-
> >>  1 file changed, 168 insertions(+), 59 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt63=
58-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt=
6358-regulator.yaml
> >> index 82328fe17680..b350181f33ff 100644
> >> --- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regu=
lator.yaml
> >> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regu=
lator.yaml
> >> @@ -16,14 +16,18 @@ description: |
> >>
> >>  properties:
> >>    compatible:
> >> -    const: mediatek,mt6358-regulator
> >> +    oneOf:
> >> +      - const: mediatek,mt6358-regulator
> >> +      - items:
> >> +          - const: mediatek,mt6366-regulator
> >> +          - const: mediatek,mt6358-regulator
> >>
> >>    vsys-ldo1-supply:
> >>      description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud28,=
 vsim1, vusb, vbif28
> >>    vsys-ldo2-supply:
> >> -    description: Supply for LDOs vldo28, vio28, vmc, vmch, vsim2
> >> +    description: Supply for LDOs vldo28 (MT6358 only), vio28, vmc, vm=
ch, vsim2
> >>    vsys-ldo3-supply:
> >> -    description: Supply for LDOs vcn33, vcama1, vcama2, vemc, vibr
> >> +    description: Supply for LDOs vcn33, vcama[12] (MT6358 only), vemc=
, vibr
> >>    vsys-vcore-supply:
> >>      description: Supply for buck regulator vcore
> >>    vsys-vdram1-supply:
> >> @@ -43,75 +47,138 @@ properties:
> >>    vsys-vs2-supply:
> >>      description: Supply for buck regulator vs2
> >>    vs1-ldo1-supply:
> >> -    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio, vio18
> >> +    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio (MT6358=
 only), vio18
> >>    vs2-ldo1-supply:
> >> -    description: Supply for LDOs vdram2
> >> +    description: Supply for LDOs vdram2, vmddr (MT6366 only)
> >>    vs2-ldo2-supply:
> >>      description: Supply for LDOs vrf12, va12
> >>    vs2-ldo3-supply:
> >> -    description: Supply for LDOs vsram-gpu, vsram-others, vsram-proc1=
1, vsram-proc12
> >> -  vs2-ldo4-supply:
> >> -    description: Supply for LDO vcamd
> >> -
> >> -patternProperties:
> >> -  "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
> >> -    description: Buck regulators
> >> -    type: object
> >> -    $ref: regulator.yaml#
> >> -    unevaluatedProperties: false
> >> -
> >> -  "^ldo_v(a|rf)12":
> >> -    description: LDOs with fixed 1.2V output and 0~100/10mV tuning
> >> -    type: object
> >> -    $ref: regulator.yaml#
> >> -    unevaluatedProperties: false
> >> -
> >> -  "^ldo_v((aux|cn|io|rf)18|camio)":
> >> -    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
> >> -    type: object
> >> -    $ref: regulator.yaml#
> >> -    unevaluatedProperties: false
> >> -
> >> -  "^ldo_vxo22":
> >> -    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
> >> -    type: object
> >> -    $ref: regulator.yaml#
> >> -    unevaluatedProperties: false
> >> -
> >> -  "^ldo_v(aud|bif|cn|fe|io)28":
> >> -    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
> >> -    type: object
> >> -    $ref: regulator.yaml#
> >> -    unevaluatedProperties: false
> >> -
> >> -  "^ldo_vusb":
> >> -    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
> >> -    type: object
> >> -    $ref: regulator.yaml#
> >> -    unevaluatedProperties: false
> >> -
> >> -  "^ldo_vsram_(gpu|others|proc1[12])$":
> >> -    description: LDOs with variable output
> >> -    type: object
> >> -    $ref: regulator.yaml#
> >> -    unevaluatedProperties: false
> >> -
> >> -  "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[12]=
)$":
> >> -    description: LDOs with variable output and 0~100/10mV tuning
> >> -    type: object
> >> -    $ref: regulator.yaml#
> >> -    unevaluatedProperties: false
> >
> > I don't understand. You just added it and it is already wrong? Please,
> > do not add code which is clearly incorrect.
>
> Sent too early - anyway properties cannot be defined in allOf:. That's
> not the place for them and there is no single reason for it. From which
> regulator binding you got this example?

None. It was simply a way I figured out when I was reading up on JSON
schema syntax. I wanted to split the definitions cleanly, since they
are very different. And with "unevaluatedProperties: false" in the base
schema it did seem to work, successfully evaluating existing device trees
and producing errors when extra properties were added, or if types didn't
match up.

Now that you mention it, I suppose the preferred way to write it is to
have all the properties in the base schema, then negate the ones that
don't belong in the allOf: section? It just seems really repetitive given
the child node names for the chip variants are completely different. OOTH
I guess it would produce better error messages.


ChenYu
