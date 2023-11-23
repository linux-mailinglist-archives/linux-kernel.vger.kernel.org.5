Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7B7F63B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjKWQOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKWQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:14:31 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C1019E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:14:37 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5ac376d311aso10106377b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700756077; x=1701360877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ipzMNGrGtolaTuN+LIIgKEncct0aftDF2s8V+J8A68E=;
        b=TB1au32u8m8eCO3UzV/gibdFPsdh5WsVOoeM3EqADr21c22opVoMNQkCvOooM127Wl
         G2PJ0otm4EnQfy67H383gMAr32cNWvbLl/3MRk4APIVR1FMIIHaW1kFVbtM/ZcUXv/ly
         h9SYLETXEGUx6WsYR0JhLnky5U+FlS1h6cyS6bEHtoQGxrqPxukBk44oWX59lQw1Bt7I
         nrnZ++FSyM8TCdYoM3u0bBFrekieYqQ7RlbejqgHKprziT3+EBV5YAecmZndOhXeZu1m
         xxMRujogWdPBWjC9Zjjale10DjBU9NtADu1hE39BWJkrOc/ioNJsXoEQ4wWbXu0lp/C6
         Y4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756077; x=1701360877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipzMNGrGtolaTuN+LIIgKEncct0aftDF2s8V+J8A68E=;
        b=k7DquqHuR9zxD0x4zfxQhZW33ZbxD6mmvLCDJrve0Y2SCCHHvurJYLqPtS5eUGiEel
         hZbL9/wAbjgGXNGNhnkt2pTHcq8HZDy2J6tXV5AIJeinWAo+aP7ods4qo5bzMXBrdPAv
         BQ6Md5Q1u7kae+L5WixJgKRobnvKhT7C4mPZP854MFLxAvNb2lz8PxnwU/KFoMthIERc
         HFG/zG90sJG7/AOt4TAzynLrtJyXz7niAaEh5Dj1bzE/gGQ8nxGxskU3MQPOJt7O5b0Z
         6parilBSukMPMDOCe8bAYeTQ7fgB3XQqGsP6Fp39XPinemUpdE/IBfO9PdLvlkRxdrF6
         OVTA==
X-Gm-Message-State: AOJu0YyKsoPU6Yxpqg8k71gZLHf2M0MHS29msYpf4uxGSF6UgJ5x4fut
        6cspkh000QdXSdv/n3zxDD9IoF4LBPu91vh+Umy50g==
X-Google-Smtp-Source: AGHT+IGVXCCNObF5Fssf2rOst5kdMHeHaWlMqNi98aNmC9WRf3QJ62k48s/V/HjbQ+uLlCBO8r4oX3qbTumAUwJj8zw=
X-Received: by 2002:a05:690c:2891:b0:5cd:6004:3549 with SMTP id
 ee17-20020a05690c289100b005cd60043549mr1455172ywb.27.1700756076780; Thu, 23
 Nov 2023 08:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com> <20231123073901.meb7p4yzueg2lkou@vireshk-i7>
In-Reply-To: <20231123073901.meb7p4yzueg2lkou@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Nov 2023 17:14:00 +0100
Message-ID: <CAPDyKFrst+j89nPsrfAmkzGBLAwZ86WWQ_agnd6MHCfR+7FeFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] cpufreq: qcom-nvmem: Fix power domain scaling
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 08:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-11-23, 11:07, Stephan Gerhold wrote:
> > The power domain scaling setup for QCS404 and MSM8909 in
> > cpufreq-com-nvmem does not work correctly at the moment because the
> > genpd core ignores all the performance state votes that are specified in
> > the CPU OPP table. This happens because nothing in the driver makes the
> > genpd core aware that the power domains are actively being consumed by
> > the CPU.
> >
> > Fix this by marking the devices as runtime active. Also mark the devices
> > to be in the "awake path" during system suspend so that performance
> > state votes necessary for the CPU are preserved during system suspend.
> >
> > While all the patches in this series are needed for full functionality,
> > the cpufreq and pmdomain patches can be merged independently. There is
> > no compile-time dependency between those two.
> >
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> > Changes in v3:
> > - Drop patches with MSM8909 definitions that were applied already
> > - Add extra patch to fix system suspend properly by using
> >   device_set_awake_path() instead of dev_pm_syscore_device()
> > - Set GENPD_FLAG_ACTIVE_WAKEUP for rpmpd so that performance state votes
> >   needed by the CPU are preserved during suspend
> > - Link to v2: https://lore.kernel.org/r/20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com
>
> Applied. Thanks.
>
> I picked the pmdomain patch too, lemme know if that needs to go via
> some other tree.

Usually I should pick the pmdomain patches. Although, I thought it may
be better to keep this series together.

Assuming you are going to send these as fixes for 6.7-rc[n]? In that
case, I can just rebase my tree on a later rc if I find any problems.

Kind regards
Uffe
