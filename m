Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7A7E9C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKMMvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKMMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:51:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74141722;
        Mon, 13 Nov 2023 04:51:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-280200949c3so3279813a91.0;
        Mon, 13 Nov 2023 04:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699879860; x=1700484660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s1u2wgBJR1eY/vvX4BSIn+hcZj98gJmcG5xtzxqEays=;
        b=cKHDRoqGMroCQXmP4xuO2obx5UlwwMwm4fnl0qnOey3hV05znUB55g79uTWWox+DGW
         FyUle/BEogkoy8gW389K9EuKxlzoCcBzpCWXkrmXR6EEUFTowvSo9OD2YkbWhQTro41K
         ZFYThpWvxAE6xm3Dk3Q9DbCoZUaXBW6NiBDhoGUk4UDNkIpgoH/OhhrLM2mbbyHieDis
         IcEntkYE3Jn0PmxWC+FKmpdwERwvIBTiKwQeyRp9713OqLaFzGpDUu3524MFsV9/ekE+
         1ZCH1O/EIVKFx4VAUepkpdO1WI701Gv3Q8CD0TS2oWl7XCYPnStA4qkVPq8jqhRWWTAQ
         lq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699879860; x=1700484660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1u2wgBJR1eY/vvX4BSIn+hcZj98gJmcG5xtzxqEays=;
        b=CsuQL2QQavP6cRebYXDvNrigrf5z123wpWNSEA6hYvakjsWsCR7i97jYbUKXrhDT1+
         rtGe0SVqWAweBQECPO7anbuSWlg3Btsil9E2/xNWvv4hD9B7gQct4al6cWruCfxOn+Bp
         2I6WyNb/ZCSoLeTeGUZf9nULzIFs0ikOZG+cw8lz6aBg4ISTAvnw9U0hCBd+SKQyZDxA
         Yl/bD8Ngbobr/b8v6L+IRSe2mk52xv/qV054HpmTfvVK62LdK88AxwU22R9s7pnSlq3r
         mXcsIfu3p1zieLsMQMpOKH7iEposgl2dx7uar6/AWQAiLNtTiKsienElILYV4JW5vaJg
         T5Uw==
X-Gm-Message-State: AOJu0YxvP/wfyXzByA6m9wtwsaGlJBssSVMqQqPNctq0A1hErh0r05rp
        3+bRxt1WGffjDaL9jjW7xaA62gkX3q9nKiBNDrs=
X-Google-Smtp-Source: AGHT+IFjsWsacLBDEf3mCA9vW/UukdUhufQXIETHl5zYVqAZBxyiINS3gtbD/tXHvfCFOuUcnyECG4ttZv3zavYrymY=
X-Received: by 2002:a17:90b:4b4b:b0:280:16bb:8169 with SMTP id
 mi11-20020a17090b4b4b00b0028016bb8169mr3707546pjb.40.1699879860080; Mon, 13
 Nov 2023 04:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20231025104457.628109-1-robimarko@gmail.com> <20231025104457.628109-2-robimarko@gmail.com>
 <CAOX2RU4MBvDZZ767RPS9XKj0U2L3gviVG5cyR8NKyO4LD+sfYQ@mail.gmail.com>
 <20c8cfde-3f55-45c5-bc23-21979ac9680d@linaro.org> <CAOX2RU5-XFZhGzjigNtu-qFnPWDd2XkpGpY=HXWigRa5SXw4TA@mail.gmail.com>
 <ef377506-4132-4805-a76e-18f241afe319@linaro.org> <CAOX2RU4K67evm10giQvF1rcfqTfR+e--KQT3ZePoHQoqASv_fg@mail.gmail.com>
 <bdf6be0b-c137-48ce-8a3f-ab74bced6f87@linaro.org> <CAOX2RU4z1Dcs7ct0BAaS7wicYVmQEiSe74=w_grFDKQv22uoFg@mail.gmail.com>
 <4243a841-5509-4d04-8ec7-191f2ba5677a@linaro.org>
