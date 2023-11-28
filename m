Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB31C7FBB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345138AbjK1NU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbjK1NUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:20:24 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A8590;
        Tue, 28 Nov 2023 05:20:30 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1fa289a3b6aso1805011fac.3;
        Tue, 28 Nov 2023 05:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701177629; x=1701782429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On66ueZto3GF440UWVrRBZc4wrXhVsUGn1SXWaiDi8g=;
        b=nOb130mw+xpBoGsNiULUoOXulipzQ/m87Ge8d0uVlx2W0To1XkjSgaYck+hNekcdcq
         8O+RGFRUsxTuSvfTOrC6QcFY/mortnROYFilnD5xZLz8VdJc8CiaTxpTR5DAdm8K8Njm
         H/ZHLFd9lURqj3iTDF0/8p2abXJ1vdxIf34po8M/CPPGQL6D3fAF/6yZwjD06cfDwgXU
         4ZSW7zyvB/vMJ8YhCEciL5KOrhgPR/hjfZLyFzRbT9Hu+DqVvAebX+YOyHJxV2LZt5LR
         Bns+o0nE/0dLwf2UyQxl4uhXbA6SSKZEeHchUh15aHhZ+SeViHrJsd/GINDgF7kHJ97A
         MBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177629; x=1701782429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=On66ueZto3GF440UWVrRBZc4wrXhVsUGn1SXWaiDi8g=;
        b=X5ov/zQ08McqTvG/StlNEiN6wnIbFoSJBQZ4v1NlyWhHoGx8ZxmgR8kqZTOStc+/DI
         QmeIzCszATCNEQnu7xytfo/iCmQxJrQlxwK1uVcsCxhlKkKPAET48uI63Fqt2VD/DKMi
         aDahbkfBkPO+7w4lMpEo6wLeKumpOfdxoqBFaG5lYJmdvfRynqFRORZoKXz/LKid4N/m
         q8wolX6k/hVTX2h/PEwMdlqfKc+0N8r0LBXt216X1y89qZNCA2KcDDqAZMoOFF+95bob
         HFL3Rx9o09xiCnzRHNMt4XwEQeCyC+9wFIQ9VwzkBFFxpqamIDtlo7HGZwYv+wwXbjeD
         gUWg==
X-Gm-Message-State: AOJu0Yw7/VWE2rjtkz+DAuNS+QTOa/fCm77pHMNfhJM3MXKpJoDozhpU
        6SfHSjGXcGRYuwFrTOhOaKvP/hJgkNrUhNMwibAL2/0dhflKVfpH
X-Google-Smtp-Source: AGHT+IEA6UtACp1At/yuKOgBXha03/AXtZNDcuSQGTuIOcoIm/wVD0Z2tmYIHiOzc7bOCaCNw+wXQ+9dUt2B7jIcqqk=
X-Received: by 2002:a05:6870:788c:b0:1eb:e8b:73cb with SMTP id
 hc12-20020a056870788c00b001eb0e8b73cbmr21421178oab.58.1701177629143; Tue, 28
 Nov 2023 05:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20231121094642.2973795-1-qiujingbao.dlmu@gmail.com>
 <20231121094642.2973795-2-qiujingbao.dlmu@gmail.com> <84a12a2c-3f64-4517-8d38-14c8516e70d0@linaro.org>
In-Reply-To: <84a12a2c-3f64-4517-8d38-14c8516e70d0@linaro.org>
From:   jingbao qiu <qiujingbao.dlmu@gmail.com>
Date:   Tue, 28 Nov 2023 21:20:18 +0800
Message-ID: <CAJRtX8ToRv7Bzyj7fZ530H9oYQWGNnEK_2G5EQjECgg_Y37guQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: rtc: add binding for Sophgo CV1800B rtc controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, chao.wei@sophgo.com,
        unicorn_wang@outlook.com, conor+dt@kernel.org, robh+dt@kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 5:57=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/11/2023 10:46, Jingbao Qiu wrote:
> > Add devicetree binding for Sophgo CV1800B SoC rtc controller.
>
> A nit, subject: drop second/last, redundant "binding for". The
> "dt-bindings" prefix is already stating that these are bindings.

will fix.

>
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  .../bindings/rtc/sophgo,cv1800b-rtc.yaml      | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800=
b-rtc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800b-rtc.y=
aml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800b-rtc.yaml
> > new file mode 100644
> > index 000000000000..fefb1e70c45c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800b-rtc.yaml
> > @@ -0,0 +1,37 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rtc/sophgo,cv1800b-rtc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800B SoC RTC Controller
>
> What is a RTC Controller? You have multiple RTCs there?
>

will drop "Controller", as I think RTC is not something like I2C, eMMC, USB=
,
which have the "controller <-> client/device" model.

> > +
> > +maintainers:
> > +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > +
>
> Missing ref to rtc.yaml. Unless it is not applicable but then why?

ok, I should ref this file.

>
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sophgo,cv1800b-rtc
>
> Blank line

ok

>
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: false
>
> unevaluatedProperties instead

will fix .

>
> > +
> > +examples:
> > +  - |
> > +    rtc-controller@05026000{
>
> The names is always "rtc", unless this is not RTC. If it isn't, please
> add full description of the hardware.

I will use "rtc" replace "rtc-controller" .

>
> > +      compatible =3D "sophgo,cv800b-rtc";
> > +      reg =3D <0x05026000 0x1000>;
> > +      interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > +      interrupt-parent =3D <&plic0>;
> > +      clocks =3D <&osc>;
>
> Why do you send untested bindings? Review costs significant amount of
> effort. Code was also not compiled? Warnings not fixed?

I will check it.
Leading 0 and referencing issues will be fixed.

>
> Best regards,
> Krzysztof
>

I'm sorry for taking so long to reply.
I took a few days off due to being infected with the flu.
Thank you again for your patient reply.

Best regards,
Jingbao Qiu
