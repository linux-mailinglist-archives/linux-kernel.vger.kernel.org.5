Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9706C7B4AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 04:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjJBCSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 22:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBCSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 22:18:39 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD76CE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 19:18:36 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C6F63F0EF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696213114;
        bh=arwkRh59RvIRo3RXrZAKRa9j+onW5QMC0mP/sOojdHs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=crXK+jiBBQdE83yYfzZvvJMZMmxBn/IGDxESHniu0vBhsK1hqpLKybgcVMxoKTm2i
         ICa/Pq22L+ZcV4kdXyAFrZDpkLiBVO0jeIPpHLd/a/L8znQCdTtNDVQ9Rcxwd8E+Qd
         k3v5Se8bVffl55+2qke7cxyWHniZf7/IuuKhnJL6wOE5WCQ/fNd1GAL70P6DZxyVN6
         jwgGS6XeoQ0FQl4scC48ml6pALm5WrfOjgrYGSA50Aqf9LwQi6d57AXUZ6DOkrhyob
         2e/1e96FIUb6JvX+/ZKODMpg70+cwgecd4aPYbh0GtTjHYSbd9HvHvZV5mYVBVrkBD
         XRagn+rdCccRA==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6933e676395so1879580b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 19:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696213112; x=1696817912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arwkRh59RvIRo3RXrZAKRa9j+onW5QMC0mP/sOojdHs=;
        b=Ppw6irByPDl5gPaBezbqICxIoZjakEavcEvIvJ28SlzTBHHCmMIz3rKsYzwO9jeTku
         zlXuGB6qmibv00hbtQ0fLG0NQn7/g84khXIQeoB2NEQs2+enYPZ4LSXMCRdI0VumYD7A
         2c6g10nRYg1CLxqLDZeuIKJuwyDBB1XM+HKfSLzs6MpLOKoknJps5u0Nsjdih/SVL9Ks
         nsCy2MJaK5AgHZ+TZei7kKPpUUfLAPyxrNND6QuZKa5/VTlCmDvrJFmZgCB9tF+Xw+I1
         KSTT0k8z648JH3etFEY4PQR7uLyO2sA+1vvJ3L9IQdA5xy168Ddu4M6JLKu2X2er5PFG
         qgKQ==
X-Gm-Message-State: AOJu0Yzl1j2mavl7M0PGB3VycnP6B/5fPUYUfeFazxu/8ByAZLjsi0Ja
        baSsTsVFYav995lGkq2Dn72eVBhhhsKyMdVDnp1bCUiD1z/k9sgGyKz02Rf1zYKYlASIuSh0LK1
        zPC+wgh+ZwZ9XypTsy/CTn4h7dXRKxveBUp2tsXuVJbHecVV1llqr00K7zw==
X-Received: by 2002:a05:6a21:a5a8:b0:159:c07d:66f0 with SMTP id gd40-20020a056a21a5a800b00159c07d66f0mr17612014pzc.6.1696213112540;
        Sun, 01 Oct 2023 19:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeQwkwVunDAptU6uHN7shOm/W7m9tX5j1saEKRmCdr9hEv+TLoTPuGBnJhX14CjIC2LvmkdpQGopP8md/45oM=
X-Received: by 2002:a05:6a21:a5a8:b0:159:c07d:66f0 with SMTP id
 gd40-20020a056a21a5a800b00159c07d66f0mr17611995pzc.6.1696213112242; Sun, 01
 Oct 2023 19:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
 <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
 <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
 <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com> <CAK00qKCXYg_JPUf=kCxLR1wmi=kmQ25X-ScQ7OYL1zpBKQAQkA@mail.gmail.com>
In-Reply-To: <CAK00qKCXYg_JPUf=kCxLR1wmi=kmQ25X-ScQ7OYL1zpBKQAQkA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 2 Oct 2023 10:18:19 +0800
Message-ID: <CAAd53p6_qQvp3EJgds_CAnHHSJLBQWc9TYyWpOzNaBZjyoDpeg@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

