Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF82477E8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbjHPScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345558AbjHPSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:31:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4C1986
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:31:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so106758061fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692210710; x=1692815510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx+mSV9nVDCSUCZ9Mp20Kvrcl4sv9ALrPuz3+qN6T0w=;
        b=KF72xASUYluN/72dWo+aR6khFl46jSBhJ21VozdC9HBp/U7j4mfKg7Kmso6fv1RyrL
         2UZad5fbNrfwGOKnAfHtkX/hd2+nvmLX7dQAa+BWV5Cbgg64KpeOk5Hf7TPAX1pQgEjP
         3WKXN3vQrj7aSUja4t6Ql4ldSe+I6OKbb5C+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692210710; x=1692815510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lx+mSV9nVDCSUCZ9Mp20Kvrcl4sv9ALrPuz3+qN6T0w=;
        b=ISJ6QYu4HXrxlxHbwZ3JMHQ6soZvB2yeh46HGNlH65x2Db4S9yb5GsH4Szi5Tf/3Tz
         82lMPw++CPf8CgT5rSyK7rdzOBrELjeQLp4V5vginKeZ73HqzrKyFeu78oCrtWHL71UD
         6HrIztxWtSvs45/Hc9wdUldhYOhkhjeIr9y3fLQ1dkk3cLTbY3ON/jkdscXMm+vEKnmb
         ErrYUS7ymKmJihp0GUaFwaFAmdPXNonE46M2GD2xVqIPnEmCDxR25zHmzcjE6XOrzXi4
         4QpkdMbvRu9FGPy47uhaULIwvwntJ9R/MHqy4Op9DJy08HWvU4lgFaTgeH27OFO97kjP
         RetA==
X-Gm-Message-State: AOJu0YwTv1ze/9Y6KBRy3hFUPuinrEKM2x+zDjd7noBRM73QtOrhoNwb
        CxiIVVcD8LOL/q2Q5oGcGIs1ynqkz8+x/bmbbDAuhpy+
X-Google-Smtp-Source: AGHT+IFbK6r2pz7XdvrM0h+SLT3UQMDoHzp1u5Lv/DXYdCMPmZ8WfV/FAnd8C+MQV6NR3IuUNLdlDw==
X-Received: by 2002:a2e:9c86:0:b0:2b4:6f0c:4760 with SMTP id x6-20020a2e9c86000000b002b46f0c4760mr2009912lji.11.1692210710203;
        Wed, 16 Aug 2023 11:31:50 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906115900b00992025654c1sm8991370eja.179.2023.08.16.11.31.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 11:31:50 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1995a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:31:49 -0700 (PDT)
X-Received: by 2002:a50:a45b:0:b0:523:bdc9:48a9 with SMTP id
 v27-20020a50a45b000000b00523bdc948a9mr18121edb.0.1692210709094; Wed, 16 Aug
 2023 11:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
 <0cc71595-ba11-11d4-1fcd-865721ede3f9@linaro.org> <CAD=FV=UfKXBQ6R0+5yY6WaNFS49=jmg2NTXrUPcyD3MBZA7A5A@mail.gmail.com>
 <eb082e10-efc2-0f5f-95e1-4d2707c87c59@linaro.org> <eb082e10-efc2-0f5f-95e1-4d2707c87c59@linaro.org/>
 <20230816095910.41305-1-sheng-liang.pan@quanta.corp-partner.google.com>
In-Reply-To: <20230816095910.41305-1-sheng-liang.pan@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Aug 2023 11:31:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VedSS62LKPHeHm8qXF_acVmjXODJS8V-EeC6eHSc9yNg@mail.gmail.com>
Message-ID: <CAD=FV=VedSS62LKPHeHm8qXF_acVmjXODJS8V-EeC6eHSc9yNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc7180: Add board id for lazor/limozeen
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
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

Hi,

On Wed, Aug 16, 2023 at 2:59=E2=80=AFAM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> > On 15/08/2023 23:10, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Sun, Aug 6, 2023 at 11:34=E2=80=AFPM Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 04/08/2023 11:58, Sheng-Liang Pan wrote:
> >>>> add BRD_ID(0, Z, 0) =3D 10 for new board with ALC5682i-VS
> >>>>
> >>>> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.=
google.com>
> >>>> ---
> >>>>
> >>>> Changes in v2:
> >>>> - correct newly create dts files
> >>>>
> >>>
> >>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts b=
/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
> >>>> new file mode 100644
> >>>> index 000000000000..5a58e94c228e
> >>>> --- /dev/null
> >>>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r10.dts
> >>>> @@ -0,0 +1,30 @@
> >>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >>>> +/*
> >>>> + * Google Lazor board device tree source
> >>>> + *
> >>>> + * Copyright 2023 Google LLC.
> >>>> + */
> >>>> +
> >>>> +/dts-v1/;
> >>>> +
> >>>> +#include "sc7180-trogdor.dtsi"
> >>>> +#include "sc7180-trogdor-parade-ps8640.dtsi"
> >>>> +#include "sc7180-trogdor-lazor.dtsi"
> >>>> +#include "sc7180-lite.dtsi"
> >>>> +
> >>>> +/ {
> >>>> +     model =3D "Google Lazor (rev10+)";
> >>>> +     compatible =3D "google,lazor", "qcom,sc7180";
> >>>> +};
> >>>> +
> >>>> +&alc5682 {
> >>>> +     compatible =3D "realtek,rt5682s";
> >>>> +     /delete-property/ VBAT-supply;
> >>>
> >>> No, don't delete properties. First of all, why you do not have this
> >>> supply here? I doubt it... Especially that this DTS has vbat-supply
> >>> regulator!
> >>>
> >>> Second, define the properties where applicable instead.
> >>
> >> It looks like v3 is out, but responding here since it looks like
> >> Sheng-Liang didn't make any changes in v3 but also didn't respond and
> >> explain why he didn't make any changes. Sheng-Liang: for future
> >> reference you should make sure to address comments folks have on the
> >> list. If your new version takes their feedback into account then
> >> there's no reason to just respond with "Done", but if (like in this
> >> case) you ignored feedback you need to say why.
> >>
> >> In this case the extra "/delete-property/" is needed to pass bindings
> >> checks. Specifically this revision of the board replaces the "rt5682i"
> >> with the newer "rt5682s". This new codec is _almost_ a drop-in
> >> replacement for the old codec with just a few tiny changes. One such
> >> change is that the new codec doesn't need a "VBAT-supply".
> >>
> >> Since most trogdor devices have the older "rt5682i" codec, the default
> >> in "sc7180-trogdor.dtsi" specifies the properties for that codec. Only
> >> the handful of boards that have been spun to use the new codec have an
> >> override like this. You can see that the override done here matches
> >> the one done in a few other trogdor boards. A good grep is:
> >>
> >> git grep -A4 realtek,rt5682s -- arch/arm64/boot/dts/qcom/sc7180-*
> >>
> >> Ironically, that grep finds that "sc7180-trogdor-pazquel360.dtsi" is
> >> missing the "/delete-property/" which I'm fairly certain means that
> >> it's giving a validation warning today.
> >>
> >> I'm happy to have a bikeshed discussion about doing this better. In a
> >> previous reply [1] I suggested that it's probably time to move the
> >> "realtek,rt5682s" snippet to something like
> >> "sc7180-trogdor-rt5682s-sku.dtsi". Then we could include it in the
> >> devices and avoid duplicating this bit of dts. I didn't insist on it,
> >> but if you feel strongly then maybe Sheng-Liang could add that to his
> >> series? Once done, we could have further bikeshed discussions about
> >> whether we should continue to use the "/delete-property/" solution or
> >> if we have to also create a "sc7180-trogdor-rt5682i-sku.dtsi" and
> >> force all older SKUs to include that. Personally I don't hate this
> >> "/delete-property/" but I don't care a whole lot either way.
> >
> > Thanks for explanation. I vote against /delete-property/ because it is
> > error-prone and a bit confusing. The same with overriding compatibles -
> > if possible, should be avoided. sc7180-trogdor-pazquel360.dtsi is doing
> > both, but that's not the pattern I find easy to read.

OK, I tried it. I'm on the fence but don't object to it landing [1]


> > I accept overriding supplies or pins, because these differ per board.
> > But if common DTSI defines compatible, then it is common for everyone o=
r
> > it is not really part of common DTSI.
> >
> > IOW, the common DTSI should be more like a SoC DTSI - have only parts
> > present there. I simplify here, because obviously SoC is a real thing
> > piece of hardware and common board DTSI is not. It's just an
> > abstraction... but anyway if different boards use different codecs, the=
n
> > I would say it is not part of common platform.
> >
> > Best regards,
> > Krzysztof
> >
> >
> Thank Doug's explain, as Doug says, we need "/delete-property/" to pass b=
inding checks.
> I read from https://lore.kernel.org/all/20221102182002.255282-9-nfraprado=
@collabora.com/ which removed VBAT-supply;
>
> I'd like to know what I can do for our project. Please advise.

I've posted a series which I think will help [2] [1]. Assuming those
look good, your action items would be:

1. If they look good, you could provide "Reviewed-by" and/or
"Tested-by" tags on my patches.

2. You can send a new version of your patches based atop mine. You'd
want to note in the cover letter and/or "after the cut" in the patch
that your patches depend on mine.

NOTE: there's no reason that the cleanup patches needed to be posted
by me. As you get more familiar with upstream kernel development, you
should be able to write similar patches yourself and include them in
your series. It's perfectly OK to "cleanup" other boards as part of
your series.


[1] https://lore.kernel.org/r/20230816112143.2.I29a5a330b6994afca81871f74bb=
acaf55b155937@changeid
[2] https://lore.kernel.org/r/20230816112143.1.I7227efd47e0dc42b6ff243bd22a=
a1a3e01923220@changeid
