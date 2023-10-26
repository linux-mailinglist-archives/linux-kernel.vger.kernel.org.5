Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501F57D8C11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344988AbjJZXGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZXGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:06:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68D1A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:06:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c3c8adb27so212759966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698361601; x=1698966401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1lvafxgrPH4MslhVVJ8PWeokuJA7ysCGpjbxciD6xM=;
        b=bF6cjHGXTw3/WdHfWmaOJ21pk5MQTrlv9hdBKufNmuIirAaGYhBCm82d6Mvf43tJxV
         eAU5dRjr75zhYpbDUzJO/DreR1IO+gsxZzzF87aHJqNWsVUVl3v8HVMmt0s6R0mW7kOG
         UiVvur1BEZK17alNNRWzy+5vcDjOtvEcvGEbZ7d5RvKq7vVHiT6wJZfMD8K6b0uL3dkc
         3X+4V8jg8HdrjgGm9PRfKuzxSml0xn+BYQuI2urbdM42f28KcSadCZLVHruDlHUu8Mep
         FWRWScFCNKbjJnpGaSBCM/doeIPIbRz9MWHupCqC31U+euNTuUMEGktD6NsqTHdABQ4y
         +5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698361601; x=1698966401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1lvafxgrPH4MslhVVJ8PWeokuJA7ysCGpjbxciD6xM=;
        b=Hd1zrSdJCCIE394P7OS0hbQ60CX4+cwPHLP9TNoMta8y67X+XPsX8yo1uWKtUZA7r/
         oU4HwuILwXeRCoUvMIod1BqH/bYCw/xCpun1dUatJR9EverFyNJaag/nShaFwRK+wRlu
         OzaVVjuubPKtIrhAcdpUGH1sEUu54Qng0jCzComm3EVzgHJKjGDrzIxhUYONsphXU82V
         FtMrU81d5xqviuEc8oV8e89Z5JcON1bz3QrXjPuQD8aC0nB5Qba8Q+0uHYknWoGXx4AT
         y+ydNUfGXhym6LXXPDZm7AVvWG8ObpqEf+6Eec7Tdsu3pboq/xZSOwXx+VstyuDurGGF
         MAqQ==
X-Gm-Message-State: AOJu0Yxvs5Xf6aS7UFts1a5GaWMn5LwX1jDP6ikonr0lp1z5kU3AAnqJ
        ndbOAsxThHCIEVBgvoVNuVzQu5JEY10gSM5G8ZE=
X-Google-Smtp-Source: AGHT+IGxmHbbMVWBC/bICXPWqiak9mqMZ+cfACESgbJx35V7lt5rWdCzi2NT9XuSrO2RdKAwoa9UzoocTNcZXwV4X6s=
X-Received: by 2002:a17:906:fd8b:b0:9bf:30e8:5bfd with SMTP id
 xa11-20020a170906fd8b00b009bf30e85bfdmr892154ejb.48.1698361601374; Thu, 26
 Oct 2023 16:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
 <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info> <16885654-09f0-c139-cc9b-c6c4d666932e@quicinc.com>
 <ae1ad814-5613-704e-b0b1-4f1fc4bead44@leemhuis.info> <1945f748-fb71-f1c1-83a2-ba0470daf817@quicinc.com>
 <ZPUXMx0H/8U9j15F@luigi.stachecki.net> <1ba68ccb-9faa-8f9f-64cb-cf74dc0a2184@quicinc.com>
In-Reply-To: <1ba68ccb-9faa-8f9f-64cb-cf74dc0a2184@quicinc.com>
From:   Tyler Stachecki <stachecki.tyler@gmail.com>
Date:   Thu, 26 Oct 2023 19:06:49 -0400
Message-ID: <CAC6wqPUFkXqT5t2jQxtDPfUtjUVLkKyzWawwDOxW7h_74PxhZQ@mail.gmail.com>
Subject: Re: Fwd: ath11k: QCN9074: ce desc not available for wmi command
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Atheros 11K <ath11k@lists.infradead.org>
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

On Mon, Sep 4, 2023 at 5:47=E2=80=AFAM Manikanta Pubbisetty
<quic_mpubbise@quicinc.com> wrote:
> > Hi Manikanta,
> >
> > I just wanted to report that this is likely related to QCN9074 when the=
 host
> > system only has 1 MSI-X vector available for the modem and/or related t=
o a
> > product named "WPEQ-405AX".
> >
> > I have two different hosts running the exact same kernel, same QCN9074
> > firmware (WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1), etc. The only
> > differences are that the one which does not work is running on a slight=
ly
> > older Intel SBC, with the older one leveraging mPCIe instead of PCIe an=
d
> > only having one MSI-X vector.
>
> Yes, you are right. This seems to be a problem with some hardware having
> QCN9074. We have tried to reproduce this problem in QC on different
> hardware but could not reproduce it even once. Not even with one MSI vect=
or.

Just as a heads up, this "Sparklan WPEQ-405AX" version of QCN9074 may
be adding to some of the confusion here and so there may be two
problems. As mentioned previously, CE desc errors stopped after
reverting the threaded NAPI patch. However, there's something odd
about this modem - it does not work with the board-2.bin that Kalle
provides as the OP noted.

Upon request, the vendor of this modem provides a board.bin for
WPEQ-405AX compatible with a copy of amss/m3 which appears to be
WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1 (based on checksums). I
found out the hard way that the ABI of the BDFs changed for
WLAN.HK.2.5.0 firmwares and beyond, making things non-backwards
compatible with the board.bin that the vendor provides.. which is
unfortunate as the vendor would not supply a BDF built against 2.5.0+
when requested.

The board-2.bin that Kalle allows the modem start, but it fails to
associate or really do anything useful beyond announcing a SSID in AP
mode.

Anyways: I think it's mostly just an issue with the IRQ affinity --
maybe the threaded NAPI patch is changing it somehow...

Cheers,
Tyler
