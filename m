Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971E9792B48
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbjIEQun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353889AbjIEIax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:30:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E77CDE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:30:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ff9b389677so3467106e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1693902646; x=1694507446; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWq30L/k6esO2m+8xJQ6plHCzdQIEU3cixCgpzG9F48=;
        b=PXUS5OrCIr0hfIiE/RYFGI+eTfixlts42tgW5wCnRf0opXHzFIjtsXr6JyebIdn9tg
         FBhI3Rqqee/Gl3C0da6tAxI6dCCXEQsjsVtuSr2n/p5xZGLu0vi5//ZskgqBM4Z53AdP
         UBTfWJ35XhHIySddhkdM0qcNF8soWEqoGeFPw5Iak5/0zLUjsAMolwGVNsRdWCB6lpQY
         p9RMVuACmnr0R14z8k1RuV8DV64dwrMxOQJtwxVyMP7nPkwp7feR04nkhRtKqX8gStDl
         GALyse9Jh2L6M/GNvl34rZ5PAUGvFj0cIQx4fhKE/1joHr20rZDln+eGo2ZC8Slye1rm
         1/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902646; x=1694507446;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWq30L/k6esO2m+8xJQ6plHCzdQIEU3cixCgpzG9F48=;
        b=BIZBucihSZF+Jr+MvHyQoZdlF4Y9QlocgdBoiqMV9NFVRwlJ2RN+mS1kdkEjTL04NZ
         fEGcTCuksrSC/0pmobTTfoF8OYy7mCZaw1C67uOemygilfrqlCAed+v27KGDusO2gmF1
         vSO+hOiUh72U8C5nK7vRgnKQcNmCWwOMengqQ3m9SwHMJNTSxZRMx9GRhW2Ul3LU5MzA
         2gT0rQANtn95rH8TK00BTTNgmuyUusvuBPDvauuTWbnlW0csz0REi+iRN25iUT/EDB5q
         DxLwVTf46v28fGforkJ9AfbStjtXqhrBHG2zD4z7KFmUGji0vrtCqNOvc2dUVMi3xN5o
         p7bg==
X-Gm-Message-State: AOJu0YwGeVSYJ3rojZdB0dpJvFOWw7EVJypEupdA4+TyuRxRXpqF9c0n
        PAcQyuPaBGt3TOFYMPXmVoTelw==
X-Google-Smtp-Source: AGHT+IHnW0XedN1vSaHx1JHDD4mFf80P5Zlb6gBn9z9f8KVQh7bwaME+VxnDiJKWubHNVVg3SjkedQ==
X-Received: by 2002:a05:6512:ea6:b0:4fe:e50:422d with SMTP id bi38-20020a0565120ea600b004fe0e50422dmr9421046lfb.25.1693902645843;
        Tue, 05 Sep 2023 01:30:45 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id fj22-20020a0564022b9600b005256aaa6e7asm667460edb.78.2023.09.05.01.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 01:30:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 05 Sep 2023 10:30:44 +0200
Message-Id: <CVAUDGBO4S08.1F0O66ZE6I4IG@otso>
To:     "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
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
From:   "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com>
 <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
 <CV6NF0466658.20DGU7QKF2UBR@otso>
 <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
 <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
 <CAA8EJpoXreHpxZQ2G10n0OiQzUX4ffk=gvo87dAU4-r+Svqpeg@mail.gmail.com>
In-Reply-To: <CAA8EJpoXreHpxZQ2G10n0OiQzUX4ffk=gvo87dAU4-r+Svqpeg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 31, 2023 at 2:27 PM CEST, Dmitry Baryshkov wrote:
> On Thu, 31 Aug 2023 at 14:54, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 31/08/2023 13:33, Dmitry Baryshkov wrote:
> > > On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com> w=
rote:
> > >>
> > >> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
> > >>> On 30/08/2023 11:58, Luca Weiss wrote:
> > >>>> Like other Qualcomm PMICs the PM7250B can be used on different add=
resses
> > >>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
> > >>>> possible.
> > >>>>
> > >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > >>>> ---
> > >>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++------=
-
> > >>>>  1 file changed, 16 insertions(+), 7 deletions(-)
> > >>>>
> > >>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/bo=
ot/dts/qcom/pm7250b.dtsi
> > >>>> index e8540c36bd99..3514de536baa 100644
> > >>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > >>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > >>>> @@ -7,6 +7,15 @@
> > >>>>  #include <dt-bindings/interrupt-controller/irq.h>
> > >>>>  #include <dt-bindings/spmi/spmi.h>
> > >>>>
> > >>>> +/* This PMIC can be configured to be at different SIDs */
> > >>>> +#ifndef PM7250B_SID
> > >>>> +   #define PM7250B_SID 2
> > >>>> +#endif
> > >>>
> > >>> Why do you send the same patch as v1, without any reference to prev=
ious
> > >>> discussions?
> > >>>
> > >>> You got here feedback already.
> > >>>
> > >>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f3=
13d9fe9@linaro.org/
> > >>
> > >> Hi Krzysztof,
> > >>
> > >> I did mention that original patch in the cover letter of this series=
.
> > >> I'm definitely aware of the discussion earlier this year there but a=
lso
> > >> tried to get an update lately if there's any update with no response=
.
> > >
> > > I think the overall consensus was that my proposal is too complicated
> > > for the DT files.
> >
> > I proposed to duplicate the entries. Do you keep QUP nodes in DTSI and
> > customize per address? No.
>
> At the same time, we do keep SoC files separate from the board files.
> Yes, I'm slightly exaggerating here.
>
> I think that for PMIC files it makes sense to extract common parts if
> that eases reuse of the common parts.

Hi all,

what can I do for v2 now?

1. Keep this patch as-is, and keep pm7250b in device dts.

2. Drop pm7250b patch and drop from device dts, until _someone_ figures
out a solution talking to the PMIC on different SID.

3. Something else like copy-pasting pm7250b.dtsi to pm7250-8.dtsi and
changing the SID there, and using that in device dts.

Please let me know what to do.

Regards
Luca

>
> >
> > I definitely do not agree to these ifndef->define. Maybe using just
> > define would work (so drop ifndef->define), because this makes it
> > obvious and fail-safe if included in wrong place... except that it is
> > still not the define we expect. This is not the coding style present in
> > other DTSes.
> >
> > The true problem how these SPMI bindings were created. Requiring SID
> > address in every child is clearly redundant and I think we do not follo=
w
> > such approach anywhere else.
> >
> > Best regards,
> > Krzysztof
> >

