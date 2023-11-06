Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54E7E1CB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjKFI4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKFI4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:56:09 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C1DB;
        Mon,  6 Nov 2023 00:56:06 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45d8c405696so625145137.3;
        Mon, 06 Nov 2023 00:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699260965; x=1699865765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FnA2dK5iXOLJoNUoBlFMyMH+VRerj2a3nUAndixNdc=;
        b=FTBaHCQMS32KGLMLFkQEKS3dAp31+fBpyccwmhWwxuZM4FEZCL0M7wgdaYiDptgKjP
         +nNvx5Gu2v2VCGPqrCBUUuuiilyR5G7OFfnchfcGCwWsNw1gzlTi9Ya+tYUJoldxRh8I
         rsHGdsvLcSiMDm3KI/goXtncEWank31oRznyK4WOZrPjuzeXq9G5Um5bziAVgf5hsszr
         5Mgw/DDSLS7yQlYorgdNmVhbZkAKnl7SO7teve+QUI53rztvYwb6NLQeuB4T203vJHOH
         TjgLEJWarp6lX9R2HR5Of8R6lZoG2RVsqFyXWU8tnbV7YNRjzffWnaunccDdDHiSdDdR
         X0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699260965; x=1699865765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FnA2dK5iXOLJoNUoBlFMyMH+VRerj2a3nUAndixNdc=;
        b=llwQfIizmIkPyOWgziDgVvwBf2+4pXEpKNq7viUFIRvWM1bZpUpXXv/ar8PrOVw+68
         EmAM8P5R7/x6hQAqysYzQeK7JDWq5NVDW2VucuuRhwUieeX0NtnRcMYhDpevkT091zTZ
         T5TMqMCUcKwWEOWZyrKBdb8j0i4/GXkjwKDr1AQ7Wrh+ibYVj/QjXG9fnpZz778voSjj
         g30NzJq4pRoKuS4KXtbJb59gwShecGOpMqlNROkQXzBSQUnw4OBnjEprXGJm1121CV70
         zmw3AzGL5Q5e5xa4PjVOZkvdybbZKRH0/qgNDde0dwkHXWo+UrNd5KXHx48GEPciWGWg
         uSPg==
X-Gm-Message-State: AOJu0Yz6vRrh2MpWY5VWi3AZHqgWg/fRA0JG/ITTFtT3IyW2Luvx72xX
        ugGakuWV09HLlxBdQX3yChOfgd744wFZYXeTcEg=
X-Google-Smtp-Source: AGHT+IH9SPCQhzFMng7GRyRX8tLnYkjisz8wyL6iUDjopfYuO/7NX9MHdWFqZadleaKU3uituxsNHPbxJ85ClM3Jl5o=
X-Received: by 2002:a67:e08d:0:b0:45f:398:aba5 with SMTP id
 f13-20020a67e08d000000b0045f0398aba5mr2690748vsl.32.1699260965375; Mon, 06
 Nov 2023 00:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20231018103337.34622-1-victorshihgli@gmail.com>
 <CAK00qKBH5P3naXUHhbQ3zgMzQrUxy=v8r84a8RCcdNORVoRPkA@mail.gmail.com> <CAPDyKFob14Tc4c0UxRfj2qbXJkDn7NRwNwRuYQ6m9t3c27Kp=Q@mail.gmail.com>
In-Reply-To: <CAPDyKFob14Tc4c0UxRfj2qbXJkDn7NRwNwRuYQ6m9t3c27Kp=Q@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Mon, 6 Nov 2023 16:55:53 +0800
Message-ID: <CAK00qKDvdDBJ9zrBh=9anCArOZUis8-kE5bRx=owjD_pe4ZDCg@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw, kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 6:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 3 Nov 2023 at 11:13, Victor Shih <victorshihgli@gmail.com> wrote:
> >
> > Hi, Ulf
> >
> > Please help review this patch and give me some advice.
> > I look forward to your reply.
> >
> > Thanks, Victor Shih
>
> I don't have in-depth knowledge of how to properly solve this for pci,
> so I am relying on Kai and others to help review.
>

Hi, Ulf

This is a standalone patch, this patch only solves the warning
messages that will
 often appear in the system log when the system accesses the GL975x PCI con=
fig.

As I discussed with Kai-Heng at the end of
[V1] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer timeout of AER,
Kai-Heng will be submitting a patch for the PCIe layer to solve the
situation he encountered.
I will also help Kai-Heng test when he submits the patch.

Thanks, Victor Shih

> >
> > On Wed, Oct 18, 2023 at 6:33=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> > >
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > Due to a flaw in the hardware design, the GL975x replay timer frequen=
tly
> > > times out when ASPM is enabled. As a result, the warning messages tha=
t will
> > > often appear in the system log when the system accesses the GL975x
> > > PCI config. Therefore, the replay timer timeout must be masked.
> > >
> > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> The code looks good to me, but let's allow Kai to get some time to
> come back to this before I apply it.
>
> Kind regards
> Uffe
>
> > > ---
> > >
> > > Updates in V2:
> > >  - Modify the commit message.
> > >
> > > ---
> > >
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
