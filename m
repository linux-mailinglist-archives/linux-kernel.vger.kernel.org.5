Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421557DC157
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjJ3Uh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjJ3Uh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:37:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68FB109;
        Mon, 30 Oct 2023 13:37:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-280137f1a1bso2265902a91.1;
        Mon, 30 Oct 2023 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698698242; x=1699303042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9/tyopkMDgCBg9IJqpFJkPLn4LWq8TVkMh2MToeKQVk=;
        b=LPyVbDBnDyiXR6fmcUxWjGRvG4LKTOMKx/febS/f5/SlWuGl2OjEfeXOWI4BPwZaBw
         caKmCaixtxEN3EuUZH1G5AtAGX6McEUrknmkaKazet98AvyUe+yTZ0a3S5CSHMG/6Jj0
         NsweWys0uJ+ZjeISFydIdaEt226on1hkGrLaX3ksabV1P3CbiaFe5r2O8hT8fsNzlqUC
         rPZTrxUpoTX90Owb6pV8di4LCIvZhZuBGOP7Ig5Zidd2WgHo8nRluErFXnoGUR4GlXgP
         WUOOAbs0ePuJJgbXm2u29VpiaqepXGoDDWrWaaaM97A1XLbdVw9k6UB4Eik4L4olbmNx
         0KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698698242; x=1699303042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/tyopkMDgCBg9IJqpFJkPLn4LWq8TVkMh2MToeKQVk=;
        b=YXAgxN4s1LQ5GRLFcAhYVOBeFmGxHNGaEaFRItA45CmnHLP7kvt8lilTULJTxOXwiN
         6857IFPXzZbbeMk26S/hAlasjhKHHpjPPqd0w+C9y4RdMxJIdERn+LLSxxUbw5lsB2Qe
         7nsjpQl8VbtGdtBJZxxQ62nh0V8pKXUMkj6Dxcal8AH60XpIKUHCn3RO2uIOGxudXuVi
         VKmVenw9kQfj0Wt0kdqy4FJM94SlYO+PyGfhY3DKkTm+n+M8En0SudrujhaThnxxrT5x
         4tB2mpwgynGRM/kIJczEhxN+Mo5zKhh/KMOS8O6ahoKA3J02zZ1zTULCUFD/SQNBL0m5
         R8xA==
X-Gm-Message-State: AOJu0YwszRARL0uewqzhfK3EY1LOb9q9n+YHIXd0PGoUgouLzDPebWwc
        9zHsj9q82JdQqWFuWlnrQv2W8ru/up4jSJ7b3qU=
X-Google-Smtp-Source: AGHT+IEyszwTBuUXM69NzRLrKZXAPOrNdGf4XC40IKbRok1aPdBnufwVvWTsRcO2sjDNUapfvR7C1s6EocKux2iwN+w=
X-Received: by 2002:a17:90b:111:b0:27d:c95:b0ad with SMTP id
 p17-20020a17090b011100b0027d0c95b0admr7633906pjz.21.1698698242060; Mon, 30
 Oct 2023 13:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231025104457.628109-1-robimarko@gmail.com> <20231025104457.628109-2-robimarko@gmail.com>
 <CAOX2RU4MBvDZZ767RPS9XKj0U2L3gviVG5cyR8NKyO4LD+sfYQ@mail.gmail.com> <20c8cfde-3f55-45c5-bc23-21979ac9680d@linaro.org>
In-Reply-To: <20c8cfde-3f55-45c5-bc23-21979ac9680d@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 30 Oct 2023 21:37:10 +0100
Message-ID: <CAOX2RU5-XFZhGzjigNtu-qFnPWDd2XkpGpY=HXWigRa5SXw4TA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 20:37, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 29.10.2023 12:04, Robert Marko wrote:
> > On Wed, 25 Oct 2023 at 12:45, Robert Marko <robimarko@gmail.com> wrote:
> >>
> >> IPQ6018 has GDSC-s for each of the USB ports, so lets define them as such
> >> and drop the curent code that is de-asserting the USB GDSC-s as part of
> >> the GCC probe.
> >>
> >> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >
> > Unfortunately, after testing on multiple devices I hit the same GDSC
> > issue I had a long time ago
> > that was the reason I did not send this upstream.
> > It seems that USB3 port GDSC (USB0 GDSC in code) works just fine,
> > however the USB2 one
> > (USB1 GDSC in code) it is stuck off and USB2 port will fail due to this:
> >     1.607531] ------------[ cut here ]------------
> > [    1.607559] usb1_gdsc status stuck at 'off'
> > [    1.607592] WARNING: CPU: 0 PID: 35 at gdsc_toggle_logic+0x16c/0x174
> > [    1.615120] Modules linked in:
> Can you dump GDSCR (the entire 32-bit register) at boot and when toggling?

Sure, here it is:
[    0.023760] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3e078 val: 0x8222004 init
[    0.023782] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val: 0x8222004 init
[    0.988626] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 before toggle
[    1.202506] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 after toggle
[    1.207208] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3e078 val:
0xa0282000 before toggle
[    1.216208] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3e078 val:
0xa0282000 after toggle
[    1.648261] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 before toggle
[    1.865867] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 after toggle
[    1.880638] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 before toggle
[    2.108643] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 after toggle
[    2.113495] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 before toggle
[    2.340844] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 after toggle
[   10.588698] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 before toggle
[   10.815257] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 after toggle
[   11.554561] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 before toggle
[   11.774515] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 after toggle
[   11.781652] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 before toggle
[   12.039619] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 after toggle
[   22.233021] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 before toggle
[   22.452907] qcom,gcc-ipq6018 1800000.gcc: reg: 0x3f078 val:
0x8282000 after toggle

BTW, earlier I tried manually setting BIT(2) to 1 and that will allow
the USB1 master clock to
come up.

Regards,
Robert
>
> Konrad
