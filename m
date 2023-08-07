Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D02771A81
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHGGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHGGhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:37:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234701711
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:37:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so5773519a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691390220; x=1691995020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30W1zdBmETkyXWkWaDUid9up8ZT6wPkzIdNcTDnK3pk=;
        b=mgLuV22coTdq7+o6lIsl9a8OScBnl9AOir7rb+tc5mEeGXg+Us1ePBiQ4cG0GvH35U
         NlFkRk4Pv17Cq9Vdls1E3oeaESuJ6tQXTd0OSGzsZdSuF7b/BAHN9CXzkY+m8Tw32Udm
         foDshWzor2s55MsqGzZqitomqSvyJyhvNW1LIEzDtyuC3gF8GLhKFOFuV1Ku+YwCcsYT
         AG5TbOgBr2jH+9x79q+pSDthnu9qqAKEj+ia+XzbVfFnCPYaYKOmCKx9xDwgnmkitf6E
         v4RTPROr9bbPHEeuuHIoEb7cwy+7W3JhFX9KZeA8q7eHf5fJ7xhWbY2BnejiHtuUmmPd
         9+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691390220; x=1691995020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30W1zdBmETkyXWkWaDUid9up8ZT6wPkzIdNcTDnK3pk=;
        b=V3HlqZlOjsUo9i1wmEm87nPUuOWDA4qLG4SU1nVDgotzJ8A52o/lZBH59VvRnw8LMO
         uicBZqGCuvsHkL51F7mfZWj9t85Vpj1FP7nBg2xt6HxZ7kd7X9z0mwVcFkCQ+h7/iu9K
         O9uh1pt0dLKQYTiEpjfwATY4sI1Qp2ZpukHpQz7hw8pr5g1SHQSL85Q5T2UPkXNrlXQ4
         0UlzHWsMFuzJTHWujGs0cEb2eyRCMMk1ltrxunYiISA3LNSr1b8A9vN9sjnTUYKPEkaq
         w7IJFkqFbO6ndA+5I+2qlKkkydekd03tRzD1n6hO0qmfdYJmzZikeSFClyJaZG5f2qPj
         uxfQ==
X-Gm-Message-State: AOJu0Yx1+r3TU3KLjEPvSHsFNabLsdQAWCu221zYNhP0FZK0KnHqJHR6
        PVBX0etkXr4iUnTBq8e0XCvuZQ==
X-Google-Smtp-Source: AGHT+IGH6tPkeAOx5ATPlagL1cpzHldL3hmthfO/OFgujaf+sCL5ZkvBRVDjNTN0aKiV74FNSyh3uw==
X-Received: by 2002:a17:907:2cce:b0:99c:6312:73ca with SMTP id hg14-20020a1709072cce00b0099c631273camr7151896ejc.71.1691390220605;
        Sun, 06 Aug 2023 23:37:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id lt1-20020a170906fa8100b009934707378fsm4707446ejb.87.2023.08.06.23.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:37:00 -0700 (PDT)
Message-ID: <95cf4d1d-a697-c42c-e904-1cbb58ec9878@linaro.org>
Date:   Mon, 7 Aug 2023 08:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/9] regulator: dt-bindings: mediatek: Add MT6366 PMIC
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
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
References: <20230803074249.3065586-1-wenst@chromium.org>
 <20230803074249.3065586-5-wenst@chromium.org>
 <6bf91ced-076f-ecc1-f626-f531f7d991bd@linaro.org>
 <CAGXv+5HkKQ79k8T7LbowpHLCLHDvyxKrOZn=PePyrPREdpT1sg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGXv+5HkKQ79k8T7LbowpHLCLHDvyxKrOZn=PePyrPREdpT1sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 08:30, Chen-Yu Tsai wrote:
> On Mon, Aug 7, 2023 at 2:23 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 03/08/2023 09:42, Chen-Yu Tsai wrote:
>>> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
>>>
>>> The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
>>> to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators and
>>> 29 LDO regulators, not counting ones that feed internally and basically
>>> have no controls. The regulators are named after their intended usage
>>> for the SoC and system design, thus not named generically as ldoX or
>>> dcdcX, but as vcn33 or vgpu.
>>>
>>> Add a binding document describing all the regulators and their supplies.
>>>
>>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
>>> [wens@chromium.org: major rework and added commit message]
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> Changes since Zhiyong's last version (v4) [1]:
>>> - simplified regulator names
>>> - added descriptions to regulators
>>> - removed bogus regulators (*_sshub)
>>> - merged vcn33-wifi and vcn33-bt as vcn33
>>> - added missing regulators (vm18, vmddr, vsram-core)
>>> - cut down examples to a handful of cases and made them complete
>>> - expanded commit message a lot
>>>
>>> [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/
>>>
>>>  .../regulator/mediatek,mt6366-regulator.yaml  | 154 ++++++++++++++++++
>>>  1 file changed, 154 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
>>> new file mode 100644
>>> index 000000000000..715c6ffcb3ab
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
>>> @@ -0,0 +1,154 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MT6366 Regulator from MediaTek Integrated
>>> +
>>> +maintainers:
>>> +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
>>> +
>>> +description: |
>>> +  Regulator part of the MT6366 PMIC. This node should be under the PMIC's
>>> +  device node.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,mt6366-regulator
>>> +
>>> +  vsys_ldo1-supply:
>>
>> Don't use underscores in property names. Only hyphens, if needed.
> 
> I assume that applies even if the actual name in the datasheet has
> underscores?

Yes. We follow this already in other bindings. Hardware people can use
any names or characters in the datasheet, e.g. "*".


Best regards,
Krzysztof

