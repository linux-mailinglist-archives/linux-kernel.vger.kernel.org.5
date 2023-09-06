Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F887934EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbjIFFjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbjIFFjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:39:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A4CFB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:38:57 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7cbcfdf137so2811808276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 22:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693978737; x=1694583537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6Vvpw2CmW0nzmxoVXpfXOrVpezzVvzdgd6ePJqRcdY=;
        b=mFoWt88bv8Rk/ox7Xk8fqXAnLvAvponBZ0O+rMfZODMTst4dqcISKDO8wsMyBY3KoP
         NfuoYzQKzbItCzIDYJFmT0GCTdY8eFaHB0ZKwYS4wmnSZM55ErwNyu21rAmjS3XKDWZ9
         7oP3YMzJksl2Fs/ujSG4NTUZU1xyQq6DuWJg2U/KR8PjiKR+Z3KcXKtP1kYM85+GvFn0
         nrgsmdmRar0WSLQyWk6qR1vW9P8yxkxq1I9xFXUiMzZRYruwoV6lbnqbySDTpj3ciUlz
         UTVHF5E4aBJlWSA8pokhksj5ljNpLKHLZK+dYDSgAaMQVYcDfZ7EjyrunnCrIr/awbFa
         gEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693978737; x=1694583537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6Vvpw2CmW0nzmxoVXpfXOrVpezzVvzdgd6ePJqRcdY=;
        b=UgV1yBbUJXx/czCmImzK2gebldZPYAod2rdosYV++z5BAX7H1mymQIH5B9Vi3s6IOH
         vG96ByLqKp0wDXD5/jKVScSWAkMsvxK3vq8oROAQBBsvqQI99WYB5Q4XfA6ygcgzLgk+
         6OTSjy2lHYGDCUpC3a78R7kw0DpNm6jVUj8fwlDbNSWaEzaupiQGsZJO7vi+YD9k3dFF
         2etq3l40HPMRyAzbmORjzr5fh8kLIJPOPUwdJQ2o2BBMEBEm2WxxhyU3ryF3W6JqrvC4
         0SwOLHvsUP49nevVewbdBOX7amH2+rrel0Z9723QWiNvewC7gaqV9UT03vG1M/pLlL+o
         j/mg==
X-Gm-Message-State: AOJu0Ywc4oKTscQk/wWX1WbhYZyw1/IAawRomUpUG8NfxyvvycRiUt09
        79tJgPpj/tS4puQkyV1gLLti3QPyfG0PvAGDZM2+KQ==
X-Google-Smtp-Source: AGHT+IHi8pHHF8NLpzQYB9v0Pol2eOPcrhcWs3eFGmil2YW0f8FVFZZu+uGmVHEtyjepaxiS6Am92KbgZ80QwJQ18Fc=
X-Received: by 2002:a25:aaa3:0:b0:d3b:24b:561e with SMTP id
 t32-20020a25aaa3000000b00d3b024b561emr16305720ybi.42.1693978737039; Tue, 05
 Sep 2023 22:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <1693909838-6682-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693909838-6682-4-git-send-email-quic_rohiagar@quicinc.com>
 <35475122-cc40-486d-90a7-09be53588219@linaro.org> <cde5be37-26a1-3efc-17f4-d58b87a9b99d@quicinc.com>
In-Reply-To: <cde5be37-26a1-3efc-17f4-d58b87a9b99d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Sep 2023 08:38:45 +0300
Message-ID: <CAA8EJpoEWLw3qmcHtGdjX6RGOWii6ysgrP45RCCMvPQTL4oR2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: usb: qcom,dwc3: Fix SDX65 clocks
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

On Wed, 6 Sept 2023 at 08:10, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
>
> On 9/6/2023 2:05 AM, Dmitry Baryshkov wrote:
> > On 05/09/2023 13:30, Rohit Agarwal wrote:
> >> SDX65 has 5 clocks so mention in the bindings.
> >>
> >> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> >
> > Fixes tag?
> Ack.
> >
> >> ---
> >>   Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> >> b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> >> index 6759105..018117b 100644
> >> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> >> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> >> @@ -180,6 +180,7 @@ allOf:
> >>                 - qcom,sdm670-dwc3
> >>                 - qcom,sdm845-dwc3
> >>                 - qcom,sdx55-dwc3
> >> +              - qcom,sdx65-dwc3
> >
> > Is indent correct here?
> >
> I double cheked the patch and didnt find the indentation wrong. Not
> sure, in your reply it seems wrong but the original patch has correct
> indent.

Ack.

> Thanks,
> Rohit
> >>                 - qcom,sm6350-dwc3
> >>       then:
> >>         properties:
> >



-- 
With best wishes
Dmitry
