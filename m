Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1857A5AED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjISHbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjISHbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:31:40 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCDDFC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:31:34 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6CF153F683
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695108692;
        bh=94LEV8sxRamBwf5ruZOpVUO6tcRznlSXV04hW3XWcFM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=j8CaOEJGlcbY+a7dbtDmL5mxrF4VXVMor6LcEqBaWy5XkNFZPM+04FCvajtOhjtNJ
         KRTXuo+FkCSWBCvQ2VAReth24ks/FPO830NonjIPIjGl4P2SEzSkNkQo5u8wGGgvvy
         HYWQlkfAS4Z+jyVIWbxW9MP+6qD4y5X+ju3UnHAbReobi6Fcyh3RHeg+LdzFZfGt9F
         zE/xocuLkBVc5Ee47ujdwFNRB/DBILt0e1kTwPhtIymB6RsZ7Hw66FLBZg1bAubkKU
         dbPEy+IPe7RJJcu3L0JzQKN9JL8bLWOy+CvJ1gqQWw5iD/HcQfcB+6TpczQm5lyApE
         +G35mkDLoaz2Q==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-68fc7be8224so5941769b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 00:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695108690; x=1695713490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94LEV8sxRamBwf5ruZOpVUO6tcRznlSXV04hW3XWcFM=;
        b=nt4k8SMRgq7fxdTOBEVTJOPGhO+DaYXrsryBUtH46DM0YlUZihw8HWGIHE5rkEiss+
         0sawK3Iac2gt9/TWOI9WTQsP7Z+kDsdVulXp3env2HbFouagLAPmPLU+j8Sia5pSYY9/
         /600WyA9tgXHyQwgCWxzIIBBZy/T6/Vzi71RY9wfP8ZELYmTEozBZBnbuX4iA1KE9xTX
         34TgCJAuDFb4RseTaCsxLGcpp22MsJbBhclSoZuGcDccql+e3z/0BgW++yY9mLX9D3ok
         MjfXAir0JLQoqoP/bZW9rxFyKuRWTAeLuQza2zUqL82ZIMPXC757RQNNMIXDMVhlM+dU
         5UKA==
X-Gm-Message-State: AOJu0YxVtW3JBbP80AeO0gtQjud/uSKyw2x6VhC/3XoP2Wm8pYs6gVjG
        1a2XbJpndZjBpOgjs9dD7c1euoL1aw+f7+TIMQDdoGOPeDn1o8wiP79pDsibiVc5OPaJYOIfXxa
        TXQLaRrZX5kAgEz/auADBz6Lb8SEZyq3EQIyhZy6vPToRQpYnjA80q3rIww==
X-Received: by 2002:a05:6a20:3d83:b0:154:a579:b0ff with SMTP id s3-20020a056a203d8300b00154a579b0ffmr16062462pzi.19.1695108689947;
        Tue, 19 Sep 2023 00:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0EAwF9oz7bRlARRsntNHNxq3AvpLMEzLX23ZxAs9aXP+tFyCsPmoWrkzvt80juB1lJbxZxpioLXTA6+OBUbw=
X-Received: by 2002:a05:6a20:3d83:b0:154:a579:b0ff with SMTP id
 s3-20020a056a203d8300b00154a579b0ffmr16062442pzi.19.1695108689656; Tue, 19
 Sep 2023 00:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com> <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
In-Reply-To: <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Sep 2023 15:31:16 +0800
Message-ID: <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Hi Victor,
> >
> > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> > >
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > Due to a flaw in the hardware design, the GL975x replay timer frequen=
tly
> > > times out when ASPM is enabled. As a result, the system will resume
> > > immediately when it enters suspend. Therefore, the replay timer
> > > timeout must be masked.
> >
> > This patch solves AER error when its PCI config gets accessed, but the
> > AER still happens at system suspend:
> >
> > [ 1100.103603] ACPI: EC: interrupt blocked
> > [ 1100.268244] ACPI: EC: interrupt unblocked
> > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error received:
> > 0000:00:1c.0
> > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
> > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
> > status/mask=3D00001000/00002000
> > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> >
> > Kai-Heng
> >
>
> Hi, Kai-Heng
>
> Could you try applying the patch and re-testing again after restarting
> the system?

Same issue happens after coldboot.

> Because I applied the patch and restarted the system and it didn't happen=
.
> The system can enter suspend normally.
>
> If you still have the issue after following the above instructions,
> please provide me with your environment and I will verify it again.

The patch gets applied on top of next-20230918. Please let me know
what else you want to know.

Kai-Heng

>
> Thanks, Victor Shih
>
> > >
> > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > ---
> > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhc=
i-pci-gli.c
> > > index d83261e857a5..d8a991b349a8 100644
> > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > @@ -28,6 +28,9 @@
> > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > >
> > > +#define PCI_GLI_9750_CORRERR_MASK                              0x214
> > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT=
(12)
> > > +
> > >  #define SDHCI_GLI_9750_CFG2          0x848
> > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > @@ -152,6 +155,9 @@
> > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > >
> > > +#define PCI_GLI_9755_CORRERR_MASK                              0x214
> > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT=
(12)
> > > +
> > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> > >
> > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host =
*host)
> > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> > >
> > > +       /* mask the replay timer timeout of AER */
> > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value=
);
> > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value=
);
> > > +
> > >         gl9750_wt_off(host);
> > >  }
> > >
> > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_s=
lot *slot)
> > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> > >
> > > +       /* mask the replay timer timeout of AER */
> > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value=
);
> > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value=
);
> > > +
> > >         gl9755_wt_off(pdev);
> > >  }
> > >
> > > --
> > > 2.25.1
> > >
