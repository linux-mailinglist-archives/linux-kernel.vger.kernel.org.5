Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51577934F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbjIFFkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbjIFFkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:40:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AEDE45
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:39:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d78328bc2abso2874789276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 22:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693978797; x=1694583597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8f/NqI9eJZNZS9Jew7TyzheIQT5LOh0WtCkl6hQ35v0=;
        b=PzuRwGBHRN4Qoj0eEeRoIDiWGhRyHuK3PF5UGxF8lcEkWN6sAN9Aimh5O15JgKRa2K
         K8JVyAM8MC3pujK5k3jU330Gt5Je2+ZVdn8bDZfbp7ZWQXHhpITifI2tfkljEa/52KgO
         FbFwkTDua+mOiHIclVgzkE6jH7EZ8Q6hhWD6XTlQ3PDK6EqslxqoQeOTouuvzAPmOH9Q
         WmflKillPFyYgn9H3EeGB63XGUe80DRCm57psGiAaHcqp6GyOYjiE6FLa2TKn4fVU595
         WG5obDUI21VVfVsQ2xInjl4qyyS8FYLwG8jUcqOdoAdbEEq3Zh1ER+Vmk739AcFIZgPa
         8G8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693978797; x=1694583597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f/NqI9eJZNZS9Jew7TyzheIQT5LOh0WtCkl6hQ35v0=;
        b=kdR25b8gCnxPvWVMVSxorWNGwzYNr1RXaPUryYnR9xq0XGPyqz4YYadJ9aPLOElgWa
         U1YvomMJgyVQUUVubvipJx0B8XjKK/K4A6UP35wOJLvqubJIzFnfpKFRnmzDJ6gvuBCo
         sVvTyJ57fFG5GFBRgyl4bbj8XSlyndxpJke/EegCmLuIXtbMXe3WmatuVhoSCsZTQ5AM
         B4jcOud9YG7n3V0tPjCB9EZaaI354MIIuy8lvQVWVecgWlaFQejiEPkZ2fABs10yFLxb
         bAaXYVDWareh3weZx/qoi6xQwl8YTvV83FkGJACgoY0pew8W5vUuAdF1Yg0zwUdXI78J
         vC4w==
X-Gm-Message-State: AOJu0YxfymKxwV05t4Y/pnXTtCnI810q5NVV74As8JKXa6ojQhQboGcD
        elutVGlN5ExBzdymBS1tOQVj7QdoET3I7ShjBZl3JA==
X-Google-Smtp-Source: AGHT+IGFfsNqsW45LvllXv0f9d4ie2TdybHTJ9lNAUNOCKumpQv/0qoQbjpjhFYWqp/OLi6ld3eDH++TbixLXN4BKVI=
X-Received: by 2002:a25:d91:0:b0:d78:26a0:ab8b with SMTP id
 139-20020a250d91000000b00d7826a0ab8bmr17030568ybn.55.1693978797353; Tue, 05
 Sep 2023 22:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693909838-6682-3-git-send-email-quic_rohiagar@quicinc.com>
 <37fe0c7e-60ad-4c27-b40f-471cc3d92e1c@linaro.org> <ea9df6f3-dfde-ea7a-af22-2a0839d82d32@quicinc.com>
 <1838845b-9586-6f8c-a4d6-ef052e0a12db@quicinc.com>
In-Reply-To: <1838845b-9586-6f8c-a4d6-ef052e0a12db@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Sep 2023 08:39:45 +0300
Message-ID: <CAA8EJpqK1FzD2+c6TsicP-fjP+vKJGNWKZ2UodphkROb0WkX1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: qcom,qmp-usb: Add SDX75 USB3 PHY
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, abel.vesa@linaro.org,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sept 2023 at 08:26, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
>
> On 9/6/2023 10:52 AM, Rohit Agarwal wrote:
> >
> > On 9/6/2023 2:04 AM, Dmitry Baryshkov wrote:
> >> On 05/09/2023 13:30, Rohit Agarwal wrote:
> >>> Add dt-bindings for USB3 PHY found on Qualcomm SDX75.
> >>>
> >>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> >>> ---
> >>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 40
> >>> ++++++++++++++++++++--
> >>>   1 file changed, 37 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >>> b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >>>
> >>> index f99fbbc..5725620 100644
> >>> ---
> >>> a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >>> +++
> >>> b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> >>> @@ -20,6 +20,7 @@ properties:
> >>>         - qcom,qcm2290-qmp-usb3-phy
> >>>         - qcom,sa8775p-qmp-usb3-uni-phy
> >>>         - qcom,sc8280xp-qmp-usb3-uni-phy
> >>> +      - qcom,sdx75-qmp-usb3-uni-phy
> >>
> >> I think the ident is wrong here.
> >
> > Same. Somehow, your reply has the issue but original not able to see.
> >
> >>
> >>>         - qcom,sm6115-qmp-usb3-phy
> >>>       reg:
> >>> @@ -38,9 +39,7 @@ properties:
> >>>       maxItems: 2
> >>>       reset-names:
> >>> -    items:
> >>> -      - const: phy
> >>> -      - const: phy_phy
> >>> +    maxItems: 2
> >>>       vdda-phy-supply: true
> >>>   @@ -75,6 +74,7 @@ allOf:
> >>>             contains:
> >>>               enum:
> >>>                 - qcom,ipq9574-qmp-usb3-phy
> >>> +              - qcom,sdx75-qmp-usb3-uni-phy
> >>>       then:
> >>>         properties:
> >>>           clock-names:
> >>> @@ -122,6 +122,40 @@ allOf:
> >>>         required:
> >>>           - power-domains
> >>>   +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - qcom,ipq9574-qmp-usb3-phy
> >>> +              - qcom,qcm2290-qmp-usb3-phy
> >>> +              - qcom,sa8775p-qmp-usb3-uni-phy
> >>> +              - qcom,sc8280xp-qmp-usb3-uni-phy
> >>> +              - qcom,sm6115-qmp-usb3-phy
> >>> +    then:
> >>> +      properties:
> >>> +        resets:
> >>> +          maxItems: 2
> >>> +        reset-names:
> >>> +          items:
> >>> +            - const: phy
> >>> +            - const: phy_phy
> >>> +
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - qcom,sdx75-qmp-usb3-uni-phy
> >>> +    then:
> >>> +      properties:
> >>> +        resets:
> >>> +          maxItems: 2
> >>> +        reset-names:
> >>> +          items:
> >>> +            - const: phy
> >>> +            - const: common
> >>
> >> Could you please point us to the actual DTS patch adding this PHY?
> >> I'd say, it is highly likely that you are trying to bring in the
> >> unnecessary change.
> > I have not posted the dt patches yet. But sdx75 uses these resets.
> > GCC_USB3PHY_PHY_BCR, GCC_USB3_PHY_BCR
> >
> > These are same as sdx65 and sdx55.
> Ok I see in your patch
> https://lore.kernel.org/linux-phy/20230824211952.1397699-17-dmitry.baryshkov@linaro.org/
> you are updating the resets name. Fine, this change becomes unnecessary.
> Will rebase my change on your patches.

Well, even without my changes, GCC_USB3PHY_PHY_BCR is "phy_phy", just
judging by the name.

>
> Thanks,
> Rohit.
> >
> > Thanks,
> > Rohit.
> >
> >>
> >>> +
> >>>   additionalProperties: false
> >>>     examples:
> >>



-- 
With best wishes
Dmitry
