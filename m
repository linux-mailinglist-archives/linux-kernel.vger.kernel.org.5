Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428AD7E72EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345122AbjKIUeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKIUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:34:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D0468A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:34:06 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a98517f3so1653060e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 12:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699562044; x=1700166844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hz4SrDWOwT1Nsy0SNakjHPg+dcbTcePbPFPDCX1MNlw=;
        b=ntBYfzzGt0HbXE61/raQhX/S590G8HbHAzI8UvsgC7aJFgIu8HVtkIXl+wkj5nmPeN
         t615RknvmF8K01HaRDV2Imug1XUGoio1qTDL8wVH519k/KHRkWnjE+exT8+Oj/jhxYEN
         svDiTFWkGCZRefv8iQtJPabFTwiyFhXoLym38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699562044; x=1700166844;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hz4SrDWOwT1Nsy0SNakjHPg+dcbTcePbPFPDCX1MNlw=;
        b=qPdnui7pJbmwsappJXUCXqA1j8MR4PqNQrMtT0TNRtOVqQojQrkn1Ayqp/rn567TyP
         d6pdWVm7oSPU5psTEXjgMK+E8hL2oEcq8NdbAX9kRQ4IId3xTx62omrOkNxn++qy/a8R
         YFhR+/faOcGn3kGcLeylMBy6pi7otViCTgEnLwZHMF1XqRQh+4RiyRVfnXaSHBwtv5D/
         vz0KgWP8xnGPR6VOl7MTrDerygntAfpnYjHPS8tO/0hUspHx2VV2qUOkCa3O3AWdtqb4
         IeTZphIJtP1eVL4D/aiUNkY3e6VFpV1BY7tgXNAjZSS6eMP96mIb92piRaJ/4WPcp3TC
         CmAw==
X-Gm-Message-State: AOJu0YxgSa9kJtqz1ndWXzro3SosOnC4TwVcvJA6RCmhN3UMwmzr1mkW
        SJb2h0EFYz12YhUD4/HoD9ouaO5K23vyCwA/PPeqDw==
X-Google-Smtp-Source: AGHT+IHxaoMdJSaick3WZp30fELOfB8B2NREc8x0ndMpBbabG9IL/PN6Usl+78bptH1bUYxO3Qg87tdyObWvdch7174=
X-Received: by 2002:a05:6512:1592:b0:50a:2721:a43d with SMTP id
 bp18-20020a056512159200b0050a2721a43dmr242391lfb.49.1699562044147; Thu, 09
 Nov 2023 12:34:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Nov 2023 12:34:03 -0800
MIME-Version: 1.0
In-Reply-To: <SN4PR0201MB8806AF236D696E15CDC6400CF9A9A@SN4PR0201MB8806.namprd02.prod.outlook.com>
References: <20231103105712.1159213-1-quic_adhudase@quicinc.com>
 <20231103193345.GY3553829@hu-bjorande-lv.qualcomm.com> <5e83d947-c77f-9318-4a4c-377a8304b8fd@quicinc.com>
 <CAE-0n50HwE+gNYotYXduer3b=O+c3ZWLC_8gEmpo0KQmtzmNvQ@mail.gmail.com>
 <d1e3adb5-b179-a119-fc0c-f92c2b84c7c2@quicinc.com> <SN4PR0201MB8806AF236D696E15CDC6400CF9A9A@SN4PR0201MB8806.namprd02.prod.outlook.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 9 Nov 2023 12:34:03 -0800
Message-ID: <CAE-0n50kf82BLXPAAUN+kba9osA-gEetm96tS7aRVzUUNHbCgQ@mail.gmail.com>
Subject: RE: [PATCH] soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
To:     Atul Dhudase <quic_adhudase@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Atul Dhudase (QUIC) (2023-11-07 07:27:54)
> Hi,
>
> On 11/7/2023 6:46 PM, Mukesh Ojha wrote:
> > On 11/7/2023 3:25 AM, Stephen Boyd wrote:
> > > Quoting Mukesh Ojha (2023-11-05 22:54:28)
> > >>
> > >>
> > >> On 11/4/2023 1:03 AM, Bjorn Andersson wrote:
> > >>> On Fri, Nov 03, 2023 at 04:27:12PM +0530, Atul Dhudase wrote:
> > >>>> While programming dis_cap_alloc and retain_on_pc, set a bit
> > >>>> corresponding to a specific SCID without disturbing the
> > >>>> previously configured bits.
> > >>>>
> > >>>
> > >>> As far as I can see, the only invocation of
> > >>> _qcom_llcc_cfg_program() comes from qcom_llcc_cfg_program(), which
> > >>> is only called once, from qcom_llcc_probe(), and here also seems
> > >>> to only be the single write to these two registers.
> > >>
> > >> It does not look to be single write but the write is for each slice
> > >> in the same register which was overriding other slices values.
> > >
> > > Can you add that detail to the commit text? What's the seriousness
> > > of the issue? Why should it be backported to stable? Is something
> > > seriously broken because a slice configuration is overwritten? Does
> > > it mean that some allocation made in a slice is being lost over
> > > power collapse (pc) when it shouldn't be?
> >
> > @Atul will update the commit text as per suggestion.
> >
> > And yes, without this change, retention feature will not work properly.
> >
> > -Mukesh
>
> Does this commit text make sense? If so, I will update patch accordingly.
>
> When configuring capacity based allocation and power collapse retention, writing to the same register for each slice caused overwriting of the values for other slices, leading to misconfiguration for majority of the slices.
> To address this, only modify the bits associated with each slice while retaining the values of the remaining bits, as they were prior to the Linux configuration.

This commit text doesn't say what, if anything, is broken. Does it save
power when it didn't before? Why is it critical to backport this to
stable kernels? Was the driver overwriting other bits in this register
that were critical to power, performance, or correctness? Or was
everything working out because the last slice to be written was the only
important one?
