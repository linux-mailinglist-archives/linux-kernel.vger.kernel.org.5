Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09FA756E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjGQUlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQUld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:41:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40BC103
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:41:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-314172bac25so4842889f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689626490; x=1692218490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dxs4QoOQ/zuyVwrQI4lubKrrMktOwLFYVCg8BWpDqAE=;
        b=i94RzqOBda0we6gStVXydLDozZedYS0fpZK7pAsIMIN7IJXNvyYVF2RumNOfBFIbAl
         WdWWZ2wsboobWEoBVfcjdQ5hYQ41X02Po46s83kFC6MmsbxflQ4mc952aTGhRbHGnKFb
         ulthz7ivLuKDhoYyzkfR+S+03giW7cDlMeB+L53yZYdLVdG5RXcUAtBQ8a9uD16erK6q
         wPQxWL3uGqAXZIOaaAJ5TqWhs56TkUxo8WwL8iyYILzt6UOgZuATex3R1BW25lOltVxy
         pHcclVdPi/puXIvpgzrqhFBOdpkdA2oI/s8oCU/lCibCpuZo6mhhSsR3At3zsNbDlOje
         2+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626490; x=1692218490;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dxs4QoOQ/zuyVwrQI4lubKrrMktOwLFYVCg8BWpDqAE=;
        b=jLX8KCr34O7lqKiDwtTkUi77RhzpkFzngSeOX7kaSN5BDTb9hMxxahWijmTRp1QL5J
         DKOm+CcdivR/NFPUPUmqRDN7hK/QG7EyzLArS5qLQDTN3k0xLG88dtpfqfnrmtBx7L/m
         xRqQQm5UIRoddqwE2Nf1mdMx4RSwjZsA2bwF475X9VoWzdteazmf94ySPL65/pl4Navx
         UtWIXtFtlgQs1Eif5T39hUwvEaZRH262j6X/JUI0TmpP2XvGYMPfVMYIYPtoxunRkRD5
         46abXmuMoKM22qAbm4OIIQJ4rivuS/8BoiG+roHz3bGesg1rnpc3LTJtjY3oddqko/QF
         Y+zA==
X-Gm-Message-State: ABy/qLYsXaRtoo4MxPF7Il9KodlQLVZ/0YwEfJs2YpXwWjVFWMsnnRDd
        FN8qJQeIPR02SZ1chC9b1MfqTHtynLEYOiQ2W9kpgw==
X-Google-Smtp-Source: APBJJlGSsV9rxiUISE+EtvohXTTyc6XC/XcPBnbdT6/SNm9+KvD19buO7D7jOsInc4V4JwLvQnwrAacAmUqhMj/w9B8=
X-Received: by 2002:adf:ffca:0:b0:314:1f1e:3a85 with SMTP id
 x10-20020adfffca000000b003141f1e3a85mr9589916wrs.61.1689626490362; Mon, 17
 Jul 2023 13:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230717103236.1246771-1-bhupesh.sharma@linaro.org>
 <20230717103236.1246771-4-bhupesh.sharma@linaro.org> <ZLUbyocjNT2bGvVt@gerhold.net>
 <CAH=2NtzM=jaVtjeHHO0rY0_wHu9==Jpdz4zx5nCK3gBh2kpL=A@mail.gmail.com>
 <ZLWHwnjjMkJx_ACH@gerhold.net> <CAH=2NtxHekJVvzaD5SNhZZmAHXhc=7v4Pr7RMEFNTXXH6x_AgQ@mail.gmail.com>
 <81491f7e-bd2c-7e3c-14c4-a7547d76c307@linaro.org> <CAH=2NtxX9jC6-7=bWEWTtgO=5VqX5U_ngnC6vWFZxDJUdsdg+g@mail.gmail.com>
 <5f415647-0cec-b4cd-f9a8-6b6690615498@linaro.org>
