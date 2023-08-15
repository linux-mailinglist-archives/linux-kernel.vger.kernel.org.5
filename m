Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B5577D4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbjHOVLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbjHOVLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:11:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98D9AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:11:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9923833737eso774569166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692133870; x=1692738670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9aC/ossKYxTISDH8R+YhqoUzqggrmfQ7aidlPBuOX0=;
        b=QqNvMeZeGm2Ei0pk5DQcG0lsP8wgS+MpbVXzUqAnMpCfIkE2wE704qScT9wn0h9uss
         osUP6fhVcmagjY3Z+P8yPeRiSixeXcadX1+umFGLZHob0+q2sGDj9V66C+9OmS8Jo/gq
         /wofk7WUSwgOHFXNF/V3MD7Iu9n+uFOk5PQRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133870; x=1692738670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9aC/ossKYxTISDH8R+YhqoUzqggrmfQ7aidlPBuOX0=;
        b=VLSVBEnfbPIh19m9ygAcCVqWYZCPdMF1LXiJoGpY4q1YTFcHszxlpe8Gfzt/Yw5RB4
         U0xkJDBIa+g+pojEWdmpPzynH0dH7vOWS7d6cTwU/ST4FSHUXF7foPGlNctkGzY0SwuK
         bADI8kciqx59+3RhlogE6Z/SBv1abSfbXgY/hJjGs3Ft6NvfRMRHWAj+uFAoGo/jMAe4
         RjuK8XOvh/rGzEyKfiu/b7JsZAS++VWlcCyPEUF94x4TrpeeHa0rXG2rl004LUsTqeug
         7gXtTs5KoqjD0uEgT1nG7qwAAqDkQ5WZ5H3zCn72UUXlyrgRt9il258996idbs+Qny1u
         BLbA==
X-Gm-Message-State: AOJu0Yxk1OPtZhcAisJHLkujQ01UYp/5ION3JNQUKzMlG1lejOuyawOn
        zA4yWMmjZkXrlqKGZ55+czwIeWjffOldJrOLHsdVhIUx
X-Google-Smtp-Source: AGHT+IENOqGUqaQaj1nhrHxNW9T1hDkMkxyFP+P8gOFcOcu333zAK+vbj2iixbQFBtUTypEPGkWVpw==
X-Received: by 2002:a17:906:1db:b0:993:f90b:e549 with SMTP id 27-20020a17090601db00b00993f90be549mr12242382ejj.37.1692133870265;
        Tue, 15 Aug 2023 14:11:10 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906455300b00992eabc0ad8sm3294619ejq.42.2023.08.15.14.11.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 14:11:09 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so1238a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:11:09 -0700 (PDT)
X-Received: by 2002:a50:d754:0:b0:525:573c:6444 with SMTP id
 i20-20020a50d754000000b00525573c6444mr12779edj.1.1692133869378; Tue, 15 Aug
 2023 14:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid> <0cc71595-ba11-11d4-1fcd-865721ede3f9@linaro.org>
In-Reply-To: <0cc71595-ba11-11d4-1fcd-865721ede3f9@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Aug 2023 14:10:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UfKXBQ6R0+5yY6WaNFS49=jmg2NTXrUPcyD3MBZA7A5A@mail.gmail.com>
Message-ID: <CAD=FV=UfKXBQ6R0+5yY6WaNFS49=jmg2NTXrUPcyD3MBZA7A5A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7180: Add board id for lazor/limozeen
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 6, 2023 at 11:34=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/08/2023 11:58, Sheng-Liang Pan wrote:
> > add BRD_ID(0, Z, 0) =3D 10 for new board with ALC5682i-VS
> >
> > Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.goo=
gle.com>
> > ---
> >
> > Changes in v2:
> > - correct newly create dts files
> >
>
>
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts b/ar=
ch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
> > new file mode 100644
> > index 000000000000..5a58e94c228e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Google Lazor board device tree source
> > + *
> > + * Copyright 2023 Google LLC.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sc7180-trogdor.dtsi"
> > +#include "sc7180-trogdor-parade-ps8640.dtsi"
> > +#include "sc7180-trogdor-lazor.dtsi"
> > +#include "sc7180-lite.dtsi"
> > +
> > +/ {
> > +     model =3D "Google Lazor (rev10+)";
> > +     compatible =3D "google,lazor", "qcom,sc7180";
> > +};
> > +
> > +&alc5682 {
> > +     compatible =3D "realtek,rt5682s";
> > +     /delete-property/ VBAT-supply;
>
> No, don't delete properties. First of all, why you do not have this
> supply here? I doubt it... Especially that this DTS has vbat-supply
> regulator!
>
> Second, define the properties where applicable instead.

It looks like v3 is out, but responding here since it looks like
Sheng-Liang didn't make any changes in v3 but also didn't respond and
explain why he didn't make any changes. Sheng-Liang: for future
reference you should make sure to address comments folks have on the
list. If your new version takes their feedback into account then
there's no reason to just respond with "Done", but if (like in this
case) you ignored feedback you need to say why.

In this case the extra "/delete-property/" is needed to pass bindings
checks. Specifically this revision of the board replaces the "rt5682i"
with the newer "rt5682s". This new codec is _almost_ a drop-in
replacement for the old codec with just a few tiny changes. One such
change is that the new codec doesn't need a "VBAT-supply".

Since most trogdor devices have the older "rt5682i" codec, the default
in "sc7180-trogdor.dtsi" specifies the properties for that codec. Only
the handful of boards that have been spun to use the new codec have an
override like this. You can see that the override done here matches
the one done in a few other trogdor boards. A good grep is:

git grep -A4 realtek,rt5682s -- arch/arm64/boot/dts/qcom/sc7180-*

Ironically, that grep finds that "sc7180-trogdor-pazquel360.dtsi" is
missing the "/delete-property/" which I'm fairly certain means that
it's giving a validation warning today.

I'm happy to have a bikeshed discussion about doing this better. In a
previous reply [1] I suggested that it's probably time to move the
"realtek,rt5682s" snippet to something like
"sc7180-trogdor-rt5682s-sku.dtsi". Then we could include it in the
devices and avoid duplicating this bit of dts. I didn't insist on it,
but if you feel strongly then maybe Sheng-Liang could add that to his
series? Once done, we could have further bikeshed discussions about
whether we should continue to use the "/delete-property/" solution or
if we have to also create a "sc7180-trogdor-rt5682i-sku.dtsi" and
force all older SKUs to include that. Personally I don't hate this
"/delete-property/" but I don't care a whole lot either way.

[1] https://lore.kernel.org/r/CAD=3DFV=3DXRq8ymnPrMPCa=3Dc7PkSH+Kj9aG29_hCj=
CNSL3fY-qaGg@mail.gmail.com


-Doug
