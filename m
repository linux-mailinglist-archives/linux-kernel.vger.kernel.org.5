Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75677F7453
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbjKXMx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXMxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:53:25 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF527193
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:53:30 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1447320276.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700830410; x=1701435210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTgTZleeDU2G7HfMpR6mP5ubFLWz0FBut+wr32KncSQ=;
        b=Qczjxkkdia9Ftmim+3rrN2TIIDT03r11LNoeL3wQcU1ia0qewKiGCAltehJ9bl8skO
         S2/Lq9dHhXiRzqIQw/c1o7ZW2H/y1IYRWlnBTuP9KkD0qL3YQ6OhzoLI3apUsvdJPPYk
         hOebeBCrQ3P+SLuTB7sRCd5nTsB6PtA/l0OMYgewTm12mDO/x9gfJwbYvCM1Q4UAvTxz
         33qZcZG2G7qFzxaOLTnn8QIeGu4+JPQqH/sDjbGt+FVav/v652myvyuOy+QnPgO9msVl
         e2uTvHW8PCbGOr3gpj0YU7S722NCQZdpL34NGgFlVM55DUkPPDyUgtx8F+eEU/8LV8Bw
         jBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830410; x=1701435210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTgTZleeDU2G7HfMpR6mP5ubFLWz0FBut+wr32KncSQ=;
        b=xGlL+GEUg0d/24WqPMue+kSugVu3/fPkUxJA9BMHw6/nJWxbc+ZdsfBEHqzEaeu+HR
         Vca1PijEK9b+4XiWJx/tzEHjNY4QKI0ESO/RNnmsLSwKs2X4/JdPX/5WLlHoqNR8IdM+
         QnV2QsqvH+oBB/th6QDkR8Ko6fJ46FS+c7lXXVxJSSIk4+cNmqxOrpFETzvQfhKWBA8Y
         OtZpX5BAIyV75drh06xLC2f5G45fFiD+3jeg+B0umo6fSnI31n2gZs4GMkK6cazvze87
         6Qckv2eq0bcRcsAIro5MRQQ/FSDBKu9/iDeoyRUfRM2cLeXOx+MbFoqZzW/NLCkan/Vz
         T2uw==
X-Gm-Message-State: AOJu0YyVBgptQHnLrMgJ+gS9W/vDodkaMjqurNN1BrF4F6MK7v+mAEj9
        PGJeG+Z1MEflBiLJAk9U+v0VQUhguivHbeUQti7zqg==
X-Google-Smtp-Source: AGHT+IHJGOTFidjATlrN1/BR2tUS7l0tUenCtw7UUh4SwCf7GRjYKWq3dqaPn+NEdGb+2zEkqKNPlG8TTnq5A9Shfe8=
X-Received: by 2002:a25:e305:0:b0:da0:3d48:aa68 with SMTP id
 z5-20020a25e305000000b00da03d48aa68mr2189648ybd.50.1700830409952; Fri, 24 Nov
 2023 04:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com>
 <20231002-sc7280-venus-pas-v2-2-bd2408891317@fairphone.com>
 <4cfad910-1821-3a31-c372-3f6b199e8f71@quicinc.com> <CX5ENKY70B5J.2D6DXKGI4EGX3@fairphone.com>
 <ff021f49-f81b-0fd1-bd2c-895dbbb03d56@quicinc.com> <CX70EBXCOB66.3998C482R86CN@fairphone.com>
 <a29123a3-afe1-8f92-ff6c-835926d411af@quicinc.com>
