Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7B806150
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbjLEWET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjLEWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:04:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591D137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 14:04:23 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf69afa99so3632434e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701813859; x=1702418659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5alETUhzLBA8tnENs+ZYtrYNqu05J/iFPPwE+W2F73g=;
        b=Oo6wBv6bMLKeL0JBFuh1uTtL91ZmK4BbwYzKYW1EJ6k3ERyQnKnE6G22TCPyqwU8CR
         u8/ob2piMBS3eWwgKMag+4rCtLMS6MhqNegjGPB/GweQof3knzSISn6R9fM6jqz2Ix8m
         FUXomrmZu0+x5xKte/2OIqbcIjadIJXTAzFd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701813859; x=1702418659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5alETUhzLBA8tnENs+ZYtrYNqu05J/iFPPwE+W2F73g=;
        b=uIi+XFBt43MSvvI/nWMM6yPQrcGYOaRdKlCa752PwARAYbyJD5LzYMfU+R3w+pyifw
         lMoa2LFkGVFIUttXGknV+7r+FIZoKayrERITB/HktcrL15tynFeDe4Lts+US4cupLyJr
         RChzvSKorE2BN0gRBqOMRMaOQlD1A3gir9+ZR03BjzcA7u0t0fREEam2tbuNc4U1YUQl
         fDpWzOVs3Kw7Dvz8c3cMPNHkw+ARyRLtb5uULRVE5EKYGxDLpqLX7dzAkrNHBubR4iFz
         MFUd7/g4Oh06YziD7qm86t524B5RbDZLhd+I9swZSbUYlXyVO1YaOQcOlCvHuOMx/D5l
         UFQA==
X-Gm-Message-State: AOJu0Yxg57xdBUVNe/vRc7H605B2AExZd8FAAwqs9dAJBb0ol6cpN912
        EGN3M01fLRQ6NZNyd43bSvi7pzhzvg+aW9o9x16oXUQ+
X-Google-Smtp-Source: AGHT+IEKbXCFO/pvm2OpQ+ZoBJF1MHj03/0xjeMvb2zqBZfEUiJuRB0Z4AeHazoooA+5oqaTEUIJIw==
X-Received: by 2002:a05:6512:2512:b0:50b:f86b:b3b4 with SMTP id be18-20020a056512251200b0050bf86bb3b4mr2708773lfb.117.1701813859399;
        Tue, 05 Dec 2023 14:04:19 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id w22-20020a170907271600b00a1d2b0d4500sm548832ejk.168.2023.12.05.14.04.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 14:04:19 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso6335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 14:04:18 -0800 (PST)
X-Received: by 2002:a05:600c:4e8d:b0:40b:33aa:a2b9 with SMTP id
 f13-20020a05600c4e8d00b0040b33aaa2b9mr25903wmq.4.1701813858451; Tue, 05 Dec
 2023 14:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com> <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
 <CAE-0n50HwE+gNYotYXduer3b=O+c3ZWLC_8gEmpo0KQmtzmNvQ@mail.gmail.com>
 <d1e3adb5-b179-a119-fc0c-f92c2b84c7c2@quicinc.com> <SN4PR0201MB8806AF236D696E15CDC6400CF9A9A@SN4PR0201MB8806.namprd02.prod.outlook.com>
 <CAE-0n50kf82BLXPAAUN+kba9osA-gEetm96tS7aRVzUUNHbCgQ@mail.gmail.com>
In-Reply-To: <CAE-0n50kf82BLXPAAUN+kba9osA-gEetm96tS7aRVzUUNHbCgQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Dec 2023 14:04:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W7pjg=vfrkZg4i=YaKpoNT+_hX_3tgDz8VQiH+OquOTQ@mail.gmail.com>
Message-ID: <CAD=FV=W7pjg=vfrkZg4i=YaKpoNT+_hX_3tgDz8VQiH+OquOTQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Atul Dhudase <quic_adhudase@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 9, 2023 at 12:34=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Quoting Atul Dhudase (QUIC) (2023-11-07 07:27:54)
> > Hi,
> >
> > On 11/7/2023 6:46 PM, Mukesh Ojha wrote:
> > > On 11/7/2023 3:25 AM, Stephen Boyd wrote:
> > > > Quoting Mukesh Ojha (2023-11-05 22:54:28)
> > > >>
> > > >>
> > > >> On 11/4/2023 1:03 AM, Bjorn Andersson wrote:
> > > >>> On Fri, Nov 03, 2023 at 04:27:12PM +0530, Atul Dhudase wrote:
> > > >>>> While programming dis_cap_alloc and retain_on_pc, set a bit
> > > >>>> corresponding to a specific SCID without disturbing the
> > > >>>> previously configured bits.
> > > >>>>
> > > >>>
> > > >>> As far as I can see, the only invocation of
> > > >>> _qcom_llcc_cfg_program() comes from qcom_llcc_cfg_program(), whic=
h
> > > >>> is only called once, from qcom_llcc_probe(), and here also seems
> > > >>> to only be the single write to these two registers.
> > > >>
> > > >> It does not look to be single write but the write is for each slic=
e
> > > >> in the same register which was overriding other slices values.
> > > >
> > > > Can you add that detail to the commit text? What's the seriousness
> > > > of the issue? Why should it be backported to stable? Is something
> > > > seriously broken because a slice configuration is overwritten? Does
> > > > it mean that some allocation made in a slice is being lost over
> > > > power collapse (pc) when it shouldn't be?
> > >
> > > @Atul will update the commit text as per suggestion.
> > >
> > > And yes, without this change, retention feature will not work properl=
y.
> > >
> > > -Mukesh
> >
> > Does this commit text make sense? If so, I will update patch accordingl=
y.
> >
> > When configuring capacity based allocation and power collapse retention=
, writing to the same register for each slice caused overwriting of the val=
ues for other slices, leading to misconfiguration for majority of the slice=
s.
> > To address this, only modify the bits associated with each slice while =
retaining the values of the remaining bits, as they were prior to the Linux=
 configuration.
>
> This commit text doesn't say what, if anything, is broken. Does it save
> power when it didn't before? Why is it critical to backport this to
> stable kernels? Was the driver overwriting other bits in this register
> that were critical to power, performance, or correctness? Or was
> everything working out because the last slice to be written was the only
> important one?

Whatever happened to this patch? It seemed like it might be important
and it never landed. I guess the only thing that was blocking it from
landing was some commit text that explained _why_ it was important and
that never got written.

I guess Bjorn was also worried that any bits that weren't updated by
the kernel would now be left in their default state (however the
bootloader left them). It would be good to indicate in the commit text
if that matters and what is in those other bits.


-Doug