In-Reply-To: <4243a841-5509-4d04-8ec7-191f2ba5677a@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 13 Nov 2023 13:50:48 +0100
Message-ID: <CAOX2RU73n4JUTxGGgN7YOEqjj-1_=n=UZ99xsZ8Easp6O-D_yA@mail.gmail.com>
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

On Mon, 13 Nov 2023 at 12:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 11.11.2023 12:28, Robert Marko wrote:
> > On Tue, 7 Nov 2023 at 22:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 10/31/23 10:01, Robert Marko wrote:
> >>> On Mon, 30 Oct 2023 at 22:12, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>
> >>>> On 30.10.2023 21:37, Robert Marko wrote:
> >>>>> On Mon, 30 Oct 2023 at 20:37, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>>>
> >>>>>> On 29.10.2023 12:04, Robert Marko wrote:
> >>>>>>> On Wed, 25 Oct 2023 at 12:45, Robert Marko <robimarko@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> IPQ6018 has GDSC-s for each of the USB ports, so lets define them as such
> >>>>>>>> and drop the curent code that is de-asserting the USB GDSC-s as part of
> >>>>>>>> the GCC probe.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>>>>>
> >>>>>>> Unfortunately, after testing on multiple devices I hit the same GDSC
> >>>>>>> issue I had a long time ago
> >>>>>>> that was the reason I did not send this upstream.
> >>>>>>> It seems that USB3 port GDSC (USB0 GDSC in code) works just fine,
> >>>>>>> however the USB2 one
> >>>>>>> (USB1 GDSC in code) it is stuck off and USB2 port will fail due to this:
> >>>>>>>      1.607531] ------------[ cut here ]------------
> >>>>>>> [    1.607559] usb1_gdsc status stuck at 'off'
> >>>>>>> [    1.607592] WARNING: CPU: 0 PID: 35 at gdsc_toggle_logic+0x16c/0x174
> >>>>>>> [    1.615120] Modules linked in:
> >>>>>> Can you dump GDSCR (the entire 32-bit register) at boot and when toggling?
> >>>>>
> >>>>> Sure, here it is:
> >>>>> [    0.023760] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3e078 val: 0x8222004 init
> >>>>> [    0.023782] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val: 0x8222004 init
> >>>>> [    0.988626] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
> >>>>> 0x8282000 before toggle
> >>>>> [    1.202506] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
> >>>>> 0x8282000 after toggle
> >>>>> [    1.207208] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3e078 val:
> >>>>> 0xa0282000 before toggle
> >>>> Any chance
> >>>>
> >>>> .en_few_wait_val = 0x2
> >>>>
> >>>> (turning BIT(19) into BIT(17))
> >>>>
> >>>> will make a difference?
> >>>
> >>> Sadly, it makes no difference and GDSC status bit newer comes up which is
> >>> rather weird as USB0 one seems to work just fine.
> >> What if you add clk_ignore_unused?
> >
> > To the USB1 master clock or?
> That's a command line parameter, effectively setting it on all clks.

Oh that, I understand now.

>
> >
> > There is definitively something broken regarding the GDSC as
> > GDSC_STATE bits (30-27)
> > change from 0 to something on the USB0 GDSC but on GDSC1 they are 0 even after
> > SW_OVERRIDE BIT(2) is set to 1, and the POWER BIT(31) newer changes to 1.
> >
> > However, if you manually set BIT(2) to 1 then the USB1 master clock
> > can come up so
> > GDSC seems to work.
> > USB1 (The USB2.0 HS) port is still broken after this if USB mass storage is used
> > but that was present before the GDSC changes as well and I still need
> > to figure out
> > which quirk is missing for this.
> Please try clk_ignore_unused and see if toggling the GDSC is still broken.

Sadly, passing clk_ignore_unused in the bootargs doesn't help, GDSC is
still stuck off.

Regards,
Robert

>
> Konrad
