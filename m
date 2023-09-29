Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457877B3BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjI2VNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2VNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:13:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC71AA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:13:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5031ccf004cso22808356e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1696021992; x=1696626792; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lWD7CSvvMUTAE7d/DotAGZPoPrwOJnnibuoFKT3rkWA=;
        b=Q81JSC1vHoh1gmuUICdVLAyU89XMTA//vZpSRAlky8QpSotdvAr0vpxUec3wXMhfU6
         f9LITY4JUcizNIoNJQb5uUsdeo+26PUMz9el7ElqVJhGuWyqf7T0INMjO5gECirG8ZXI
         1xYcvufv0CSuGRtBeo3xazhvaNgpmuztqpIGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021992; x=1696626792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWD7CSvvMUTAE7d/DotAGZPoPrwOJnnibuoFKT3rkWA=;
        b=B9ZG4IEBozwpuf/iukW7Rwrwk2G8O2fjoPRmKdzkDjZruh2idtVoOGyq2X4rReYI8v
         yx8d3iAKk12QkY6+QW8y1kMeE17tyw29ZUqvgtAohQW+hujId9nZlfYQr8A7Rj4fw3Dp
         61oXZZbHJnNWRwzYQ3cAQNX+2ZXb/1qUSd/E/voPdMkf8ZShAWP0sS90ZQYtbTQ/zuQo
         b6RY7jhaB2yVHPgmPHtNZJUSJiyVMRsZmFi5IGn+U0hLoP1A5FyXOtQtkEkEJvYj2Ken
         8yDQHiwIUuKIDu4+7VQpiK/ptVsyKBJNcfvS0XIx7zv/1n7HKriOuDeQUOI2CRz9MDfA
         2Icg==
X-Gm-Message-State: AOJu0Yw2XjYiIQa3AlJNCKKwsElY9pzWppHOObZhDIxywBQRfUUgfiUV
        K8NqOIgwki34iJ9uNy0rmkpiS/xGrTANDyh2L25cWw==
X-Google-Smtp-Source: AGHT+IFqh8NR7zmBSfZrgBF1fH9WXNYle01Sxlf/XOKPOs0AI8CFeRl9DydIbr1Oln0NgbRv3n79FdY1djgS2E6kF0M=
X-Received: by 2002:a19:e047:0:b0:4fd:d18f:2d93 with SMTP id
 g7-20020a19e047000000b004fdd18f2d93mr3906906lfj.6.1696021992445; Fri, 29 Sep
 2023 14:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230926175208.9298-1-james.quinlan@broadcom.com>
 <20230926175208.9298-2-james.quinlan@broadcom.com> <CACRpkdYGPpUUCqmJLT4t+6CNOOmRAh_vYPSPK1SWy+tNycnSqQ@mail.gmail.com>
 <CA+-6iNwkegPBxeksgNntrP1Cr5Edk5Q4o660NCZjKo9s8z3OOQ@mail.gmail.com>
 <ac1acda2-7d90-44e3-8931-f2a73fa16b15@app.fastmail.com> <CA+-6iNwj3qUPO99zTCimywyC9sV2aRYw3-TuVQTP8NYWD3LaLg@mail.gmail.com>
 <1f08bd12-0ac4-43ea-b058-7836521eec12@app.fastmail.com> <CA+-6iNwmkV0PagHehOhnYxOjwURhXZy-GnVzhkBL+9YaGMRmgQ@mail.gmail.com>
 <edc3a774-adc0-4873-8ebe-a346b51cb9ca@app.fastmail.com>
In-Reply-To: <edc3a774-adc0-4873-8ebe-a346b51cb9ca@app.fastmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Fri, 29 Sep 2023 17:13:00 -0400
Message-ID: <CA+-6iNx1YennqtbvNTRi8dQ=RK4LrOngQTipWkWz1Om6-CFzbA@mail.gmail.com>
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
        boundary="0000000000006a7aaf060685e48e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006a7aaf060685e48e
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

Yes I plan to do that.

There's also one other datapoint I have but have only tried it on 6.1
and 5.15 ARM  builds.
I can set a board to run its PCIe  HW in EP mode, and then connect it
to a board running its
PCIe HW in RC mode.

On the RC side, I've written a small PCIe host driver [1].  On the EP
board, I just run this shell
command when I get the prompt:

while true ; do
    for i in `seq 0 15` ; do
        devmem $(printf "0x%x" $((0x50a000000 + ($i << 16))))
    done
    echo
    sleep 1
done

You will have to take my word that I've configured the PCIe window on
the EP board at 0x5_0a000000
to correspond to the restricted memory region on the RC side (0x4a000000).
With ARM+restricted DMA  I see something like this as the output [2].
The values should appear
all at once or at least in order -- as they do on ARM64 -- but they do
not for ARM.

FWIW,
Jim Quinlan
Broadcom STB/CM

[1]
#define NUM_DMA_REGIONS 16

for (i =3D 0; i < NUM_DMA_REGIONS; i++)
        va[i] =3D dma_alloc_coherent(dev, size, &dma_addr, flags);

for (i =3D 0; i < NUM_DMA_REGIONS; i++)
        memset(va[i], 0, size/sizeof(u32));

printk("\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D START READING AT=
 EP  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n")=
;
msleep(4000);
for (i =3D 0; i < NUM_DMA_REGIONS; i++) {
        pu32 =3D va[i];
        for (j =3D 0; j < size/sizeof(u32); j +=3D 64) {
                uint32_t x =3D pu32[j];

                mdelay(3);
                pu32[j] =3D 0x12340000 + (i << 12) + j + (x & 0x0f00);
                wmb();
        }
}

[2]
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000

0x00000000
0x00000000
0x12342000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000

0x12340000
0x00000000
0x12342000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000

0x12340000
0x00000000
0x12342000
0x12343000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000

0x12340000
0x00000000
0x12342000
0x12343000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000

0x12340000
0x12341000
0x12342000
0x12343000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000

0x12340000
0x12341000
0x12342000
0x12343000
0x00000000
0x00000000
0x00000000
0x12347000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000

0x12340000
0x12341000
0x12342000
0x12343000
0x00000000
0x00000000
0x00000000
0x12347000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000
0x00000000

 ^C
>
>
> The only change I see in that time frame that seems related
> is 7bd6680b47fa ("Revert "Revert "arm64: dma: Drop cache
> invalidation from arch_dma_prep_coherent()"""), so you could
> start by reverting that. However, it's probably something
> else since this is for the coherent mappings, not the
> streaming ones.
>
>        Arnd

--0000000000006a7aaf060685e48e
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
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA+/cccaZTi5yO5dLrSg3AWou5e5iSJ
z4dh+cvYZ/DxlzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzA5
MjkyMTEzMTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEANCqI9xqeTX2hpThcPB18Xq6t/3mPWLV4rIF8qg6w6P0qW6z3
NvhQt4LSjILPlySh3GrbE3S2lVTGhY4jpT8K8h+4/Nn3zaarPB2h+KjtzAV1FqCPH+i8opa11bee
2r0MOtZFKix9a1arbrdHsVCJW+NXIrWWHxeHj+cv8+i8V2aPThx0V5y8CbPi+mcTyiemZA7QkpmT
Ep924WjzEVFzIOH1zXjNu2AVhMGZjT6rRRN47hOFM9U6WE4Zyjcr1ycrFTHpyfG7WM54BVJcPDKK
HDRa/VmrLLaY8ewXZwH27sAX6o/Oa8kQxjgN80qj+snhg0MmiJCo2kZQ/phnrbOv6g==
--0000000000006a7aaf060685e48e--
