Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA778ED0D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346022AbjHaM1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbjHaM1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:27:47 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDA41A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:27:43 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d73c595b558so542775276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693484862; x=1694089662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+euXE6DJl0h9x0YnFOgiELlDo48jOrMwbdikCRJ89TQ=;
        b=Auhdeh+7vNBWdS24IBIixZblq2QXnziTT7UGO/pVNc/2efCo4QgX639kbvLAs2c7gq
         f//JH/gEVgPt9a324HKyauA0HRluGppHBPuwXX9WNMTD0STwDYBqBbjwvV+rI8P2KLIH
         YrI4JQZGyLwyfKEK2tkoW6+o9BO723Tpb6L7e28v6QbffYltJj1jwIVYEcAOBDHSbWK/
         Vg0Ls6/nMUqZOR7AL17C9jTNP+ubPVLN2G5afY23SyyPE4qSUPmGy32nYXpAsUkzBK/S
         ClA6JWI9k3rPJTVJBOEt+uugCjv+wcCEW46xvFDhP2iWE4UnE/rKTX3kQurt70OW7c3b
         LEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693484862; x=1694089662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+euXE6DJl0h9x0YnFOgiELlDo48jOrMwbdikCRJ89TQ=;
        b=h7Mf8BczcuXvrZsDC76hLxbHfKpax4m2Z1u8MPR0RKZuoYgZDVNgqe270/bqNAbnNa
         CY/MFMBxt2CiFPXHf5ZEqky7rso49PJ5Y5RBjZbALx5sWTEm40cfVo0zo+ByWAVRU4um
         PgOebO9M16lOjQzlncWREQdJZT5Z+seh9MksXr+oyMYmAGIPk1RYEF5qLjpC0w42TIcK
         1bjfGnk/l+Z2fZweHhNyOPn//+s3VIGKU3v5uYVaOLh493nidLryuIKM1wAJASyeDWKG
         pnv9kKKGpr2eaEd/FK3FZ27ITrQ/YqQsxrY+EmjoFhOs+gC6T5irKmwpq0s1VkVYMQN2
         rY5A==
X-Gm-Message-State: AOJu0Yz9u0oQ11AjQrtdzw7YPfdx2HmgHs0fjSCQ5a+WDK9earXAeZ2C
        7PXFY9fzNW09DW1jWyhvhIO5YBIBCi3vtHWEcysmXw==
X-Google-Smtp-Source: AGHT+IFN/QPkD2DDoLhunzmKqMmQHmEKpyhIngn/fH7LLN0iTKE6YtivqDw4n3VbuF85fjove4wN7PQ7fW1hf85rbDI=
X-Received: by 2002:a25:b291:0:b0:d7b:957e:e476 with SMTP id
 k17-20020a25b291000000b00d7b957ee476mr4588754ybj.45.1693484862378; Thu, 31
 Aug 2023 05:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-4-5a954519bbad@fairphone.com> <b82f4683-e8b5-b424-8f7a-6d2ba1cab61f@linaro.org>
 <CV6NF0466658.20DGU7QKF2UBR@otso> <CAA8EJpr1+W3f08X-FpiiVrJ98kg52HaMwbbKn=fG15Whm4C8aQ@mail.gmail.com>
 <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
In-Reply-To: <728003b9-db27-fdc0-e761-197a02a38c24@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 31 Aug 2023 15:27:31 +0300
Message-ID: <CAA8EJpoXreHpxZQ2G10n0OiQzUX4ffk=gvo87dAU4-r+Svqpeg@mail.gmail.com>
Subject: Re: [PATCH 04/11] arm64: dts: qcom: pm7250b: make SID configurable
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 14:54, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 31/08/2023 13:33, Dmitry Baryshkov wrote:
> > On Thu, 31 Aug 2023 at 13:13, Luca Weiss <luca.weiss@fairphone.com> wrote:
> >>
> >> On Wed Aug 30, 2023 at 12:06 PM CEST, Krzysztof Kozlowski wrote:
> >>> On 30/08/2023 11:58, Luca Weiss wrote:
> >>>> Like other Qualcomm PMICs the PM7250B can be used on different addresses
> >>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
> >>>> possible.
> >>>>
> >>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
> >>>>  1 file changed, 16 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
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
> >>> Why do you send the same patch as v1, without any reference to previous
> >>> discussions?
> >>>
> >>> You got here feedback already.
> >>>
> >>> https://lore.kernel.org/linux-arm-msm/f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org/
> >>
> >> Hi Krzysztof,
> >>
> >> I did mention that original patch in the cover letter of this series.
> >> I'm definitely aware of the discussion earlier this year there but also
> >> tried to get an update lately if there's any update with no response.
> >
> > I think the overall consensus was that my proposal is too complicated
> > for the DT files.
>
> I proposed to duplicate the entries. Do you keep QUP nodes in DTSI and
> customize per address? No.

At the same time, we do keep SoC files separate from the board files.
Yes, I'm slightly exaggerating here.

I think that for PMIC files it makes sense to extract common parts if
that eases reuse of the common parts.

>
> I definitely do not agree to these ifndef->define. Maybe using just
> define would work (so drop ifndef->define), because this makes it
> obvious and fail-safe if included in wrong place... except that it is
> still not the define we expect. This is not the coding style present in
> other DTSes.
>
> The true problem how these SPMI bindings were created. Requiring SID
> address in every child is clearly redundant and I think we do not follow
> such approach anywhere else.
>
> Best regards,
> Krzysztof
>


-- 
With best wishes
Dmitry
