Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437E678EC17
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbjHaLd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbjHaLdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:33:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB0CF9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:33:52 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58caaedb20bso8826327b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693481631; x=1694086431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibzG3mVx4GFurVxbkoUFG27FCbRg5ZUj4tD8lzqeKtg=;
        b=C4xhoFvG4nLN7VivM88cB7ikaRDgW++/+abHV4+cUxfpoloOBfF1B+T89Cn28V3Q3I
         4t7EYiuW8hwfNZDv3AWIkk+/uxv9ezg3dc8s0dXl0ZUbp7zp0iknhnrhJcPfrZmwQ1Lp
         RBikaZAUGrUuDWy6ZdcFjLKkbRdcGHPAl45Kmdr4SJyjKuphggz7zS/0hyy8u4BIxAH6
         lXCpz7uqrY8D1uT3BeyeP/U28UIWqaODMbccSz1c76Y/EyxqLKAbspt7Y7a+X5xpcXsU
         pxi2ky5piudDNwclyg3JNU5VQVxQv7vzas+BjamDc/VByzds9mKI+xs28isIU0RzoZsZ
         Jk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693481631; x=1694086431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibzG3mVx4GFurVxbkoUFG27FCbRg5ZUj4tD8lzqeKtg=;
        b=Yen+Em2fYyYlxkHIZoROMYaz+3sezNQ9PTUdTA+bAarwG4AcPdGLAEDc3a+WIW7vyN
         RGLWYxaGt6kzesTb6/vzC6P6qo9rURx8eQIigsyTIyql/0AwqzAhvKGJDszkhFKIJyC1
         iQwsHBj3YAz8/fQXhaQqHt+UkHwTGexzEpo2Bw5QVS23RYAQ+TMSOaUPfDhgdU5y1AgA
         I8/iuWg6ghgUqa82GnauWNc9Ri4UrjaxxA4+5OHsE+UcjSasmvw5XtbdmtZQ0A3gXAAu
         sAsDCAQqGf6/UgOa+gzGMG+YIp8QEUpypvB185KVQAChxhlxs3I7sFOOaGLxj8/1YI+U
         zMCQ==
X-Gm-Message-State: AOJu0YwwuU3dm0jck2QgEEywNuEeAqhordMWETV73RC4Qq+R5TOUuIma
        I7tVfNw2IcK9l2xj/C1/rTfQxiPLtc9ym2+mRh9QYQ==
X-Google-Smtp-Source: AGHT+IHeKlJ2Cnt3SKF3aIUgqGGMgbJPVvaV8pDIkWX0azrFs3oQc15jhGlTDqlAxq2mojbE2e8cDhdUFN1nTd6fj8U=
X-Received: by 2002:a25:b116:0:b0:d78:538:8017 with SMTP id
 g22-20020a25b116000000b00d7805388017mr4779117ybj.61.1693481631542; Thu, 31
 Aug 2023 04:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com> <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
 <CV6NF0466658.20DGU7QKF2UBR@otso>
In-Reply-To: <CV6NF0466658.20DGU7QKF2UBR@otso>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 14:33:39 +0300
Message-ID: <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
> > On 30/08/2023 11:58, Luca Weiss wrote:
> > > Like other Qualcomm PMICs the PM7250B can be used on different addresses
> > > on the SPMI bus. Use similar defines like the PMK8350 to make this
> > > possible.
> > >
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
> > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > > index e8540c36bd99..3514de536baa 100644
> > > --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> > > @@ -7,6 +7,15 @@
> > >  #include <dt-bindings/interrupt-controller/irq.h>
> > >  #include <dt-bindings/spmi/spmi.h>
> > >
> > > +/* This PMIC can be configured to be at different SIDs */
> > > +#ifndef PM7250B_SID
> > > +   #define PM7250B_SID 2
> > > +#endif
> >
> > Why do you send the same patch as v1, without any reference to previous
> > discussions?
> >
> > You got here feedback already.
> >
> > https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org/
>
> Hi Krzysztof,
>
> I did mention that original patch in the cover letter of this series.
> I'm definitely aware of the discussion earlier this year there but also
> tried to get an update lately if there's any update with no response.

I think the overall consensus was that my proposal is too complicated
for the DT files.

>
> If you want to block this patch, I'll have to remove pm7250b from the
> device dts, so we'll lose some functionality. Not sure what other
> approaches there could be.
>
> Regards
> Luca
>
> >
> > Best regards,
> > Krzysztof
>


-- 
With best wishes
Dmitry
