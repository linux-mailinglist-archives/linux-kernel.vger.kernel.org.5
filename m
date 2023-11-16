Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16017EDD61
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjKPJJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjKPJJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:09:03 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78042E5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:08:59 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5afa5dbc378so5998357b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700125738; x=1700730538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiMYfZ+A2iUQf2KOkcm1PZ8y14NGTAvuJT5UyKjiI+k=;
        b=V4nztDxL/TIIeGz5teRGcDNkB8gdv2o5er9FL3RSWHZdn1Adpb5Fjlo7vZpyNeZdva
         TBCpkb7/z7LG5ZVAjp0Ho7dXNn1fHXPwnOm9X13Eyb85t5vF6k1oghpvFAVVsZ04VNMO
         KQg6jkG5eWUz5Qqu+xppxDrU+T7t58NFl5cneNOqiYbxdu8nel3SxHzXQ3YdWV5QWXza
         U9n93gos9garvYxNgK3qZv199rxcUytURUj6QZpnGexn2SL5BBL7l8IRA2JcK+WYqf04
         zh1I51i+ed/xOi2Q642M8jQEBK4YwJEdjJt0tWDMtzZbaWH4B9k4TiyBHHamkhTwsiYo
         TgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125738; x=1700730538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiMYfZ+A2iUQf2KOkcm1PZ8y14NGTAvuJT5UyKjiI+k=;
        b=JApS/LuBXEFAJdvVfgUXRryVq7jtcqmoO0gVGFcgUuG2ADqUu4rAYO7/GHTLN1ew6W
         bdgsNJLRys0noA1hztxa4dqVJmkRA57Zuibfcrx30peXmJsd8WOJ/wetxv6vgu/t+x9V
         aooVHtd6+odC65gmB44QXJohatAUxbUxG5Tr3qu1iglDoVuw+tgle7Zbm5xP10GQFqo8
         A2gsDLT5rHWQnDsmilvWM3aBOFJ3FPOVGaSh7Zm0ZQZasYRuD0bWzRgjK8oLQdcjhgrh
         Died59nrDFd+nB+aC9Ab/YCxKzK5UsYGa6gY/lgh2GsiAlRJbF82ZdganQpUqHtamV8f
         onEw==
X-Gm-Message-State: AOJu0YyJdSenU50DnirsSJKiIpDLdN/b5r0AIgmzu6YgIyj3aeS5tw4Z
        RYmrTnI/fF/UbwNM9Nq5XCJ/JvNXItKzLktaNS0EUw==
X-Google-Smtp-Source: AGHT+IF6BBUkRdHTNI4kLc4++AIpEBe+uTcg0DjjGG/Wn2eQ+g10P4WlTdNo3niQqqPA2ZwbBUy7TUyzoVG6AbyLKEg=
X-Received: by 2002:a81:6d14:0:b0:592:1bab:52bd with SMTP id
 i20-20020a816d14000000b005921bab52bdmr13791072ywc.39.1700125738621; Thu, 16
 Nov 2023 01:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20231116051401.4112494-1-quic_rohiagar@quicinc.com>
 <20231116051401.4112494-2-quic_rohiagar@quicinc.com> <CAA8EJprzSFrb1qC-khPmTTac5o2ZX8azYBNPmT8DjyeNo3SAZA@mail.gmail.com>
 <6ba4d0a9-c370-4851-8631-4c8f952b44d9@quicinc.com>
In-Reply-To: <6ba4d0a9-c370-4851-8631-4c8f952b44d9@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Nov 2023 11:08:47 +0200
Message-ID: <CAA8EJprB=Jsiwb_K_9n3ypwDzns_2QBeBYO-o7PX-QPmhSHKBA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable GCC for SDX75
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, geert+renesas@glider.be,
        konrad.dybcio@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
        peng.fan@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 10:42, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>
>
> On 11/16/2023 10:56 AM, Dmitry Baryshkov wrote:
> > On Thu, 16 Nov 2023 at 07:14, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
> >> Enable Global Clock controller framework support for
> >> Qualcomm's SDX75 SoC.
> > Please add:
> >
> > ... which is used for this and that board and/or device.
> Sure will add something like this
> "Enable Global Clock controller framework support for
> Qualcomm's SDX75 SoC which is required to boot to console
> on sdx75-idp platform."
> Let me know if this doesnt look good.

Sounds good to me.

>
> Thanks,
> Rohit.
> >> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> >> ---
> >>   arch/arm64/configs/defconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >> index b60aa1f89343..d1be1efa8a23 100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -1252,6 +1252,7 @@ CONFIG_SDM_GPUCC_845=y
> >>   CONFIG_SDM_VIDEOCC_845=y
> >>   CONFIG_SDM_DISPCC_845=y
> >>   CONFIG_SDM_LPASSCC_845=m
> >> +CONFIG_SDX_GCC_75=y
> >>   CONFIG_SM_CAMCC_8250=m
> >>   CONFIG_SM_DISPCC_6115=m
> >>   CONFIG_SM_DISPCC_8250=y
> >> --
> >> 2.25.1
> >>
> >



-- 
With best wishes
Dmitry