On Tue, Sep 26, 2023 at 4:21=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> On Fri, Sep 22, 2023 at 3:11=E2=80=AFPM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Hi Victor,
> >
> > On Wed, Sep 20, 2023 at 4:54=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> > >
> > > On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > Hi Victor,
> > > >
> > > > On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshihgli@=
gmail.com> wrote:
> > > > >
> > > > > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > >
> > > > > > Hi Victor,
> > > > > >
> > > > > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshih=
gli@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > > >
> > > > > > > Due to a flaw in the hardware design, the GL975x replay timer=
 frequently
> > > > > > > times out when ASPM is enabled. As a result, the system will =
resume
> > > > > > > immediately when it enters suspend. Therefore, the replay tim=
er
> > > > > > > timeout must be masked.
> > > > > >
> > > > > > This patch solves AER error when its PCI config gets accessed, =
but the
> > > > > > AER still happens at system suspend:
> > > > > >
> > > > > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > > > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > > > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error rece=
ived:
> > > > > > 0000:00:1c.0
> > > > > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > > > > severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
> > > > > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] erro=
r
> > > > > > status/mask=3D00001000/00002000
> > > > > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > > > > >
> > > > > > Kai-Heng
> > > > > >
> > > > >
> > > > > Hi, Kai-Heng
> > > > >
> > > > > Could you try applying the patch and re-testing again after resta=
rting
> > > > > the system?
> > > >
> > > > Same issue happens after coldboot.
> > > >
> > > > > Because I applied the patch and restarted the system and it didn'=
t happen.
> > > > > The system can enter suspend normally.
> > > > >
> > > > > If you still have the issue after following the above instruction=
s,
> > > > > please provide me with your environment and I will verify it agai=
n.
> > > >
> > > > The patch gets applied on top of next-20230918. Please let me know
> > > > what else you want to know.
> > > >
> > > > Kai-Heng
> > > >
> > >
> > > Hi, Kai-Heng
> > >
> > > If I want to mask the replay timer timeout AER of the upper layer roo=
t port,
> > > could you give me some suggestions?
> > > Or could you provide sample code for my reference?
> >
> > I am not aware of anyway to mask "replay timer timeout" from root port.
> > I wonder if the device supoprt D3hot? Or should it stay at D0 when
> > ASPM L1.2 is enabled?
> >
> > Kai-Heng
> >
>
> Hi, Kai-Heng
>
> Do you know any way to mask the replay timer timeout AER of the
> upstream port from the device?

Per PCIe Spec, I don't think it's possible to only mask 'replay timer timeo=
ut'.

> The device supports D3hot.

Do you think such error plays any crucial rule? Otherwise disable
'correctable' errors may be plausible.

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
> > > > > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > > > ---
> > > > > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > > > > >  1 file changed, 16 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/h=
ost/sdhci-pci-gli.c
> > > > > > > index d83261e857a5..d8a991b349a8 100644
> > > > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > @@ -28,6 +28,9 @@
> > > > > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > > > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > > > > >
> > > > > > > +#define PCI_GLI_9750_CORRERR_MASK                           =
   0x214
> > > > > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT    =
     BIT(12)
> > > > > > > +
> > > > > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > > > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > > > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > > > > @@ -152,6 +155,9 @@
> > > > > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > > > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > > > > >
> > > > > > > +#define PCI_GLI_9755_CORRERR_MASK                           =
   0x214
> > > > > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT    =
     BIT(12)
> > > > > > > +
> > > > > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> > > > > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT=
(8)
> > > > > > >
> > > > > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdh=
ci_host *host)
> > > > > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, va=
lue);
> > > > > > >
> > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK=
, &value);
> > > > > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIM=
EOUT;
> > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MAS=
K, value);
> > > > > > > +
> > > > > > >         gl9750_wt_off(host);
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdh=
ci_pci_slot *slot)
> > > > > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, va=
lue);
> > > > > > >
> > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK=
, &value);
> > > > > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIM=
EOUT;
> > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MAS=
K, value);
> > > > > > > +
> > > > > > >         gl9755_wt_off(pdev);
> > > > > > >  }
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
