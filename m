Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C6777172
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjHJHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:38:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE4B1703;
        Thu, 10 Aug 2023 00:38:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so123172a12.1;
        Thu, 10 Aug 2023 00:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691653105; x=1692257905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdMfMM/SdqNtHwQ1XO5GF4QV/3ikuZOysoKPc/8ygig=;
        b=bK2Pkjbr+hS5Z9CKmwOeUuA1ugtA4ICZBt4F/DEwBtq4bdZbvU/Mi90oivC8P7vz7i
         iGQi8SylOF1I3V4ISIPv9VBhlzaxq+HKaFVTWmHE3BwzhsaukKEcAZSuUG1pqxnc8gJY
         3A1Q0QmS9zLX/pD5hDvl3bQU4oNBrBNoVUzAeLjzwa2HjKvnI9q7KjW1CGByfWXy43iJ
         FxyfIuwVVZzk/YoMxtg5cWhu9WavHmej+3d5fXFNebte+7q2AJQ3fRccwglW2Y43NX50
         DZ0poxQ22FonYi6MUjyIJuH4eSc3bN7PlCmV/QXvcA1YOntIt0mAihjmzoabAymOwO4Z
         /K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653105; x=1692257905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdMfMM/SdqNtHwQ1XO5GF4QV/3ikuZOysoKPc/8ygig=;
        b=PvddJG+YAk3nRoluTEvPU4ACMcxePx6p9XIbBZ3bkDR/mlygSUaCONxmmcO+Py2GeC
         y/GuVzEMKygHBYgO1yPkcCmgmcAsRFBLiFw4l45VCQnFU4FRWmvjSpq9eIheseQQWl3/
         +bFzOARMA8IfQBjyxufNGcMdFHsmi85irabgkSFsq/s3Tg4T24rGGAAdMT8S479oqMBA
         iB1ARkGccwXDBdAcXN1bZdW2J/abj8FqoIXxGX2jU1SbzapU9YRUudwpnERLzdrwazdS
         18ee0LUebf08UByN0OXos9uL9nDcx2MKfAOONPl/U/6u8IJ6PFe1EoXtKvruMVDiy5Mx
         1dSA==
X-Gm-Message-State: AOJu0Yw6Fo6wA+pd/JGP6aMqkep9DWPuX1L04c4AxDqfcfU85Q4FVFfm
        Ymg/KsyBg62InikkmcXuGvgQnBNYDtdd/013pYw=
X-Google-Smtp-Source: AGHT+IH+G5fT48hn52GpYPJrTghk6ssBz+EOYR3ZtcNPduVnatcJ4JATNjYsXBpPu+xLgJOsGJdu7VNLIXh9fl5sYQU=
X-Received: by 2002:a17:906:7487:b0:997:d069:a880 with SMTP id
 e7-20020a170906748700b00997d069a880mr1374549ejl.1.1691653104939; Thu, 10 Aug
 2023 00:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230808072252.3229-1-Wenhua.Lin@unisoc.com> <3f17d903-20c4-59ac-f52b-ed108fe9475f@kernel.org>
In-Reply-To: <3f17d903-20c4-59ac-f52b-ed108fe9475f@kernel.org>
From:   wenhua lin <wenhua.lin1994@gmail.com>
Date:   Thu, 10 Aug 2023 15:38:13 +0800
Message-ID: <CAB9BWhcNG4yt_07LmLk8YjFFzbVCqcrDO5e8DYE7e_wSsevWaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] devicetree: bindings: Add keypad driver ducumentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 2:31=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 08/08/2023 09:22, Wenhua Lin wrote:
> > Add keypad driver ducumentation.
>
> 1. Please use scripts/get_maintainers.pl to get a list of necessary
> people and lists to CC. It might happen, that command when run on an
> older kernel, gives you outdated entries. Therefore please be sure you
> base your patches on recent Linux kernel.
>
> You missed at least DT list (maybe more), so this won't be tested by
> automated tooling. Performing review on untested code might be a waste
> of time, thus I will skip this patch entirely till you follow the
> process allowing the patch to be tested.
>
> Please kindly resend and include all necessary To/Cc entries.
>
>
> 2. Please use subject prefixes matching the subsystem. You can get them
> for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
> directory your patch is touching.
>
>
> Limited review follows:
>
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  .../bindings/input/sprd-keypad.yaml           | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/sprd-keypad=
.yaml
>
> Filename matching compatible, so sprd,block-name-etc.yaml
>
> >
> > diff --git a/Documentation/devicetree/bindings/input/sprd-keypad.yaml b=
/Documentation/devicetree/bindings/input/sprd-keypad.yaml
> > new file mode 100644
> > index 000000000000..51710e1eb389
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/sprd-keypad.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2023 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/sprd-keypad.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Device-Tree bindings for GPIO attached keys
>
> This should not work and you should see warnings... which means:
>
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.
>
> so drop "Device-tree bindings".
>
> Title also says nothing about the hardware - it is entirely unrelated.
> Describe the hardware.
>
>
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +description: |
> > +    Keypad controller is used to interface a SoC with a matrix-keypad =
device.
>
> Mention which SoC.
>
> > +    The keypad controller supports multiple row and column lines.
> > +    A key can be placed at each intersection of a unique row and a uni=
que column.
> > +    The keypad controller can sense a key-press and key-release and re=
port the
> > +    event using a interrupt to the cpu.
> > +
> > +properties:
> > +    compatible:
> > +    const: sprd,sc9860-keypad
> > +
> > +    reg:
> > +        maxItems: 1
>
> OK, so this was for 100% not tested and won't work. No need to waste our
> time on this. Test before sending:
>
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.
>
> Best regards,
> Krzysztof
>

Hi Krzysztof:
   This is a mistake of ours, sorry for wasting your precious time.

Thanks
Wenhua.Lin
