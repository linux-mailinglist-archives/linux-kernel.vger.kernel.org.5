Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D287B477D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjJAMtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjJAMtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:49:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E7AA7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 05:49:06 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-504a7f9204eso5862673e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696164545; x=1696769345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cptbJIS4rsn75uiezvpL7vtIzzmW/GLryxnEaPJIxYY=;
        b=c/g11L6d0yk4XEwVnGUU8fWjPvsl4TH+bGFzlE6MiGIYkbqBsJh+uCLNGbAPy+bVDU
         GaolPRv2Ait0egdXwqukDdlGQJTAqlm6mPxyb+vg7x/2FFYLe3Su5hKCoSiMZlOI1odB
         R//YPAoXHc+rwVGjPO5d66sOAnZj8A0WZHzdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696164545; x=1696769345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cptbJIS4rsn75uiezvpL7vtIzzmW/GLryxnEaPJIxYY=;
        b=NizJO30LmuBTGlLEpXtaxxYyRKX0PWZDgu9KA5xqvqDnHP0n+SKR/6FK5ZPHs4NLQ0
         bMQsjLzMS2O2tgwg+OT4yVcSApUbLoSTOHFDZvIG6Tabqb8j5rPKQpItfQPO4kqHrHLu
         C9KVhtxIoapJUg5KMYL+W1Mf4sM3sjzq5y9lLtcPUPcU3EkDf4Mq+aC0ONRV1IO4fSOd
         x/6bZVG/nnm/gIfXOQbkDFM3Zxf5msiRzfyaZCjMR8kOZes8kJzv/vuw2uXLvLIJi2Nq
         nMT81V2avwUp0nXCWd6w2u8damRS2raGLa3Nj9/tjWg3hvhkNS8xR/SXczZ3zmOy49co
         /OYA==
X-Gm-Message-State: AOJu0YwI1U0VS0j5qOiNccvP+Iz8RFRtxynVhI89VWf9s1G76gUR2Ubm
        0uS8OkS8mxjfzihUjMCZQv5bQdYSf+eRcrSy/MFzsw==
X-Google-Smtp-Source: AGHT+IFtYB6VrI4/nVYEF4xxHX07+DnBy9f4Oad+4cRM03oApEDd+kmbhrTCTUUH5j/nna70Iizhf3pSWZacr9NZKQQ=
X-Received: by 2002:a05:6512:250e:b0:503:35b3:aa31 with SMTP id
 be14-20020a056512250e00b0050335b3aa31mr7884556lfb.27.1696164544921; Sun, 01
 Oct 2023 05:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com> <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
 <ac1acda2-7d90-44e3-8931-f2a73fa16b15@app.fastmail.com> <CA+-6iNwj3qUPO99zTCimywyC9sV2aRYw3-TuVQTP8NYWD3LaLg@mail.gmail.com>
 <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com> <CA+-6iNwmkV0PagHehOhnYxOjwURhXZy-GnVzhkBL+9YaGMRmgQ@mail.gmail.com>
 <edc3a774-adc0-4873-8ebe-a346b51cb9ca@app.fastmail.com>
