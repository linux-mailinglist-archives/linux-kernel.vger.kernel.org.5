Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8647DE36A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjKAP1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjKAP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:27:31 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5A128;
        Wed,  1 Nov 2023 08:27:21 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9d465d1c86bso475720566b.3;
        Wed, 01 Nov 2023 08:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852440; x=1699457240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHvK9y12HVFPPCcFRFW7IlBRtyM+hFYAm7yaHjfI6As=;
        b=BEjtnptBIXWsWqMVxrtr/t+BsmCgtB5G0zI1BF8jbh9lLyOdDbou4RxcGtcVFsVRQt
         jZFiAiSS1Khto93EgPEj1T40x/59e+Q8aedSk50VgeyaVLu9zHj6eHhPkvEwq5GMKCS/
         0m4Sz3V7pJEvCqbITcF5CRuchACfiSJt6AZ6p8GAE//9TEND+QaZxXrcFF6jVfpGQU36
         S5wD3sSczgJf6kv3WT/8RXo7UbyDcfkmicpNfdiOBumPpE2MsiFi4cj6SiCNaIREG8sq
         w1omYa+B3vE6WZTa3ugtxp13i5g0MK0tqEi9/qnOZ3Y3G5P1jY6bb0MZvitrPdblbmt5
         UW5Q==
X-Gm-Message-State: AOJu0YwR9+/a19spHvOFipZ6k1MYtZ1QvQLCfvAwelVbsFDExWe2e3fa
        kEYTFjEJUwF8trBQWfwzp3xKFRbFgv0/Wg==
X-Google-Smtp-Source: AGHT+IFZKt4Lx3IHvtCFOtDHkfMl4Fy5MbihEW3uZZKr+F3k301Bk2ffmCEH8dfncR2/IiWTk6foFw==
X-Received: by 2002:a17:907:7641:b0:9da:ee00:a023 with SMTP id kj1-20020a170907764100b009daee00a023mr609747ejc.30.1698852439384;
        Wed, 01 Nov 2023 08:27:19 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id f6-20020a170906560600b009ae587ce133sm45622ejq.188.2023.11.01.08.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 08:27:19 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so10880999a12.3;
        Wed, 01 Nov 2023 08:27:19 -0700 (PDT)
X-Received: by 2002:a17:906:db0d:b0:9d3:ccd1:a905 with SMTP id
 xj13-20020a170906db0d00b009d3ccd1a905mr2191785ejb.51.1698852439007; Wed, 01
 Nov 2023 08:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231101095533.45258-1-tom@baremetal.dev> <ZUJoFAcKMrVD5Glo@lore-desk>
In-Reply-To: <ZUJoFAcKMrVD5Glo@lore-desk>
From:   Tom Waldron <tom@baremetal.dev>
Date:   Wed, 1 Nov 2023 15:26:46 +0000
X-Gmail-Original-Message-ID: <CANjHDnBkCW_zQxyCcKcyrZOYnnLNVKT1Z2AJr6x6DT55UZ+A7Q@mail.gmail.com>
Message-ID: <CANjHDnBkCW_zQxyCcKcyrZOYnnLNVKT1Z2AJr6x6DT55UZ+A7Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] wifi: mt76: mt7921: Add a new VID/PID 0b48/7922 for MT7922
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI VID 0x0b48 doesn't appear to be listed anywhere I can find, though
a website named pcilookup.com suggests it belongs to TechnoTrend AG. I
think it's more likely to be part of AMD RZ600 series - rebranded
mediatek devices. Not sure how any of this might be verified.

On Wed, 1 Nov 2023 at 15:00, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Add VID/PID 0b48/7922 for MediaTek MT7922 wifi chip.
> > Change tested on Redmi Book Pro 15 2023 (Fedora 38).
> >
> > Signed-off-by: Tom Waldron <tom@baremetal.dev>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > index 3dda84a93..ba805cb02 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > @@ -21,6 +21,8 @@ static const struct pci_device_id mt7921_pci_device_table[] = {
> >               .driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
> >       { PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
> >               .driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
> > +     { PCI_DEVICE(0x0b48, 0x7922),
> > +             .driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
>
> is PCI VID 0x0b48 PCI_VENDOR_ID_ITTIM?
>
> Regards,
> Lorenzo
>
> >       { },
> >  };
> >
> > --
> > 2.41.0
> >
