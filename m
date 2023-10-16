Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351A97CAE6E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjJPQDx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJPQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:03:51 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3BE83;
        Mon, 16 Oct 2023 09:03:49 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso829258566b.2;
        Mon, 16 Oct 2023 09:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472227; x=1698077027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o1Sjx05gX0rIxT2he/9e9a3FERmo9S5QHOTVv8X/pQ=;
        b=OOUsrcj+0/6QsZ4/LeBI8DOmYhG+4LTi+FHHPNMH9lprWi2UArQnUnANL+EmV3GpWW
         Dh/yEiopewOB0b4z6MFMKehXIQ0wmWdnYfj6CoOBxJjG/sgXrDUOo72AIzF82VCJSuT9
         ALKCZj6Ath50RlW+FIrcgem7MwmaSLmVUQqlnjzRFih+yXeSicVyA5wD/OotT6La7uDq
         DHglFdkmO4VxUdJj26qTRMJcHcIMi/hGF02btBemFKZ258qOVcNlUBLCFh+1hzcyIgUD
         HJbWglPCQoj9tPqK/A6Ev8RYCwhYxdN8gR9IZzvRs3fR5D47+9s6qs4xNJZVxSyjbOdG
         kvBA==
X-Gm-Message-State: AOJu0YwTge8a39q1b638+stl22PDwfBxnAuVCZWCpi/0032HNZ1ak6R2
        cMV12FPDcbwCaMO+IM/Fqty3hSGkC8c7nBiB
X-Google-Smtp-Source: AGHT+IEHsC9eapQFmh1S59jpY0V6BKXc9Z26PLodm/GELAFzExo6+taqttZJeidNnlaBJOGWd6B84w==
X-Received: by 2002:a17:907:96a9:b0:9bf:a01c:8213 with SMTP id hd41-20020a17090796a900b009bfa01c8213mr5493708ejc.11.1697472227043;
        Mon, 16 Oct 2023 09:03:47 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id gu9-20020a170906f28900b00982a92a849asm4283868ejb.91.2023.10.16.09.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 09:03:46 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9b2cee55056so829314766b.3;
        Mon, 16 Oct 2023 09:03:46 -0700 (PDT)
X-Received: by 2002:a17:907:74b:b0:9bd:a669:d682 with SMTP id
 xc11-20020a170907074b00b009bda669d682mr8603309ejb.20.1697472226085; Mon, 16
 Oct 2023 09:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
In-Reply-To: <20231016-bt-bcm4377-quirk-broken-le-coded-v1-1-52ea69d3c979@jannau.net>
From:   Neal Gompa <neal@gompa.dev>
Date:   Mon, 16 Oct 2023 12:03:09 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8rBdgAnpxfW_jP6io1x0MxLu+x_AHbCGrTmjc8XKCLiQ@mail.gmail.com>
Message-ID: <CAEg-Je8rBdgAnpxfW_jP6io1x0MxLu+x_AHbCGrTmjc8XKCLiQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED
To:     j@jannau.net
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 3:13 AM Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> bcm4378 and bcm4387 claim to support LE Coded PHY but fail to pair
> (reliably) with BLE devices if it is enabled.
> On bcm4378 pairing usually succeeds after 2-3 tries. On bcm4387
> pairing appears to be completely broken.
>
> Cc: stable@vger.kernel.org # 6.4.y+
> Link: https://discussion.fedoraproject.org/t/mx-master-3-bluetooth-mouse-doesnt-connect/87072/33
> Link: https://github.com/AsahiLinux/linux/issues/177
> Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
> index 19ad0e788646..a61757835695 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -512,6 +512,7 @@ struct bcm4377_hw {
>         unsigned long disable_aspm : 1;
>         unsigned long broken_ext_scan : 1;
>         unsigned long broken_mws_transport_config : 1;
> +       unsigned long broken_le_coded : 1;
>
>         int (*send_calibration)(struct bcm4377_data *bcm4377);
>         int (*send_ptb)(struct bcm4377_data *bcm4377,
> @@ -2372,6 +2373,8 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>                 set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev->quirks);
>         if (bcm4377->hw->broken_ext_scan)
>                 set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
> +       if (bcm4377->hw->broken_le_coded)
> +               set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
>
>         pci_set_drvdata(pdev, bcm4377);
>         hci_set_drvdata(hdev, bcm4377);
> @@ -2461,6 +2464,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
>                 .bar0_core2_window2 = 0x18107000,
>                 .has_bar0_core2_window2 = true,
>                 .broken_mws_transport_config = true,
> +               .broken_le_coded = true,
>                 .send_calibration = bcm4378_send_calibration,
>                 .send_ptb = bcm4378_send_ptb,
>         },
> @@ -2474,6 +2478,7 @@ static const struct bcm4377_hw bcm4377_hw_variants[] = {
>                 .has_bar0_core2_window2 = true,
>                 .clear_pciecfg_subsystem_ctrl_bit19 = true,
>                 .broken_mws_transport_config = true,
> +               .broken_le_coded = true,
>                 .send_calibration = bcm4387_send_calibration,
>                 .send_ptb = bcm4378_send_ptb,
>         },
>
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20231016-bt-bcm4377-quirk-broken-le-coded-599688e3c4a0
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
