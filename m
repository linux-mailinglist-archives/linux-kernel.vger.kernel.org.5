Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8E7A5862
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 06:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjISEY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 00:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjISEY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:24:57 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CEA8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 21:24:51 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D12703F67C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695097488;
        bh=IMtK+jU1aaMg55M9XkRBqz1ntxbDUiDeLgvPp97wNk0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qve+rFxC6cuevf3T0qYkvISSF4H9bNpwrlM9zIEtDOk0vKYpyr5SRPMFlp6yKWJvS
         vcyLMdl4g++OyBVIuSobVKrJC3RtBKFf2I+Mov6JLbmH8YT3YP1s3vIYRK/Z8ySXwZ
         20p0FiZ36MA5Fh0sjk2EPOgF+MCZ+0kBkxfJGoM6wZ5Zla6Epmfzwhc/A7+yMyqFLd
         GbVi0sUZHsXcVVgHV7lhB3DXySOwEm8gynpMSRDR9ffc6dZe3i1bCzm/9BwEUM1XK5
         MEn4C76oT3rNGfk0kBMrtjk+sKLqpf8BBQoMM29To+ClCs/hixMjynK2Z6Iybramnt
         sWr3RXhcblIIA==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5788445ac04so1340305a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 21:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695097487; x=1695702287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMtK+jU1aaMg55M9XkRBqz1ntxbDUiDeLgvPp97wNk0=;
        b=xJ63TDLKtTNscE9jsX63tL38V1Fu6SaAAtzJpkL65geSYBN7tHLwdS4Zy4OZsomSGq
         0ja/g2lM8lNPGTt4oAcJMciR4gTWkNxbcx24R/XoYc0tqzz4gjcTw8RLmHA61AWk5rkM
         MFfBLoP4iWuFpk8LbBCZEedI1hCsdBV2K0B+/Wj1o8zdy8ZiYRVR6CywPnnLhAu/pQzK
         qrL8CZtrb6A9exvN+ebOM3QbJA3lTWM40cj4ZWvCv1VSvVYfd+X3KqgqHpjL8x6lIl0l
         HeQ+Rg2JUNwLDvbLSlolztPn9Whkb8DPNkXE/8ENN2jA/6hBnEj7MlQjwDnfH4wEAQiF
         ddpA==
X-Gm-Message-State: AOJu0YwqkNNaHaa+hlivjdY9s6SY+J7hPykVNSD4YM5iwdPQ8ZgrZupO
        Kg+3fYXIRZTiJ7yieLGzb5UYRUlKrWFTx0Xan+v6S9z7ClkaRI1GMDiG3lDXh7dI1U5lsjUbaA8
        BlbWOH3U/pb5cWaCRx/0wOkfN9kNYjUVqpnK6kp7T9J/ek4PVD3g7vfDU7Q==
X-Received: by 2002:a05:6a21:18e:b0:13a:12c2:359e with SMTP id le14-20020a056a21018e00b0013a12c2359emr12692345pzb.2.1695097487142;
        Mon, 18 Sep 2023 21:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfSpGqyN9f9jWsNOnlcse6U3a2kxaJXMtNr6uyc/cwtIZGvdtxdi2SphBoLjW8MxYK7MZ1EDlr3URictaFhME=
X-Received: by 2002:a05:6a21:18e:b0:13a:12c2:359e with SMTP id
 le14-20020a056a21018e00b0013a12c2359emr12692337pzb.2.1695097486878; Mon, 18
 Sep 2023 21:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
In-Reply-To: <20230918103055.5471-1-victorshihgli@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Sep 2023 12:24:34 +0800
Message-ID: <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Due to a flaw in the hardware design, the GL975x replay timer frequently
> times out when ASPM is enabled. As a result, the system will resume
> immediately when it enters suspend. Therefore, the replay timer
> timeout must be masked.

This patch solves AER error when its PCI config gets accessed, but the
AER still happens at system suspend:

[ 1100.103603] ACPI: EC: interrupt blocked
[ 1100.268244] ACPI: EC: interrupt unblocked
[ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
status/mask=3D00001000/00002000
[ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout

Kai-Heng

>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index d83261e857a5..d8a991b349a8 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -28,6 +28,9 @@
>  #define PCI_GLI_9750_PM_CTRL   0xFC
>  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
>
> +#define PCI_GLI_9750_CORRERR_MASK                              0x214
> +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(12)
> +
>  #define SDHCI_GLI_9750_CFG2          0x848
>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> @@ -152,6 +155,9 @@
>  #define PCI_GLI_9755_PM_CTRL     0xFC
>  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
>
> +#define PCI_GLI_9755_CORRERR_MASK                              0x214
> +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(12)
> +
>  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
>  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
>
> @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *hos=
t)
>         value &=3D ~PCI_GLI_9750_PM_STATE;
>         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
>
> +       /* mask the replay timer timeout of AER */
> +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
> +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
> +
>         gl9750_wt_off(host);
>  }
>
> @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot =
*slot)
>         value &=3D ~PCI_GLI_9755_PM_STATE;
>         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
>
> +       /* mask the replay timer timeout of AER */
> +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
> +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
> +
>         gl9755_wt_off(pdev);
>  }
>
> --
> 2.25.1
>
