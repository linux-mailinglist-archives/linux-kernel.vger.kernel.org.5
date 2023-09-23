Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617717AC4E0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIWTjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIWTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:39:54 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201F3AB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:39:48 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59c0b9ad491so47061557b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695497987; x=1696102787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZUI5JRy5ooMMlYQuNNW1FylY6iB/MUj4ec8wnbLqgc=;
        b=b1/LSUMyEY/Zr2kkjzg4mEnFJtB4escH/mNZaZBI8/87reiqjM0Bry8z3QZ+UqZHIp
         HPinAG6izSN8TBi7rd3Iu7RKD7Uaw7bbccrT5uZ3ywaEMEqtnZo9M2dlPlacqI3oXrgH
         INmlxeOxC8n49rsKxHXeycXUrcjCBWlPlOUnbRutcng354HdsBhpmS3Odzil0D9RnlEf
         JPBWhRJo9rPPEov+XtsTrIO/djT6jmpWxOqQZsy8eY41ITp9TfEMZ1I+hcKzTtB9dYab
         sWyq13F+MLnXY5hNB4ypUBtroi3rDH45bvM/Q+7lOqytm5Ecq/YH9b1ogSVmLoUSX565
         m9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695497987; x=1696102787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZUI5JRy5ooMMlYQuNNW1FylY6iB/MUj4ec8wnbLqgc=;
        b=XZhvynIdliwIGr8EVN7Rt6MCGi7MAzu2Q5LhIYkNDzE+OB25YjJ/iIQGoBJnQrO3GB
         Zrh2Ia440SnT0tbOTs8B0a0ax/s5ofJJsPMOsQ9ZmEBxz3LFneu322RHKm8BSQu4VLWP
         D++E+10dO2saUWbfoPh/888DUrOKgmaN1I40Ki+QZiBC4vvN35vXgjzvPYAgzN3CxDXe
         Dr2lITWO4gTK1aKrjLm/VVWItGcsebW9HsX5LlQSPflm6pmZVGfLOMUMe6Od79wmznLt
         3SLPZZgYwRirvWE/NKYrD6MBj6vmO1OjMbee55qkt/eMwZHZNDq86ODfKrRV1xkk2QIa
         C2cQ==
X-Gm-Message-State: AOJu0YxBF2/bZXpd52lT0YqSPOQ9Sdbc2Z8uzcr1l06wahlA+LA3aim5
        hzssoVGtAQjy8NKmi9vcKuZ35OBOuLhtjCHmbbJQQg==
X-Google-Smtp-Source: AGHT+IGg1BK5ZFMzfCZb7J/hcYQOX73acsJZNxfmoVNRoSzLFDaNDaN+U/JMuhmw1BwZP3AyrXrspkWytJ289mF6o8o=
X-Received: by 2002:a81:b209:0:b0:59f:4bea:512f with SMTP id
 q9-20020a81b209000000b0059f4bea512fmr2648650ywh.15.1695497987221; Sat, 23 Sep
 2023 12:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230130-msm8974-qfprom-v2-1-3839cf41d9ee@z3ntu.xyz>
 <ff6fwomoik6kz4jtbm5jac7jahrtcia5fb6dj5ykxg7xt574sn@ti42sevqj6pk>
 <12394955.O9o76ZdvQC@z3ntu.xyz> <4831735.GXAFRqVoOG@z3ntu.xyz>
In-Reply-To: <4831735.GXAFRqVoOG@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Sep 2023 22:39:36 +0300
Message-ID: <CAA8EJpr+Csrzp4=9XOkC8HCXGJS861h73k_eHfsfyetDrrFWug@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: qcom: msm8974: correct qfprom node size
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 19:57, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> On Sonntag, 6. August 2023 12:47:51 CEST Luca Weiss wrote:
> > Hi Bjorn,
> >
> > On Montag, 31. Juli 2023 23:45:21 CEST Bjorn Andersson wrote:
> > > On Thu, Jun 15, 2023 at 08:20:41PM +0200, Konrad Dybcio wrote:
> > > > On 15.06.2023 20:17, Luca Weiss wrote:
> > > > > From: Craig Tatlor <ctatlor97@gmail.com>
> > > > >
> > > > > The qfprom actually has size 0x3000, so adjust the reg.
> > > > >
> > > > > Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
> > > > > (-0x4000). The current reg points to the ECC-corrected qfprom block
> > > > > which should have equivalent values at all offsets compared to the
> > > > > non-corrected version.
> > > > >
> > > > > [luca@z3ntu.xyz: extract to standalone patch and adjust for review
> > > > > comments]
> > > > >
> > > > > Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and
> > > > > qfprom nodes") Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > > ---
> > > >
> > > > Not sure of the actual size of the region, maybe Bjorn can help..
> > > >
> > > > Downstream 3.10 suggests 0x60F0, 0x20F0 after adjusting for the ECC
> > > > offset
> > >
> > > There is indeed 0x3000 bytes until the next region, but afaict the
> > > corrected ECC values only cover the first 0x800 bytes thereof.
> > >
> > > Can you please let me know if this patch fixes a problem, or just
> > > makes the numbers look better?
> >
> > Initially this patch came from a different direction, to make space to use
> > the PVS bits for cpufreq. Since Konrad said in earlier revisions that I
> > should always use the +0x4000 space for the ECC-corrected variant I've
> > switched to that.
> >
> > If you think it's not useful to have the qfprom size reflect the actual
> > size, we can also drop this patch since I don't think it's actually
> > necessary for anything that I have lying around in some branches.
> >
> > I think I've just sent the current patch to make sure the hardware
> > description (dts) is as accurate as possible, but of course since any info
> > on Qualcomm is very restricted it could also be a bit wrong.
>
> Hi Bjorn,
>
> this patch is still lying in my inbox. Do you think it's correct or incorrect
> - so should we drop it?

There are JTAG and coresight fuses at 0xfc4be024. So, I think, the
regions should be extended to 0x20f0 or 0x2100. BTW: could you please
also fix msm8974 and apq8084 in a similar way?

>
> Regards
> Luca
>
> >
> > Regards
> > Luca
> >
> > > Regards,
> > > Bjorn
> > >
> > > > Konrad
> > > >
> > > > > Changes in v2:
> > > > > - Keep base offset but expand reg from 0x1000 to 0x3000 (Konrad)
> > > > > - Link to v1:
> > > > > https://lore.kernel.org/r/20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3
> > > > > n
> > > > > tu.xyz ---
> > > > >
> > > > >  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > > > b/arch/arm/boot/dts/qcom-msm8974.dtsi index 7ed0d925a4e9..3156fe25967f
> > > > > 100644
> > > > > --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > > > +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> > > > > @@ -1194,7 +1194,7 @@ restart@fc4ab000 {
> > > > >
> > > > >                 qfprom: qfprom@fc4bc000 {
> > > > >
> > > > >                         compatible = "qcom,msm8974-qfprom",
> >
> > "qcom,qfprom";
> >
> > > > > -                       reg = <0xfc4bc000 0x1000>;
> > > > > +                       reg = <0xfc4bc000 0x3000>;
> > > > >
> > > > >                         #address-cells = <1>;
> > > > >                         #size-cells = <1>;
> > > > >
> > > > > ---
> > > > > base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> > > > > change-id: 20230130-msm8974-qfprom-619c0e8f26eb
> > > > >
> > > > > Best regards,
>
>
>
>


-- 
With best wishes
Dmitry
