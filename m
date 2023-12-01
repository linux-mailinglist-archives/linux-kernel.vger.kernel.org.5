Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC378002A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjLAEhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjLAEhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:37:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3DE171B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 20:37:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bc053a9a7so2497453e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 20:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701405465; x=1702010265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+jcpVk/CzMrLl1xGP/BznaGgT2T4KFEs7BkhiB0I8U=;
        b=WQTx8HFPEO943LbdIt/oxjvMXRxLn01/KEs/gmF9kOK+7n5+ZxQM+V3JXn53W481aZ
         PFUHpyjEdxjQXBanHtfR4bHfuAeWyCgJDOdemfCTwcpxU45dU4PONy0JFsNGl7xYUX4D
         84QfW1juZgvFAf4Y6P7RV+bfQke4KkUE0jB8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701405465; x=1702010265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+jcpVk/CzMrLl1xGP/BznaGgT2T4KFEs7BkhiB0I8U=;
        b=C8SULHfoCU87nJ8gxjUdAbexlO0GZWu0bhFsw3h/sCbJG+VC20kayuDj0KGB3DwDKy
         p5+23dXaAOFpNm2QR41JX/Iv1RY4IhDCuq0Fb9uVKnBZMHNwlskHuXpquctwEACeLrHV
         tmcQqA3yNOdMVEPN2oXvxZRAUowMCBKi3EgQPzS46anH7yYHWpac2WE0LxSIeGuL+v1w
         pGRRaWg+dH+gZ80Aw36ToKz3NkdUT/QDnKQ7bWjzbXYa/LkldwMYdmAQeYE+V5maG4FU
         ZfhTZFGwn9J9A7JC9Z9f1SYmPCP5c6gmUa2ZewHB9gnhIyBbdL9mymEHn5re/3Icuqaq
         g1fg==
X-Gm-Message-State: AOJu0Yy/oXPVx/MHl+UGONH9P9O68YDJP9i4OW6MGfN4v7ALVRk+18Nz
        91Q4VVOmNitjm2KCweU27QDTd0ovjGekJeujCkcj/w==
X-Google-Smtp-Source: AGHT+IHjtP70U0cou0Khp4frD8Bd9W2gzREg9o3JzohtHlJxZwZqTL81+2+AdCVmMC8QPCRHBgSKZ2QKlPiqh2l+Yf4=
X-Received: by 2002:ac2:46db:0:b0:50b:c2ed:e28a with SMTP id
 p27-20020ac246db000000b0050bc2ede28amr232773lfo.13.1701405465218; Thu, 30 Nov
 2023 20:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20231130083333.932862-1-wenst@chromium.org> <2288442b-9002-4711-9b64-16b204f19985@linaro.org>
In-Reply-To: <2288442b-9002-4711-9b64-16b204f19985@linaro.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Dec 2023 12:37:34 +0800
Message-ID: <CAGXv+5HwzSX=x_0u-95i1+q+xbstrCmuMxRoKXJwEL5ErnRgOQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mfd: cros-ec: Allow interrupts-extended property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 4:52=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/11/2023 09:33, Chen-Yu Tsai wrote:
> > "interrupts-extended" provides a more concise way of describing externa=
l
> > GPIO interrupts.
> >
> > Allow using this instead of "interrupts" plus "interrupt-parent" for
> > cros-ec.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  .../devicetree/bindings/mfd/google,cros-ec.yaml          | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml =
b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > index e1ca4f297c6d..e514eac9f4fc 100644
> > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > @@ -75,6 +75,9 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  interrupts-extended:
> > +    maxItems: 1
> > +
>
> I don't understand why you need it. You already have interrupts there,
> so this is redundant. I suggest to drop the patch or provide real
> rationale (which I doubt you can get :) ).

I'm sorry, I should've included this in the commit message.

The other half of the patch gets rid of a DT validation fail when
interrupts-extended is used instead of interrupts:

.../arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb: ec@0:
'interrupts' is a required property
    from schema $id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#


maxItems for interrupts-extended was included for completeness. Maybe it
isn't needed? But then how would the validator know how many items should
there be when interrupts-extended is used


Regards
ChenYu
