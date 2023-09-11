Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0179B2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377389AbjIKWV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjIKIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:34:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCF51A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:34:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c136ee106so515882966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1694421254; x=1695026054; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJm1KaNRweMkGVAymSAxQbFYuR9Q/QDHdaAfSIOtOtY=;
        b=snoiVXErePqPv15Ov6YYqDsErLkyeRomEvttbFZlvfsaKz8W7DEzqzhqqOv4JPO58e
         hueYhhGy4d//Ns30AaauvV6CiM8JrDN6bbz8/7uEHD9m8zqSaSxpk93orUy4uiROjT2A
         XnDn+Du8jSzlH9TgsKmSwU0ka4kqIW5aw59TV5n7r3R7RHi5LwnIWBbCyt2gWT1g3VMW
         CzE/MaW7BbgLmmQF4oTS3INXAQZflcmS/mn67R029HtPhkcZfrh4M5QCNNrlfV+LtRL4
         eBjJlx2KAnMpzzNQnA/13u0L9gBRZ7puIXew2OogC76rmA12X/JOUCmIJkYuQgx9v3mS
         fbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421254; x=1695026054;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XJm1KaNRweMkGVAymSAxQbFYuR9Q/QDHdaAfSIOtOtY=;
        b=uzSp1P4m3lMbep6fzNREmt5RUhOnSdxtOwFWZXKvvZShua7wUSjxu2hA6hovSjvDXb
         gp7r951DFrdLmutWNbGFqUCreYLbSTdKjgIMlQNDcNZMimiAuBoSTMTqUJ3o36YJrkiA
         dERG3DJXsnD4Y6tARLAPo87baIYKskdNkELPu7YwEqgzooeHaxzehGbjTOWR0aPIQD1B
         dDphYLfvtvA7hVeSmVKv8wKi2Eay6BSHOjO0FqKE3u+b1Pht7yy/2PomPE+rkS4u3nj+
         vyy2glkF5a/tDPP/oEtsOLt3uWUG8hJ27nbTSnmErriP1s6tYthdW4YyxjcRA9dO+ArI
         1QvA==
X-Gm-Message-State: AOJu0YxOQrupSoxPLG0ohC24xu89aNIX3sGEOUmBAacXeS181KEf9DLE
        lNWjYXsp3qPSvX1sgNwi/f8DNfnkKWmdmTHa2dTYGA==
X-Google-Smtp-Source: AGHT+IFj11zWwg4l2ZYoi5wwOlV3+q/kHSKszsCHlHHWLxUQKUTp28BwxRBudKWY2XQcGgljf2DGcg==
X-Received: by 2002:a17:906:5a49:b0:9a2:24f9:fabe with SMTP id my9-20020a1709065a4900b009a224f9fabemr7402648ejc.66.1694421253741;
        Mon, 11 Sep 2023 01:34:13 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709064a1400b00991faf3810esm5046605eju.146.2023.09.11.01.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:34:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 11 Sep 2023 10:34:12 +0200
Message-Id: <CVFY7D7ND3WS.2B2EYB4ZO86P@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Luca Weiss" <luca.weiss@fairphone.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
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
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
 <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
 <CV6NF0466658.20DGU7QKF2UBR@otso>
 <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
 <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
 <CAA8EJpoXreHpxZQ2G10n0OiQzUX4ffk=gvo87dAU4-r+Svqpeg@mail.gmail.com>
 <CVAUDGBO4S08.1F0O66ZE6I4IG@otso>
In-Reply-To: <CVAUDGBO4S08.1F0O66ZE6I4IG@otso>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 5, 2023 at 10:30 AM CEST, Luca Weiss wrote:
> On Thu Aug 31, 2023 at 2:27 PM CEST, Dmitry Baryshkov wrote:
> > On Thu, 31 Aug 2023 at 14:54, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 31/08/2023 13:33, Dmitry Baryshkov wrote:
> > > > On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com>=
 wrote:
> > > >>
> > > >> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
> > > >>> On 30/08/2023 11:58, Luca Weiss wrote:
> > > >>>> Like other Qualcomm PMICs the PM7250B can be used on different a=
ddresses
> > > >>>> on the SPMI bus. Use similar defines like the PMK8350 to make th=
is
> > > >>>> possible.
> > > >>>>
> > > >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > >>>> ---
> > > >>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++----=
---
> > > >>>>  1 file changed, 16 insertions(+), 7 deletions(-)
> > > >>>>
> > > >>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/=
boot/dts/qcom/pm7250b.dtsi
> > > >>>> index e8540c36bd99..3514de536baa 100644
> > > >>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > > >>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > > >>>> @@ -7,6 +7,15 @@
> > > >>>>  #include <dt-bindings/interrupt-controller/irq.h>
> > > >>>>  #include <dt-bindings/spmi/spmi.h>
> > > >>>>
> > > >>>> +/* This PMIC can be configured to be at different SIDs */
> > > >>>> +#ifndef PM7250B_SID
> > > >>>> +   #define PM7250B_SID 2
> > > >>>> +#endif
> > > >>>
> > > >>> Why do you send the same patch as v1, without any reference to pr=
evious
> > > >>> discussions?
> > > >>>
> > > >>> You got here feedback already.
> > > >>>
> > > >>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3=
f313d9fe9@linaro.org/
> > > >>
> > > >> Hi Krzysztof,
> > > >>
> > > >> I did mention that original patch in the cover letter of this seri=
es.
> > > >> I'm definitely aware of the discussion earlier this year there but=
 also
> > > >> tried to get an update lately if there's any update with no respon=
se.
> > > >
> > > > I think the overall consensus was that my proposal is too complicat=
ed
> > > > for the DT files.
> > >
> > > I proposed to duplicate the entries. Do you keep QUP nodes in DTSI an=
d
> > > customize per address? No.
> >
> > At the same time, we do keep SoC files separate from the board files.
> > Yes, I'm slightly exaggerating here.
> >
> > I think that for PMIC files it makes sense to extract common parts if
> > that eases reuse of the common parts.
>
> Hi all,
>
> what can I do for v2 now?
>
> 1. Keep this patch as-is, and keep pm7250b in device dts.
>
> 2. Drop pm7250b patch and drop from device dts, until _someone_ figures
> out a solution talking to the PMIC on different SID.
>
> 3. Something else like copy-pasting pm7250b.dtsi to pm7250-8.dtsi and
> changing the SID there, and using that in device dts.
>
> Please let me know what to do.
>
> Regards
> Luca

Hi,

if there's no feedback I'll keep this patch in v2 of this series and we
can continue to discuss there (if necessary).

Regards
Luca

>
> >
> > >
> > > I definitely do not agree to these ifndef->define. Maybe using just
> > > define would work (so drop ifndef->define), because this makes it
> > > obvious and fail-safe if included in wrong place... except that it is
> > > still not the define we expect. This is not the coding style present =
in
> > > other DTSes.
> > >
> > > The true problem how these SPMI bindings were created. Requiring SID
> > > address in every child is clearly redundant and I think we do not fol=
low
> > > such approach anywhere else.
> > >
> > > Best regards,
> > > Krzysztof
> > >