In-Reply-To: <5f415647-0cec-b4cd-f9a8-6b6690615498@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Tue, 18 Jul 2023 02:11:18 +0530
Message-ID: <CAH=2NtySyCVaxca_MVpDz6eOWvpGTSM3XHfjGUcNCeGXMXVtbQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3 connector
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org, quic_schowdhu@quicinc.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 at 01:54, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 17.07.2023 22:22, Bhupesh Sharma wrote:
> > On Tue, 18 Jul 2023 at 01:49, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 17.07.2023 22:09, Bhupesh Sharma wrote:
> >>> On Mon, 17 Jul 2023 at 23:58, Stephan Gerhold <stephan@gerhold.net> wrote:
> >>>>
> >>>> On Mon, Jul 17, 2023 at 11:33:40PM +0530, Bhupesh Sharma wrote:
> >>>>> On Mon, 17 Jul 2023 at 16:15, Stephan Gerhold <stephan@gerhold.net> wrote:
> >>>>>>
> >>>>>> On Mon, Jul 17, 2023 at 04:02:35PM +0530, Bhupesh Sharma wrote:
> >>>>>>> Add the Embedded USB Debugger(EUD) device tree node for
> >>>>>>> SM6115 / SM4250 SoC.
> >>>>>>>
> >>>>>>> The node contains EUD base register region, EUD mode manager
> >>>>>>> register region and TCSR Base register region along with the
> >>>>>>> interrupt entry.
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>>>>>> ---
> >>>>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 50 ++++++++++++++++++++++++++++
> >>>>>>>  1 file changed, 50 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>>> index 839c603512403..db45337c1082c 100644
> >>>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>>>>>> [...]
> >>>>>>> @@ -789,6 +801,37 @@ gcc: clock-controller@1400000 {
> >>>>>>>                       #power-domain-cells = <1>;
> >>>>>>>               };
> >>>>>>>
> >>>>>>> +             eud: eud@1610000 {
> >>>>>>> +                     compatible = "qcom,sm6115-eud", "qcom,eud";
> >>>>>>> +                     reg = <0x0 0x01610000 0x0 0x2000>,
> >>>>>>> +                           <0x0 0x01612000 0x0 0x1000>,
> >>>>>>> +                           <0x0 0x003c0000 0x0 0x40000>;
> >>>>>>> +                     reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
> >>>>>>
> >>>>>> TCSR is a separate hardware block unrelated to the EUD. IMHO it
> >>>>>> shouldn't be listed as "reg" here.
> >>>>>>
> >>>>>> Typically we describe it as syscon and then reference it from other
> >>>>>> nodes. See e.g. sm8450.dtsi "tcsr: syscon@1fc0000" referenced in &scm
> >>>>>> "qcom,dload-mode = <&tcsr 0x13000>". This is pretty much exactly the
> >>>>>> same use case as you have. It also uses this to write something with
> >>>>>> qcom_scm_io_writel() at the end.
> >>>>>
> >>>>> That was discussed a bit during v1 patchset review. Basically, if we
> >>>>> use a tcsr syscon approach here, we will need to define a 'qcom,xx'
> >>>>> vendor specific dt-property and use something like this in the eud
> >>>>> node:
> >>>>>
> >>>>> qcom,eud-sec-reg = <&tcsr_reg yyyy>
> >>>>>
> >>>>> which would be then used by the eud driver (via
> >>>>> syscon_regmap_lookup_by_phandle()).
> >>>>>
> >>>>> But for sm6115 / qcm2290 this would be an over complicated solution as
> >>>>> normally the eud driver (say sc7280) doesn't need tcsr based secure
> >>>>> mode manager access. So defining a new soc / vendor specific
> >>>>> dt-property might be an overkill.
> >>>>>
> >>>>
> >>>> IMO a vendor-specific DT property is still better than messing up the
> >>>> device separation in the device tree. The same "tcsr-base" reg would
> >>>> also appear on the actual tcsr syscon device tree node. Having two
> >>>> device tree nodes with the same reg region is generally not valid.
> >>>>
> >>>> Something like qcom,eud-sec-reg = <&tcsr_reg yyyy> would at least make
> >>>> clear that this points into a region that is shared between multiple
> >>>> different devices, while adding it as reg suggests that TCSR belongs
> >>>> exclusively to EUD.
> >>>
> >>> I understand your point but since for sm6115 / qcm2290 devices TCSR is
> >>> not used for any other purpose than EUD, I still think introducing a
> >>> new soc / vendor specific dt-property might be an overkill for this
> >>> changeset.
> >> Untrue, there's some mumblings around the PHY properties and PSHOLD.
> >> I think Stephan may be correct here.
> >
> > Can you share the links to those discussions?
> It just seemed off to me that TCSR was not used by anything else (even
> from Linux, it would obviously be used by something else higher up in
> the boot chain as it contains various configuration registers), so I
> took a glance at the downstream device tree and I noticed there are
> more users.

Ok, let me recheck the downstream code and come back.

Thanks,
Bhupesh
