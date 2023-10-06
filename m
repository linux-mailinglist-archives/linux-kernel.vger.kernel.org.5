Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28CC7BB537
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjJFKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjJFKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:30:27 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40249E4;
        Fri,  6 Oct 2023 03:30:24 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49d0f24a815so782709e0c.2;
        Fri, 06 Oct 2023 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696588223; x=1697193023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blEZscFcgy/Pf7C3AmtaKvEya+48OGSVdWrJtz/KTDU=;
        b=eTXdDXxqVzzdSJy8ldk6eauPMFg5ahiXt8RNqsAwAYq7ZLgmDly1zGYB13mkeraGC4
         ETH88q1EcHoKax2omvC3eqV/iMVvBe6uVfCFLHxVr1m+Mwyt6s4I2OE09trgJT/qJHxa
         mWP32evSUdhnPqk72yUakRxARo+uBTr6F+OJaCweUlZa/OuGIggmAHd0n9lMJ5OZz3bW
         eIOO4PgrzpdxIU/CWuejhCxVVMuNDzZRxnU4MIU67bkvuv57yzd3eHut2ZfWEQPuOz/R
         uJGm8Jmag7TwIh54GGWDzWlWESO4uDtlZzCeha0UKzN2Di6BELaaI/dLhNgE2xZIEYeb
         O9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696588223; x=1697193023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blEZscFcgy/Pf7C3AmtaKvEya+48OGSVdWrJtz/KTDU=;
        b=DVJ2HTCuoVO8vQIdW+EHevSz5uTN2b2MYrzqEIW/Ey/KKx1Ed9ZGiJ4VxE6wwPa2DZ
         stx7iqru1zVpATBidOw0DeHM/upYfQEMeqvkTG+mAucS8KPSvRMsBi3bFIhMHho6gAd9
         WC57q3RAVPrp8k03ekMvEt7L9Xzs1dXMSCTTwTU0eucNDGgrdbD6oFKn6AVy8KnOwZ2I
         ELROI6Cv8fE6q8KaCXqia7xPlqbjxblPwD3K/gM6wH4GZbzmPbgc4umHxSbAJ8Y0wJxJ
         XR71NthSZnCOFZx6obRnVwiPxVptXuJZ3wzvFXhsKmVjTMGoyoflNegrqDLqsyY/iP9H
         SpUQ==
X-Gm-Message-State: AOJu0YwP/dHohQAUZg6nxK0BfZnMAZt7835HnSmO4LZNuuMLCL+M6EAy
        HdXRNayWB1M5HHdR+lccL73eWjQzpubaHaZY+8M=
X-Google-Smtp-Source: AGHT+IEc9SH8+bqTt7/mMwGK+N32gBqkbR0vxkfp3Kvpo0QjZwZ+hqdzk5+siE4OPjbbUi+gn+Bb0GAnr/NEVg5IO58=
X-Received: by 2002:a1f:4887:0:b0:493:3491:ce89 with SMTP id
 v129-20020a1f4887000000b004933491ce89mr5920840vka.14.1696588223186; Fri, 06
 Oct 2023 03:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
 <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
 <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
 <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com>
 <CAK00qKCXYg_JPUf=kCxLR1wmi=kmQ25X-ScQ7OYL1zpBKQAQkA@mail.gmail.com> <CAAd53p6_qQvp3EJgds_CAnHHSJLBQWc9TYyWpOzNaBZjyoDpeg@mail.gmail.com>
In-Reply-To: <CAAd53p6_qQvp3EJgds_CAnHHSJLBQWc9TYyWpOzNaBZjyoDpeg@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 6 Oct 2023 18:30:08 +0800
Message-ID: <CAK00qKAhOnGzX8mAUADXDAjExHTQmyb5DyNkZoFht3Cn6bU1Aw@mail.gmail.com>
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

On Mon, Oct 2, 2023 at 10:18=E2=80=AFAM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Victor,
>
> On Tue, Sep 26, 2023 at 4:21=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > On Fri, Sep 22, 2023 at 3:11=E2=80=AFPM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > Hi Victor,
> > >
> > > On Wed, Sep 20, 2023 at 4:54=E2=80=AFPM Victor Shih <victorshihgli@gm=
ail.com> wrote:
> > > >
> > > > On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
> > > > <kai.heng.feng@canonical.com> wrote:
> > > > >
> > > > > Hi Victor,
> > > > >
> > > > > On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshihgl=
i@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > >
> > > > > > > Hi Victor,
> > > > > > >
> > > > > > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorsh=
ihgli@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > > > >
> > > > > > > > Due to a flaw in the hardware design, the GL975x replay tim=
er frequently
> > > > > > > > times out when ASPM is enabled. As a result, the system wil=
l resume
> > > > > > > > immediately when it enters suspend. Therefore, the replay t=
imer
> > > > > > > > timeout must be masked.
> > > > > > >
> > > > > > > This patch solves AER error when its PCI config gets accessed=
, but the
> > > > > > > AER still happens at system suspend:
> > > > > > >
> > > > > > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > > > > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > > > > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error re=
ceived:
> > > > > > > 0000:00:1c.0
> > > > > > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > > > > > severity=3DCorrected, type=3DData Link Layer, (Transmitter ID=
)
> > > > > > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] er=
ror
> > > > > > > status/mask=3D00001000/00002000
> > > > > > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > > > > > >
> > > > > > > Kai-Heng
> > > > > > >
> > > > > >
> > > > > > Hi, Kai-Heng
> > > > > >
> > > > > > Could you try applying the patch and re-testing again after res=
tarting
> > > > > > the system?
> > > > >
> > > > > Same issue happens after coldboot.
> > > > >
> > > > > > Because I applied the patch and restarted the system and it did=
n't happen.
> > > > > > The system can enter suspend normally.
> > > > > >
> > > > > > If you still have the issue after following the above instructi=
ons,
> > > > > > please provide me with your environment and I will verify it ag=
ain.
> > > > >
> > > > > The patch gets applied on top of next-20230918. Please let me kno=
w
> > > > > what else you want to know.
> > > > >
> > > > > Kai-Heng
> > > > >
> > > >
> > > > Hi, Kai-Heng
> > > >
> > > > If I want to mask the replay timer timeout AER of the upper layer r=
oot port,
> > > > could you give me some suggestions?
> > > > Or could you provide sample code for my reference?
> > >
> > > I am not aware of anyway to mask "replay timer timeout" from root por=
t.
> > > I wonder if the device supoprt D3hot? Or should it stay at D0 when
> > > ASPM L1.2 is enabled?
> > >
> > > Kai-Heng
> > >
> >
> > Hi, Kai-Heng
> >
> > Do you know any way to mask the replay timer timeout AER of the
> > upstream port from the device?
>
> Per PCIe Spec, I don't think it's possible to only mask 'replay timer tim=
eout'.
>
> > The device supports D3hot.
>
> Do you think such error plays any crucial rule? Otherwise disable
> 'correctable' errors may be plausible.
>
> Kai-Heng
>

Hi, Kai-Heng

Due to a flaw in the hardware design, the GL975x replay timer frequently
times out when ASPM is enabled.
This patch solves the AER error of the replay timer timeout for GL975x.
We have not encountered any other errors so far.
Does your 'correctable' errors mean the AER error of the replay timer timeo=
ut?
May I ask if you have any other comments on this patch?

Thanks, Victor Shih

> >
> > Thanks, Victor Shih
> >
> > > >
> > > > Thanks, Victor Shih
> > > >
> > > > > >
> > > > > > Thanks, Victor Shih
> > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw=
>
> > > > > > > > ---
> > > > > > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > > > > > >  1 file changed, 16 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc=
/host/sdhci-pci-gli.c
> > > > > > > > index d83261e857a5..d8a991b349a8 100644
> > > > > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > > @@ -28,6 +28,9 @@
> > > > > > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > > > > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > > > > > >
> > > > > > > > +#define PCI_GLI_9750_CORRERR_MASK                         =
     0x214
> > > > > > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT  =
       BIT(12)
> > > > > > > > +
> > > > > > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > > > > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > > > > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > > > > > @@ -152,6 +155,9 @@
> > > > > > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > > > > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > > > > > >
> > > > > > > > +#define PCI_GLI_9755_CORRERR_MASK                         =
     0x214
> > > > > > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT  =
       BIT(12)
> > > > > > > > +
> > > > > > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x5=
10
> > > > > > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    B=
IT(8)
> > > > > > > >
> > > > > > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct s=
dhci_host *host)
> > > > > > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, =
value);
> > > > > > > >
> > > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MA=
SK, &value);
> > > > > > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_T=
IMEOUT;
> > > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_M=
ASK, value);
> > > > > > > > +
> > > > > > > >         gl9750_wt_off(host);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct s=
dhci_pci_slot *slot)
> > > > > > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, =
value);
> > > > > > > >
> > > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MA=
SK, &value);
> > > > > > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_T=
IMEOUT;
> > > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_M=
ASK, value);
> > > > > > > > +
> > > > > > > >         gl9755_wt_off(pdev);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > > >
