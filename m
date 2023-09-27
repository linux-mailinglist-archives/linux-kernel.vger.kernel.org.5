Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913F87B0C48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjI0S4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0S4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:56:33 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256DCE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:56:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3514ece5ed4so25665ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695840991; x=1696445791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MurAOYPXjHwdvk7TTp2tGZ93V7FzPadwfJU/w4cmONw=;
        b=DvDOXEHdf1DMo4hA8062CsntcoQIINGW9C5+Gbt8xqVQNf3rJPkLKD4W7q/h48qDkw
         3mrKF+7EjHo1K7FCVtpcvId7lGGQeLyQs7loHnx5zW0gQRXU1MiGxbHUe9Ke9T/tXtf1
         bhSSWt94dT0Cv0GSnWEi8QHLSliSZW74DmHd1nFXNSvjAInUF+I3XzsHmCiuVJGByYSs
         RPj6i3k7PJbAXFcp4JvMC2tlEUV1R6Lk4fTFVtNOXAMr1j59eUzTTa9bozKak6E40O0d
         TZh6ibCFjham7wQQEdJD1G8JXsBsSNJedXcG1NfGNo3MdUWKM6A/jpKcjuzrJj1X1Wsl
         yJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695840991; x=1696445791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MurAOYPXjHwdvk7TTp2tGZ93V7FzPadwfJU/w4cmONw=;
        b=CELALkhtLnM4j8iA2WjNydRBRGJMQ7IUvv9X40Zbio0D07ltTFsRXOzk/Ypuv1TjQl
         7DZVfSSBGA/ZXEgPioIyY4bOMeQN4Vrgrrp6p+Zj1LoR0hx0k26zcoCCuUaLo9KQROmx
         Baafd0E+6xzkZ+GaqziKdqJonEwP5TNE695x62gbVu6Y/6eUJZ/zXwn+K34VsTmyZvUu
         YbeQCcAIJnK2Bs1+LjdN9UO3L0kSNk4YulJCv/R8Udx1n6LeFTcRNRr7xNGDCHKMyy2f
         3c4ObKBp0sRyDo4XTTF3x558jLsjpiGuFzE6jUPwFG9EPU7MOFr47m7OzTkXKp1jbNZa
         Vhsg==
X-Gm-Message-State: AOJu0YzCYcou2X0jGyWopeYycqG0euQD8f//rT1w4BSk0/mbiwdTpMt+
        9cQvRaKtgGRR2DdKM2KO3lTyQ12nwuVe+LEmHzQk
X-Google-Smtp-Source: AGHT+IHpy0ebrOGWKBvJhgjGq+yQihXMl6pVYmNyHBVx+lU9W2/wuviNywEw1Opgza+nHML4UERjWiWazlDFeUjnHnI=
X-Received: by 2002:a05:6e02:1988:b0:34f:71b0:e72b with SMTP id
 g8-20020a056e02198800b0034f71b0e72bmr693354ilf.27.1695840991320; Wed, 27 Sep
 2023 11:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230911023038.30649-1-yong.wu@mediatek.com> <20230911023038.30649-6-yong.wu@mediatek.com>
 <d0373c02-9b22-661f-9930-ca720053c2a0@collabora.com> <a115a2a5d3ac218e6db65ccdb0a1876f9cfca02b.camel@mediatek.com>
 <d798b15b-6f35-96db-e3f7-5c0bcc5d46a2@collabora.com> <a4ecc2792f3a4d3159e34415be984ff7d5f5e263.camel@mediatek.com>
 <20230927134614.kp27moxdw72jiu4y@pop-os.localdomain> <3aaafe47-3733-a4d5-038d-a7e439309282@collabora.com>
In-Reply-To: <3aaafe47-3733-a4d5-038d-a7e439309282@collabora.com>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 27 Sep 2023 11:56:20 -0700
Message-ID: <CA+ddPcP4=p37cV5Tbn5zTUbiL4ou+Yqb=5rS+O_ff8ZUw64D3Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] dma-buf: heaps: mtk_sec_heap: Initialise tee session
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     Joakim Bech <joakim.bech@linaro.org>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "jstultz@google.com" <jstultz@google.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?= 
        <Jianjiao.Zeng@mediatek.com>,
        =?UTF-8?B?S3VvaG9uZyBXYW5nICjnjovlnIvptLsp?= 
        <kuohong.wang@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Brian.Starkey@arm.com" <Brian.Starkey@arm.com>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 8:18=E2=80=AFAM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 27/09/2023 =C3=A0 15:46, Joakim Bech a =C3=A9crit :
