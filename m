Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB77A5A90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjISHKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjISHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:10:20 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB1100;
        Tue, 19 Sep 2023 00:10:13 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4526d872941so881002137.1;
        Tue, 19 Sep 2023 00:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695107413; x=1695712213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsdOtANdLKgirpqcXbxY/f816A3d1ngutR7psqK0OAQ=;
        b=NeRdSNorAbp++rug+GaiBVgRkzpbAMu89m1pK9azuGAS1vcvHa0MeHnymY0vzn0msJ
         ScHyoDvsUjuuBKlfKUP8IEGKag6amCPK9wafCfORvnreFvZc2nq1fn8GVfp4wpqPiI5y
         +qiqf3a++acRVJ2sjgB6IpXyzkk5aHZsEshokBYl9c3ST50JsRsFVuxUfLb3Uod56RWq
         ph5pQBAD4hr6xSB7J3G3iF8CKwq97mGlUNvgUTEQC4ZqqeRGrxDC1vIPJN3/eovudq9a
         WUUqUgffo/k2PCn+kXDqnUb/rnhVvKXj0UgAut9O7pz1zpcrzaa2defKMX97sF9xBGwg
         +svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695107413; x=1695712213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsdOtANdLKgirpqcXbxY/f816A3d1ngutR7psqK0OAQ=;
        b=B1xK1ZGhdltpLg+upnH925kmWbwF5karMqO2OEUEbQMfM2X3YpwHuZgsn9WA5CaGKy
         v2vittxqgaYWvUMsnOmtk6n0AljLaxKDxpa1Nt/zHcz9bvzhOREY/pVwkjWS5PF1V2vi
         O6Nt2acrIDqq7DJmcH44gAUHvn1+0M9Mx+DIRczPqCyHl1/ClpZn0F0/A1FshtcutG89
         95UzX6uTfxHicDnFdUfd/8Au7qCoPTdoOOg2blXH+L1Byz0RopayCdWsx3MZwGI2S+0Z
         KyJAJvVq5bN7sEBNk4bkQDkK65xmfSgxL4pJ53cJ8Mu74VWBFjx/RAX+cMGCE187I6+B
         b/ng==
X-Gm-Message-State: AOJu0YwGamJm+9KBoIC9KwVSXluK4oTOFbyIqW3RlfqcThzs4xOldK3I
        RquZksAR9ZOUjxkdbue+NBQtWH4jSM1Yy9rXD3w=
X-Google-Smtp-Source: AGHT+IHO3ZLJIvmjuoRlEb2a7rzwmjUq7whrADeTjzpIA4drZTgVnieFvUO8ivNffqkzmdai6BjyAv1riBSWra6V450=
X-Received: by 2002:a67:ce0d:0:b0:44d:626b:94da with SMTP id
 s13-20020a67ce0d000000b0044d626b94damr10005440vsl.32.1695107412821; Tue, 19
 Sep 2023 00:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com> <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
In-Reply-To: <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 19 Sep 2023 15:10:01 +0800
Message-ID: <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, kangzhen.lou@dell.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Victor,
>
> On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Due to a flaw in the hardware design, the GL975x replay timer frequentl=
y
> > times out when ASPM is enabled. As a result, the system will resume
> > immediately when it enters suspend. Therefore, the replay timer
> > timeout must be masked.
>
> This patch solves AER error when its PCI config gets accessed, but the
> AER still happens at system suspend:
>
> [ 1100.103603] ACPI: EC: interrupt blocked
> [ 1100.268244] ACPI: EC: interrupt unblocked
> [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error received:
> 0000:00:1c.0
> [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
> [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
> status/mask=3D00001000/00002000
> [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
>
> Kai-Heng
>

Hi, Kai-Heng

Could you try applying the patch and re-testing again after restarting
the system?
Because I applied the patch and restarted the system and it didn't happen.
The system can enter suspend normally.

If you still have the issue after following the above instructions,
please provide me with your environment and I will verify it again.

Thanks, Victor Shih

> >
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index d83261e857a5..d8a991b349a8 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -28,6 +28,9 @@
> >  #define PCI_GLI_9750_PM_CTRL   0xFC
> >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> >
> > +#define PCI_GLI_9750_CORRERR_MASK                              0x214
> > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(1=
2)
> > +
> >  #define SDHCI_GLI_9750_CFG2          0x848
> >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > @@ -152,6 +155,9 @@
> >  #define PCI_GLI_9755_PM_CTRL     0xFC
> >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> >
> > +#define PCI_GLI_9755_CORRERR_MASK                              0x214
> > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(1=
2)
> > +
> >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> >
> > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *h=
ost)
> >         value &=3D ~PCI_GLI_9750_PM_STATE;
> >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> >
> > +       /* mask the replay timer timeout of AER */
> > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
> > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
> > +
> >         gl9750_wt_off(host);
> >  }
> >
> > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slo=
t *slot)
> >         value &=3D ~PCI_GLI_9755_PM_STATE;
> >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> >
> > +       /* mask the replay timer timeout of AER */
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
> > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
> > +
> >         gl9755_wt_off(pdev);
> >  }
> >
> > --
> > 2.25.1
> >
