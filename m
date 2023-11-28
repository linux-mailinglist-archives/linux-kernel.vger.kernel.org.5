Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD57FBA06
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbjK1MZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344474AbjK1MZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:25:17 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9904FD5B;
        Tue, 28 Nov 2023 04:25:23 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfb30ce241so27371795ad.0;
        Tue, 28 Nov 2023 04:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701174323; x=1701779123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FpZMH9jqBR7iLcAB8dXkkbG1VWWxWtCIiGpAgogjkdw=;
        b=BnXhwdQPUO1WRphA7Nx1Q7PcxJYbajIJld44sWCz71kbdlP0v6dQJfoHI2qNfp1UF3
         0Y+0WDItCGbIMLlNIFslTFgHcgwv7q3AiKYECDOx8Ss9NuesZIlm/SomgQoIp2rVJBnk
         svf+S42JznityHKXiUJ+dZoeyWXrO00Sp5HG6Km0cu5Ss3TZYb2qleyah0feek4eRkFt
         DN7q1Cg1AOYvYDRkeyW6mj7G4D0rsoX85K88aWC/eX/YEdamhLaZUrnDFFUruFD31EwZ
         Q/IOGy94ACkUzuUYi1U5TYCAXkp+Aa1DOFHOUGsVuPQpfZoDH6IGOAsk7c5EpbPtx6pY
         pYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701174323; x=1701779123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpZMH9jqBR7iLcAB8dXkkbG1VWWxWtCIiGpAgogjkdw=;
        b=Adn+HFfptGm0qXwej/Ukvz47+IkZTmgQUO0UlGdhkNVKgyWqGurlByo1LqDr9SWR+3
         8NPH//l6SsmMg3fPDUvUxvOh/w0/kQEAUcMQVqMkFizgMelTu1FElNRoIF3LGLvlarzD
         Bbvz9OPhcAoKk3Ew9Viztgys4GHOZrS6egqHrVDx1uGsw4VgGec6YQ9Tuu4uNp36b7TH
         KCWnQwUc+3w+XKlkpmPad70MRvUh8+MHhYWC4ga5bmq7cNHawGrOGyrTr8Kcj+xL201U
         xSLUX50OWOWxz3C75LRkJglxLMEhqjvvLEmzd35XvOt83QZ8SvpA7ZDTKmefpZup3pQz
         3NlQ==
X-Gm-Message-State: AOJu0Ywkojbnyg5yo9wZSMjqGai49dtTqpTNjjZ8G6LqlXOHG7Rs1rn3
        LIHCfEGSK/kIEjWOlhq9BkhPDn1ain46lUgRtwXqdOxbC/Q=
X-Google-Smtp-Source: AGHT+IEncS9KAPArxVtfBqiUQpZTa6Fa44Km3nsDxBpEXJqvkVttbxmetcS4gSR0rmf239ATBFkw//MalFkIAgy8PtE=
X-Received: by 2002:a17:90a:f2d2:b0:27d:348:94a8 with SMTP id
 gt18-20020a17090af2d200b0027d034894a8mr15336036pjb.6.1701174323063; Tue, 28
 Nov 2023 04:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20231025104457.628109-1-robimarko@gmail.com> <20231025104457.628109-2-robimarko@gmail.com>
 <CAOX2RU4MBvDZZ767RPS9XKj0U2L3gviVG5cyR8NKyO4LD+sfYQ@mail.gmail.com>
 <20c8cfde-3f55-45c5-bc23-21979ac9680d@linaro.org> <CAOX2RU5-XFZhGzjigNtu-qFnPWDd2XkpGpY=HXWigRa5SXw4TA@mail.gmail.com>
 <ef377506-4132-4805-a76e-18f241afe319@linaro.org> <CAOX2RU4K67evm10giQvF1rcfqTfR+e--KQT3ZePoHQoqASv_fg@mail.gmail.com>
 <bdf6be0b-c137-48ce-8a3f-ab74bced6f87@linaro.org> <CAOX2RU4z1Dcs7ct0BAaS7wicYVmQEiSe74=w_grFDKQv22uoFg@mail.gmail.com>
 <4243a841-5509-4d04-8ec7-191f2ba5677a@linaro.org> <CAOX2RU73n4JUTxGGgN7YOEqjj-1_=n=UZ99xsZ8Easp6O-D_yA@mail.gmail.com>
 <1f7674ea-ed79-48b1-b577-1596e6fe57d2@linaro.org>