> > On Mon, Sep 25, 2023 at 12:49:50PM +0000, Yong Wu (=E5=90=B4=E5=8B=87) =
wrote:
> >> On Tue, 2023-09-12 at 11:32 +0200, AngeloGioacchino Del Regno wrote:
> >>> Il 12/09/23 08:17, Yong Wu (=E5=90=B4=E5=8B=87) ha scritto:
> >>>> On Mon, 2023-09-11 at 11:29 +0200, AngeloGioacchino Del Regno
> >>>> wrote:
> >>>>> Il 11/09/23 04:30, Yong Wu ha scritto:
> >>>>>> The TEE probe later than dma-buf heap, and PROBE_DEDER doesn't
> >>>>>> work
> >>>>>> here since this is not a platform driver, therefore initialise
> >>>>>> the
> >>>>>> TEE
> >>>>>> context/session while we allocate the first secure buffer.
> >>>>>>
> >>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >>>>>> ---
> >>>>>>     drivers/dma-buf/heaps/mtk_secure_heap.c | 61
> >>>>>> +++++++++++++++++++++++++
> >>>>>>     1 file changed, 61 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/dma-buf/heaps/mtk_secure_heap.c
> >>>>>> b/drivers/dma-
> >>>>>> buf/heaps/mtk_secure_heap.c
> >>>>>> index bbf1c8dce23e..e3da33a3d083 100644
> >>>>>> --- a/drivers/dma-buf/heaps/mtk_secure_heap.c
> >>>>>> +++ b/drivers/dma-buf/heaps/mtk_secure_heap.c
> >>>>>> @@ -10,6 +10,12 @@
> >>>>>>     #include <linux/err.h>
> >>>>>>     #include <linux/module.h>
> >>>>>>     #include <linux/slab.h>
> >>>>>> +#include <linux/tee_drv.h>
> >>>>>> +#include <linux/uuid.h>
> >>>>>> +
> >>>>>> +#define TZ_TA_MEM_UUID          "4477588a-8476-11e2-ad15-
> >>>>>> e41f1390d676"
> >>>>>> +
> >>>>> Is this UUID the same for all SoCs and all TZ versions?
> >>>> Yes. It is the same for all SoCs and all TZ versions currently.
> >>>>
> >>> That's good news!
> >>>
> >>> Is this UUID used in any userspace component? (example: Android
> >>> HALs?)
> >> No. Userspace never use it. If userspace would like to allocate this
> >> secure buffer, it can achieve through the existing dmabuf IOCTL via
> >> /dev/dma_heap/mtk_svp node.
> >>
> > In general I think as mentioned elsewhere in comments, that there isn't
> > that much here that seems to be unique for MediaTek in this patch
> > series, so I think it worth to see whether this whole patch set can be
> > made more generic. Having said that, the UUID is always unique for a
> > certain Trusted Application. So, it's not entirely true saying that the
> > UUID is the same for all SoCs and all TrustZone versions. It might be
> > true for a family of MediaTek devices and the TEE in use, but not
> > generically.
> >
> > So, if we need to differentiate between different TA implementations,
> > then we need different UUIDs. If it would be possible to make this patc=
h
> > set generic, then it sounds like a single UUID would be sufficient, but
> > that would imply that all TA's supporting such a generic UUID would be
> > implemented the same from an API point of view. Which also means that
> > for example Trusted Application function ID's needs to be the same etc.
> > Not impossible to achieve, but still not easy (different TEE follows
> > different specifications) and it's not typically something we've done i=
n
> > the past.
> >
> > Unfortunately there is no standardized database of TA's describing what
> > they implement and support.
> >
> > As an alternative, we could implement a query call in the TEE answering=
,
> > "What UUID does your TA have that implements secure unmapped heap?".
> > I.e., something that reminds of a lookup table. Then we wouldn't have t=
o
> > carry this in UAPI, DT or anywhere else.
>
> Joakim does a TA could offer a generic API and hide the hardware specific
> details (like kernel uAPI does for drivers) ?
It would have to go through another layer (like the tee driver) to be
a generic API. The main issue with TAs is that they have UUIDs you
need to connect to and specific codes for each function; so we should
abstract at a layer above where those exist in the dma-heap code.
>
> Aside that question I wonder what are the needs to perform a 'secure' pla=
yback.
> I have in mind 2 requirements:
> - secure memory regions, which means configure the hardware to ensure tha=
t only
> dedicated hardware blocks and read or write into it.
> - set hardware blocks in secure modes so they access to secure memory.
> Do you see something else ?
This is more or less what is required, but this is out of scope for
the Linux kernel since it can't be trusted to do these things...this
is all done in firmware or the TEE itself.
>
> Regards,
> Benjamin
>
> >
