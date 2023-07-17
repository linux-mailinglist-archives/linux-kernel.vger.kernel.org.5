Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A18756DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGQUJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:09:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11DF133
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:09:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so45728115e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689624593; x=1692216593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=23dRsu8FFXKzlR7wpidba41k+oFieJdfmWOjiAaYDnw=;
        b=Hm1a9ZNqEybhEbdbYVSWOnLddeGSSYalfJhbMYYH2HW6pML3qI5/Z6qRhRRviVKiIs
         0Y43gN87iC2muHypgZvLaYmenOeLK9WGpTRq3gq0rsQYOO4DnR1oewY7oB9bK+8Qu2CD
         8pS6vsxyxAGka8ifKfm9bz5fvShH/BEX0x2Jth4TqUuBlqZR32dLqInaELalW1yAn1BA
         +eXr/O023PxrC6ZIj1y7vpoTCK2CmcL9bbSpFGxvHWam9MgjbaUjTiztUDQV3Bk7Xr1p
         Ghg6BynZX1EzJJ+xVgnmq5xZsXMwlXBs4vhgR6OLkzbYkKKquYyvkilwN6B151TTLnb9
         fFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624593; x=1692216593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23dRsu8FFXKzlR7wpidba41k+oFieJdfmWOjiAaYDnw=;
        b=FBN/qeNyI4VJqYb1NuoWW3Lfvuxd3yulT/mombU4K5N4XayS0tXNyJd573KFYsUaSf
         Gco5TJEuwC3ro5ZNjbXzH2MY14ZeKgelEO9fV5dpT1LBOk9GTwkyECOMDl84fXh3kTTt
         cdwB9aR99fxoEytM3yN3pRN/BkVuXLg01nfzT2eJMxPNth2Ea/lZp1iJgfQnp6TLr8qh
         O5GsVgQJTEUGms5djIusPCqCJBFeei+j5NULrPXuyWObJV0GIbAfqDhdSItBBJstekFe
         +82KEcqCIxciMjUaRBSd5RYhzGAagOp85KPm3V/T505HnkefKhtw8cF0meFe4KI7kjqN
         GxYw==
X-Gm-Message-State: ABy/qLZ/nP+O9yjDXaQ3fL9CJwmXEsMLlB+lxtl4qodE0PTM+DR55yCl
        nekMxKgO6O9KEWv1wIWOW+5iOiBBojWzbzvuPHENhfO8isOFEq6o4dY=
X-Google-Smtp-Source: APBJJlEa9PfjirXt6bc7HlMULQG1woEKCO5ni/IRSegVAYsLM1HvtKDtOWzdVotBBR6kNmVYkQzrdhaPYNxMRApwCSQ=
X-Received: by 2002:adf:d84e:0:b0:313:f6bb:ec2b with SMTP id
 k14-20020adfd84e000000b00313f6bbec2bmr9945414wrl.47.1689624593023; Mon, 17
 Jul 2023 13:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
 <20230717103236.1246771-4-bhupesh.sharma@linaro.org> <ZLUbyocjNT2bGvVt@gerhold.net>
 <CAH=2NtzM=jaVtjeHHO0rY0_wHu9==Jpdz4zx5nCK3gBh2kpL=A@mail.gmail.com> <ZLWHwnjjMkJx_ACH@gerhold.net>
In-Reply-To: <ZLWHwnjjMkJx_ACH@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 18 Jul 2023 01:39:41 +0530
Message-ID: <CAH=2NtxHekJVvzaD5SNhZZmAHXhc=7v4Pr7RMEFNTXXH6x_AgQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 at 23:58, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Mon, Jul 17, 2023 at 11:33:40PM +0530, Bhupesh Sharma wrote:
> > On Mon, 17 Jul 2023 at 16:15, Stephan Gerhold <stephan@gerhold.net> wrote:
> > >
> > > On Mon, Jul 17, 2023 at 04:02:35PM +0530, Bhupesh Sharma wrote:
> > > > Add the Embedded USB Debugger(EUD) device tree node for
> > > > SM6115 / SM4250 SoC.
> > > >
> > > > The node contains EUD base register region, EUD mode manager
> > > > register region and TCSR Base register region along with the
> > > > interrupt entry.
> > > >
> > > > [...]
> > > >
> > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 50 ++++++++++++++++++++++++++++
> > > >  1 file changed, 50 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > > index 839c603512403..db45337c1082c 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > > > [...]
> > > > @@ -789,6 +801,37 @@ gcc: clock-controller@1400000 {
> > > >                       #power-domain-cells = <1>;
> > > >               };
> > > >
> > > > +             eud: eud@1610000 {
> > > > +                     compatible = "qcom,sm6115-eud", "qcom,eud";
> > > > +                     reg = <0x0 0x01610000 0x0 0x2000>,
> > > > +                           <0x0 0x01612000 0x0 0x1000>,
> > > > +                           <0x0 0x003c0000 0x0 0x40000>;
> > > > +                     reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
> > >
> > > TCSR is a separate hardware block unrelated to the EUD. IMHO it
> > > shouldn't be listed as "reg" here.
> > >
> > > Typically we describe it as syscon and then reference it from other
> > > nodes. See e.g. sm8450.dtsi "tcsr: syscon@1fc0000" referenced in &scm
> > > "qcom,dload-mode = <&tcsr 0x13000>". This is pretty much exactly the
> > > same use case as you have. It also uses this to write something with
> > > qcom_scm_io_writel() at the end.
> >
> > That was discussed a bit during v1 patchset review. Basically, if we
> > use a tcsr syscon approach here, we will need to define a 'qcom,xx'
> > vendor specific dt-property and use something like this in the eud
> > node:
> >
> > qcom,eud-sec-reg = <&tcsr_reg yyyy>
> >
> > which would be then used by the eud driver (via
> > syscon_regmap_lookup_by_phandle()).
> >
> > But for sm6115 / qcm2290 this would be an over complicated solution as
> > normally the eud driver (say sc7280) doesn't need tcsr based secure
> > mode manager access. So defining a new soc / vendor specific
> > dt-property might be an overkill.
> >
>
> IMO a vendor-specific DT property is still better than messing up the
> device separation in the device tree. The same "tcsr-base" reg would
> also appear on the actual tcsr syscon device tree node. Having two
> device tree nodes with the same reg region is generally not valid.
>
> Something like qcom,eud-sec-reg = <&tcsr_reg yyyy> would at least make
> clear that this points into a region that is shared between multiple
> different devices, while adding it as reg suggests that TCSR belongs
> exclusively to EUD.

I understand your point but since for sm6115 / qcm2290 devices TCSR is
not used for any other purpose than EUD, I still think introducing a
new soc / vendor specific dt-property might be an overkill for this
changeset.

Thanks,
Bhupesh