In-Reply-To: <edc3a774-adc0-4873-8ebe-a346b51cb9ca@app.fastmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Sun, 1 Oct 2023 08:48:52 -0400
Message-ID: <CA+-6iNxxWtZ32F4AR9jbp3upvouF29WYDTAn-QHetx4yOD6hvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: Select DMA_DIRECT_REMAP to fix restricted DMA
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Claire Chang <tientzu@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003457d50606a715bd"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003457d50606a715bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 3:52=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Sep 29, 2023, at 15:24, Jim Quinlan wrote:
> > On Thu, Sep 28, 2023 at 11:17=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
> >> On Thu, Sep 28, 2023, at 10:00, Jim Quinlan wrote:
> >
> > Our RC is definitely not coherent with the ARM/ARM64 caches.
>
> Ok, thanks for the confirmation.
>
> >> It's unlikely but not impossible, as the driver has some
> >> unusual constructs, using a lot of coherent mappings that
> >> might otherwise be streaming mappings, and relying on
> >> dma_sync_single_for_device(..., DMA_BIDIRECTIONAL) for other
> >> data, but without the corresponding dma_sync_single_for_cpu().
> >> If all the testing happens on x86, this might easily lead
> >> to a bug that only shows up on non-coherent systems but
> >> is never seen during testing.
> >>
> >> If the problem is not the "dma-coherent" property, can you
> >> double-check if using a different PCIe device works, or narrow
> >> down which specific buffer you saw get corrupted?
> >
> > I've done some testing, below are the results.  The new two devices, a
> > USB controller
> > and an M2 NVMe stick, behave the same as iwlwifi.
> >
> > Note that I'm not advocating that "select DMA_DIRECT_REMAP" is the
> > anser, I'm just showing that it fixes my examples.
>
> Ok, so I think we can stop looking at the device drivers for
> bugs then.
>
> > VER      PCI-DEV                       <--------- RESTRICTED DMA ------=
--->
> >                       ARM64    ARM     ARM64    ARM    ARM+DMA_DIRECT_R=
EMAP
> > 5.15     iwlwifi        P       P        P       F             P
> > 5.15     nvme           P       P        P       F             P
> > 5.15     usb            P       P        P       F             P
> >
> > 6.1      iwlwifi        P       P        P       F             P
> > 6.1      nvme           P       P        P       F             P
> > 6.1      usb            P        P       P       F             P
> >
> > Upstrm   iwlwifi        P       P        F       F             F
> > Upstrm   nvme           P       P        F       F             F
> > Upstrm   usb            P       P        F       F             F
> >                       ARM64    ARM     ARM64    ARM    ARM+DMA_DIRECT_R=
EMAP
> > VER      PCI-DEV                       <--------- RESTRICTED DMA ------=
--->
> >
> > LEGEND:
> >   P       :=3D pass, driver probe and some functional test performed
> >   F       :=3D fail, usually when probe is called; impossible to do
> > functional test
> >   Upstrm  :=3D 633b47cb009d "Merge tag 'scsi-fixes' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi"
> >
> >   iwlwifi :=3D 7260 Wifi 8086:08b1
> >   nvme    :=3D 1e95:1007
> >   usb     :=3D Supahub, 1912:0014
>
> Thanks for the thorough testing, that looks very useful, even though
> I don't have an answer immediately. Maybe Robin can see something
> here that I don't.
>
> It's particularly interesting how arm64 only started failing
> on fairly recent kernels, so if nothing else helps you could
> always try bisecting the history between 6.1 and 633b47cb009d,
> hoping that the commit that broke it points us to the arm32
> problem.
>
> The only change I see in that time frame that seems related
> is 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache
> invalidation from arch_dma_prep_coherent()"""), so you could
> start by reverting that. However, it's probably something
> else since this is for the coherent mappings, not the
> streaming ones.

Hi Arnd,

I started to do the bisection and it was clear early on that something
else was afoot --
it turns out that our 6.1 and 5.15 builds included a NAK'd upstream
commit which was required
by our legacy DT tree.  Once I updated our DT tree, the upstream results ma=
tched
those of 6.1 and 5.15.  I've included the new results below.

Long story short, it appears that restricted DMA does not work with ARCH=3D=
arm
platforms using non-dma-coherent devices.  AFAICT, the
dma_alloc_coherent() function
should return a pointer to an uncacheable page -- the only way our system c=
an
have coherent memory -- but it is not.

The "select DMA_DIRECT_REMAP" makes things work in 5.15, 6.1 and upstream,
although I cannot really say if that is a viable solution.

Regards,
Jim Quinlan
Broadcom STB/CM

VER      PCI-DEV                       <--------- RESTRICTED DMA --------->
                      ARM64    ARM     ARM64    ARM    ARM+DMA_DIRECT_REMAP
5.15     iwlwifi        P       P        P       F             P
5.15     nvme           P       P        P       F             P
5.15     usb            P       P        P       F             P

6.1      iwlwifi        P       P        P       F             P
6.1      nvme           P       P        P       F             P
6.1      usb            P       P        P       F             P

Upstrm   iwlwifi        P       P        P       F             P
Upstrm   nvme           P       P        P       F             P
Upstrm   usb            P       P        P       F             P
                      ARM64    ARM     ARM64    ARM    ARM+DMA_DIRECT_REMAP
VER      PCI-DEV                       <--------- RESTRICTED DMA --------->

LEGEND:
  P       :=3D pass, driver probe and some functional test performed
  F       :=3D fail, usually when probe is called; impossible to do
functional test
  Upstrm  :=3D 633b47cb009d "Merge tag 'scsi-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi"

  iwlwifi :=3D 7260 Wifi 8086:08b1
  nvme    :=3D 1e95:1007
  usb     :=3D Supahub, 1912:0014
>
>        Arnd

--0000000000003457d50606a715bd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mOAplh6h3nMZUZxBguxG3g2p3iD4EgibUYneEzqOQafIQB/naf2uetKb8y9jKgWJxq2Y4y8Jqg2u
uVIO1AyOJjWwqdgN+QhuIlat+qZd03P48Gim9ZPEMDUCAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFGx/E27aeGBP2eJktrILxlhK
z8f6MA0GCSqGSIb3DQEBCwUAA4IBAQBdQQukiELsPfse49X4QNy/UN43dPUw0I1asiQ8wye3nAuD
b3GFmf3SZKlgxBTdWJoaNmmUFW2H3HWOoQBnTeedLtV9M2Tb9vOKMncQD1f9hvWZR6LnZpjBIlKe
+R+v6CLF07qYmBI6olvOY/Rsv9QpW9W8qZYk+2RkWHz/fR5N5YldKlJHP0NDT4Wjc5fEzV+mZC8A
AlT80qiuCVv+IQP08ovEVSLPhUp8i1pwsHT9atbWOfXQjbq1B/ditFIbPzwmwJPuGUc7n7vpmtxB
75sSFMj27j4JXl5W9vORgHR2YzuPBzfzDJU1ul0DIofSWVF6E1dx4tZohRED1Yl/T/ZGMYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMSO43VW7D5NP1X/KD
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB9IHGoQ43+KuyYP8oVe3DktguuwcjO
hwwH17hShaDTNjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzEw
MDExMjQ5MDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAL/yM/QvAr+8I3HC1v5Vwy9Sm+ynsWKkV/pXZrmVrCI3mweVc
PZcgHbkGc6HqcLFRBgWgwhHrXcAx+x/9mUp5Kvve6PMhpJMDsJqkHyn3rpRq2PLBbwIWRvZE7EJw
CcycmIPyaggezmwAWaQrHEkCJtPsvmrdLBdQ/n5m3jp6dIEAgDqKKu77XMUQBJLHbD3kVZvRCDk8
4csIXeGsvBxzkJUd3uVfOOyAiyIhr187NiWozvtVhzTBZ6P1OSaNAAc08u97C5RaxRFy+t9vngDV
Asj2HgYkmjqyaLRlWPP0wdgoiudUykZvF00WK2p7/y0cxiDx7jvQ8WmNgRVSi2oWDQ==
--0000000000003457d50606a715bd--
