Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3478A98D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjH1KDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjH1KDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:03:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15EBF0;
        Mon, 28 Aug 2023 03:03:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a529e1974so2011267b3a.3;
        Mon, 28 Aug 2023 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693217013; x=1693821813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+m7qhg+0nv62qiTjlTeUn/Y1rJMp/EuMcHg0FMMCKo=;
        b=P4mqpjKl7ddIZv4B4GvRLFlnEUBjYFBAxRFX3YSjBA+szFSurQnGVGc9USRMRIsMMK
         2fw8lyEcxdVMlfpkFTQf2fHhov+Jsew8zlmsMrz7mhQQQCiOhCdNJb92VmLcEyDsWKKr
         yhtl1tIrXdFNW0mZLcogBHSbDvoY3hVMoq2ZRzbivxje5mm7weSh5NdmW14cSos/2qLd
         Oj+2H0dOa5i3f33jvZ5jmLpJtrE3QiuLYky/Jrn8TZg3vYeB4DLo/TeZHD/3UQDl8w0v
         806Hh9nSJFCtInoD4urt8iLM8pkhRLql2X5ot5zQdBEFNcLKfe8wdhcsJRgVhBo+TKx8
         W1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217013; x=1693821813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+m7qhg+0nv62qiTjlTeUn/Y1rJMp/EuMcHg0FMMCKo=;
        b=IfCqJDa7jcFId6fQvN9Q3VbmUnatfe6YADlxvZ2jhWagX9vpLtINmGFGPkUhiTDOcg
         ONAop/Wz/ow3O2mAOzD5ng5ryGS5iqGpOdk2KFvWxxuQ3v6ioAbUKAuCDIrH7ge5mCmU
         aCC54zWJSVEHorQN1jsr01IzkBjBJpA3tphoR9j0V5gIwhhASxEoK4B9FB8MtmSZ7aAh
         bWJDPpSb05igktBeQ/sMWhdgZTYpoJK84jtc6xTihWKCYglcKEDSSwYx/ybRcnA3h9qC
         ieO1aAR/8NUetg9O27i5LdSgrju5jYk6EoKRgKuhFRGv/wXuiSQbQKlk/D3JzDtQ0sWv
         KUpg==
X-Gm-Message-State: AOJu0YzkRn5oFBcfUAttsa+8y5ldqLESSrRj3oebh1YHEBVfL9/pIX7W
        f7UdHktBlOh2Eb6ZxrZdPm4=
X-Google-Smtp-Source: AGHT+IFjtOlQkYt6SCf2U54F86EY8PkQSVTSqwtAOyFJOBG7hg69Gw4DyrnSq8XN86YnGpyOo6vC8Q==
X-Received: by 2002:a05:6a20:729b:b0:140:a6ec:b55e with SMTP id o27-20020a056a20729b00b00140a6ecb55emr24031643pzk.3.1693217013085;
        Mon, 28 Aug 2023 03:03:33 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id q9-20020a63ae09000000b005579f12a238sm6973165pgf.86.2023.08.28.03.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 03:03:32 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com