In-Reply-To: <a29123a3-afe1-8f92-ff6c-835926d411af@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 24 Nov 2023 14:53:19 +0200
Message-ID: <CAA8EJppkjpMmcHCvxomgUMPxGpf77iN9roRvb=NEcxdk237-UA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sc7280: Move video-firmware to chrome-common
To:     Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 14:30, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>
> On 11/24/2023 5:05 PM, Luca Weiss wrote:
> > On Fri Nov 24, 2023 at 7:38 AM CET, Vikash Garodia wrote:
> >>
> >> On 11/22/2023 7:50 PM, Luca Weiss wrote:
> >>> On Wed Nov 22, 2023 at 2:17 PM CET, Vikash Garodia wrote:
> >>>>
> >>>> On 10/2/2023 7:50 PM, Luca Weiss wrote:
> >>>>> If the video-firmware node is present, the venus driver assumes we're on
> >>>>> a system that doesn't use TZ for starting venus, like on ChromeOS
> >>>>> devices.
> >>>>>
> >>>>> Move the video-firmware node to chrome-common.dtsi so we can use venus
> >>>>> on a non-ChromeOS devices.
> >>>>>
> >>>>> At the same time also disable the venus node by default in the dtsi,
> >>>>> like it's done on other SoCs.
> >>>>>
> >>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> >>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 8 ++++++++
> >>>>>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 6 ++----
> >>>>>  2 files changed, 10 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> >>>>> index 5d462ae14ba1..cd491e46666d 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> >>>>> @@ -104,6 +104,14 @@ &scm {
> >>>>>   dma-coherent;
> >>>>>  };
> >>>>>
> >>>>> +&venus {
> >>>>> + status = "okay";
> >>>>> +
> >>>>> + video-firmware {
> >>>>> +         iommus = <&apps_smmu 0x21a2 0x0>;
> >>>>> + };
> >>>>> +};
> >>>>> +
> >>>>>  &watchdog {
> >>>>>   status = "okay";
> >>>>>  };
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>>>> index 66f1eb83cca7..fa53f54d4675 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>>>> @@ -3740,6 +3740,8 @@ venus: video-codec@aa00000 {
> >>>>>                            <&apps_smmu 0x2184 0x20>;
> >> 0x2184 is a secure SID. I think qcm6490-fairphone-fp5.dts needs to override the
> >> iommus property as well to retain only the non secure SID i.e 0x2180 ? I am
> >> seeing below crash
> >>
> >> Call trace:
> >> [   47.663593]  qcom_smmu_write_s2cr+0x64/0xa4
> >> [   47.663616]  arm_smmu_attach_dev+0x120/0x284
> >> [   47.663647]  __iommu_attach_device+0x24/0xf8
> >> [   47.676845]  __iommu_device_set_domain+0x70/0xd0
> >> [   47.681632]  __iommu_group_set_domain_internal+0x60/0x1b4
> >> [   47.687218]  iommu_setup_default_domain+0x358/0x418
> >> [   47.692258]  __iommu_probe_device+0x3e4/0x404
> >>
> >> Could you please reconfirm if Video SID 0x2184 (and mask) is allowed by the
> >> qcm6490-fairphone-fp5 hardware having TZ ?
> >
> > Hi,
> >
> > On FP5 it seems it's no problem to have both SIDs in there, probe and
> > using venus appears to work fine.
> >
> > Are you using different firmware than QCM6490.LA.3.0 on the device where
> > you tested this?
> I was testing this on RB3 board which uses firmware [1].

There is something wrong here.

RB3 board uses venus-5.2
RB5 board uses vpu-1.0
Only sc7280 uses vpu-2.0

>
> Regards,
> Vikash
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/qcom/vpu-2.0
>
> >>
> >>>>>                   memory-region = <&video_mem>;
> >>>>>
> >>>>> +                 status = "disabled";
> >>>>> +
> >>>>>                   video-decoder {
> >>>>>                           compatible = "venus-decoder";
> >>>>>                   };
> >>>>> @@ -3748,10 +3750,6 @@ video-encoder {
> >>>>>                           compatible = "venus-encoder";
> >>>>>                   };
> >>>>>
> >>>>> -                 video-firmware {
> >>>>> -                         iommus = <&apps_smmu 0x21a2 0x0>;
> >>>>> -                 };
> >>>>> -
> >>>>>                   venus_opp_table: opp-table {
> >>>>>                           compatible = "operating-points-v2";
> >>>>>
> >>>>>
> >>>> Changes look good. Is this tested on SC7280 ?
> >>>
> >>> Hi Vikash,
> >>>
> >>> I didn't test it myself on sc7280 (just qcm6490-fp5) but dtx_diff
> >>> reports no differences except for status = okay property being added, so
> >>> there should be no change on those boards. See below.
> >>>
> >>> Regards
> >>> Luca
> >>
> >> I tested on SC7280 (herobrine) and all good.
> >
> > Great, thanks!
> >
> > Regards
> > Luca
> >
> >>
> >> Regards,
> >> Vikash
> >
>


-- 
With best wishes
Dmitry
