Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0377EC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346581AbjHPVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346601AbjHPVlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:41:17 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448DB2135
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:40:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d733844772eso41320276.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692222055; x=1692826855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma6f9Ok2+0t+XPGWJJlS+l++mI50erlQmhZRuRa/3Hk=;
        b=nHme26sKn+oiv7POtxC7pJqQ/5O4M79AK0MzXi3jo0W54gaAUNLO2jGr39PhK6jXa2
         NpF0rvrtHsXUmuL/gRCYXmQprNiHA+aMsKDYHjkpEYmbv48LheRguEKwPVokHpUTgJF1
         g8fuXRyztpND2PIBV5yjZgWccNpX36TriYUhwmb1dT9J3GHRlwNt10JvdBjiCzMWROd6
         skLlzwcpnHZw85SxgtEXJ/xhHTAB4qeNZCvhRLLraBDp6RIkPnC7jcmYAgufbUmrQzGm
         KisklsfbbMI8zHBr8j2sBUzUR7yVmcW74yRuBaJgWcqxlqNKGK1U/Zx3ZkcwvngfQY3i
         GfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692222055; x=1692826855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ma6f9Ok2+0t+XPGWJJlS+l++mI50erlQmhZRuRa/3Hk=;
        b=U2pK2KaPUfFc5UlslWam9ec/QywgxZNjq7NuRBdIUysvj79L1wqLjj2+BoGRL6SeX6
         PPAPLBA87kGLu5m4YdvV8d6Z96Zemc3LB3dftRGB6VS1FDISjk6CTvtdmSxj8NrqF7KB
         EESD93zMuAQS1w1fl8ZpWsXWIKJcPyEg162ERv2Z/yKzfVJFB+n0qaT1MsgGq4KYg255
         oel31FO07ZNa3dR47e8We0oSPX8YnRL4u9aUn4MUSYY9mpfxjLJOX7Eo3cDSJpAHycqw
         hoIBl/waSFuQPWdEwDCcUqYKJwPXhuYL1+77cRcR5SKO2RayS84BO+o4LMaywdN7H4yu
         AhQA==
X-Gm-Message-State: AOJu0Yzh6fsK8o634C2KGkFC/RKMJjSCO+KRVmzhvoqWi5QELwrsNbP9
        CwZKQ+b8y5Eh92Sotm194A8W1MT2Iiy911P6fVw4LQ==
X-Google-Smtp-Source: AGHT+IFQX2G9dQRnr7Qlmhd0VGdqhschoGcmIdkMaKSu7OPh0Yaf0YaCTTNuES0hSst5c7aUdsxZBhu1eFzAb4HKbxY=
X-Received: by 2002:a05:6902:1024:b0:d12:ab1:d88a with SMTP id
 x4-20020a056902102400b00d120ab1d88amr3980991ybt.40.1692222055464; Wed, 16 Aug
 2023 14:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230808202319.191434-1-limings@nvidia.com> <16047c7a-5bd1-868c-e6eb-e5f415e77fdd@intel.com>
 <CAPDyKFp28mmbRAGf14u8KTO3v7H=SFAYbwcz7xeb1m4tD_G2vQ@mail.gmail.com>
 <a2f6cd0e-8429-3468-9dcf-a5022717e2ae@intel.com> <CAPDyKFqTWMghEAsBdLUF+K4QNEWBozNi3_a7w0+KuuO3x+wkTQ@mail.gmail.com>
 <e561174e-a5cf-9503-f47a-d6c3fc7a1719@intel.com> <CAPDyKFrZawSORUG6wAJoCGFJABXvadivarNJ7_3V-ajeULLitw@mail.gmail.com>
 <BN9PR12MB50688191EFE9CBBD7D3A988AD315A@BN9PR12MB5068.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB50688191EFE9CBBD7D3A988AD315A@BN9PR12MB5068.namprd12.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Aug 2023 23:40:18 +0200
Message-ID: <CAPDyKFp8t-Yg8ABV4YU7LAsAULR_UoAps+COufJ_6hqRFGWxcg@mail.gmail.com>
Subject: Re: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > >>>>
> > > >>>> Since you are only using the runtime PM callbacks to turn off the card
> > > >>>> clock via SDHCI_CLOCK_CONTROL, pm_runtime_force_suspend() and
> > > >>>> pm_runtime_force_resume() are not needed at all.
> > > >>>
> > > >>> Right, it can be done without these too.
> > > >>>
> > > >>>>
> > > >>>> sdhci_suspend_host() does not care if SDHCI_CLOCK_CARD_EN is on or
> > off.
> > > >>>> (And you are disabling pltfm_host->clk and priv->bus_clk, so
> > presumably
> > > >>>> the result is no clock either way)
> > > >>>>
> > > >>>> sdhci_resume_host() does not restore state unless
> > > >>>> SDHCI_QUIRK2_HOST_OFF_CARD_ON is used, it just resets, so the
> > internal clock
> > > >>>> SDHCI_CLOCK_INT_EN is off which is consistent with either runtime
> > suspended
> > > >>>> or runtime resumed.
> > > >>>
> > > >>> Even if this may work, to me, it doesn't look like good practice for
> > > >>> how to use runtime PM in combination with system wide
> > suspend/resume.
> > > >>>
> > > >>> The point is, sdhci_suspend|resume_host() may end up reading/writing
> > > >>> to sdhci registers - and we should *not* allow that (because it may
> > > >>> not always work), unless the sdhci controller has been runtime resumed
> > > >>> first, right?
> > > >>
> > > >> I am OK with drivers that just want to use runtime PM to turn off a
> > > >> functional clock.  sdhci-tegra.c is also doing that although using the
> > > >> clock framework.
> > > >
> > > > Yes, I agree. At least this works for SoC specific drivers.
> > > >
> > > >>
> > > >> Certainly that approach assumes that the host controller's power state
> > > >> is not changed due to runtime PM.
> > > >>
> > > >> To ensure that the host controller is runtime resumed before calling
> > > >> sdhci_suspend_host(), we can just call pm_runtime_resume() I think.
> > > >
> > > > Yes, that was kind of what I proposed in the other thread as option 1)
> > > > (except for the replacement of pm_runtime_force_suspend|resume).
> > > >
> > > > Although, to be clear I would probably use pm_runtime_get_sync()
> > > > instead, to make sure the usage count is incremented too.
> > >
> > > In that case, a matching pm_runtime_put() is needed also at the
> > > end of the resume callback.
> >
> > Yes, of course. Or depending if we are using the force_suspend|resume
> > helper, a pm_runtime_put_noidle is sufficient after
> > pm_runtime_force_suspend() has been called.
>
> Thanks Ulf/Adrian! Plan to upload v8 with the following changes:
> - Remove pm_runtime_force_suspend/resume() from dwcmshc_suspend()/dwcmshc_resume() (Adrian's comment).
> - Add comments for dwcmshc_resume()/dwcmshc_suspend();
> (According to Andrian's comment).
> - Add pm_runtime_get_sync()/pm_runtime_put() in dwcmshc_suspend(), which is Ulf option-1.  Option-2 seems more efficient, but it involves more changes and I couldn't test the impact on other SoC. Maybe for future enhancement?

That works for me!

Kind regards
Uffe