In-Reply-To: <1f7674ea-ed79-48b1-b577-1596e6fe57d2@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 28 Nov 2023 13:25:11 +0100
Message-ID: <CAOX2RU67BHtiQf1HbZMTUUSMckY7J8kbKR6LeLuDKKAaGS0r-A@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: qcom: ipq6018: add USB GDSCs
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 17:22, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 11/13/23 13:50, Robert Marko wrote:
> > On Mon, 13 Nov 2023 at 12:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 11.11.2023 12:28, Robert Marko wrote:
> >>> On Tue, 7 Nov 2023 at 22:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10/31/23 10:01, Robert Marko wrote:
> >>>>> On Mon, 30 Oct 2023 at 22:12, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>>>
> >>>>>> On 30.10.2023 21:37, Robert Marko wrote:
> >>>>>>> On Mon, 30 Oct 2023 at 20:37, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>>>>>
> >>>>>>>> On 29.10.2023 12:04, Robert Marko wrote:
> >>>>>>>>> On Wed, 25 Oct 2023 at 12:45, Robert Marko <robimarko@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> IPQ6018 has GDSC-s for each of the USB ports, so lets define them as such
> >>>>>>>>>> and drop the curent code that is de-asserting the USB GDSC-s as part of
> >>>>>>>>>> the GCC probe.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>>>>>>>
> >>>>>>>>> Unfortunately, after testing on multiple devices I hit the same GDSC
> >>>>>>>>> issue I had a long time ago
> >>>>>>>>> that was the reason I did not send this upstream.
> >>>>>>>>> It seems that USB3 port GDSC (USB0 GDSC in code) works just fine,
> >>>>>>>>> however the USB2 one
> >>>>>>>>> (USB1 GDSC in code) it is stuck off and USB2 port will fail due to this:
> >>>>>>>>>       1.607531] ------------[ cut here ]------------
> >>>>>>>>> [    1.607559] usb1_gdsc status stuck at 'off'
> >>>>>>>>> [    1.607592] WARNING: CPU: 0 PID: 35 at gdsc_toggle_logic+0x16c/0x174
> >>>>>>>>> [    1.615120] Modules linked in:
> >>>>>>>> Can you dump GDSCR (the entire 32-bit register) at boot and when toggling?
> >>>>>>>
> >>>>>>> Sure, here it is:
> >>>>>>> [    0.023760] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3e078 val: 0x8222004 init
> >>>>>>> [    0.023782] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val: 0x8222004 init
> >>>>>>> [    0.988626] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
> >>>>>>> 0x8282000 before toggle
> >>>>>>> [    1.202506] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
> >>>>>>> 0x8282000 after toggle
> >>>>>>> [    1.207208] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3e078 val:
> >>>>>>> 0xa0282000 before toggle
> >>>>>> Any chance
> >>>>>>
> >>>>>> .en_few_wait_val = 0x2
> >>>>>>
> >>>>>> (turning BIT(19) into BIT(17))
> >>>>>>
> >>>>>> will make a difference?
> >>>>>
> >>>>> Sadly, it makes no difference and GDSC status bit newer comes up which is
> >>>>> rather weird as USB0 one seems to work just fine.
> >>>> What if you add clk_ignore_unused?
> >>>
> >>> To the USB1 master clock or?
> >> That's a command line parameter, effectively setting it on all clks.
> >
> > Oh that, I understand now.
> >
> >>
> >>>
> >>> There is definitively something broken regarding the GDSC as
> >>> GDSC_STATE bits (30-27)
> >>> change from 0 to something on the USB0 GDSC but on GDSC1 they are 0 even after
> >>> SW_OVERRIDE BIT(2) is set to 1, and the POWER BIT(31) newer changes to 1.
> >>>
> >>> However, if you manually set BIT(2) to 1 then the USB1 master clock
> >>> can come up so
> >>> GDSC seems to work.
> >>> USB1 (The USB2.0 HS) port is still broken after this if USB mass storage is used
> >>> but that was present before the GDSC changes as well and I still need
> >>> to figure out
> >>> which quirk is missing for this.
> >> Please try clk_ignore_unused and see if toggling the GDSC is still broken.
> >
> > Sadly, passing clk_ignore_unused in the bootargs doesn't help, GDSC is
> > still stuck off.
> Hm, so it looks like there's no clock dependency for this GDSC..
>
> Maybe some regulator needs to be turned on?
>
> Can you try to add regulator-always-on to all vregs and retry?
> (and keep clk_ignore_unused to be sure)

Sorry for the ultra late reply, currently there is just CPU regulator described
via RPM.

I will look into describing the VQMMC and others I can find but I doubt
it will change anything as no regulators are getting disabled currently.

Regards,
Robert
>
> Konrad
