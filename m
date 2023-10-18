Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1B7CD8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjJRKF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:05:57 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91795;
        Wed, 18 Oct 2023 03:05:54 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7b64810aebdso1895558241.2;
        Wed, 18 Oct 2023 03:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697623553; x=1698228353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdlcSktSRSHArPajPsys/vHJvl4EcUiEhw2MBXd54bk=;
        b=eE56ymFoimrfqyR1lO4pc19NTSQC5YhxT8ZT+EtvpzA/LY6DvhteilVsJ1/m054R+H
         BlGssjFqy/jjnxvKfnp+nPcp17MZdbDKd8ZxKG7ONHlBzBcfYruUdbI2KZD9eK5gtWSD
         YTuMxa3VHllYOSbPW3iRrTAdirjURVelixoqhHOxD19qQ9TFUyx2wKemdvxKpI0X8oZm
         /QT7PXph0Y/ypLAlfWd/HmUIBiwhna1h2hJEEobDD1Uy40kX/fkyaIWReUbZmYsp2Wq6
         7iQLBUWRcLn4qg7OBhV5WeIxzlGEJOYTEb/rhrsOmE1PmDPsc4PMxbvNOMtijcEjEbFL
         88Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623553; x=1698228353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdlcSktSRSHArPajPsys/vHJvl4EcUiEhw2MBXd54bk=;
        b=KJlftjUVLQo45XXKw9Ji7sH35zgOA06Zw6/DtN3rEU1nfS/jaUCjaOnwrh415vbtWC
         jF3DECL7fhdUAQwGfbTzVLpg+lz921wEuMlHWNyIxkEg+KhNRmps2so3H4+orU9Pe4dk
         vz3IXkdCdDFzxl/PCCqg7zHWmKaBEMK3U3UTtnTGtGKS91nPCzr4o5GNHVPGmTrmVQiG
         Z9IqWvuQ9tAS4BhovMa6OM5FWTGSTqA6XmBzSSD4YVvzHqYNywsnexA/ppurlUQdi6U/
         hAbBglxI1cDVIf0U4zAKVqiza58pd5t6wvCVWDx69eo73dLSkCfRE5DUXOLWFpcYb2qU
         VRbw==
X-Gm-Message-State: AOJu0YyBpDoNg9B41KFm+ZQeRWInRxsS86aS+9Gt+/yoNowrwnuCKweC
        r9GrVbA/nrBlBI6vtg3sF3L+gEiXJyYdrzd5poo=
X-Google-Smtp-Source: AGHT+IH1IRh1BjMyOcfKeXHJ0ucJjHQ0asHDcuJoj3BNQnsUUOF885S8031nBwnqNNaWoj/jXqDPCOlNnqZ9o4Zlc4c=
X-Received: by 2002:a05:6102:2051:b0:457:c650:b810 with SMTP id
 q17-20020a056102205100b00457c650b810mr5179775vsr.8.1697623553137; Wed, 18 Oct
 2023 03:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
 <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
 <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
 <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com>
 <CAK00qKCXYg_JPUf=kCxLR1wmi=kmQ25X-ScQ7OYL1zpBKQAQkA@mail.gmail.com>
 <CAAd53p6_qQvp3EJgds_CAnHHSJLBQWc9TYyWpOzNaBZjyoDpeg@mail.gmail.com>
 <CAK00qKAhOnGzX8mAUADXDAjExHTQmyb5DyNkZoFht3Cn6bU1Aw@mail.gmail.com> <CAAd53p7YD4B9U6C+3RiW_mgMXnGTMNbVmgkAuge5U3ZXVL7FQQ@mail.gmail.com>
In-Reply-To: <CAAd53p7YD4B9U6C+3RiW_mgMXnGTMNbVmgkAuge5U3ZXVL7FQQ@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 18 Oct 2023 18:05:40 +0800
Message-ID: <CAK00qKBiGd0vt5VHEBq25fp_r0OZa7qiWGWdYM0-fiYBZmCDgw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 2:35=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Fri, Oct 6, 2023 at 6:30=E2=80=AFPM Victor Shih <victorshihgli@gmail.c=
om> wrote:
> >
> > On Mon, Oct 2, 2023 at 10:18=E2=80=AFAM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > Hi Victor,
> > >
> > > On Tue, Sep 26, 2023 at 4:21=E2=80=AFPM Victor Shih <victorshihgli@gm=
ail.com> wrote:
> > > >
> > > > On Fri, Sep 22, 2023 at 3:11=E2=80=AFPM Kai-Heng Feng
> > > > <kai.heng.feng@canonical.com> wrote:
> > > > >
> > > > > Hi Victor,
> > > > >
> > > > > On Wed, Sep 20, 2023 at 4:54=E2=80=AFPM Victor Shih <victorshihgl=
i@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
> > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > >
> > > > > > > Hi Victor,
> > > > > > >
> > > > > > > On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorsh=
ihgli@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > > > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Victor,
> > > > > > > > >
> > > > > > > > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <vict=
orshihgli@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > > > > > >
> > > > > > > > > > Due to a flaw in the hardware design, the GL975x replay=
 timer frequently
> > > > > > > > > > times out when ASPM is enabled. As a result, the system=
 will resume
