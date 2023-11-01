Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26F47DE426
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjKAPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbjKAPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:49:02 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6532910F;
        Wed,  1 Nov 2023 08:48:56 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso6012083a12.1;
        Wed, 01 Nov 2023 08:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853735; x=1699458535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gi/cA1xFlkm8PTXHxgTpI8HEV8sUdw+/4F8StYPG7eQ=;
        b=Teb+xxCVf7j816OAIyY0v/UUW8Yl+eI86BlBMl2Q0oWwjw3uc6xcmD6noK+4cH+qLU
         ROXBsarSM8lGjtDkdsDpCHGiwGYS7uivbm/If535T2EAKvQAyhXPawhGGCHMTCk9stQV
         pWxcp40E2XiNpvyKLFeXUSzk8pOnq3jZLz+B9E7+ekxi/D9IykYmfjbCOoUqM1lyK9pV
         0uYwyNwSfclKCmhf0abEXjjQ6AtFZDmEjNRHgHGZxMBd5eX4PN+yKflTg8N5+Bf2AR8m
         kWbOH///vYd1CvIpCboS7gmruq4prlAKBcHX35mUtPGD/ITHzuQnCGkqAOMyBDSjIttn
         q3ZA==
X-Gm-Message-State: AOJu0YzahEPxug4iuBX0083fva/WwcOCVrJ89SQH66CKXUwymNBx3FKf
        CSs40acKR+UenSn0QL4Cv7Wkb1V7+yWt5Q==
X-Google-Smtp-Source: AGHT+IH/ah0iMY06UCPzIAWOd57qQxthqjewOPMmCV3ayL/1OZAfjCYGsIx7KhtXc/got6EAsXUV7A==
X-Received: by 2002:a17:907:7da3:b0:9da:b2ca:6c50 with SMTP id oz35-20020a1709077da300b009dab2ca6c50mr975740ejc.72.1698853734322;
        Wed, 01 Nov 2023 08:48:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id oq8-20020a170906cc8800b0099c53c44083sm74406ejb.79.2023.11.01.08.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 08:48:54 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso1066214566b.2;
        Wed, 01 Nov 2023 08:48:54 -0700 (PDT)
X-Received: by 2002:a17:907:3ac5:b0:9c6:1143:b73 with SMTP id
 fi5-20020a1709073ac500b009c611430b73mr1494767ejc.51.1698853733927; Wed, 01
 Nov 2023 08:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231101095533.45258-1-tom@baremetal.dev> <ZUJoFAcKMrVD5Glo@lore-desk>
 <CANjHDnBkCW_zQxyCcKcyrZOYnnLNVKT1Z2AJr6x6DT55UZ+A7Q@mail.gmail.com> <ZUJwJ+bimXFVcXps@lore-desk>
In-Reply-To: <ZUJwJ+bimXFVcXps@lore-desk>
From:   Tom Waldron <tom@baremetal.dev>
Date:   Wed, 1 Nov 2023 15:48:21 +0000
X-Gmail-Original-Message-ID: <CANjHDnBsTaqPsMBtN1EU8rUdQwPu3riXcy66BTFBcJcy45HcDw@mail.gmail.com>
Message-ID: <CANjHDnBsTaqPsMBtN1EU8rUdQwPu3riXcy66BTFBcJcy45HcDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] wifi: mt76: mt7921: Add a new VID/PID 0b48/7922 for MT7922
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just realised that I had based my changes on the wrong repo(linux
stable). Also that this change has already been made in the
wireless-next repo. It seems the ITTIM vendor was used in this case.

Please ignore this submission and please accept my apologies for
taking up your time.

Regards

Tom

On Wed, 1 Nov 2023 at 15:35, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > PCI VID 0x0b48 doesn't appear to be listed anywhere I can find, though
> > a website named pcilookup.com suggests it belongs to TechnoTrend AG. I
> > think it's more likely to be part of AMD RZ600 series - rebranded
> > mediatek devices. Not sure how any of this might be verified.
>
> I have just found it here: include/linux/pci_ids.h
> but I am not sure if it is related. Anyway:
>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> >
> > On Wed, 1 Nov 2023 at 15:00, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >
> > > > Add VID/PID 0b48/7922 for MediaTek MT7922 wifi chip.
> > > > Change tested on Redmi Book Pro 15 2023 (Fedora 38).
> > > >
> > > > Signed-off-by: Tom Waldron <tom@baremetal.dev>
> > > > ---
> > > >  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > > > index 3dda84a93..ba805cb02 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> > > > @@ -21,6 +21,8 @@ static const struct pci_device_id mt7921_pci_device_table[] = {
> > > >               .driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
> > > >       { PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
> > > >               .driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
> > > > +     { PCI_DEVICE(0x0b48, 0x7922),
> > > > +             .driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
> > >
> > > is PCI VID 0x0b48 PCI_VENDOR_ID_ITTIM?
> > >
> > > Regards,
> > > Lorenzo
> > >
> > > >       { },
> > > >  };
> > > >
> > > > --
> > > > 2.41.0
> > > >
