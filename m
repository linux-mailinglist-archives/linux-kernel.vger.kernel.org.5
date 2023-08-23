Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6747785260
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjHWIKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjHWIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:07:53 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F8C1BE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:07:48 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-48d0e739e32so1205027e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692778068; x=1693382868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWFQ+NRj1pvHQgNGUhiVooOT67xBmu6h5n2vJTdEj0I=;
        b=UFqTKpPHyzNHb0sjEHOuKCw8OF0dmFmGIrQYM6JGdimaBQ77YA0moK7kjzz47pYKeR
         /XfpnZv1h2Eft9kjW1luBgQPr9ziIMFIE7TKgAtVXDwXPa8C7ia1MNijgRk/YNBZd/WW
         4NmGN930VNUBDmPRPpKdUQ8UQ5ynYZ/Gjnpp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778068; x=1693382868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWFQ+NRj1pvHQgNGUhiVooOT67xBmu6h5n2vJTdEj0I=;
        b=BGwDqnVuEv2waq+kQNNmlhvvlKtr+Qfw0mY5EI7RB9q7+K9Xv1QLT+AUqu1lMhKjH6
         mEjH7uhC13oZFMirdiDFKzPHY0Zx1yTIhmK784FFXawxN1Rzdf3p6YSwqWoFZuGbxyRA
         qhB9ZD8qZg873lBZ2KljAEvN/tsmz6pgCQjkKlWWdimGuIxB7iD8e39FaMXNVaJ+bV/k
         oG+DiKzxv80ngV2QgpswvmLJYUHUKOccHIDlw1IF/kAcIgpAA4SreoqY5od2qsP1/Mrf
         9pl8LVw0SsQQDRWhSxzinQ8oaPsD/t7wL8uZcYBhgR6Lt+WUgamqfTP59yQd7S8SZ1bq
         7TSQ==
X-Gm-Message-State: AOJu0YxrGdhbyjRVNAl5n4YcOwRzVQVJ/Z0hySFNuL+mOWnDyzJ+XIyt
        Ha2NPFu7Bdni1f2i2njtMpqeypILPwAH1ySB38II9w==
X-Google-Smtp-Source: AGHT+IHlzmZBjeac46F4tWF53DAqr8iZMwG0CpZ00NsY2irL7eT3YbCn2qMWaWYc/4NQI4kWsxvYUjcNBkT0GXQWyeY=
X-Received: by 2002:a1f:c682:0:b0:48d:bb6:841d with SMTP id
 w124-20020a1fc682000000b0048d0bb6841dmr8091733vkf.12.1692778067885; Wed, 23
 Aug 2023 01:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230822084520.564937-1-wenst@chromium.org> <20230822084520.564937-6-wenst@chromium.org>
 <337f20d5-4dfe-90ef-16b9-c10b14060b97@linaro.org> <60221aab-d8da-9f0b-057b-e8a28840849f@linaro.org>
 <CAGXv+5EiiDT_TWdyhrdq7HrBuMxpzZeKWNuhiVqJpmzcHEhaMA@mail.gmail.com> <c0289603-f498-2b6b-c45a-82ba400f2f58@linaro.org>
In-Reply-To: <c0289603-f498-2b6b-c45a-82ba400f2f58@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 23 Aug 2023 16:07:36 +0800
Message-ID: <CAGXv+5H60PQpVQ6A06ZuY5V1n5OxEYcH097UiaoQumVRjTc+JA@mail.gmail.com>
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

