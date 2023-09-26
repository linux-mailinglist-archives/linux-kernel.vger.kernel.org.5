Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7F57AE7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjIZIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjIZIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:21:29 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E7A97;
        Tue, 26 Sep 2023 01:21:23 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7ab4c86eeb0so2334948241.2;
        Tue, 26 Sep 2023 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695716482; x=1696321282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBkB1PXkvpUJ5/QF/RvxMDdoBBZtzH2CJ6N0G77XI9Y=;
        b=i+AGeBPGSDPu1zPi2vUglGQSZVWTx8+LXdVyWXT26Ogvbp6/raPzr7CUN3PECP8a2s
         G1rGyGXsuvK2CGE/f5Ksw4tcCqB9wEc3TkfAwx3gO7Viwq+pERWfmVw+8tpakwWwCT/I
         fSjzexowtFxVeB0n69A7Am2UZKekUm8bOGgcqek/j00X7wq3grkrKJbK01B6pPdhQZNE
         QbhiKBPE3lMBPH5vw+fdsIzjbvcLEVWNJExSc+HfytZcDQ+3z6CwH20cy3FU3S3usIIb
         e+4BKLmxnSnhx/uBP25Hc0Mw6UjRrAwFyqUNEAXBOgbOmEmv3P5/pxpo3dE8SsR4oRJU
         5DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695716482; x=1696321282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBkB1PXkvpUJ5/QF/RvxMDdoBBZtzH2CJ6N0G77XI9Y=;
        b=eMkKg7hkcswX4671zYWNNCtdqSuhIy1TCbirZkznOVUKHNEFnF+iQUpbMBuFYFqmMA
         KmhtJz0aF6m4QvJEsZ4YM6OwGawMchEGuznM7MQCR/ni9q8Ch3HbBCf7XizOrST0B1la
         4uz+uwdEf1jXthA+9pZgwIqpDXLPbviOpHWA8tGV09w20+YpIjG43ujD7LqW7Fkmt97d
         YVfCpHNIO21V2jMrXDS4LLdxQZNp5dm8xyXA3rV0ZJI33PmO3LesQpbbB8xBsCKFzKDd
         nT6la0XM+tEegi1Rbm6o/fPnDOCtpAluUjyKFr7pW2y6JBoQJOZzdQo27NXxR35rdn6z
         ynPA==
X-Gm-Message-State: AOJu0YzNO9Ae6yNRiFtXaKYNsQeu4RG2MlRJt0HfMwOYGoF9LPIYhvfE
        6ltS3A5ODS6JJTJO0YAo0/h5j2K+NSAp6bJT/cI=
X-Google-Smtp-Source: AGHT+IGFak/e7ef5Vb6/GQrq9aqO6pFL9o40XChk4JYyU3fRXwhSV7XqOu07VteSOMBfXNVObJLB7RhBXFlom6GVnbA=
X-Received: by 2002:a67:f8ca:0:b0:452:8f88:a782 with SMTP id
 c10-20020a67f8ca000000b004528f88a782mr3454006vsp.32.1695716482251; Tue, 26
 Sep 2023 01:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
 <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
 <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com> <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com>
In-Reply-To: <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Tue, 26 Sep 2023 16:21:09 +0800
Message-ID: <CAK00qKCXYg_JPUf=kCxLR1wmi=kmQ25X-ScQ7OYL1zpBKQAQkA@mail.gmail.com>
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

On Fri, Sep 22, 2023 at 3:11=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Victor,
>
> On Wed, Sep 20, 2023 at 4:54=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > Hi Victor,
> > >
> > > On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshihgli@gm=
ail.com> wrote:
> > > >
> > > > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > > > <kai.heng.feng@canonical.com> wrote:
> > > > >
> > > > > Hi Victor,
> > > > >
> > > > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgl=
i@gmail.com> wrote:
> > > > > >
> > > > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > >
> > > > > > Due to a flaw in the hardware design, the GL975x replay timer f=
requently
> > > > > > times out when ASPM is enabled. As a result, the system will re=
sume
> > > > > > immediately when it enters suspend. Therefore, the replay timer
> > > > > > timeout must be masked.
> > > > >
> > > > > This patch solves AER error when its PCI config gets accessed, bu=
t the
> > > > > AER still happens at system suspend:
> > > > >
> > > > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error receiv=
ed:
> > > > > 0000:00:1c.0
> > > > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > > > severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
> > > > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
> > > > > status/mask=3D00001000/00002000
> > > > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > > > >
> > > > > Kai-Heng
> > > > >
> > > >
> > > > Hi, Kai-Heng
> > > >
> > > > Could you try applying the patch and re-testing again after restart=
ing
> > > > the system?
> > >
> > > Same issue happens after coldboot.
> > >
> > > > Because I applied the patch and restarted the system and it didn't =
happen.
> > > > The system can enter suspend normally.
> > > >
> > > > If you still have the issue after following the above instructions,
> > > > please provide me with your environment and I will verify it again.
> > >
> > > The patch gets applied on top of next-20230918. Please let me know
> > > what else you want to know.
> > >
> > > Kai-Heng
> > >
> >
> > Hi, Kai-Heng
> >
> > If I want to mask the replay timer timeout AER of the upper layer root =
port,
> > could you give me some suggestions?
> > Or could you provide sample code for my reference?
>
> I am not aware of anyway to mask "replay timer timeout" from root port.
> I wonder if the device supoprt D3hot? Or should it stay at D0 when
> ASPM L1.2 is enabled?
>
> Kai-Heng
>

Hi, Kai-Heng

Do you know any way to mask the replay timer timeout AER of the
upstream port from the device?
The device supports D3hot.

Thanks, Victor Shih

> >
> > Thanks, Victor Shih
> >
> > > >
> > > > Thanks, Victor Shih
> > > >
> > > > > >
> > > > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > > ---
> > > > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > > > >  1 file changed, 16 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/hos=
t/sdhci-pci-gli.c
> > > > > > index d83261e857a5..d8a991b349a8 100644
> > > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > @@ -28,6 +28,9 @@
> > > > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > > > >
> > > > > > +#define PCI_GLI_9750_CORRERR_MASK                             =
 0x214
> > > > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT      =
   BIT(12)
> > > > > > +
> > > > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > > > @@ -152,6 +155,9 @@
> > > > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > > > >
> > > > > > +#define PCI_GLI_9755_CORRERR_MASK                             =
 0x214
> > > > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT      =
   BIT(12)
> > > > > > +
> > > > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> > > > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8=
)
> > > > > >
> > > > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci=
_host *host)
> > > > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, valu=
e);
> > > > > >
> > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, =
&value);
> > > > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEO=
UT;
> > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK,=
 value);
> > > > > > +
> > > > > >         gl9750_wt_off(host);
> > > > > >  }
> > > > > >
> > > > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci=
_pci_slot *slot)
> > > > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, valu=
e);
> > > > > >
> > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, =
&value);
> > > > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEO=
UT;
> > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK,=
 value);
> > > > > > +
> > > > > >         gl9755_wt_off(pdev);
> > > > > >  }
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
