Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A2978ED25
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbjHaMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjHaMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:32:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1780CFF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:32:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99cce6f7de2so86437666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693485157; x=1694089957; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj4e69HAaMOOdlvr+WIWTnSbaYlLGaoLGvsHESxOroI=;
        b=t80J9iBsHgwc38mPwyXOf6kIGe08KqFyxVERI58fPPJoQ20bgP12GYKTPg8X2jQw0U
         yY+0fJVSLNhf1/skaoCvFWhiv80HuXbeZH7ePs1TS/aTJuB/xcaK8DPYZhJnHRd5dCbu
         JGvsWNPFeWZv/SwFM7BD3O6n+oco8yQmp3PYzEWJJf6PzSUpyqsNeDteJtEj645o3gHO
         Ld4HDDbTSyhKgze3fRNpZI+6/S1FtLa9poO5lXspbLJBcqJmje/PzslEFYaZiJlghK9/
         WLQrZ3xWM3+5WhHI8sx+au4F3Q7nMVQf/Ir097g72WjnYgnWTcTXupC3RI/dZSG4QB80
         85aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693485157; x=1694089957;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cj4e69HAaMOOdlvr+WIWTnSbaYlLGaoLGvsHESxOroI=;
        b=RKGpdtM1y3PvpvcHxyt1OK+zccsIPlaRXGcSqxR3HxwzpTzGlXFUdhqevdmVsJ9Q4s
         ujMitNV6uyDOwVLNYR2A6x6Cz9ayrMR6cCV+qbFAx0cqbb5LMd7eEj82KDWwGPuY6LNP
         dwDycH43q1ra42axCy/PflUDr2X6U8yTti9d+LiK2hxkoK0UFSZxt+WCa9cCmEqJiUzm
         xXorIxz9KydVMG1R/ESOmkslcWcYMSkxzwddlkKdn1EegbCxp+ENHY31MSc0NHh8aGeK
         ++ftN02Z3Ny0mteahud4gYs6vXZxiuRgcIJs6ARC9Nbs+wvxhrIdoh8Zqpz43mibB5O1
         KJ6w==
X-Gm-Message-State: AOJu0Yzj1oBciW3HqE3EVUHcLc4Xkpyaq9F2soonwTJ/ZyrX4jGc4snW
        wOLDKhytsBwU4/B/e543Wk4pTg==
X-Google-Smtp-Source: AGHT+IHyE5BVYp70Ll+vKcK9XwzMnRGpWsl9jIQBoASbYwV/rC/46WZgUGOARkhdfkh5OQgp6z9Qug==
X-Received: by 2002:a17:907:75f6:b0:988:9b29:5653 with SMTP id jz22-20020a17090775f600b009889b295653mr3326856ejc.77.1693485157385;
        Thu, 31 Aug 2023 05:32:37 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906594300b0099cf44adf2csm703919ejr.46.2023.08.31.05.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 05:32:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 31 Aug 2023 14:32:35 +0200
Message-Id: <CV6QDWJRJNRH.27JMF9AB7MEXO@otso>
Cc:     <cros-qcom-dts-watchers@chromium.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
 <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
 <CV6NF0466658.20DGU7QKF2UBR@otso>
 <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
 <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
In-Reply-To: <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 31, 2023 at 1:54 PM CEST, Krzysztof Kozlowski wrote:
> On 31/08/2023 13:33, Dmitry Baryshkov wrote:
> > On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com> wro=
te:
> >>
> >> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
> >>> On 30/08/2023 11:58, Luca Weiss wrote:
> >>>> Like other Qualcomm PMICs the PM7250B can be used on different addre=
sses
> >>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
> >>>> possible.
> >>>>
> >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
> >>>>  1 file changed, 16 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot=
/dts/qcom/pm7250b.dtsi
> >>>> index e8540c36bd99..3514de536baa 100644
> >>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> >>>> @@ -7,6 +7,15 @@
> >>>>  #include <dt-bindings/interrupt-controller/irq.h>
> >>>>  #include <dt-bindings/spmi/spmi.h>
> >>>>
> >>>> +/* This PMIC can be configured to be at different SIDs */
> >>>> +#ifndef PM7250B_SID
> >>>> +   #define PM7250B_SID 2
> >>>> +#endif
> >>>
> >>> Why do you send the same patch as v1, without any reference to previo=
us
> >>> discussions?
> >>>
> >>> You got here feedback already.
> >>>
> >>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313=
d9fe9@linaro.org/
> >>
> >> Hi Krzysztof,
> >>
> >> I did mention that original patch in the cover letter of this series.
> >> I'm definitely aware of the discussion earlier this year there but als=
o
> >> tried to get an update lately if there's any update with no response.
> >=20
> > I think the overall consensus was that my proposal is too complicated
> > for the DT files.
>
> I proposed to duplicate the entries.

If you mean creating a pm7250b-8.dtsi with pm7250b copy-pasted but the
SID changed from 2 & 3 to 8 & 9, I can do that if that's the way
forward.

If this was done, I'd also say then that pm7250b.dtsi should be renamed
to e.g. pm7250b-2.dtsi since it's currently sitting on SID 2 & 3.

> Do you keep QUP nodes in DTSI and customize per address? No.
>
> I definitely do not agree to these ifndef->define. Maybe using just
> define would work (so drop ifndef->define), because this makes it
> obvious and fail-safe if included in wrong place... except that it is
> still not the define we expect. This is not the coding style present in
> other DTSes.

I really don't mind either way, I'd just like to have some way for now.

>
> The true problem how these SPMI bindings were created. Requiring SID
> address in every child is clearly redundant and I think we do not follow
> such approach anywhere else.

Is this something that could be fixed long term? Especially since
Qualcomm is reconfiguring PMICs on different addresses nowadays maybe
there's more or a push to do this?

Regards
Luca

>
> Best regards,
> Krzysztof