On Wed, Aug 23, 2023 at 1:45=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/08/2023 06:20, Chen-Yu Tsai wrote:
> > On Wed, Aug 23, 2023 at 3:40=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 22/08/2023 21:39, Krzysztof Kozlowski wrote:
> >>> On 22/08/2023 10:45, Chen-Yu Tsai wrote:
> >>>> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> >>>>
> >>>> The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is design=
ed
> >>>> to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators =
and
> >>>> 29 LDO regulators, not counting ones that feed internally and basica=
lly
> >>>> have no controls. The regulators are named after their intended usag=
e
> >>>> for the SoC and system design, thus not named generically as ldoX or
> >>>> dcdcX, but as vcn33 or vgpu.
> >>>>
> >>>> Add a binding document describing all the regulators and their suppl=
ies.
> >>>>
> >>>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> >>>> [wens@chromium.org: major rework and added commit message]
> >>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>>> ---
> >>>> Changes since v1:
> >>>> - Replaced underscores in supply names to hyphens
> >>>> - Merged with MT6358 regulator binding
> >>>> - Added MT6358 fallback compatible to MT6366 regulator
> >>>>
> >>>> Changes since Zhiyong's last version (v4) [1]:
> >>>> - simplified regulator names
> >>>> - added descriptions to regulators
> >>>> - removed bogus regulators (*_sshub)
> >>>> - merged vcn33-wifi and vcn33-bt as vcn33
> >>>> - added missing regulators (vm18, vmddr, vsram-core)
> >>>> - cut down examples to a handful of cases and made them complete
> >>>> - expanded commit message a lot
> >>>>
> >>>> [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-=
zhiyong.tao@mediatek.com/
> >>>>  .../regulator/mediatek,mt6358-regulator.yaml  | 227 +++++++++++++--=
---
> >>>>  1 file changed, 168 insertions(+), 59 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt=
6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,=
mt6358-regulator.yaml
> >>>> index 82328fe17680..b350181f33ff 100644
> >>>> --- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-re=
gulator.yaml
> >>>> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-re=
gulator.yaml
> >>>> @@ -16,14 +16,18 @@ description: |
> >>>>
> >>>>  properties:
> >>>>    compatible:
> >>>> -    const: mediatek,mt6358-regulator
> >>>> +    oneOf:
> >>>> +      - const: mediatek,mt6358-regulator
> >>>> +      - items:
> >>>> +          - const: mediatek,mt6366-regulator
> >>>> +          - const: mediatek,mt6358-regulator
> >>>>
> >>>>    vsys-ldo1-supply:
> >>>>      description: Supply for LDOs vfe28, vxo22, vcn28, vaux18, vaud2=
8, vsim1, vusb, vbif28
> >>>>    vsys-ldo2-supply:
> >>>> -    description: Supply for LDOs vldo28, vio28, vmc, vmch, vsim2
> >>>> +    description: Supply for LDOs vldo28 (MT6358 only), vio28, vmc, =
vmch, vsim2
> >>>>    vsys-ldo3-supply:
> >>>> -    description: Supply for LDOs vcn33, vcama1, vcama2, vemc, vibr
> >>>> +    description: Supply for LDOs vcn33, vcama[12] (MT6358 only), ve=
mc, vibr
> >>>>    vsys-vcore-supply:
> >>>>      description: Supply for buck regulator vcore
> >>>>    vsys-vdram1-supply:
> >>>> @@ -43,75 +47,138 @@ properties:
> >>>>    vsys-vs2-supply:
> >>>>      description: Supply for buck regulator vs2
> >>>>    vs1-ldo1-supply:
> >>>> -    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio, vio1=
8
> >>>> +    description: Supply for LDOs vrf18, vefuse, vcn18, vcamio (MT63=
58 only), vio18
> >>>>    vs2-ldo1-supply:
> >>>> -    description: Supply for LDOs vdram2
> >>>> +    description: Supply for LDOs vdram2, vmddr (MT6366 only)
> >>>>    vs2-ldo2-supply:
> >>>>      description: Supply for LDOs vrf12, va12
> >>>>    vs2-ldo3-supply:
> >>>> -    description: Supply for LDOs vsram-gpu, vsram-others, vsram-pro=
c11, vsram-proc12
> >>>> -  vs2-ldo4-supply:
> >>>> -    description: Supply for LDO vcamd
> >>>> -
> >>>> -patternProperties:
> >>>> -  "^buck_v(core|dram1|gpu|modem|pa|proc1[12]|s[12])$":
> >>>> -    description: Buck regulators
> >>>> -    type: object
> >>>> -    $ref: regulator.yaml#
> >>>> -    unevaluatedProperties: false
> >>>> -
> >>>> -  "^ldo_v(a|rf)12":
> >>>> -    description: LDOs with fixed 1.2V output and 0~100/10mV tuning
> >>>> -    type: object
> >>>> -    $ref: regulator.yaml#
> >>>> -    unevaluatedProperties: false
> >>>> -
> >>>> -  "^ldo_v((aux|cn|io|rf)18|camio)":
> >>>> -    description: LDOs with fixed 1.8V output and 0~100/10mV tuning
> >>>> -    type: object
> >>>> -    $ref: regulator.yaml#
> >>>> -    unevaluatedProperties: false
> >>>> -
> >>>> -  "^ldo_vxo22":
> >>>> -    description: LDOs with fixed 2.2V output and 0~100/10mV tuning
> >>>> -    type: object
> >>>> -    $ref: regulator.yaml#
> >>>> -    unevaluatedProperties: false
> >>>> -
> >>>> -  "^ldo_v(aud|bif|cn|fe|io)28":
> >>>> -    description: LDOs with fixed 2.8V output and 0~100/10mV tuning
> >>>> -    type: object
> >>>> -    $ref: regulator.yaml#
> >>>> -    unevaluatedProperties: false
> >>>> -
> >>>> -  "^ldo_vusb":
> >>>> -    description: LDOs with fixed 3.0V output and 0~100/10mV tuning
> >>>> -    type: object
> >>>> -    $ref: regulator.yaml#
> >>>> -    unevaluatedProperties: false
> >>>> -
> >>>> -  "^ldo_vsram_(gpu|others|proc1[12])$":
> >>>> -    description: LDOs with variable output
> >>>> -    type: object
> >>>> -    $ref: regulator.yaml#
> >>>> -    unevaluatedProperties: false
> >>>> -
> >>>> -  "^ldo_v(cama[12]|camd|cn33|dram2|efuse|emc|ibr|ldo28|mc|mch|sim[1=
2])$":
> >>>> -    description: LDOs with variable output and 0~100/10mV tuning
> >>>> -    type: object
> >>>> -    $ref: regulator.yaml#
> >>>> -    unevaluatedProperties: false
> >>>
> >>> I don't understand. You just added it and it is already wrong? Please=
,
> >>> do not add code which is clearly incorrect.
> >>
> >> Sent too early - anyway properties cannot be defined in allOf:. That's
> >> not the place for them and there is no single reason for it. From whic=
h
> >> regulator binding you got this example?
> >
> > None. It was simply a way I figured out when I was reading up on JSON
> > schema syntax. I wanted to split the definitions cleanly, since they
> > are very different. And with "unevaluatedProperties: false" in the base
> > schema it did seem to work, successfully evaluating existing device tre=
es
> > and producing errors when extra properties were added, or if types didn=
't
> > match up.
>
> If they are very different, this should not have been one binding. There
> is little benefit of that.

But how would one handle sharing a common fallback compatible if it were
split? In v1 they were separate bindings, but then Angelo argued that they
were in fact very similar and the variants can be detected through hardware
registers.

Note that the vastly different regulator names here are done for aesthetic
reasons. The MT6358 had names with underscores and IMHO unneeded prefixes.
These can't be changed due to existing device trees using them. (Or we
could break the ABI.) With the MT6366 I chose to simplify them to match
the exact names from the datasheet, except for the underscores.

ChenYu

> > Now that you mention it, I suppose the preferred way to write it is to
> > have all the properties in the base schema, then negate the ones that
> > don't belong in the allOf: section? It just seems really repetitive giv=
en
> > the child node names for the chip variants are completely different. OO=
TH
> > I guess it would produce better error messages.
>
>
> For regular cases yes, but not if devices differ so much.
>
> Best regards,
> Krzysztof
>
