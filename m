Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6727A766B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjITIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjITIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:54:05 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558459E;
        Wed, 20 Sep 2023 01:53:59 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7870821d9a1so444869241.1;
        Wed, 20 Sep 2023 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695200038; x=1695804838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrrQJKkKes28oqech+rUAf+7IG5PdT7LFyD0ckVQ1ag=;
        b=dpweKRhbjw4FwX+NfhmkJyt7YW3UZoqQT2M5A3X7RrhVQecs4MIBnCSzwBtTqVibgk
         yIrnnFiTzMfD/5QG8qiur9W1kahfJNimaEO5PALJfr0OlA3Q93vWazsLw+ownzl+jsX9
         d2lUSc0iwiGROZp4z23GYUHIbvt+FCos2CFrx2oTkcZAk+w4zxWa/l7GqHJ8xP+BVJGM
         xWN0emkvtjTCHs9edYSUPLx8cQDPoT8tZr4PIY2U91JokVXFPxvuULhhA54tj9/LNG/z
         1z6ZeuX7gVOjm0AtfBrFE50L2/5MwqQPwAGXtzYBXDHZwBZcqaeKD+eVkxjq+H5Mz+y1
         j5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695200038; x=1695804838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrrQJKkKes28oqech+rUAf+7IG5PdT7LFyD0ckVQ1ag=;
        b=d0MkCYpsWt+KSB0gUDzTLKJgPgRlOXcNJ55VyrKGsJnGOki4ctX6RLbKukDR4eCy0V
         VbNEDQbKJYI5G69AC/ivTs42NpeTer537ZogQmdDOaHYV60KM11q97TxP+St5imb/s1D
         9xjUY9sNTnlRCHYDLFpFKNeKVy1hKkRKWgLJwMORMozTUIJ/6+7xHaT81ErXddYMHp9L
         WHRxi/pLeifFDfVpSUOoVrlvdzTWYS6K6o9KVFtmqF1QETKdEKWkkRuD416S6uUQ/FCU
         /3u8RYvc7+jyOG8rNfCg7uRiwk/RJDwEJIxwT4HGFQV6wCIiMgV7ciaFLuzj+gKL6A0Q
         FflA==
X-Gm-Message-State: AOJu0Yz+wqpBONYqR2ipn8LB5HzZ1tXwWpe04A+4YMP1t93f16DmS6Ge
        tLdkl4aEYZ6LJigrYybUqzolKFQAwdwKUJ03zwo=
X-Google-Smtp-Source: AGHT+IFITPG1Lw0bQlaXkEIvpzAWajhVilVHRJvLKi0dbcR+748lf1WeMOet7434fQqo1MKvA2U4Z38ooConYDSkqcE=
X-Received: by 2002:a67:fd51:0:b0:452:7715:ef91 with SMTP id
 g17-20020a67fd51000000b004527715ef91mr1078111vsr.12.1695200038303; Wed, 20
 Sep 2023 01:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com> <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
In-Reply-To: <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 20 Sep 2023 16:53:46 +0800
Message-ID: <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
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

On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Victor,
>
> On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > Hi Victor,
> > >
> > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgli@gm=
ail.com> wrote:
> > > >
> > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > >
> > > > Due to a flaw in the hardware design, the GL975x replay timer frequ=
ently
> > > > times out when ASPM is enabled. As a result, the system will resume
> > > > immediately when it enters suspend. Therefore, the replay timer
> > > > timeout must be masked.
> > >
> > > This patch solves AER error when its PCI config gets accessed, but th=
e
> > > AER still happens at system suspend:
> > >
> > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error received:
> > > 0000:00:1c.0
> > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
> > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
> > > status/mask=3D00001000/00002000
> > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > >
> > > Kai-Heng
> > >
> >
> > Hi, Kai-Heng
> >
> > Could you try applying the patch and re-testing again after restarting
> > the system?
>
> Same issue happens after coldboot.
>
> > Because I applied the patch and restarted the system and it didn't happ=
en.
> > The system can enter suspend normally.
> >
> > If you still have the issue after following the above instructions,
> > please provide me with your environment and I will verify it again.
>
> The patch gets applied on top of next-20230918. Please let me know
> what else you want to know.
>
> Kai-Heng
>

Hi, Kai-Heng

If I want to mask the replay timer timeout AER of the upper layer root port=
,
could you give me some suggestions?
Or could you provide sample code for my reference?

Thanks, Victor Shih

> >
> > Thanks, Victor Shih
> >
> > > >
> > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > ---
> > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sd=
hci-pci-gli.c
> > > > index d83261e857a5..d8a991b349a8 100644
> > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > @@ -28,6 +28,9 @@
> > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > >
> > > > +#define PCI_GLI_9750_CORRERR_MASK                              0x2=
14
> > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         B=
IT(12)
> > > > +
> > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > @@ -152,6 +155,9 @@
> > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > >
> > > > +#define PCI_GLI_9755_CORRERR_MASK                              0x2=
14
> > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         B=
IT(12)
> > > > +
> > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> > > >
> > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_hos=
t *host)
> > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> > > >
> > > > +       /* mask the replay timer timeout of AER */
> > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &val=
ue);
> > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, val=
ue);
> > > > +
> > > >         gl9750_wt_off(host);
> > > >  }
> > > >
> > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci=
_slot *slot)
> > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> > > >
> > > > +       /* mask the replay timer timeout of AER */
> > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &val=
ue);
> > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, val=
ue);
> > > > +
> > > >         gl9755_wt_off(pdev);
> > > >  }
> > > >
> > > > --
> > > > 2.25.1
> > > >