> > > > > > > > > > immediately when it enters suspend. Therefore, the repl=
ay timer
> > > > > > > > > > timeout must be masked.
> > > > > > > > >
> > > > > > > > > This patch solves AER error when its PCI config gets acce=
ssed, but the
> > > > > > > > > AER still happens at system suspend:
> > > > > > > > >
> > > > > > > > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > > > > > > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > > > > > > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected erro=
r received:
> > > > > > > > > 0000:00:1c.0
> > > > > > > > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > > > > > > > severity=3DCorrected, type=3DData Link Layer, (Transmitte=
r ID)
> > > > > > > > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9=
] error
> > > > > > > > > status/mask=3D00001000/00002000
> > > > > > > > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > > > > > > > >
> > > > > > > > > Kai-Heng
> > > > > > > > >
> > > > > > > >
> > > > > > > > Hi, Kai-Heng
> > > > > > > >
> > > > > > > > Could you try applying the patch and re-testing again after=
 restarting
> > > > > > > > the system?
> > > > > > >
> > > > > > > Same issue happens after coldboot.
> > > > > > >
> > > > > > > > Because I applied the patch and restarted the system and it=
 didn't happen.
> > > > > > > > The system can enter suspend normally.
> > > > > > > >
> > > > > > > > If you still have the issue after following the above instr=
uctions,
> > > > > > > > please provide me with your environment and I will verify i=
t again.
> > > > > > >
> > > > > > > The patch gets applied on top of next-20230918. Please let me=
 know
> > > > > > > what else you want to know.
> > > > > > >
> > > > > > > Kai-Heng
> > > > > > >
> > > > > >
> > > > > > Hi, Kai-Heng
> > > > > >
> > > > > > If I want to mask the replay timer timeout AER of the upper lay=
er root port,
> > > > > > could you give me some suggestions?
> > > > > > Or could you provide sample code for my reference?
> > > > >
> > > > > I am not aware of anyway to mask "replay timer timeout" from root=
 port.
> > > > > I wonder if the device supoprt D3hot? Or should it stay at D0 whe=
n
> > > > > ASPM L1.2 is enabled?
> > > > >
> > > > > Kai-Heng
> > > > >
> > > >
> > > > Hi, Kai-Heng
> > > >
> > > > Do you know any way to mask the replay timer timeout AER of the
> > > > upstream port from the device?
> > >
> > > Per PCIe Spec, I don't think it's possible to only mask 'replay timer=
 timeout'.
> > >
> > > > The device supports D3hot.
> > >
> > > Do you think such error plays any crucial rule? Otherwise disable
> > > 'correctable' errors may be plausible.
> > >
> > > Kai-Heng
> > >
> >
> > Hi, Kai-Heng
> >
> > Due to a flaw in the hardware design, the GL975x replay timer frequentl=
y
> > times out when ASPM is enabled.
> > This patch solves the AER error of the replay timer timeout for GL975x.
> > We have not encountered any other errors so far.
>
> On the system I tested, this patch reduces the occurrence of the
> error, but not completely eliminated.
>
> > Does your 'correctable' errors mean the AER error of the replay timer t=
imeout?
> > May I ask if you have any other comments on this patch?
>
> Spamming `lspci -vv -s` on the device can still observe the AER error.
>
> I think the "correctable" mask should be optional, let me send a patch
> to PCI for comment.
>
> Kai-Heng
>

Hi, Kai-Heng

As we discussed in another email, if you want to solve the issue of suspens=
ion,
you only need masking the replay timer timeout on its root port.
I haven't seen the PCI patch you submitted yet.
If you provide me with the PCI patch, I can help you test it.

This patch only solves the warning messages that will often appear in
the system log
when the system accesses the GL975x PCI config.
Therefore, I will revise the commit message and submit the V2 version.

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
> > > > > > > > Thanks, Victor Shih
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.co=
m.tw>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > > > > > > > >  1 file changed, 16 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers=
/mmc/host/sdhci-pci-gli.c
> > > > > > > > > > index d83261e857a5..d8a991b349a8 100644
> > > > > > > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > > > > @@ -28,6 +28,9 @@
> > > > > > > > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > > > > > > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > > > > > > > >
> > > > > > > > > > +#define PCI_GLI_9750_CORRERR_MASK                     =
         0x214
> > > > > > > > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEO=
UT         BIT(12)
> > > > > > > > > > +
> > > > > > > > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > > > > > > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > > > > > > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > > > > > > > @@ -152,6 +155,9 @@
> > > > > > > > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > > > > > > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > > > > > > > >
> > > > > > > > > > +#define PCI_GLI_9755_CORRERR_MASK                     =
         0x214
> > > > > > > > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEO=
UT         BIT(12)
> > > > > > > > > > +
> > > > > > > > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                  =
 0x510
> > > > > > > > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET =
   BIT(8)
> > > > > > > > > >
> > > > > > > > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(stru=
ct sdhci_host *host)
> > > > > > > > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > > > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CT=
RL, value);
> > > > > > > > > >
> > > > > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRER=
R_MASK, &value);
> > > > > > > > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIM=
ER_TIMEOUT;
> > > > > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRE=
RR_MASK, value);
> > > > > > > > > > +
> > > > > > > > > >         gl9750_wt_off(host);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(stru=
ct sdhci_pci_slot *slot)
> > > > > > > > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > > > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CT=
RL, value);
> > > > > > > > > >
> > > > > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRER=
R_MASK, &value);
> > > > > > > > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIM=
ER_TIMEOUT;
> > > > > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRE=
RR_MASK, value);
> > > > > > > > > > +
> > > > > > > > > >         gl9755_wt_off(pdev);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > > > > >
