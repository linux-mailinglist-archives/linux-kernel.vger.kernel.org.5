Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9A47C4AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345394AbjJKGfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbjJKGe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:34:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA6B93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:34:55 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 31D8E3FA61
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697006094;
        bh=UMKdS5SnMMrOpMCMYwNeeTyyHh/lJY0Na/By5DR8NHA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=b03eStwIJcqi1Xf8ILBpbB39B0rdxihuf/VGj0tT+Z8PrMRbVq0irtq5e8gNfT0cj
         mjhhtodKloEcJU4ofFMB8g26NHBns/r2S9NrPsu+0LMkugwKmrsPuhX82qF/ymZNsA
         gTm7fX9Fu+xzWiAVSVXNnWnRN9Bjlk0Lp6XPshQ/9WXvhL6bRwihBGZWxg3aA12Jtd
         25I7eoxs0ty4ps0Ej2rG6IH+r/fn105Q5KhAWlnRmkT/nY4HsljbhsxBW8g2tg2Ylg
         dK5neRDf5V41f0nph/Mi+iOMcGKU4oouA/R9O7trzJzsHM3L2YLhSyDEHuA0JTtNDD
         dG9jfwE/GfE0A==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-27cefad6c6fso1218663a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006092; x=1697610892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMKdS5SnMMrOpMCMYwNeeTyyHh/lJY0Na/By5DR8NHA=;
        b=BR88jh+g+jjlixEmMDO+/Vg5+ca0bnEq50ADMz4CaFJT+rA+s1WbS7TG9yL+a6Z3Pg
         zoo7cdrgnCbB+srjmDwwWsEqtF/WNf0uWbd6d4RkGOXEf/rkMNSw65DmflBXpVa3sp/k
         DIZhL55af0YY7B2Kx24u9qEzZMQUs8Fe/k9Or9Eii6l7jZeHeKFdYyxG5le67GNvcBM1
         UZRfG8wjMLZcNa4JYj3mIEUoe6PUfw127qk5QFwUaLSF21/h0PQSuJsile9/uvOIH/Yr
         iJWtRJvsKr7XrxzQmNMOcn+iY9psRolZuXiWfPrKGWax+RkUP6cTjSnazwCaB8CN7enN
         t/tw==
X-Gm-Message-State: AOJu0Yz9wUelYvnRmC9GKNYuFuIf4PrPIFmIfWuTvRFpmuadT+WNehDB
        rOzkYDz2MD4yeN7dWUgCMCv9W6AIgs2UcEHZ6UBKme+ixqBDcmued9n/doFNyyfXm7IDSa7cKHa
        kEWFsoUIdwr0KKp99EDRvT8RRwVHoDHXaGPaGxWzmF5Bt4eM4VOgt0i5+mg==
X-Received: by 2002:a17:90b:207:b0:263:ebab:a152 with SMTP id fy7-20020a17090b020700b00263ebaba152mr17455684pjb.19.1697006092273;
        Tue, 10 Oct 2023 23:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Jg8p5JoarrZc0SP0VmvntkNCM4Bi6vD3Oq1kx7GyQ/FZG+mqRHFLHLMNSUEcC96PyTkWuiVj2mriWrNmD5c=
X-Received: by 2002:a17:90b:207:b0:263:ebab:a152 with SMTP id
 fy7-20020a17090b020700b00263ebaba152mr17455674pjb.19.1697006091933; Tue, 10
 Oct 2023 23:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
 <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
 <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
 <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com>
 <CAK00qKCXYg_JPUf=kCxLR1wmi=kmQ25X-ScQ7OYL1zpBKQAQkA@mail.gmail.com>
 <CAAd53p6_qQvp3EJgds_CAnHHSJLBQWc9TYyWpOzNaBZjyoDpeg@mail.gmail.com> <CAK00qKAhOnGzX8mAUADXDAjExHTQmyb5DyNkZoFht3Cn6bU1Aw@mail.gmail.com>
In-Reply-To: <CAK00qKAhOnGzX8mAUADXDAjExHTQmyb5DyNkZoFht3Cn6bU1Aw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 11 Oct 2023 14:34:39 +0800
Message-ID: <CAAd53p7YD4B9U6C+3RiW_mgMXnGTMNbVmgkAuge5U3ZXVL7FQQ@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, kangzhen.lou@dell.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 6:30=E2=80=AFPM Victor Shih <victorshihgli@gmail.com=
> wrote:
>
> On Mon, Oct 2, 2023 at 10:18=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Hi Victor,
> >
> > On Tue, Sep 26, 2023 at 4:21=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> > >
> > > On Fri, Sep 22, 2023 at 3:11=E2=80=AFPM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > Hi Victor,
> > > >
> > > > On Wed, Sep 20, 2023 at 4:54=E2=80=AFPM Victor Shih <victorshihgli@=
gmail.com> wrote:
> > > > >
> > > > > On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
> > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > >
> > > > > > Hi Victor,
> > > > > >
> > > > > > On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshih=
gli@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > > >
> > > > > > > > Hi Victor,
> > > > > > > >
> > > > > > > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victor=
shihgli@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > > > > >
> > > > > > > > > Due to a flaw in the hardware design, the GL975x replay t=
imer frequently
> > > > > > > > > times out when ASPM is enabled. As a result, the system w=
ill resume
> > > > > > > > > immediately when it enters suspend. Therefore, the replay=
 timer
> > > > > > > > > timeout must be masked.
> > > > > > > >
> > > > > > > > This patch solves AER error when its PCI config gets access=
ed, but the
> > > > > > > > AER still happens at system suspend:
> > > > > > > >
> > > > > > > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > > > > > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > > > > > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error =
received:
> > > > > > > > 0000:00:1c.0
> > > > > > > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > > > > > > severity=3DCorrected, type=3DData Link Layer, (Transmitter =
ID)
> > > > > > > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] =
error
> > > > > > > > status/mask=3D00001000/00002000
> > > > > > > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > > > > > > >
> > > > > > > > Kai-Heng
> > > > > > > >
> > > > > > >
> > > > > > > Hi, Kai-Heng
> > > > > > >
> > > > > > > Could you try applying the patch and re-testing again after r=
estarting
> > > > > > > the system?
> > > > > >
> > > > > > Same issue happens after coldboot.
> > > > > >
> > > > > > > Because I applied the patch and restarted the system and it d=
idn't happen.
> > > > > > > The system can enter suspend normally.
> > > > > > >
> > > > > > > If you still have the issue after following the above instruc=
tions,
> > > > > > > please provide me with your environment and I will verify it =
again.
> > > > > >
> > > > > > The patch gets applied on top of next-20230918. Please let me k=
now
> > > > > > what else you want to know.
> > > > > >
> > > > > > Kai-Heng
> > > > > >
> > > > >
> > > > > Hi, Kai-Heng
> > > > >
> > > > > If I want to mask the replay timer timeout AER of the upper layer=
 root port,
> > > > > could you give me some suggestions?
> > > > > Or could you provide sample code for my reference?
> > > >
> > > > I am not aware of anyway to mask "replay timer timeout" from root p=
ort.
> > > > I wonder if the device supoprt D3hot? Or should it stay at D0 when
> > > > ASPM L1.2 is enabled?
> > > >
> > > > Kai-Heng
> > > >
> > >
> > > Hi, Kai-Heng
> > >
> > > Do you know any way to mask the replay timer timeout AER of the
> > > upstream port from the device?
> >
> > Per PCIe Spec, I don't think it's possible to only mask 'replay timer t=
imeout'.
> >
> > > The device supports D3hot.
> >
> > Do you think such error plays any crucial rule? Otherwise disable
> > 'correctable' errors may be plausible.
> >
> > Kai-Heng
> >
>
> Hi, Kai-Heng
>
> Due to a flaw in the hardware design, the GL975x replay timer frequently
> times out when ASPM is enabled.
> This patch solves the AER error of the replay timer timeout for GL975x.
> We have not encountered any other errors so far.

On the system I tested, this patch reduces the occurrence of the
error, but not completely eliminated.

> Does your 'correctable' errors mean the AER error of the replay timer tim=
eout?
> May I ask if you have any other comments on this patch?

Spamming `lspci -vv -s` on the device can still observe the AER error.

I think the "correctable" mask should be optional, let me send a patch
to PCI for comment.

Kai-Heng

>
> Thanks, Victor Shih
>
> > >
> > > Thanks, Victor Shih
> > >
> > > > >
> > > > > Thanks, Victor Shih
> > > > >
> > > > > > >
> > > > > > > Thanks, Victor Shih
> > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.=
tw>
> > > > > > > > > ---
> > > > > > > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > > > > > > >  1 file changed, 16 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/m=
mc/host/sdhci-pci-gli.c
> > > > > > > > > index d83261e857a5..d8a991b349a8 100644
> > > > > > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > > > @@ -28,6 +28,9 @@
> > > > > > > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > > > > > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > > > > > > >
> > > > > > > > > +#define PCI_GLI_9750_CORRERR_MASK                       =
       0x214
> > > > > > > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT=
         BIT(12)
> > > > > > > > > +
> > > > > > > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > > > > > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > > > > > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > > > > > > @@ -152,6 +155,9 @@
> > > > > > > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > > > > > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > > > > > > >
> > > > > > > > > +#define PCI_GLI_9755_CORRERR_MASK                       =
       0x214
> > > > > > > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT=
         BIT(12)
> > > > > > > > > +
> > > > > > > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0=
x510
> > > > > > > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET   =
 BIT(8)
> > > > > > > > >
> > > > > > > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct=
 sdhci_host *host)
> > > > > > > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL=
, value);
> > > > > > > > >
> > > > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_=
MASK, &value);
> > > > > > > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER=
_TIMEOUT;
> > > > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR=
_MASK, value);
> > > > > > > > > +
> > > > > > > > >         gl9750_wt_off(host);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct=
 sdhci_pci_slot *slot)
> > > > > > > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL=
, value);
> > > > > > > > >
> > > > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_=
MASK, &value);
> > > > > > > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER=
_TIMEOUT;
> > > > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR=
_MASK, value);
> > > > > > > > > +
> > > > > > > > >         gl9755_wt_off(pdev);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > > >
