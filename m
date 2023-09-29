Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA207B3AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjI2TYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjI2TYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:24:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4512F5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:24:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50573e85ee0so376306e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696015479; x=1696620279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DbPV7/IdmlKS5g8YDCHE5Fpunuwb35Fd9WB5+TsP6Us=;
        b=DlVPJLedokuVhsDodqfvIfz6nJU0v367sTPpyv+GxUFnIiRnRxFd3q3AQILZxcDJWH
         MwQ9/T0XeQJ5kRWpfoEiER48Wb1rocYmeDC3cd9/Xw37Qvkw3CWAsA4JlLTkTR4t1gNO
         /poWvKpaXM4hMxWQ2t65ac1fCEkf42xxQMBhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696015479; x=1696620279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbPV7/IdmlKS5g8YDCHE5Fpunuwb35Fd9WB5+TsP6Us=;
        b=cMBw1XDGtvw9WgElZ5+1wJctszrHTChTNAudMw+qJ9czmQVnRrSEzIhs2uU0bahbSF
         Grujl4Iy7jVpWscvLxk4kTqQDeTSoH26ZbsWIzTKCEtvIliTXaoNxTv4jlBONNu+fYY2
         Vk/168nWOkMkblz4oa7sRu6RHDHrCCQsdEprKCXWRCZ8vDOcGpjHmcKluldcE19lJACd
         0RUh5TML0ryZgc86QhTOp8r9squQTZdg7ATvdcjzJkwv2YvrdiRSb4LLdzuLABHuoduG
         2+rNQZT2c3HULPBuiRJ3LuwNrrFydR9oCs67ePStXXo30k3hMoVPtV3lSKIh3dhOZ/x6
         6x2A==
X-Gm-Message-State: AOJu0Yw9jXQK0Dc3bCl5gCt/Ied1G7ZgSSFEWkrH/jaeo3db7Lgq33jE
        l0jWEe6GLumFjwOmu0b538mSAcQ93DLti2jfZM5R/g==
X-Google-Smtp-Source: AGHT+IFHJCtnxC11jPcAM/9afvN5aePSSFw/RD0/+NVTHix7uuMWrY6a+mqS+lBaz32dbOq14yiRSJjiJsus6zO6HrM=
X-Received: by 2002:a05:6512:401a:b0:503:446:c7b0 with SMTP id
 br26-20020a056512401a00b005030446c7b0mr5629406lfb.32.1696015478830; Fri, 29
 Sep 2023 12:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com> <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
 <ac1acda2-7d90-44e3-8931-f2a73fa16b15@app.fastmail.com> <CA+-6iNwj3qUPO99zTCimywyC9sV2aRYw3-TuVQTP8NYWD3LaLg@mail.gmail.com>
 <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com>
In-Reply-To: <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 29 Sep 2023 15:24:27 -0400
Message-ID: <CA+-6iNwmkV0PagHehOhnYxOjwURhXZy-GnVzhkBL+9YaGMRmgQ@mail.gmail.com>
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
        Claire Chang <tientzu@chromium.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002d0afd06068460d3"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002d0afd06068460d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:17=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Thu, Sep 28, 2023, at 10:00, Jim Quinlan wrote:
> > On Thu, Sep 28, 2023 at 9:32=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >>
> >> On Thu, Sep 28, 2023, at 08:07, Jim Quinlan wrote:
> >> > On Wed, Sep 27, 2023 at 7:10=E2=80=AFPM Linus Walleij <linus.walleij=
@linaro.org> wrote:
> >> >>
> >> >> Clearly if you want to do this, surely the ARM-specific
> >> >> arch/arm/mm/dma-mapping.c and arch/arm/mm/dma-mapping-nommu.c
> >> >> needs to be removed at the same time?
> >> >
> >> >
> >> > Yes, this is the reason I used "RFC" as the fix looked too easy to b=
e viable :-)
> >> > I debugged it enough to see that the host driver's
> >> > writes to the dma_alloc_coherent() region  were not appearing in
> >> > memory, and that
> >> > led me to DMA_DIRECT_REMAP.
> >>
> >> Usually when you see a mismatch between the data observed by the
> >> device and the CPU, the problem is an incorrect "dma-coherent"
> >> property in the DT: either the device is coherent and accesses
> >> the cache but the CPU tries to bypass it because the property
> >> is missing, or there is an extraneous property and the CPU
> >> goes the through the cache but the devices bypasses it.
> >
> > I just searched, there are no "dt-coherent" properties in our device tr=
ee.
> > Also, even if we did have them, wouldn't things also fail when not usin=
g
> > restricted DMA?
>
> Correct, it should be independent of restricted DMA, but it might
> work by chance that way even if it's still wrong. If your DT
> is marked as non-coherent (note: the property to look for
> is "dma-coherent", not "dt-coherent"), can you check the
> datasheet of the SoC to if that is actually correct?

Our PCIe RC device is not dma-coherent.

>
> If the chip is designed to support high-speed devices on
> PCIe, it's likely that the PCIe root complex is either coherent
> with the caches, or can (and should) be configured that way
> for performance reasons.

Our RC is definitely not coherent with the ARM/ARM64 caches.

>
> >> It could also be a driver bug if the device  mixes up the
> >> address spaces, e.g. passing virt_to_phys(pointer) rather
> >> than the DMA address returned by dma_alloc_coherent().
> >
> > This is an Intel 7260 part using the iwlwifi driver, I doubt it has
> > errors of that kind.
>
> It's unlikely but not impossible, as the driver has some
> unusual constructs, using a lot of coherent mappings that
> might otherwise be streaming mappings, and relying on
> dma_sync_single_for_device(..., DMA_BIDIRECTIONAL) for other
> data, but without the corresponding dma_sync_single_for_cpu().
> If all the testing happens on x86, this might easily lead
> to a bug that only shows up on non-coherent systems but
> is never seen during testing.
>
> If the problem is not the "dma-coherent" property, can you
> double-check if using a different PCIe device works, or narrow
> down which specific buffer you saw get corrupted?

I've done some testing, below are the results.  The new two devices, a
USB controller
and an M2 NVMe stick, behave the same as iwlwifi.

Note that I'm not advocating that "select DMA_DIRECT_REMAP" is the
anser, I'm just
showing that it fixes my examples.

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
6.1      usb            P        P       P       F             P

Upstrm   iwlwifi        P       P        F       F             F
Upstrm   nvme           P       P        F       F             F
Upstrm   usb            P       P        F       F             F
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
>      Arnd

--0000000000002d0afd06068460d3
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCvU9zFQdPiAio4kyZNzT7lWFhJLzPL
hdseC2Nu9eBnezAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA5
MjkxOTI0MzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAnI+SGGVCN20MQ19o5uBs/pbtSPzzbE5PdL92coo5Z9sLixmj
VGQU0LyYfAB5+FV60bFNQlAkQ/DjoqhLwmD+ZzvDUkVKv2YJvJKxaNK9Uu8JQeZLenQiiFRB4XZ9
WiaPCO9MTLklKUG0hP+xhTWTCwtooJxzov8mnEfQdXsrLO46H/oBXwUcUxF32TE1/Pr8o5/AFoYi
Y+dqPtUlAVcUagsyM5iCECvrjsqhvqyBP1cvBykddZEPQc40yLbybvbJvnm7bKQxUcYVUe+7cBXd
ynnQmuwN1fy8I/wHuvpD706/REdcV8SQ2UlW/go808mNk6+XHomnYfFCtvBfi1dv/A==
--0000000000002d0afd06068460d3--
