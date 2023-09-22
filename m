Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7247AA9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjIVHLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjIVHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:11:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD3419A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:11:03 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 42D9141DC0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695366661;
        bh=32y6QHnxViOsZUOoPcCiP72zawebasLjgpKpSnUSB6U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ETWdfvxxqefVpeKvydxOahQvKgX/x0LJUJApfFBAJROCnM7Na5KRnDISGknvJaIoO
         f48GoqkOudStn6u+ig+2EZWvjvRmrNwNPLzG+Ced1UZnc8B15i7zj8tu7MWNgDZiy2
         FZk9Nfe/w38qwjAt7bP+zy1Su1NR4/rVJJhlBTN0NqykgjNWAWYQ3z8K3bWE89oWTa
         CPQJpfRIcTGhXLVYk0Ze11gLpF+bcK7083vxZO9CyuYXYAn7YWHiQTLNg/9wgz8Qkd
         WLEAVuQHviqGrkRJXCao+bgxoGpppFCSy9Q8hX7JOnT1X85sST11ov8QB1Emkm2iZ3
         mja978IT9SGOQ==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-274d62ab09bso1592956a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695366656; x=1695971456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32y6QHnxViOsZUOoPcCiP72zawebasLjgpKpSnUSB6U=;
        b=B1oCZyIXhJj44G7eUJx36Q5pttFql5cKMpVdxuKLK4tblJv7/SD6lFu3+EgfQik95i
         EntanO5geBVqU7pYf7J7ddLdG9Tc8Fr/zoJzxAVlmsO8pipPSc18FeFc3x6Z9kSaCVkD
         Z5Rspezu2/ewVcVAsTvmGS9ta49hCwUgQHEarYEGoA3mOVm5q0kL5wMULbVpwPAIKo65
         Y6lUtICpWPMoXbOo6uPiBYKnN0GwWlybjMTQLOkxan1uJCIiNhWED3+1joX2tat16K6b
         YPTeoesZC9jrE0UqiDAdMpN+5yo/mzJL8IitWbjae2eg/IGC4P3LlEJkLjoFEkk+tJJ4
         vm8g==
X-Gm-Message-State: AOJu0YzxKIs/S+9FgS/Jsoi/U279zfquk0VP/F+OkHFG6Waa4BtoWN67
        3gy18E9/2nI8zbuLQoBtkm/lnNwj575bjsBPgC+/52TA6MQe1WpQ+8xhY+uUOSeCYr1mW+DvqaW
        sW+x9I60ivvbO9FguUqPAsxqpAgG1XOAf4Cuin/Jgkbs8QZqyB76D94JaG00zFt1jig==
X-Received: by 2002:a17:90b:1018:b0:274:84e4:4ef8 with SMTP id gm24-20020a17090b101800b0027484e44ef8mr8134179pjb.32.1695366655863;
        Fri, 22 Sep 2023 00:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGod7CcERn2eMZR/UVTGo78WSbu0rFiusPo9zXcqFuZ4I5paN2ltrtP4yo1wndlXn4mtKrdxLetX9V84XrL8uw=
X-Received: by 2002:a17:90b:1018:b0:274:84e4:4ef8 with SMTP id
 gm24-20020a17090b101800b0027484e44ef8mr8134161pjb.32.1695366655510; Fri, 22
 Sep 2023 00:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
 <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com> <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
In-Reply-To: <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 22 Sep 2023 15:10:42 +0800
Message-ID: <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com>
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

Hi Victor,

On Wed, Sep 20, 2023 at 4:54=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Hi Victor,
> >
> > On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> > >
> > > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > Hi Victor,
> > > >
> > > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgli@=
gmail.com> wrote:
> > > > >
> > > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > >
> > > > > Due to a flaw in the hardware design, the GL975x replay timer fre=
quently
> > > > > times out when ASPM is enabled. As a result, the system will resu=
me
> > > > > immediately when it enters suspend. Therefore, the replay timer
> > > > > timeout must be masked.
> > > >
> > > > This patch solves AER error when its PCI config gets accessed, but =
the
> > > > AER still happens at system suspend:
> > > >
> > > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error received=
:
> > > > 0000:00:1c.0
> > > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > > severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
> > > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
> > > > status/mask=3D00001000/00002000
> > > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > > >
> > > > Kai-Heng
> > > >
> > >
> > > Hi, Kai-Heng
> > >
> > > Could you try applying the patch and re-testing again after restartin=
g
> > > the system?
> >
> > Same issue happens after coldboot.
> >
> > > Because I applied the patch and restarted the system and it didn't ha=
ppen.
> > > The system can enter suspend normally.
> > >
> > > If you still have the issue after following the above instructions,
> > > please provide me with your environment and I will verify it again.
> >
> > The patch gets applied on top of next-20230918. Please let me know
> > what else you want to know.
> >
> > Kai-Heng
> >
>
> Hi, Kai-Heng
>
> If I want to mask the replay timer timeout AER of the upper layer root po=
rt,
> could you give me some suggestions?
> Or could you provide sample code for my reference?

I am not aware of anyway to mask "replay timer timeout" from root port.
I wonder if the device supoprt D3hot? Or should it stay at D0 when
ASPM L1.2 is enabled?

Kai-Heng

>
> Thanks, Victor Shih
>
> > >
> > > Thanks, Victor Shih
> > >
> > > > >
> > > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > ---
> > > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/=
sdhci-pci-gli.c
> > > > > index d83261e857a5..d8a991b349a8 100644
> > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > @@ -28,6 +28,9 @@
> > > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > > >
> > > > > +#define PCI_GLI_9750_CORRERR_MASK                              0=
x214
> > > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT        =
 BIT(12)
> > > > > +
> > > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > > @@ -152,6 +155,9 @@
> > > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > > >
> > > > > +#define PCI_GLI_9755_CORRERR_MASK                              0=
x214
> > > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT        =
 BIT(12)
> > > > > +
> > > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> > > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> > > > >
> > > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_h=
ost *host)
> > > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value)=
;
> > > > >
> > > > > +       /* mask the replay timer timeout of AER */
> > > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &v=
alue);
> > > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT=
;
> > > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, v=
alue);
> > > > > +
> > > > >         gl9750_wt_off(host);
> > > > >  }
> > > > >
> > > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_p=
ci_slot *slot)
> > > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value)=
;
> > > > >
> > > > > +       /* mask the replay timer timeout of AER */
> > > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &v=
alue);
> > > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT=
;
> > > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, v=
alue);
> > > > > +
> > > > >         gl9755_wt_off(pdev);
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