Cc:     SeanHY.chen@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, reniuschengl@gmail.com,
        skardach@google.com, stable@vger.kernel.org, svenva@chromium.org,
        ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw,
        benchuanggli@gmail.com, victorshihgli@gmail.com
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend
Date:   Mon, 28 Aug 2023 18:02:49 +0800
Message-ID: <20230828100313.3051403-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/08/23 20:18, Adrian Hunter wrote:
> On 24/08/23 14:50, Stanisław Kardach wrote:
> > Hi Adrian,
> > 
> > Thanks for reviewing our patches.
> > 
> > On Thu, Aug 24, 2023 at 1:47 PM Adrian Hunter <adrian.hunter@intel.com <mailto:adrian.hunter@intel.com>> wrote:
> > 
> >     Hi
> > 
> >     Looks OK - a few minor comments below
> > 
> >     On 23/08/23 20:41, Sven van Ashbrook wrote:
> >     > To improve the r/w performance of GL9763E, the current driver inhibits LPM
> >     > negotiation while the device is active.
> >     >
> >     > This prevents a large number of SoCs from suspending, notably x86 systems
> > 
> >     If possible, can you give example of which SoCs / products
> > 
> >     > which use S0ix as the suspend mechanism:
> >     > 1. Userspace initiates s2idle suspend (e.g. via writing to
> >     >    /sys/power/state)
> >     > 2. This switches the runtime_pm device state to active, which disables
> >     >    LPM negotiation, then calls the "regular" suspend callback
> >     > 3. With LPM negotiation disabled, the bus cannot enter low-power state
> >     > 4. On a large number of SoCs, if the bus not in a low-power state, S0ix
> >     >    cannot be entered, which in turn prevents the SoC from entering
> >     >    suspend.
> >     >
> >     > Fix by re-enabling LPM negotiation in the device's suspend callback.
> >     >
> >     > Suggested-by: Stanislaw Kardach <skardach@google.com <mailto:skardach@google.com>>
> >     > Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
> >     > Cc: stable@vger.kernel.org <mailto:stable@vger.kernel.org>
> >     > Signed-off-by: Sven van Ashbrook <svenva@chromium.org <mailto:svenva@chromium.org>>
> >     >      # on gladios device
> >     >      # on 15590.0.0 with v5.10 and upstream (v6.4) kernels
> >     >
> > 
> >     3 extraneous lines here - please remove
> > 
> >     > ---
> >     >
> >     > Changes in v2:
> >     > - improved symmetry and error path in s2idle suspend callback (internal review)
> >     >
> >     >  drivers/mmc/host/sdhci-pci-gli.c | 102 +++++++++++++++++++------------
> >     >  1 file changed, 64 insertions(+), 38 deletions(-)
> >     >
> >     > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> >     > index 1792665c9494a..19f577cc8bceb 100644
> >     > --- a/drivers/mmc/host/sdhci-pci-gli.c
> >     > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> >     > @@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> >     >       return value;
> >     >  }
> >     > 
> >     > -#ifdef CONFIG_PM_SLEEP
> >     > -static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> >     > -{
> >     > -     struct sdhci_pci_slot *slot = chip->slots[0];
> >     > -
> >     > -     pci_free_irq_vectors(slot->chip->pdev);
> >     > -     gli_pcie_enable_msi(slot);
> >     > -
> >     > -     return sdhci_pci_resume_host(chip);
> >     > -}
> >     > -
> >     > -static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> >     > -{
> >     > -     struct sdhci_pci_slot *slot = chip->slots[0];
> >     > -     int ret;
> >     > -
> >     > -     ret = sdhci_pci_gli_resume(chip);
> >     > -     if (ret)
> >     > -             return ret;
> >     > -
> >     > -     return cqhci_resume(slot->host->mmc);
> >     > -}
> >     > -
> >     > -static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
> >     > -{
> >     > -     struct sdhci_pci_slot *slot = chip->slots[0];
> >     > -     int ret;
> >     > -
> >     > -     ret = cqhci_suspend(slot->host->mmc);
> >     > -     if (ret)
> >     > -             return ret;
> >     > -
> >     > -     return sdhci_suspend_host(slot->host);
> >     > -}
> >     > -#endif
> >     > -
> >     >  static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
> >     >                                         struct mmc_ios *ios)
> >     >  {
> >     > @@ -1029,6 +993,68 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> >     >  }
> >     >  #endif
> >     > 
> >     > +#ifdef CONFIG_PM_SLEEP
> >     > +static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> >     > +{
> >     > +     struct sdhci_pci_slot *slot = chip->slots[0];
> >     > +
> >     > +     pci_free_irq_vectors(slot->chip->pdev);
> >     > +     gli_pcie_enable_msi(slot);
> >     > +
> >     > +     return sdhci_pci_resume_host(chip);
> >     > +}

sdhci_pci_gli_resume() is the same as before. Is there any reason to move it here?

> >     > +
> >     > +static int gl9763e_resume(struct sdhci_pci_chip *chip)
> >     > +{
> >     > +     struct sdhci_pci_slot *slot = chip->slots[0];
> >     > +     int ret;
> >     > +
> >     > +     ret = sdhci_pci_gli_resume(chip);
> >     > +     if (ret)
> >     > +             return ret;
> >     > +
> >     > +     ret = cqhci_resume(slot->host->mmc);
> >     > +     if (ret)
> >     > +             return ret;
> >     > +
> >     > +     /* Disable LPM negotiation to bring device back in sync
> >     > +      * with its runtime_pm state.
> >     > +      */
> > 
> >     I would prefer the comment style:
> > 
> >             /*
> >              * Blah, blah ...
> >              * Blah, blah, blah.
> >              */
> > 
> >     > +     gl9763e_set_low_power_negotiation(slot, false);

There is a situation for your reference.
If `allow_runtime_pm' is set to false and the system resumes from suspend, GL9763E 
LPM negotiation will be always disabled on S0. GL9763E will stay L0 and never 
enter L1 because GL9763E LPM negotiation is disabled.

This patch enables allow_runtime_pm. The simple flow is
gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled -> (a)
(a) -+--> idle -->  gl9763e_runtime_suspend() -> LPM enabled
     |
     +--> no idle -> gl9763e_runtime_resume() -> LPM disabled

This patch disables allow_runtime_pm. The simple flow is
gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled (no runtime_pm)

Although that may not be the case with the current configuration, it's only a
possibility.

> >     > +
> >     > +     return 0;
> >     > +}
> >     > +
> >     > +static int gl9763e_suspend(struct sdhci_pci_chip *chip)
> >     > +{
> >     > +     struct sdhci_pci_slot *slot = chip->slots[0];
> >     > +     int ret;
> >     > +
> >     > +     /* Certain SoCs can suspend only with the bus in low-
> > 
> >     Ditto re comment style
> > 
> >     > +      * power state, notably x86 SoCs when using S0ix.
> >     > +      * Re-enable LPM negotiation to allow entering L1 state
> >     > +      * and entering system suspend.
> >     > +      */
> >     > +     gl9763e_set_low_power_negotiation(slot, true);
> > 
> >     Couldn't this be at the end of the function, save
> >     an error path
> > 
> > Please correct me if I'm wrong but writing to device config
> > space could trigger a side effect, so it's probably better to
> > do it before calling functions suspending the device?
> 
> sdhci doesn't know anything about the bus.  It is independent
> of PCI, so I can't see how it would make any difference.
> One of the people cc'ed might know more.  Jason Lai (cc'ed)
> added it for runtime PM.
>

As far as I know, when disabling LPM negotiation, the GL9763E will stop entering
L1. It doesn't other side effect. Does Jason.Lai and Victor.Shih have any comments
or suggestions?

Best regards,
Ben Chuang

> > 
> > 
> >     > +
> >     > +     ret = cqhci_suspend(slot->host->mmc);
> >     > +     if (ret)
> >     > +             goto err_suspend;
> >     > +
> >     > +     ret = sdhci_suspend_host(slot->host);
> >     > +     if (ret)
> >     > +             goto err_suspend_host;
> >     > +
> >     > +     return 0;
> >     > +
> >     > +err_suspend_host:
> >     > +     cqhci_resume(slot->host->mmc);
> >     > +err_suspend:
> >     > +     gl9763e_set_low_power_negotiation(slot, false);
> >     > +     return ret;
> >     > +}
> >     > +#endif
> >     > +
> >     >  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
> >     >  {
> >     >       struct pci_dev *pdev = slot->chip->pdev;
> >     > @@ -1113,8 +1139,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
> >     >       .probe_slot     = gli_probe_slot_gl9763e,
> >     >       .ops            = &sdhci_gl9763e_ops,
> >     >  #ifdef CONFIG_PM_SLEEP
> >     > -     .resume         = sdhci_cqhci_gli_resume,
> >     > -     .suspend        = sdhci_cqhci_gli_suspend,
> >     > +     .resume         = gl9763e_resume,
> >     > +     .suspend        = gl9763e_suspend,
> >     >  #endif
> >     >  #ifdef CONFIG_PM
> >     >       .runtime_suspend = gl9763e_runtime_suspend,
> > 
> > 
> > 
> > -- 
> > Best Regards,
> > Stanisław Kardach
> 
> 
